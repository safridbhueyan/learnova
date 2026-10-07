import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/marksheet_provider.dart';

class CourseMarksTableWidget extends ConsumerWidget {
  const CourseMarksTableWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marksheetState = ref.watch(marksheetProvider);
    final courses = marksheetState.currentCourses;

    if (courses.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: AppColor.cardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.cardBorder),
        ),
        child: Column(
          children: [
            Icon(Icons.notes_rounded, size: 48.sp, color: AppColor.textMuted),
            12.verticalSpace,
            Text(
              "No Course Marks Recorded for ${marksheetState.selectedSemester}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              textAlign: TextAlign.center,
            ),
            6.verticalSpace,
            Text(
              "Scan a semester transcript photo or tap '+ Add Course Mark' below to enter subject marks.",
              style: TextStyle(fontSize: 11.5.sp, color: AppColor.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Course Marks & Evaluation (${courses.length} Courses)",
                style: TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColor.primarySubtle,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                "SQLite Persisted",
                style: TextStyle(fontSize: 9.5.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
            ),
          ],
        ),
        12.verticalSpace,
        ...courses.map((course) {
          Color gradeColor = AppColor.mastered;
          if (course.letterGrade.contains("B")) gradeColor = AppColor.accent;
          if (course.letterGrade.contains("C") || course.letterGrade.contains("D")) gradeColor = AppColor.missing;

          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColor.cardBg,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColor.cardBorder, width: 1.w),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadow,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColor.primarySubtle,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        course.courseCode,
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.courseTitle,
                            style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                          ),
                          2.verticalSpace,
                          Text(
                            "${course.creditHours} Credit Hours",
                            style: TextStyle(fontSize: 10.5.sp, color: AppColor.textMuted),
                          ),
                        ],
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: gradeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            course.letterGrade,
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w900, color: gradeColor),
                          ),
                          Text(
                            "${course.gradePoint.toStringAsFixed(2)} GP",
                            style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: gradeColor),
                          ),
                        ],
                      ),
                    ),
                    4.horizontalSpace,
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(Icons.delete_outline_rounded, color: AppColor.textMuted, size: 18.sp),
                      onPressed: () {
                        ref.read(marksheetProvider.notifier).removeCourseMark(
                              marksheetState.selectedSemester,
                              course.courseCode,
                            );
                      },
                    ),
                  ],
                ),
                12.verticalSpace,
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColor.surfaceLight,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMarkItem("Midterm (30)", "${course.midtermMarks}"),
                      _buildMarkItem("Final Exam (50)", "${course.finalMarks}"),
                      _buildMarkItem("Quiz & Lab (20)", "${course.quizAssignmentMarks}"),
                      _buildMarkItem("Total Mark", "${course.totalMarks}%", isTotal: true),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMarkItem(String label, String value, {bool isTotal = false}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 12.5.sp : 11.5.sp,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.bold,
            color: isTotal ? AppColor.primary : AppColor.textPrimary,
          ),
        ),
        2.verticalSpace,
        Text(
          label,
          style: TextStyle(fontSize: 9.sp, color: AppColor.textMuted),
        ),
      ],
    );
  }
}
