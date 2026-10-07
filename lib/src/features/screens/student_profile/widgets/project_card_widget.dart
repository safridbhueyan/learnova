import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/student_profile_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class ProjectCardWidget extends StatelessWidget {
  final ProjectItem project;

  const ProjectCardWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(16.r),
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
                  project.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: project.status == "Completed" ? AppColor.mastered.withValues(alpha: 0.15) : AppColor.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  project.status,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: project.status == "Completed" ? AppColor.mastered : AppColor.warning,
                  ),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            project.description,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.textSecondary,
              height: 1.3,
            ),
          ),
          12.verticalSpace,
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: project.techStack.map((tech) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.surfaceLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColor.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
