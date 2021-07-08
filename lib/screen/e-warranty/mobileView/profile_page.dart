import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/model/sweetLogoutDialog.dart';
import 'package:affix_web/model/update_user_info.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/e-warranty/ui/change_password.dart';
import 'package:affix_web/screen/e-warranty/ui/update_email_dialog.dart';
import 'package:affix_web/screen/e-warranty/ui/text_input_profile.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

bool _editable = false;

class ProfilePage extends StatefulWidget {
  final int totalRepair;
  final int totalPrice;
  final bool isMobile;
  ProfilePage({
    this.totalRepair,
    this.totalPrice,
    this.isMobile,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Text Controller
  final _inputName = TextEditingController();
  final _inputEmail = TextEditingController();
  final _inputPhone = TextEditingController();
  String newName;
  String newPhone;

  bool _isGoogle = true;
  String name;
  User user = FirebaseAuth.instance.currentUser;
  bool _reloading = true;

  @override
  Widget build(BuildContext context) {
    String _photoUrl = Provider.of<UpdateUI>(context).userPhoto;
    bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _uid = Provider.of<UpdateUI>(context).uid;
    bool isMobile = widget.isMobile;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('customer')
            .doc(_uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
          }
          var document = snapshot.data.data();
          int _points = document['Points'];
          name = document['Nama'];
          _inputEmail.text = document['Email'];
          if (_reloading == true) {
            _inputName.text = document['Nama'];
            _inputPhone.text = document['No Phone'];
            _reloading = false;
          }

          if (FirebaseAuth.instance.currentUser != null) {
            _isGoogle =
                FirebaseAuth.instance.currentUser.providerData[0].providerId ==
                    'google.com';
          }
          return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: _photoUrl == null && _isAnony == false
                            ? AvatarLetter(
                                fontSize: 30,
                                text: '$name',
                                textColor: Colors.white,
                                textColorHex: null,
                                backgroundColor: Theme.of(context).primaryColor,
                                backgroundColorHex: null,
                                letterType: LetterType.Circular,
                              )
                            : CircleAvatar(
                                minRadius: 28,
                                backgroundColor: isMobile == true
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                backgroundImage: isMobile != null
                                    ? NetworkImage(_photoUrl)
                                    : null,
                              ),
                      ),
                    ),
                    SelectableText(
                      '$name',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 5),
                    SelectableText(
                      '${_inputEmail.text}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    Wrap(
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        _cardDetails(
                          '${AppLocalizations.of(context).translate('repaireddevices')}',
                          widget.totalRepair <= 0
                              ? '--'
                              : '${widget.totalRepair}',
                        ),
                        _cardDetails(
                          '${AppLocalizations.of(context).translate('spentprice')}',
                          widget.totalPrice <= 0
                              ? '--'
                              : 'RM${widget.totalPrice}',
                        ),
                        _cardDetails(
                          '${AppLocalizations.of(context).translate('repairpoint')}',
                          _points <= 0 ? '--' : '$_points',
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile == true ? 30 : 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: isMobile == true
                                    ? MediaQuery.of(context).size.width - 60
                                    : 450,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context).translate('yourinformation')}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    // SizedBox(width: 15),
                                    IconButton(
                                      tooltip:
                                          _editable == true ? 'Save' : 'Edit',
                                      onPressed: () async {
                                        setState(() {
                                          _editable = !_editable;
                                        });
                                        if (_editable == false) {
                                          if (_inputName.text.isEmpty ||
                                              _inputPhone.text.isEmpty) {
                                            _inputName.text = newName;
                                            _inputPhone.text = newPhone;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Gagal untuk mengemaskini data pengguna, Sila masukkann maklumat anda dengan betul'),
                                              backgroundColor:
                                                  Colors.amber[900],
                                            ));
                                          } else {
                                            await updateUser(
                                              context: context,
                                              inputPhone: _inputPhone.text,
                                              inputName: _inputName.text,
                                            ).then((value) => user.reload());
                                          }
                                        } else {
                                          newName = _inputName.text;
                                          newPhone = _inputPhone.text;
                                        }
                                      },
                                      icon: Icon(
                                        _editable == false
                                            ? Icons.edit
                                            : Icons.save,
                                        color: _isDarkMode == true
                                            ? kColorGrey
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              textInputProfile(
                                  controller: _inputName,
                                  isMobile: isMobile,
                                  context: context,
                                  title:
                                      '${AppLocalizations.of(context).translate('name')}',
                                  icon: Icons.person,
                                  lock: _editable,
                                  isDarkMode: _isDarkMode),
                              textInputProfile(
                                  controller: _inputPhone,
                                  isMobile: isMobile,
                                  context: context,
                                  title:
                                      '${AppLocalizations.of(context).translate('phonenumber')}',
                                  icon: Icons.phone,
                                  lock: _editable,
                                  isDarkMode: _isDarkMode),
                              textInputProfile(
                                  controller: _inputEmail,
                                  isMobile: isMobile,
                                  context: context,
                                  title:
                                      '${AppLocalizations.of(context).translate('email')}',
                                  icon: Icons.mail,
                                  lock: false,
                                  isDarkMode: _isDarkMode),
                              SizedBox(height: 10),
                              Container(
                                width: isMobile == true
                                    ? MediaQuery.of(context).size.width - 60
                                    : 450,
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        '${AppLocalizations.of(context).translate('infodescription')}',
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${AppLocalizations.of(context).translate('aboutinfo')}',
                                        style: TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                '${AppLocalizations.of(context).translate('assaffaccount')}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        _isGoogle == false
                            ? SignInButton(
                                _isDarkMode == true
                                    ? Buttons.Google
                                    : Buttons.GoogleDark,
                                onPressed: () {
                                  user.reload();
                                },
                                text:
                                    '${AppLocalizations.of(context).translate('linkwithgoogle')}',
                              )
                            : Container(),
                        _isGoogle == false
                            ? buttonAccount(
                                title:
                                    '${AppLocalizations.of(context).translate('changeemail')}',
                                icon: Icons.email,
                                color: Colors.blueGrey[300],
                                onPressed: () {
                                  updatingEmail(
                                      context: context,
                                      defaultEmail: _inputEmail.text);
                                })
                            : Container(),
                        _isGoogle == false
                            ? buttonAccount(
                                title:
                                    '${AppLocalizations.of(context).translate('changepassword')}',
                                icon: Icons.vpn_key_outlined,
                                color: Colors.blueGrey[300],
                                onPressed: () {
                                  changePassword(context: context);
                                })
                            : Container(),
                        buttonAccount(
                          title:
                              '${AppLocalizations.of(context).translate('signout')}',
                          icon: Icons.logout,
                          color: Colors.red[300],
                          onPressed: () {
                            showLogoutDialog(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ));
        });
  }
}

StreamBuilder<DocumentSnapshot> profilePage({
  BuildContext context,
  User user,
  bool isMobile,
  String name,
  String uid,
  int totalRepair,
  int totalPrice,
}) {
//Text Controller
  final _inputName = TextEditingController();
  final _inputEmail = TextEditingController();
  final _inputPhone = TextEditingController();

  String newName;
  String newPhone;

  String _photoUrl = Provider.of<UpdateUI>(context).userPhoto;
  bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;
  bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
  bool _isGoogle = true;
  _inputName.text = name;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('customer')
          .doc(uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
        }
        var document = snapshot.data.data();
        int _points = document['Points'];

        // final _inputName = TextEditingController(text: name);
        // final _inputEmail = TextEditingController(text: document['Email']);
        // final _inputPhone = TextEditingController(text: document['No Phone']);
        // final String _defaultName = name;
        // final String _defaultEmail = document['Email'];
        // final String _defaultPhone = document['No Phone'];
        if (FirebaseAuth.instance.currentUser != null) {
          _isGoogle =
              FirebaseAuth.instance.currentUser.providerData[0].providerId ==
                  'google.com';
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: _photoUrl == null && _isAnony == false
                          ? AvatarLetter(
                              fontSize: 30,
                              text: '$name',
                              textColor: isMobile == true
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              textColorHex: null,
                              backgroundColor: isMobile == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              backgroundColorHex: null,
                              letterType: LetterType.Circular,
                            )
                          : CircleAvatar(
                              minRadius: 28,
                              backgroundColor: isMobile == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              backgroundImage: isMobile != null
                                  ? NetworkImage(_photoUrl)
                                  : null,
                            ),
                    ),
                  ),
                  SelectableText(
                    '$name',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  SelectableText(
                    '${_inputEmail.text}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      _cardDetails(
                        '${AppLocalizations.of(context).translate('repaireddevices')}',
                        totalRepair <= 0 ? '--' : '$totalRepair',
                      ),
                      _cardDetails(
                        '${AppLocalizations.of(context).translate('spentprice')}',
                        totalPrice <= 0 ? '--' : 'RM$totalPrice',
                      ),
                      _cardDetails(
                        '${AppLocalizations.of(context).translate('repairpoint')}',
                        _points <= 0 ? '--' : '$_points',
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobile == true ? 30 : 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: isMobile == true
                                  ? MediaQuery.of(context).size.width - 60
                                  : 450,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).translate('yourinformation')}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  // SizedBox(width: 15),
                                  IconButton(
                                    tooltip:
                                        _editable == true ? 'Save' : 'Edit',
                                    onPressed: () async {
                                      setState(() {
                                        _editable = !_editable;
                                      });
                                      if (_editable == false) {
                                        // newName = _inputName.text;
                                        // newPhone = _inputPhone.text;
                                        // await reauthUserDialog(
                                        //   context: context,
                                        //   email: _inputEmail.text,
                                        //   name: _inputName.text,
                                        //   phone: _inputPhone.text,
                                        // );
                                        if (_inputName.text.isEmpty ||
                                            _inputPhone.text.isEmpty) {
                                          _inputName.text = newName;
                                          _inputPhone.text = newPhone;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Gagal untuk mengemaskini data pengguna, Sila masukkann maklumat anda dengan betul'),
                                            backgroundColor: Colors.amber[900],
                                          ));
                                        } else {
                                          await updateUser(
                                            context: context,
                                            inputPhone: _inputPhone.text,
                                            inputName: _inputName.text,
                                          ).then((value) => user.reload());
                                        }
                                      } else {
                                        newName = _inputName.text;
                                        newPhone = _inputPhone.text;
                                      }
                                    },
                                    icon: Icon(
                                      _editable == false
                                          ? Icons.edit
                                          : Icons.save,
                                      color: _isDarkMode == true
                                          ? kColorGrey
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            textInputProfile(
                                controller: _inputName,
                                isMobile: isMobile,
                                context: context,
                                title:
                                    '${AppLocalizations.of(context).translate('name')}',
                                icon: Icons.person,
                                lock: _editable,
                                isDarkMode: _isDarkMode),
                            textInputProfile(
                                controller: _inputPhone,
                                isMobile: isMobile,
                                context: context,
                                title:
                                    '${AppLocalizations.of(context).translate('phonenumber')}',
                                icon: Icons.phone,
                                lock: _editable,
                                isDarkMode: _isDarkMode),
                            textInputProfile(
                                controller: _inputEmail,
                                isMobile: isMobile,
                                context: context,
                                title:
                                    '${AppLocalizations.of(context).translate('email')}',
                                icon: Icons.mail,
                                lock: false,
                                isDarkMode: _isDarkMode),
                            SizedBox(height: 10),
                            Container(
                              width: isMobile == true
                                  ? MediaQuery.of(context).size.width - 60
                                  : 450,
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context).translate('infodescription')}',
                                  children: [
                                    TextSpan(
                                      text:
                                          ' ${AppLocalizations.of(context).translate('aboutinfo')}',
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              '${AppLocalizations.of(context).translate('assaffaccount')}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      _isGoogle == false
                          ? SignInButton(
                              _isDarkMode == true
                                  ? Buttons.Google
                                  : Buttons.GoogleDark,
                              onPressed: () {
                                user.reload();
                              },
                              text:
                                  '${AppLocalizations.of(context).translate('linkwithgoogle')}',
                            )
                          : Container(),
                      _isGoogle == false
                          ? buttonAccount(
                              title:
                                  '${AppLocalizations.of(context).translate('changeemail')}',
                              icon: Icons.email,
                              color: Colors.blueGrey[300],
                              onPressed: () {
                                updatingEmail(
                                    context: context,
                                    defaultEmail: _inputEmail.text);
                              })
                          : Container(),
                      _isGoogle == false
                          ? buttonAccount(
                              title:
                                  '${AppLocalizations.of(context).translate('changepassword')}',
                              icon: Icons.vpn_key_outlined,
                              color: Colors.blueGrey[300],
                            )
                          : Container(),
                      buttonAccount(
                        title:
                            '${AppLocalizations.of(context).translate('signout')}',
                        icon: Icons.logout,
                        color: Colors.red[300],
                        onPressed: () {
                          showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          }),
        );
      });
}

SizedBox buttonAccount(
    {@required String title,
    @required IconData icon,
    Color color,
    Function onPressed}) {
  return SizedBox(
    height: 38,
    width: 220,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon ?? Icons.vpn_key_outlined),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? Colors.teal,
        ),
      ),
      label: Text('$title'),
    ),
  );
}

Container _cardDetails(String title, String number) {
  return Container(
    width: 150,
    height: 100,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              number,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// onTap: () async {
//   await context
//       .read<AuthenticationServices>()
//       .linktoGoogle()
//       .then((value) {
//     if (Provider.of<AuthenticationServices>(context, listen: false)
//             .isError ==
//         false) {
//     } else {
//       _isErrorDialog();
//     }
//   });

//   Provider.of<UpdateUI>(context, listen: false)
//       .setUserPhoto(user.photoURL);
// },

// _isErrorDialog() {
//   Provider.of<AuthenticationServices>(context, listen: false).isError = false;
//   DialogBackground(
//     blur: 13,
//     dialog: AlertDialog(
//       title: Text('${AppLocalizations.of(context).translate('errorfound')}'),
//       content: Text(
//           'Error: ${Provider.of<AuthenticationServices>(context, listen: false).status}'),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             'Okay',
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 15,
//             ),
//           ),
//         ),
//       ],
//     ),
//   ).show(context);
// }
