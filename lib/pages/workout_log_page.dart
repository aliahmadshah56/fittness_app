import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class WorkoutLogPage extends StatefulWidget {
  @override
  _WorkoutLogPageState createState() => _WorkoutLogPageState();
}

class _WorkoutLogPageState extends State<WorkoutLogPage> {
  final _formKey = GlobalKey<FormState>();
  String _exerciseType = '';
  int _duration = 0;
  String _intensity = 'Low';

  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Exercise Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an exercise type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _exerciseType = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  _duration = int.parse(value!);
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Intensity'),
                value: _intensity,
                items: ['Low', 'Medium', 'High']
                    .map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _intensity = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    User? user = _auth.currentUser;
                    if (user != null) {
                      await _firestoreService.addWorkout(
                        user.uid,
                        _exerciseType,
                        _duration,
                        _intensity,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Workout Logged!')));
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
