import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class attend_search01 extends StatefulWidget {
  const attend_search01({super.key});

  @override
  State<attend_search01> createState() => _attend_search01State();
}

class _attend_search01State extends State<attend_search01> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://netchex.com/wp-content/uploads/2022/06/Employee-Time-Tracking-1400.jpg"))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (_) {
                  setState(() {}); // Trigger rebuild when text changes
                },
                decoration: InputDecoration(
                  labelText: 'Search by Name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
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
                    String name = doc['name'].toString().toLowerCase();
                    String searchQuery = _searchController.text.toLowerCase();
                    return name.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredDocuments.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot student = filteredDocuments[index];
                      int totalAttendance = countAttendance(student);
                      return Card(
                        child: ListTile(
                          title: Text(student['name']),
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
    return data.keys
        .where((key) => key.contains('attendance'))
        .fold(0, (acc, key) => acc + (data[key] as bool ? 1 : 0));
  }
}
