import 'package:flutter/material.dart';

Padding textInputProfile({
  @required bool isMobile,
  @required BuildContext context,
  @required TextEditingController controller,
  @required String title,
  @required IconData icon,
}) {
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
        enabled: false,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white10,
          labelText: '$title',
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(gapPadding: 2),
        ),
      ),
    ),
  );
}
