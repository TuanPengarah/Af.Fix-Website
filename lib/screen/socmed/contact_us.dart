// import 'package:affix_web/config/app_localizations.dart';
// import 'package:affix_web/config/constant.dart';
// import 'package:affix_web/drawer/drawer.dart';
// import 'package:affix_web/provider/themeUI_provider.dart';
// import 'package:affix_web/provider/updateUI_provider.dart';
// import 'package:affix_web/snackbar/error_snackbar.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/model/technician_model.dart';
import 'package:affix_web/screen/socmed/widget_info.dart';
import 'package:affix_web/screen/socmed/widget_whatsapp.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import '../../config/app_localizations.dart';
import '../../snackbar/error_snackbar.dart';

class ContactUs extends StatefulWidget {
  final String tech;

  ContactUs(this.tech);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String _techName = '';
  String _photoURL = '';
  String _cawangan = '';
  String _jawatan = '';
  int _jumlahRepair = 0;
  String _year = DateTime.now().year.toString();
  Future _getTech;
  List<TechnicianModel> _technician = [];

  @override
  void initState() {
    super.initState();
    _getTech = getTechnician();
  }

  Future<void> getTechnician() async {
    if (widget.tech != null) {
      _technician = [];
      debugPrint('tech is not null');
      DatabaseEvent event =
          await FirebaseDatabase.instance.ref().child('Technician').once();
      Map<dynamic, dynamic> values = event.snapshot.value;
      debugPrint(values.length.toString());
      values.forEach((key, value) {
        _technician.add(TechnicianModel.fromFirebase(value));
      });
      TechnicianModel result = _technician.firstWhere((element) =>
          element.nama.replaceAll(' ', '').toLowerCase() == widget.tech);

      if (widget.tech == result.nama.replaceAll(' ', '').toLowerCase()) {
        _techName = result.nama;
        _photoURL = result.photoURL;
        _cawangan = result.cawangan;
        _jawatan = result.jawatan == 'Founder'
            ? 'Sr.Technician & Founder'
            : result.jawatan;
        _jumlahRepair = result.jumlahRepair;
      } else {
        debugPrint('tak jumpa pun: ${result.nama}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kColorDarkScaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: _getTech,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _techName == ''
                        ? const SizedBox()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text.rich(
                              TextSpan(
                                text:
                                    '${AppLocalizations.of(context).translate('greetinghi')} ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '$_techName',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  TextSpan(
                                      text:
                                          '. ${AppLocalizations.of(context).translate('greeting1')}'),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    _photoURL == ''
                        ? const SizedBox()
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: 0,
                                left: -50,
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                      ),
                                      color: Colors.blueGrey,
                                    ),
                                    width: 300,
                                    height: 300,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(300),
                                      ),
                                      color: Colors.blueGrey,
                                    ),
                                    width: 300,
                                    height: 300,
                                  ),
                                ]),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(200),
                                          ),
                                          color: Colors.blueGrey.shade800,
                                        ),
                                        width: 200,
                                        height: 200,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(500),
                                          ),
                                          color: Colors.blueGrey.shade800,
                                        ),
                                        width: 200,
                                        height: 200,
                                      ),
                                    ]),
                              ),
                              Image(
                                height: 450,
                                width: 450,
                                image: ExtendedNetworkImageProvider(
                                  _photoURL,
                                ),
                              ),
                            ],
                          ),
                    _photoURL == ''
                        ? const SizedBox()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Wrap(
                                  spacing: 150,
                                  runSpacing: 50,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceAround,
                                  direction: Axis.horizontal,
                                  children: [
                                    InfoWidget(
                                      icon: Icons.badge,
                                      title:
                                          '${AppLocalizations.of(context).translate('position')}',
                                      subtitle: '$_jawatan',
                                    ),
                                    InfoWidget(
                                      icon: Icons.room,
                                      title:
                                          '${AppLocalizations.of(context).translate('branch')}',
                                      subtitle: '$_cawangan',
                                    ),
                                    InfoWidget(
                                      icon: Icons.construction,
                                      title:
                                          '${AppLocalizations.of(context).translate('totalrepair')}',
                                      subtitle:
                                          '$_jumlahRepair ${AppLocalizations.of(context).translate('totalrepaired')}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    WhatsappNow(photoURL: _photoURL),
                    const SizedBox(height: 50),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MaterialCommunityIcons.account_supervisor_circle,
                            size: 150,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              '${AppLocalizations.of(context).translate('gettouch')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              '${AppLocalizations.of(context).translate('gettouchsub')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(15),
                      child: Wrap(
                        spacing: 30,
                        runSpacing: 30,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () async {
                              final url = "tel: $kNoKedai";
                              await Future.delayed(Duration(milliseconds: 180));
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                showErrorSnackBar('Could not launch $url');
                              }
                            },
                            child: InfoWidget(
                              title:
                                  '${AppLocalizations.of(context).translate('calltitle')}',
                              subtitle: '+60 11 1179 6421',
                              icon: Icons.call,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final url = "sms: $kNoKedai";
                              await Future.delayed(Duration(milliseconds: 180));
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                showErrorSnackBar('Could not launch $url');
                              }
                            },
                            child: InfoWidget(
                              title:
                                  '${AppLocalizations.of(context).translate('messagetitle')}',
                              subtitle: '+60 11 1179 6421',
                              icon: Icons.message,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final url = "mailto: $kEmailKedai";
                              await Future.delayed(Duration(milliseconds: 180));
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                showErrorSnackBar('Could not launch $url');
                              }
                            },
                            child: InfoWidget(
                              title: 'Email',
                              subtitle: 'services.af.fix@gmail.com',
                              icon: Icons.email,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: InfoWidget(
                              title:
                                  '${AppLocalizations.of(context).translate('webappstitle')}',
                              subtitle: 'af-fix.com',
                              icon: Icons.web,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              html.window.open(kFacebookLink, 'Facebook');
                            },
                            child: InfoWidget(
                              title: 'Facebook',
                              subtitle: 'Af-Fix Smartphone Repair',
                              icon: MaterialCommunityIcons.facebook,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              html.window.open(kInstagramLink, 'Instagram');
                            },
                            child: InfoWidget(
                              title: 'Instagram',
                              subtitle: '@assaff.fix',
                              icon: MaterialCommunityIcons.instagram,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              html.window.open(kWhatsAppLink, 'WhatsApp');
                            },
                            child: InfoWidget(
                              title: 'WhatsApp',
                              subtitle: '+60 11 1179 6421',
                              icon: MaterialCommunityIcons.whatsapp,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              html.window.open(kYoutubeLink, 'Youtube');
                            },
                            child: InfoWidget(
                              title: 'Youtube',
                              subtitle: 'Af-Fix Smartphone Repair',
                              icon: MaterialCommunityIcons.youtube,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              html.window.open(kMapsSearch, 'Google Maps');
                            },
                            child: InfoWidget(
                              title:
                                  '${AppLocalizations.of(context).translate('location')}',
                              subtitle:
                                  '${AppLocalizations.of(context).translate('locationdesc')}',
                              icon: MaterialCommunityIcons.map,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    SelectableText(
                      '${AppLocalizations.of(context).translate('copyright')} $_year | ${AppLocalizations.of(context).translate('copyright1')}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }),
      ),
    );
  }
}



// class ContactUs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
//     String _year = DateTime.now().year.toString();
//     String _uidText = Provider.of<UpdateUI>(context).uid;
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         leading: IconButton(
//           tooltip: '${AppLocalizations.of(context).translate('buttonclose')}',
//           icon: Icon(
//             Icons.close,
//             color: _isDarkMode == false
//                 ? Colors.white
//                 : Provider.of<UpdateUI>(context).changeColor,
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           Builder(
//             builder: (BuildContext context) => IconButton(
//               tooltip: 'Menu',
//               icon: Icon(
//                 Icons.menu,
//                 color: _isDarkMode == false
//                     ? Colors.white
//                     : Provider.of<UpdateUI>(context).changeColor,
//               ),
//               onPressed: () {
//                 FocusScope.of(context).unfocus();
//                 Scaffold.of(context).openEndDrawer();
//               },
//             ),
//           ),
//         ],
//       ),
//       endDrawer: EndDrawer(uidText: _uidText, isDarkMode: _isDarkMode),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 50),
//               Container(
//                 width: 500,
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: 150,
//                           height: 150,
//                           child: Image.asset(
//                             _isDarkMode == false
//                                 ? 'assets/images/splash_light.png'
//                                 : 'assets/images/splash_dark.png',
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         SelectableText(
//                           '${AppLocalizations.of(context).translate('contactustitle')}',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 40,
//                             fontWeight: FontWeight.w900,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Divider(thickness: 1.5),
//                         SizedBox(height: 10),
//                         ListTile(
//                           title: Text('Email'),
//                           subtitle: Text(kEmailKedai),
//                           leading: Icon(
//                             MaterialCommunityIcons.email,
//                           ),
//                           onTap: () async {
//                             final url = "mailto: $kEmailKedai";
//                             await Future.delayed(Duration(milliseconds: 180));
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             } else {
//                               showErrorSnackBar('Could not launch $url');
//                             }
//                           },
//                         ),
//                         ListTile(
//                           title: Text(
//                               '${AppLocalizations.of(context).translate('calltitle')}'),
//                           subtitle: Text('+6011-11796421'),
//                           leading: Icon(
//                             MaterialCommunityIcons.phone,
//                           ),
//                           onTap: () async {
//                             final url = "tel: $kNoKedai";
//                             await Future.delayed(Duration(milliseconds: 180));
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             } else {
//                               showErrorSnackBar('Could not launch $url');
//                             }
//                           },
//                         ),
//                         ListTile(
//                           title: Text(
//                               '${AppLocalizations.of(context).translate('messagetitle')}'),
//                           subtitle: Text('+6011-11796421'),
//                           leading: Icon(
//                             MaterialCommunityIcons.message,
//                           ),
//                           onTap: () async {
//                             final url = "sms: $kNoKedai";
//                             await Future.delayed(Duration(milliseconds: 180));
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             } else {
//                               showErrorSnackBar('Could not launch $url');
//                             }
//                           },
//                         ),
//                         ListTile(
//                           title: Text(
//                               '${AppLocalizations.of(context).translate('webappstitle')}'),
//                           subtitle: Text('af-fix.com'),
//                           leading: Icon(
//                             MaterialCommunityIcons.web,
//                           ),
//                           onTap: () async {
//                             await Future.delayed(Duration(milliseconds: 300));
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         ListTile(
//                           title: Text('Facebook'),
//                           subtitle: Text('Af-Fix Smartphone Repair'),
//                           leading: Icon(
//                             MaterialCommunityIcons.facebook,
//                           ),
//                           onTap: () async {
//                             await Future.delayed(Duration(milliseconds: 200));
//                             html.window.open(kFacebookLink, 'Facebook');
//                           },
//                         ),
//                         ListTile(
//                           title: Text('Instagram'),
//                           subtitle: Text('@assaff.fix'),
//                           leading: Icon(
//                             MaterialCommunityIcons.instagram,
//                           ),
//                           onTap: () async {
//                             await Future.delayed(Duration(milliseconds: 200));
//                             html.window.open(kInstagramLink, 'Instagram');
//                           },
//                         ),
//                         ListTile(
//                           title: Text('WhatsApp'),
//                           subtitle: Text('+6011-11796421'),
//                           leading: Icon(
//                             MaterialCommunityIcons.whatsapp,
//                           ),
//                           onTap: () async {
//                             await Future.delayed(Duration(milliseconds: 200));
//                             html.window.open(kWhatsAppLink, 'WhatsApp');
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 50),
//               SelectableText(
//                 '${AppLocalizations.of(context).translate('copyright')} $_year | ${AppLocalizations.of(context).translate('copyright1')}',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
