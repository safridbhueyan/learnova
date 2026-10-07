import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class AcademicGrowthChartWidget extends StatelessWidget {
  const AcademicGrowthChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final semesterData = [
      {"sem": "Sem 1", "cgpa": 3.40, "skill": 42},
      {"sem": "Sem 2", "cgpa": 3.52, "skill": 54},
      {"sem": "Sem 3", "cgpa": 3.60, "skill": 62},
      {"sem": "Sem 4", "cgpa": 3.70, "skill": 70},
      {"sem": "Sem 5", "cgpa": 3.78, "skill": 78},
      {"sem": "Sem 6", "cgpa": 3.82, "skill": 84},
      {"sem": "Sem 7", "cgpa": 3.85, "skill": 92},
    ];

    return Container(
      padding: EdgeInsets.all(18.r),
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
                child: Text(
                  "Academic & Skill Improvement Graph",
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.masteredLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: AppColor.mastered, size: 14.r),
                    4.horizontalSpace,
                    Text("+13.2% Growth", style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.mastered)),
                  ],
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Text(
            "Semester-by-semester CGPA and technical skill mastery progression.",
            style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: semesterData.map((data) {
              final sem = data["sem"] as String;
              final cgpa = data["cgpa"] as double;
              final heightPct = (cgpa / 4.0).clamp(0.0, 1.0);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$cgpa",
                    style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
                  ),
                  4.verticalSpace,
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: 16.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          color: AppColor.surfaceLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      Container(
                        width: 16.w,
                        height: 90.h * heightPct,
                        decoration: BoxDecoration(
                          gradient: AppColor.primaryGradient,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Text(
                    sem,
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: AppColor.textSecondary),
                  ),
                ],
              );
            }).toList(),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(AppColor.primary, "CGPA Trend"),
              16.horizontalSpace,
              _buildLegend(AppColor.accent, "Skill Mastery Index"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        6.horizontalSpace,
        Text(label, style: TextStyle(fontSize: 10.sp, color: AppColor.textSecondary)),
      ],
    );
  }
}
