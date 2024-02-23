import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tmdb/app/core/config/build_config.dart';
import 'package:tmdb/app/data/datasources/remote/services/api_service.dart';
import 'package:tmdb/shared/utils/extensions.dart';

class DioModule with DioMixin implements Dio {
  DioModule() {
    final newOptions = BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
      baseUrl: BuildConfig.BASE_URL,
    );

    options = newOptions;
    interceptors.addAll([AppInterceptor()]);

    httpClientAdapter = HttpClientAdapter();
  }

  ApiService get apiService => ApiService(this);
}

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const token =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDM5YmRhMTcwZTQ3Y2JkMzU5MGFmNDMzNzZmZWZkMiIsInN1YiI6IjVkNGNlOTljMTA2NWQzMDAxMTRjZTk5NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eOHDw8cS7zNQaU-VqEk2-MtcFSx9K71wAuROFYzV_rY';
    var authorization = 'Bearer $token';

    options.headers.addAll({"Authorization": authorization});

    final url = '${options.baseUrl}${options.path}';
    final path = 'REQUEST[${options.method}] => PATH: $url';
    String body = '';
    List<String> parameters = [];
    List<String> headers = [];

    options.headers.forEach((key, value) {
      if (value != null) headers.add('$key: $value');
    });
    if (options.queryParameters.isNotEmpty) {
      options.queryParameters.forEach((k, v) => parameters.add('$k: $v'));
    }
    if (options.data != null) {
      body = Ext.toPrettyJSONString(options.data);
    }

    final returnLog = '$path'
        '\nHEADERS:\n${headers.join('\n')}'
        '${parameters.isNotEmpty ? '\nPARAMETERS:\n${parameters.join('\n')}' : ''}'
        '${body.isNotEmpty ? '\nDATA BODY:\n$body' : ''}';

    log(returnLog);

    log('-------------------');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final url =
        '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    final path =
        'RESPONSE[${response.statusCode}-${response.requestOptions.method}] => PATH: $url';
    List<String> parameters = [];
    final data = Ext.toPrettyJSONString(response.data);

    final queryParameters = response.requestOptions.queryParameters;
    if (queryParameters.isNotEmpty) {
      queryParameters.forEach((k, v) => parameters.add('$k: $v'));
    }

    final returnLog = '$path'
        '${parameters.isNotEmpty ? '\nPARAMETERS:\n${parameters.join('\n')}' : ''}'
        '\nRESPONSE DATA:\n$data';

    log(returnLog);

    log('-------------------');

    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final url = '${err.requestOptions.baseUrl}${err.requestOptions.path}';
    final path =
        'ERROR[${err.response?.statusCode}-${err.response?.statusMessage}] => PATH: $url';
    List<String> parameters = [];
    final data = Ext.toPrettyJSONString(err.response?.data);

    final queryParameters = err.requestOptions.queryParameters;
    if (queryParameters.isNotEmpty) {
      queryParameters.forEach((k, v) => parameters.add('$k: $v'));
    }

    final returnLog = '$path'
        '${parameters.isNotEmpty ? '\nPARAMETERS:\n${parameters.join('\n')}' : ''}'
        '\nERROR DATA:\n$data';

    log(returnLog);

    log('-------------------');

    super.onError(err, handler);
  }
}
