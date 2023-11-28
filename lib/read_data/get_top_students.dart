import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turquoise/core/app_export.dart';


class GetTopStudents extends StatelessWidget {
  final String documentID;
  final String classID;
  GetTopStudents({required this.documentID, required this.classID});
/*
  @override
  Widget build(BuildContext context) {
    CollectionReference students = FirebaseFirestore.instance
        .collection('Turquoise')
        .doc('Students')
        .collection('PersonalInfo');

    return FutureBuilder<DocumentSnapshot>(
        future: students.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data!.exists) {
              // Check if data is not null and the document exists
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text("${data['Name']} - ${data['TotalPoints']}");
            } else {
              return Text('Document does not exist.');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading...');
          } else {
            return Text('Error: ${snapshot.error}');
          }
        }));
  }
*/
  @override
  Widget build(BuildContext context) {
    CollectionReference students = FirebaseFirestore.instance
        .collection('Turquoise')
        .doc('Students')
        .collection('PersonalInfo');

    return FutureBuilder<QuerySnapshot>(
        future:
            students.orderBy('TotalPoints', descending: true).limit(3).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              // Check if data is not null and the document exists
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<Widget> topThreeWidgets = [];
              for (DocumentSnapshot document in documents) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String name = data['Name'];
                int totalPoints = data['TotalPoints'];
                Widget studentWidget = ListTile(
              title: Text("$name - $totalPoints", overflow: TextOverflow.ellipsis, style: theme.textTheme.headlineSmall),
              //subtitle: Text('Total Points: $totalPoints'),
            );
            topThreeWidgets.add(studentWidget);
              }
              return Column(
                children: topThreeWidgets,
              );
            } else {
              return Text('Document does not exist.');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading...');
          } else {
            return Text('Error: ${snapshot.error}');
          }
        });
  }
}
