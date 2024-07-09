import 'package:firebase_03/attendance_student.dart';
import 'package:firebase_03/teacher_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class front_pg extends StatelessWidget {
  const front_pg({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login To Your Account",
          style: TextStyle(fontSize: 30),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://media.istockphoto.com/id/1351249861/vector/office-software-attendance-management-business-concept-infographics-for-web-banner-calendar.jpg?s=612x612&w=0&k=20&c=z9PgaX2Z1ArGDXZmwLkxWCxI8LAgd109trO85bB9aLI="))),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: 0.3 * w,
              height: 0.1 * h,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(search_01());
                  Get.snackbar("Have A Nice Day", "Enter Your  Login ID",
                      snackPosition: SnackPosition.BOTTOM);
                },
                child: Text("Student"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 0.3 * w,
              height: 0.1 * h,
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(teacher_log());
                    Get.snackbar("Have a Nice Day", "Student Login");
                  },
                  child: Text("Teacher"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)))),
            )
          ],
        ),
      ),
    );
  }
}
