import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/models/learning_resource_model.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import '../provider/learning_resources_provider.dart';
import 'video_player_modal.dart';

class TutorialCardWidget extends ConsumerWidget {
  final LearningResourceModel tutorial;

  const TutorialCardWidget({
    super.key,
    required this.tutorial,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color difficultyColor = AppColor.mastered;
    if (tutorial.difficulty == "Intermediate") difficultyColor = AppColor.accent;
    if (tutorial.difficulty == "Advanced") difficultyColor = AppColor.primary;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: AppColor.cardBg,
        borderRadius: BorderRadius.circular(18.r),
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
          // Simulated YouTube Video Header Banner
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30.r,
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time_rounded, color: Colors.white, size: 10.r),
                        4.horizontalSpace,
                        Text(
                          tutorial.duration,
                          style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: difficultyColor.withValues(alpha: 0.2),
                      border: Border.all(color: difficultyColor, width: 1.w),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      tutorial.difficulty,
                      style: TextStyle(fontSize: 9.sp, color: difficultyColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 12.w,
                  child: Row(
                    children: [
                      Icon(Icons.ondemand_video_rounded, color: Colors.redAccent, size: 14.r),
                      6.horizontalSpace,
                      Text(
                        tutorial.channelName,
                        style: TextStyle(fontSize: 11.sp, color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        tutorial.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textPrimary,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        tutorial.isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        color: tutorial.isBookmarked ? AppColor.accent : AppColor.textMuted,
                        size: 22.r,
                      ),
                      onPressed: () {
                        ref.read(learningResourcesProvider.notifier).toggleBookmark(tutorial.id);
                      },
                    ),
                  ],
                ),
                6.verticalSpace,
                Text(
                  tutorial.summary,
                  style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                12.verticalSpace,
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: tutorial.keyTopics.map((topic) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: AppColor.surfaceLight,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        "#$topic",
                        style: TextStyle(fontSize: 9.sp, color: AppColor.textMuted, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
                14.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber, size: 14.r),
                        4.horizontalSpace,
                        Text(
                          "${tutorial.rating}",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textPrimary),
                        ),
                        8.horizontalSpace,
                        Text(
                          "• ${tutorial.views}",
                          style: TextStyle(fontSize: 10.sp, color: AppColor.textMuted),
                        ),
                      ],
                    ),
                    BouncyScaleButton(
                      id: "watch_${tutorial.id}",
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => VideoPlayerModal(tutorial: tutorial),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_circle_fill, color: AppColor.textOnPrimary, size: 14.r),
                            6.horizontalSpace,
                            Text(
                              "Watch Tutorial",
                              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                            ),
                          ],
                        ),
                      ),
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
