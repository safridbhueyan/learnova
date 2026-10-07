import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/semester_marksheet_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/marksheet_provider.dart';

class AddSemesterMarksDialog extends ConsumerWidget {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController creditController = TextEditingController(text: "3");
  final TextEditingController midtermController = TextEditingController(text: "25");
  final TextEditingController finalController = TextEditingController(text: "42");
  final TextEditingController quizController = TextEditingController(text: "18");
  final TextEditingController gradeController = TextEditingController(text: "A+");

  AddSemesterMarksDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marksheetState = ref.watch(marksheetProvider);

    return Dialog(
      backgroundColor: AppColor.cardBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Course Mark",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColor.primarySubtle,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      marksheetState.selectedSemester,
                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                    ),
                  ),
                ],
              ),
              14.verticalSpace,
              TextField(
                controller: codeController,
                style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                decoration: InputDecoration(
                  labelText: "Course Code (e.g. CSE-705)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              10.verticalSpace,
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                decoration: InputDecoration(
                  labelText: "Course Title (e.g. Clean Code & Architecture)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: creditController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                      decoration: InputDecoration(
                        labelText: "Credits (1-4)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: TextField(
                      controller: gradeController,
                      style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                      decoration: InputDecoration(
                        labelText: "Grade (A+, A, B)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: midtermController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                      decoration: InputDecoration(
                        labelText: "Mid (max 30)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: TextField(
                      controller: finalController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                      decoration: InputDecoration(
                        labelText: "Final (max 50)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: TextField(
                      controller: quizController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 13.sp, color: AppColor.textPrimary),
                      decoration: InputDecoration(
                        labelText: "Quiz (max 20)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                ],
              ),
              18.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel", style: TextStyle(color: AppColor.textMuted, fontSize: 12.sp)),
                  ),
                  10.horizontalSpace,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    onPressed: () {
                      final code = codeController.text.trim().isEmpty ? "CSE-101" : codeController.text.trim();
                      final title = titleController.text.trim().isEmpty ? "Computer Science Fundamentals" : titleController.text.trim();
                      final credits = int.tryParse(creditController.text.trim()) ?? 3;
                      final mid = double.tryParse(midtermController.text.trim()) ?? 25.0;
                      final fn = double.tryParse(finalController.text.trim()) ?? 42.0;
                      final qz = double.tryParse(quizController.text.trim()) ?? 18.0;
                      final grade = gradeController.text.trim().toUpperCase().isEmpty ? "A+" : gradeController.text.trim().toUpperCase();

                      double total = mid + fn + qz;
                      double gp = 4.0;
                      if (grade == "A") gp = 3.75;
                      if (grade == "A-") gp = 3.50;
                      if (grade == "B+") gp = 3.25;
                      if (grade == "B") gp = 3.00;

                      final newCourse = CourseMark(
                        courseCode: code,
                        courseTitle: title,
                        creditHours: credits,
                        midtermMarks: mid,
                        finalMarks: fn,
                        quizAssignmentMarks: qz,
                        totalMarks: total,
                        letterGrade: grade,
                        gradePoint: gp,
                      );

                      ref.read(marksheetProvider.notifier).addCourseMark(
                            marksheetState.selectedSemester,
                            newCourse,
                          );

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Save to SQLite",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
