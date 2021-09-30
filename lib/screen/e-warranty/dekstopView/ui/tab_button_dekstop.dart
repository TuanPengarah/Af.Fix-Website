import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabButtonDekstop extends StatelessWidget {
  final String label;
  final IconData icon;
  final int pageNumber;
  final int selectablePage;
  final Function onTap;

  TabButtonDekstop({
    @required this.label,
    @required this.icon,
    this.pageNumber,
    this.selectablePage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white10,
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          width: 250,
          color: pageNumber == selectablePage
              ? _isDarkMode == true
                  ? Colors.blue[700]
                  : Colors.teal[900]
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(
                icon,
                size: 35,
                color: pageNumber == selectablePage
                    ? Colors.white
                    : Colors.white54,
              ),
              SizedBox(width: 30),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: pageNumber == selectablePage
                      ? Colors.white
                      : Colors.white54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
