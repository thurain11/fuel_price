import 'dart:io';

import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/providers/theme_provider.dart';
import '../../core/utils/app_utils.dart';
import '../../global.dart';
import '../../widgets/icon_lavel_widget.dart';
import '../../widgets/my_card.dart';
import 'language_page/language_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late String operatingSystem;

  @override
  void initState() {
    super.initState();

    operatingSystem = Platform.isAndroid ? 'Android' : 'ios';
  }

  @override
  Widget build(BuildContext context) {
    // LoginProvider lp = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppUtils.MyAppBar(context: context, title: context.tr("setting")),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                titleIconWidget(
                  title: context.tr('setting'),
                  icon: Icon(
                    LineIcons.cogs,
                    // color: Colors.grey,
                  ),
                ),
                myListTileWidget(
                  leading: IconLabelWidget(iconName: CupertinoIcons.globe),
                  onTap: () => context.to(LanguagePage()),
                  title: context.tr('language'),
                  trailing: Icon(CupertinoIcons.right_chevron, size: 16),
                ),
                Consumer<ThemeProvider>(
                  builder: (con, ThemeProvider tm, child) {
                    return myListTileWidget(
                      leading: IconLabelWidget(
                        iconName: Icons.palette_outlined,
                      ),
                      title: tr('theme'),
                      trailing: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text("Light"),
                            value: ThemeMode.light,
                          ),
                          DropdownMenuItem(
                            child: Text("Dark"),
                            value: ThemeMode.dark,
                          ),
                          DropdownMenuItem(
                            child: Text("System"),
                            value: ThemeMode.system,
                          ),
                        ],
                        onChanged: (dynamic value) {
                          if (value == ThemeMode.light) {
                            tm.changeToLight();
                          } else if (value == ThemeMode.dark) {
                            tm.changeToDark();
                          } else {
                            tm.changeToSystem();
                          }
                        },
                        value: tm.themeMode,
                        underline: Container(),
                      ),
                    );
                  },
                ),
                titleIconWidget(
                  title: context.tr('other'),
                  icon: Icon(
                    LineIcons.rssSquare,
                    // color: Colors.grey,
                  ),
                ),
                myListTileWidget(
                  leading: IconLabelWidget(
                    iconName: CupertinoIcons.doc_plaintext,
                  ),

                  title: context.tr('terms'),
                  trailing: Icon(CupertinoIcons.right_chevron, size: 16),
                ),
                myListTileWidget(
                  leading: IconLabelWidget(
                    iconName: CupertinoIcons.doc_plaintext,
                  ),
                  onTap: () {},
                  title: context.tr('privacy'),
                  trailing: Icon(CupertinoIcons.right_chevron, size: 16),
                ),
                myListTileWidget(
                  leading: IconLabelWidget(iconName: CupertinoIcons.person_2),
                  onTap: () {},
                  title: context.tr('about_us'),
                  trailing: Icon(CupertinoIcons.right_chevron, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  titleIconWidget({String? title, Icon? icon}) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 16, 0, 0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).cardColor,
            ),
            child: icon,
          ),
          SizedBox(width: 4),
          Text(title!, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget myListTileWidget({
    required Widget leading,
    required String title,
    Widget? trailing,
    Function()? onTap,
  }) {
    return MyCard(
      // color: Colors.white,
      mb: 0,
      pa: 4,
      mh: 10,
      child: ListTile(
        leading: leading,
        onTap: onTap,
        title: Text(title, style: Theme.of(context).textTheme.titleSmall),
        trailing: trailing,
      ),
    );
  }
}

class ShimmerVersionLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(height: 8.0, color: Colors.white),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(height: 8.0, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 15,
            // ),
          ],
        ),
      ),
    );
  }
}
