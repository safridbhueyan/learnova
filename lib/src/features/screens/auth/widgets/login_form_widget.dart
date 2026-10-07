import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/auth_provider.dart';

class LoginFormWidget extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController(text: "safrid.student@university.edu");
  final TextEditingController passwordController = TextEditingController(text: "password123");

  LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Student University Email",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        TextField(
          controller: emailController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(
            hintText: "e.g. student@uits.edu.bd",
            prefixIcon: Icon(Icons.email_outlined, color: AppColor.textMuted, size: 20),
          ),
        ),
        14.verticalSpace,
        Text(
          "Password",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        TextField(
          controller: passwordController,
          obscureText: true,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(
            hintText: "••••••••",
            prefixIcon: Icon(Icons.lock_outline, color: AppColor.textMuted, size: 20),
          ),
        ),
        12.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Forgot password?",
              style: TextStyle(fontSize: 12.sp, color: AppColor.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        16.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              elevation: 0,
            ),
            onPressed: authState.isLoading
                ? null
                : () {
                    ref.read(authProvider.notifier).login(
                          emailController.text.trim(),
                          passwordController.text,
                        );
                  },
            child: authState.isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(color: AppColor.textOnPrimary, strokeWidth: 2),
                  )
                : Text(
                    "Sign In to Learnova",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                  ),
          ),
        ),
      ],
    );
  }
}
