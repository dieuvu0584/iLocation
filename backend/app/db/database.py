"""SQLite connection helper.

A single shared connection (not thread-local): FastAPI's TestClient and
uvicorn's async workers can hand requests to a different OS thread than the
one that created the app, so a thread-local connection would silently open a
second, un-migrated database file. WAL mode + `check_same_thread=False`
makes one shared connection safe for this app's access pattern (short
read/write transactions, no long-lived cursors held across awaits).
"""
from __future__ import annotations

import sqlite3
import threading
from pathlib import Path

from app.config import get_settings

_lock = threading.Lock()
_conn: sqlite3.Connection | None = None


def _schema_path() -> Path:
    return Path(__file__).resolve().parent / "schema.sql"


def get_connection() -> sqlite3.Connection:
    global _conn
    if _conn is None:
        with _lock:
            if _conn is None:
                settings = get_settings()
                Path(settings.sqlite_path).parent.mkdir(parents=True, exist_ok=True)
                conn = sqlite3.connect(settings.sqlite_path, check_same_thread=False)
                conn.row_factory = sqlite3.Row
                conn.execute("PRAGMA journal_mode=WAL")
                conn.execute("PRAGMA foreign_keys=ON")
                conn.executescript(_schema_path().read_text())
                conn.commit()
                _conn = conn
    return _conn


def reset_for_tests(db_path: str) -> sqlite3.Connection:
    """Force a fresh connection pointed at a temp DB — used by the test suite only."""
    global _conn
    with _lock:
        if _conn is not None:
            _conn.close()
        conn = sqlite3.connect(db_path, check_same_thread=False)
        conn.row_factory = sqlite3.Row
        conn.executescript(_schema_path().read_text())
        conn.commit()
        _conn = conn
    return _conn
