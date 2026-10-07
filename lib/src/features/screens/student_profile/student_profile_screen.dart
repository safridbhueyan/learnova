import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../auth/auth_screen.dart';
import '../auth/provider/auth_provider.dart';
import 'provider/student_profile_provider.dart';
import 'widgets/add_skill_dialog.dart';
import 'widgets/profile_header_widget.dart';
import 'widgets/project_card_widget.dart';
import 'widgets/skill_chip_group_widget.dart';

class StudentProfileScreen extends ConsumerWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(studentProfileProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Student Profile & Skill Inventory",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded, color: AppColor.missing, size: 20.r),
            tooltip: "Sign Out",
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
          8.horizontalSpace,
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderWidget(student: student),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Assessed Technical Skills",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddSkillDialog(),
                    );
                  },
                  icon: Icon(Icons.add_circle_outline, color: AppColor.accent, size: 18.r),
                  label: Text(
                    "Add Skill",
                    style: TextStyle(color: AppColor.accent, fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            SkillChipGroupWidget(skills: student.skills),
            24.verticalSpace,
            Text(
              "Portfolio Projects & Experience",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            12.verticalSpace,
            ...student.projects.map((project) => ProjectCardWidget(project: project)),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
