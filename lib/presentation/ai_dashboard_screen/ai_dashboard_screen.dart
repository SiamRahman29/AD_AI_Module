import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turquoise/core/app_export.dart';
import 'package:turquoise/widgets/custom_drop_down.dart';
import 'package:turquoise/widgets/custom_outlined_button.dart';
import 'package:turquoise/read_data/get_top_students.dart';
import 'package:turquoise/read_data/get_bottom_students.dart';

// ignore_for_file: must_be_immutable
class AiDashboardScreen extends StatefulWidget {
  AiDashboardScreen({Key? key}) : super(key: key);

  @override
  _AiDashboardScreenState createState() => _AiDashboardScreenState();
}

class _AiDashboardScreenState extends State<AiDashboardScreen> {
  

  List<String> dropdownItemList = [
    "1 Itqaan",
    "1 Ikhlas",
    "1 Ihsaan",
    "1 Tawakal",
    "2 Suhail",
    "2 Unais",
    "2 Saad",
    "2 Zubair",
    "3 Badar",
    "3 Uhud",
    "3 Mu'tah",
    "3 Hunain",
    "4 Al Banna",
    "4 Qutb",
    "4 Qardhawi",
    "5 Hanbali",
    "5 Hanafi",
    "5 Syafie",
    "6 Nawawi",
    "6 Bukhari"
  ];

  List<String> dropdownItemList1 = [
    "1 Itqaan",
    "1 Ikhlas",
    "1 Ihsaan",
    "1 Tawakal",
    "2 Suhail",
    "2 Unais",
    "2 Saad",
    "2 Zubair",
    "3 Badar",
    "3 Uhud",
    "3 Mu'tah",
    "3 Hunain",
    "4 Al Banna",
    "4 Qutb",
    "4 Qardhawi",
    "5 Hanbali",
    "5 Hanafi",
    "5 Syafie",
    "6 Nawawi",
    "6 Bukhari",
    "School Overalls"
  ];

  //list of holding good deed document ids
  List<String> docIDs = [];
  //get document ids
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Turquoise')
        .doc('Students')
        .collection('PersonalInfo')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((element) {
            print(element.reference);
            docIDs.add(element.reference.id);
          }),
        );
  }

  Future<void> func() async {
    await getDocId();
  }

  String className = "default";

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgRectangle6,
                          height: 97.v,
                          width: 430.h),
                      CustomImageView(
                          imagePath: ImageConstant.imgRectangle5,
                          height: 43.v,
                          width: 430.h),
                      SizedBox(height: 31.v),
                      Padding(
                          padding: EdgeInsets.only(left: 23.h),
                          child: CustomDropDown(
                              width: 192.h,
                              icon: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      12.h, 13.v, 18.h, 13.v),
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgLocation,
                                      height: 15.v,
                                      width: 25.h)),
                              hintText: "Choose Class",
                              items: dropdownItemList,
                              onChanged: (value) {
                                setState(() {
                                  className = value;
                                });
                                  
                              
                              })),
                      SizedBox(height: 42.v),
                      Padding(
                          padding: EdgeInsets.only(left: 33.h, right: 111.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 1.v),
                                    child: Text("Top 3",
                                        style: theme.textTheme.headlineSmall)),
                                Text("Bottom 3",
                                    style: theme.textTheme.headlineSmall)
                              ])),
                      SizedBox(height: 12.v),
                      Row(
                        children: [
                          Expanded(
                            child: FutureBuilder(
                              future: getDocId(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (!snapshot.hasError) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: GetTopStudents(
                                            documentID: docIDs[
                                                0], // Change the index as needed
                                            classID: className,
                                          ),
                                        ),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: GetBottomStudents(
                                            documentID: docIDs[
                                                0], // Change the index as needed
                                            classID: className,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text('Error loading data.');
                                  }
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else {
                                  return Text('Error: ${snapshot.error}');
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      /*Row(children: [
                      Expanded(
                          child: FutureBuilder(
                              future: getDocId(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    itemCount: docIDs.length,
                                    itemBuilder: ((context, index) {
                                      return GetTopStudents(
                                          documentID: docIDs[index],
                                          classID: "Class 1");
                                    }));
                              })),
                      SizedBox(width: 16.0),
                      
                      Expanded(
                          child: FutureBuilder(
                              future: getDocId(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    itemCount: docIDs.length,
                                    itemBuilder: ((context, index) {
                                      return GetBottomStudents(
                                          documentID: docIDs[index],
                                          classID: "Class 1");
                                    }));
                              })),


                      ]),*/
                      /*Container(
                          width: 124.h,
                          margin: EdgeInsets.only(left: 33.h),
                          child: Text("A - 150 pts\nB - 147 pts\nC - 139 pts",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineSmall)),
                      */
                      /*
                      Expanded(
                          child: FutureBuilder(
                              future: getDocId(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    itemCount: docIDs.length,
                                    itemBuilder: ((context, index) {
                                      return GetTopStudents(
                                          documentID: docIDs[index],
                                          classID: "Class 1");
                                    }));
                              })),
                      SizedBox(height: 63.v),
                      
                      Expanded(
                          child: FutureBuilder(
                              future: getDocId(),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    itemCount: docIDs.length,
                                    itemBuilder: ((context, index) {
                                      return GetBottomStudents(
                                          documentID: docIDs[index],
                                          classID: "Class 1");
                                    }));
                              })),
                      SizedBox(height: 63.v),
                      */
                      Container(
                          height: 68.v,
                          width: 221.h,
                          margin: EdgeInsets.only(left: 24.h),
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                                child: CustomOutlinedButton(
                              width: 400.h,
                              text: "Cadangan",
                              onPressed: () {
                                onTapView(context);
                              },
                            ))
                          ])),
                      SizedBox(height: 31.v),
                      Padding(
                          padding: EdgeInsets.only(left: 35.h),
                          child: Text("Kemajuan",
                              style: theme.textTheme.headlineSmall)),
                      SizedBox(height: 21.v),
                      Padding(
                          padding: EdgeInsets.only(left: 26.h),
                          child: CustomDropDown(
                              width: 221.h,
                              icon: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      15.h, 12.v, 9.h, 12.v),
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgLocation,
                                      height: 15.v,
                                      width: 25.h)),
                              hintText: "Graph Mode",
                              items: dropdownItemList1,
                              onChanged: (value) {})),
                      SizedBox(height: 31.v),
                      Container(
                          width: 221.h,
                          margin: EdgeInsets.only(left: 26.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.h, vertical: 2.v),
                          decoration: AppDecoration.outlineBlack.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder20),
                          child: Text("Graf",
                              style: theme.textTheme.headlineSmall)),
                      SizedBox(height: 28.v),
                      CustomOutlinedButton(
                          width: 91.h,
                          text: "Back",
                          margin: EdgeInsets.only(left: 26.h)),
                      SizedBox(height: 48.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgRectangle8,
                          height: 39.v,
                          width: 430.h)
                    ]))));
  }

  /// Navigates to the suggestionsScreen when the action is triggered.
  onTapView(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.suggestionsScreen);
  }
}
