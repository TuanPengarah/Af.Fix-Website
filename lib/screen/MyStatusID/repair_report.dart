import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class RepairReport extends StatelessWidget {
  final String mysid;

  RepairReport({this.mysid});
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
      appBar: AppBar(
        elevation: 10,
        title: Text(
          '${AppLocalizations.of(context).translate('buttonrepairlog')}',
          style: TextStyle(
            color: _isDarkMode == false ? kColorWhite : kColorGrey,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: '${AppLocalizations.of(context).translate('buttonclose')}',
          onPressed: () {
            SystemChrome.setApplicationSwitcherDescription(
                ApplicationSwitcherDescription(
              label: 'MyStatus ID- Af.Fix Smartphone Repair',
              primaryColor: Theme.of(context).primaryColor.value,
            ));
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: _isDarkMode == false ? kColorWhite : kColorGrey,
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              tooltip: 'Menu',
              icon: Icon(
                Icons.menu,
                color: _isDarkMode == false ? kColorWhite : kColorGrey,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('MyrepairID')
            .doc(mysid)
            .collection('repair log')
            .orderBy('timeStamp', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline),
                  SizedBox(height: 15),
                  Text('No data found'),
                ],
              ),
            );
          }

          return Timeline.builder(
            lineColor: Colors.grey,
            shrinkWrap: true,
            position: TimelinePosition.Left,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int i) {
              var document = snapshot.data.docs[i];
              bool _isError = document['isError'];
              return TimelineModel(
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 100,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SelectableText(
                                document['Repair Log'],
                              ),
                              SizedBox(height: 10),
                              SelectableText(
                                document['Waktu'],
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              )
                            ],
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
                  icon: _iconLookup(_isError, document['Repair Log']),
                  iconBackground: _isError == true ? Colors.red : Colors.teal);
            },
            itemCount: snapshot.data.docs.length,
          );
        },
      ),
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
