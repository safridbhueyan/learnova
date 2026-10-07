import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/onboarding_provider.dart';

class StepSkillsWidget extends ConsumerWidget {
  const StepSkillsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);

    final skillOptions = [
      "Dart",
      "Flutter",
      "Firebase",
      "Git & GitHub",
      "Python",
      "C++ / Data Structures",
      "SQL / Database",
      "JavaScript / Node.js",
      "HTML / CSS",
      "REST APIs",
      "Docker",
      "Figma UI",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 3: Existing Skills & Tools",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        Text(
          "Select the languages and tools you have already studied or used in projects.",
          style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary),
        ),
        20.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 10.h,
          children: skillOptions.map((skill) {
            final isSelected = onboarding.selectedSkills.contains(skill);

            return FilterChip(
              selected: isSelected,
              showCheckmark: false,
              selectedColor: AppColor.accent,
              backgroundColor: AppColor.cardBg,
              side: BorderSide(
                color: isSelected ? AppColor.accent : AppColor.cardBorder,
                width: 1,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              label: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColor.textOnPrimary : AppColor.textPrimary,
                  ),
                ),
              ),
              onSelected: (val) {
                ref.read(onboardingProvider.notifier).toggleSkill(skill);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
