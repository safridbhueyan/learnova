import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../onboarding_qna/onboarding_qna_screen.dart';
import 'provider/auth_provider.dart';
import 'widgets/auth_header_widget.dart';
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthHeaderWidget(isLogin: authState.isLoginMode),
                24.verticalSpace,
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppColor.cardBg,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColor.cardBorder, width: 1.w),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (!authState.isLoginMode) {
                                  ref.read(authProvider.notifier).toggleAuthMode();
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: authState.isLoginMode ? AppColor.primary : AppColor.chipBackground,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: authState.isLoginMode ? AppColor.textOnPrimary : AppColor.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (authState.isLoginMode) {
                                  ref.read(authProvider.notifier).toggleAuthMode();
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: !authState.isLoginMode ? AppColor.primary : AppColor.chipBackground,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: !authState.isLoginMode ? AppColor.textOnPrimary : AppColor.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      authState.isLoginMode ? LoginFormWidget() : RegisterFormWidget(),
                    ],
                  ),
                ),
                20.verticalSpace,
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "University Career Office & Advisor Portal • ",
                      style: TextStyle(fontSize: 11.sp, color: AppColor.textMuted),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Faculty Access",
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.accent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
