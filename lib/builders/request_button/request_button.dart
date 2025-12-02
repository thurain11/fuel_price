import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../../core/network/dio_basenetwork.dart';
import '../../core/ob/response_ob.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/utils/app_utils.dart';
import '../../global.dart';
import '../../widgets/loading_widget.dart';
import 'request_button_bloc.dart';

typedef dynamic OnPressed();
typedef Future<Map<String, dynamic>?>? onAsyncPressed();

typedef void SuccessFuncMethod(ResponseOb ob);
typedef void ValidFuncMethod(ResponseOb ob);
typedef void MoreFuncMethod(ResponseOb ob);
typedef void StateFuncMethod(ResponseOb ob);

class RequestButton extends StatefulWidget {
  String? url; //request url
  String? text; //
  ScaffoldState? scaffoldState;
  bool changeFormData; //dio request -> true/false
  bool isShowDialog; //true
  Color textColor;
  Color? color;
  EdgeInsetsGeometry padding;
  TextStyle? textStyle;
  SuccessFuncMethod successFunc;
  StateFuncMethod? stateFunc;
  MoreFuncMethod? moreFunc;
  OnPressed? onPress; //Map
  onAsyncPressed? onAsyncPress; //Map<>
  Function? errorFunc; //
  ValidFuncMethod? validFunc;
  ReqType requestType;
  bool isDisable;
  double borderRadius;
  BorderRadius? bRadius;
  bool showErrSnack;
  Widget? icon;
  Widget? loadingWidget;
  bool showLoading;
  Color borderColor;
  double borderWidth;
  bool isAlreadyFormData;
  TextAlign? align;
  String? tempId;
  bool isCupertino;

  RequestButton({
    required this.url,
    required this.text,
    this.scaffoldState,
    required this.successFunc,
    this.stateFunc,
    this.moreFunc,
    this.errorFunc,
    this.isAlreadyFormData = false,
    this.showLoading = true,
    this.onPress,
    this.onAsyncPress,
    this.changeFormData = false,
    this.textColor = Colors.white,
    this.color,
    this.padding = const EdgeInsets.all(10),
    this.isShowDialog = false,
    this.textStyle,
    this.align,
    this.validFunc,
    this.requestType = ReqType.Post,
    this.isDisable = false,
    this.borderRadius = 5,
    this.bRadius,
    this.showErrSnack = true,
    this.icon,
    this.loadingWidget,
    this.borderColor = Colors.transparent,
    this.isCupertino = false,
    this.borderWidth = 0.0,
    this.tempId = '',
  });

  @override
  _RequestButtonState createState() => _RequestButtonState();
}

class _RequestButtonState extends State<RequestButton> {
  final _bloc = RequestButtonBloc();

  bool isShowingDialog = false;

  @override
  void initState() {
    super.initState();

    _bloc.getRequestStream().listen((ResponseOb resp) {
      if (widget.stateFunc != null) {
        widget.stateFunc!(resp);
      }

      if (resp.message == MsgState.data) {
        if (widget.isShowDialog) {
          if (isShowingDialog) {
            Navigator.of(context).pop();
          }
        }
        widget.successFunc(resp);
      }

      if (resp.message == MsgState.more) {
        if (widget.isShowDialog) {
          if (isShowingDialog) {
            Navigator.of(context).pop();
          }
        }
        if (widget.errorFunc == null) {
          if (widget.showErrSnack) {
            // AppUtils.moreResponse(resp, context);
          }
          if (widget.moreFunc != null) {
            Map<String, dynamic> moreMap = resp.data;
            widget.moreFunc!(resp);
          } else if (widget.moreFunc == null) {
            Map<String, dynamic> moreMap = resp.data;
          }
        } else {
          widget.errorFunc!();
        }
      }

      if (resp.message == MsgState.error) {
        if (resp.errState == ErrState.no_login) {
          //&& widget.errorFunc == null
        }

        if (widget.isShowDialog) {
          if (isShowingDialog) {
            Navigator.of(context).pop();
          }
        }

        if (widget.errorFunc == null) {
          if (widget.scaffoldState != null) {
            ToastHelper.checkError(resp, context: context);
          } else {
            if (widget.showErrSnack) {
              // ToastHelper.showErrorToast(title: "Error", context: context);
              // toastification.show(
              //   context: context, // optional if you use ToastificationWrapper
              //   title: Text('Hello, world!'),
              //   autoCloseDuration: const Duration(seconds: 5),
              // );

              ToastHelper.checkError(resp, context: context);
            } else {
              if (resp.errState == ErrState.server_error) {
                ToastHelper.showErrorToast(
                  title: "Internal Server Error",
                  context: context,
                );
              }

              if (resp.errState == ErrState.no_internet) {
                // ToastHelper.sh("No Internet connection!", color: Colors.redAccent,context: context);
                ToastHelper.showErrorToast(
                  title: "No Internet connection!",
                  context: context,
                );
              }

              if (resp.errState == ErrState.not_found) {
                ToastHelper.showErrorToast(
                  title: "Your requested data not found!",
                  context: context,
                );
              }

              if (resp.errState == ErrState.connection_timeout) {
                ToastHelper.showErrorToast(
                  title: "Connection Timeout! Try Again!",
                  context: context,
                );
              }
            }
          }
        } else {
          widget.errorFunc!();
          if (widget.showErrSnack) {
            if (widget.scaffoldState != null) {
              ToastHelper.checkError(resp, context: context);
            } else {
              ToastHelper.checkError(resp, context: context);
            }
          }
        }

        if (resp.errState == ErrState.validate_err) {
          print("This is val ==>");
          if (widget.validFunc != null) {
            resp.data = json.decode(resp.data);
            widget.validFunc!(resp);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResponseOb>(
      initialData: ResponseOb(),
      stream: _bloc.getRequestStream(),
      builder: (context, snapshot) {
        ResponseOb? resp = snapshot.data;
        if (widget.showLoading) {
          if (resp!.message == MsgState.loading &&
              widget.isShowDialog == false) {
            return Center(child: widget.loadingWidget ?? LoadingWidget());
          } else {
            return widget.isCupertino ? cupertinoWidget() : mainWidget();
          }
        } else {
          return widget.isCupertino ? cupertinoWidget() : mainWidget();
        }
      },
    );
  }

  Widget cupertinoWidget() {
    return CupertinoButton(
      padding: widget.padding,
      borderRadius: widget.bRadius == null
          ? BorderRadius.circular(widget.borderRadius)
          : widget.bRadius!,
      onPressed: widget.isDisable
          ? null
          : () async {
              // print(widget.onPress!().toString() + " On Press )))))))))");

              if (widget.onPress != null) {
                if (widget.onPress!() != null) {
                  Map<String, dynamic> map = widget.onPress!();

                  checkDialog();
                  if (map['is_logout'] == true) {
                    // NotificationSubscribeService.logoutSubscribe().then((value) {
                    //
                    //   Future.delayed(Duration(seconds: 3),(){
                    //     if (widget.isAlreadyFormData) {
                    //       _bloc.postData(widget.url,
                    //         fd: widget.onPress!(),
                    //         requestType: widget.requestType,);
                    //     } else {
                    //       if (!widget.changeFormData) {
                    //         _bloc.postData(widget.url,
                    //           map: widget.onPress!(),
                    //           requestType: widget.requestType,);
                    //       } else {
                    //         FormData fd = FormData.fromMap(widget.onPress!());
                    //         _bloc.postData(widget.url,
                    //           fd: fd,
                    //           requestType: widget.requestType,);
                    //       }
                    //     }
                    //   });
                    //
                    // });
                  } else {
                    if (widget.isAlreadyFormData) {
                      _bloc.postData(
                        widget.url,
                        fd: widget.onPress!(),
                        requestType: widget.requestType,
                      );
                    } else {
                      if (!widget.changeFormData) {
                        _bloc.postData(
                          widget.url,
                          map: widget.onPress!(),
                          requestType: widget.requestType,
                        );
                      } else {
                        FormData fd = FormData.fromMap(widget.onPress!());
                        _bloc.postData(
                          widget.url,
                          fd: fd,
                          requestType: widget.requestType,
                        );
                      }
                    }
                  }
                }
              } else {
                await widget.onAsyncPress!()!.then((a) {
                  if (a != null) {
                    checkDialog();
                    if (widget.requestType == ReqType.Get) {
                      _bloc.postData(
                        widget.url,
                        map: a,
                        requestType: widget.requestType,
                      );
                    } else {
                      FormData fd = FormData.fromMap(a);
                      _bloc.postData(
                        widget.url,
                        fd: fd,
                        requestType: widget.requestType,
                      );
                    }
                  }
                });
              }
            },
      child: widget.icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon!,
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    widget.text!,
                    style:
                        widget.textStyle ??
                        Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                widget.text!,
                style:
                    widget.textStyle ?? Theme.of(context).textTheme.labelMedium,
              ),
            ),
    );
  }

  Widget mainWidget() {
    return Consumer<ThemeProvider>(
      builder: (context, ThemeProvider provider, child) {
        return TextButton.icon(
          style: TextButton.styleFrom(
            shape: widget.isCupertino
                ? RoundedRectangleBorder()
                : RoundedRectangleBorder(
                    borderRadius: widget.bRadius == null
                        ? BorderRadius.circular(widget.borderRadius)
                        : widget.bRadius!,
                    side: BorderSide(
                      color: widget.borderColor,
                      width: widget.borderWidth,
                    ),
                  ),
            padding: widget.padding,
            backgroundColor: widget.color ?? Theme.of(context).primaryColor,
            foregroundColor: provider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            // disabledColor: Colors.grey,
          ),
          onPressed: widget.isDisable
              ? null
              : () async {
                  if (widget.onPress != null) {
                    // if (widget.onPress!() != null) {

                    checkDialog();
                    if (widget.isAlreadyFormData) {
                      _bloc.postData(
                        widget.url,
                        fd: widget.onPress!(),
                        requestType: widget.requestType,
                        tempId: widget.tempId,
                      );
                    } else {
                      if (!widget.changeFormData) {
                        _bloc.postData(
                          widget.url,
                          map: await widget.onPress!(),
                          requestType: widget.requestType,
                          tempId: widget.tempId,
                        );
                      } else {
                        FormData fd = FormData.fromMap(widget.onPress!());
                        _bloc.postData(
                          widget.url,
                          fd: fd,
                          requestType: widget.requestType,
                          tempId: widget.tempId,
                        );
                      }
                    }
                    // }
                  } else {
                    await widget.onAsyncPress!()!.then((a) {
                      if (a != null) {
                        checkDialog();
                        if (widget.requestType == ReqType.Get) {
                          _bloc.postData(
                            widget.url,
                            map: a,
                            requestType: widget.requestType,
                            tempId: widget.tempId,
                          );
                        } else {
                          FormData fd = FormData.fromMap(a);
                          _bloc.postData(
                            widget.url,
                            fd: fd,
                            requestType: widget.requestType,
                            tempId: widget.tempId,
                          );
                        }
                      }
                    });
                  }
                },
          label: Text(
            widget.text!,
            style: widget.textStyle,
            textAlign: TextAlign.center,
          ),
          icon: widget.icon == null ? null : widget.icon,
        );
      },
    );
  }

  checkDialog() async {
    if (widget.isShowDialog) {
      isShowingDialog = true;
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Stack(
            // overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: LoadingWidget(),
              ),
            ],
          );
        },
      ).then((v) {
        isShowingDialog = false;
      });
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
