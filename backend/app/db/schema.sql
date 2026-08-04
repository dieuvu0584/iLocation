CREATE TABLE IF NOT EXISTS locations (
    location_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    lat REAL NOT NULL,
    lng REAL NOT NULL,
    country_code TEXT,
    created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS cache_items (
    location_id TEXT NOT NULL,
    item_id TEXT NOT NULL,
    group_id TEXT NOT NULL,
    label TEXT NOT NULL,
    source TEXT NOT NULL,
    summary TEXT NOT NULL,
    detail TEXT NOT NULL DEFAULT '',
    sources_json TEXT NOT NULL DEFAULT '[]',
    warning TEXT,
    updated_at TEXT NOT NULL,
    expires_at TEXT,
    PRIMARY KEY (location_id, item_id),
    FOREIGN KEY (location_id) REFERENCES locations (location_id)
);

CREATE TABLE IF NOT EXISTS device_llm_usage (
    device_id TEXT NOT NULL,
    usage_date TEXT NOT NULL,
    count INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (device_id, usage_date)
);

CREATE TABLE IF NOT EXISTS app_llm_usage (
    usage_date TEXT PRIMARY KEY,
    count INTEGER NOT NULL DEFAULT 0
);
