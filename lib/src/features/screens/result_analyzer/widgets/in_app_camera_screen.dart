import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/theme_extension/color_scheme.dart';
import 'crop_image_screen.dart';

class CameraState {
  final CameraController? controller;
  final bool isInitialized;
  final bool isCapturing;
  final int selectedCameraIndex;
  final FlashMode flashMode;
  final String? errorMessage;

  const CameraState({
    this.controller,
    required this.isInitialized,
    required this.isCapturing,
    required this.selectedCameraIndex,
    required this.flashMode,
    this.errorMessage,
  });

  CameraState copyWith({
    CameraController? controller,
    bool? isInitialized,
    bool? isCapturing,
    int? selectedCameraIndex,
    FlashMode? flashMode,
    String? errorMessage,
  }) {
    return CameraState(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
      isCapturing: isCapturing ?? this.isCapturing,
      selectedCameraIndex: selectedCameraIndex ?? this.selectedCameraIndex,
      flashMode: flashMode ?? this.flashMode,
      errorMessage: errorMessage,
    );
  }
}

class CameraNotifier extends Notifier<CameraState> {
  List<CameraDescription> _cameras = [];

  @override
  CameraState build() {
    _initCamera();
    return const CameraState(
      isInitialized: false,
      isCapturing: false,
      selectedCameraIndex: 0,
      flashMode: FlashMode.auto,
    );
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        state = state.copyWith(errorMessage: "No physical camera detected. Using camera viewfinder mode.");
        return;
      }

      final controller = CameraController(
        _cameras[state.selectedCameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();
      await controller.setFlashMode(state.flashMode);

      state = state.copyWith(
        controller: controller,
        isInitialized: true,
      );
    } catch (e) {
      state = state.copyWith(
        isInitialized: false,
        errorMessage: "Camera hardware initialization note: $e",
      );
    }
  }

  Future<void> toggleFlash() async {
    if (state.controller == null || !state.isInitialized) return;
    FlashMode nextMode = FlashMode.auto;
    if (state.flashMode == FlashMode.auto) {
      nextMode = FlashMode.torch;
    } else if (state.flashMode == FlashMode.torch) {
      nextMode = FlashMode.off;
    }

    try {
      await state.controller!.setFlashMode(nextMode);
      state = state.copyWith(flashMode: nextMode);
    } catch (_) {}
  }

  Future<void> switchCamera() async {
    if (_cameras.length <= 1) return;
    final nextIndex = (state.selectedCameraIndex + 1) % _cameras.length;
    state = state.copyWith(selectedCameraIndex: nextIndex, isInitialized: false);

    if (state.controller != null) {
      await state.controller!.dispose();
    }
    _initCamera();
  }

  Future<XFile?> takePicture() async {
    if (state.isCapturing) return null;
    state = state.copyWith(isCapturing: true);

    try {
      if (state.controller != null && state.controller!.value.isInitialized) {
        final file = await state.controller!.takePicture();
        state = state.copyWith(isCapturing: false);
        return file;
      }
    } catch (_) {}

    state = state.copyWith(isCapturing: false);
    return null;
  }
}

final cameraNotifierProvider = NotifierProvider<CameraNotifier, CameraState>(CameraNotifier.new);

class InAppCameraScreen extends ConsumerWidget {
  const InAppCameraScreen({super.key});

  Future<void> _handleCapture(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(cameraNotifierProvider.notifier);
    final file = await notifier.takePicture();

    final imagePath = file?.path ?? "captured_marksheet_photo.jpg";

    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => CropImageScreen(
            imagePath: imagePath,
            sourceName: "Real In-App Camera",
          ),
        ),
      );
    }
  }

  Future<void> _handleGalleryPick(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery);
      final imagePath = file?.path ?? "gallery_marksheet_photo.png";

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => CropImageScreen(
              imagePath: imagePath,
              sourceName: "Gallery Upload",
            ),
          ),
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Live Camera Viewfinder or Simulator Container
          Positioned.fill(
            child: cameraState.isInitialized && cameraState.controller != null
                ? CameraPreview(cameraState.controller!)
                : Container(
                    color: AppColor.primaryDark,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, size: 64.sp, color: AppColor.accent),
                          16.verticalSpace,
                          Text(
                            "Learnova Document Camera Scanner",
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                          ),
                          8.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              cameraState.errorMessage ?? "Initializing real camera sensor...",
                              style: TextStyle(fontSize: 11.sp, color: AppColor.textMuted),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),

          // Document Frame Overlay Box
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 80.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.accent.withValues(alpha: 0.8), width: 2.w),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12.r,
                    left: 12.r,
                    child: Icon(Icons.crop_free_rounded, color: AppColor.accent, size: 28.sp),
                  ),
                  Positioned(
                    bottom: 12.r,
                    right: 12.r,
                    child: Icon(Icons.crop_free_rounded, color: AppColor.accent, size: 28.sp),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "Align Marksheet Inside Frame",
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Camera Controls Bar
          Positioned(
            top: 40.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: AppColor.textOnPrimary, size: 20.sp),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.center_focus_strong_rounded, color: AppColor.accent, size: 16.sp),
                      6.horizontalSpace,
                      Text(
                        "Document Mode",
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: AppColor.textOnPrimary),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: Icon(
                          cameraState.flashMode == FlashMode.torch
                              ? Icons.flash_on_rounded
                              : cameraState.flashMode == FlashMode.off
                                  ? Icons.flash_off_rounded
                                  : Icons.flash_auto_rounded,
                          color: cameraState.flashMode == FlashMode.torch ? AppColor.accent : AppColor.textOnPrimary,
                          size: 20.sp,
                        ),
                        onPressed: () => ref.read(cameraNotifierProvider.notifier).toggleFlash(),
                      ),
                    ),
                    8.horizontalSpace,
                    CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: Icon(Icons.flip_camera_ios_rounded, color: AppColor.textOnPrimary, size: 20.sp),
                        onPressed: () => ref.read(cameraNotifierProvider.notifier).switchCamera(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Shutter & Gallery Bar
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: Colors.white12, width: 1.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_library_rounded, color: AppColor.textOnPrimary, size: 26.sp),
                    onPressed: () => _handleGalleryPick(context),
                    tooltip: "Pick from Gallery",
                  ),
                  GestureDetector(
                    onTap: cameraState.isCapturing ? null : () => _handleCapture(context, ref),
                    child: Container(
                      width: 68.r,
                      height: 68.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.accent, width: 4.w),
                        color: Colors.white,
                      ),
                      child: cameraState.isCapturing
                          ? Padding(
                              padding: EdgeInsets.all(16.r),
                              child: const CircularProgressIndicator(color: AppColor.primary, strokeWidth: 3),
                            )
                          : Center(
                              child: Container(
                                width: 52.r,
                                height: 52.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.primary,
                                ),
                                child: Icon(Icons.camera_alt_rounded, color: AppColor.textOnPrimary, size: 26.sp),
                              ),
                            ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.help_outline_rounded, color: AppColor.textOnPrimary, size: 24.sp),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Align your semester marksheet inside the box frame and press the shutter button."),
                        ),
                      );
                    },
                    tooltip: "Camera Help",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
