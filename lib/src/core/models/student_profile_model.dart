class SkillItem {
  final String name;
  final String category; // Mobile, AI/ML, Web, Backend, Tools, Soft Skills
  final int proficiency; // 0 - 100
  final String status; // Mastered, Strong, Needs Improvement, Missing

  const SkillItem({
    required this.name,
    required this.category,
    required this.proficiency,
    required this.status,
  });

  SkillItem copyWith({
    String? name,
    String? category,
    int? proficiency,
    String? status,
  }) {
    return SkillItem(
      name: name ?? this.name,
      category: category ?? this.category,
      proficiency: proficiency ?? this.proficiency,
      status: status ?? this.status,
    );
  }
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> techStack;
  final String role;
  final String status; // Completed, In Progress
  final String? githubUrl;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.techStack,
    required this.role,
    required this.status,
    this.githubUrl,
  });
}

class StudentProfileModel {
  final String name;
  final String email;
  final String university;
  final String department;
  final String semester;
  final String cgpa;
  final List<String> interests;
  final List<SkillItem> skills;
  final List<ProjectItem> projects;
  final String targetCareer;

  const StudentProfileModel({
    required this.name,
    required this.email,
    required this.university,
    required this.department,
    required this.semester,
    required this.cgpa,
    required this.interests,
    required this.skills,
    required this.projects,
    required this.targetCareer,
  });

  StudentProfileModel copyWith({
    String? name,
    String? email,
    String? university,
    String? department,
    String? semester,
    String? cgpa,
    List<String>? interests,
    List<SkillItem>? skills,
    List<ProjectItem>? projects,
    String? targetCareer,
  }) {
    return StudentProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      university: university ?? this.university,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      cgpa: cgpa ?? this.cgpa,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      targetCareer: targetCareer ?? this.targetCareer,
    );
  }
}
