import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_utils.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String changeEn = "";
  String changeUni = "";

  int? selectedRadio = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f6f4),
      appBar: AppUtils.MyAppBar(context: context, title: 'language'.tr()),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    context.setLocale(Locale('en', 'US'));
                  },
                  trailing: context.locale.languageCode == "en"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  title: Text('english'.tr()),
                ),
                Divider(thickness: 0.1),
                ListTile(
                  onTap: () {
                    context.setLocale(Locale('my', 'MM'));
                  },
                  trailing: context.locale.languageCode == "my"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  title: Text('myanmar'.tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
