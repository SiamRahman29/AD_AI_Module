import 'package:flutter/material.dart';
import 'package:turquoise/core/app_export.dart';
import 'package:turquoise/widgets/custom_outlined_button.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle697x430,
                      height: 97.v,
                      width: 430.h),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle543x430,
                      height: 43.v,
                      width: 430.h),
                  SizedBox(height: 42.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          width: 373.h,
                          margin: EdgeInsets.only(left: 21.h, right: 35.h),
                          child: Text(
                              "Focus Required for Following Areas\n\nThrowing trash: 15% below school average\nGiving Salam: 17% below school average and lowest in school\n\nStrong Suites\n\nParticipation in activities\nHelping classmates",
                              maxLines: 14,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineLarge))),
                  SizedBox(height: 65.v),
                  CustomOutlinedButton(
                      width: 91.h,
                      text: "Back",
                      margin: EdgeInsets.only(left: 22.h),
                      onPressed: () {
                        onTapBack(context);
                      },
                      alignment: Alignment.centerLeft),
                  SizedBox(height: 50.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle839x430,
                      height: 39.v,
                      width: 430.h)
                ]))));
  }

  /// Navigates to the aiDashboardScreen when the action is triggered.
  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.aiDashboardScreen);
  }
}
