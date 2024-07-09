import 'package:firebase_03/hidd_draw.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signup01 extends StatelessWidget {
  const signup01({super.key});
  void validation() {}
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    TextEditingController nameController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://blog.cdn.cmarix.com/blog/wp-content/uploads/2022/05/Attendance-Management-System.png"))),
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 0.8 * w,
                height: 0.1 * h,
                margin: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  "Login to your Account",
                  style: TextStyle(fontSize: 20),
                )),
              ),
              Container(
                width: 0.8 * w,
                height: 0.03 * h,
                margin: EdgeInsets.only(top: 10),
                child: Text("First Name"),
              ),
              Container(
                width: 0.8 * w,
                height: 0.07 * h,
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(CupertinoIcons.profile_circled),
                    hintText: "Your First Name",
                  ),
                ),
              ),
              Container(
                width: 0.8 * w,
                height: 0.03 * h,
                margin: EdgeInsets.only(top: 20),
                child: Text("Password"),
              ),
              Container(
                width: 0.8 * w,
                height: 0.07 * h,
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(CupertinoIcons.lock),
                    hintText: "Your password",
                  ),
                ),
              ),
              Container(
                  width: 0.8 * w,
                  height: 0.07 * h,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent)),
                      onPressed: () {
                        String name = nameController.text;
                        String pass = passController.text;
                        if (name == "shraddha" && pass == "123456") {
                          Get.offAll(HiddenDrawer01());
                          Get.snackbar("Success", "Welcome");
                        } else {
                          Get.snackbar(
                              "Please enter correct Username or Password",
                              "Try Again");
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
            ],
          )),
    );
  }
}
