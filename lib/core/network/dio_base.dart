//
//
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import '../constants/app_constants.dart';
// import '../database/share_pref.dart';
// import '../ob/response_ob.dart';
//
// class DioBaseNetwork {
//   // Singleton pattern to ensure only one instance of DioBaseNetwork
//   static final DioBaseNetwork _instance = DioBaseNetwork._internal();
//   factory DioBaseNetwork() => _instance;
//   DioBaseNetwork._internal();
//
//   // Dio instance
//   late Dio _dio;
//
//   // Initialize Dio with base options
//   Future<void> _initDio() async {
//     _dio = Dio(BaseOptions(
//       headers: await _getDefaultHeaders(), // Await the headers
//     ));
//
//     // Add PrettyDioLogger for request/response logging
//     _dio.interceptors.add(PrettyDioLogger(
//       requestHeader: true,
//       requestBody: true,
//       responseBody: true,
//       responseHeader: false,
//       error: true,
//       compact: true,
//       maxWidth: 90,
//     ));
//   }
//
//   // Get default headers
//   Future<Map<String, String>> _getDefaultHeaders() async {
//     String os = Platform.isIOS ? "ios" : "android";
//     String language = await SharedPref.getData(key: SharedPref.language) ?? 'en';
//
//     return {
//       "Authorization": await SharedPref.getData(key: SharedPref.token) ?? '',
//       "Accept": "application/json",
//       "language": language,
//       "version-ios": NOW_VERSION_IOS,
//       "version-android": NOW_VERSION_ANDROID,
//       "operating-system": os,
//       "gen-ios": GEN_NUMBER_IOS,
//       "gen-android": GEN_NUMBER_ANDROID,
//       "User-Agent": await SharedPref.getData(key: SharedPref.user_agent) ?? '',
//     };
//   }
//
//   // Generic method to handle all types of requests
//   Future<void> _dioRequest({
//     required ReqType requestType,
//     required String url,
//     Map<String, dynamic>? params,
//     FormData? formData,
//     required callBackFunction callBack,
//     ProgressCallbackFunction? progressCallback,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       Response response;
//
//       switch (requestType) {
//         case ReqType.Get:
//           response = await _dio.get(url, queryParameters: params);
//           break;
//         case ReqType.Post:
//           response = await _dio.post(url, data: formData ?? params);
//           break;
//         case ReqType.Put:
//           response = await _dio.put(url, data: params);
//           break;
//         case ReqType.Patch:
//           response = await _dio.patch(url, data: params);
//           break;
//         case ReqType.Delete:
//           response = await _dio.delete(url, queryParameters: params);
//           break;
//         default:
//           throw Exception("Invalid request type");
//       }
//
//       // Handle successful response
//       callBack(ResponseOb(
//         message: MsgState.data,
//         data: response.data,
//       ));
//     } on DioException catch (e) {
//       // Handle Dio errors
//       callBack(ResponseOb(
//         message: MsgState.error,
//         data: e.response?.data ?? "Unknown error",
//         errState: _handleError(e.response?.statusCode),
//       ));
//     } catch (e) {
//       // Handle other exceptions
//       callBack(ResponseOb(
//         message: MsgState.error,
//         data: e.toString(),
//         errState: ErrState.unknown_err,
//       ));
//     }
//   }
//
//   // Handle specific error states based on status code
//   ErrState _handleError(int? statusCode) {
//     switch (statusCode) {
//       case 400:
//         return ErrState.validate_err;
//       case 401:
//         return ErrState.no_login;
//       case 404:
//         return ErrState.not_found;
//       case 429:
//         return ErrState.too_many_request;
//       case 500:
//         return ErrState.server_error;
//       case 503:
//         return ErrState.server_maintain;
//       default:
//         return ErrState.unknown_err;
//     }
//   }
//
//   // Public methods for different request types
//
//   Future<void> getReq(String url, {Map<String, dynamic>? params, required callBackFunction callBack}) async {
//     await _initDio(); // Initialize Dio before making the request
//     _dioRequest(
//       requestType: ReqType.Get,
//       url: url,
//       params: params,
//       callBack: callBack,
//     );
//   }
//
//   Future<void> postReq(String url, {Map<String, dynamic>? params, FormData? formData, required callBackFunction callBack}) async {
//     await _initDio(); // Initialize Dio before making the request
//     _dioRequest(
//       requestType: ReqType.Post,
//       url: url,
//       params: params,
//       formData: formData,
//       callBack: callBack,
//     );
//   }
//
//   Future<void> putReq(String url, {Map<String, dynamic>? params, required callBackFunction callBack}) async {
//     await _initDio(); // Initialize Dio before making the request
//     _dioRequest(
//       requestType: ReqType.Put,
//       url: url,
//       params: params,
//       callBack: callBack,
//     );
//   }
//
//   Future<void> patchReq(String url, {Map<String, dynamic>? params, required callBackFunction callBack}) async {
//     await _initDio(); // Initialize Dio before making the request
//     _dioRequest(
//       requestType: ReqType.Patch,
//       url: url,
//       params: params,
//       callBack: callBack,
//     );
//   }
//
//   Future<void> deleteReq(String url, {Map<String, dynamic>? params, required callBackFunction callBack}) async {
//     await _initDio(); // Initialize Dio before making the request
//     _dioRequest(
//       requestType: ReqType.Delete,
//       url: url,
//       params: params,
//       callBack: callBack,
//     );
//   }
//
//   Future<void> uploadFile(
//       String url, {
//         required FormData formData,
//         required callBackFunction callBack,
//         ProgressCallbackFunction? progressCallback,
//         CancelToken? cancelToken,
//       }) async {
//     await _initDio(); // Initialize Dio before making the request
//     _dioRequest(
//       requestType: ReqType.Post,
//       url: url,
//       formData: formData,
//       callBack: callBack,
//       progressCallback: progressCallback,
//       cancelToken: cancelToken,
//     );
//   }
// }
//
// enum ReqType { Get, Post, Put, Patch, Delete }
//
// typedef callBackFunction(ResponseOb ob);
// typedef ProgressCallbackFunction(double progress);
