import 'package:flutter/material.dart';
import 'package:turquoise/presentation/ai_dashboard_screen/ai_dashboard_screen.dart';
import 'package:turquoise/presentation/suggestions_screen/suggestions_screen.dart';
import 'package:turquoise/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:turquoise/make_charts/create_chart.dart';

class AppRoutes {
  static const String aiDashboardScreen = '/ai_dashboard_screen';

  static const String suggestionsScreen = '/suggestions_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String chartsScreen = '/create_chart';

  static Map<String, WidgetBuilder> routes = {
    aiDashboardScreen: (context) => AiDashboardScreen(),
    suggestionsScreen: (context) => SuggestionsScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    chartsScreen: (context) => ChartsScreen(isShowingMainData: true)
  };
}
