import 'package:dio/dio.dart';

class DioProviderBase {
  static const String URL_BASE = "https://superheroapi.com/api/2946051325711000/";

  static final DioProviderBase _dioProviderBase = DioProviderBase._internal();
  DioProviderBase._internal();

  final dio = Dio(
    BaseOptions(
      baseUrl: URL_BASE,
      connectTimeout: Duration(minutes: 3).inMilliseconds,
      receiveTimeout: Duration(minutes: 5).inMilliseconds,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  factory DioProviderBase() {
    return _dioProviderBase;
  }

  Future<Response> get(String path, Map<String, dynamic> params) async {
    return await dio.get(path, queryParameters: params ?? {});
  }

}
