import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabButton extends StatelessWidget {
  final String tabName;
  final int pageNumber;
  final int selectablePage;
  final Function onPressed;
  final IconData icon;
  TabButton(
      {this.tabName,
      this.pageNumber,
      this.selectablePage,
      this.onPressed,
      this.icon});

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;

    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeOutExpo,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: pageNumber == selectablePage
              ? Theme.of(context).primaryColor
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon ?? Icons.history,
              color: pageNumber == selectablePage
                  ? Colors.white
                  : _isDarkMode == false
                      ? Colors.white
                      : Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              tabName ?? 'Tab Button',
              style: TextStyle(
                color: pageNumber == selectablePage
                    ? Colors.white
                    : _isDarkMode == false
                        ? Colors.white
                        : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
