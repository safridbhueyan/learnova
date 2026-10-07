import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extension/color_scheme.dart';
import '../job_matching/provider/job_matching_provider.dart';
import '../job_matching/widgets/job_card_widget.dart';
import '../job_matching/widgets/job_detail_dialog.dart';
import 'widgets/academic_growth_chart_widget.dart';
import 'widgets/ai_detected_tech_stack_widget.dart';
import 'widgets/subject_grade_list_widget.dart';
import 'widgets/transcript_photo_scanner_widget.dart';

class ResultScanTabNotifier extends Notifier<int> {
  @override
  int build() => 0; // 0: Result OCR & Tech Stack, 1: Matched Jobs
  void setTab(int index) => state = index;
}

final resultScanTabProvider = NotifierProvider<ResultScanTabNotifier, int>(ResultScanTabNotifier.new);

class ResultAnalyzerScreen extends ConsumerWidget {
  const ResultAnalyzerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(resultScanTabProvider);
    final jobs = ref.watch(jobMatchingProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text(
          "Scan Results & Job Matching",
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
            // Segment Controller
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: AppColor.surfaceLight,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(resultScanTabProvider.notifier).setTab(0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: activeTab == 0 ? AppColor.primary : AppColor.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            "Result OCR Scan",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: activeTab == 0 ? AppColor.textOnPrimary : AppColor.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(resultScanTabProvider.notifier).setTab(1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: activeTab == 1 ? AppColor.primary : AppColor.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            "Job Matching",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: activeTab == 1 ? AppColor.textOnPrimary : AppColor.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            CustomAnimatedSwitcher(
              key: ValueKey('result_tab_$activeTab'),
              child: activeTab == 0
                  ? Column(
                      children: const [
                        ScaleFadeEntrance(delay: Duration.zero, child: TranscriptPhotoScannerWidget()),
                        SizedBox(height: 20),
                        ScaleFadeEntrance(delay: Duration(milliseconds: 100), child: SubjectGradeListWidget()),
                        SizedBox(height: 20),
                        ScaleFadeEntrance(delay: Duration(milliseconds: 200), child: AcademicGrowthChartWidget()),
                        SizedBox(height: 24),
                        ScaleFadeEntrance(delay: Duration(milliseconds: 300), child: AIDetectedTechStackWidget()),
                      ],
                    )
                  : Column(
                      children: List.generate(jobs.length, (index) {
                        final job = jobs[index];
                        return ScaleFadeEntrance(
                          delay: Duration(milliseconds: index * 90),
                          child: JobCardWidget(
                            job: job,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => JobDetailDialog(job: job),
                              );
                            },
                          ),
                        );
                      }),
                    ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
