
import '../../global.dart';

class BottomNavigationIndexProvider extends ChangeNotifier {
  int i = 0;
  int homeBottomIndex = 0;
  // loan type slider
  int sliderIndex = 0;

  CupertinoTabController controller = CupertinoTabController();

  checkHomeIndex(int index) {
    i = index;
    notifyListeners();
  }

  changeHomeBottomIndex(int index) {
    homeBottomIndex = index;
    notifyListeners();
  }

  onChangedSlider(int i) {
    sliderIndex = i;
    notifyListeners();
  }
}
