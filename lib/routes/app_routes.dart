import 'package:flutter/material.dart';
import 'package:turquoise/presentation/ai_dashboard_screen/ai_dashboard_screen.dart';
import 'package:turquoise/presentation/suggestions_screen/suggestions_screen.dart';
import 'package:turquoise/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:turquoise/make_charts/create_chart.dart';

class Arguments {
  final String graphClassName;

  Arguments({required this.graphClassName});
  
}

class AppRoutes {
  static const String aiDashboardScreen = '/ai_dashboard_screen';

  static const String suggestionsScreen = '/suggestions_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String chartsScreen = '/create_chart';

  
  static Map<String, WidgetBuilder> routes = {
    aiDashboardScreen: (context) => AiDashboardScreen(),
    suggestionsScreen: (context) => SuggestionsScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    chartsScreen: (context) {
      //final args = arguments as Arguments;
      return ChartsScreen(
        documentIds: ["1 Itqaan", "1 Ikhlas", "1 Ihsaan"],
        lineColors: [
          Colors.blue,
          Colors.teal,
          Colors.red,
          /*
            Colors.pink,
            Colors.purple,
            Colors.indigo,
            Colors.cyan,
            Colors.lime,
            Colors.deepOrange,
            Colors.lightGreen,
            Colors.brown,
            Colors.lightBlue,
            Colors.yellow,
            Colors.deepPurple,
            Colors.orange,
            Colors.tealAccent,
            Colors.lightGreenAccent,
            Colors.pinkAccent,
            Colors.limeAccent
            */
        ],
        graphClass: "SchoolOveralls",
        onGraphClassChanged: (newGraphClass) {
          // Handle the updated graphClass value if needed
          print("Selected graph class: $newGraphClass");
        }
      );
    },
  };
}
