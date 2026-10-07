import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/result_analyzer_provider.dart';

class SubjectGradeListWidget extends ConsumerWidget {
  const SubjectGradeListWidget({super.key});

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
                "Parsed Subject Grades (${analyzerState.subjects.length})",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              ),
            ),
            8.horizontalSpace,
            Text(
              "Tap ✖ to remove",
              style: TextStyle(fontSize: 11.sp, color: AppColor.textMuted),
            ),
          ],
        ),
        12.verticalSpace,
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List.generate(analyzerState.subjects.length, (index) {
            final sub = analyzerState.subjects[index];
            Color gradeColor = AppColor.mastered;
            if (sub.grade.contains("B")) gradeColor = AppColor.accent;
            if (sub.grade.contains("C") || sub.grade.contains("D")) gradeColor = AppColor.missing;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColor.cardBg,
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
                  Text(
                    sub.subjectName,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColor.textPrimary),
                  ),
                  6.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      ref.read(resultAnalyzerProvider.notifier).removeSubjectGrade(index);
                    },
                    child: Icon(Icons.close_rounded, size: 14.r, color: AppColor.textMuted),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
