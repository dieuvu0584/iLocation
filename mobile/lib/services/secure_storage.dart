import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Used ONLY for the BYOK LLM API key (CLAUDE.md: "chỉ dùng cho API key BYOK,
/// không dùng cho gì khác"). Everything else lives in SettingsService.
class SecureStorageService {
  static const _byokKeyStorageKey = 'byok_api_key';

  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> readByokApiKey() => _storage.read(key: _byokKeyStorageKey);

  Future<void> writeByokApiKey(String apiKey) => _storage.write(key: _byokKeyStorageKey, value: apiKey);

  Future<void> deleteByokApiKey() => _storage.delete(key: _byokKeyStorageKey);
}
