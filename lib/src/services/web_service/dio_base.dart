import 'dart:convert';
import 'package:dio/dio.dart';

Future<Dio> setupDio() async {
  final Dio dio = Dio();

  /// Adapt data (according to your own data structure, you can choose to add it)
  // dio.interceptors.add(TokenInterceptor());

  /// Print Log (production mode removal)
  // if (F.  != Flavor.prod) {
  dio.interceptors.add(CurlInterceptor());
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  // }
  return dio;
}

class CurlInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final Map<String, dynamic> qp = options.queryParameters;
      final Map<String, dynamic> h = options.headers;
      final dynamic d = options.data;
      final String curl =
          'curl -X ${options.method} \'${options.baseUrl}${options.path}' +
              (qp.isNotEmpty
                  ? qp.keys.fold(
                      '',
                      (String value, String key) =>
                          '$value${value.isEmpty ? '?' : '&'}$key=${qp[key]}\'')
                  : '\'') +
              h.keys.fold(
                  '',
                  (String value, String key) =>
                      '$value -H \'$key: ${h[key]}\'') +
              (d.length != 0 ? ' --data-binary \'${json.encode(d)}\'' : '') +
              ' --insecure';
      print('server_curl: $curl');
    } catch (e) {
      print('CurlInterceptor error: $e');
    }

    super.onRequest(options, handler);
  }
}
