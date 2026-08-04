from app.services import emergency


def test_known_country_has_no_warning():
    item = emergency.get_emergency_item("VN")
    assert "113" in item.detail or "115" in item.detail
    assert item.source == "static"
    assert item.warning is None


def test_unknown_country_falls_back_with_warning():
    item = emergency.get_emergency_item("ZZ")
    assert item.source == "static"
    assert item.warning is not None
    assert "112" in item.summary


def test_missing_country_code_falls_back():
    item = emergency.get_emergency_item(None)
    assert item.warning is not None


def test_lookup_is_case_insensitive():
    lower = emergency.get_emergency_item("vn")
    upper = emergency.get_emergency_item("VN")
    assert lower.summary == upper.summary
