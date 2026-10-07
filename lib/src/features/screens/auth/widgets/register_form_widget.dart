import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/auth_provider.dart';

class RegisterFormWidget extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController uniController = TextEditingController(text: "UITS");
  final TextEditingController deptController = TextEditingController(text: "CSE");
  final TextEditingController semController = TextEditingController(text: "7th Semester");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Full Name", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: nameController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(hintText: "e.g. Safrid Bhueyan", prefixIcon: Icon(Icons.person_outline, size: 20)),
        ),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("University", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
                  6.verticalSpace,
                  TextField(
                    controller: uniController,
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                    decoration: const InputDecoration(hintText: "UITS"),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Department", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
                  6.verticalSpace,
                  TextField(
                    controller: deptController,
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                    decoration: const InputDecoration(hintText: "CSE"),
                  ),
                ],
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Text("Academic Semester", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: semController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(hintText: "e.g. 7th Semester"),
        ),
        12.verticalSpace,
        Text("Email Address", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: emailController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(hintText: "student@university.edu", prefixIcon: Icon(Icons.email_outlined, size: 20)),
        ),
        12.verticalSpace,
        Text("Create Password", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: passwordController,
          obscureText: true,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(hintText: "••••••••", prefixIcon: Icon(Icons.lock_outline, size: 20)),
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
                    ref.read(authProvider.notifier).register(
                          name: nameController.text,
                          university: uniController.text,
                          department: deptController.text,
                          semester: semController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  },
            child: authState.isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(color: AppColor.textOnPrimary, strokeWidth: 2),
                  )
                : Text(
                    "Create Student Profile",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                  ),
          ),
        ),
      ],
    );
  }
}
