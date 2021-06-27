import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/e-warranty/ui/text_input_profile.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

StreamBuilder<DocumentSnapshot> profilePage({
  BuildContext context,
  User user,
  bool isMobile,
  String name,
  String uid,
  int totalRepair,
  int totalPrice,
  bool isDarkMode,
}) {
  _isErrorDialog() {
    Provider.of<AuthenticationServices>(context, listen: false).isError = false;
    DialogBackground(
      blur: 13,
      dialog: AlertDialog(
        title: Text('${AppLocalizations.of(context).translate('errorfound')}'),
        content: Text(
            'Error: ${Provider.of<AuthenticationServices>(context, listen: false).status}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Okay',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    ).show(context);
  }

//Text Controller
  final _inputName = TextEditingController();
  final _inputEmail = TextEditingController();
  final _inputPhone = TextEditingController();

  String _photoUrl = Provider.of<UpdateUI>(context).userPhoto;
  bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;

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
        _inputName.text = name;
        _inputEmail.text = document['Email'];
        _inputPhone.text = document['No Phone'];
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
                  '${user.email}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 30),
                Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    _cardDetails(
                      'Peranti telah dibaiki',
                      totalRepair <= 0 ? '--' : '$totalRepair',
                    ),
                    _cardDetails(
                      'Harga yang telah dibelanja',
                      totalPrice <= 0 ? '--' : 'RM$totalPrice',
                    ),
                    _cardDetails(
                      'Assaff Repair Points',
                      _points <= 0 ? '--' : '$_points',
                    ),
                    // Text('Jumlah yang telah dibelanja'),
                    // Text('Af.Fix Points'),
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
                          Text(
                            'Your Information',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20),
                          textInputProfile(
                            controller: _inputName,
                            isMobile: isMobile,
                            context: context,
                            title: 'Name',
                            icon: Icons.person,
                          ),
                          textInputProfile(
                            controller: _inputPhone,
                            isMobile: isMobile,
                            context: context,
                            title: 'Phone Number',
                            icon: Icons.phone,
                          ),
                          textInputProfile(
                            controller: _inputEmail,
                            isMobile: isMobile,
                            context: context,
                            title: 'Email Address',
                            icon: Icons.mail,
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: isMobile == true
                                ? MediaQuery.of(context).size.width - 60
                                : 450,
                            child: Text.rich(
                              TextSpan(
                                text:
                                    'Maklumat anda hanya digunakan untuk bertujuan pihak kami menghubungi anda berkenaan dengan peranti yang sedang dibaiki.',
                                children: [
                                  TextSpan(
                                    text:
                                        ' Lihat bagaimana kami menguruskan data peribadi anda',
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
                            'Assaff Account',
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
                    SignInButton(
                      isDarkMode == true ? Buttons.Google : Buttons.GoogleDark,
                      onPressed: () {},
                      text: 'Link Account with Google',
                    ),
                    buttonAccount(
                      title: 'Change Password',
                      icon: Icons.vpn_key_outlined,
                      color: Colors.blueGrey[300],
                    ),
                    buttonAccount(
                        title: 'Log Out',
                        icon: Icons.logout,
                        color: Colors.red[300]),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      });
}

SizedBox buttonAccount(
    {@required String title, @required IconData icon, Color color}) {
  return SizedBox(
    height: 38,
    width: 220,
    child: ElevatedButton.icon(
      onPressed: () {},
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
