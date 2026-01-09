import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/app_localizations.dart';
import 'core/core.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'router/app_router.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<WeatherBloc>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (_) => sl<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp.router(
                    title: 'Weather Gravity',
                    debugShowCheckedModeBanner: false,
                    locale: locale,
                    theme: themeData,
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [Locale('en'), Locale('hi'), Locale('ar')],
                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
