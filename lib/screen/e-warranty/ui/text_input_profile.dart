import 'package:flutter/material.dart';

Padding textInputProfile(
    {@required bool isMobile,
    @required BuildContext context,
    @required TextEditingController controller,
    @required String title,
    @required IconData icon,
    bool lock,
    bool isDarkMode}) {
  if (controller.text.isEmpty) {
    controller.text = '--';
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth:
              isMobile == true ? MediaQuery.of(context).size.width - 60 : 450),
      child: TextField(
        controller: controller,
        enabled: lock ?? false,
        style: TextStyle(
          color: lock == false
              ? Colors.grey
              : isDarkMode == true
                  ? Colors.black
                  : Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
            labelText: '$title',
            prefixIcon: Icon(
              icon,
              color:
                  lock == false ? Colors.grey : Theme.of(context).primaryColor,
            ),
            border: OutlineInputBorder(
              gapPadding: 2,
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
      ),
    ),
  );
}
