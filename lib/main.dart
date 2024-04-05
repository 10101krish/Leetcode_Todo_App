import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leetcode_todo_app/screens/landing_screen.dart';

void main() {
  runApp(const ProviderScope(
    child: MaterialApp(
      home: LandingScreen(),
    ),
  ));
}
