import 'package:affix_web/config/app_localizations.dart';
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: 10),
            SelectableText(
              '${AppLocalizations.of(context).translate('titlecheck')}',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1),
            ),
            SizedBox(height: 10),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('MyrepairID')
                  .doc(docid)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Text("loading");
                } else if (!snapshot.data.exists) {
                  return Text('No data found');
                }
                var userDocument = snapshot.data;
                return Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Card(
                    child: Column(
                      children: [SelectableText('${userDocument['Model']}')],
                    ),
                  ),
                );
              },
            )
          ],
        );
      });
}
