# CLAUDE.md — Location Info Explorer

Đây là bộ nhớ dự án cho Claude Code. Đọc file này trước khi bắt đầu bất kỳ
task nào. Bản thiết kế đầy đủ nằm ở `SDD.md` cùng thư mục — đọc SDD trước
khi code phần liên quan.

## Bối cảnh dự án

App mobile Flutter cho phép tra cứu thông tin tổng hợp về 1 địa điểm bất kỳ
(toàn cầu), hiển thị qua UI dạng node-graph 2 tầng thay vì list truyền
thống.

**Kiến trúc: hoàn toàn client-side (đã đổi hướng 2026-08-04, xem bên dưới).**
Không có backend server. App gọi thẳng các provider (Google Places/
Geocoding, OpenWeatherMap, Tavily, LLM) từ Flutter bằng API key người dùng
tự nhập (BYOK), cache bằng SQLite cục bộ trên máy (`sqflite`).

Đây là side project cá nhân — ưu tiên chi phí vận hành thấp (lý tưởng: $0,
vì không có server nào phải trả tiền vận hành), và chất lượng
production-ready dù là 1 người làm.

## Quyết định đã chốt

### 2026-08-04 (đợt 2) — Bỏ backend, chuyển hẳn sang client-side

Sau khi build xong bản backend+mobile đầu tiên (xem đợt 1 bên dưới) và thử
trên điện thoại thật, chủ dự án quyết định **bỏ hẳn backend FastAPI**, đổi
sang kiến trúc client-only:

- **Lý do**: đơn giản hoá vận hành — không cần tự host/deploy 1 server nào
  cả, không cần lo server offline/mất kết nối giữa điện thoại và backend
  (vấn đề gặp phải khi test trên máy thật: `10.0.2.2` chỉ hoạt động trên
  Android emulator, không phải máy thật, và chạy backend trên máy tính cá
  nhân đòi hỏi cùng mạng WiFi + mở `--host 0.0.0.0` — bất tiện cho việc
  dùng hàng ngày).
- **Điều này ĐẢO NGƯỢC quyết định "BYOK routing: qua backend" ở đợt 1** —
  giờ LLM (và cả Places/Weather/Search) gọi thẳng từ Dart, không qua
  backend nữa. Lý do ban đầu (tập trung prompt-building/JSON
  schema/localization ở 1 chỗ) vẫn đúng về mặt kỹ trong lý thuyết, nhưng
  chủ dự án ưu tiên "không cần vận hành server" hơn.
- **Không còn khái niệm "free tier" (Gemini key của app).** Không có
  backend nghĩa là không có nơi giữ app-owned key an toàn + rate-limit
  theo thiết bị. Mọi provider (LLM, Places, Weather, Search) đều là BYOK —
  người dùng tự nhập key trong Settings, lưu ở `flutter_secure_storage`.
- **Timezone**: không dùng `timezonefinder` (Python-only) nữa. Tính gần
  đúng từ kinh độ (`round(lng / 15)` giờ UTC offset), hoàn toàn offline,
  không cần key, không có tên IANA chính xác (không tính DST) — đánh đổi
  chấp nhận được cho 1 app client-only, có ghi chú rõ trong UI.
- **`backend/` vẫn còn trong repo nhưng KHÔNG được app dùng nữa.** Giữ lại
  vì code còn chạy được, có test, và có thể hữu ích sau này nếu đổi hướng
  lần nữa (vd: muốn cache dùng chung nhiều thiết bị) — nhưng đừng động vào
  nó khi sửa mobile app, và đừng giả định app gọi nó.
- **`local db on phone`**: cache location theo `location_id` dùng `sqflite`
  (SQLite trên thiết bị), schema tương đương `backend/app/db/schema.sql`
  nhưng port sang Dart — xem `mobile/lib/db/app_database.dart` và
  `mobile/lib/services/cache_service.dart`.

### 2026-08-04 (đợt 1) — các quyết định của lần triển khai đầu tiên

Một số điểm dưới đây (đặc biệt #4) đã bị đảo ngược ở đợt 2 phía trên — giữ
lại để biết lý do ban đầu, đừng làm theo #4 nữa:

1. **Web search provider: Tavily.** Chọn vì free tier hào phóng, tối ưu cho
   use case LLM/RAG. Giờ gọi thẳng từ `mobile/lib/services/web_search_service.dart`
   (BYOK), không qua backend nữa.
2. **UI Search/History: đơn giản, chức năng.** Không phải thiết kế đầy đủ
   như node-graph — text search + list gần đây, theo đúng theme màu/font
   chung. Xem `mobile/lib/screens/search/` và `mobile/lib/screens/history/`.
3. **Timezone**: ban đầu tính bằng `timezonefinder` (Python) ở backend —
   đợt 2 đổi sang tính gần đúng từ kinh độ ngay trong Dart, xem trên.
4. ~~**BYOK routing: qua backend**~~ — ĐÃ ĐẢO NGƯỢC ở đợt 2, xem trên. Gọi
   thẳng từ Flutter client giờ là hướng chính thức.
5. **Icon set: Material Icons**, không phải `lucide_icons`/`flutter_lucide`
   như SDD gợi ý — môi trường build đầu tiên không có Flutter SDK để xác
   minh version package nào thực sự resolve được trên pub.dev, nên dùng bộ
   icon có sẵn của Flutter qua bảng ánh xạ tập trung
   (`mobile/lib/widgets/node_graph/graph_icons.dart`) để không chặn tiến độ.
   Đổi sang lucide sau nếu muốn khớp mockup hơn — chỉ cần sửa 1 file.

## Tech stack (bắt buộc tuân theo, không tự ý đổi)

- **Mobile**: Flutter (Dart) — **đây là toàn bộ app, không có backend**.
- **DB/cache trên thiết bị**: `sqflite` (SQLite local, không phải server).
- **Secure storage client**: `flutter_secure_storage` — dùng cho MỌI API
  key BYOK (LLM, Places/Geocoding, Weather, Search), không dùng cho gì khác.
- **LLM**: người dùng tự chọn provider (Gemini / Groq / OpenRouter /
  OpenAI) + tự nhập key — không có provider/key mặc định của app.
- **Web search**: Tavily, BYOK, tuỳ chọn (không bắt buộc — thiếu key thì
  bỏ qua bước search, LLM trả lời bằng kiến thức sẵn có và nói rõ không có
  nguồn).
- **`backend/` (Python/FastAPI)**: còn trong repo, có test, nhưng KHÔNG
  được mobile app dùng — xem quyết định đợt 2 ở trên.

## Cấu trúc thư mục (thực tế, đã triển khai)

```
/backend            # Còn trong repo nhưng app KHÔNG gọi tới nữa (xem quyết định đợt 2)
  ... (giữ nguyên, xem code — không cần đọc để sửa mobile app)

/mobile
  /lib
    /screens
      graph/               # Node-graph 2-tier (node_graph_screen.dart, detail_panel.dart)
      settings/
        language_settings_screen.dart
        llm_settings_screen.dart      # provider + key LLM, detail level, show sources
        api_keys_settings_screen.dart   # key Places/Geocoding, Weather, Search (Tavily)
        privacy_settings_screen.dart
        settings_home_screen.dart
      search/               # search_screen.dart — đơn giản, chức năng
      history/                # history_screen.dart — tương tự
    /widgets
      node_graph/            # ring_layout, graph_node, connector_painter, graph_icons
      common/                  # settings_scaffold.dart
    /db
      app_database.dart          # sqflite: mở DB, tạo bảng locations/cache_items
    /services
      cache_service.dart           # Dart port của backend/app/services/cache.py — TTL theo item
      geocode_service.dart           # Google Geocoding, gọi thẳng (BYOK)
      places_service.dart              # Google Places (nearby/airport/hospital), gọi thẳng (BYOK)
      weather_service.dart               # OpenWeatherMap, gọi thẳng (BYOK)
      web_search_service.dart              # Tavily, gọi thẳng (BYOK, tuỳ chọn)
      llm_service.dart                       # Port của backend/app/services/llm.py — prompt + provider routing
      timezone_service.dart                    # offline, tính gần đúng từ kinh độ
      emergency_service.dart                     # tra bảng tĩnh, bundle JSON asset
      orchestrator_service.dart                    # Dart port của backend/app/services/orchestrator.py
      secure_storage.dart                            # MỌI API key BYOK (LLM + Places + Weather + Search)
      settings_service.dart                            # SharedPreferences — setting không nhạy cảm
      history_service.dart
    /state
      app_settings.dart            # ChangeNotifier bọc SettingsService + SecureStorageService
      location_provider.dart         # ChangeNotifier gọi orchestrator_service.dart trực tiếp (không qua HTTP)
    /l10n                              # ARB files (app_en.arb, app_vi.arb) + generated/ (xem README)
    /theme
      colors.dart                       # bám theo palette ở SDD mục 9, KHÔNG tự đổi màu
      typography.dart                     # Fraunces (display) + Inter (body), qua google_fonts
    /data
      mock_location.dart                    # fixture cho demo, khớp schema ChildItem/Group/LocationResponse
    /assets
      emergency_numbers.json                  # copy từ backend/data/, bundle vào app
```

## Nguyên tắc thiết kế cần giữ khi code

1. **Không phải mọi mục thông tin đều gọi LLM.** Tổng cộng có 21 mục con.
   3 mục (Places, Weather, Airport) gọi API structured trực tiếp; 2 mục
   (Timezone, Emergency) tính/tra cứu offline không qua LLM, không cần key.
   Chỉ 16/21 mục còn lại mới qua LLM. Đừng gộp chung logic.

2. **Số khẩn cấp và visa là dữ liệu rủi ro cao.** Emergency dùng bảng tra
   cứu tĩnh (`mobile/assets/emergency_numbers.json`), không qua LLM, không
   cần mạng. Visa qua LLM nhưng LUÔN kèm disclaimer "kiểm tra nguồn chính
   thức".

3. **Cache-first, cache cục bộ trên máy.** Mọi lần xem 1 địa điểm phải
   check `sqflite` cache theo `location_id` trước khi gọi Places/Weather/
   search/LLM. TTL khác nhau theo loại dữ liệu (`cache_service.dart`
   `ttlByItem`) — không dùng 1 TTL chung cho tất cả.

4. **Mọi provider đều là BYOK, không có rate limit của app.** Không còn
   `device_id`/free-tier — mỗi provider (LLM, Places, Weather, Search) chỉ
   hoạt động khi người dùng tự nhập key tương ứng trong Settings. Thiếu key
   nào thì các mục phụ thuộc key đó hiển thị trạng thái "cần thêm API key"
   thay vì lỗi khó hiểu.

5. **API key KHÔNG BAO GIỜ rời khỏi thiết bị ngoài lúc gọi thẳng provider.**
   Lưu ở `flutter_secure_storage`, không log, không gửi đi đâu khác ngoài
   request tới đúng provider đó.

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

- [x] Backend (Python/FastAPI) — đầy đủ chức năng, có test, nhưng KHÔNG
      còn được mobile app dùng (xem quyết định đợt 2).
- [x] Mobile: node-graph widget (tier 1 + tier 2 + detail panel), mock data.
- [x] Mobile: chuyển sang kiến trúc client-only — cache `sqflite`, gọi
      thẳng Places/Weather/Search/LLM bằng BYOK key, port toàn bộ logic
      cache TTL + prompt building + orchestration từ backend Python sang
      Dart.
- [x] Settings: API Keys (Places/Weather/Search), LLM (provider + key,
      không còn free tier), Privacy (cache local, không còn "backend server
      URL").
- [x] Cài Flutter SDK (3.44.8 stable) trong môi trường build, chạy
      `flutter create .`, `flutter analyze` (0 issues), `flutter test`,
      `flutter build linux`/`flutter build web`/`flutter build apk` (qua
      GitHub Actions CI, môi trường build sandbox không có Android SDK khả
      dụng — xem `.github/workflows/build-apk.yml`).
- [ ] Test trên thiết bị thật với API key thật (Google Places/Geocoding,
      OpenWeatherMap, Tavily, và 1 provider LLM) — môi trường build chưa có
      key nào để test end-to-end.
- [ ] Build/test iOS — môi trường build không có Xcode.
- [ ] Mở rộng bảng số khẩn cấp ngoài ~40 quốc gia hiện có.

## Việc KHÔNG được tự quyết định (còn lại)

- Đổi web search provider khỏi Tavily mà không hỏi lại.
- Thêm bất kỳ managed/paid service nào (vd: quay lại có backend, hoặc thêm
  1 API trả phí khác) mà không hỏi lại — kiến trúc client-only + BYOK đã
  chốt ở đợt 2, đừng tự ý quay lại backend.
- Thiết kế lại UI Search/History thành phiên bản "đầy đủ" (đã triển khai bản
  tối giản; nếu muốn nâng cấp UI, xác nhận hướng thiết kế trước).
