import 'dart:async';
import 'package:affix_web/screen/authscreen/ui/bottom_signup.dart';
import 'package:affix_web/screen/authscreen/ui/google_button.dart';
import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/drawer/drawer.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:affix_web/screen/authscreen/ui/text_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:string_validator/string_validator.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  bool _emailMiss = false;
  bool _passwordMiss = false;
  DocumentSnapshot snapshot;
  bool _visibilityPassword;

  Future<dynamic> setUserName(String uid) async {
    try {
      final setUser = await FirebaseFirestore.instance
          .collection('customer')
          .doc(uid)
          .get();
      print('setting username...');
      snapshot = setUser;
    } catch (e) {
      print('cannot set username');
    }
  }

  @override
  void initState() {
    _visibilityPassword = false;
    super.initState();
  }

  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    _emailInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    String _uidText = Provider.of<UpdateUI>(context).uid;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: EndDrawer(
        isDarkMode: _isDarkMode,
        uidText: _uidText,
      ),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: NetworkImage(kImageAuth),
                            height: 400,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _title(context, 45),
                              SizedBox(height: 5),
                              _subtitle(context),
                              SizedBox(height: 30),
                              authTextInput(
                                context: context,
                                isDarkMode: _isDarkMode,
                                controller: _emailInput,
                                type: TextInputType.emailAddress,
                                title: 'Email',
                                subtitle: 'contoh@email.com',
                                icon: Icon(Icons.email),
                                err: _emailMiss
                                    ? '${AppLocalizations.of(context).translate('noemail')}'
                                    : null,
                                buttonController: _buttonController,
                                onEnter: () {
                                  context.nextEditableTextFocus();
                                },
                              ),
                              SizedBox(height: 15),
                              authTextInput(
                                context: context,
                                isDarkMode: _isDarkMode,
                                controller: _passwordInput,
                                type: TextInputType.visiblePassword,
                                title:
                                    '${AppLocalizations.of(context).translate('password')}',
                                subtitle: '123456',
                                isPassword: !_visibilityPassword,
                                icon: Icon(Icons.password),
                                err: _passwordMiss
                                    ? '${AppLocalizations.of(context).translate('nopassword')}'
                                    : null,
                                iconButton: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _visibilityPassword =
                                          !_visibilityPassword;
                                    });
                                  },
                                  icon: Icon(_visibilityPassword == false
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                buttonController: _buttonController,
                                onEnter: () {
                                  FocusScope.of(context).unfocus();
                                  _buttonController.start();
                                },
                              ),
                              SizedBox(height: 30),
                              _buttonAuth(
                                  context: context,
                                  onTap: () {
                                    _loginAction(context);
                                  }),
                              SizedBox(height: 15),
                              orDivivder(),
                              SizedBox(height: 15),
                              OtherButtonSign(
                                title:
                                    '${AppLocalizations.of(context).translate('googlesignbutton')}',
                                icon: MaterialCommunityIcons.google,
                              ),
                              SizedBox(height: 20),
                              newUser(context, _isDarkMode),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(kImageAuth),
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 19),
                          _title(context, 35),
                          SizedBox(height: 5),
                          _subtitle(context),
                          SizedBox(height: 30),
                          authTextInput(
                            context: context,
                            isDarkMode: _isDarkMode,
                            controller: _emailInput,
                            type: TextInputType.emailAddress,
                            title: 'Email',
                            subtitle: 'contoh@email.com',
                            icon: Icon(Icons.email),
                            err: _emailMiss
                                ? '${AppLocalizations.of(context).translate('noemail')}'
                                : null,
                            buttonController: _buttonController,
                            onEnter: () {
                              context.nextEditableTextFocus();
                            },
                          ),
                          SizedBox(height: 15),
                          authTextInput(
                            context: context,
                            isDarkMode: _isDarkMode,
                            controller: _passwordInput,
                            type: TextInputType.visiblePassword,
                            title:
                                '${AppLocalizations.of(context).translate('password')}',
                            subtitle: '123456',
                            isPassword: !_visibilityPassword,
                            icon: Icon(Icons.password),
                            err: _passwordMiss
                                ? '${AppLocalizations.of(context).translate('nopassword')}'
                                : null,
                            iconButton: IconButton(
                              onPressed: () {
                                setState(() {
                                  _visibilityPassword = !_visibilityPassword;
                                });
                              },
                              icon: Icon(_visibilityPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            buttonController: _buttonController,
                            onEnter: () {
                              FocusScope.of(context).unfocus();
                              _buttonController.start();
                            },
                          ),
                          SizedBox(height: 30),
                          _buttonAuth(
                              context: context,
                              onTap: () {
                                _loginAction(context);
                              }),
                          SizedBox(height: 30),
                          newUser(context, _isDarkMode),
                          SizedBox(height: 30),
                          orDivivder(),
                          SizedBox(height: 10),
                          OtherButtonSign(
                            title:
                                '${AppLocalizations.of(context).translate('googlesignbutton')}',
                            icon: MaterialCommunityIcons.google,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(
              builder: (BuildContext context) => IconButton(
                tooltip: 'Menu',
                icon: Icon(Icons.menu,
                    color: _isDarkMode == true ? kColorGrey : Colors.white),
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
              child: Builder(
                builder: (BuildContext context) => IconButton(
                  tooltip: 'Back',
                  icon: Icon(Icons.arrow_back,
                      color: _isDarkMode == true ? kColorGrey : Colors.white),
                  onPressed: () {
                    SystemChrome.setApplicationSwitcherDescription(
                        ApplicationSwitcherDescription(
                      label:
                          'Af.Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
                      primaryColor: Theme.of(context).primaryColor.value,
                    ));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText newUser(BuildContext context, bool isDarkMode) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '${AppLocalizations.of(context).translate('newuser?')} ',
              style: TextStyle(
                  color: isDarkMode == true ? kColorGrey : Colors.white)),
          TextSpan(
              text:
                  '${AppLocalizations.of(context).translate('emailsignbutton')}',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showBottomSignUp(context).then((value) {
                    User _user = FirebaseAuth.instance.currentUser;
                    if (_user != null && !_user.isAnonymous) {
                      Navigator.of(context).pop();
                    }
                  });
                  print('SubhanAllah');
                }),
        ],
      ),
    );
  }

  Row orDivivder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: Divider(
            thickness: 2,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '${AppLocalizations.of(context).translate('or')}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 100,
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    );
  }

  //onError
  _buttonError() {
    _buttonController.error();
    Timer(Duration(seconds: 2), () {
      _buttonController.reset();
    });
  }

//onCompleted
  _buttonCompleted() {
    _buttonController.success();
    Timer(Duration(seconds: 2), () {
      // _buttonController.reset();
      VxNavigator.of(context).pop();
    });
  }

//Pressed Button
  _loginAction(BuildContext context) async {
    //Check error Input
    setState(() {
      if (_emailInput.text.isEmpty || !isEmail(_emailInput.text)) {
        _emailMiss = true;
        _buttonError();
      } else {
        _emailMiss = false;
      }

      if (_passwordInput.text.isEmpty) {
        _passwordMiss = true;
        _buttonError();
      } else {
        _passwordMiss = false;
      }
    });

    //check correct input
    if (_emailMiss == false && _passwordMiss == false) {
      FirebaseAuth _auth = FirebaseAuth.instance;

      _auth.setPersistence(Persistence.LOCAL);
      //sign out anonymous
      // await context.read<AuthenticationServices>().signOut();
      try {
        //sign in new user

        await context.read<AuthenticationServices>().signIn(
            email: _emailInput.text.trim(),
            password: _passwordInput.text.trim());

        if (Provider.of<AuthenticationServices>(context, listen: false)
                .isError ==
            false) {
          final retrieve =
              await context.read<AuthenticationServices>().getUserName();
          Provider.of<UpdateUI>(context, listen: false).setUserName(retrieve);
          _buttonCompleted();
          Provider.of<UpdateUI>(context, listen: false).setAnonymous(false);
          //show status
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${Provider.of<AuthenticationServices>(context, listen: false).status}'),
            ),
          );
        } else {
          _buttonError();
          //show status
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.amber[900],
              content: Text(
                  '${Provider.of<AuthenticationServices>(context, listen: false).status}'),
            ),
          );
        }
        //setting uid
        FirebaseAuth.instance.authStateChanges().listen((User user) async {
          if (user != null) {
            Provider.of<UpdateUI>(context, listen: false).setUID(user.uid);
            if (user.displayName == null && !user.isAnonymous) {
              await setUserName(user.uid);
              try {
                user.updateProfile(
                    displayName: snapshot.data()['Nama'].toString());
              } catch (e) {
                final retrieve =
                    await context.read<AuthenticationServices>().getEmail();
                Provider.of<UpdateUI>(context, listen: false)
                    .setUserName(retrieve);
                print('cannot set username: $e');
              }
            }
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${Provider.of<AuthenticationServices>(context, listen: false).status}'),
          ),
        );
        print(e);
      }
    }
  }

  SizedBox _buttonAuth({BuildContext context, Function onTap}) {
    return SizedBox(
      width: 400,
      child: RoundedLoadingButton(
        successColor: Theme.of(context).primaryColor,
        valueColor: kColorWhite,
        errorColor: Theme.of(context).primaryColor,
        controller: _buttonController,
        onPressed: onTap,
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.login, color: kColorWhite),
            SizedBox(width: 15),
            Text(
              '${AppLocalizations.of(context).translate('signin')}',
              style: TextStyle(color: kColorWhite),
            ),
          ],
        ),
      ),
    );
  }

  SelectableText _subtitle(BuildContext context) {
    return SelectableText(
      '${AppLocalizations.of(context).translate('signinsubtitle')}',
      textAlign: TextAlign.center,
    );
  }

  SelectableText _title(BuildContext context, double titleSize) {
    return SelectableText(
      '${AppLocalizations.of(context).translate('signintitle')}',
      textAlign: TextAlign.center,
      style: TextStyle(
        letterSpacing: 1.1,
        fontSize: titleSize,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class LoginWrapper extends StatefulWidget {
  @override
  _LoginWrapperState createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  @override
  Widget build(BuildContext context) {
    bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;
    if (_isAnony == true) {
      LoginPage();
    } else if (_isAnony == false) {
      Navigator.of(context).pop();
    }
    return LoginPage();
  }
}
