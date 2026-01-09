import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/core.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_list.dart';
import '../widgets/error_view.dart';
import '../../../../injection_container.dart';
import '../../../../router/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();
  bool _isGpsLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  void _fetchCurrentLocationWeather() async {
    setState(() {
      _isGpsLoading = true;
    });
    try {
      final position = await sl<LocationService>().getCurrentPosition();
      if (mounted) {
        context.read<WeatherBloc>().add(
          GetWeatherByLocationEvent(position.latitude, position.longitude),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: SmartText(e.toString(), useLocalization: false)),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGpsLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: SmartAppBar(
        title: l10n.appTitle,
        isBack: false,
        actions: [
          _buildThemeToggle(),
          _buildLanguageToggle(),
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.push(AppRouter.map),
          ),
        ],
      ),
      body: BlocListener<LocaleCubit, Locale>(
        listener: (context, locale) {
          _fetchCurrentLocationWeather();
        },
        child: SmartColumn(
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimens.paddingMedium),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: l10n.searchCityHint,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_cityController.text.isNotEmpty) {
                        context.read<WeatherBloc>().add(
                          GetWeatherByCityEvent(_cityController.text),
                        );
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimens.borderRadiusXLarge,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingXLarge,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    context.read<WeatherBloc>().add(
                      GetWeatherByCityEvent(value),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: _isGpsLoading
                  ? const WeatherLoadingView()
                  : BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherLoading) {
                          return const WeatherLoadingView();
                        } else if (state is WeatherLoaded) {
                          return SmartSingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            onRefresh: () async {
                              _fetchCurrentLocationWeather();
                            },
                            child: SmartColumn(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                    AppDimens.paddingMedium,
                                  ),
                                  child: WeatherCard(weather: state.weather),
                                ),
                                if (state.forecast.isNotEmpty)
                                  ForecastList(forecast: state.forecast),
                              ],
                            ),
                          );
                        } else if (state is WeatherError) {
                          return ErrorView(
                            message: state.message,
                            onRetry: _fetchCurrentLocationWeather,
                          );
                        }
                        return Center(
                          child: SmartText(
                            l10n.searchPlaceholder,
                            useLocalization: false,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, themeData) {
        final l10n = AppLocalizations.of(context)!;
        final isDark = themeData.brightness == Brightness.dark;

        return IconButton(
          icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimens.borderRadiusXXLarge),
                ),
              ),
              builder: (BuildContext bottomSheetContext) {
                return BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (context, currentThemeData) {
                    final currentIsDark =
                        currentThemeData.brightness == Brightness.dark;
                    return Container(
                      padding: EdgeInsets.all(AppDimens.paddingXLarge),
                      child: SmartColumn(
                        children: [
                          SmartText(
                            'Theme',
                            useLocalization: false,
                            style: TextStyle(
                              fontSize: AppDimens.fontSizeXLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: AppDimens.spacingLarge),
                          _buildThemeOption(
                            bottomSheetContext,
                            'light',
                            l10n.themeLight,
                            Icons.light_mode,
                            !currentIsDark,
                          ),
                          SizedBox(height: AppDimens.spacingMedium),
                          _buildThemeOption(
                            bottomSheetContext,
                            'dark',
                            l10n.themeDark,
                            Icons.dark_mode,
                            currentIsDark,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context,
      String themeMode,
      String themeName,
      IconData icon,
      bool isSelected,) {
    final theme = Theme.of(context);
    final themeCubit = context.read<ThemeCubit>();

    return ListTile(
      leading: Icon(icon, color: isSelected ? theme.colorScheme.primary : null),
      title: SmartText(
        themeName,
        useLocalization: false,
        style: TextStyle(
          fontSize: AppDimens.fontSizeLarge,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.textTheme.bodyLarge?.color,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        if (themeMode == 'light') {
          themeCubit.setLightTheme();
        } else if (themeMode == 'dark') {
          themeCubit.setDarkTheme();
        }
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildLanguageToggle() {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final l10n = AppLocalizations.of(context)!;
        return IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimens.borderRadiusXXLarge),
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(AppDimens.paddingXLarge),
                  child: SmartColumn(
                    children: [
                      SmartText(
                        'Language',
                        useLocalization: false,
                        style: TextStyle(
                          fontSize: AppDimens.fontSizeXLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimens.spacingLarge),
                      _buildLanguageOption(
                        context,
                        'en',
                        l10n.languageEnglish,
                        locale.languageCode == 'en',
                      ),
                      SizedBox(height: AppDimens.spacingMedium),
                      _buildLanguageOption(
                        context,
                        'hi',
                        l10n.languageHindi,
                        locale.languageCode == 'hi',
                      ),
                      SizedBox(height: AppDimens.spacingMedium),
                      _buildLanguageOption(
                        context,
                        'ar',
                        l10n.languageArabic,
                        locale.languageCode == 'ar',
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageOption(BuildContext context,
      String languageCode,
      String languageName,
      bool isSelected,) {
    final theme = Theme.of(context);
    return ListTile(
      title: SmartText(
        languageName,
        useLocalization: false,
        style: TextStyle(
          fontSize: AppDimens.fontSizeLarge,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.textTheme.bodyLarge?.color,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        context.read<LocaleCubit>().changeLocale(languageCode);
        Navigator.of(context).pop();
      },
    );
  }
}

class WeatherLoadingView extends StatefulWidget {
  const WeatherLoadingView({super.key});

  @override
  State<WeatherLoadingView> createState() => _WeatherLoadingViewState();
}

class _WeatherLoadingViewState extends State<WeatherLoadingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppDimens.animationDurationMedium),
    )
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: SmartColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _controller,
            child: Icon(
              Icons.wb_sunny_rounded,
              size: AppDimens.iconXLarge,
              color: AppColors.orangeAccent,
            ),
          ),
          SizedBox(height: AppDimens.spacingXLarge),
          SmartText(
            l10n.fetchingWeatherData,
            useLocalization: false,
            style: TextStyle(
              fontSize: AppDimens.fontSizeLarge,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyMedium?.color ?? AppColors.grey600,
            ),
          ),
          SizedBox(height: AppDimens.spacingSmall),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingXLarge * 1.25,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
              child: const LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.orangeAccent,
                ),
                backgroundColor: AppColors.progressBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
