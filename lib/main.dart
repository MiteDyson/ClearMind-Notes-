// lib/main.dart

import 'package:flutter/material.dart';
import 'package:clearmind_app/screens/journal_entry_screen.dart';

void main() {
  runApp(ClearmindApp());
}

class ClearmindApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clearmind',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JournalEntryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
