import 'package:firebase_03/attendance_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class student_admin extends StatelessWidget {
  const student_admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              Get.to(search_01());
              Get.snackbar("Add you attendace", "Based on your Class");
            },
            child: Text("Student")),
      ),
    ));
  }
}
