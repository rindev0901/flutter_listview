import 'package:flutter/material.dart';
import 'package:flutter_qlnv/models/student.dart';

class MyStudentDetailPage extends StatelessWidget {
  const MyStudentDetailPage({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Thông tin sinh viên: ${student.name} - ${student.code}"),
      ),
    );
  }
}
