import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class ReadinessGaugeWidget extends StatelessWidget {
  final int readinessScore;
  final String statusLabel;

  const ReadinessGaugeWidget({
    super.key,
    required this.readinessScore,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = (readinessScore / 100).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.cardBorder, width: 1.w),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 42.r,
            lineWidth: 7.w,
            percent: percent,
            animation: true,
            animationDuration: 1000,
            center: Padding(
              padding: EdgeInsets.all(4.r),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedCountText(
                      targetValue: readinessScore,
                      suffix: "%",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textPrimary,
                      ),
                    ),
                    Text(
                      "READY",
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.accent,
                        letterSpacing: 0.8.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: AppColor.surfaceLight,
            progressColor: AppColor.primary,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Job Readiness",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    6.horizontalSpace,
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: AppColor.masteredLight,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          statusLabel,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.mastered,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                _buildMiniScoreBar("Technical Skills", 0.82, AppColor.primary),
                6.verticalSpace,
                _buildMiniScoreBar("Project Portfolio", 0.75, AppColor.accent),
                6.verticalSpace,
                _buildMiniScoreBar("Industry Alignment", 0.87, AppColor.mastered),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMiniScoreBar(String label, double val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 10.sp, color: AppColor.textSecondary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            4.horizontalSpace,
            Text(
              "${(val * 100).round()}%",
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        3.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: val,
            minHeight: 4.h,
            backgroundColor: AppColor.surfaceLight,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
