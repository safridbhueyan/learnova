import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/marksheet_provider.dart';

class MarksheetSummaryCardWidget extends ConsumerWidget {
  const MarksheetSummaryCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marksheetState = ref.watch(marksheetProvider);

    final sgpa = marksheetState.currentSGPA;
    final cgpa = marksheetState.cumulativeCGPA;
    final credits = marksheetState.currentCredits;

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        gradient: AppColor.heroGradient,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    marksheetState.selectedSemester,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textOnPrimary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    "Official Academic Transcript Summary",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColor.textOnPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColor.accent,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  sgpa >= 3.75 ? "High Distinction" : "Merit Standing",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textOnPrimary,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      sgpa > 0 ? sgpa.toStringAsFixed(2) : "N/A",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColor.textOnPrimary,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      "Semester SGPA",
                      style: TextStyle(fontSize: 10.sp, color: AppColor.textOnPrimary.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
                Container(width: 1.w, height: 32.h, color: Colors.white24),
                Column(
                  children: [
                    Text(
                      cgpa.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColor.accentLight,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      "Overall CGPA",
                      style: TextStyle(fontSize: 10.sp, color: AppColor.textOnPrimary.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
                Container(width: 1.w, height: 32.h, color: Colors.white24),
                Column(
                  children: [
                    Text(
                      "$credits",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: AppColor.textOnPrimary,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      "Credits Earned",
                      style: TextStyle(fontSize: 10.sp, color: AppColor.textOnPrimary.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
