import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../onboarding_qna/onboarding_qna_screen.dart';
import 'provider/auth_provider.dart';
import 'widgets/auth_header_widget.dart';
import 'widgets/forgot_password_widget.dart';
import 'widgets/login_form_widget.dart';
import 'widgets/register_form_widget.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isAuthenticated && (previous == null || !previous.isAuthenticated)) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingQnaScreen()),
        );
      }
    });

    if (authState.isAuthenticated) {
      return const OnboardingQnaScreen();
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // Background ambient gradient circles
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthHeaderWidget(isLogin: authState.isLoginMode),
                    20.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(22.r),
                      decoration: BoxDecoration(
                        color: AppColor.cardBg,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(color: AppColor.cardBorder, width: 1.w),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColor.shadow,
                            blurRadius: 24,
                            offset: Offset(0, 10),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          if (!authState.isForgotPasswordMode) ...[
                            Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: AppColor.chipBackground,
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (!authState.isLoginMode) {
                                          ref.read(authProvider.notifier).showLoginMode();
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 240),
                                        curve: Curves.easeOutCubic,
                                        padding: EdgeInsets.symmetric(vertical: 11.h),
                                        decoration: BoxDecoration(
                                          color: authState.isLoginMode ? AppColor.primary : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10.r),
                                          boxShadow: authState.isLoginMode
                                              ? const [
                                                  BoxShadow(
                                                    color: AppColor.shadow,
                                                    blurRadius: 8,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Sign In",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: authState.isLoginMode ? AppColor.textOnPrimary : AppColor.textSecondary,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (authState.isLoginMode) {
                                          ref.read(authProvider.notifier).showRegisterMode();
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 240),
                                        curve: Curves.easeOutCubic,
                                        padding: EdgeInsets.symmetric(vertical: 11.h),
                                        decoration: BoxDecoration(
                                          color: !authState.isLoginMode ? AppColor.primary : Colors.transparent,
                                          borderRadius: BorderRadius.circular(10.r),
                                          boxShadow: !authState.isLoginMode
                                              ? const [
                                                  BoxShadow(
                                                    color: AppColor.shadow,
                                                    blurRadius: 8,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: !authState.isLoginMode ? AppColor.textOnPrimary : AppColor.textSecondary,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.verticalSpace,
                          ],
                          CustomAnimatedSwitcher(
                            child: authState.isForgotPasswordMode
                                ? ForgotPasswordWidget(key: const ValueKey("forgot_password"))
                                : authState.isLoginMode
                                    ? LoginFormWidget(key: const ValueKey("login_form"))
                                    : RegisterFormWidget(key: const ValueKey("register_form")),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified_user_rounded, size: 14.sp, color: AppColor.accent),
                        6.horizontalSpace,
                        Text(
                          "University Career Office & Advisor Portal",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColor.textSecondary),
                        ),
                      ],
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
