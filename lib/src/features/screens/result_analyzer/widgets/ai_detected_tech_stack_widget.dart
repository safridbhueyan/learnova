import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../../student_profile/provider/student_profile_provider.dart';
import '../provider/result_analyzer_provider.dart';
import 'manual_grade_dialog.dart';

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
                "AI Tech Stack Recommendations",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              ),
            ),
            8.horizontalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: analyzerState.hasUploadedResults ? AppColor.masteredLight : AppColor.accentLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    analyzerState.hasUploadedResults ? Icons.verified_rounded : Icons.warning_amber_rounded,
                    size: 14.sp,
                    color: analyzerState.hasUploadedResults ? AppColor.mastered : AppColor.accent,
                  ),
                  4.horizontalSpace,
                  Text(
                    analyzerState.hasUploadedResults ? "Verified Real AI Stacks" : "Dummy Preview Mode",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: analyzerState.hasUploadedResults ? AppColor.mastered : AppColor.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        12.verticalSpace,
        if (!analyzerState.hasUploadedResults) ...[
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColor.accentLight,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.accent.withValues(alpha: 0.4), width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock_rounded, color: AppColor.accent, size: 20.sp),
                    8.horizontalSpace,
                    Text(
                      "Unlock Real AI-Calculated Tech Stacks",
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.accentSecondary),
                    ),
                  ],
                ),
                6.verticalSpace,
                Text(
                  "You are currently viewing Dummy / Default preview tech stacks because marksheet results haven't been uploaded yet.",
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.35),
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        onPressed: () {
                          ref.read(resultAnalyzerProvider.notifier).scanPhotoTranscript("camera_scan_marksheet.jpg");
                        },
                        icon: Icon(Icons.camera_alt_rounded, size: 16.sp, color: AppColor.textOnPrimary),
                        label: Text(
                          "Camera Scan",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColor.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        onPressed: () {
                          ref.read(resultAnalyzerProvider.notifier).scanPhotoTranscript("gallery_marksheet.png");
                        },
                        icon: Icon(Icons.photo_library_rounded, size: 16.sp, color: AppColor.primary),
                        label: Text(
                          "Gallery Upload",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                        ),
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ManualGradeDialog(),
                      );
                    },
                    icon: Icon(Icons.edit_note_rounded, size: 16.sp, color: AppColor.accent),
                    label: Text(
                      "Enter Grades Manually",
                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.accent),
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
        ],
        if (analyzerState.isPhotoScanning) ...[
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColor.cardBg,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColor.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: const CircularProgressIndicator(color: AppColor.primary, strokeWidth: 2.5),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AI Scanner Extracting Marksheet...",
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                      ),
                      2.verticalSpace,
                      Text(
                        "Calculating 3 career tech stacks based on transcript OCR",
                        style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
        ],
        ...analyzerState.activeRecommendations.map((rec) {
          return Container(
            margin: EdgeInsets.only(bottom: 14.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColor.cardBg,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: analyzerState.hasUploadedResults ? AppColor.cardBorder : AppColor.accent.withValues(alpha: 0.3),
                width: 1.w,
              ),
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
                        color: analyzerState.hasUploadedResults ? AppColor.accent : AppColor.textMuted,
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
