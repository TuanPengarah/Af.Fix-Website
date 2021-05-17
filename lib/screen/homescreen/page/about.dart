import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class About extends StatefulWidget {
  const About({
    Key key,
  }) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  AnimationController _lottieFirstController;
  AnimationController _lottieSecondController;
  AnimationController _lottieThirdController;
  AnimationController _lottieForthController;
  AnimationController _lottieFithController;
  AnimationController _lottieSixController;

  @override
  void initState() {
    super.initState();
    _lottieFirstController = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {});
      });
    _lottieSecondController = AnimationController(vsync: this)
      ..value = 0.7
      ..addListener(() {
        setState(() {});
      });
    _lottieThirdController = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {});
      });
    _lottieForthController = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {});
      });
    _lottieFithController = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {});
      });
    _lottieSixController = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _lottieFirstController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorRed,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                child: SelectableText(
                  '${AppLocalizations.of(context).translate('whyus')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 40,
                  ),
                ),
              ),
              Divider(
                indent: 80,
                endIndent: 80,
                color: Colors.white,
              ),
              SizedBox(height: 80),
              Wrap(
                spacing: 100,
                runSpacing: 50,
                alignment: WrapAlignment.center,
                children: [
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('cheap')}',
                    _lottieFirstController,
                    kLottieMoney,
                    200,
                    0.5,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('bmf')}',
                    _lottieSecondController,
                    kLottieMalaysia,
                    150,
                    0.65,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('mailin')}',
                    _lottieThirdController,
                    kLottieCourier,
                    200,
                    0.5,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('services')}',
                    _lottieForthController,
                    kLottieService,
                    200,
                    0.5,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('diagnostic')}',
                    _lottieFithController,
                    kLottieChecking,
                    200,
                    0.5,
                  ),
                  aboutContaint(
                    '${AppLocalizations.of(context).translate('system')}',
                    _lottieSixController,
                    kLottieSystem,
                    200,
                    0.5,
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Container aboutContaint(String title, AnimationController controller,
      String url, double height, double value) {
    return Container(
      height: 450,
      width: 300,
      color: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              onExit: (_exit) {
                controller.value = value;
              },
              onEnter: (_enter) {
                controller.forward(
                    from: controller.value == 1 ? 0 : controller.value);
              },
              child: Center(
                child: Lottie.network(url,
                    controller: controller,
                    height: height, onLoaded: (composition) {
                  setState(() {
                    controller.duration = composition.duration;
                  });
                }),
              ),
            ),
            SizedBox(height: 15),
            SelectableText(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                fontSize: 20,
                color: kColorWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
