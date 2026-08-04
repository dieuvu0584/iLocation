from app.services import timezone as timezone_service


def test_known_coordinates_resolve_timezone():
    item = timezone_service.get_timezone_item(11.94, 108.46)
    assert item.source == "static"
    assert "Asia/Ho_Chi_Minh" in item.summary


def test_ocean_coordinates_return_unknown_gracefully():
    item = timezone_service.get_timezone_item(0.0, -160.0)
    assert item.source == "static"
    assert item.summary
