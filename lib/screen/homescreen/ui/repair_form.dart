import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class RepairForm extends StatelessWidget {
  const RepairForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 800,
      decoration: BoxDecoration(
        color: kColorGrey,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              'Mari mulakan. Kami akan hubungi anda secepat mungkin',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              child: Divider(
                thickness: 1,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
