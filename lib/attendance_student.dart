import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_03/add_date_stu.dart';
import 'package:flutter/material.dart';

class search_01 extends StatefulWidget {
  const search_01({Key? key}) : super(key: key);

  @override
  State<search_01> createState() => _search_01State();
}

class _search_01State extends State<search_01> {
  int? selectedClass;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://media.istockphoto.com/id/1351249861/vector/office-software-attendance-management-business-concept-infographics-for-web-banner-calendar.jpg?s=612x612&w=0&k=20&c=z9PgaX2Z1ArGDXZmwLkxWCxI8LAgd109trO85bB9aLI="))),
        child: Column(
          children: [
            Container(
              width: 0.5 * w,
              height: 0.1 * h,
              decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.all(10),
              child: DropdownButton<int>(
                value: selectedClass,
                hint: Text('  Select Class'),
                onChanged: (newValue) {
                  setState(() {
                    selectedClass = newValue;
                  });
                },
                items: [1, 2, 3, 4].map((classNumber) {
                  return DropdownMenuItem<int>(
                    value: classNumber,
                    child: Text('     Class $classNumber'),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List<QueryDocumentSnapshot> documents =
                      snapshot.data!.docs;

                  List<QueryDocumentSnapshot> filteredDocuments =
                      documents.where((doc) {
                    return doc['class'] == selectedClass;
                  }).toList();

                  if (_searchController.text.isNotEmpty) {
                    filteredDocuments = filteredDocuments.where((doc) {
                      String name = doc['name'].toString().toLowerCase();
                      String searchQuery = _searchController.text.toLowerCase();
                      return name.contains(searchQuery);
                    }).toList();
                  }

                  return ListView.builder(
                    itemCount: filteredDocuments.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot student = filteredDocuments[index];
                      int totalAttendance = countAttendance(student);
                      return Card(
                        child: ListTile(
                          title: GestureDetector(
                            child: Text(student['name']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => nxt_attend01(
                                    calendarDate: student['date'],
                                    studentName: student['name'],
                                  ),
                                ),
                              );
                            },
                          ),
                          subtitle: Text("Roll No: ${student['rollNo']}"),
                          trailing: Text(
                            "Total Attendance: $totalAttendance",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int countAttendance(QueryDocumentSnapshot student) {
    Map<String, dynamic> data = student.data() as Map<String, dynamic>;
    List<String> attendanceKeys =
        data.keys.where((key) => key.contains('attendance')).toList();
    print('Attendance keys: $attendanceKeys');
    int trueCount = 0;
    for (String key in attendanceKeys) {
      if (data[key] == true) {
        trueCount++;
      }
    }
    print('Attendance count: $trueCount');

    return trueCount;
  }
}
