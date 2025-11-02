import 'package:flutter/material.dart';

class Course {
  final String code;
  final String name;
  final String professor;
  final Color color;
  final double progress;

  Course({
    required this.code,
    required this.name,
    required this.professor,
    required this.color,
    required this.progress,
  });
}

final List<Course> demoCourses = [
  Course(
    code: 'CSE 101',
    name: 'Introduction to Computer Science',
    professor: 'Dr. Smith',
    color: const Color(0xFF4834D4),
    progress: 0.75,
  ),
  Course(
    code: 'MATH 201',
    name: 'Linear Algebra',
    professor: 'Dr. Johnson',
    color: const Color(0xFF6C5CE7),
    progress: 0.60,
  ),
  Course(
    code: 'PHY 301',
    name: 'Quantum Mechanics',
    professor: 'Dr. Williams',
    color: const Color(0xFFa55eea),
    progress: 0.45,
  ),
  Course(
    code: 'ENG 202',
    name: 'Technical Writing',
    professor: 'Prof. Davis',
    color: const Color(0xFF8C7AE6),
    progress: 0.90,
  ),
];
