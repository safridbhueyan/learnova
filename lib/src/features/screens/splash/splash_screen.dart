import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../auth/auth_screen.dart';
import 'provider/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashState = ref.watch(splashProvider);

    if (splashState.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const AuthScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // Ambient background decoration
          Positioned(
            top: -60.h,
            right: -60.w,
            child: Container(
              width: 220.r,
              height: 220.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primarySubtle.withValues(alpha: 0.5),
              ),
            ),
          ),
          Positioned(
            bottom: -40.h,
            left: -40.w,
            child: Container(
              width: 180.r,
              height: 180.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.accentLight.withValues(alpha: 0.6),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Animated Learnova Logo Hero
                    ScaleFadeEntrance(
                      delay: Duration.zero,
                      duration: const Duration(milliseconds: 700),
                      startScale: 0.8,
                      child: SizedBox(
                        height: 110.h,
                        child: Image.asset(
                          'assets/images/learnova_logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.rocket_launch_rounded, color: AppColor.accent, size: 42.r),
                                12.horizontalSpace,
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Learn",
                                        style: TextStyle(
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppColor.primary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "ova",
                                        style: TextStyle(
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w900,
                                          color: AppColor.accent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    ScaleFadeEntrance(
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        "AI-Powered Career Guidance &\nSkill Development Engine",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ),
                    36.verticalSpace,
                    // Status Loading Indicator
                    ScaleFadeEntrance(
                      delay: const Duration(milliseconds: 400),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 32.r,
                            height: 32.r,
                            child: const CircularProgressIndicator(
                              color: AppColor.primary,
                              strokeWidth: 3,
                            ),
                          ),
                          16.verticalSpace,
                          Text(
                            splashState.statusMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    Text(
                      "v1.0.0 • Learnova Engine",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColor.textMuted.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
