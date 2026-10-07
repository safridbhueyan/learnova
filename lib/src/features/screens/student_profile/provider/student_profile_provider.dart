import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/student_profile_model.dart';

class StudentProfileNotifier extends Notifier<StudentProfileModel> {
  @override
  StudentProfileModel build() {
    return const StudentProfileModel(
      name: "Safrid Bhueyan",
      email: "safrid.student@university.edu",
      university: "UITS",
      department: "Computer Science & Engineering",
      semester: "7th Semester",
      cgpa: "3.85",
      interests: [
        "Mobile Development",
        "Flutter & Dart",
        "Artificial Intelligence",
        "Software Engineering",
        "Cloud Architecture",
      ],
      targetCareer: "Flutter Developer",
      skills: [
        SkillItem(name: "Dart", category: "Language", proficiency: 92, status: "Mastered"),
        SkillItem(name: "Flutter UI", category: "Framework", proficiency: 88, status: "Mastered"),
        SkillItem(name: "Firebase Auth & Firestore", category: "Backend", proficiency: 80, status: "Strong"),
        SkillItem(name: "Riverpod / State Management", category: "Architecture", proficiency: 75, status: "Strong"),
        SkillItem(name: "REST API Integration", category: "Networking", proficiency: 60, status: "Needs Improvement"),
        SkillItem(name: "Git & GitHub", category: "Tools", proficiency: 85, status: "Strong"),
        SkillItem(name: "Clean Architecture", category: "Architecture", proficiency: 35, status: "Missing"),
        SkillItem(name: "Automated Unit Testing", category: "Testing", proficiency: 25, status: "Missing"),
        SkillItem(name: "CI/CD Deployment", category: "DevOps", proficiency: 20, status: "Missing"),
      ],
      projects: [
        ProjectItem(
          title: "Learnova Capstone Platform",
          description: "AI-Powered Student Career Grooming and Job Readiness application built with Flutter and Riverpod.",
          techStack: ["Flutter", "Dart", "Riverpod", "Python NLP", "Node.js"],
          role: "Lead Flutter Developer",
          status: "In Progress",
          githubUrl: "https://github.com/safridbhueyan/ToDo-App",
        ),
        ProjectItem(
          title: "Smart E-Commerce Mobile App",
          description: "Full-featured shopping platform with Firebase auth, payment gateway mock, and product catalog.",
          techStack: ["Flutter", "Firebase", "Stripe API"],
          role: "Solo Developer",
          status: "Completed",
          githubUrl: "https://github.com/safridbhueyan/ecommerce-app",
        ),
      ],
    );
  }

  void updateTargetCareer(String careerTitle) {
    state = state.copyWith(targetCareer: careerTitle);
  }

  void addSkill(SkillItem newSkill) {
    final updatedSkills = [...state.skills, newSkill];
    state = state.copyWith(skills: updatedSkills);
  }

  void updateAcademicInfo({String? university, String? department, String? semester, String? cgpa}) {
    state = state.copyWith(
      university: university ?? state.university,
      department: department ?? state.department,
      semester: semester ?? state.semester,
      cgpa: cgpa ?? state.cgpa,
    );
  }

  void updateInterests(List<String> interests) {
    state = state.copyWith(interests: interests);
  }

  void removeSkill(String skillName) {
    final updatedSkills = state.skills.where((s) => s.name != skillName).toList();
    state = state.copyWith(skills: updatedSkills);
  }

  void updateSkillProficiency(String skillName, int newProficiency) {
    final updatedSkills = state.skills.map((s) {
      if (s.name == skillName) {
        String status = "Missing";
        if (newProficiency >= 85) {
          status = "Mastered";
        } else if (newProficiency >= 70) {
          status = "Strong";
        } else if (newProficiency >= 45) {
          status = "Needs Improvement";
        }
        return s.copyWith(proficiency: newProficiency, status: status);
      }
      return s;
    }).toList();
    state = state.copyWith(skills: updatedSkills);
  }
}

final studentProfileProvider = NotifierProvider<StudentProfileNotifier, StudentProfileModel>(StudentProfileNotifier.new);
