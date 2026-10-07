import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class AuthHeaderWidget extends StatelessWidget {
  final bool isLogin;

  const AuthHeaderWidget({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return ScaleFadeEntrance(
      delay: Duration.zero,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            constraints: BoxConstraints(maxHeight: 90.h, maxWidth: 300.w),
            child: Image.asset(
              'assets/images/learnova_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: const BoxDecoration(
                        color: AppColor.primarySubtle,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.rocket_launch_rounded,
                        color: AppColor.accent,
                        size: 28.r,
                      ),
                    ),
                    10.horizontalSpace,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Learn",
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColor.primary,
                            ),
                          ),
                          TextSpan(
                            text: "ova",
                            style: TextStyle(
                              fontSize: 26.sp,
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
          12.verticalSpace,
          Text(
            isLogin
                ? "Welcome back! Sign in to continue your career grooming."
                : "Begin your AI-powered career readiness journey today.",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.textSecondary,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
