import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static const String _themeKey = 'app_theme';
  static const String _themeLight = 'light';
  static const String _themeDark = 'dark';

  final AppThemes _appThemes = AppThemes();

  ThemeCubit() : super(AppThemes().light()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey) ?? _themeLight;

    if (theme == _themeDark) {
      emit(_appThemes.dark());
    } else if (theme == _themeLight) {
      emit(_appThemes.light());
    } else {
      emit(_appThemes.light());
    }
  }

  Future<void> setLightTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeLight);
    emit(_appThemes.light());
  }

  Future<void> setDarkTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeDark);
    emit(_appThemes.dark());
  }


  /// Get current theme mode as string
  String getCurrentThemeMode() {
    return state.brightness == Brightness.dark ? _themeDark : _themeLight;
  }
}
