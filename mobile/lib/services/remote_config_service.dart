import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Optional app-owned defaults for the 3 provider keys (Weather/Tavily/Groq),
/// sourced from Firebase Remote Config (CLAUDE.md "Quyết định đã chốt
/// 2026-08-06 (đợt 8)"). This is NOT a BYOK key — the project owner sets
/// these once in the Firebase console so the app works out of the box.
///
/// A user-entered BYOK key (flutter_secure_storage) always wins when present
/// — see `AppSettings.buildRequestSettings`. This service only fills the gap
/// when the user hasn't entered their own key.
///
/// Firebase is optional, best-effort infrastructure here, not a hard
/// dependency: if `android/app/google-services.json` wasn't injected at
/// build time (see `.github/workflows/build-apk.yml`), or the device has no
/// network on first launch, every getter below just returns null and the app
/// behaves exactly like pure BYOK — never let a Firebase failure crash the
/// app or block startup.
///
/// `Firebase.initializeApp()` doesn't reliably fail fast when there's no
/// working platform channel underneath it (observed: it can hang forever
/// instead of throwing, e.g. in a plain `flutter test` run with no Firebase
/// plugin registered) — every step below is wrapped in `.timeout(...)` so a
/// stuck platform call can never hang app startup, only fall back to no-op.
class RemoteConfigService {
  static const _initTimeout = Duration(seconds: 8);

  final FirebaseRemoteConfig? _remoteConfig;

  RemoteConfigService._(this._remoteConfig);

  /// A no-op instance that never touches Firebase — every getter returns
  /// null, same end state as a failed `Firebase.initializeApp()`. Use this
  /// in tests instead of `create()`: the real Firebase plugin has no native
  /// responder under `flutter test`, and unlike a normal MethodChannel it
  /// doesn't fail fast in that situation — it can leave its Future pending
  /// forever inside a `testWidgets` zone, which no `.timeout()` on our side
  /// can preempt (the underlying platform call never yields). That's a
  /// `flutter_test`-harness artifact, not a real-device risk — a real
  /// device's native side always responds.
  factory RemoteConfigService.disabled() => RemoteConfigService._(null);

  static Future<RemoteConfigService> create() async {
    try {
      await Firebase.initializeApp().timeout(_initTimeout);
      final rc = FirebaseRemoteConfig.instance;
      await rc.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      )).timeout(_initTimeout);
      await rc.setDefaults(const {
        'weather_api_key': '',
        'tavily_api_key': '',
        'groq_api_key': '',
      }).timeout(_initTimeout);
      try {
        await rc.fetchAndActivate().timeout(const Duration(seconds: 10));
      } catch (_) {
        // No network / fetch failed on first launch — keep whatever is
        // already cached from a previous fetch (or the empty defaults).
      }
      return RemoteConfigService._(rc);
    } catch (_) {
      return RemoteConfigService._(null);
    }
  }

  String? get weatherApiKey => _nonEmpty(_remoteConfig?.getString('weather_api_key'));
  String? get tavilyApiKey => _nonEmpty(_remoteConfig?.getString('tavily_api_key'));
  String? get groqApiKey => _nonEmpty(_remoteConfig?.getString('groq_api_key'));

  String? _nonEmpty(String? value) => (value == null || value.trim().isEmpty) ? null : value;
}
