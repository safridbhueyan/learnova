import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/auth_provider.dart';

class ForgotPasswordWidget extends ConsumerStatefulWidget {
  const ForgotPasswordWidget({super.key});

  @override
  ConsumerState<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends ConsumerState<ForgotPasswordWidget> {
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                ref.read(authProvider.notifier).showLoginMode();
              },
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: Icon(Icons.arrow_back_rounded, size: 20.sp, color: AppColor.textPrimary),
              ),
            ),
            6.horizontalSpace,
            Text(
              "Reset Account Password",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Text(
          "Enter your registered student email below. We will send you a secure link to reset your Learnova password.",
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColor.textSecondary,
            height: 1.4,
          ),
        ),
        16.verticalSpace,
        if (authState.errorMessage != null) ...[
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColor.missingLight,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.missing.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline_rounded, color: AppColor.missing, size: 20.sp),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    authState.errorMessage!,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColor.missing),
                  ),
                ),
              ],
            ),
          ),
          14.verticalSpace,
        ],
        if (authState.successMessage != null) ...[
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColor.masteredLight,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.mastered.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline_rounded, color: AppColor.mastered, size: 20.sp),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    authState.successMessage!,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColor.mastered),
                  ),
                ),
              ],
            ),
          ),
          14.verticalSpace,
        ],
        Text(
          "Student University Email",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: InputDecoration(
            hintText: "e.g. student@university.edu",
            hintStyle: TextStyle(fontSize: 13.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.email_outlined, color: AppColor.primary, size: 20),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColor.cardBorder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColor.primary, width: 1.5),
            ),
          ),
        ),
        20.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.textOnPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
              elevation: 2,
              shadowColor: AppColor.shadow,
            ),
            onPressed: authState.isLoading
                ? null
                : () {
                    ref.read(authProvider.notifier).sendForgotPasswordEmail(
                          emailController.text.trim(),
                        );
                  },
            child: authState.isLoading
                ? SizedBox(
                    width: 22.r,
                    height: 22.r,
                    child: const CircularProgressIndicator(color: AppColor.textOnPrimary, strokeWidth: 2.5),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send Reset Link",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, letterSpacing: 0.2),
                      ),
                      8.horizontalSpace,
                      Icon(Icons.mark_email_read_rounded, size: 18.sp),
                    ],
                  ),
          ),
        ),
        16.verticalSpace,
        Center(
          child: TextButton.icon(
            onPressed: () {
              ref.read(authProvider.notifier).showLoginMode();
            },
            icon: Icon(Icons.arrow_back_rounded, size: 16.sp, color: AppColor.primary),
            label: Text(
              "Back to Sign In",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
            ),
          ),
        ),
      ],
    );
  }
}
