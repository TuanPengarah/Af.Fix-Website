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
import 'package:affix_web/snackbar/error_snackbar.dart';
import 'package:affix_web/snackbar/sucess_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _emailFocus = new FocusNode();
  final _passwordFocus = new FocusNode();
  bool _emailMiss = false;
  bool _passwordMiss = false;
  DocumentSnapshot snapshot;
  bool _visibilityPassword;

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
                            image: ExtendedNetworkImageProvider(kImageAuth),
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
                                focus: _emailFocus,
                                context: context,
                                isDarkMode: _isDarkMode,
                                controller: _emailInput,
                                type: TextInputType.emailAddress,
                                title: 'Email',
                                subtitle: 'contoh@email.com',
                                icon: Icon(Icons.email),
                                onEnter: () => _passwordFocus.requestFocus(),
                                err: _emailMiss
                                    ? '${AppLocalizations.of(context).translate('noemail')}'
                                    : null,
                                buttonController: _buttonController,
                              ),
                              SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  authTextInput(
                                    context: context,
                                    focus: _passwordFocus,
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
                                    buttonController: _buttonController,
                                    onEnter: () {
                                      FocusScope.of(context).unfocus();
                                      _buttonController.start();
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _visibilityPassword,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _visibilityPassword = newValue;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '${AppLocalizations.of(context).translate('showpassword')}',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              _buttonAuth(
                                  context: context,
                                  onTap: () {
                                    setState(() {
                                      _emailMiss = false;
                                      _passwordMiss = false;
                                    });
                                    _loginAction(context);
                                  }),
                              SizedBox(height: 15),
                              orDivivder(),
                              SizedBox(height: 15),
                              OtherButtonSign(
                                title:
                                    '${AppLocalizations.of(context).translate('googlesignbutton')}',
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
                            focus: _emailFocus,
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
                              _passwordFocus.requestFocus();
                            },
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              authTextInput(
                                context: context,
                                focus: _passwordFocus,
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
                                buttonController: _buttonController,
                                onEnter: () {
                                  FocusScope.of(context).unfocus();
                                  _buttonController.start();
                                },
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: 400,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _visibilityPassword,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _visibilityPassword = newValue;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${AppLocalizations.of(context).translate('showpassword')}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          _buttonAuth(
                              context: context,
                              onTap: () {
                                setState(() {
                                  _emailMiss = false;
                                  _passwordMiss = false;
                                });
                                _loginAction(context);
                              }),
                          SizedBox(height: 30),
                          orDivivder(),
                          SizedBox(height: 10),
                          OtherButtonSign(
                            title:
                                '${AppLocalizations.of(context).translate('googlesignbutton')}',
                          ),
                          SizedBox(height: 30),
                          newUser(context, _isDarkMode),
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
                          'Af-Fix Smartphone Repair - Baiki Smartphone anda dengan mudah',
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

        await context
            .read<AuthenticationServices>()
            .signIn(
                email: _emailInput.text.trim(),
                password: _passwordInput.text.trim())
            .then((e) async {
          if (e == 'user-not-found') {
            _buttonError();
            showErrorSnackBar(
                '${AppLocalizations.of(context).translate('usernotfound')}');
          } else if (e == 'wrong-password') {
            _buttonError();
            showErrorSnackBar(
                '${AppLocalizations.of(context).translate('wrongpassword')}');
          } else if (e != null) {
            _buttonError();
            showErrorSnackBar(
                '${AppLocalizations.of(context).translate('errorfound')}');
          } else {
            User user = FirebaseAuth.instance.currentUser;
            final retrieve =
                await context.read<AuthenticationServices>().getUserName();
            Provider.of<UpdateUI>(context, listen: false).setUserName(retrieve);
            Provider.of<UpdateUI>(context, listen: false).setAnonymous(false);
            _buttonCompleted();
            showSuccessSnackBar(
                '${AppLocalizations.of(context).translate('signincomplete')} ${user.displayName}');
          }
        });
        //setting uid
        FirebaseAuth.instance.authStateChanges().listen((User user) async {
          if (user != null) {
            Provider.of<UpdateUI>(context, listen: false).setUID(user.uid);
          }
        });
      } catch (e) {
        showErrorSnackBar(e);
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
