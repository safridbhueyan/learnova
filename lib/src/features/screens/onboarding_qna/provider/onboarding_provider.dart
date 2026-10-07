import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final int currentStep; // 0: Academic, 1: Interests, 2: Skills, 3: Target Career
  final String university;
  final String department;
  final String semester;
  final String cgpa;
  final List<String> selectedInterests;
  final List<String> selectedSkills;
  final String targetCareer;
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
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState(
      currentStep: 0,
      university: "UITS",
      department: "CSE",
      semester: "7th Semester",
      cgpa: "3.85",
      selectedInterests: ["Mobile Development", "Artificial Intelligence"],
      selectedSkills: ["Dart", "Flutter", "Firebase", "Git"],
      targetCareer: "Flutter Developer",
      isCompleted: false,
    );
  }

  void nextStep() {
    if (state.currentStep < 3) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    } else {
      state = state.copyWith(isCompleted: true);
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

  void completeOnboarding() {
    state = state.copyWith(isCompleted: true);
  }
}

final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingState>(OnboardingNotifier.new);
