import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to your Fitness Tracker!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/workout_log');
              },
              child: Text('Log Workout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/goals');
              },
              child: Text('Set Goals'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/progress');
              },
              child: Text('View Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
