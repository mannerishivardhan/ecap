import 'package:ecap/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ecap/core/theme/app_theme.dart';
import 'package:ecap/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Cap',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
