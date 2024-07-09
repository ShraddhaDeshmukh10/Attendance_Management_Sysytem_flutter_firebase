import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class nxt_attend extends StatefulWidget {
  final String studentName;
  final String calendarDate;
  const nxt_attend({
    required this.studentName,
    required this.calendarDate,
    Key? key,
  }) : super(key: key);

  @override
  State<nxt_attend> createState() => _nxt_attendState();
}

class _nxt_attendState extends State<nxt_attend> {
  TextEditingController _dateController = TextEditingController();
  List<String> attendanceDates = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceKeys().then((keys) {
      setState(() {
        attendanceDates = keys;
      });
    });
  }

  Future<List<String>> _fetchAttendanceKeys() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(widget.studentName)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        List<String> attendanceKeys =
            data.keys.where((key) => key.contains('attendance')).toList();
        print('Attendance keys: $attendanceKeys');
        return attendanceKeys;
      } else {
        print('Student document does not exist');
        return [];
      }
    } catch (error) {
      print('Failed to fetch attendance keys: $error');
      return [];
    }
  }

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDayOfMonth,
      lastDate: lastDayOfMonth,
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _addAttendance() async {
    FirebaseFirestore.instance
        .collection('students')
        .doc(widget.studentName)
        .set({
      'attendance:${_dateController.text}': true,
    }, SetOptions(merge: true)).then((_) {
      print('Attendance added successfully');
      setState(() {
        attendanceDates.add(_dateController.text);
      });
      Get.snackbar(
        "Done",
        "Student attendance added successfully",
        snackPosition: SnackPosition.TOP,
      );
    }).catchError((error) {
      print("Failed to add attendance: $error");
    });
  }

  Future<void> _deleteAttendance(String date) async {
    FirebaseFirestore.instance
        .collection('students')
        .doc(widget.studentName)
        .update({
      'attendance:$date': FieldValue.delete(),
    }).then((_) {
      print('Attendance deleted successfully');
      setState(() {
        attendanceDates.remove(date);
      });
      Get.snackbar(
        "Done",
        "Student attendance deleted successfully",
        snackPosition: SnackPosition.TOP,
      );
    }).catchError((error) {
      print("Failed to delete attendance: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Student's Record"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://cdni.iconscout.com/illustration/premium/thumb/task-schedule-plan-3949744-3272575.png"))),
        child: Column(
          children: [
            Card(
              child: Container(
                width: 0.5 * w,
                height: 0.1 * h,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Student Name: ${widget.studentName}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              width: 0.5 * w,
              height: 0.1 * h,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Choose Date',
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
              width: 0.5 * w,
              height: 0.1 * h,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  _addAttendance();
                },
                child: Text("Add Attendance"),
              ),
            ),
            Container(
              width: 0.5 * w,
              height: 0.3 * h,
              margin: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Text(
                    "Attendance Dates:  ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  if (attendanceDates.isNotEmpty)
                    ...attendanceDates.map((key) => ListTile(
                          title:
                              Text(key.length > 11 ? key.substring(11) : key),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteAttendance(key);
                            },
                          ),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
