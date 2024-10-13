import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _workoutsCollection = FirebaseFirestore.instance.collection('workouts');

  // Add a workout to Firestore
  Future<void> addWorkout(String userId, String exerciseType, int duration, String intensity) async {
    await _workoutsCollection.add({
      'userId': userId,
      'exerciseType': exerciseType,
      'duration': duration,
      'intensity': intensity,
      'timestamp': Timestamp.now(),
    });
    // Removed the return statement
  }

  // Get workouts for a specific user
  Stream<QuerySnapshot> getWorkouts(String userId) {
    return _workoutsCollection.where('userId', isEqualTo: userId).orderBy('timestamp', descending: true).snapshots();
  }
}
