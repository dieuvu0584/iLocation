import pytest

from app.services import llm


def test_extract_json_from_clean_response():
    parsed = llm._extract_json('{"summary": "a", "detail": "b"}')
    assert parsed == {"summary": "a", "detail": "b"}


def test_extract_json_strips_surrounding_text():
    raw = 'Sure, here is the JSON:\n```json\n{"summary": "a", "detail": "b"}\n```'
    parsed = llm._extract_json(raw)
    assert parsed == {"summary": "a", "detail": "b"}


def test_extract_json_raises_on_no_json():
    with pytest.raises(llm.LLMError):
        llm._extract_json("no json here")


def test_risk_disclaimer_items_have_no_ttl_conflict():
    # visa/insurance must always carry a disclaimer regardless of LLM output.
    assert "visa" in llm.RISK_DISCLAIMER_ITEMS
    assert "insurance" in llm.RISK_DISCLAIMER_ITEMS


def test_search_query_templates_cover_all_llm_items():
    from app.models.location import LLM_ITEM_IDS

    assert set(llm.SEARCH_QUERY_TEMPLATES.keys()) == LLM_ITEM_IDS
