import 'dart:async';
import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/model/auth_services.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/screen/authscreen/ui/text_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:string_validator/string_validator.dart';

class RegisterForm extends StatefulWidget {
  final bool isMobile;
  RegisterForm({this.isMobile});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _errName = false;
  bool _errPhone = false;
  bool _errEmail = false;
  bool _errPassword = false;
  bool _showPassword = false;
  RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: widget.isMobile == true
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        authTextInput(
          context: context,
          controller: _nameController,
          title: '${AppLocalizations.of(context).translate('name')}',
          subtitle: '${AppLocalizations.of(context).translate('yourname')}',
          icon: Icon(Icons.person),
          type: TextInputType.name,
          onEnter: () {
            context.nextEditableTextFocus();
          },
          isDarkMode: _isDarkMode,
          err: _errName
              ? '${AppLocalizations.of(context).translate('pleasename')}'
              : null,
        ),
        SizedBox(height: 20),
        authTextInput(
          context: context,
          controller: _phoneController,
          title: '${AppLocalizations.of(context).translate('phonenumber')}',
          subtitle: '012-34567890',
          icon: Icon(Icons.call),
          type: TextInputType.phone,
          onEnter: () {
            context.nextEditableTextFocus();
          },
          isDarkMode: _isDarkMode,
          err: _errPhone
              ? '${AppLocalizations.of(context).translate('pleasenumber')}'
              : null,
        ),
        SizedBox(height: 20),
        authTextInput(
          context: context,
          controller: _emailController,
          title: 'Email',
          subtitle: 'abdullah@contoh.com',
          icon: Icon(MaterialCommunityIcons.email),
          type: TextInputType.emailAddress,
          onEnter: () {
            context.nextEditableTextFocus();
          },
          isDarkMode: _isDarkMode,
          err: _errEmail
              ? '${AppLocalizations.of(context).translate('pleaseemail')}'
              : null,
        ),
        SizedBox(height: 20),
        authTextInput(
          context: context,
          controller: _passwordController,
          title: '${AppLocalizations.of(context).translate('password')}',
          subtitle:
              '${AppLocalizations.of(context).translate('pleasepassword')}',
          icon: Icon(Icons.password),
          type: TextInputType.visiblePassword,
          isPassword: !_showPassword,
          onEnter: () {
            FocusScope.of(context).unfocus();
            _buttonController.start();
          },
          isDarkMode: _isDarkMode,
          err: _errPassword
              ? '${AppLocalizations.of(context).translate('pleasepassword')}'
              : null,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
              value: _showPassword,
              onChanged: (newValue) {
                setState(() {
                  _showPassword = newValue;
                });
              },
            ),
            SizedBox(width: 5),
            Text(
              '${AppLocalizations.of(context).translate('showpassword')}',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        SizedBox(height: 30),
        SizedBox(
          width: 400,
          child: RoundedLoadingButton(
            color: Colors.blueGrey[800],
            controller: _buttonController,
            onPressed: () {
              _checkError();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(MaterialCommunityIcons.email),
                SizedBox(width: 15),
                Text(
                    '${AppLocalizations.of(context).translate('createaccount')}'),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 400,
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: '${AppLocalizations.of(context).translate('policy1')} ',
                ),
                TextSpan(
                  text: '${AppLocalizations.of(context).translate('tos')}',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text:
                      ', ${AppLocalizations.of(context).translate('policy2')} ',
                ),
                TextSpan(
                    text:
                        '${AppLocalizations.of(context).translate('useragreement')} ',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(color: Colors.blue)),
                TextSpan(
                    text:
                        ', ${AppLocalizations.of(context).translate('and')} '),
                TextSpan(
                    text:
                        '${AppLocalizations.of(context).translate('privacypolicy')}',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(color: Colors.blue))
              ],
            ),
          ),
        )
      ],
    );
  }

  _buttonError() {
    _buttonController.error();
    Timer(Duration(seconds: 2), () {
      _buttonController.reset();
    });
  }

  _createUserSucess() {
    _buttonController.success();
    // showDialogStatus(
    //     title: 'Registration Completed',
    //     content: 'Welcome to Af.Fix ${_nameController.text}');
    DialogBackground(
      blur: 13,
      dialog: AlertDialog(
        title:
            Text('${AppLocalizations.of(context).translate('registerdone')}'),
        content: Text(
            '${AppLocalizations.of(context).translate('signinnew')} ${_nameController.text}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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

  _createUserError() {
    _buttonError();
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

  _checkError() async {
    if (_nameController.text.isEmpty) {
      setState(() {
        _errName = true;
      });
      _buttonError();
    } else {
      setState(() {
        _errName = false;
      });
    }
    if (_phoneController.text.isEmpty) {
      setState(() {
        _errPhone = true;
      });
      _buttonError();
    } else {
      setState(() {
        _errPhone = false;
      });
    }
    if (_emailController.text.isEmpty || !isEmail(_emailController.text)) {
      setState(() {
        _errEmail = true;
      });
      _buttonError();
    } else {
      setState(() {
        _errEmail = false;
      });
    }
    if (_passwordController.text.isEmpty |
        !isLength(_passwordController.text, 6)) {
      setState(() {
        _errPassword = true;
      });
      _buttonError();
    } else {
      setState(() {
        _errPassword = false;
      });
    }

    if (_nameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _errEmail == false &&
        _errPassword == false) {
      await _createUser().then((value) {
        if (Provider.of<AuthenticationServices>(context, listen: false)
                .isError ==
            false) {
          _createUserSucess();
        } else {
          _createUserError();
        }
      });
    }
  }

  Future<void> _createUser() async {
    await context.read<AuthenticationServices>().signUp(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          phone: _phoneController.text,
        );
  }
}
