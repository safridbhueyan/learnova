import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/onboarding_provider.dart';

class StepInterestsWidget extends ConsumerWidget {
  const StepInterestsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);

    final options = [
      "Mobile Development",
      "Artificial Intelligence",
      "Machine Learning",
      "Full-Stack Web",
      "UI/UX Design",
      "Cybersecurity",
      "Cloud & DevOps",
      "Competitive Programming",
      "Data Science",
      "Software Testing",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 2: Technology Interests",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        Text(
          "Select the career domains you feel most passionate about.",
          style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary),
        ),
        20.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 10.h,
          children: options.map((interest) {
            final isSelected = onboarding.selectedInterests.contains(interest);

            return FilterChip(
              selected: isSelected,
              showCheckmark: false,
              selectedColor: AppColor.primary,
              backgroundColor: AppColor.cardBg,
              side: BorderSide(
                color: isSelected ? AppColor.primary : AppColor.cardBorder,
                width: 1,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              label: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Text(
                  interest,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? AppColor.textOnPrimary : AppColor.textPrimary,
                  ),
                ),
              ),
              onSelected: (val) {
                ref.read(onboardingProvider.notifier).toggleInterest(interest);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
