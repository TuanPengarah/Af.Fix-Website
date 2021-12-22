import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/config/routes.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

showDetails(BuildContext context, String docid) {
  bool _isMobile = Provider.of<UpdateUI>(context, listen: false).isMobile;
  showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: _isMobile == true ? 0.8 : 0.6,
      maxHeight: 0.8,
      context: context,
      builder: (
        BuildContext context,
        ScrollController scrollController,
        double bottomSheetOffset,
      ) {
        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('titlecheck')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
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
                          return Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(height: 15),
                                Text('Loading...'),
                              ],
                            ),
                          );
                        } else if (!snapshot.data.exists) {
                          return Center(
                            child: Column(
                              children: [
                                Icon(Icons.error_outline),
                                SizedBox(height: 15),
                                Text('No data found'),
                              ],
                            ),
                          );
                        }
                        var userDocument = snapshot.data;
                        String _model = '${userDocument['Model']}';
                        bool _isOldiPhone = true;
                        bool _isNewiPhone = false;
                        int _progress = userDocument['Percent'] * 100;

                        if (matches(_model, 'IPHONE 5') ||
                            matches(_model, 'IPHONE 6') ||
                            matches(_model, 'IPHONE 7') ||
                            matches(_model, 'IPHONE 8') ||
                            matches(_model, 'IPHONE SE')) {
                          _isOldiPhone = true;
                          _isNewiPhone = false;
                        } else if (matches(_model, 'IPHONE X') ||
                            matches(_model, 'IPHONE XS') ||
                            matches(_model, 'IPHONE XR') ||
                            matches(_model, 'IPHONE 11') ||
                            matches(_model, 'IPHONE 12') ||
                            matches(_model, 'IPHONE 13')) {
                          _isNewiPhone = true;
                          _isOldiPhone = false;
                        } else {
                          _isNewiPhone = false;
                          _isOldiPhone = false;
                        }

                        return Center(
                          child: Column(
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
                                  progressColor: Colors.blue.shade300,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: Stack(
                                  clipBehavior: Clip.antiAlias,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_progress == 100) {
                                          Provider.of<UpdateUI>(context,
                                                  listen: false)
                                              .setRepair(false);
                                        } else {
                                          Provider.of<UpdateUI>(context,
                                                  listen: false)
                                              .setRepair(true);
                                        }
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.blue.shade300,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            '${AppLocalizations.of(context).translate('buttonrepairlog')}'),
                                      ),
                                    ),
                                    Positioned(
                                      right: -0,
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'Beta',
                                          style: TextStyle(
                                              fontSize: 9, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                    color: Colors.blue.shade300,
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
            ),
          ),
        );
      });
}
