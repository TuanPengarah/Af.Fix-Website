import 'dart:async';
import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:affix_web/screen/MyStatusID/MyStatusID_modal_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MyRepairIDContainer extends StatefulWidget {
  final String mySIDText;

  MyRepairIDContainer({this.mySIDText});
  @override
  _MyRepairIDContainerState createState() => _MyRepairIDContainerState();
}

final RoundedLoadingButtonController _buttonController =
    RoundedLoadingButtonController();

class _MyRepairIDContainerState extends State<MyRepairIDContainer> {
  final _inputSearch = TextEditingController();
  _checkDatabase(BuildContext context) async {
    final _inputText = _inputSearch.text;
    if (_inputText.isEmpty) {
      _buttonController.error();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${AppLocalizations.of(context).translate('emptyfieldmysid')}'),
        ),
      );
      Timer(Duration(seconds: 3), () {
        _buttonController.reset();
      });
    } else {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('MyrepairID')
            .doc(_inputText)
            .get();
        if (snapshot == null || !snapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${AppLocalizations.of(context).translate('recordnotfound')}'),
            ),
          );
          _buttonController.error();
          Timer(Duration(seconds: 2), () {
            _buttonController.reset();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${AppLocalizations.of(context).translate('recordfound')}'),
            ),
          );

          _buttonController.success();
          Timer(Duration(seconds: 2), () {
            showDetails(context, _inputText);
            _buttonController.reset();
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
        _buttonController.error();
        Timer(Duration(seconds: 2), () {
          _buttonController.reset();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.mySIDText == null) {
      _inputSearch.text = '';
    } else {
      _inputSearch.text = widget.mySIDText.toString();
      Timer(Duration(milliseconds: 1500), () {
        _buttonController.start();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _inputSearch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(kImageTicket),
                    height: 180,
                  ),
                  SizedBox(height: 10),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('trackyourrepair')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  SelectableText(
                    '${AppLocalizations.of(context).translate('tyrsubtitle')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      controller: _inputSearch,
                      cursorColor: Colors.white,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      onEditingComplete: () {
                        print(_inputSearch.text);
                        _buttonController.start();
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        hintText:
                            '${AppLocalizations.of(context).translate('egmysid')}',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                        filled: true,
                        alignLabelWithHint: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),
                        labelText:
                            '${AppLocalizations.of(context).translate('tyrhint')}',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: _isDarkMode == false
                                  ? Colors.teal.shade700
                                  : Colors.red.shade800,
                              width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    height: 120,
                    child: RoundedLoadingButton(
                      successColor: Colors.white,
                      valueColor: Theme.of(context).primaryColor,
                      errorColor: Colors.white,
                      controller: _buttonController,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _checkDatabase(context);
                      },
                      color: kColorWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            MaterialCommunityIcons.notebook,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            '${AppLocalizations.of(context).translate('trackbutton')}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
