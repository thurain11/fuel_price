import '../../global.dart';
import '../../pages/root_page.dart';

class ServerErrWidget extends StatelessWidget {
  final Function? fun;
  final double? widgetSize;

  ServerErrWidget({this.fun, this.widgetSize = 300});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(child: Image.asset('assets/images/500.png', height: 200)),
          Center(
            child: Text(
              '500 INTERNAL SERVER ERROR!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      context.offAll(RootPage());
                    },
                    child: Text(
                      "Back Home",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
