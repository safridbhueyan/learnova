import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/subject_grade_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/result_analyzer_provider.dart';

class ManualGradeDialog extends ConsumerWidget {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController gradeController = TextEditingController(text: "A+");
  final TextEditingController categoryController = TextEditingController(text: "Software Eng");

  ManualGradeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: AppColor.cardBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Academic Subject Result",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
            ),
            16.verticalSpace,
            TextField(
              controller: subjectController,
              style: TextStyle(color: AppColor.textPrimary, fontSize: 13.sp),
              decoration: const InputDecoration(
                labelText: "Subject Name (e.g. Data Structures)",
              ),
            ),
            12.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: gradeController,
                    style: TextStyle(color: AppColor.textPrimary, fontSize: 13.sp),
                    decoration: const InputDecoration(
                      labelText: "Letter Grade (A+, A, B)",
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: TextField(
                    controller: categoryController,
                    style: TextStyle(color: AppColor.textPrimary, fontSize: 13.sp),
                    decoration: const InputDecoration(
                      labelText: "Domain Category",
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () {
                    final name = subjectController.text.trim();
                    final gradeStr = gradeController.text.trim().toUpperCase();
                    final category = categoryController.text.trim();

                    if (name.isNotEmpty) {
                      double gpa = 4.0;
                      if (gradeStr == "A") gpa = 3.75;
                      if (gradeStr == "A-") gpa = 3.50;
                      if (gradeStr == "B+") gpa = 3.25;
                      if (gradeStr == "B") gpa = 3.00;

                      ref.read(resultAnalyzerProvider.notifier).addManualSubjectGrade(
                            SubjectGrade(
                              subjectName: name,
                              grade: gradeStr.isEmpty ? "A" : gradeStr,
                              gpa: gpa,
                              category: category.isEmpty ? "General CS" : category,
                            ),
                          );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Save Subject", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
