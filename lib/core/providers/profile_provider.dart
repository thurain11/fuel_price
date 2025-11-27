// import 'dart:convert';
//
// import '../../global.dart';
// import '../constants/app_constants.dart';
// import '../database/share_pref.dart';
// import '../network/dio_basenetwork.dart';
// import '../ob/response_ob.dart';
//
//
// class ProfileProvider extends ChangeNotifier {
//   ResponseOb profileResponse = ResponseOb();
//   ShopProfileData? profileData;
//   DioBaseNetwork _network = DioBaseNetwork();
//   bool isBirthday = false;
//   bool isLogin = false;
//   bool isStuff = false;
//   bool isMicrofinance = false;
//
//   ProfileProvider.initialize() {
//     SharedPref.getData(key: SharedPref.token).then((data) {
//       if (data != "null" && data != "") {
//         isLogin = true;
//         // getUserProfileData(isRefresh: false);
//       } else {
//         profileData = null;
//         isLogin = false;
//       }
//       notifyListeners();
//     });
//   }
//
//   getUserProfileData({bool isRefresh = true, bool cache = false}) async {
//     profileResponse = ResponseOb(message: MsgState.loading, data: null);
//     if (isRefresh) {
//       notifyListeners();
//     }
//
//     if (cache) {
//       SharedPref.getData(key: SharedPref.profile).then((data) {
//         if (data != "null") {
//           ShopProfileOb userOb = ShopProfileOb.fromJson(json.decode(data));
//           profileResponse.message = MsgState.data;
//           profileResponse.data = userOb.data;
//           profileData = userOb.data;
//           // SharedPref.setData(key: SharedPref.owner_id, value: profileData!.id ?? "");
//           notifyListeners();
//         }
//       });
//     }
//
//     try {
//       _network.getReq(MAIN_URL + 'shop-portal/profile', callBack: (rv) {
//         if (rv.message == MsgState.data) {
//           // Map<String, dynamic> map = rv.data;
//           print(rv.data.runtimeType.toString() + " What --->");
//           if (rv.data['result'] == 1) {
//             // UserProfileOb userOb = ShopProfileOb().fromJson(rv.data['data']);
//             ShopProfileOb userOb = ShopProfileOb.fromJson(rv.data);
//
//             // SharedPref.setData(key: SharedPref.profile, value: json.encode(rv.data));
//
//             profileResponse.message = MsgState.data;
//             profileResponse.data = userOb.data;
//             profileData = userOb.data;
//
//             // SharedPref.setData(
//             //     key: SharedPref.owner_id, value: profileData!.id.toString() ?? '');
//
//             notifyListeners();
//           } else {
//             profileResponse.message = MsgState.more;
//             profileResponse.data = rv.data;
//             notifyListeners();
//           }
//         } else {
//           if (rv.errState == ErrState.no_login) {
//             // SharedPreferences.getInstance().then((shp) {
//             //   shp.clear();
//             // });
//             isLogin = false;
//             profileData = null;
//             notifyListeners();
//           }
//
//           if (rv.errState == ErrState.no_internet) {
//             SharedPref.getData(key: SharedPref.profile).then((data) {
//               if (data != "null") {
//                 ShopProfileOb userOb = ShopProfileOb.fromJson(json.decode(data));
//                 profileResponse.message = MsgState.data;
//                 profileResponse.data = userOb.data;
//                 profileData = userOb.data;
//                 notifyListeners();
//               } else {
//                 profileResponse = rv;
//                 notifyListeners();
//               }
//             });
//           } else {
//             profileResponse = rv;
//             notifyListeners();
//           }
//         }
//       });
//     } catch (e) {
//       profileResponse.message = MsgState.error;
//       profileResponse.data = "Unknown Error";
//       profileResponse.errState = ErrState.unknown_err;
//       notifyListeners();
//     }
//   }
//
//   ResponseOb deliRespObj = ResponseOb();
//
//   checkLogin() {
//     SharedPref.getData(key: SharedPref.token).then((value) {
//       if (value != "null") {
//         isLogin = true;
//         notifyListeners();
//       } else {
//         profileData = null;
//         isLogin = false;
//         notifyListeners();
//       }
//     });
//   }
//
//   void showFinishBirthday() {
//     isBirthday = false;
//     notifyListeners();
//   }
//
//   void dispose() {}
// }
//
