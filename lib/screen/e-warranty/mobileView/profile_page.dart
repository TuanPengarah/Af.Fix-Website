import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

StreamBuilder<DocumentSnapshot> profilePage(
    {BuildContext context,
    User user,
    bool isMobile,
    String name,
    String uid,
    int totalRepair,
    int totalPrice}) {
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
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
              ],
            ),
          ),
        );
      });
}

Container _cardDetails(String title, String number) {
  return Container(
    width: 150,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
