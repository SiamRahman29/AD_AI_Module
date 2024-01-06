import 'package:flutter/material.dart';
import 'package:turquoise/core/app_export.dart';
import 'package:turquoise/widgets/custom_outlined_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class SuggestionsScreen extends StatelessWidget {
  SuggestionsScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchDeedsData(String className) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> deedDocument =
          await FirebaseFirestore.instance
              .collection('Turquoise')
              .doc('ForSuggestion')
              .collection('PointsFromDeeds')
              .doc(className)
              .get();

      Map<String, dynamic> deedData = deedDocument.data() ?? {};
      return deedData;
    } catch (e) {
      print("Error fetching deed data: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchAveragesData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> averagesDocument =
          await FirebaseFirestore.instance
              .collection('Turquoise')
              .doc('ForSuggestion')
              .collection('SchoolAverages')
              .doc('Averages')
              .get();

      Map<String, dynamic> averagesData =
          averagesDocument.data() as Map<String, dynamic>;
      return averagesData;
    } catch (e) {
      print("Error fetching school averages: $e");
      return {};
    }
  }

  String? leastPointsField1;
  String? leastPointsField2;
  String? mostPointsField1;
  String? mostPointsField2;

  int leastPointsField1Averages = 0;
  int leastPointsField2Averages = 0;
  int mostPointsField1Averages = 0;
  int mostPointsField2Averages = 0;

  int leastPointsField1Points = 0;
  int leastPointsField2Points = 0;
  int mostPointsField1Points = 0;
  int mostPointsField2Points = 0;

  double leastPointsDiff1 = 0;
  double leastPointsDiff2 = 0;
  double mostPointsDiff1 = 0;
  double mostPointsDiff2 = 0;

  @override
  Widget build(BuildContext context) {
    String className =
        ModalRoute.of(context)?.settings.arguments as String? ?? "1 Itqaan";
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle697x430,
                height: 97.v,
                width: 430.h,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgRectangle543x430,
                height: 43.v,
                width: 430.h,
              ),
              SizedBox(height: 42.v),
              FutureBuilder<Map<String, dynamic>>(
            future: fetchDeedsData(className),
            builder: (context, deedSnapshot) {
              if (deedSnapshot.connectionState == ConnectionState.done) {
                if (deedSnapshot.hasError) {
                  return Center(child: Text('Error: ${deedSnapshot.error}'));
                } else {
                  Map<String, dynamic> deedData = deedSnapshot.data ?? {};
                  // Sort entries by points in ascending order
                  var sortedEntries = deedData.entries.toList()
                    ..sort((a, b) => a.value.compareTo(b.value));

                  // Take the two entries with the least points
                  var leastPointsEntries = sortedEntries.take(2).toList();
                  if (leastPointsEntries.length >= 1) {
                    leastPointsField1 = leastPointsEntries[0].key;
                    leastPointsField1Points = leastPointsEntries[0].value;
                  }
                  if (leastPointsEntries.length >= 2) {
                    leastPointsField2 = leastPointsEntries[1].key;
                    leastPointsField2Points = leastPointsEntries[1].value;
                  }

                  // Sort entries by points in descending order
                  sortedEntries.sort((a, b) => b.value.compareTo(a.value));

                  // Take the two entries with the most points
                  var mostPointsEntries = sortedEntries.take(2).toList();
                  if (mostPointsEntries.length >= 1) {
                    mostPointsField1 = mostPointsEntries[0].key;
                    mostPointsField1Points = mostPointsEntries[0].value;
                  }
                  if (mostPointsEntries.length >= 2) {
                    mostPointsField2 = mostPointsEntries[1].key;
                    mostPointsField2Points = mostPointsEntries[1].value;
                  }

                  return FutureBuilder<Map<String, dynamic>>(
                    future: fetchAveragesData(),
                    builder: (context, averagesSnapshot) {
                      if (averagesSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (averagesSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${averagesSnapshot.error}'));
                        } else {
                          Map<String, dynamic> averagesData =
                              averagesSnapshot.data as Map<String, dynamic>;

                          // ... rest of your code to calculate differences
                          leastPointsField1Averages =
                              averagesData[leastPointsField1] ?? 0;
                          leastPointsField2Averages =
                              averagesData[leastPointsField2] ?? 0;
                          mostPointsField1Averages =
                              averagesData[mostPointsField1] ?? 0;
                          mostPointsField2Averages =
                              averagesData[mostPointsField2] ?? 0;
                          leastPointsDiff1 = ((leastPointsField1Averages -
                                      leastPointsField1Points) /
                                  leastPointsField1Averages) *
                              100;
                          leastPointsDiff2 = ((leastPointsField2Averages -
                                      leastPointsField2Points) /
                                  leastPointsField2Averages) *
                              100;
                          mostPointsDiff1 = ((-mostPointsField1Averages +
                                      mostPointsField1Points) /
                                  mostPointsField1Averages) *
                              100;
                          mostPointsDiff2 = ((-mostPointsField2Averages +
                                      mostPointsField2Points) /
                                  mostPointsField2Averages) *
                              100;
                          String truncatedDiff1 = leastPointsDiff1.toStringAsFixed(2);
                          String truncatedDiff2 = leastPointsDiff2.toStringAsFixed(2);
                          String truncatedDiff3 = mostPointsDiff1.toStringAsFixed(2);
                          String truncatedDiff4 = mostPointsDiff2.toStringAsFixed(2);


                          return Align(
                           alignment: Alignment.centerLeft,
                            child: Container(
                              width: 373.h,
                              margin: EdgeInsets.only(left: 21.h, right: 35.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    "Focus Required for Following Areas",
                                    style: theme.textTheme.headlineLarge,
                                  ),
                                  SizedBox(height: 16.0),
                                  // Display the two fields with the least points
                                  ...leastPointsEntries.map((entry) {
                                    return Text(
                                      "${entry.key}: ${entry.value} points",
                                      style: TextStyle(fontSize: 16.0),
                                    );
                                  }).toList(),
                                  SizedBox(height: 32.0),
                                  Text(
                                    "The points are below average by $truncatedDiff1% and $truncatedDiff2%",
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    "Strong Suites",
                                    style: theme.textTheme.headlineLarge,
                                  ),
                                  SizedBox(height: 16.0),
                                  // Display the two fields with the most points
                                  ...mostPointsEntries.map((entry) {
                                    return Text(
                                      "${entry.key}: ${entry.value} points",
                                      style: TextStyle(fontSize: 16.0),
                                    );
                                  }).toList(),
                                  SizedBox(height: 32.0),
                                  Text(
                                    "The points are above average by $truncatedDiff3% and $truncatedDiff4%",
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(height: 65.v),
              CustomOutlinedButton(
                width: 91.h,
                text: "Back",
                margin: EdgeInsets.only(left: 22.h),
                onPressed: () {
                  onTapBack(context);
                },
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 50.v),
        ]),
      ),
      ),
    );
  }

  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.aiDashboardScreen);
  }
}

/*

class SuggestionsScreen extends StatelessWidget {
  SuggestionsScreen({Key? key}) : super(key: key);
  Future<Map<String, dynamic>> fetchDeedsData(String className) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> deedDocument =
          await FirebaseFirestore.instance
              .collection('Turquoise')
              .doc('ForSuggestion')
              .collection('PointsFromDeeds')
              .doc(className)
              .get(); // as DocumentSnapshot<Map<String, dynamic>>;

      Map<String, dynamic> deedData = deedDocument.data() ?? {};
      return deedData;
    } catch (e) {
      print("Error fetching deed data: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchAveragesData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> averagesDocument =
          await FirebaseFirestore.instance
              .collection('Turquoise')
              .doc('ForSuggestion')
              .collection('SchoolAverages')
              .doc('Averages')
              .get();

      Map<String, dynamic> averagesData = averagesDocument.data() as Map<String,dynamic>;
      return averagesData;
    } catch (e) {
      print("Error fetching school averages: $e");
      return {};
    }
  }

  String? leastPointsField1;
  String? leastPointsField2;
  String? mostPointsField1;
  String? mostPointsField2;

  int leastPointsField1Averages = 0;
  int leastPointsField2Averages = 0;
  int mostPointsField1Averages = 0;
  int mostPointsField2Averages = 0;

  int leastPointsField1Points = 0;
  int leastPointsField2Points = 0;
  int mostPointsField1Points = 0;
  int mostPointsField2Points = 0;

  double leastPointsDiff1 = 0;
  double leastPointsDiff2 = 0;
  double mostPointsDiff1 = 0;
  double mostPointsDiff2 = 0;

  @override
  Widget build(BuildContext context) {
    String className =
        ModalRoute.of(context)?.settings.arguments as String? ?? "1 Itqaan";
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle697x430,
                height: 97.v,
                width: 430.h,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgRectangle543x430,
                height: 43.v,
                width: 430.h,
              ),
              SizedBox(height: 42.v),
              FutureBuilder<Map<String, dynamic>>(
                future: fetchDeedsData(
                    className), // Update with the actual class name
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      Map<String, dynamic> deedData = snapshot.data ?? {};

                      // Sort entries by points in ascending order
                      var sortedEntries = deedData.entries.toList()
                        ..sort((a, b) => a.value.compareTo(b.value));

                      // Take the two entries with the least points
                      var leastPointsEntries = sortedEntries.take(2).toList();
                      if (leastPointsEntries.length >= 1) {
                        leastPointsField1 = leastPointsEntries[0].key;
                        leastPointsField1Points = leastPointsEntries[0].value;
                      }
                      if (leastPointsEntries.length >= 2) {
                        leastPointsField2 = leastPointsEntries[1].key;
                        leastPointsField2Points = leastPointsEntries[1].value;
                      }

                      // Sort entries by points in descending order
                      sortedEntries.sort((a, b) => b.value.compareTo(a.value));

                      // Take the two entries with the most points
                      var mostPointsEntries = sortedEntries.take(2).toList();
                      if (mostPointsEntries.length >= 1) {
                        mostPointsField1 = mostPointsEntries[0].key;
                        mostPointsField1Points = mostPointsEntries[0].value;
                      }
                      if (mostPointsEntries.length >= 2) {
                        mostPointsField2 = mostPointsEntries[1].key;
                        mostPointsField2Points = mostPointsEntries[1].value;
                      }
                      FirebaseFirestore.instance
                          .collection('Turquoise')
                          .doc('ForSuggestion')
                          .collection('SchoolAverages')
                          .doc('Averages')
                          .get()
                          .then((averagesDocument) {
                        if (averagesDocument.exists) {
                          Map<String, dynamic> averagesData =
                              averagesDocument.data() as Map<String, dynamic>;
                          print(averagesDocument);
                          // Retrieve the average for the specific field
                          leastPointsField1Averages =
                              averagesData[leastPointsField1] ?? 0;
                          leastPointsField2Averages =
                              averagesData[leastPointsField2] ?? 0;
                          mostPointsField1Averages =
                              averagesData[mostPointsField1] ?? 0;
                          mostPointsField2Averages =
                              averagesData[mostPointsField2] ?? 0;
                          leastPointsDiff1 = ((leastPointsField1Averages -
                                      leastPointsField1Points) /
                                  leastPointsField1Averages) *
                              100;
                          leastPointsDiff2 = ((leastPointsField2Averages -
                                      leastPointsField2Points) /
                                  leastPointsField2Averages) *
                              100;
                          mostPointsDiff1 = ((-mostPointsField1Averages +
                                      mostPointsField1Points) /
                                  mostPointsField1Averages) *
                              100;
                          mostPointsDiff2 = ((-mostPointsField2Averages +
                                      mostPointsField2Points) /
                                  mostPointsField2Averages) *
                              100;
                          // Now we can use leastPointsField1Averages as needed
                          print(
                              'Average for $leastPointsField1Points: $leastPointsField1Averages');
                          print(
                              'Average for $leastPointsField2Points: $leastPointsField2Averages');
                          print(
                              'Average for $leastPointsField1Points: $leastPointsField1Averages');
                          print(
                              'Average for $leastPointsDiff2: $leastPointsDiff1');
                          print(
                              'Average for $mostPointsDiff2: $mostPointsDiff1');
                        }
                      });

                      //print(mostPointsField2);
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 373.h,
                          margin: EdgeInsets.only(left: 21.h, right: 35.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Focus Required for Following Areas",
                                style: theme.textTheme.headlineLarge,
                              ),
                              SizedBox(height: 16.0),
                              // Display the two fields with the least points
                              ...leastPointsEntries.map((entry) {
                                return Text(
                                  "${entry.key}: ${entry.value} points",
                                  style: TextStyle(fontSize: 16.0),
                                );
                              }).toList(),
                              SizedBox(height: 32.0),
                              Text(
                                "The points are below average by $leastPointsDiff1% and $leastPointsDiff2%",
                                style: theme.textTheme.headlineSmall,
                              ),
                              Text(
                                "Strong Suites",
                                style: theme.textTheme.headlineLarge,
                              ),
                              SizedBox(height: 16.0),
                              // Display the two fields with the most points
                              ...mostPointsEntries.map((entry) {
                                return Text(
                                  "${entry.key}: ${entry.value} points",
                                  style: TextStyle(fontSize: 16.0),
                                );
                              }).toList(),
                              SizedBox(height: 32.0),
                              Text(
                                "The points are above average by $mostPointsDiff1% and $mostPointsDiff2%",
                                style: theme.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: 65.v),
              CustomOutlinedButton(
                width: 91.h,
                text: "Back",
                margin: EdgeInsets.only(left: 22.h),
                onPressed: () {
                  onTapBack(context);
                },
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 50.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the aiDashboardScreen when the action is triggered.
  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.aiDashboardScreen);
  }
}
*/