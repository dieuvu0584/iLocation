# CLAUDE.md — Location Info Explorer

Đây là bộ nhớ dự án cho Claude Code. Đọc file này trước khi bắt đầu bất kỳ
task nào. Bản thiết kế đầy đủ nằm ở `SDD.md` cùng thư mục — đọc SDD trước
khi code phần liên quan.

## Bối cảnh dự án

App mobile Flutter cho phép tra cứu thông tin tổng hợp về 1 địa điểm bất kỳ
(toàn cầu), hiển thị qua UI dạng node-graph 2 tầng thay vì list truyền
thống. Backend FastAPI tổng hợp dữ liệu từ API structured (Places, Weather)
và LLM (cho các mục dạng text tự do), có cache để giảm chi phí.

Đây là side project cá nhân — ưu tiên chi phí vận hành thấp, tự host, và
chất lượng production-ready dù là 1 người làm.

## Quyết định đã chốt (2026-08-04)

Lần triển khai đầu tiên (backend + mobile) đã xác nhận các điểm sau — vốn
trước đó được đánh dấu "chưa chốt" trong SDD:

1. **Web search provider: Tavily.** Chọn vì free tier hào phóng, tối ưu cho
   use case LLM/RAG. Implement ở `backend/app/services/search.py`.
2. **UI Search/History: đơn giản, chức năng.** Không phải thiết kế đầy đủ
   như node-graph — text search + list gần đây, theo đúng theme màu/font
   chung. Xem `mobile/lib/screens/search/` và `mobile/lib/screens/history/`.
3. **Timezone**: tính offline từ toạ độ bằng `timezonefinder` (Python),
   KHÔNG gọi API ngoài, KHÔNG qua LLM — khớp với ghi chú SDD §4
   "API/tĩnh theo toạ độ" mà lần đọc đầu tiên đã bỏ sót khi phân loại item.
4. **BYOK routing: qua backend**, không gọi LLM trực tiếp từ Flutter client
   (đây là 1 trong 2 hướng SDD/CLAUDE.md để ngỏ). Lý do: giữ prompt-building,
   enforce JSON schema, và localization tập trung 1 chỗ thay vì lặp lại ở
   Dart. Key BYOK chỉ tồn tại trong bộ nhớ của 1 request, không bao giờ ghi
   xuống DB/log — xem docstring `backend/app/services/llm.py`.
5. **Icon set: Material Icons**, không phải `lucide_icons`/`flutter_lucide`
   như SDD gợi ý — môi trường build đầu tiên không có Flutter SDK để xác
   minh version package nào thực sự resolve được trên pub.dev, nên dùng bộ
   icon có sẵn của Flutter qua bảng ánh xạ tập trung
   (`mobile/lib/widgets/node_graph/graph_icons.dart`) để không chặn tiến độ.
   Đổi sang lucide sau nếu muốn khớp mockup hơn — chỉ cần sửa 1 file.

## Tech stack (bắt buộc tuân theo, không tự ý đổi)

- **Mobile**: Flutter (Dart)
- **Backend**: Python 3.11+ / FastAPI
- **DB/cache**: SQLite
- **Secure storage client**: `flutter_secure_storage` (chỉ dùng cho API
  key BYOK, không dùng cho gì khác)
- **LLM mặc định**: Google Gemini Flash (free tier)
- **Web search**: Tavily (xem "Quyết định đã chốt" ở trên)
- **Hạ tầng**: self-hosted, Docker — không dùng managed service trả phí
  trừ khi thực sự cần thiết (đúng pattern các dự án khác của chủ dự án)

## Cấu trúc thư mục (thực tế, đã triển khai)

```
/backend
  /app
    /api/routes      # location.py (search/resolve/refresh), meta.py (usage/cache)
    /services
      places.py       # Google Places integration
      weather.py       # Weather API integration
      geocode.py        # free-text query -> candidates
      timezone.py        # coordinate -> IANA timezone, offline (timezonefinder)
      emergency.py        # static per-country lookup table
      search.py             # Tavily web search
      llm.py                 # LLM aggregator: prompt building, provider routing, fallback
      rate_limit.py            # per-device free-tier daily limit
      cache.py                  # SQLite cache read/write, per-item TTL
      orchestrator.py            # ties everything together per SDD §3 pipeline
    /models            # Pydantic schemas — bám sát JSON schema ở SDD mục 4
    /db                 # schema.sql + sqlite3 connection helper
    config.py             # env vars, provider keys mặc định của app
  /tests                    # pytest — cache TTL, rate limit, emergency, routes, llm parsing
  /data
    emergency_numbers.json     # bảng tĩnh, KHÔNG qua LLM
  Dockerfile
  docker-compose.yml

/mobile
  /lib
    /screens
      graph/               # Node-graph 2-tier (node_graph_screen.dart, detail_panel.dart)
      settings/
        language_settings_screen.dart
        llm_settings_screen.dart
        privacy_settings_screen.dart
        settings_home_screen.dart
      search/               # search_screen.dart — đơn giản, chức năng (xem "Quyết định đã chốt")
      history/                # history_screen.dart — tương tự
    /widgets
      node_graph/            # ring_layout, graph_node, connector_painter, graph_icons
      common/                  # settings_scaffold.dart
    /services
      api_client.dart
      secure_storage.dart       # CHỈ dùng cho BYOK key
      settings_service.dart       # SharedPreferences — mọi setting không nhạy cảm
      history_service.dart
    /state
      app_settings.dart            # ChangeNotifier bọc SettingsService + SecureStorageService
      location_provider.dart         # ChangeNotifier điều khiển fetch/refresh location
    /l10n                              # ARB files (app_en.arb, app_vi.arb) + generated/ (xem README)
    /theme
      colors.dart                       # bám theo palette ở SDD mục 9, KHÔNG tự đổi màu
      typography.dart                     # Fraunces (display) + Inter (body), qua google_fonts
    /data
      mock_location.dart                    # fixture cho demo/offline, khớp schema backend
```

## Nguyên tắc thiết kế cần giữ khi code

1. **Không phải mọi mục thông tin đều gọi LLM.** Tổng cộng có 21 mục con.
   3 mục (Places, Weather, Airport) lấy từ API structured; 2 mục (Timezone,
   Emergency) tính/tra cứu offline không qua LLM. Chỉ 16/21 mục còn lại mới
   qua LLM (`app.models.location.LLM_ITEM_IDS`). Xem bảng đầy đủ ở SDD mục
   4 — đừng gộp chung logic.

2. **Số khẩn cấp và visa là dữ liệu rủi ro cao.** Emergency dùng bảng tra
   cứu tĩnh (`backend/data/emergency_numbers.json`), không qua LLM. Visa
   qua LLM nhưng LUÔN kèm disclaimer "kiểm tra nguồn chính thức"
   (`llm.RISK_DISCLAIMER_ITEMS`).

3. **Cache-first.** Mọi request phải check cache theo `location_id` trước
   khi gọi Places/Weather/search/LLM. TTL khác nhau theo loại dữ liệu (SDD
   mục 5, `cache.TTL_BY_ITEM`) — không dùng 1 TTL chung cho tất cả.

4. **Free-tier LLM có rate limit theo thiết bị.** `rate_limit.py` track
   usage theo `device_id` (không cần tài khoản) để áp giới hạn — tránh 1
   user dùng hết quota Gemini Flash miễn phí của cả app.

5. **BYOK key không bao giờ chạm vào backend DB/log/analytics.** Key chỉ
   sống trong 1 request (`LLMRequestSettings.byok_api_key`), dùng để gọi
   thẳng provider, không bao giờ được `cache.put_item`-ed hay ghi log. Xem
   "Quyết định đã chốt" #4 ở trên cho lý do vẫn route qua backend thay vì
   gọi thẳng từ client.

6. **Animation ambient trong node-graph phải tôn trọng
   `prefers-reduced-motion`** (`MediaQuery.disableAnimations` trong Flutter)
   VÀ setting "giảm chuyển động" trong app
   (`AppSettings.reducedMotion`). Không hardcode animation luôn bật — xem
   `node_graph_screen.dart._reducedMotion()`.

7. **Ngôn ngữ UI và ngôn ngữ nội dung LLM là 2 setting riêng.** Đừng gộp
   chung — `AppSettings.uiLocale` vs `AppSettings.contentLanguage`, xem SDD
   mục 7.1.

## Palette & typography (không tự đổi, đã chốt qua nhiều vòng thiết kế)

```dart
// mobile/lib/theme/colors.dart
const bgDark = Color(0xFF0A141D);
const bgMid = Color(0xFF16283A);
const accentAmber = Color(0xFFE8A33D);
const accentAmberDark = Color(0xFFC97C2E);
const cardBg1 = Color(0xFF1B2E3D);
const cardBg2 = Color(0xFF142330);
const textPrimary = Color(0xFFEDEAE3);
const textSecondary = Color(0xFF7FA8C9);
const textMuted = Color(0xFF9FB6C6);
const borderColor = Color(0xFF2A4356);
```

- Display font: **Fraunces** (serif, dùng cho heading/node label chính)
- Body font: **Inter** (sans, dùng cho mọi text khác)

## Trạng thái hiện tại / việc cần làm tiếp

- [x] Backend: cache layer + Places/Weather/Timezone/Emergency integration.
- [x] Backend: LLM aggregator (Gemini free-tier + BYOK Gemini/Groq/OpenRouter/OpenAI, fallback).
- [x] Backend: pytest suite (26 tests, chạy qua `cd backend && pytest`).
- [x] Mobile: node-graph widget (tier 1 + tier 2 + detail panel), mock data.
- [x] Mobile: settings LLM/Language/Privacy.
- [x] Mobile ↔ backend nối thật qua `ApiClient` (chưa test trên thiết bị/emulator thật).
- [x] Settings ngôn ngữ/đơn vị + `flutter_localizations` setup (ARB + hand-authored generated classes, xem `mobile/README.md`).
- [x] Search/History UI — đã xác nhận với chủ dự án, triển khai bản đơn giản.
- [ ] Điền API keys thật (Google Places/Geocoding, OpenWeatherMap, Tavily, Gemini) và test end-to-end.
- [ ] `flutter create .` trong `mobile/` để sinh platform folders (môi trường build không có Flutter SDK).
- [ ] Test trên thiết bị/emulator thật — chưa từng chạy `flutter run` trong môi trường này.
- [ ] Mở rộng bảng số khẩn cấp ngoài ~40 quốc gia hiện có.

## Việc KHÔNG được tự quyết định (còn lại)

- Đổi model LLM mặc định khỏi Gemini Flash mà không hỏi lại.
- Đổi web search provider khỏi Tavily mà không hỏi lại (đã chốt 2026-08-04).
- Thêm bất kỳ managed service trả phí nào vào kiến trúc mà không hỏi lại.
- Thiết kế lại UI Search/History thành phiên bản "đầy đủ" (đã triển khai bản
  tối giản; nếu muốn nâng cấp UI, xác nhận hướng thiết kế trước).
