import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:velocity_x/velocity_x.dart';

showDetails(BuildContext context, String docid) {
  showModalBottomSheet(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(10),
      //     topRight: Radius.circular(10),
      //   ),
      // ),
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  tooltip: 'Tutup',
                  icon: Icon(
                    Icons.close,
                    color: Color(0xFFFA7268),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('MyrepairID')
                        .doc(docid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading...');
                      } else if (!snapshot.data.exists) {
                        return Text('No data found');
                      }
                      var userDocument = snapshot.data;
                      String _model = '${userDocument['Model']}';
                      bool _isOldiPhone = true;
                      bool _isNewiPhone = false;
                      bool _isAndroid = false;
                      int _progress = userDocument['Percent'] * 100;
                      if (matches(_model, 'IPHONE 5') ||
                          matches(_model, 'IPHONE 6') ||
                          matches(_model, 'IPHONE 7') ||
                          matches(_model, 'IPHONE 8') ||
                          matches(_model, 'IPHONE SE')) {
                        _isOldiPhone = true;
                        _isNewiPhone = false;
                        _isAndroid = false;
                      } else if (matches(_model, 'IPHONE X') ||
                          matches(_model, 'IPHONE XS') ||
                          matches(_model, 'IPHONE XR') ||
                          matches(_model, 'IPHONE 11') ||
                          matches(_model, 'IPHONE 12')) {
                        _isNewiPhone = true;
                        _isOldiPhone = false;
                        _isAndroid = false;
                      } else {
                        _isNewiPhone = false;
                        _isOldiPhone = false;
                        _isAndroid = true;
                      }
                      print('old iphone: $_isOldiPhone');
                      print('new iphone: $_isNewiPhone');
                      print('android: $_isAndroid');

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: NetworkImage((_isOldiPhone == true)
                                  ? kImageiPhoneOldWhite
                                  : (_isNewiPhone == true)
                                      ? kImageiPhoneNew
                                      : kImageAndroid),
                              height: 180,
                            ),
                            SizedBox(height: 15),
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
                            SizedBox(height: 30),
                            SelectableText.rich(
                              TextSpan(
                                  text:
                                      '${AppLocalizations.of(context).translate('receiveddate')}',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${userDocument['Tarikh']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            SelectableText.rich(
                              TextSpan(
                                  text:
                                      '${AppLocalizations.of(context).translate('technician')}',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${userDocument['Technician']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 35),
                            SelectableText(
                              '${AppLocalizations.of(context).translate('progress')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 500,
                              child: FAProgressBar(
                                currentValue: _progress.toInt(),
                                displayText: '%',
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.vxNav.push(
                                    Uri(
                                      path: MyRoutes.mySIDDetails,
                                      queryParameters: {"id": docid},
                                    ),
                                    params: docid);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFFFA7268),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    '${AppLocalizations.of(context).translate('buttonrepairlog')}'),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                '${AppLocalizations.of(context).translate('buttonclose')}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFFFA7268),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
