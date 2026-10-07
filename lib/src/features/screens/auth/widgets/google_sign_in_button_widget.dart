import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/auth_provider.dart';

class GoogleSignInButtonWidget extends ConsumerWidget {
  const GoogleSignInButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColor.surface,
          side: BorderSide(color: AppColor.cardBorder, width: 1.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
        onPressed: authState.isLoading
            ? null
            : () {
                ref.read(authProvider.notifier).signInWithGoogle();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Image.asset(
                "assets/images/SignInScreen.png",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: const BoxDecoration(
                      color: AppColor.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.g_mobiledata_rounded,
                      size: 22.sp,
                      color: AppColor.accent,
                    ),
                  );
                },
              ),
            ),
            10.horizontalSpace,
            Text(
              "Continue with Google",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.textPrimary,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
