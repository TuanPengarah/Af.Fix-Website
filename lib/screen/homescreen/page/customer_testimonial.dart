import 'package:affix_web/config/app_localizations.dart';
import 'package:affix_web/config/constant.dart';
import 'package:affix_web/provider/themeUI_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerTestimonial extends StatelessWidget {
  const CustomerTestimonial({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            SelectableText(
              '${AppLocalizations.of(context).translate('testimonial')}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 40,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: Divider(
                thickness: 1,
              ),
            ),
            SizedBox(height: 50),
            Wrap(
              spacing: 100,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _customerCard(
                  'Alhamdulillah wahh phone dapat dibaiki..kemas dan teliti pulak tu😆',
                  'Ijoy',
                  kImageCustomerIjoy,
                  context,
                ),
                _customerCard(
                  'Harga muroh berbanding di tempat lain, owner keda mudoh baso, tpom memey repair sini doh kalu ado gapo2',
                  'Yen',
                  kImageCustomerYen,
                  context,
                ),
                _customerCard(
                  'Phone Huawei lepas format terus kena lock hantar kedai lain mahal gile..siap kena tinggal 2-3 hari lagi, nasib baik ada kawan rekemen dekat brader ni. Alhamdulillah tak sampai sehari dah settle. Siap dapat harga diskaun lagi terbaikkk👍',
                  'Langkojai',
                  kImageCustomerLangkojai,
                  context,
                ),
                _customerCard(
                  '2-3 kali dah repair tempat ni..semua repair dapat harga murah memang puas hati❤️',
                  'Faridzul',
                  kImageCustomerFaridzul,
                  context,
                ),
                _customerCard(
                  'Dah banyak kali repair kat sini sangat2 recommended👍👍',
                  'Jon',
                  kImageCustomerJon,
                  context,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _customerCard(
      String title, String name, String url, BuildContext context) {
    bool _isDarkMode = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      height: 200,
      width: 450,
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey.withOpacity(0.2) : kColorWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color:
                _isDarkMode ? Colors.transparent : Colors.grey.withOpacity(0.5),
            spreadRadius: 6,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(url),
                    maxRadius: 40,
                    backgroundColor: kColorWhiteDark,
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: SelectableText(
                      title,
                      // maxLines: line,
                    ),
                  )
                ],
              ),
            ),
            SelectableText(
              '- ' + name,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
