import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:system_info_agent/system_info_agent.dart';
import 'package:toastification/toastification.dart';

import '../../global.dart';
import '../ob/response_ob.dart';

enum SnackColor { Warning, Success, Error }

class ToastHelper {
  static void showSuccessToast({
    String? title,
    String? description,
    required BuildContext context,
  }) {
    Toastification().show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      // title: Text(title??''),
      description: description != null ? Text(description) : null,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check),
      showIcon: true,
      primaryColor: Colors.white,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      ),
      progressBarTheme: ProgressIndicatorThemeData(color: Colors.grey),
    );
  }

  static void showErrorToast({
    String? title,
    String? description,
    required BuildContext context,
  }) {
    Toastification().show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,

      // title: Text(title??''),
      description: description != null ? Text(description) : null,
      backgroundColor: Colors.redAccent[200],
      primaryColor: Colors.white,
      foregroundColor: Colors.white,
      showProgressBar: true,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      showIcon: true,
      progressBarTheme: ProgressIndicatorThemeData(color: Colors.grey),
    );
  }

  static checkError(ResponseOb resp, {required BuildContext context}) {
    String error = "Unknown Error";

    if (resp.errState == ErrState.no_internet) {
      error = "No Internet connection! ";
    } else if (resp.errState == ErrState.not_found) {
      error = "Your requested data not found!";
    } else if (resp.errState == ErrState.connection_timeout) {
      error = "Connection Timeout! Try Again";
    } else if (resp.errState == ErrState.too_many_request) {
      error = "Too Many Request! Try Again Later";
    } else if (resp.errState == ErrState.validate_err) {
      var v = json.decode(resp.data);
      error = v['message'].toString();
    } else if (resp.errState == ErrState.server_error) {
      error = "Internal Server Error! Try Again";
    } else if (resp.errState == ErrState.unknown_err) {
      error = "Unknown Error";
    } else {
      error = "Unknown Error";
    }

    // AppUtils.showSnackBar(error, color: Colors.red, textColor: Colors.white);
    ToastHelper.showErrorToast(description: error, context: context);
  }
}

class AppUtils {
  static PreferredSize statusBar({Color color = Colors.teal}) {
    return PreferredSize(
      child: Container(color: color),
      preferredSize: Size(double.infinity, 0),
    );
  }

  // it's from notification or not
  static bool isOpenByNotification = false;

  static PreferredSize MyAppBar({
    Widget? leading,
    required BuildContext? context,
    List<Widget>? actions,
    required String? title,
    bool centerTitle = true,
    bool autoImplement = true,
    bool hasBottomBar = false,
    PreferredSizeWidget? bottom,
    Color? color,
    Color? statusBarColor,
    Brightness? statusBrightness,
    String fontFamily = 'roboto',
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w500,
    Color? textColor,
    Color? iconColor,
    Widget? widget,
  }) {
    // Ensure context is not null
    assert(context != null, 'Context must not be null');

    final theme = Theme.of(context!); // Retrieve the theme
    final appBarTheme = theme.appBarTheme; // Access the AppBar theme if defined

    return PreferredSize(
      preferredSize: Size(double.infinity, (bottom == null ? 50 : 100)),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        actionsIconTheme: IconThemeData(
          // color: appBarTheme.actionsIconTheme?.color ?? theme.primaryColor,
        ),
        backgroundColor:
            color ??
            appBarTheme.backgroundColor ??
            theme.scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:
              statusBarColor ??
              appBarTheme.backgroundColor ??
              theme.primaryColor,
          statusBarIconBrightness: statusBrightness ?? Brightness.light,
        ),
        iconTheme: IconThemeData(
          color:
              iconColor ??
              appBarTheme.iconTheme?.color ??
              theme.iconTheme.color,
        ),
        automaticallyImplyLeading: autoImplement,
        title:
            widget ??
            Text(
              title!,
              style: TextStyle(
                // color:
                //     textColor ??
                //     theme.primaryColor
                //         ??
                //     theme.textTheme.headlineSmall?.color,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
        centerTitle: centerTitle,
        actions: actions,
        leading: leading,
        bottom: bottom,
      ),
    );
  }

  // static void showSnackBar(String str, {color = Colors.green, textColor = Colors.white, BuildContext? context}) {
  //
  //
  //
  // }

  // static void showNormal(String str, {color = Colors.redAccent, textColor = Colors.white}) {
  //   rootScaffoldKey.currentState!.showSnackBar(SnackBar(
  //     duration: Duration(seconds: 4),
  //     behavior: SnackBarBehavior.floating,
  //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(5.0),
  //     ),
  //     content: Container(
  //       padding: EdgeInsets.all(5),
  //       child: Text(
  //         str,
  //         style: TextStyle(color: textColor, fontSize: 16),
  //       ),
  //     ),
  //     backgroundColor: color,
  //   ));
  // }

  // static checkError(ResponseOb resp) {
  //   String error = "Unknown Error";
  //
  //   if (resp.errState == ErrState.no_internet) {
  //     error = "No Internet connection! ";
  //   } else if (resp.errState == ErrState.not_found) {
  //     error = "Your requested data not found!";
  //   } else if (resp.errState == ErrState.connection_timeout) {
  //     error = "Connection Timeout! Try Again";
  //   } else if (resp.errState == ErrState.too_many_request) {
  //     error = "Too Many Request! Try Again Later";
  //   } else if (resp.errState == ErrState.validate_err) {
  //     var v = json.decode(resp.data);
  //     error = v['message'].toString();
  //   } else if (resp.errState == ErrState.server_error) {
  //     error = "Internal Server Error! Try Again";
  //   } else if (resp.errState == ErrState.unknown_err) {
  //     error = "Unknown Error";
  //   } else {
  //     error = "Unknown Error";
  //   }
  //
  //   // AppUtils.showSnackBar(error, color: Colors.red, textColor: Colors.white);
  //   // ToastHelper.showErrorToast(context: context, title: error);
  // }

  static String? getUserAgent() {
    String userAgent, webViewUserAgent;
    try {
      return SystemInfoAgent.userAgent;
      // return await FlutterUserAgent.getPropertyAsync('userAgent');
    } on PlatformException {
      return webViewUserAgent = '<error>';
    }
  }

  //moreState
  static moreResponse(ResponseOb rv, BuildContext context) {
    Map<String, dynamic> myMap = rv.data;

    // if (myMap['target'].toString() == "agent_login") {
    //   AppUtils.expireLoginDialog(context, message: myMap['message'].toString());
    // } else if (myMap['target'].toString() == "customer_login") {
    //   // AppUtils.userDeactivateLogin(context, message: myMap['message'].toString());
    //   AppUtils.expireLoginDialog(context, message: myMap['message'].toString());
    // } else {
    //   AppUtils.showSnackBar(myMap['message'].toString(), textColor: Colors.white, color: Colors.redAccent);
    // }
  }
}

//0975688555
