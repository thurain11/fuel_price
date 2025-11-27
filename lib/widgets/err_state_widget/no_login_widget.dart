import 'package:provider/provider.dart';

import '../../core/database/share_pref.dart';
import '../../core/providers/login_provider.dart';
import '../../global.dart';

class NoLoginWidget extends StatelessWidget {
  String? message;
  NoLoginWidget({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            child: Image.asset('assets/images/404.png'),
            width: 200,
            height: 200,
          ),

          Center(child: Text("You need to login to continue")),
          SizedBox(height: 20),
          Center(
            child: Container(
              // height: 25,
              child: ElevatedButton(
                onPressed: () {
                  SharedPref.setData(key: SharedPref.token, value: '').then((
                    token,
                  ) {
                    Provider.of<LoginProvider>(
                      context,
                      listen: false,
                    ).checkLogin();
                  });
                  // context.off(LoginPage());
                },
                child: Text("Login Page"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
