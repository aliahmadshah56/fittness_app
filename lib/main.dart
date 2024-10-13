import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'auth/signup_page.dart';
import 'auth/login_page.dart';
import 'services/auth_service.dart';
import 'pages/home_page.dart';
import 'pages/workout_log_page.dart';
import 'pages/goals_page.dart';
import 'pages/progress_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Fitness Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(),
          '/home': (context) => HomePage(),
          '/workout_log': (context) => WorkoutLogPage(),
          '/goals': (context) => GoalsPage(),
          '/progress': (context) => ProgressPage(),
        },
      ),
    );
  }
}
