import '../../global.dart';
import '../database/share_pref.dart';

class LoginProvider extends ChangeNotifier {
  bool isLogin = false;

  checkLogin() async {
    SharedPref.getData(key: SharedPref.token).then((token) {
      if (token == '' || token == "null") {
        isLogin = false;
        notifyListeners();
      } else {
        isLogin = true;
        notifyListeners();
      }
    });
  }
}
