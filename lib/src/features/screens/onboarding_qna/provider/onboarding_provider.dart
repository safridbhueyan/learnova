import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final int currentStep; // 0: Academic, 1: Interests, 2: Skills, 3: Target Career, 4: Results Upload
  final String university;
  final String department;
  final String semester;
  final String cgpa;
  final List<String> selectedInterests;
  final List<String> selectedSkills;
  final String targetCareer;
  final bool hasUploadedResults;
  final bool isAnalyzingResults;
  final String? uploadedFileName;
  final bool isCompleted;

  const OnboardingState({
    required this.currentStep,
    required this.university,
    required this.department,
    required this.semester,
    required this.cgpa,
    required this.selectedInterests,
    required this.selectedSkills,
    required this.targetCareer,
    this.hasUploadedResults = false,
    this.isAnalyzingResults = false,
    this.uploadedFileName,
    required this.isCompleted,
  });

  OnboardingState copyWith({
    int? currentStep,
    String? university,
    String? department,
    String? semester,
    String? cgpa,
    List<String>? selectedInterests,
    List<String>? selectedSkills,
    String? targetCareer,
    bool? hasUploadedResults,
    bool? isAnalyzingResults,
    String? uploadedFileName,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      university: university ?? this.university,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      cgpa: cgpa ?? this.cgpa,
      selectedInterests: selectedInterests ?? this.selectedInterests,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      targetCareer: targetCareer ?? this.targetCareer,
      hasUploadedResults: hasUploadedResults ?? this.hasUploadedResults,
      isAnalyzingResults: isAnalyzingResults ?? this.isAnalyzingResults,
      uploadedFileName: uploadedFileName ?? this.uploadedFileName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState(
      currentStep: 0,
      university: "",
      department: "",
      semester: "",
      cgpa: "",
      selectedInterests: ["Mobile Development", "Artificial Intelligence"],
      selectedSkills: ["Dart", "Flutter", "Firebase"],
      targetCareer: "Flutter Developer",
      hasUploadedResults: false,
      isAnalyzingResults: false,
      uploadedFileName: null,
      isCompleted: false,
    );
  }

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    } else {
      completeOnboarding();
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void updateAcademic({String? uni, String? dept, String? sem, String? cgpaVal}) {
    state = state.copyWith(
      university: uni ?? state.university,
      department: dept ?? state.department,
      semester: sem ?? state.semester,
      cgpa: cgpaVal ?? state.cgpa,
    );
  }

  void toggleInterest(String interest) {
    final list = List<String>.from(state.selectedInterests);
    if (list.contains(interest)) {
      list.remove(interest);
    } else {
      list.add(interest);
    }
    state = state.copyWith(selectedInterests: list);
  }

  void toggleSkill(String skill) {
    final list = List<String>.from(state.selectedSkills);
    if (list.contains(skill)) {
      list.remove(skill);
    } else {
      list.add(skill);
    }
    state = state.copyWith(selectedSkills: list);
  }

  void selectTargetCareer(String careerTitle) {
    state = state.copyWith(targetCareer: careerTitle);
  }

  Future<void> simulateResultUploadAndAnalysis(String sourceName) async {
    state = state.copyWith(isAnalyzingResults: true, uploadedFileName: sourceName);
    
    // Simulate AI loading & Tech stack extraction
    await Future.delayed(const Duration(milliseconds: 1600));
    
    state = state.copyWith(
      isAnalyzingResults: false,
      hasUploadedResults: true,
      isCompleted: true,
    );
    await saveOnboardingToFirestore();
  }

  void skipResultUpload() {
    state = state.copyWith(
      hasUploadedResults: false,
      isCompleted: true,
    );
    saveOnboardingToFirestore();
  }

  void completeOnboarding() {
    state = state.copyWith(isCompleted: true);
    saveOnboardingToFirestore();
  }

  Future<void> saveOnboardingToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final data = {
          'university': state.university,
          'department': state.department,
          'semester': state.semester,
          'cgpa': state.cgpa,
          'selectedInterests': state.selectedInterests,
          'selectedSkills': state.selectedSkills,
          'targetCareer': state.targetCareer,
          'hasUploadedResults': state.hasUploadedResults,
          'updatedAt': DateTime.now().toIso8601String(),
        };
        await FirebaseFirestore.instance.collection('user').doc(user.uid).set(data, SetOptions(merge: true));
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(data, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint("Save onboarding to firestore error: $e");
    }
  }
}

final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingState>(OnboardingNotifier.new);
