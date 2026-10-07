import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/onboarding_provider.dart';

class StepAcademicWidget extends ConsumerStatefulWidget {
  const StepAcademicWidget({super.key});

  @override
  ConsumerState<StepAcademicWidget> createState() => _StepAcademicWidgetState();
}

class _StepAcademicWidgetState extends ConsumerState<StepAcademicWidget> {
  late final TextEditingController uniController;
  late final TextEditingController deptController;
  late final TextEditingController semController;
  late final TextEditingController cgpaController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(onboardingProvider);
    uniController = TextEditingController(text: state.university);
    deptController = TextEditingController(text: state.department);
    semController = TextEditingController(text: state.semester);
    cgpaController = TextEditingController(text: state.cgpa);
  }

  @override
  void dispose() {
    uniController.dispose();
    deptController.dispose();
    semController.dispose();
    cgpaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        Text("University Name", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: uniController,
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(uni: val),
          decoration: InputDecoration(
            hintText: "Enter university name (e.g. UITS)",
            hintStyle: TextStyle(fontSize: 13.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.account_balance_outlined, color: AppColor.primary, size: 20),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
          ),
        ),
        14.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Department", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
                  6.verticalSpace,
                  TextField(
                    controller: deptController,
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                    onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(dept: val),
                    decoration: InputDecoration(
                      hintText: "Department (e.g. CSE)",
                      hintStyle: TextStyle(fontSize: 11.5.sp, color: AppColor.textMuted),
                      prefixIcon: const Icon(Icons.code_rounded, color: AppColor.primary, size: 18),
                      filled: true,
                      fillColor: AppColor.surfaceLight,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Semester", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
                  6.verticalSpace,
                  TextField(
                    controller: semController,
                    style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                    onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(sem: val),
                    decoration: InputDecoration(
                      hintText: "Semester (e.g. 7th Sem)",
                      hintStyle: TextStyle(fontSize: 11.5.sp, color: AppColor.textMuted),
                      prefixIcon: const Icon(Icons.calendar_today_outlined, color: AppColor.primary, size: 18),
                      filled: true,
                      fillColor: AppColor.surfaceLight,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        14.verticalSpace,
        Text("Current CGPA (0.00 - 4.00)", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: AppColor.textPrimary)),
        6.verticalSpace,
        TextField(
          controller: cgpaController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
          onChanged: (val) => ref.read(onboardingProvider.notifier).updateAcademic(cgpaVal: val),
          decoration: InputDecoration(
            hintText: "Current CGPA (e.g. 3.85)",
            hintStyle: TextStyle(fontSize: 13.sp, color: AppColor.textMuted),
            prefixIcon: const Icon(Icons.grade_outlined, color: AppColor.primary, size: 20),
            filled: true,
            fillColor: AppColor.surfaceLight,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.cardBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColor.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }
}
