import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/menu/menu_change_language.dart';
import 'package:affix_web/menu/menu_change_theme.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '${AppLocalizations.of(context).translate('usernotsign')}',
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 20,
                    minFontSize: 13,
                  ),
                  SizedBox(height: 5),
                  SelectableText(
                    'uid: $_uidText',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipletrepair')}',
              child: ListTile(
                title:
                    Text(AppLocalizations.of(context).translate('letsrepair')),
                onTap: () {},
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipabout')}',
              child: ListTile(
                title: Text(AppLocalizations.of(context).translate('about')),
                onTap: () {},
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipourservice')}',
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('ourservice'),
                ),
                onTap: () {},
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipewaranti')}',
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('ewarranti'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipmyrid')}',
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('myrid'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipsocial')}',
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('tooltipsocial'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipchangelang')}',
              child: ListTile(
                title: Text(
                  '${AppLocalizations.of(context).translate('language')}',
                ),
                trailing:
                    Text('${AppLocalizations.of(context).translate('locale')}'),
                onTap: () {
                  showLanguage(context);
                },
              ),
            ),
            Tooltip(
              message:
                  '${AppLocalizations.of(context).translate('tooltipdarktheme')}',
              child: ListTile(
                title: Text(
                    '${AppLocalizations.of(context).translate('darktheme')}'),
                trailing: Text(
                  _isDarkMode
                      ? '${AppLocalizations.of(context).translate('on')}'
                      : '${AppLocalizations.of(context).translate('off')}',
                ),
                onTap: () {
                  showDarkTheme(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('MyrepairID')
            .doc(mysid)
            .collection('repair log')
            .orderBy('timeStamp', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          } else if (snapshot.data.docs.isEmpty) {
            return Text('No data found');
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
// <TimelineModel>[
//               TimelineModel(
//                 Container(
//                   height: 100,
//                   child: Center(
//                     child: Text("data"),
//                   ),
//                 ),
//                 icon: Icon(Icons.receipt, color: Colors.white),
//                 iconBackground: Colors.blue,
//               ),
//             ],

// children: snapshot.data.docs.map((document) {
//             TimelineModel(
//               Container(
//                 height: 100,
//                 child: Center(
//                   child: Text(document['Repair Log']),
//                 ),
//               ),
//               icon: Icon(Icons.receipt, color: Colors.white),
//               iconBackground: Colors.blue,
//             );
//           }).toList(),
//           position: TimelinePosition.Left,

//           iconSize: 40,
//           lineColor: Colors.blue,
