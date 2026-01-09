import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageInterceptor extends Interceptor {
  final SharedPreferences sharedPreferences;

  LanguageInterceptor(this.sharedPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('api.openweathermap.org')) {
      final String? langCode = sharedPreferences.getString('selected_locale');
      if (langCode != null) {
        options.queryParameters['lang'] = langCode;
      }
    }
    super.onRequest(options, handler);
  }
}
