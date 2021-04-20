import 'package:affix_web/config/constant.dart';
import 'package:affix_web/screen/homescreen/ui/repair_form.dart';
import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          image: AssetImage('assets/images/back1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Text('Smartphone anda mengalami kerosakkan?', style: kTextSubtitle)
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
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          image: AssetImage('assets/images/back2.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Smartphone anda mengalami kerosakkan?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.white,
                indent: 300,
                endIndent: 300,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.4,
                child: Text(
                  'Servis smartphone anda dengan mudah dan semestinya dipercayai',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ],
          ),
          RepairForm()
        ],
      ),
    );
  }
}
