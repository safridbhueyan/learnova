import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/result_analyzer_provider.dart';
import 'manual_grade_dialog.dart';

class SubjectGradeListWidget extends ConsumerWidget {
  const SubjectGradeListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzerState = ref.watch(resultAnalyzerProvider);

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: AppColor.primarySubtle,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.list_alt_rounded, color: AppColor.primary, size: 18.sp),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        "Academic Results & Grades (${analyzerState.subjects.length})",
                        style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ManualGradeDialog(),
                  );
                },
                icon: Icon(Icons.add_circle_outline_rounded, color: AppColor.primary, size: 22.sp),
                tooltip: "Add Subject Manually",
              ),
            ],
          ),
          6.verticalSpace,
          Text(
            analyzerState.hasUploadedResults
                ? "Here are your verified course subjects and letter grades extracted from your uploaded marksheet or manual entry:"
                : "Default course subjects shown. Upload your marksheet or enter grades manually to update your profile:",
            style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.3),
          ),
          14.verticalSpace,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.generate(analyzerState.subjects.length, (index) {
              final sub = analyzerState.subjects[index];
              Color gradeColor = AppColor.mastered;
              if (sub.grade.contains("B")) gradeColor = AppColor.accent;
              if (sub.grade.contains("C") || sub.grade.contains("D")) gradeColor = AppColor.missing;

              return Container(
                constraints: BoxConstraints(maxWidth: ScreenUtil().screenWidth - 70.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColor.surfaceLight,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColor.cardBorder, width: 1.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: gradeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        sub.grade,
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: gradeColor),
                      ),
                    ),
                    8.horizontalSpace,
                    Flexible(
                      child: Text(
                        sub.subjectName,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    6.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        ref.read(resultAnalyzerProvider.notifier).removeSubjectGrade(index);
                      },
                      child: Icon(Icons.close_rounded, size: 16.r, color: AppColor.textMuted),
                    ),
                  ],
                ),
              );
            }),
          ),
          12.verticalSpace,
          Center(
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ManualGradeDialog(),
                );
              },
              icon: Icon(Icons.add_rounded, size: 16.sp, color: AppColor.primary),
              label: Text(
                "+ Add Another Course Grade Manually",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
