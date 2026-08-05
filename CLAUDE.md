# CLAUDE.md — Location Info Explorer

Đây là bộ nhớ dự án cho Claude Code. Đọc file này trước khi bắt đầu bất kỳ
task nào. Bản thiết kế đầy đủ nằm ở `SDD.md` cùng thư mục — đọc SDD trước
khi code phần liên quan.

## Bối cảnh dự án

App mobile Flutter cho phép tra cứu thông tin tổng hợp về 1 địa điểm bất kỳ
(toàn cầu), hiển thị qua UI dạng node-graph 2 tầng thay vì list truyền
thống.

**Kiến trúc: hoàn toàn client-side (đã đổi hướng 2026-08-04, xem bên dưới).**
Không có backend server. App gọi thẳng các provider từ Flutter — OpenStreetMap
(Nominatim + Overpass, **miễn phí, không cần API key**) cho Places/Geocoding,
OpenWeatherMap cho Weather, Tavily cho Search (tuỳ chọn), và 1 LLM provider
người dùng tự chọn — bằng API key người dùng tự nhập cho các provider cần
key (BYOK), cache bằng SQLite cục bộ trên máy (`sqflite`).

Đây là side project cá nhân — ưu tiên chi phí vận hành thấp (lý tưởng: $0,
vì không có server nào phải trả tiền vận hành), và chất lượng
production-ready dù là 1 người làm.

## Quyết định đã chốt

### 2026-08-05 (đợt 6) — Node hình tròn, bỏ nút demo, sửa bug Hotels không ra dữ liệu

Phản hồi tiếp theo từ thiết bị thật sau đợt 5 (screenshot node-graph +
"vẫn chưa thấy thông tin khách sạn"):

- **Node tier 2/3 (nhóm + mục con) đổi từ hình chữ nhật bo góc sang hình
  tròn** — khớp với `CenterNode` (vốn đã là hình tròn từ đầu). Sửa trong
  `RingNode` (`graph_node.dart`): `shape` đổi sang `CircleBorder`, thêm
  `clipBehavior: Clip.antiAlias` để nội dung (icon + label 2 dòng) không bị
  tràn ra ngoài viền tròn, `InkWell` dùng `customBorder: CircleBorder()`
  thay vì `borderRadius` để hiệu ứng ripple đúng hình tròn. Tăng
  `RingNode.size` từ 88 lên 96 để label 2 dòng vẫn đủ chỗ trong hình tròn
  (hình tròn "lãng phí" diện tích ở 4 góc hơn hình vuông bo góc).
- **Xóa nút "Try a demo (Da Lat)"** khỏi màn hình search — không còn cần
  thiết vì search thật đã hoạt động ổn định. Xóa luôn
  `LocationProvider.loadMock()` và file `lib/data/mock_location.dart` (chỉ
  được dùng bởi 2 nút demo đó, không còn chỗ nào khác dùng tới).
- **Bug: mục Hotels không hiện dữ liệu.** Nguyên nhân: Overpass
  (`overpass-api.de`) giới hạn số kết nối đồng thời từ 1 client (~2 request
  cùng lúc theo fair-use policy công khai của họ). Trước đợt 5 chỉ có 2 mục
  gọi Overpass song song trong 1 lần tải địa điểm (`places` + `airport`,
  qua `Future.wait` trong `orchestrator_service.dart`) — vừa đủ giới hạn.
  Thêm `hotels` thành mục Overpass thứ 3 khiến 1 trong 3 request bị
  từ chối/timeout ngẫu nhiên. **Sửa trong `places_service.dart`**: mọi
  request Overpass (`places`/`airport`/`hotels`/hospital snippet cho
  `health`) giờ chạy tuần tự qua 1 hàng đợi nội bộ (`_queue`, một
  `Future` được chain nối tiếp) thay vì để `Future.wait` bắn đồng thời —
  đánh đổi thêm 1 chút độ trễ khi tải lần đầu để không bao giờ vượt giới
  hạn concurrent-connection của Overpass, dù sau này có thêm mục Overpass
  nào nữa cũng an toàn. **Đây là lớp sửa lỗi quan trọng — đừng xóa hàng đợi
  này nếu thêm mục Overpass mới, chỉ cần gọi qua `_query()` như các mục
  hiện có.**

### 2026-08-05 (đợt 5) — Node-graph: quốc gia + giãn cách + 2 mục mới (Hotels, Signature photos)

Phản hồi từ ảnh chụp màn hình thiết bị thật (node-graph tier 1):

- **Vòng tròn trung tâm hiện tên quốc gia** (chữ nhỏ, dưới tên địa điểm —
  vd "Da Lat" / "Vietnam"). Lấy từ `address.country` của Nominatim (cùng
  request với tên địa điểm/tên bản địa ở đợt 4, không tốn thêm network
  call). Đi qua `LocationSearchCandidate.country` →
  `LocationInfo.country` → cột `country` mới trong bảng `locations`
  — **cần migration schema** (`AppDatabase` version 1→2). `CenterNode`
  giờ nhận thêm `sublabel`.
- **Giãn cách giữa các ô nhóm/mục và vòng tròn trung tâm** tăng lên (trong
  `node_graph_screen.dart`, công thức tính `radius`) — trước đó gần như
  chạm vào nhau, giờ có khoảng trống rõ ràng hơn.
- **2 mục con mới trong nhóm `explore`**: `hotels` (khách sạn gần đó, API
  Overpass `tourism=hotel/guest_house/hostel/apartment`, cùng pattern với
  `places`/`airport`, không cần key) và `photos` ("Signature photos" — mở
  link ảnh nổi bật của địa điểm trong trình duyệt ngoài, KHÔNG qua LLM,
  KHÔNG cần key, chỉ dựng URL Google Images từ tên địa điểm + quốc gia).
  `explore` giờ có 5 mục (từ 3).
  - `photos` là loại `source` MỚI: `'link'` — `ChildItem` có thêm field
    `linkUrl`, detail panel hiện nút "Open link" gọi `url_launcher` thay vì
    hiện summary/detail như bình thường. Cần thêm cột `link_url` vào bảng
    `cache_items` — **migration schema** (version 2→3).
  - `url_launcher` cần khai báo `<queries><intent>...ACTION_VIEW...https
    </intent></queries>` trong `AndroidManifest.xml` để mở được link trên
    Android 11+ (package visibility) — vì `android/` không commit vào repo,
    thêm bằng `sed` trong CI workflow, giống hệt cách vá `INTERNET`
    permission ở đợt 4. **Nếu sau này đổi CI workflow, đừng xoá step này.**
  - Chọn Google Images search (`google.com/search?tbm=isch&q=...`) làm
    nguồn ảnh vì phủ toàn cầu tốt hơn Unsplash cho các địa điểm nhỏ/ít
    tiếng — đổi provider ảnh dễ dàng (chỉ 1 URL template trong
    `photo_link_service.dart`), không phải quyết định khó đảo ngược.
  - `kChildLabels`/nhãn 2 mục mới vẫn là chuỗi tiếng Anh cố định, theo đúng
    quy ước hiện có (label nhóm/mục KHÔNG chạy qua `AppLocalizations`, chỉ
    nội dung LLM mới theo content language — xem comment trong
    `location_models.dart`).

### 2026-08-05 (đợt 4) — Sửa lỗi thiết bị thật + UX search/timezone/tên địa điểm + đa ngôn ngữ

Sau khi chủ dự án cài APK (đợt 3) lên điện thoại thật và test, phát hiện
hàng loạt lỗi thật + yêu cầu UX mới. Tất cả đã sửa/triển khai trong đợt này:

- **Lỗi gốc của MỌI lỗi mạng từ trước tới giờ**: `AndroidManifest.xml` do
  `flutter create` sinh ra (Flutter 3.44.8) **thiếu hẳn**
  `<uses-permission android:name="android.permission.INTERNET"/>`. Vì
  `android/` không commit vào repo (bị `.gitignore`, CI tự sinh lại mỗi lần
  build qua `flutter create`), permission này chưa từng có trong bất kỳ APK
  nào từng gửi cho chủ dự án — giải thích tại sao Nominatim/Weather/LLM đều
  lỗi "Failed host lookup" dù trình duyệt điện thoại vẫn vào mạng bình
  thường (browser là app khác, quyền khác). Sửa bằng cách thêm 1 step `sed`
  trong `.github/workflows/build-apk.yml` ngay sau step `flutter create`,
  chèn permission vào `AndroidManifest.xml` trước khi build. **Đây là fix
  quan trọng nhất trong đợt này — nếu sau này đổi CI workflow, đừng xoá
  step này.**
- **Bug cache "cần thêm API key" bị kẹt vĩnh viễn**: `CacheService.getItem()`
  áp TTL bình thường (14–90 ngày) luôn cho cả item có `source == 'missing_key'`
  — nghĩa là 1 mục đã xem trước khi thêm API key sẽ tiếp tục hiển thị "cần
  thêm API key" hàng tuần sau khi key đã lưu đúng, vì cache vẫn coi là
  "còn hạn". Sửa: `getItem()` giờ luôn coi `missing_key` là hết hạn, tự
  retry ở lần load tiếp theo (không tốn network call nếu vẫn chưa có key).
- **Timezone hiển thị giờ/ngày hiện tại**: `detail_panel.dart` thêm
  `_LiveLocalClock` — tính giờ địa phương từ offset (dùng lại
  `TimezoneService.estimateOffsetHours`) **tại thời điểm render**, KHÔNG
  bake vào text cache (vì mục timezone cache 90 ngày, bake giờ vào đó sẽ
  sai ngay lập tức). Tự cập nhật mỗi 30 giây khi panel còn mở.
- **Search gợi ý trực tiếp khi gõ**: `search_screen.dart` debounce 700ms
  sau khi ngừng gõ (không phải mỗi keystroke) để vẫn tôn trọng giới hạn
  ~1 request/giây của Nominatim, kèm sequence counter chống race condition
  (kết quả cũ trả về sau đè lên kết quả mới).
- **Tên địa điểm theo ngôn ngữ máy + tên bản địa**: `geocode_service.dart`
  giờ gọi Nominatim với `accept-language` (theo locale hiện tại của app) +
  `namedetails=1`. `LocationSearchCandidate.localName` lưu tên bản địa
  (native name) khi khác tên đã dịch — hiển thị dạng "Seoul (서울특별시)"
  trong search results + history list (widget dùng chung
  `widgets/common/candidate_title.dart`).
- **Mở rộng ~35 ngôn ngữ App/Content language**: thêm 33 file
  `lib/l10n/app_<code>.arb` (trước chỉ có `en`, `vi`). Ngôn ngữ nào chưa
  dịch đủ tự động fallback về tiếng Anh theo từng chuỗi — đây là hành vi
  sẵn có của Flutter gen-l10n (class `AppLocalizations<Code>` kế thừa class
  tiếng Anh, chỉ override key nào có trong ARB), **không cần code thêm gì**
  để có fallback, chỉ cần thêm file ARB. Đã dịch đầy đủ cả 35/35 ngôn ngữ
  trong đợt này (không có ngôn ngữ nào chỉ có fallback rỗng). Chú ý:
  `zh_Hant` (Trung phồn thể) dùng script code, không phải country code —
  `Locale('zh_Hant')` thường KHÔNG parse đúng, phải dùng
  `Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')`. Xem helper
  `lib/l10n/locale_codes.dart` (`localeFromCode`/`localeToCode`) — dùng
  helper này ở MỌI chỗ chuyển đổi giữa mã locale dạng string (lưu trong
  SharedPreferences, dùng làm key dropdown) và `Locale` object, đừng gọi
  `Locale(code)` trực tiếp nữa.

### 2026-08-04 (đợt 3) — Đổi Places/Geocoding sang OpenStreetMap, bỏ Google

Chủ dự án hỏi có cách nào miễn phí hơn cho Places/Geocoding không, không
nhất thiết phải dùng Google (Google Places/Geocoding yêu cầu gắn thẻ thanh
toán dù có $200/tháng miễn phí). Đã đổi sang **OpenStreetMap**:

- **Geocoding/search**: Nominatim (`nominatim.openstreetmap.org`) — miễn
  phí, KHÔNG cần API key. Chỉ cần header `User-Agent` định danh app và giới
  hạn ~1 request/giây — từ đợt 4, search gợi ý trực tiếp khi gõ (debounce
  700ms, xem đợt 4), không còn "chỉ gọi khi bấm search" như mô tả ban đầu ở
  đây. Xem `mobile/lib/services/geocode_service.dart`.
- **Nearby places / airport / hospital**: Overpass API
  (`overpass-api.de/api/interpreter`) — miễn phí, KHÔNG cần API key. Dùng
  Overpass QL query theo bán kính (`around:RADIUS,LAT,LNG`), rồi tự sort
  theo khoảng cách (Haversine) trong Dart vì Overpass không tự sort. Xem
  `mobile/lib/services/places_service.dart`.
- **Đánh đổi chấp nhận được**: đây là instance công cộng dùng chung, có thể
  chậm hoặc quá tải hơn Google trong giờ cao điểm, và dữ liệu OSM đôi khi ít
  đầy đủ hơn ở thị trấn nhỏ — bù lại không cần thẻ thanh toán, không giới
  hạn quota trả phí, đúng tinh thần "chi phí vận hành $0" của dự án.
- **`RequestSettings.placesApiKey` đã bị xoá hoàn toàn** — không còn field
  này nữa (không phải optional, mà KHÔNG TỒN TẠI, vì Places/Geocoding không
  bao giờ cần key). Đừng thêm lại field này trừ khi đổi provider lần nữa.
- Setting "API Keys" trong app giờ chỉ còn Weather (OpenWeatherMap) + Search
  (Tavily) — Places không còn xuất hiện ở màn hình đó, thay bằng 1 ghi chú
  giải thích ngắn.

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
  key BYOK còn lại (LLM, Weather, Search), không dùng cho gì khác.
- **Places/Geocoding**: OpenStreetMap (Nominatim + Overpass API) — miễn phí,
  KHÔNG cần API key (đã chốt đợt 3, đổi từ Google). Đừng đổi lại Google
  hoặc thêm key requirement cho mục này mà không hỏi lại.
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
        api_keys_settings_screen.dart   # key Weather, Search (Tavily) — Places/Geocoding không cần key
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
      geocode_service.dart           # OpenStreetMap Nominatim, gọi thẳng, KHÔNG cần key
      places_service.dart              # OpenStreetMap Overpass (nearby/airport/hotels/hospital), KHÔNG cần key
      weather_service.dart               # OpenWeatherMap, gọi thẳng (BYOK)
      web_search_service.dart              # Tavily, gọi thẳng (BYOK, tuỳ chọn)
      llm_service.dart                       # Port của backend/app/services/llm.py — prompt + provider routing
      timezone_service.dart                    # offline, tính gần đúng từ kinh độ
      emergency_service.dart                     # tra bảng tĩnh, bundle JSON asset
      photo_link_service.dart                      # dựng URL Google Images từ tên+quốc gia, KHÔNG key, KHÔNG LLM
      orchestrator_service.dart                    # Dart port của backend/app/services/orchestrator.py
      secure_storage.dart                            # API key BYOK còn lại (LLM + Weather + Search)
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

4. **Mọi provider cần key đều là BYOK, không có rate limit của app.** Không
   còn `device_id`/free-tier — LLM/Weather/Search chỉ hoạt động khi người
   dùng tự nhập key tương ứng trong Settings; Places/Geocoding (OpenStreetMap)
   không cần key nên luôn hoạt động. Thiếu key nào thì các mục phụ thuộc key
   đó hiển thị trạng thái "cần thêm API key" thay vì lỗi khó hiểu.

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
      thẳng Places/Weather/Search/LLM, port toàn bộ logic cache TTL +
      prompt building + orchestration từ backend Python sang Dart.
- [x] Mobile: đổi Places/Geocoding từ Google sang OpenStreetMap (Nominatim +
      Overpass) — miễn phí, không cần key (đợt 3).
- [x] Settings: API Keys (Weather/Search), LLM (provider + key, không còn
      free tier), Privacy (cache local, không còn "backend server URL").
- [x] Cài Flutter SDK (3.44.8 stable) trong môi trường build, chạy
      `flutter create .`, `flutter analyze` (0 issues), `flutter test`,
      `flutter build linux`/`flutter build web`/`flutter build apk` (qua
      GitHub Actions CI, môi trường build sandbox không có Android SDK khả
      dụng — xem `.github/workflows/build-apk.yml`).
- [x] Sửa lỗi thiết bị thật: thiếu `INTERNET` permission trong
      `AndroidManifest.xml` (nguyên nhân gốc mọi lỗi mạng từ trước tới giờ),
      cache "cần thêm API key" bị kẹt vĩnh viễn — cả 2 xác nhận qua test
      trên điện thoại thật của chủ dự án (đợt 4).
- [x] Timezone hiển thị giờ/ngày hiện tại (live, không cache), search gợi ý
      trực tiếp khi gõ (debounce), tên địa điểm theo ngôn ngữ máy + tên bản
      địa (đợt 4).
- [x] Mở rộng App/Content language lên ~35 ngôn ngữ phổ biến, dịch đầy đủ
      cả 35 (đợt 4) — ngôn ngữ thêm sau này chỉ cần 1 file ARB, tự fallback
      tiếng Anh cho key chưa dịch.
- [ ] Test trên thiết bị thật với API key thật cho toàn bộ pipeline
      (OpenWeatherMap, Tavily, 1 provider LLM, và giờ cả các ngôn ngữ mới) —
      môi trường build chưa có key nào để test end-to-end, và chỉ có phản
      hồi thực tế từ chủ dự án cho tiếng Việt + tiếng Anh tính đến nay.
      Nominatim/Overpass đã xác nhận code đúng nhưng không test sống được từ
      sandbox build (network policy của sandbox chặn cả 2 host này, không
      liên quan tới điện thoại thật của user).
- [ ] Build/test iOS — môi trường build không có Xcode.
- [ ] Mở rộng bảng số khẩn cấp ngoài ~40 quốc gia hiện có.

## Việc KHÔNG được tự quyết định (còn lại)

- Đổi web search provider khỏi Tavily mà không hỏi lại.
- Thêm bất kỳ managed/paid service nào (vd: quay lại có backend, hoặc thêm
  1 API trả phí khác) mà không hỏi lại — kiến trúc client-only + BYOK đã
  chốt ở đợt 2, đừng tự ý quay lại backend.
- Thiết kế lại UI Search/History thành phiên bản "đầy đủ" (đã triển khai bản
  tối giản; nếu muốn nâng cấp UI, xác nhận hướng thiết kế trước).
