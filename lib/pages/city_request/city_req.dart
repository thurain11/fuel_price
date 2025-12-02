// city_req.dart
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:market_price/core/constants/app_constants.dart';
import 'package:market_price/core/network/dio_basenetwork.dart';
import 'package:market_price/core/ob/response_ob.dart';

class CityReq extends DioBaseNetwork {
  // Singleton
  CityReq._();
  static final CityReq _instance = CityReq._();
  factory CityReq() => _instance;

  /// မြို့စာရင်း ယူမယ် - await နဲ့ သုံးလို့ရတယ်
  Future<ResponseOb> getCityList({
    String search = "",
    String type = "15",
  }) async {
    // အရင်ဆုံုး loading state နဲ့ ResponseOb တစ်ခု ဖန်တီးထားမယ်
    final completer = Completer<ResponseOb>();

    // getReq ခေါ်တယ်
    getReq(
      MAIN_URL + "city",
      params: {"type": type, if (search.isNotEmpty) "search": search},
      callBack: (ResponseOb response) {
        // callback ထဲမှာ ရလာတဲ့ response ကို completer နဲ့ ပြန်ပေးလိုက်တယ်
        if (!completer.isCompleted) {
          completer.complete(response);
        }
      },
    );

    // Timeout ထည့်ပေးထားတယ် (15 စက္ကန့်)
    return completer.future.timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        final timeoutResp = ResponseOb(
          message: MsgState.error,
          errState: ErrState.connection_timeout,
          data: "ချိတ်ဆက်မှု ကြာလွန်းနေပါသည်",
        );
        if (!completer.isCompleted) completer.complete(timeoutResp);
        return timeoutResp;
      },
    );
  }

  /// တခြား post request လိုရင်လည်း ဒီလိုပဲ သုံးလို့ရတယ်
  Future<ResponseOb> postCity({Map<String, dynamic>? map, FormData? fd}) async {
    final completer = Completer<ResponseOb>();

    postReq(
      MAIN_URL + "city",
      map: map,
      fd: fd,
      callBack: (response) {
        if (!completer.isCompleted) completer.complete(response);
      },
    );

    return completer.future.timeout(
      const Duration(seconds: 20),
      onTimeout: () {
        final resp = ResponseOb(
          message: MsgState.error,
          errState: ErrState.connection_timeout,
          data: "Request timeout",
        );
        if (!completer.isCompleted) completer.complete(resp);
        return resp;
      },
    );
  }
}
