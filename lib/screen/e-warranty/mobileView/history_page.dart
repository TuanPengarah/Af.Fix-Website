import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/screen/e-warranty/ui/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

StreamBuilder<QuerySnapshot> historyRepairPage(
    String _uidText, String _name, bool isDark, bool isMobile) {
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
                    Icons.browser_not_supported,
                    color: Colors.grey,
                    size: 120,
                  ),
                  SizedBox(height: 15),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('nodevice')}',
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
          padding: EdgeInsets.symmetric(
              horizontal: isMobile == true ? 20 : 80, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                '${AppLocalizations.of(context).translate('devicehistory')}',
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
