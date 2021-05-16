import 'dart:async';
import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/model/firestore_add.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild.context.widget is! EditableText);
  }
}

class RepairForm extends StatefulWidget {
  @override
  _RepairFormState createState() => _RepairFormState();
}

class _RepairFormState extends State<RepairForm> {
  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _model = TextEditingController();
  final _kerosakkan = TextEditingController();

  void _submitted() async {
    Timer(Duration(seconds: 2), () async {
      if (_formKey.currentState.validate()) {
        try {
          await AddAppointment(
            context: context,
            email: _email.text,
            model: _model.text,
            name: _name.text,
            noPhone: _phoneNumber.text,
            problem: _kerosakkan.text,
          ).addToFirestore();
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
        _email.clear();
        _kerosakkan.clear();
        _model.clear();
        _name.clear();
        _phoneNumber.clear();
        _buttonController.success();

        Timer(Duration(seconds: 2), () {
          _buttonController.reset();
        });
      } else {
        _buttonController.error();
        Timer(Duration(seconds: 2), () {
          _buttonController.reset();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Form(
      key: _formKey,
      child: Container(
        width: 500,
        height: 850,
        decoration: BoxDecoration(
          color: _isDarkMode ? Colors.grey.shade900 : kColorGrey,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                '${AppLocalizations.of(context).translate('start')}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 100,
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${AppLocalizations.of(context).translate('emptyfield')}';
                    }
                    return null;
                  },
                  onEditingComplete: () => context.nextEditableTextFocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText:
                        '${AppLocalizations.of(context).translate('name')}',
                    hintText: 'Abdullah',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _phoneNumber,
                  onEditingComplete: () => context.nextEditableTextFocus(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${AppLocalizations.of(context).translate('emptyfield')}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText:
                        '${AppLocalizations.of(context).translate('phonenumber')}',
                    hintText: '012-3456789',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _email,
                  onEditingComplete: () => context.nextEditableTextFocus(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${AppLocalizations.of(context).translate('emptyfield')}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Email',
                    hintText: 'abdullah@mail.com',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _model,
                  onEditingComplete: () => context.nextEditableTextFocus(),
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${AppLocalizations.of(context).translate('emptyfield')}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Model',
                    hintText: 'Huawei Nova 3i, iPhone 8...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  // maxLines: 3,
                  controller: _kerosakkan,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.send,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${AppLocalizations.of(context).translate('emptyfield')}';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                    labelText:
                        '${AppLocalizations.of(context).translate('damage')}',
                    hintText: '${AppLocalizations.of(context).translate('eg')}',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedLoadingButton(
                    errorColor: Colors.red,
                    controller: _buttonController,
                    onPressed: () => _submitted(),
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(width: 15),
                        Text(
                            '${AppLocalizations.of(context).translate('send')}'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
