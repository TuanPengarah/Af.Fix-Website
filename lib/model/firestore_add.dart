import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAppointment {
  final String name;
  final String noPhone;
  final String email;
  final String model;
  final String problem;
  final BuildContext context;

  AddAppointment(
      {@required this.name,
      @required this.noPhone,
      @required this.email,
      @required this.model,
      @required this.problem,
      @required this.context});

  addToFirestore() async {
    CollectionReference _addAppointment =
        FirebaseFirestore.instance.collection('appointment');
    Map<String, dynamic> appointment = {
      'Nama': name,
      'Nombor Tel': noPhone,
      'Email': email,
      'Model': model,
      'Masalah': problem
    };
    await _addAppointment.doc().set(appointment).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Berjaya'),
            ),
          ),
        );
  }
}
