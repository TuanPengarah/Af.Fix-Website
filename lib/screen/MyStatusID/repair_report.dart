import 'dart:async';

import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class RepairReport extends StatefulWidget {
  final String mysid;

  RepairReport({this.mysid});

  @override
  _RepairReportState createState() => _RepairReportState();
}

class _RepairReportState extends State<RepairReport> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool _isMobile = false;
  bool _isDone = true;
  Future<void> _onRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future.then((value) {
      setState(() {
        print(_isDone);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                '${AppLocalizations.of(context).translate('refreshcomplete')}')));
      });
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _uidText = Provider.of<UpdateUI>(context).uid;

    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label:
          '${AppLocalizations.of(context).translate('buttonrepairlog')} - Af.Fix Smartphone Repair',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          _isMobile = false;
        } else {
          _isMobile = true;
        }
        return LiquidPullToRefresh(
          animSpeedFactor: 5,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).primaryColor,
          showChildOpacityTransition: false,
          onRefresh: _onRefresh,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('MyrepairID')
                .doc(widget.mysid)
                .collection('repair log')
                .orderBy('timeStamp', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                      SizedBox(height: 15),
                      Text('Loading...'),
                    ],
                  ),
                );
              } else if (snapshot.data.docs.isEmpty) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline),
                              SizedBox(height: 15),
                              Text('No data found'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Builder(
                        builder: (BuildContext context) => IconButton(
                          tooltip: 'Menu',
                          icon: Icon(
                            Icons.menu,
                            color:
                                _isDarkMode == false ? kColorWhite : kColorGrey,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          tooltip: 'Tutup',
                          icon: Icon(
                            Icons.close,
                            color:
                                _isDarkMode == false ? kColorWhite : kColorGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Stack(
                alignment: Alignment.topRight,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: _isMobile == true
                          ? EdgeInsets.all(16)
                          : EdgeInsets.symmetric(
                              horizontal: _isMobile == true ? 40.0 : 150,
                              vertical: 20),
                      child: Column(
                        mainAxisAlignment: _isMobile == true
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        crossAxisAlignment: _isMobile == true
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: _isMobile == false ? 0 : 50),
                          Text(
                            'Repair Timeline',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 5),
                          SelectableText(
                            '${AppLocalizations.of(context).translate('repairtimelinesubtitle')}',
                            style: TextStyle(
                                color: _isDarkMode == true
                                    ? Colors.grey.shade600
                                    : Colors.grey,
                                fontSize: 14),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: _isMobile == true
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            crossAxisAlignment: _isMobile == true
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_downward_sharp,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${AppLocalizations.of(context).translate('timelinestart')}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          Timeline.builder(
                            lineColor: Colors.grey,
                            shrinkWrap: true,
                            position: _isMobile == true
                                ? TimelinePosition.Left
                                : TimelinePosition.Center,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int i) {
                              var document = snapshot.data.docs[i];
                              bool _isError = document['isError'];
                              _isDone =
                                  matches('Selesai', document['Repair Log']);
                              return TimelineModel(
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ClayContainer(
                                      height: 100,
                                      emboss: false,
                                      borderRadius: 18,
                                      spread: 10,
                                      parentColor: _isDarkMode == true
                                          ? Colors.grey[350].withOpacity(0.3)
                                          : Colors.grey[900],
                                      color: _isError == false
                                          ? Colors.teal[400]
                                          : Colors.red[400],
                                      width: double.infinity,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          customBorder: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)),
                                          onLongPress: () async {
                                            await DialogBackground(
                                              blur: 6,
                                              dialog: AlertDialog(
                                                content: SelectableText(
                                                  "${document['Repair Log']}",
                                                ),
                                                actions: <Widget>[
                                                  SizedBox(width: 10),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                        '${AppLocalizations.of(context).translate('buttonclose')}',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).show(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    document['Repair Log'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                SelectableText(
                                                  document['Waktu'],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  position: i % 2 == 0
                                      ? TimelineItemPosition.right
                                      : TimelineItemPosition.left,
                                  isFirst: i == 0,
                                  isLast: i == snapshot.data.docs.length,
                                  icon: _iconLookup(
                                      _isError, document['Repair Log']),
                                  iconBackground: _isError == true
                                      ? Colors.red
                                      : Colors.teal);
                            },
                            itemCount: snapshot.data.docs.length,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: _isMobile == true
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            crossAxisAlignment: _isMobile == true
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              _isDone == true
                                  ? Icon(Icons.timeline, color: Colors.grey)
                                  : SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                        strokeWidth: 2,
                                      ),
                                    ),
                              SizedBox(width: 10),
                              Text(
                                _isDone == true
                                    ? '${AppLocalizations.of(context).translate('timelineend')}'
                                    : '${AppLocalizations.of(context).translate('timelineinprogress')}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (BuildContext context) => IconButton(
                        tooltip: 'Menu',
                        icon: Icon(
                          Icons.menu,
                          color:
                              _isDarkMode == false ? kColorWhite : kColorGrey,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        tooltip: 'Tutup',
                        icon: Icon(
                          Icons.close,
                          color:
                              _isDarkMode == false ? kColorWhite : kColorGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  Icon _iconLookup(bool isError, String checkIcon) {
    if (isError == true) {
      return Icon(Icons.warning);
    } else if (checkIcon == 'Pesanan diterima') {
      return Icon(Icons.note_alt_outlined);
    } else if (checkIcon == 'Menunggu giliran') {
      return Icon(Icons.alarm);
    } else if (checkIcon == 'Memulakan proses diagnosis') {
      return Icon(Icons.search);
    } else if (checkIcon == 'Proses diagnosis selesai') {
      return Icon(Icons.download_done);
    } else if (checkIcon == 'Memulakan proses membaiki') {
      return Icon(Icons.home_repair_service_outlined);
    } else if (checkIcon ==
        'Menyelaraskan sparepart baru kepada peranti anda') {
      return Icon(Icons.sync);
    } else if (checkIcon == 'Semua alat sparepart baru berfungsi dengan baik') {
      return Icon(Icons.download_done);
    } else if (checkIcon == 'Memasang semula peranti anda') {
      return Icon(Icons.add_to_home_screen);
    } else if (checkIcon == 'Melakukan proses diagnosis buat kali terakhir') {
      return Icon(Icons.saved_search);
    } else if (checkIcon == 'Proses membaiki selesai') {
      return Icon(Icons.done);
    } else if (checkIcon == 'Pihak kami cuba untuk menghubungi anda') {
      return Icon(Icons.call_rounded);
    } else if (checkIcon == 'Maklumat telah diberitahu kepada anda') {
      return Icon(Icons.notifications_active_outlined);
    } else if (checkIcon == 'Selesai') {
      return Icon(Icons.done_all);
    } else {
      return Icon(Icons.notes);
    }
  }
}
