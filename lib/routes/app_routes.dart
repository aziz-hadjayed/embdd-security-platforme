import 'package:flutter/material.dart';
import '../screens/loading.dart'; // Import du SplashScreen
import '../screens/home.dart'; // Import du WelcomeScreen

class AppRoutes {
  //definition des noms des routes
  static const String loading = '/';
  static const String bienvenu = '/home';

  //Map des routes associant les noms aux widgets
  static final Map<String, WidgetBuilder> routes = {
    loading: (context) => LoadingScreen(),
    bienvenu: (context) => HomeScreen(),
  };

  static String settings = '/home';

  static String home = '/home';
}
