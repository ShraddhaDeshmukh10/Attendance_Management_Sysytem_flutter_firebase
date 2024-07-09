import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class attend01 extends StatefulWidget {
  const attend01({Key? key}) : super(key: key);

  @override
  State<attend01> createState() => _attend01State();
}

class _attend01State extends State<attend01> {
  List<int> classList = [1, 2, 3, 4];
  int? selectedIntItem = 1;

  List<String> divList = ['IT', 'Comps', 'EXTC', 'AIML', 'Civil', 'Auto'];
  String? selectedStringItem = 'IT';

  TextEditingController nameController = TextEditingController();
  TextEditingController rollnoController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp().catchError((error) {
      print("Failed to initialize Firebase: $error");
    });
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://californiapayroll.com/wp-content/uploads/2022/01/time-banner-image-is-1154340468.png"))),
        width: 0.9 * w,
        height: 0.7 * h,
        child: Column(
          children: [
            Container(
              width: 0.7 * w,
              height: 0.1 * h,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: "Name"),
              ),
            ),
            Container(
              width: 0.7 * w,
              height: 0.1 * h,
              child: TextField(
                controller: rollnoController,
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: "Roll No"),
              ),
            ),
            Container(
              width: 0.2 * w,
              height: 0.06 * h,
              decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.all(10),
              child: DropdownButton<int>(
                value: selectedIntItem,
                items: classList
                    .map((a) => DropdownMenuItem<int>(
                          value: a,
                          child: Text(a.toString(),
                              style: TextStyle(fontSize: 15)),
                        ))
                    .toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedIntItem = newValue;
                  });
                },
              ),
            ),
            Container(
              width: 0.2 * w,
              height: 0.06 * h,
              decoration: BoxDecoration(border: Border.all()),
              child: DropdownButton<String>(
                value: selectedStringItem,
                items: divList
                    .map((a) => DropdownMenuItem<String>(
                          value: a,
                          child: Text(a, style: TextStyle(fontSize: 15)),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStringItem = newValue;
                  });
                },
              ),
            ),
            Container(
              width: 0.7 * w,
              height: 0.1 * h,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Add Date of Admission',
                  filled: true,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
            ),
            Container(
              width: 0.2 * w,
              height: 0.07 * h,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('students')
                      .doc(nameController.text)
                      .set({
                    'name': nameController.text,
                    'rollNo': rollnoController.text,
                    'class': selectedIntItem,
                    'division': selectedStringItem,
                    'date': _dateController.text,
                  }).then((value) {
                    nameController.clear();
                    rollnoController.clear();
                    setState(() {
                      selectedIntItem = null;
                      selectedStringItem = 'IT';
                    });
                    Get.snackbar(
                      "Success!!!",
                      "Student added successfully",
                      snackPosition: SnackPosition.TOP,
                    );
                  }).catchError((error) {
                    print("Failed to add student: $error");
                  });
                },
                child: Text("Add"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
