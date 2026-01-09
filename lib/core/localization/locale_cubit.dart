import '../core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences _prefs;
  static const String _localeKey = 'selected_locale';

  LocaleCubit(this._prefs) : super(_loadInitialLocale(_prefs));

  static Locale _loadInitialLocale(SharedPreferences prefs) {
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return const Locale('en');
  }

  void changeLocale(String languageCode) async {
    await _prefs.setString(_localeKey, languageCode);
    emit(Locale(languageCode));
  }
}
