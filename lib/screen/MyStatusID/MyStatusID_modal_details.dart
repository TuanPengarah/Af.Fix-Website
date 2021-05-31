import 'package:affix_web/config/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showDetails(BuildContext context, String docid) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(kImageiPhoneOldWhite),
                height: 150,
              ),
              SizedBox(height: 10),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('MyrepairID')
                    .doc(docid)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading");
                  } else if (!snapshot.data.exists) {
                    return Text('No data found');
                  }
                  var userDocument = snapshot.data;
                  return Column(
                    children: [
                      SelectableText(
                        '${userDocument['Model']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      SelectableText(
                        '${userDocument['Kerosakkan']}',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      SelectableText(
                        'Tarikh Diterima: ${userDocument['Tarikh']}',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      SelectableText(
                        'Peranti ini diuruskan oleh juruteknik bernama ${userDocument['Technician']}',
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                },
              )
            ],
          ),
        );
      });
}
