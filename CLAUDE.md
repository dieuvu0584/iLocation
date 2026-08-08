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

### 2026-08-08 (đợt 15) — Chuẩn bị publish Google Play: ký release thật + Privacy Policy

Chủ dự án xác nhận đã có sẵn tài khoản Google Play Console, yêu cầu code
xong phần chuẩn bị kỹ thuật, và tự thêm GitHub secret. Trước đó đã phát
hiện: CI build `.apk` release đang ký bằng **debug key**
(`signingConfig = signingConfigs.getByName("debug")` mặc định của
`flutter create`) — Play Console từ chối thẳng build ký bằng debug key.

- **Ký release thật, có điều kiện** (`android/app/build.gradle.kts`, vá
  qua `sed` trong CI vì `android/` không commit — xem đợt 4): thêm
  `signingConfigs.create("release")` đọc từ `android/key.properties`
  (`keyAlias`/`keyPassword`/`storeFile`/`storePassword`), và
  `buildTypes.release.signingConfig` giờ là biểu thức điều kiện:
  `if (keystorePropertiesFile.exists()) signingConfigs.getByName("release")
  else signingConfigs.getByName("debug")` — đúng pattern "gate theo secret,
  không có secret thì rơi về hành vi cũ" đã dùng cho Firebase/BuildTimeDefaults
  (đợt 8/9). Nghĩa là: chưa thêm secret → build `.apk` test vẫn ký debug
  như trước, không có gì hỏng; thêm secret xong → CẢ `.apk` test lẫn
  `.aab` Play Store đều tự động ký bằng key thật.
- **4 GitHub secret chủ dự án cần tự thêm** (Claude không tạo được):
  `ANDROID_KEYSTORE_BASE64` (nội dung file `.jks` encode base64),
  `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`.
  Tạo keystore bằng lệnh chuẩn của Android:
  `keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048
  -validity 10000 -alias upload` — **Claude không tự tạo keystore hộ**, vì
  đây là khoá ký duy nhất cho vòng đời app trên Play Store (mất là không
  bao giờ update lại được app dưới cùng listing nữa), phải do chính chủ
  dự án tạo và giữ, không phải thứ nên đi qua tay AI.
- **Thêm bước build `.aab`** (Android App Bundle) — Play Store bắt buộc
  định dạng này cho app mới từ 2021, khác `.apk` (vẫn giữ `.apk` cho mục
  đích test/sideload như cũ, không đụng tới). Bước build `.aab` SKIP hẳn
  (không chỉ build ký sai) nếu chưa có secret `ANDROID_KEYSTORE_BASE64` —
  build `.aab` ký debug không có ý nghĩa gì vì Play sẽ từ chối, nên không
  tốn công build. `upload-artifact` cho `.aab` dùng
  `if-no-files-found: warn` (không phải `error`) để không làm fail cả
  workflow khi bước build bị skip.
- **Đã verify cục bộ**: tự scaffold `android/` thật, áp `sed` patch, đọc
  lại `build.gradle.kts` xác nhận cú pháp Kotlin DSL đúng (khớp gần như
  y hệt pattern chính thức trong tài liệu Flutter cho release signing).
  KHÔNG build thử được `flutter build apk`/`appbundle` cục bộ vì sandbox
  không có Android SDK (giới hạn đã biết từ trước) — CI (có Android SDK
  qua `subosito/flutter-action`) là nơi verify thật.
- **Privacy Policy** (`docs/privacy-policy.html`, mới) — bắt buộc với Play
  Console. Host qua **GitHub Pages**, branch `claude/mobile-app-from-markdown-p0uxzh`
  (đúng branch mặc định/HEAD của repo — xác nhận qua `git remote show
  origin`), thư mục `/docs`. **Việc chủ dự án cần tự làm** (Claude không
  bật được Settings repo qua tool hiện có): vào Settings → Pages → Source:
  "Deploy from a branch" → Branch: branch này, folder `/docs` → Save. URL
  kết quả sẽ là `https://dieuvu0584.github.io/iLocation/privacy-policy.html`.
  Nội dung trang liệt kê ĐÚNG những gì app thật sự làm (đối chiếu code, không
  phải mẫu chung chung): 6 provider bên thứ 3 thực tế gọi tới (Nominatim/
  Overpass, OpenWeatherMap, Open-Meteo, Tavily, LLM provider, Firebase
  Remote Config), xác nhận rõ app KHÔNG dùng GPS thiết bị (setting "Use my
  location" trong Privacy chỉ là toggle chưa nối logic — xem đợt 5/14), dữ
  liệu cache/lịch sử/settings chỉ lưu local, API key BYOK chỉ nằm trong
  secure storage. Email liên hệ: `dieuvu0584@gmail.com`.
- **Việc chủ dự án CÒN CẦN tự làm ngoài phần trên** (Play Console, không
  phải code): điền Store Listing (mô tả, ảnh chụp màn hình, feature
  graphic — icon app đã có sẵn từ đợt 12), Content rating questionnaire,
  Data safety form (khai đúng theo nội dung Privacy Policy ở trên), và lưu
  ý **tài khoản Play Console mới phải chạy Closed testing với ≥12 người
  trong 14 ngày liên tục** trước khi mở khoá được Production — không thể
  bỏ qua bước này.

### 2026-08-08 (đợt 14) — Audit checklist thông tin cơ bản; node level 2 vuông + giãn cách lỏng

Chủ dự án liệt kê 12 loại thông tin cơ bản cần LUÔN có khi search 1 địa
điểm, yêu cầu tất cả ở "node level 2" cho tiện check, đổi style node level
2 về hình vuông (như trước đợt 6), và node level 2 không cần cách đều nhau
so với level 1.

- **Audit 12 mục yêu cầu**: 8/12 đã có sẵn — lịch sử địa điểm (`history`,
  đợt 11), Google Maps link (`maps`, đợt 10), signature images link
  (`photos`, đợt 5), chi phí sinh hoạt (`cost`), tiền tệ & thanh toán
  (`currency`), điện thoại khẩn cấp (`emergency`), văn hoá địa phương
  (`etiquette`), đồ ăn phổ biến (`food`) — không cần sửa. 4 mục còn thiếu
  hoặc chưa đủ, đã bổ sung trong đợt này (xem dưới).
- **`directions` (mới)** — "di chuyển từ vị trí điện thoại tới đó bằng
  cách nào" — khác hẳn `transport` (đi lại LOCAL tại điểm đến, đã có).
  Dùng Google Maps Directions URL **chỉ set destination, bỏ trống origin**
  (`.../maps/dir/?api=1&destination=lat,lng`) — Google Maps tự động dùng
  "vị trí hiện tại" của máy khi mở link, nên KHÔNG cần xin quyền định vị
  hay thêm package `geolocator` nào trong app (setting "Use my location"
  hiện có trong Privacy chỉ là 1 toggle chưa nối vào logic gì — không đụng
  tới). Cùng pattern static/link như `maps`/`photos`: thêm vào
  `MapLinkService.getDirectionsItem()`, `kChildIdsByGroup['explore']`,
  `kStaticItemIds`, TTL null.
- **Weather: thêm dự báo 7 ngày** — OpenWeatherMap (BYOK, hiện tại) giữ
  nguyên cho thời tiết hiện tại; dự báo 7 ngày gọi thêm **Open-Meteo**
  (open-meteo.com) — **miễn phí, không cần key**, đúng tinh thần ưu tiên
  provider không-key của dự án (giống Nominatim/Overpass). Gộp vào cùng 1
  `ChildItem` 'weather' (`detail` field), gọi best-effort — lỗi/timeout gọi
  Open-Meteo không làm hỏng phần thời tiết hiện tại, chỉ đơn giản thiếu
  đoạn dự báo. Dùng mã thời tiết WMO chuẩn (`weather_code`) map sang text
  ngắn (`_wmoWeatherLabels` trong `weather_service.dart`).
- **`safety_history` (mới)** — "an toàn trong quá khứ", khác `safety_level`
  hiện có (đang là "an toàn hiện tại"). Mục LLM mới trong nhóm `safety`,
  query tìm kiếm nền: lịch sử tội phạm/sự kiện an toàn đáng chú ý trong
  quá khứ. Đồng thời **mở rộng query của `safety_level`** để phủ luôn
  "thiên tai, chiến tranh" theo đúng yêu cầu (trước đó chỉ có
  "scams/crime") — không tách riêng thành mục thứ 3 vì cả 2 đều là tình
  trạng AN TOÀN HIỆN TẠI, chỉ khác góc nhìn (chung chung vs thiên
  tai/chính trị).
- **26 → 28 mục con.** `explore` giờ 8 mục, `safety` giờ 6 mục.
- **Node level 2 đổi lại hình vuông bo góc** (`RoundedRectangleBorder`,
  radius 20) — đảo ngược phần "hình tròn" của đợt 6, áp dụng cho MỌI
  `RingNode` (cả khi hiện nhóm lẫn khi hiện mục con — 2 màn dùng chung 1
  widget, không tách style riêng theo tầng). `CenterNode` (vòng tròn phát
  sáng ở giữa) giữ nguyên không đổi — chỉ "node level 2" (ring nodes) đổi,
  không phải "level 1" (center).
- **Giãn cách "level 2" không còn bắt buộc đều nhau** — đã hỏi lại chủ dự
  án giữa 2 phương án (vẫn là đồ thị nhưng nới lỏng giãn cách, hay chuyển
  hẳn sang lưới card không đường nối) vì đây là quyết định ảnh hưởng tới
  bản sắc UI cốt lõi của app (node-graph, không phải list truyền thống —
  nguyên tắc đầu tiên trong "Bối cảnh dự án"). Chủ dự án chọn **giữ đồ thị,
  nới lỏng giãn cách** — `ring_layout.dart` có hàm mới
  `relaxedRingPositions()` thay cho `ringPositions()` (đã xoá hẳn, không
  còn nơi nào gọi): áp dụng lệch góc + hệ số bán kính xen kẽ theo index
  (`angleJitter`/`radiusFactor`, deterministic — không đổi giữa các lần
  render), thay vì chia đều tuyệt đối `2*pi/count`. Vẫn giữ đường nối từ
  tâm (`ConnectorPainter`) và cảm giác "graph" đặc trưng của app — chỉ bỏ
  yêu cầu chia đều góc/bán kính, không đổi kiến trúc màn hình. Đã tăng
  margin trừ bán kính (56→64) và giảm trần clamp (190→178) để chừa chỗ cho
  hệ số bán kính ngoài (1.06x) không bị tràn ra rìa màn hình khi 1 nhóm có
  nhiều mục con (vd `explore` giờ 8 mục).
- **Đã verify trực quan cục bộ** bằng cách build Linux desktop thật với 1
  entrypoint preview tạm (`lib/_preview_graph.dart`, đã xoá sau khi xong,
  theo đúng pattern preview file tạm đã dùng ở đợt 7) + Xvfb + `import`
  chụp ảnh — xác nhận: node vuông bo góc, giãn cách rõ ràng không đều, 8
  mục trong `explore` không chồng/không tràn viền, node "Get there" hiện
  đúng icon+nhãn.

### 2026-08-08 (đợt 13) — Đổi tên app hiển thị thành "Location Explorer"

Chủ dự án yêu cầu "đổi tên app thành Location Explorer".

- **Tên trong app (MaterialApp `title`) và l10n (`appTitle`) đã ĐÚNG sẵn**
  — cả 2 đều đã là "Location Explorer" từ trước, không cần sửa gì ở tầng
  Flutter/Dart.
- **Vấn đề thật sự nằm ở tên hiển thị cấp hệ điều hành Android**
  (`android:label` trong `AndroidManifest.xml` — tên hiện dưới icon ở màn
  hình chính, trong app switcher, và trong danh sách app của Settings).
  `flutter create --project-name ilocation` (chạy lại mỗi lần build vì
  `android/` không commit — xem đợt 4) đặt `android:label="ilocation"` (tên
  package thô, chữ thường), khác hẳn tên hiển thị trong app.
- **Sửa bằng `sed`** trong `.github/workflows/build-apk.yml`, thêm step mới
  ngay sau step "add ACTION_VIEW query" — pattern giống hệt các lần vá
  `AndroidManifest.xml` trước (đợt 4 INTERNET permission, đợt 5 ACTION_VIEW
  query): `sed -i 's|android:label="ilocation"|android:label="Location
  Explorer"|'`, có `grep` xác nhận sau để build FAIL RÕ RÀNG nếu template
  Flutter version sau này đổi khác. Đã verify cục bộ bằng cách tự scaffold
  `android/` rồi chạy sed thật, xác nhận đúng.
- **KHÔNG đổi** `pubspec.yaml` `name: ilocation` (định danh package Dart
  nội bộ, dùng trong mọi `package:ilocation/...` import xuyên suốt
  codebase — đổi cái này là 1 refactor lớn, rủi ro cao, và người dùng cuối
  không bao giờ nhìn thấy giá trị này) và **KHÔNG đổi** tên artifact CI
  `ilocation-release-apk` (chỉ là tên file build nội bộ trong GitHub
  Actions, không phải "tên app"). Đây là phạm vi tối thiểu đúng với yêu cầu
  "đổi tên app" — chỉ sửa những gì người dùng thực sự nhìn thấy.

### 2026-08-08 (đợt 12) — Thiết kế app icon mới (location pin, đúng bảng màu)

Chủ dự án yêu cầu "tạo và cập nhật app icon phong cách hiện đại, gam màu
phù hợp, có kèm biểu tượng location".

- **Thiết kế**: 1 map pin (teardrop) màu `accentAmber` (#E8A33D) với lỗ
  tròn ở giữa màu `bgMid` (#16283A, viền `accentAmberDark`), đặt trên nền
  gradient chéo `bgDark` (#0A141D) → `bgMid` — đúng bảng màu đã chốt ở
  `mobile/lib/theme/colors.dart`, không tự bịa màu mới. Có bóng đổ mềm dưới
  pin để tạo chiều sâu (yêu cầu "hiện đại").
- **`mobile/tool/generate_icon.py`** (mới, dùng Pillow): script one-off,
  KHÔNG chạy trong pipeline build — chỉ chạy thủ công khi cần đổi lại thiết
  kế. Render ở độ phân giải 4x rồi downsample (LANCZOS) để chống răng cưa.
  Xuất 2 file vào `mobile/assets/icon/`:
  - `app_icon.png` (1024×1024, nền đầy, bo góc) — icon "legacy"/không phải
    adaptive, dùng cho `image_path`.
  - `app_icon_foreground.png` (1024×1024, nền trong suốt, pin thu nhỏ nằm
    trong vùng an toàn ~66% giữa canvas) — lớp foreground cho Android
    adaptive icon, tránh bị cắt khi launcher mask theo hình tròn/vuông bo/
    squircle khác nhau.
- **`flutter_launcher_icons`** (package mới, dev dependency) sinh icon thật
  từ 2 file trên — cấu hình nằm ngay trong `pubspec.yaml`
  (`flutter_launcher_icons:` block): `android: "launcher_icon"` (đặt tên
  riêng, không ghi đè `ic_launcher` mặc định — package tự cập nhật
  `android:icon` trong `AndroidManifest.xml` trỏ tới tên mới), `ios: false`
  (app không build iOS, thư mục `ios/` không được scaffold trong CI nên để
  `true` sẽ lỗi), `adaptive_icon_background: "#16283A"` (dùng thẳng mã màu,
  không cần ảnh riêng), `adaptive_icon_foreground` trỏ tới
  `app_icon_foreground.png`.
- **CI**: vì `android/` không commit vào repo (regenerate mỗi lần build,
  xem đợt 4), việc sinh icon PHẢI chạy trong `.github/workflows/build-apk.yml`
  — thêm step `dart run flutter_launcher_icons` ngay sau `flutter pub get`
  (cần dependency đã resolve) và sau `flutter create` (cần `android/` đã
  tồn tại), trước `flutter build apk --release`. Đã verify cục bộ bằng cách
  tự scaffold `android/` (`flutter create --platforms=android .`) rồi chạy
  `dart run flutter_launcher_icons` — xác nhận đúng: sinh
  `mipmap-*/launcher_icon.png` + `mipmap-anydpi-v26/launcher_icon.xml`
  (adaptive icon) + tự thêm `values/colors.xml` (biến `ic_launcher_background`)
  + tự sửa `android:icon="@mipmap/launcher_icon"` trong manifest. File
  `ic_launcher.png` mặc định của Flutter (logo Flutter) vẫn còn trong
  `mipmap-*/` nhưng không còn được manifest tham chiếu tới — vô hại, không
  cần dọn.
- Bảng màu ở `tool/generate_icon.py` chép tay từ `colors.dart` (không import
  chéo Dart↔Python được) — **nếu sau này đổi `colors.dart`, nhớ sửa cả file
  Python này rồi chạy lại script + `dart run flutter_launcher_icons`** để
  icon không bị lệch màu với UI.

### 2026-08-08 (đợt 11) — Thêm node Travel tips + History; giữ nguyên Currency

Chủ dự án yêu cầu "thêm node thông tin travel, tiền tệ, lịch sử địa điểm".
Trước khi code, đã hỏi lại 2 câu vì 2/3 yêu cầu có thể trùng/mơ hồ với node
đã có:

- **"Tiền tệ"**: app đã có sẵn node "Currency & payments" (tỷ giá, thanh
  toán) trong nhóm `practical`. Chủ dự án xác nhận **node hiện có là đủ,
  không thêm gì mới** — đây là lý do KHÔNG có thay đổi nào cho `currency`
  trong đợt này dù nằm trong yêu cầu ban đầu.
- **"Thông tin travel"**: mơ hồ vì app đã có nhiều node liên quan (giao
  thông, best time, visa, an toàn...). Đã hỏi lại, chủ dự án chọn **"Mẹo du
  lịch chung (travel tips)"** — khác các node chi tiết đã có (không phải
  cảnh báo an ninh chính thức, không phải hướng dẫn giao thông cụ thể).
- **"Lịch sử địa điểm"**: rõ ràng ngay từ đầu, không cần hỏi — lịch sử/nền
  tảng hình thành của địa điểm (khác hẳn "Lịch sử tìm kiếm" của
  `history_screen.dart`, đó là lịch sử tra cứu của người dùng, không liên
  quan).

- **2 mục con LLM mới**: `travel_tips` (nhóm `explore`, sau `best_time`) và
  `history` (nhóm `culture`, sau `holidays`) — 24 → 26 mục con. Cả 2 đều đi
  qua pipeline LLM có sẵn (`kLlmItemIds`), không cần logic riêng ở
  `orchestrator_service.dart` — chỉ cần thêm entry trong
  `LlmService.searchQueryTemplates` (câu query tìm kiếm nền cho từng mục)
  và `kChildLabels`/`kChildIdsByGroup` trong `location_models.dart`, đúng
  pattern data-driven đã có sẵn cho mọi mục LLM khác.
- **TTL cache**: cả 2 xếp vào nhóm "rarely-changing content" (90 ngày,
  `CacheService.ttlByItem`) — cùng nhóm với `food`/`best_time`/`etiquette`/
  `holidays`, vì nội dung mẹo du lịch chung và lịch sử hầu như không đổi
  theo ngày/tuần.
- **Icon**: `travel_tips` → `Icons.tips_and_updates_outlined`, `history` →
  `Icons.museum_outlined` (`graph_icons.dart`).
- Layout node-graph tự chia đều theo số lượng mục (đã ghi ở đợt 10) — thêm
  mục vào `explore`/`culture` không cần sửa gì ở tầng layout, y hệt lý do
  Google Maps không cần sửa layout ở đợt 10.

### 2026-08-07 (đợt 10) — Khoá cứng Trợ lý AI = Groq luôn bật, ẩn màn hình cài đặt; thêm node Google Maps

Sau khi xác nhận đã tự thêm xong 3 GitHub Actions secret (đợt 9), chủ dự án
yêu cầu tiếp trong 1 message: (1) Trợ lý AI (LLM) luôn bật với Groq key,
detail level = "chi tiết" (`detailed`), hiện nguồn (`showSources`), và ẩn
hẳn màn hình cài đặt Trợ lý AI; (2) thêm 1 node "Google Maps" vào node-graph
khi xem 1 địa điểm.

- **Khoá cứng 4 giá trị**: `AppSettings.llmEnabled`/`llmProvider`/
  `detailLevel`/`showSources` giờ là getter hardcode (`true`/
  `ByokProvider.groq`/`DetailLevel.detailed`/`true`), KHÔNG còn đọc từ
  `SettingsService`/SharedPreferences nữa — đảm bảo đúng behavior "LUÔN"
  bật bất kể giá trị đã lưu trước đó từ khi màn hình còn tồn tại (nếu chỉ
  đổi default mà vẫn đọc pref cũ, người dùng đã từng tắt/đổi provider sẽ
  không được áp dụng giá trị mới). Các setter tương ứng
  (`setLlmEnabled`/`setLlmProvider`/`setDetailLevel`/`setShowSources`) đã
  xoá luôn khỏi `AppSettings` vì không còn nơi nào gọi. `SettingsService`
  (tầng SharedPreferences bên dưới) vẫn giữ nguyên các field này — không
  xoá — phòng khi sau này cần cho cấu hình lại được.
- **Xoá hẳn `llm_settings_screen.dart`** và bỏ tile "AI Assistant" khỏi
  `settings_home_screen.dart` — toàn bộ nội dung màn hình đó (chọn
  provider, nhập key, detail level, show sources) đều đã bị khoá cứng nên
  không còn gì để hiển thị, theo đúng pattern đã làm với
  `api_keys_settings_screen.dart` ở đợt 9. `getLlmApiKey`/`setLlmApiKey`
  vẫn giữ trong `AppSettings` (không xoá) — `buildRequestSettings()` vẫn
  gọi để tôn trọng key Groq người dùng có thể đã tự lưu từ trước khi màn
  hình bị ẩn, y hệt lý do giữ lại `getWeatherApiKey`/`getSearchApiKey` ở
  đợt 9. Xoá luôn `widgets/common/get_api_key_link.dart` — sau khi màn
  hình Trợ lý AI biến mất, đây là nơi gọi widget này cuối cùng còn lại
  trong app (API Keys screen đã xoá ở đợt 9), không còn chỗ nào dùng nữa.
- **Node "Google Maps" mới trong nhóm `explore`** (6 mục, từ 5) — cùng
  pattern với `photos` (đợt 5): loại `source: 'link'`, không qua LLM,
  không cần key, không có TTL (deterministic, không bao giờ "cũ").
  `MapLinkService` (`mobile/lib/services/map_link_service.dart`, mới) dựng
  URL từ **toạ độ** (`https://www.google.com/maps/search/?api=1&query=lat,lng`,
  theo đúng Google Maps URL API chính thức) thay vì tên địa điểm — chính
  xác hơn `photos` (tránh trùng tên địa điểm ở nơi khác trên thế giới).
  Wiring giống hệt `photos`: thêm vào `kChildIdsByGroup['explore']`,
  `kStaticItemIds`, `kChildLabels`, `graph_icons.dart`
  (`Icons.map_outlined`), `CacheService.ttlByItem` (`'maps': null`), và
  nhánh `else if (itemId == 'maps')` trong
  `OrchestratorService._resolveItem`. **Không cần migration schema** —
  tái dùng cột `link_url` đã có sẵn từ `photos` (đợt 5).
- Layout node-graph (`ring_layout.dart`) tự chia đều theo `2*pi/count`,
  không hardcode số lượng mục — thêm mục thứ 6 vào `explore` không cần sửa
  gì ở tầng layout.

### 2026-08-06 (đợt 9) — Bỏ qua Firebase, dùng key mặc định qua `--dart-define` ở CI; ẩn 3 ô nhập key

Ngay sau đợt 8, chủ dự án dán LẠI 3 key thật (Weather/Tavily/Groq — cùng 3
key đã dán ở đợt 8) và yêu cầu thẳng: "use 3 key trên cho app, và hide
setting cho 3 key này, build lại app". Đã hỏi lại 1 câu (hide ngay hay đợi
setup Firebase Console xong) — chủ dự án trả lời **"ignore firebase
solution, use keys and hide setting now anyway"**, tức là bỏ luôn hướng
Firebase Remote Config (đợt 8) cho đợt key lần này.

- **Vẫn TỪ CHỐI ghi giá trị key thật vào bất kỳ file nào commit vào repo**
  — lý do y hệt đợt 8 (repo public, lộ ngay lập tức, bot quét trong vài
  phút). Đây là ranh giới không đổi dù được yêu cầu trực tiếp 2 lần.
- **Giải pháp đã làm thay vì Firebase**: `mobile/lib/config/build_time_defaults.dart`
  (`BuildTimeDefaults`) — 3 hằng số `String.fromEnvironment('DEFAULT_WEATHER_API_KEY'
  | 'DEFAULT_TAVILY_API_KEY' | 'DEFAULT_GROQ_API_KEY')`, chỉ có giá trị khi
  CI build với `--dart-define` tương ứng. `.github/workflows/build-apk.yml`
  đọc 3 secret cùng tên qua `env:` rồi truyền vào `flutter build apk
  --release --dart-define=...`. **Chủ dự án cần tự vào GitHub repo Settings →
  Secrets and variables → Actions, tự thêm 3 secret này với giá trị key
  thật** — Claude không có quyền tạo secret. Nếu chưa set, `--dart-define`
  nhận chuỗi rỗng, `BuildTimeDefaults` coi là "không có default", rơi tiếp
  xuống Firebase Remote Config (đợt 8, vẫn giữ nguyên code, không xoá) rồi
  tới "cần thêm API key" — không có gì hỏng, chỉ đơn giản chưa có default
  nào hoạt động cho tới khi họ set secret.
- **Thứ tự ưu tiên đầy đủ** (`AppSettings.buildRequestSettings()`): key
  người dùng tự nhập (secure storage) → `BuildTimeDefaults` (đợt 9,
  `--dart-define`) → Firebase Remote Config (đợt 8) → "cần thêm API key".
  Cách này KHÔNG cần Firebase Console/`google-services.json` gì cả nếu chủ
  dự án chỉ dùng đường `--dart-define` — đơn giản hơn hẳn đợt 8, đánh đổi:
  đổi key phải build lại app (không "remote" thật sự như Remote Config).
- **Ẩn hẳn 3 ô nhập key theo đúng yêu cầu**:
  - Xoá hẳn `api_keys_settings_screen.dart` (màn hình Weather + Search) và
    bỏ tile "API Keys" khỏi `settings_home_screen.dart` — cả màn hình chỉ
    có 2 field này nên xoá nguyên màn thay vì để trống.
  - `llm_settings_screen.dart`: ô nhập API key CHỈ ẩn khi
    `llmProvider == ByokProvider.groq` (thay bằng 1 card ghi chú
    `l10n.llmKeyBuiltIn`) — Gemini/OpenRouter/OpenAI vẫn hiện ô nhập bình
    thường vì 3 provider đó KHÔNG có default, ẩn đi sẽ khiến chúng vĩnh
    viễn không dùng được. Đừng ẩn ô key cho các provider này.
  - `AppSettings.getWeatherApiKey/setWeatherApiKey/getSearchApiKey/
    setSearchApiKey` vẫn giữ nguyên trong code (không xoá) — dù không còn
    UI nào gọi tới `setXxx`, `getXxx` vẫn được `buildRequestSettings()` gọi
    để tôn trọng key cũ đã lưu từ trước khi ẩn UI (nếu có).
- Do đã ẩn UI nhập key, khi cả 3 secret CI lẫn Firebase Remote Config đều
  chưa set (đúng trạng thái hiện tại), Weather/Search/Groq sẽ hiện "cần
  thêm API key" **và người dùng không còn cách nào tự sửa từ trong app** —
  đã báo trước điều này, chủ dự án xác nhận chấp nhận đánh đổi. Ưu tiên số 1
  cần làm tiếp: set 3 GitHub secret nói trên.

### 2026-08-06 (đợt 8) — App-owned default key cho Weather/Search/Groq qua Firebase Remote Config

Chủ dự án dán 3 API key thật (OpenWeatherMap, Tavily, Groq) vào chat và yêu
cầu **built-in cứng làm default trong app**. Đã TỪ CHỐI làm vậy — repo
`dieuvu0584/iLocation` là public, commit key vào source lộ ngay lập tức;
ngay cả không commit git, key bake vào APK build ra vẫn luôn decompile được.
Khuyên chủ dự án **đổi lại (rotate) cả 3 key** vì đã dán vào chat. Thay vào
đó, bước đầu thêm nút "Lấy API key" (`GetApiKeyLink` widget) ở mỗi ô nhập
key trong Settings, trỏ tới trang tạo key của từng provider.

Chủ dự án sau đó yêu cầu đổi kiến trúc để app lấy 3 key này **qua Firebase**
thay vì bắt mỗi người dùng tự nhập. Đã hỏi lại 2 câu: (1) Remote Config hay
Cloud Functions proxy, (2) đã có Firebase project chưa. Chủ dự án chọn
Remote Config, có hỏi thêm "mã hoá key trên Firebase, giải mã trong app có
ổn không" — đã giải thích: mã hoá/giải mã phía client KHÔNG chặn được người
cố tình decompile APK (khoá giải mã cũng phải đóng gói trong cùng APK), chỉ
chặn được rò rỉ tình cờ (vd ai đó nhìn màn hình Firebase console). Quyết
định: **dùng Remote Config, KHÔNG mã hoá** — mã hoá thêm phức tạp mà không
tăng bảo mật thật sự cho use case side-project cá nhân này.

- **Đây KHÔNG phải BYOK.** Đây là default key do CHỦ DỰ ÁN sở hữu, cấu hình
  1 lần trên Firebase Console (Remote Config parameters: `weather_api_key`,
  `tavily_api_key`, `groq_api_key`), mọi người dùng app đều dùng chung —
  **đổi ngược lại hoàn toàn ý "mọi provider đều BYOK, không có key mặc định
  của app"** ở đợt 2/đợt 4. Key người dùng tự nhập trong Settings (secure
  storage) LUÔN được ưu tiên trước; chỉ khi ô đó trống mới rơi xuống dùng
  default key từ Remote Config — xem `AppSettings.buildRequestSettings()`
  (`_orNonEmpty`), đây là nơi DUY NHẤT quyết định thứ tự ưu tiên này, đừng
  thêm logic fallback ở chỗ khác.
- **`RemoteConfigService`** (`mobile/lib/services/remote_config_service.dart`)
  bọc `firebase_core` + `firebase_remote_config`. Thiết kế fail-safe tuyệt
  đối: MỌI lỗi khi `Firebase.initializeApp()` (thiếu
  `google-services.json`, không mạng lần đầu mở app, project chưa cấu hình,
  v.v.) đều bị bắt và service rơi về trạng thái no-op (mọi getter trả
  `null`) — KHÔNG BAO GIỜ được để lỗi Firebase làm crash app hay chặn khởi
  động, vì Firebase ở đây là hạ tầng tuỳ chọn, không phải phụ thuộc bắt
  buộc. Nếu sửa file này, giữ nguyên nguyên tắc try/catch bao ngoài này.
- **Chỉ Groq có default LLM key** (chủ dự án chỉ đưa 1 key Groq, không phải
  cả 4 provider) — fallback LLM key trong `buildRequestSettings()` chỉ áp
  dụng khi `llmProvider == ByokProvider.groq`, các provider LLM khác
  (Gemini/OpenRouter/OpenAI) vẫn bắt buộc BYOK thuần, không có default.
- **`android/` không commit vào repo** (xem đợt 4) nên
  `google-services.json` cũng không thể commit thẳng — CI
  (`.github/workflows/build-apk.yml`) ghi file này từ 1 GitHub Actions
  secret (`GOOGLE_SERVICES_JSON_B64`, nội dung file gốc encode base64) và
  tự thêm Gradle plugin `com.google.gms.google-services` vào
  `settings.gradle.kts`/`app/build.gradle.kts` bằng `sed`, **CHỈ KHI secret
  đó tồn tại** — check bằng bash (`if [ -z "$GOOGLE_SERVICES_JSON_B64" ];
  then exit 0; fi` trong `run:`, đọc secret qua `env:`), KHÔNG dùng
  `if: secrets.X != ''` ở step — GitHub Actions từ chối cả file workflow
  với lỗi "Unrecognized named-value: 'secrets'" nếu dùng `secrets` context
  trực tiếp trong `if:` của step (đã tự vấp lỗi này 1 lần, build fail ngay
  lập tức với 0 job chạy — đừng lặp lại). Build vẫn chạy bình thường (thuần
  BYOK, như trước đợt 8) nếu chủ dự án chưa set secret này. Có `grep` xác
  nhận sau mỗi `sed` để build FAIL RÕ RÀNG nếu template Gradle của Flutter
  version sau này đổi khác, thay vì âm thầm bỏ qua bước inject plugin.
  **Việc chủ dự án cần tự làm (Claude không tự làm
  được vì cần đăng nhập Firebase CLI của chủ dự án)**: chạy
  `flutterfire configure` hoặc tải `google-services.json` từ Firebase
  Console cho app Android (package `com.ilocation.ilocation`, khớp
  `--org com.ilocation` trong CI), thêm base64 của file đó làm secret
  `GOOGLE_SERVICES_JSON_B64` trong GitHub repo settings, và điền 3 giá trị
  key thật vào 3 Remote Config parameter tương ứng trên Firebase Console.
- Chưa có UI hiển thị "đang dùng default key của app" khi rơi vào fallback
  — người dùng không biết được item nào đang chạy bằng key chung vs key
  riêng của họ. Không phải yêu cầu ban đầu, nhưng để ý nếu sau này muốn làm
  rõ hơn trong UI.

### 2026-08-05 (đợt 7) — Sửa bug cỡ chữ (Font size) trong Settings không có tác dụng

Chủ dự án báo kéo thanh trượt "Font size" lên max nhưng không thấy chữ đổi
gì cả. Tái hiện được bằng build Linux desktop thật + so sánh ảnh chụp
pixel-by-pixel (`compare -metric AE`) — xác nhận đúng: KHÔNG có bất kỳ chữ
nào trên toàn app đổi kích thước, dù giá trị `fontScale` trong state đã đổi
đúng (Slider di chuyển đúng vị trí).

- **Nguyên nhân gốc**: `AppTypography.textTheme()` (`lib/theme/typography.dart`)
  gọi `GoogleFonts.interTextTheme()` / `GoogleFonts.frauncesTextTheme()`
  **không truyền tham số base** — cách gọi này trả về `TextTheme` có
  `fontSize` là `null` cho MỌI style (chỉ style/font-family được set, không
  phải cỡ chữ). `.apply(fontSizeFactor: fontScale)` gọi sau đó vì vậy không
  có gì để nhân — mọi widget Text sau đó âm thầm rơi về cỡ chữ mặc định
  built-in của Flutter (không liên quan gì tới `fontScale`), nên slider kéo
  gì cũng vô tác dụng.
- **Đã thử 2 cách "hiển nhiên đúng" nhưng KHÔNG hoạt động** — ghi lại để
  không lặp lại sai lầm tương tự: dùng `ThemeData(...).textTheme` làm base,
  và dùng `Typography.material2021().white` làm base — cả 2 đều VẪN trả về
  `fontSize` null khi gọi ngoài 1 cây widget đã render đầy đủ (khác với kỳ
  vọng thông thường). Debug bằng cách build 1 app Flutter tối giản riêng
  (không qua Provider/Settings) in trực tiếp `textTheme.headlineSmall
  ?.fontSize` ra console mới lộ ra được `null` ở TẤT CẢ các cách thử.
- **Fix**: định nghĩa cứng 1 `TextTheme` cụ thể (`_fallbackSizes` trong
  `typography.dart`) với `fontSize` số thực cho từng style (theo chuẩn
  Material 3: displayLarge=57, ..., labelSmall=11), dùng làm base truyền
  vào `GoogleFonts.interTextTheme(_fallbackSizes)` /
  `frauncesTextTheme(_fallbackSizes)`. Đã verify lại bằng build thật +
  chụp ảnh so sánh: chữ toàn app giờ đổi cỡ đúng theo slider. **Nếu sau
  này đổi bộ font/thêm text style mới, đừng gọi `GoogleFonts.xTextTheme()`
  trực tiếp không tham số — luôn truyền `_fallbackSizes` (hoặc 1 TextTheme
  cụ thể khác có đủ `fontSize`) làm base.**

### 2026-08-05 (đợt 6) — Node hình tròn, bỏ nút demo, sửa bug Hotels không ra dữ liệu

**Phần "hình tròn" bên dưới đã bị ĐẢO NGƯỢC ở đợt 14** (node level 2 quay
lại hình vuông bo góc) — đừng làm theo phần này nữa, chỉ giữ lại để biết
lý do ban đầu.

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
- **LLM**: KHÔNG còn cho người dùng chọn provider — khoá cứng LUÔN bật với
  Groq (`AppSettings.llmEnabled`/`llmProvider` hardcode, đợt 10), dùng
  default key qua `--dart-define` (đợt 9) → Firebase Remote Config (đợt 8).
  `detailLevel`/`showSources` cũng khoá cứng (`detailed`/`true`). Màn hình
  "AI Assistant" đã xoá hẳn (đợt 10) — không còn cách nào trong app để tắt
  LLM, đổi provider, hay tự nhập key khác. Gemini/OpenRouter/OpenAI vẫn còn
  trong enum `ByokProvider` (không xoá, đề phòng cần bật lại chọn provider
  sau này) nhưng không còn đường nào trong UI để chọn tới chúng.
- **Web search**: Tavily — không còn ô nhập key trong app (đợt 9, đã ẩn UI).
  Thứ tự nguồn key: key người dùng đã lưu trước đó (nếu có) → build-time
  default qua `--dart-define` (đợt 9) → Firebase Remote Config (đợt 8);
  thiếu cả 3 thì bỏ qua bước search, LLM trả lời bằng kiến thức sẵn có và
  nói rõ không có nguồn.
- **Weather**: OpenWeatherMap — không còn ô nhập key trong app (đợt 9, đã
  ẩn UI). Cùng thứ tự nguồn key như Web search ở trên.
- **App-owned default key cho Weather/Tavily/Groq** — 2 lớp, ưu tiên từ
  trên xuống:
  1. **Build-time qua `--dart-define`** (đợt 9, `BuildTimeDefaults`
     trong `mobile/lib/config/build_time_defaults.dart`) — đọc từ 3
     GitHub Actions secret (`DEFAULT_WEATHER_API_KEY`/
     `DEFAULT_TAVILY_API_KEY`/`DEFAULT_GROQ_API_KEY`) tại lúc CI build
     APK, KHÔNG cần Firebase. Đây là lớp chủ dự án đang dùng (đã yêu cầu
     "ignore firebase solution" ở đợt 9).
  2. **Firebase Remote Config** (đợt 8, `RemoteConfigService`) — vẫn giữ
     nguyên trong code làm lớp dự phòng thứ 2, dù chủ dự án hiện chưa dùng
     tới (chưa set `google-services.json`/Remote Config Console). KHÔNG
     phải BYOK, KHÔNG phải backend. Fail-safe tuyệt đối — mọi lỗi Firebase
     đều rơi về no-op, không bao giờ crash app.
  Cả 2 lớp đều là key do CHỦ DỰ ÁN sở hữu, dùng chung cho mọi người dùng —
  khác hẳn BYOK. Xem `AppSettings.buildRequestSettings()` cho thứ tự ưu
  tiên đầy đủ.
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
        privacy_settings_screen.dart
        settings_home_screen.dart      # KHÔNG còn tile "AI Assistant" (đợt 10) lẫn "API Keys" (đợt 9)
      search/               # search_screen.dart — đơn giản, chức năng
      history/                # history_screen.dart — tương tự
    /widgets
      node_graph/            # ring_layout, graph_node, connector_painter, graph_icons
      common/                  # settings_scaffold.dart
    /config
      build_time_defaults.dart   # đợt 9: default key qua --dart-define lúc CI build, KHÔNG commit giá trị thật
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
      map_link_service.dart                          # đợt 10: dựng URL Google Maps từ toạ độ, KHÔNG key, KHÔNG LLM
      orchestrator_service.dart                    # Dart port của backend/app/services/orchestrator.py
      secure_storage.dart                            # API key BYOK còn lại (LLM + Weather + Search)
      remote_config_service.dart                       # Firebase Remote Config — default key Weather/Tavily/Groq (đợt 8), fail-safe
      settings_service.dart                            # SharedPreferences — setting không nhạy cảm
      history_service.dart
    /state
      app_settings.dart            # ChangeNotifier bọc SettingsService + SecureStorageService + RemoteConfigService
      location_provider.dart         # ChangeNotifier gọi orchestrator_service.dart trực tiếp (không qua HTTP)
    /l10n                              # ARB files (app_en.arb, app_vi.arb) + generated/ (xem README)
    /theme
      colors.dart                       # bám theo palette ở SDD mục 9, KHÔNG tự đổi màu
      typography.dart                     # Fraunces (display) + Inter (body), qua google_fonts
    /assets
      emergency_numbers.json                  # copy từ backend/data/, bundle vào app
      icon/
        app_icon.png                            # đợt 12: icon "legacy", nền đầy + bo góc
        app_icon_foreground.png                   # đợt 12: layer foreground cho Android adaptive icon
  /tool
    generate_icon.py                                # đợt 12: script Pillow one-off sinh 2 file icon trên, KHÔNG chạy trong build
```

## Nguyên tắc thiết kế cần giữ khi code

1. **Không phải mọi mục thông tin đều gọi LLM.** Tổng cộng có 28 mục con
   (`kChildIdsByGroup`). 4 mục (Places, Weather, Airport, Hotels) gọi API
   structured trực tiếp (`kApiItemIds`); 5 mục (Timezone, Emergency,
   Signature photos, Google Maps, Get there/directions) tính/tra cứu/dựng
   URL offline không qua LLM, không cần key (`kStaticItemIds`). Chỉ 19/28
   mục còn lại mới qua LLM (`kLlmItemIds`). Đừng gộp chung logic.

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
- [x] Code app-owned default key qua Firebase Remote Config (đợt 8) —
      `RemoteConfigService` + fallback trong `AppSettings`, CI đã có bước
      inject `google-services.json`/Gradle plugin (gated theo secret). Chủ
      dự án chưa dùng lớp này (đã chọn hướng đợt 9 thay thế) nhưng code vẫn
      giữ nguyên làm lớp dự phòng thứ 2.
- [x] Code app-owned default key qua `--dart-define` lúc CI build (đợt 9) —
      `BuildTimeDefaults`, ưu tiên cao hơn Firebase Remote Config trong
      `buildRequestSettings()`. Đã ẩn 3 ô nhập key Weather/Search/Groq khỏi
      Settings UI theo yêu cầu trực tiếp của chủ dự án.
- [ ] Chủ dự án cần tự thêm 3 GitHub Actions secret (`DEFAULT_WEATHER_API_KEY`,
      `DEFAULT_TAVILY_API_KEY`, `DEFAULT_GROQ_API_KEY`) trong repo Settings →
      Secrets and variables → Actions với giá trị key thật — Claude không
      có quyền tạo secret. **Cho tới khi làm bước này, Weather/Search/Groq
      sẽ hiện "cần thêm API key" và người dùng KHÔNG còn cách nào tự sửa từ
      trong app** (vì đã ẩn UI nhập key ở đợt 9) — đây là đánh đổi chủ dự
      án đã xác nhận chấp nhận.
- [x] Code ký release thật cho Play Store (đợt 15) — signingConfigs điều
      kiện trong `build.gradle.kts`, bước build `.aab`, Privacy Policy
      (`docs/privacy-policy.html`).
- [ ] Chủ dự án cần tự: (1) tạo Android upload keystore bằng `keytool`
      (lệnh ở đợt 15) và thêm 4 GitHub secret (`ANDROID_KEYSTORE_BASE64`,
      `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`,
      `ANDROID_KEY_PASSWORD`); (2) bật GitHub Pages (Settings → Pages →
      branch này, folder `/docs`) để Privacy Policy URL hoạt động; (3)
      hoàn tất Store Listing/Content rating/Data safety form và chạy đủ
      Closed testing 14 ngày/≥12 người trên Play Console — không có bước
      nào ở đây Claude làm thay được.

## Việc KHÔNG được tự quyết định (còn lại)

- **Ghi giá trị API key thật vào bất kỳ file nào commit vào repo** (source,
  YAML, docs, v.v.) — đã bị từ chối 2 lần (đợt 8, đợt 9) dù được yêu cầu
  trực tiếp, vì repo `dieuvu0584/iLocation` là public. Nơi DUY NHẤT hợp lệ
  cho giá trị key thật: GitHub Actions secrets (chủ dự án tự thêm) hoặc
  Firebase Remote Config Console (chủ dự án tự điền) — không bao giờ trong
  git history. Đây là ranh giới cứng, không tự đảo ngược kể cả khi được
  yêu cầu lại lần nữa.
- **Tự tạo/tự giữ Android upload keystore hộ chủ dự án** (đợt 15) — đây là
  khoá ký duy nhất cho vòng đời app trên Play Store, mất là không bao giờ
  update lại được app dưới cùng listing nữa. Chỉ đưa ra lệnh `keytool` để
  chủ dự án tự chạy, không tự sinh file `.jks` hay giữ mật khẩu hộ.
- Đổi web search provider khỏi Tavily mà không hỏi lại.
- Thêm bất kỳ managed/paid service nào KHÁC ngoài Firebase Remote Config
  (vd: quay lại có backend thật sự chạy code — Cloud Functions, hoặc thêm 1
  API trả phí khác) mà không hỏi lại — kiến trúc client-only vẫn giữ
  nguyên, Firebase Remote Config ở đợt 8 chỉ là 1 giá trị cấu hình tĩnh đọc
  từ xa, KHÔNG phải backend chạy code, đã được chủ dự án xác nhận trực
  tiếp nên KHÔNG tính là vi phạm quyết định đợt 2. Đừng tự ý đổi qua
  Cloud Functions proxy (phương án đã hỏi và bị từ chối vì cần backend +
  Firebase Blaze trả phí) mà không hỏi lại lần nữa.
- Mã hoá key trong Remote Config — đã cân nhắc và quyết định KHÔNG làm
  (đợt 8, xem lý do ở trên: không tăng bảo mật thật sự, chỉ thêm phức
  tạp). Đừng tự thêm lại trừ khi chủ dự án yêu cầu.
- Thiết kế lại UI Search/History thành phiên bản "đầy đủ" (đã triển khai bản
  tối giản; nếu muốn nâng cấp UI, xác nhận hướng thiết kế trước).
