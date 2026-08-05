// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'ค้นหาสถานที่ เมือง หรือที่อยู่';

  @override
  String get searchButton => 'ค้นหา';

  @override
  String get searchRecent => 'ล่าสุด';

  @override
  String get searchTryDemo => 'ลองใช้เดโม (ดาลัต)';

  @override
  String get searchNoResults => 'ไม่พบผลลัพธ์ที่ตรงกัน ลองค้นหาด้วยคำอื่น';

  @override
  String get searchError =>
      'เกิดข้อผิดพลาด ตรวจสอบการเชื่อมต่อของคุณหรือลองใช้เดโม';

  @override
  String get searchChooseMatch => 'เลือกสถานที่';

  @override
  String get graphBack => 'กลับ';

  @override
  String get graphSettings => 'การตั้งค่า';

  @override
  String get graphHistory => 'ประวัติ';

  @override
  String get graphRefresh => 'รีเฟรช';

  @override
  String get graphRefreshAll => 'รีเฟรชทั้งหมด';

  @override
  String get graphLoading => 'กำลังรวบรวมข้อมูล…';

  @override
  String get graphError => 'ไม่สามารถโหลดสถานที่นี้ได้';

  @override
  String get graphRetry => 'ลองอีกครั้ง';

  @override
  String get detailSourceLlm => 'สรุปโดย AI';

  @override
  String get detailSourceApi => 'ข้อมูลสด';

  @override
  String get detailSourceStatic => 'ข้อมูลอ้างอิง';

  @override
  String get detailSourceSearch => 'ผลการค้นหาดิบ';

  @override
  String get detailSourceMissingKey => 'ต้องใช้คีย์ API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'อัปเดตเมื่อ $date';
  }

  @override
  String get detailStale => 'กำลังแสดงข้อมูลแคชเก่า — การรีเฟรชล้มเหลว';

  @override
  String get detailSources => 'แหล่งที่มา';

  @override
  String get detailNoData => 'ยังไม่มีข้อมูล';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get settingsLanguageUnits => 'ภาษาและหน่วย';

  @override
  String get settingsLanguageUnitsDesc =>
      'ภาษาของแอป ภาษาเนื้อหา หน่วยระยะทาง/อุณหภูมิ';

  @override
  String get settingsApiKeys => 'คีย์ API';

  @override
  String get settingsApiKeysDesc =>
      'สภาพอากาศและการค้นหา — สถานที่/การหาพิกัดไม่ต้องใช้คีย์';

  @override
  String get settingsAiAssistant => 'ผู้ช่วย AI';

  @override
  String get settingsAiAssistantDesc =>
      'คีย์ API LLM ของคุณเอง ระดับรายละเอียด แหล่งที่มา';

  @override
  String get settingsDataPrivacy => 'ข้อมูลและความเป็นส่วนตัว';

  @override
  String get settingsDataPrivacyDesc =>
      'แคช ประวัติ สิทธิ์การเข้าถึงตำแหน่ง การเคลื่อนไหว ขนาดตัวอักษร';

  @override
  String get languageSettingsTitle => 'ภาษาและหน่วย';

  @override
  String get uiLanguage => 'ภาษาของแอป';

  @override
  String get contentLanguage => 'ภาษาเนื้อหา';

  @override
  String get contentLanguageDesc =>
      'ภาษาที่ใช้สำหรับเนื้อหาที่สรุปโดย AI — อาจแตกต่างจากภาษาของแอป';

  @override
  String get distanceUnit => 'หน่วยระยะทาง';

  @override
  String get temperatureUnit => 'หน่วยอุณหภูมิ';

  @override
  String get currencyFormat => 'รูปแบบสกุลเงิน';

  @override
  String get km => 'กิโลเมตร';

  @override
  String get miles => 'ไมล์';

  @override
  String get celsius => 'เซลเซียส (°C)';

  @override
  String get fahrenheit => 'ฟาเรนไฮต์ (°F)';

  @override
  String get systemDefault => 'ค่าเริ่มต้นของระบบ';

  @override
  String get apiKeysTitle => 'คีย์ API';

  @override
  String get placesNoKeyNote =>
      'การค้นหา สถานที่ใกล้เคียง และสนามบินที่ใกล้ที่สุดทำงานบน OpenStreetMap (Nominatim + Overpass) — ฟรี ไม่ต้องใช้คีย์ API';

  @override
  String get weatherApiKeyLabel => 'คีย์ API ของ OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'จำเป็นสำหรับสภาพอากาศปัจจุบัน';

  @override
  String get searchApiKeyLabel => 'คีย์ API การค้นหา Tavily (ไม่บังคับ)';

  @override
  String get searchApiKeyDesc =>
      'ใช้ผลการค้นหาจริงเป็นพื้นฐานสำหรับคำตอบที่สรุปโดย AI หากไม่มี AI จะตอบจากความรู้ทั่วไปเท่านั้น';

  @override
  String get llmSettingsTitle => 'ผู้ช่วย AI';

  @override
  String get llmEnabled => 'เปิดใช้งานการสรุปโดย AI';

  @override
  String get llmEnabledDesc =>
      'เมื่อปิดใช้งาน รายการเหล่านั้นจะว่างเปล่าแทนที่จะเรียกใช้ LLM';

  @override
  String get byokProviderLabel => 'ผู้ให้บริการ';

  @override
  String get byokApiKey => 'คีย์ API';

  @override
  String get byokApiKeyHint => 'จัดเก็บอย่างปลอดภัยบนอุปกรณ์นี้เท่านั้น';

  @override
  String get detailLevel => 'ระดับรายละเอียด';

  @override
  String get detailLevelShort => 'สั้น';

  @override
  String get detailLevelDetailed => 'ละเอียด';

  @override
  String get showSources => 'แสดงแหล่งที่มา';

  @override
  String get showSourcesDesc => 'แสดงลิงก์ที่ใช้เป็นพื้นฐานของบทสรุป AI';

  @override
  String get llmDisclaimer =>
      'เนื้อหาที่ทำเครื่องหมายว่า \"สรุปโดย AI\" อาจไม่ถูกต้อง โปรดตรวจสอบข้อมูลวีซ่า สุขภาพ และความปลอดภัยกับแหล่งที่มาที่เป็นทางการเสมอ';

  @override
  String get privacySettingsTitle => 'ข้อมูลและความเป็นส่วนตัว';

  @override
  String get cacheSize => 'ขนาดแคช';

  @override
  String get clearCache => 'ล้างแคช';

  @override
  String get clearCacheConfirm =>
      'การดำเนินการนี้จะลบข้อมูลสถานที่ที่แคชไว้ทั้งหมด ดำเนินการต่อหรือไม่';

  @override
  String get locationHistory => 'ประวัติสถานที่';

  @override
  String get clearHistory => 'ล้างประวัติ';

  @override
  String get clearHistoryConfirm =>
      'การดำเนินการนี้จะลบประวัติการค้นหาของคุณ ดำเนินการต่อหรือไม่';

  @override
  String get gpsPermission => 'ใช้ตำแหน่งของฉัน';

  @override
  String get gpsPermissionDesc =>
      'ใช้เพื่อค้นหาสถานที่ในรัศมี 15 กม. จากคุณ คุณสามารถค้นหาด้วยตนเองแทนได้เสมอ';

  @override
  String get reducedMotion => 'ลดการเคลื่อนไหว';

  @override
  String get reducedMotionDesc => 'ปิดแอนิเมชันพื้นหลังในกราฟโหนด';

  @override
  String get fontSize => 'ขนาดตัวอักษร';

  @override
  String get historyTitle => 'ประวัติ';

  @override
  String get historyEmpty => 'ยังไม่มีการค้นหาสถานที่';

  @override
  String get save => 'บันทึก';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get close => 'ปิด';

  @override
  String get groupExplore => 'สำรวจ';

  @override
  String get groupPractical => 'ข้อมูลที่เป็นประโยชน์';

  @override
  String get groupSafety => 'ความปลอดภัยและสุขภาพ';

  @override
  String get groupCulture => 'วัฒนธรรม';

  @override
  String get groupEntryStay => 'การเข้าประเทศและการพำนัก';
}
