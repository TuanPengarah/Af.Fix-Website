import 'package:affix_web/config/app_localizations.dart';
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
        title: Text(
            '${AppLocalizations.of(context).translate('buttonrepairlog')}'),
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
          icon: Icon(Icons.close),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              tooltip: 'Menu',
              icon: Icon(Icons.menu, color: Colors.white),
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
                  iconBackground: Theme.of(context).primaryColor);
            },
            itemCount: snapshot.data.docs.length,
          );
        },
      ),
    );
  }
}
