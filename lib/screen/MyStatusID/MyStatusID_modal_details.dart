import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

showDetails(BuildContext context, String docid) {
  showModalBottomSheet(
      isScrollControlled: true,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  return Column(
                    children: [
                      Image(
                        image: NetworkImage((_isOldiPhone == true)
                            ? kImageiPhoneOldWhite
                            : (_isNewiPhone == true)
                                ? kImageiPhoneNew
                                : kImageAndroid),
                        height: 150,
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 5),
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
                      SizedBox(height: 28),
                      SelectableText(
                        '${AppLocalizations.of(context).translate('progress')}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 500,
                        child: FAProgressBar(
                          currentValue: _progress.toInt(),
                          displayText: '%',
                          animatedDuration: Duration(milliseconds: 400),
                          displayTextStyle: TextStyle(
                              color:
                                  _progress < 5 ? Colors.black : Colors.white),
                          border: Border.all(color: Color(0xFFFA7268)),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                },
              )
            ],
          ),
        );
      });
}
