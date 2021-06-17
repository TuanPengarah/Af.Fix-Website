import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/updateUI_provider.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Row userProfile(String name, BuildContext context, bool hpke, bool isDark) {
  String _photoUrl = Provider.of<UpdateUI>(context).userPhoto;
  bool _isAnony = Provider.of<UpdateUI>(context).checkAnonymous;
  String _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return '${AppLocalizations.of(context).translate('goodmorning')}';
    }
    if (hour < 13) {
      return '${AppLocalizations.of(context).translate('goodafternoon')}';
    }
    return '${AppLocalizations.of(context).translate('goodevening')}';
  }

  return Row(
    children: [
      _photoUrl == null && _isAnony == false
          ? AvatarLetter(
              text: '$name',
              textColor:
                  hpke == true ? Colors.white : Theme.of(context).primaryColor,
              textColorHex: null,
              backgroundColor:
                  hpke == true ? Theme.of(context).primaryColor : Colors.white,
              backgroundColorHex: null,
              letterType: LetterType.Circular,
            )
          : CircleAvatar(
              minRadius: 28,
              backgroundColor:
                  hpke == true ? Theme.of(context).primaryColor : Colors.white,
              backgroundImage:
                  _photoUrl != null ? NetworkImage(_photoUrl) : null,
            ),
      SizedBox(width: 18),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            '${_greeting()},',
            style: TextStyle(
              fontSize: 16,
              color: hpke == false
                  ? Colors.white
                  : isDark == false
                      ? Colors.white
                      : kColorGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: hpke == false ? 150 : 280,
            child: Text(
              '$name',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: hpke == false
                    ? Colors.white
                    : isDark == false
                        ? Colors.white
                        : kColorGrey,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
