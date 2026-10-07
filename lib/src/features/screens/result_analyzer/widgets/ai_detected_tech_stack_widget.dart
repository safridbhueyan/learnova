import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../../student_profile/provider/student_profile_provider.dart';
import '../provider/result_analyzer_provider.dart';

class AIDetectedTechStackWidget extends ConsumerWidget {
  const AIDetectedTechStackWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzerState = ref.watch(resultAnalyzerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "AI Detected Tech Stack Recommendations",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              ),
            ),
            8.horizontalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColor.masteredLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                "Grade Analysis Active",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.mastered),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        ...analyzerState.recommendations.map((rec) {
          return Container(
            margin: EdgeInsets.only(bottom: 14.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColor.cardBg,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColor.cardBorder, width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        rec.careerPathTitle,
                        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColor.accent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "${rec.suitabilityScore}% Fit",
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Text(
                  rec.aiReasoningText,
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.35),
                ),
                12.verticalSpace,
                Text(
                  "Recommended Core Tech Stack:",
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                ),
                6.verticalSpace,
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: rec.primaryTechStack.map((tech) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColor.primarySubtle,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        "⚡ $tech",
                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColor.primary),
                      ),
                    );
                  }).toList(),
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColor.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                        onPressed: () {
                          ref.read(studentProfileProvider.notifier).updateTargetCareer(rec.careerPathTitle);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColor.primary,
                              content: Text("Target Career & Tech Stack set to: ${rec.careerPathTitle}"),
                            ),
                          );
                        },
                        child: Text(
                          "Adopt Tech Stack Profile",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}
