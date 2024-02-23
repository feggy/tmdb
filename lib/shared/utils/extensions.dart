import 'dart:convert';

import 'package:dio/dio.dart';

abstract class Ext {
  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[~!@#$%^&*()_+`{}|<>?;:./,=\-\[\]])(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validatePasswordLogin(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String toPrettyJSONString(jsonObject) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      if (jsonObject is FormData) {
        final encoder = jsonObject.files.map((e) => e.value.filename).toList();
        return encoder.join('\n');
      }

      return jsonObject.toString();
    }
  }
}
