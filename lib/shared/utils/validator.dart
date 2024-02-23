import 'package:string_validator/string_validator.dart';
import 'package:tmdb/shared/utils/extensions.dart';

class Validator {
  static String? validateEmpty(String value) {
    if (value.isEmpty) {
      return 'Kolom harus diisi';
    }
    return null;
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Kolom harus diisi';
    } else if (!isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  static String? validatePasswordLogin(String value) {
    if (value.isEmpty) {
      return 'Kolom harus diisi';
    } else if (!Ext.validatePasswordLogin(value)) {
      return 'Kata sandi harus terdiri dari huruf kecil (a-z), huruf besar (A-Z), dan angka (0-9)';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Kolom harus diisi';
    } else if (!Ext.validatePassword(value)) {
      return 'Kata sandi harus terdiri dari minimal 8 karakter, huruf kecil (a-z), huruf besar (A-Z), angka (0-9), dan karakter khusus (!@#\$%)';
    }
    return null;
  }

  static String? validateRePassword(
    String value,
    String password,
  ) {
    if (value.isEmpty) {
      return 'Kolom harus diisi';
    } else if (value != password) {
      return 'Konfirmasi password harus sama dengan kata sandi';
    }
    return null;
  }
}
