import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/student_profile_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/student_profile_provider.dart';

class AddSkillDialog extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController proficiencyController = TextEditingController(text: "70");

  AddSkillDialog({super.key});

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
              "Add New Skill",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            16.verticalSpace,
            TextField(
              controller: nameController,
              style: TextStyle(color: AppColor.textPrimary, fontSize: 13.sp),
              decoration: InputDecoration(
                labelText: "Skill Name (e.g. GraphQL, Docker)",
                labelStyle: TextStyle(color: AppColor.textSecondary, fontSize: 12.sp),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.cardBorder),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primary),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            12.verticalSpace,
            TextField(
              controller: categoryController,
              style: TextStyle(color: AppColor.textPrimary, fontSize: 13.sp),
              decoration: InputDecoration(
                labelText: "Category (e.g. Backend, Tools)",
                labelStyle: TextStyle(color: AppColor.textSecondary, fontSize: 12.sp),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.cardBorder),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primary),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            12.verticalSpace,
            TextField(
              controller: proficiencyController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppColor.textPrimary, fontSize: 13.sp),
              decoration: InputDecoration(
                labelText: "Proficiency % (0 - 100)",
                labelStyle: TextStyle(color: AppColor.textSecondary, fontSize: 12.sp),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.cardBorder),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primary),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColor.textMuted, fontSize: 13.sp),
                  ),
                ),
                12.horizontalSpace,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    final name = nameController.text.trim();
                    final category = categoryController.text.trim().isEmpty ? "General" : categoryController.text.trim();
                    final prof = int.tryParse(proficiencyController.text) ?? 50;
                    if (name.isNotEmpty) {
                      String status = "Missing";
                      if (prof >= 85) {
                        status = "Mastered";
                      } else if (prof >= 70) {
                        status = "Strong";
                      } else if (prof >= 45) {
                        status = "Needs Improvement";
                      }
                      ref.read(studentProfileProvider.notifier).addSkill(
                            SkillItem(
                              name: name,
                              category: category,
                              proficiency: prof,
                              status: status,
                            ),
                          );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Add Skill",
                    style: TextStyle(color: AppColor.textOnPrimary, fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
