import 'dart:async';

import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/model/firestore_add.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RepairFormMobile extends StatefulWidget {
  @override
  _RepairFormMobileState createState() => _RepairFormMobileState();
}

class _RepairFormMobileState extends State<RepairFormMobile> {
  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _model = TextEditingController();
  TextEditingController _kerosakkan = TextEditingController();

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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Processing Data')));
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
        width: MediaQuery.of(context).size.width - 10,
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
              Center(
                child: SelectableText(
                  '${AppLocalizations.of(context).translate('start')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.done,
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
