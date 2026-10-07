import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/onboarding_provider.dart';

class StepAcademicWidget extends ConsumerWidget {
  final TextEditingController uniController = TextEditingController(text: "UITS");
  final TextEditingController deptController = TextEditingController(text: "CSE");
  final TextEditingController semController = TextEditingController(text: "7th Semester");
  final TextEditingController cgpaController = TextEditingController(text: "3.85");

  StepAcademicWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 1: Academic Background",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        Text(
          "Tell us about your university, current semester, and academic standing.",
          style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary),
        ),
        20.verticalSpace,
        Text("University Name", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: uniController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(uni: val),
          decoration: const InputDecoration(hintText: "e.g. UITS"),
        ),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Department", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
                  6.verticalSpace,
                  TextField(
                    controller: deptController,
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                    onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(dept: val),
                    decoration: const InputDecoration(hintText: "CSE"),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Semester", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
                  6.verticalSpace,
                  TextField(
                    controller: semController,
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                    onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(sem: val),
                    decoration: const InputDecoration(hintText: "7th Sem"),
                  ),
                ],
              ),
            ),
          ],
        ),
        12.verticalSpace,
        Text("Current CGPA (0.00 - 4.00)", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: cgpaController,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(cgpaVal: val),
          decoration: const InputDecoration(hintText: "3.85"),
        ),
      ],
    );
  }
}
