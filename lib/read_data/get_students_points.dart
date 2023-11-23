import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetStudentPoints extends StatelessWidget {
  final String documentID;
  final String classID;
  GetStudentPoints({required this.documentID, required this.classID});

  @override
  Widget build(BuildContext context) {
    CollectionReference students = FirebaseFirestore.instance
        .collection('Turquoise')
        .doc('Students')
        .collection('Classes')
        .doc('Class 1')
        .collection('StudentInfo');

    return FutureBuilder<DocumentSnapshot>(
        future: students.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text("Name: ${data['Name']} - ${data['TotalPoints']}");
          }
          return Text('loading...');
        }));
  }
}
