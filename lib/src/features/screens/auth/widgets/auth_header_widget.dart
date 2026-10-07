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
          SizedBox(
            height: 75.h,
            child: Image.asset(
              'assets/images/learnova_logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.rocket_launch_rounded,
                      color: AppColor.accent,
                      size: 32.sp,
                    ),
                    10.horizontalSpace,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Learn",
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColor.primary,
                            ),
                          ),
                          TextSpan(
                            text: "ova",
                            style: TextStyle(
                              fontSize: 28.sp,
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
            isLogin ? "Welcome Back to Learnova" : "Create Your Student Account",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
          ),
          4.verticalSpace,
          Text(
            isLogin
                ? "Sign in to access your personalized AI career roadmap & grade insights."
                : "Empower your academic journey & unlock AI career recommendations.",
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.textSecondary,
              height: 1.35,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
