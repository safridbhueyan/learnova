import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/onboarding_provider.dart';

class StepTargetCareerWidget extends ConsumerWidget {
  const StepTargetCareerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarding = ref.watch(onboardingProvider);

    final careerChoices = [
      {"title": "Flutter Developer", "desc": "Cross-Platform Mobile Apps", "icon": Icons.phone_iphone_rounded},
      {"title": "Software Engineer", "desc": "Full-Stack & Systems", "icon": Icons.code_rounded},
      {"title": "AI & ML Engineer", "desc": "Models, NLP & Data Science", "icon": Icons.psychology_rounded},
      {"title": "Frontend Developer", "desc": "Modern Web Platforms", "icon": Icons.web_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 4: Primary Target Career",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
        ),
        6.verticalSpace,
        Text(
          "Select your initial target track. Learnova AI will continuously guide your progress.",
          style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary),
        ),
        16.verticalSpace,
        ...careerChoices.map((c) {
          final title = c["title"] as String;
          final desc = c["desc"] as String;
          final icon = c["icon"] as IconData;
          final isSelected = onboarding.targetCareer == title;

          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: InkWell(
              onTap: () {
                ref.read(onboardingProvider.notifier).selectTargetCareer(title);
              },
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primarySubtle : AppColor.cardBg,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected ? AppColor.primary : AppColor.cardBorder,
                    width: isSelected ? 1.5.w : 1.w,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColor.primary : AppColor.surfaceLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: isSelected ? AppColor.textOnPrimary : AppColor.textSecondary, size: 20.r),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                          ),
                          2.verticalSpace,
                          Text(
                            desc,
                            style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected) Icon(Icons.check_circle, color: AppColor.primary, size: 20.r),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
