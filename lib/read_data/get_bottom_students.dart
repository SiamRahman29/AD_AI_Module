import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turquoise/core/app_export.dart';

class GetBottomStudents extends StatelessWidget {
  final String documentID;
  final String classID;
  GetBottomStudents({required this.documentID, required this.classID});

  @override
  Widget build(BuildContext context) {
    CollectionReference students = FirebaseFirestore.instance
        .collection('Turquoise')
        .doc('Students')
        .collection('PersonalInfo');

    return FutureBuilder<QuerySnapshot>(
        future: students
            .where('Class', isEqualTo: classID)
            .orderBy('TotalPoints', descending: false)
            .limit(3)
            .get(),
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
                  title: Text("$name - $totalPoints",
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall),
                  //subtitle: Text('Total Points: $totalPoints'),
                );
                topThreeWidgets.add(studentWidget);
              }
              return Column(
                children: topThreeWidgets,
              );
            } else {
              print('${snapshot.error}');
              return Text('Error: ${snapshot.error}');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            print('${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          }
        });
  }
}
