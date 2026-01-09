import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/core.dart';
import '../../../../router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppDimens.animationDurationShort),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Navigate to home after delay
    Future.delayed(const Duration(milliseconds: AppDimens.splashDelay), () {
      if (mounted) {
        context.go(AppRouter.home);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          SmartImage(
            path: 'https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?q=80&w=1080&auto=format&fit=crop',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: AppColors.blueShade900),
            errorWidget: (context, url, error) => Container(color: AppColors.blueShade900),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.textPrimary.withValues(alpha: 0.3),
                  AppColors.textPrimary.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Content
          FadeTransition(
            opacity: _fadeAnimation,
            child: SmartColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wb_sunny_rounded,
                  size: AppDimens.iconXXLarge,
                  color: AppColors.textWhite,
                ),
                SizedBox(height: AppDimens.spacingLarge),
                SmartText(
                  l10n.appName,
                  useLocalization: false,
                  style: TextStyle(
                    fontSize: AppDimens.fontSizeHuge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                    letterSpacing: 4,
                  ),
                ),
                SizedBox(height: AppDimens.spacingMedium),
                SmartText(
                  l10n.appTagline,
                  useLocalization: false,
                  style: TextStyle(
                    fontSize: AppDimens.fontSizeMedium,
                    color: AppColors.textWhite70,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: AppDimens.spacingHuge),
                const SmartCircularProgressIndicator(
                  color: AppColors.textWhite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
