import 'package:affix_web/screen/e-warranty/ui/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:string_validator/string_validator.dart';

StreamBuilder<QuerySnapshot> historyRepairPage(
    String _uidText, String _name, bool isDark) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('customer')
        .doc(_uidText)
        .collection('repair history')
        .orderBy('timeStamp', descending: true)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
              SizedBox(height: 15),
              Text('Loading...'),
            ],
          ),
        );
      } else if (snapshot.data.docs.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    MaterialCommunityIcons.close_octagon_outline,
                    color: Colors.grey,
                    size: 120,
                  ),
                  SizedBox(height: 15),
                  SelectableText(
                    'Maaf $_name nampak gayanya waranti anda sudah tamat atau anda tidak mempunyai sebarang waranti daripada kami',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ]),
          ),
        );
      }
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                'Peranti anda yang telah baiki',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: snapshot.data.docs.map((document) {
                  bool warranty = document['isWarranty'];
                  bool isRepair = equals('Belum Selesai', document['Status']);
                  return warrantyCard(
                      context: context,
                      phoneModel: document['Model'],
                      harga: document['Harga'],
                      rosak: document['Kerosakkan'],
                      uid: document['MID'],
                      warrantyStart: document['Tarikh'],
                      warrantyAkhir: document['Tarikh Waranti'],
                      warrantiKe: warranty,
                      isDark: isDark,
                      tengahRepair: isRepair);
                }).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}
