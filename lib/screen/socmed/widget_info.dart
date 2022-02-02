import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  InfoWidget({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 180,
      // padding: const EdgeInsets.all(15.0),
      // margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            '$title',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            '$subtitle',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
