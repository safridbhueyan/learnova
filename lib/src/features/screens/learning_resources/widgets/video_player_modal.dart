import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/models/learning_resource_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';

class VideoPlayerModal extends ConsumerWidget {
  final LearningResourceModel tutorial;

  const VideoPlayerModal({
    super.key,
    required this.tutorial,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColor.cardBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          16.verticalSpace,
          // Simulated Embedded Video Player Stage
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: const [
                BoxShadow(
                  color: AppColor.shadow,
                  blurRadius: 14,
                  offset: Offset(0, 6),
                )
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36.r),
                      ),
                      10.verticalSpace,
                      Text(
                        "Playing Tutorial Preview",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      4.verticalSpace,
                      Text(
                        tutorial.channelName,
                        style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 12.w,
                  right: 12.w,
                  child: Row(
                    children: [
                      Text("04:12", style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                      8.horizontalSpace,
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: 0.35,
                            minHeight: 4.h,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Text(tutorial.duration, style: TextStyle(color: Colors.white70, fontSize: 10.sp)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          Text(
            tutorial.title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary, height: 1.3),
          ),
          8.verticalSpace,
          Row(
            children: [
              Icon(Icons.video_library_rounded, size: 14.r, color: Colors.redAccent),
              6.horizontalSpace,
              Text(tutorial.channelName, style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, fontWeight: FontWeight.bold)),
              12.horizontalSpace,
              Text("• ${tutorial.views}", style: TextStyle(fontSize: 11.sp, color: AppColor.textMuted)),
            ],
          ),
          14.verticalSpace,
          Text(
            "Video Overview:",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.accent),
          ),
          6.verticalSpace,
          Text(
            tutorial.summary,
            style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.35),
          ),
          14.verticalSpace,
          Text(
            "Key Learning Takeaways:",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.primary),
          ),
          8.verticalSpace,
          ...tutorial.keyTopics.map((topic) {
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 14.r, color: AppColor.mastered),
                  8.horizontalSpace,
                  Text(
                    topic,
                    style: TextStyle(fontSize: 11.sp, color: AppColor.textPrimary, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: BouncyScaleButton(
                  id: "close_modal",
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColor.chipBackground,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        "Close Player",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColor.textSecondary),
                      ),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: BouncyScaleButton(
                  id: "open_yt",
                  onTap: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Launching YouTube Tutorial: ${tutorial.title}"),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.open_in_new, color: Colors.white, size: 14.r),
                          6.horizontalSpace,
                          Text(
                            "Open in YouTube",
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
