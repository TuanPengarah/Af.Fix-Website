import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';

class PWA extends StatelessWidget {
  const PWA({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SelectableText(
              'Alat berguna untuk anda terokai',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                // color: kColorWhite,
                fontSize: 40,
              ),
            ),
            Container(
              width: 200,
              child: Divider(
                thickness: 1,
                // color: Colors.white,
              ),
            ),
            SizedBox(height: 60),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 60,
              runSpacing: 50,
              children: [
                pwaContainer(
                    'MyRepair ID',
                    'Setiap phone yang di pick up untuk dibaiki atau telah dibaiki akan diberikan nombor tracking. Jom tracking smartphone anda di sini',
                    'Track smartphone saya'),
                pwaContainer(
                    'E-Waranti',
                    'Setiap phone yang di pick up untuk dibaiki atau telah dibaiki akan diberikan nombor tracking. Jom tracking smartphone anda di sini',
                    'Lihat semua waranti saya'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container pwaContainer(String title, String subtitle, String button) {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: kColorRed,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SelectableText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: kColorWhite,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 20),
            SelectableText(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: kColorWhite,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kColorWhite),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  button,
                  style: TextStyle(
                    color: kColorRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
