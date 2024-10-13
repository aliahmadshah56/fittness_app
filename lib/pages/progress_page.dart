import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class ProgressPage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    if (user == null) return Container();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Progress'),
      ),
      body: StreamBuilder(
        stream: _firestoreService.getWorkouts(user.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<FlSpot> dataPoints = [];
          snapshot.data!.docs.asMap().forEach((index, workout) {
            dataPoints.add(FlSpot(
              index.toDouble(),
              (workout['duration'] as int).toDouble(),
            ));
          });

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: dataPoints,
                  isCurved: true,
                  barWidth: 4,
                  // Replace 'colors' with 'belowBarData'
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [Colors.blue.withOpacity(0.3), Colors.lightBlue.withOpacity(0.3)],
                    ),
                  ),
                  // Define the colors using 'gradient'
                  dotData: FlDotData(show: true),
                  color: Colors.blue, // Set a solid color if needed
                  // Add a gradient to the line itself if desired
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                  ),
                ),
              ],
            )),
          );
        },
      ),
    );
  }
}
