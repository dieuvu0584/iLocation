# SDD — Location Info Explorer (tên tạm)

## 1. Tổng quan

Ứng dụng mobile cho phép người dùng tra cứu một địa điểm bất kỳ (toàn cầu) và
nhận về thông tin tổng hợp, cập nhật, được tổ chức theo dạng **node-graph
tương tác** thay vì list/card truyền thống.

**Mục tiêu chính**
- Tra cứu 1 địa điểm → trả về đầy đủ thông tin hữu ích cho người mới đến,
  tổng hợp từ nhiều nguồn (API structured + web search + LLM summarization).
- Trải nghiệm UI khác biệt: bản đồ tư duy (node-graph) thay vì scroll list.
- Chi phí vận hành thấp: cache tối đa, LLM chỉ dùng khi cần, có free-tier
  mặc định + cho phép BYOK.
- Hỗ trợ đa ngôn ngữ, hướng đối tượng người dùng toàn cầu (không chỉ VN).

**Ngoài phạm vi bản thiết kế này**: màn hình Search/History (icon, layout
danh sách tìm kiếm gần đây) — chưa chốt UI, cần thiết kế tiếp ở phase sau.

> **Cập nhật 2026-08-04**: Search/History đã được triển khai dưới dạng UI
> đơn giản, chức năng (text search + danh sách gần đây) theo xác nhận của
> chủ dự án — xem `CLAUDE.md` mục "Quyết định đã chốt".

> **Cập nhật 2026-08-04 (đợt 2) — KIẾN TRÚC ĐÃ ĐỔI: không còn backend.**
> Toàn bộ nội dung §3 (kiến trúc) và phần "BYOK qua backend" ở §7.2 bên
> dưới mô tả bản thiết kế GỐC (có backend FastAPI) — đã bị thay thế. Kiến
> trúc thực tế hiện tại: app Flutter gọi thẳng mọi provider (Places,
> Weather, Tavily, LLM) bằng key người dùng tự nhập, cache bằng SQLite cục
> bộ trên máy (`sqflite`), không có server nào cả. Chi tiết đầy đủ + lý do
> đổi hướng xem `CLAUDE.md` mục "Quyết định đã chốt → 2026-08-04 (đợt 2)".
> Phần còn lại của tài liệu này (data model §4, node-graph UI §6, palette
> §9) vẫn đúng nguyên vẹn — chỉ có "ai gọi API" và "cache ở đâu" là đổi.

---

## 2. Tech stack

| Layer | Công nghệ |
|---|---|
| Mobile app | Flutter |
| Backend | Python / FastAPI |
| Cache / local storage | SQLite (backend cache) + `flutter_secure_storage` (API key trên client) |
| LLM (mặc định) | Google Gemini Flash (free tier, 1,500 req/ngày) |
| LLM (BYOK) | Gemini / Groq / OpenRouter / OpenAI — người dùng tự cấu hình |
| Địa điểm gần | Google Places API (Nearby Search) |
| Thời tiết | OpenWeatherMap hoặc WeatherAPI |
| Web search (cho tóm tắt LLM) | Tavily API (đã chốt 2026-08-04) |
| Hạ tầng | Self-hosted (theo pattern hiện tại của dự án khác), Docker |
| Localization | `flutter_localizations` + ARB files (UI); ngôn ngữ nội dung xử lý ở backend prompt |

> Lưu ý chi phí: free tier của các provider LLM/search thay đổi thường
> xuyên — kiểm tra lại giới hạn thực tế trước khi launch, đừng hardcode giả
> định về quota.

---

## 3. Kiến trúc tổng quan

```
[Flutter App]
     |
     |  1. User nhập địa điểm → geocode (lat/lng)
     v
[FastAPI Backend]
     |
     |  2. Check cache theo location_id
     |     - cache hit & còn hạn -> trả ngay (bước 6)
     |     - cache miss/hết hạn -> tiếp tục
     v
  [Song song gọi các nguồn]
     ├── Google Places API      -> địa điểm gần (structured, KHÔNG qua LLM)
     ├── Weather API             -> thời tiết (structured, KHÔNG qua LLM)
     ├── Timezone (tính từ toạ độ, offline) -> múi giờ (structured, KHÔNG qua LLM)
     └── Web search (nhiều query) -> đặc sản / an toàn / chi phí / văn hoá / v.v.
     |
     |  3. Đưa kết quả search thô vào LLM aggregator
     |     (chỉ áp dụng cho các mục dạng text tự do, xem mục 5)
     v
  [LLM Aggregator]
     |  4. Chuẩn hoá thành JSON theo schema cố định (mục 5)
     v
  [Cache layer - SQLite]
     |  5. Lưu cache theo location_id, TTL riêng theo từng mục
     v
[FastAPI Backend] --6. trả JSON--> [Flutter App] --> render node-graph
```

**Nguyên tắc quan trọng**: không phải mọi mục đều cần LLM.
- Đã có API structured (Places, Weather) → parse trực tiếp, KHÔNG qua LLM.
- Múi giờ tính trực tiếp từ toạ độ (thư viện `timezonefinder`, không gọi
  API ngoài) → KHÔNG qua LLM.
- Không có API chuẩn (đặc sản, an toàn, chi phí, văn hoá, v.v.) → web search
  + LLM tóm tắt thành text ngắn gọn, đồng nhất format.

---

## 4. Data model — nhóm thông tin (2-tier)

Cấu trúc dữ liệu map trực tiếp sang JSON response và sang node-graph UI.

```
Location
 └── Groups[] (5 nhóm)
      ├── explore              "Khám phá"
      │    ├── places          Địa điểm gần (≤15km)     [API - Places]
      │    ├── food             Đặc sản                  [LLM]
      │    └── best_time        Thời điểm đẹp nhất        [LLM]
      ├── practical             "Thực dụng"
      │    ├── weather          Thời tiết                 [API - Weather]
      │    ├── transport        Di chuyển                 [LLM]
      │    ├── power             Điện & Sim (điện áp, ổ cắm, eSIM) [LLM]
      │    ├── currency          Tiền tệ & Thanh toán      [LLM]
      │    └── timezone          Múi giờ                   [Tính từ toạ độ, offline]
      ├── safety                "An toàn & Sức khỏe"
      │    ├── safety_level      An toàn                   [LLM]
      │    ├── health            Y tế (bệnh viện gần nhất) [API Places + LLM]
      │    ├── water             Nước uống                 [LLM]
      │    ├── insurance         Bảo hiểm du lịch           [LLM]
      │    └── emergency         Số khẩn cấp               [Bảng tra cứu tĩnh theo quốc gia — KHÔNG qua LLM]
      ├── culture                "Văn hóa"
      │    ├── language          Ngôn ngữ                   [LLM]
      │    ├── etiquette         Quy tắc ứng xử             [LLM]
      │    ├── tipping           Văn hóa tip                [LLM]
      │    └── holidays          Ngày lễ địa phương         [LLM]
      └── entry_stay              "Nhập cảnh & Lưu trú"
           ├── visa               Visa                      [LLM, luôn kèm cảnh báo "kiểm tra nguồn chính thức"]
           ├── airport             Sân bay gần nhất           [API Places]
           ├── stay                Lưu trú                    [LLM]
           └── cost                Chi phí sinh hoạt          [LLM]
```

**JSON response schema (rút gọn)** — xem `backend/app/models/location.py` cho
định nghĩa Pydantic đầy đủ.

```json
{
  "location": {
    "id": "string",
    "name": "Đà Lạt, Việt Nam",
    "lat": 11.9404,
    "lng": 108.4583
  },
  "cached_at": "ISO8601",
  "groups": [
    {
      "id": "practical",
      "label": "Thực dụng",
      "children": [
        {
          "id": "weather",
          "label": "Thời tiết",
          "source": "api",
          "summary": "18°C, se lạnh, sương mù sáng",
          "detail": "...",
          "sources": ["https://..."],
          "updated_at": "ISO8601"
        }
      ]
    }
  ]
}
```

> `source: "api" | "llm" | "static" | "search"` để Flutter biết hiển thị
> badge nguồn nào (yêu cầu minh bạch, xem mục 7). `search` = kết quả tìm
> kiếm thô khi người dùng tắt LLM.

---

## 5. Cache strategy

| Loại dữ liệu | TTL gợi ý |
|---|---|
| Thời tiết | 3 giờ |
| Địa điểm gần, sân bay | 30 ngày |
| Đặc sản, văn hóa, ngôn ngữ, ứng xử, múi giờ | 90 ngày (ít đổi) |
| An toàn, visa, y tế, chi phí sinh hoạt | 14 ngày (cần mới hơn) |
| Số khẩn cấp | Không cache theo TTL — dùng bảng tĩnh theo quốc gia, cập nhật thủ công |

Cache key: `location_id` (geocode chuẩn hoá, làm tròn toạ độ 3 chữ số thập
phân để gộp các lần tra cứu gần giống nhau về cùng 1 cache entry).

User có thể **"Làm mới"** thủ công 1 mục hoặc toàn bộ location (bỏ qua
cache, force refetch) — xem mục Settings.

---

## 6. UI Spec — Node Graph (2-tier)

- **Tier 1**: node trung tâm = địa điểm đang xem. 5 node vòng ngoài = 5
  nhóm (`explore`, `practical`, `safety`, `culture`, `entry_stay`).
- **Tier 2**: tap vào 1 nhóm → nhóm đó trở thành tâm mới, ring hiển thị các
  node con (detail). Có breadcrumb + nút back quay lại tier 1.
- Tap vào node con → panel chi tiết trượt lên bên dưới graph (summary +
  detail text + nguồn nếu có).
- **Ambient animation** (chuyển động ngay cả khi không tương tác): node
  trôi nhẹ (float), center node có breathing glow + ping ring lan toả,
  đường nối có pulse. Tất cả tắt khi `prefers-reduced-motion` hoặc setting
  "giảm chuyển động" bật.

Triển khai Flutter (`mobile/lib/widgets/node_graph/`):
- Vị trí node tính bằng lượng giác — `ring_layout.dart`.
- Animation lặp vô hạn dùng một `AnimationController` dùng chung (
  `.repeat()`), không dùng package ngoài.
- Icon set: dùng Material Icons qua bảng ánh xạ tập trung
  (`graph_icons.dart`) thay cho `lucide_icons`/`flutter_lucide` — môi
  trường build này không thể xác minh version package trên pub.dev, xem
  `mobile/README.md` mục "Icon set note".

---

## 7. Settings Spec

### 7.1 Ngôn ngữ & đơn vị

| Setting | Giá trị mặc định | Ghi chú |
|---|---|---|
| Ngôn ngữ UI | Theo ngôn ngữ máy lúc cài; fallback English nếu không hỗ trợ | Lưu override nếu user đổi thủ công, không tự đổi lại theo hệ thống sau đó |
| Ngôn ngữ nội dung (kết quả LLM) | Theo ngôn ngữ UI | Tách riêng — cho phép user chọn khác UI (vd: đọc nội dung bằng tiếng Anh) |
| Đơn vị khoảng cách | km hoặc miles | Tách khỏi ngôn ngữ (không suy ra tự động từ locale) |
| Đơn vị nhiệt độ | °C hoặc °F | Tương tự |
| Định dạng tiền tệ | Theo lựa chọn, không phụ thuộc ngôn ngữ | |

### 7.2 Trợ lý AI (LLM)

| Setting | Giá trị | Ghi chú |
|---|---|---|
| `llm_enabled` | bật/tắt | Tắt → chỉ hiển thị kết quả search thô, không gọi LLM |
| `provider_mode` | `free` \| `byok` | Radio, loại trừ lẫn nhau |
| Free tier | Gemini Flash, key của app | Hiển thị `usage_today/limit`, giờ reset. Cảnh báo khi ≥80% |
| BYOK | provider dropdown + API key (secure storage) | Không giới hạn, user tự chịu chi phí. Key **không** lưu ở server của app |
| `fallback_enabled` | bật/tắt | Chỉ hiện trong nhánh BYOK — khi provider của user bị rate-limit, tự động chuyển sang free tier của app cho lượt đó |
| `detail_level` | `short` \| `detailed` | Ảnh hưởng độ dài prompt/token usage |
| `show_sources` | bật/tắt | Hiện link nguồn LLM dựa vào, tăng độ tin cậy |
| Disclaimer tĩnh | luôn hiển thị | "Nội dung do AI tổng hợp, có thể không chính xác — kiểm tra nguồn chính thức với visa/y tế/an toàn" |

### 7.3 Dữ liệu & quyền riêng tư

- Xem dung lượng cache, nút xóa cache.
- Lịch sử địa điểm đã tra cứu + nút xóa lịch sử.
- Toggle quyền vị trí (GPS) — giải thích rõ dùng để tính bán kính 15km.
- Toggle "giảm chuyển động" (map với setting hệ thống, cho override).
- Cỡ chữ.

---

## 8. Non-functional requirements

- **Minh bạch dữ liệu**: mọi mục có nguồn `llm` phải hiển thị được
  "cập nhật lần cuối" + tuỳ chọn xem nguồn gốc.
- **Độ chính xác cao với dữ liệu rủi ro**: số khẩn cấp dùng bảng tra cứu
  tĩnh (không qua LLM). Visa luôn qua LLM nhưng kèm cảnh báo kiểm tra lại
  bắt buộc.
- **Chi phí vận hành**: cache-first, LLM chỉ gọi khi cache miss; free-tier
  mặc định có rate-limit theo thiết bị/người dùng để tránh vượt quota của
  chủ app.
- **Accessibility**: tôn trọng `prefers-reduced-motion`, hỗ trợ cỡ chữ lớn,
  contrast đủ trên nền tối.
- **Bảo mật**: API key BYOK lưu `flutter_secure_storage`, không log, không
  gửi lên analytics/server backend của app (chỉ đi qua trong 1 request LLM
  rồi bị bỏ, không bao giờ ghi xuống DB).

---

## 9. Design references

Palette chuẩn (tái sử dụng cho toàn app):
- Nền: `#0A141D` → `#16283A` (radial gradient navy)
- Accent chính: `#E8A33D` (amber)
- Card/node nền: `#1B2E3D` / `#142330`
- Text chính: `#EDEAE3`, text phụ: `#7FA8C9` / `#9FB6C6`
- Font: display = Fraunces (serif), body = Inter

---

## 10. Trạng thái triển khai (2026-08-04)

Toàn bộ backend + mobile app đã được triển khai lần đầu — xem
`CLAUDE.md` mục "Quyết định đã chốt" và README ở `backend/` / `mobile/`
cho chi tiết vận hành. Các điểm còn cần làm tiếp:

- Kết nối thật với API keys (Google Places/Geocoding, OpenWeatherMap,
  Tavily, Gemini) và test trên thiết bị thật — chưa có key nào được cấu
  hình trong môi trường build này.
- Chạy `flutter create .` trong `mobile/` để sinh các thư mục nền tảng
  (android/ios/web/...) — môi trường build này không có Flutter SDK.
- Bảng số khẩn cấp (`backend/data/emergency_numbers.json`) mới phủ ~40
  quốc gia phổ biến; mở rộng dần khi cần.
- UI Search/History hiện ở mức tối giản, chức năng — có thể thiết kế lại
  đẹp hơn ở phase sau nếu cần.
