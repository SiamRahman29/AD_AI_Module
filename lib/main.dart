import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turquoise/theme/theme_helper.dart';
import 'package:turquoise/routes/app_routes.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'turquoise',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.aiDashboardScreen,
      routes: AppRoutes.routes,
    );
  }
}
