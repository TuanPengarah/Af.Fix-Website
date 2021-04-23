import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/screen/homescreen/ui/repair_form.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FirstLanding extends StatelessWidget {
  const FirstLanding({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1200) {
          return DekstopFirstPageView();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return MobileFirstPageView();
        } else {
          return MobileFirstPageView();
        }
      },
    );
  }
}

class MobileFirstPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height + 900,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Text(AppLocalizations.of(context).translate('broken'),
              textAlign: TextAlign.center, style: kTextSubtitleDark),
          Container(
            width: 200,
            child: Divider(
              thickness: 1,
              color: kColorGrey,
            ),
          ),
          Center(
            child: Container(
              child: AutoSizeText.rich(
                TextSpan(
                  text: '${AppLocalizations.of(context).translate('service')} ',
                  style: TextStyle(
                    color: kColorGrey,
                    letterSpacing: 1.1,
                    fontSize: 40,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('easy')}',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    TextSpan(
                        text:
                            ' ${AppLocalizations.of(context).translate('and')} '),
                    TextSpan(
                      text:
                          '${AppLocalizations.of(context).translate('trust')}',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                minFontSize: 10,
                maxFontSize: 30,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kColorGrey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            icon: Icon(MaterialCommunityIcons.whatsapp),
            label: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                '${AppLocalizations.of(context).translate('whatsapp')}',
                style: kTextSubtitle,
              ),
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.file_download,
              color: kColorGrey,
            ),
            label: Expanded(
              child: Text(
                '${AppLocalizations.of(context).translate('download')}',
                style: kTextSubtitleDark,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          RepairForm(),
        ],
      ),
    );
  }
}

class DekstopFirstPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height + 250,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate('broken'),
                style: TextStyle(
                  color: kColorGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: Divider(
                  thickness: 3,
                  color: kColorGrey,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.4,
                child: AutoSizeText.rich(
                  TextSpan(
                    text:
                        '${AppLocalizations.of(context).translate('service')} ',
                    style: TextStyle(
                      color: kColorGrey,
                      fontSize: 40,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${AppLocalizations.of(context).translate('easy')}',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                          text:
                              ' ${AppLocalizations.of(context).translate('and')} '),
                      TextSpan(
                        text:
                            '${AppLocalizations.of(context).translate('trust')}',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  minFontSize: 25,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kColorGrey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    icon: Icon(MaterialCommunityIcons.whatsapp),
                    label: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        '${AppLocalizations.of(context).translate('whatsapp')}',
                        style: kTextSubtitle,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.file_download,
                      color: kColorGrey,
                    ),
                    label: Text(
                      '${AppLocalizations.of(context).translate('download')}',
                      style: kTextSubtitleDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 40,
          ),
          RepairForm()
        ],
      ),
    );
  }
}
