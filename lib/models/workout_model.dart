import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  String exerciseType;
  int duration;
  String intensity;
  DateTime timestamp;

  Workout({
    required this.exerciseType,
    required this.duration,
    required this.intensity,
    required this.timestamp,
  });

  // Create a Workout from Firestore document
  factory Workout.fromMap(Map<String, dynamic> data) {
    return Workout(
      exerciseType: data['exerciseType'],
      duration: data['duration'],
      intensity: data['intensity'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Convert the Workout object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'exerciseType': exerciseType,
      'duration': duration,
      'intensity': intensity,
      'timestamp': timestamp,
    };
  }
}
