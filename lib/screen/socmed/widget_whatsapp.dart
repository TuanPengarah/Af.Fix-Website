import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:universal_html/html.dart' as html;
import '../../config/constant.dart';

class WhatsappNow extends StatelessWidget {
  const WhatsappNow({
    Key key,
    @required String photoURL,
  })  : _photoURL = photoURL,
        super(key: key);

  final String _photoURL;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: 140,
          width: MediaQuery.of(context).size.width,
          color: _photoURL == '' ? Colors.transparent : Colors.black,
        ),
        Container(
          alignment: Alignment.center,
          height: 250,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ingin bercakap dengan technician kami dan ingin mengetahui harga spareparts untuk peranti anda? WhatsApp kami sekarang!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 190,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 200));
                      html.window.open(kWhatsAppLink, 'WhatsApp');
                    },
                    icon: Icon(
                      MaterialCommunityIcons.whatsapp,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text(
                      'WhatsApp',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
