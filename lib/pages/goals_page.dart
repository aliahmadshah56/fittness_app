import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final _formKey = GlobalKey<FormState>();
  String _goalDescription = '';
  int _targetValue = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _goalsCollection = FirebaseFirestore.instance.collection('goals');

  Future<void> _setGoal() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _goalsCollection.add({
        'userId': user.uid,
        'goalDescription': _goalDescription,
        'targetValue': _targetValue,
        'timestamp': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Fitness Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Goal Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _goalDescription = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Target Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid target';
                  }
                  return null;
                },
                onSaved: (value) {
                  _targetValue = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _setGoal();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Goal Set!')));
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
