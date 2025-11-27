import 'package:flutter/material.dart';

class Course {
  final String code;
  final String name;
  final String professor;
  final Color color;
  final double progress;
  final List<CourseMaterial> materials;
  final List<Assignment> assignments;

  Course({
    required this.code,
    required this.name,
    required this.professor,
    required this.color,
    required this.progress,
    this.materials = const [],
    this.assignments = const [],
  });
}

class CourseMaterial {
  final String title;
  final String type;
  final String size;
  final DateTime uploadDate;
  final String downloadUrl;

  CourseMaterial({
    required this.title,
    required this.type,
    required this.size,
    required this.uploadDate,
    required this.downloadUrl,
  });
}

class Assignment {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isSubmitted;
  final String? submissionUrl;
  final int totalMarks;
  final int? obtainedMarks;

  Assignment({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isSubmitted = false,
    this.submissionUrl,
    required this.totalMarks,
    this.obtainedMarks,
  });
}

final List<Course> demoCourses = [
  Course(
    code: 'CSE 101',
    name: 'Introduction to Computer Science',
    professor: 'Dr. Smith',
    color: const Color(0xFF4834D4),
    progress: 0.75,
    materials: [
      CourseMaterial(
        title: 'Introduction to Programming',
        type: 'PDF',
        size: '2.5 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 5)),
        downloadUrl: 'https://example.com/materials/intro-programming.pdf',
      ),
      CourseMaterial(
        title: 'Data Types and Variables',
        type: 'PDF',
        size: '1.8 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 3)),
        downloadUrl: 'https://example.com/materials/data-types.pdf',
      ),
      CourseMaterial(
        title: 'Control Structures Lecture',
        type: 'Video',
        size: '45 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 1)),
        downloadUrl: 'https://example.com/materials/control-structures.mp4',
      ),
    ],
    assignments: [
      Assignment(
        title: 'Programming Basics',
        description: 'Complete the basic programming exercises',
        dueDate: DateTime.now().add(const Duration(days: 7)),
        totalMarks: 100,
      ),
      Assignment(
        title: 'Variables and Operations',
        description: 'Solve problems using variables and basic operations',
        dueDate: DateTime.now().add(const Duration(days: 14)),
        totalMarks: 50,
      ),
    ],
  ),
  
   Course(
    code: 'CSE 101',
    name: 'Introduction to Computer Science',
    professor: 'Dr. Smith',
    color: const Color(0xFF4834D4),
    progress: 0.75,
    materials: [
      CourseMaterial(
        title: 'Introduction to Programming',
        type: 'PDF',
        size: '2.5 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 5)),
        downloadUrl: 'https://example.com/materials/intro-programming.pdf',
      ),
      CourseMaterial(
        title: 'Data Types and Variables',
        type: 'PDF',
        size: '1.8 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 3)),
        downloadUrl: 'https://example.com/materials/data-types.pdf',
      ),
      CourseMaterial(
        title: 'Control Structures Lecture',
        type: 'Video',
        size: '45 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 1)),
        downloadUrl: 'https://example.com/materials/control-structures.mp4',
      ),
    ],
    assignments: [
      Assignment(
        title: 'Programming Basics',
        description: 'Complete the basic programming exercises',
        dueDate: DateTime.now().add(const Duration(days: 7)),
        totalMarks: 100,
      ),
      Assignment(
        title: 'Variables and Operations',
        description: 'Solve problems using variables and basic operations',
        dueDate: DateTime.now().add(const Duration(days: 14)),
        totalMarks: 50,
      ),
    ],
  ),
   Course(
    code: 'CSE 101',
    name: 'Introduction to Computer Science',
    professor: 'Dr. Smith',
    color: const Color(0xFF4834D4),
    progress: 0.75,
    materials: [
      CourseMaterial(
        title: 'Introduction to Programming',
        type: 'PDF',
        size: '2.5 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 5)),
        downloadUrl: 'https://example.com/materials/intro-programming.pdf',
      ),
      CourseMaterial(
        title: 'Data Types and Variables',
        type: 'PDF',
        size: '1.8 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 3)),
        downloadUrl: 'https://example.com/materials/data-types.pdf',
      ),
      CourseMaterial(
        title: 'Control Structures Lecture',
        type: 'Video',
        size: '45 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 1)),
        downloadUrl: 'https://example.com/materials/control-structures.mp4',
      ),
    ],
    assignments: [
      Assignment(
        title: 'Programming Basics',
        description: 'Complete the basic programming exercises',
        dueDate: DateTime.now().add(const Duration(days: 7)),
        totalMarks: 100,
      ),
      Assignment(
        title: 'Variables and Operations',
        description: 'Solve problems using variables and basic operations',
        dueDate: DateTime.now().add(const Duration(days: 14)),
        totalMarks: 50,
      ),
    ],
  ),
  
  // Course(
  //   code: 'MATH 201',
  //   name: 'Linear Algebra',
  //   professor: 'Dr. Johnson',
  //   color: const Color(0xFF6C5CE7),
  //   progress: 0.60,
  //   materials: [
  //     CourseMaterial(
  //       title: 'Matrices and Determinants',
  //       type: 'PDF',
  //       size: '3.2 MB',
  //       uploadDate: DateTime.now().subtract(const Duration(days: 4)),
  //       downloadUrl: 'https://example.com/materials/matrices.pdf',
  //     ),
  //     CourseMaterial(
  //       title: 'Vector Spaces',
  //       type: 'PDF',
  //       size: '2.1 MB',
  //       uploadDate: DateTime.now().subtract(const Duration(days: 2)),
  //       downloadUrl: 'https://example.com/materials/vector-spaces.pdf',
  //     ),
  //   ],
  //   assignments: [
  //     Assignment(
  //       title: 'Matrix Operations',
  //       description: 'Solve problems involving matrix operations',
  //       dueDate: DateTime.now().add(const Duration(days: 5)),
  //       totalMarks: 50,
  //     ),
  //   ],
  // ),
  Course(
    code: 'PHY 301',
    name: 'Quantum Mechanics',
    professor: 'Dr. Williams',
    color: const Color(0xFFa55eea),
    progress: 0.45,
    materials: [
      CourseMaterial(
        title: 'Quantum States',
        type: 'PDF',
        size: '4.5 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 6)),
        downloadUrl: 'https://example.com/materials/quantum-states.pdf',
      ),
    ],
    assignments: [
      Assignment(
        title: 'Wave Functions',
        description: 'Solve problems related to wave functions',
        dueDate: DateTime.now().add(const Duration(days: 10)),
        totalMarks: 100,
      ),
    ],
  ),
  Course(
    code: 'ENG 202',
    name: 'Technical Writing',
    professor: 'Prof. Davis',
    color: const Color(0xFF8C7AE6),
    progress: 0.90,
    materials: [
      CourseMaterial(
        title: 'Technical Documentation',
        type: 'PDF',
        size: '1.5 MB',
        uploadDate: DateTime.now().subtract(const Duration(days: 1)),
        downloadUrl: 'https://example.com/materials/technical-docs.pdf',
      ),
    ],
    assignments: [
      Assignment(
        title: 'Documentation Project',
        description: 'Create technical documentation for a software project',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        totalMarks: 100,
      ),
    ],
  ),
];
