import 'package:flutter/material.dart';

class TechnicianModel {
  final String nama;
  final String cawangan;
  final String email;
  final String photoURL;
  final String jawatan;
  final int jumlahKeuntungan;
  final int jumlahRepair;

  TechnicianModel(
      {@required this.nama,
      @required this.cawangan,
      @required this.email,
      @required this.photoURL,
      @required this.jawatan,
      @required this.jumlahKeuntungan,
      @required this.jumlahRepair});

  factory TechnicianModel.fromFirebase(Map<dynamic, dynamic> firebase) =>
      TechnicianModel(
        nama: firebase['nama'],
        cawangan: firebase['cawangan'],
        email: firebase['email'],
        photoURL: firebase['photoURL'],
        jawatan: firebase['jawatan'],
        jumlahKeuntungan: firebase['jumlahKeuntungan'],
        jumlahRepair: firebase['jumlahRepair'],
      );
}
