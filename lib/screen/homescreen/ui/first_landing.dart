import 'package:affix_web/config/constant.dart';
import 'package:affix_web/screen/homescreen/ui/repair_form.dart';
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Text('Smartphone anda mengalami kerosakkan?',
              style: kTextSubtitleDark)
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
                'Peranti anda mengalami kerosakkan?',
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
                child: RichText(
                  text: TextSpan(
                    text: 'Servis peranti anda dengan ',
                    style: TextStyle(
                      color: kColorGrey,
                      fontSize: 70,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'mudah',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      TextSpan(text: ' dan semestinya '),
                      TextSpan(
                        text: 'dipercayai',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                // child: Text(
                //   'Servis peranti anda dengan mudah dan semestinya dipercayai',
                //   textAlign: TextAlign.left,
                //   style: TextStyle(
                //     color: kColorGrey,
                //     fontSize: 70,
                //     fontWeight: FontWeight.w800,
                //   ),
                // ),
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
                        'Whatsapp kami',
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
                      'Muat turun aplikasi (Akan Datang)',
                      style: kTextSubtitleDark,
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            width: 100,
          ),
          RepairForm()
        ],
      ),
    );
  }
}
