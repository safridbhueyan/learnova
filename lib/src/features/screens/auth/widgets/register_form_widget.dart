import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/auth_provider.dart';
import 'google_sign_in_button_widget.dart';

class RegisterFormWidget extends ConsumerStatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  ConsumerState<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends ConsumerState<RegisterFormWidget> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                ref.read(authProvider.notifier).showLoginMode();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_rounded, size: 18.sp, color: AppColor.primary),
                    4.horizontalSpace,
                    Text(
                      "Back to Sign In",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        14.verticalSpace,
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
        Text("Full Name", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: nameController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: InputDecoration(
            hintText: "Enter your full name (e.g. Safrid Bhueyan)",
            hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.person_outline_rounded, size: 20, color: AppColor.primary),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
          ),
        ),
        12.verticalSpace,
        Text("Email Address", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: InputDecoration(
            hintText: "University email (e.g. student@uits.edu.bd)",
            hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.email_outlined, size: 20, color: AppColor.primary),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
          ),
        ),
        12.verticalSpace,
        Text("Create Password", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: passwordController,
          obscureText: !authState.isRegisterPasswordVisible,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: InputDecoration(
            hintText: "Create a secure password",
            hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: AppColor.primary),
            suffixIcon: IconButton(
              icon: Icon(
                authState.isRegisterPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColor.textSecondary,
                size: 20.sp,
              ),
              onPressed: () {
                ref.read(authProvider.notifier).toggleRegisterPasswordVisibility();
              },
            ),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
          ),
        ),
        12.verticalSpace,
        Text("Confirm Password", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: confirmPasswordController,
          obscureText: !authState.isRegisterConfirmPasswordVisible,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: InputDecoration(
            hintText: "Re-enter your password",
            hintStyle: TextStyle(fontSize: 12.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.lock_reset_rounded, size: 20, color: AppColor.primary),
            suffixIcon: IconButton(
              icon: Icon(
                authState.isRegisterConfirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColor.textSecondary,
                size: 20.sp,
              ),
              onPressed: () {
                ref.read(authProvider.notifier).toggleRegisterConfirmPasswordVisibility();
              },
            ),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
          ),
        ),
        18.verticalSpace,
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
                    ref.read(authProvider.notifier).register(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
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
                        "Create Account",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, letterSpacing: 0.2),
                      ),
                      8.horizontalSpace,
                      Icon(Icons.check_circle_outline_rounded, size: 18.sp),
                    ],
                  ),
          ),
        ),
        18.verticalSpace,
        Row(
          children: [
            const Expanded(child: Divider(color: AppColor.divider)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "OR SIGNUP WITH",
                style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted, fontWeight: FontWeight.w700, letterSpacing: 0.5),
              ),
            ),
            const Expanded(child: Divider(color: AppColor.divider)),
          ],
        ),
        16.verticalSpace,
        const GoogleSignInButtonWidget(),
      ],
    );
  }
}
