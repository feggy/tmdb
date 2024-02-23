import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tmdb/app/data/models/entities/failure.dart';

Future<Either<Failure, T>> safeRemoteCall<T>({
  required Future<T> Function() remoteCall,
}) async {
  try {
    final result = await remoteCall();
    return right(result);
  } catch (e, stackTrace) {
    log(e.toString(), stackTrace: stackTrace);
    return left(parseException(e));
  }
}

Failure parseException(Object e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.badResponse) {
      final response = e.response;
      if (response != null) {
        final statusCode = response.statusCode;
        var message = response.statusMessage;

        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          if (data.containsKey('message')) {
            message = response.data?['message'];
          }
        }

        return Failure(status: statusCode, message: message);
      }
    }
  }

  return Failure(message: 'Ups... Terjadi suatu kesalahan');
}
