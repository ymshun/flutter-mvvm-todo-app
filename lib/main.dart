import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/presentation/home/home_page.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: HomePage())));
}
