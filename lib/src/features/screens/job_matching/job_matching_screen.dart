import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import 'provider/job_matching_provider.dart';
import 'widgets/job_card_widget.dart';
import 'widgets/job_detail_dialog.dart';

class JobMatchingScreen extends ConsumerWidget {
  const JobMatchingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobMatchingProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Job & Internship Opportunities",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColor.cardBorder),
              ),
              child: Row(
                children: [
                  Icon(Icons.work_outline, color: AppColor.accent, size: 22.r),
                  12.horizontalSpace,
                  Expanded(
                    child: Text(
                      "NLP similarity matching between your current skill inventory and real-time tech industry job requisitions.",
                      style: TextStyle(fontSize: 11.sp, color: AppColor.textSecondary, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Text(
              "Recommended Positions",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
            12.verticalSpace,
            ...jobs.map((job) {
              return JobCardWidget(
                job: job,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => JobDetailDialog(job: job),
                  );
                },
              );
            }),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
