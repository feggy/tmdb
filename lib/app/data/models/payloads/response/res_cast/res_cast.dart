import 'package:freezed_annotation/freezed_annotation.dart';

import 'cast.dart';
import 'crew.dart';

part 'res_cast.freezed.dart';
part 'res_cast.g.dart';

@freezed
class ResCast with _$ResCast {
  factory ResCast({
    List<Cast>? cast,
    List<Crew>? crew,
    int? id,
  }) = _ResCast;

  factory ResCast.fromJson(Map<String, dynamic> json) =>
      _$ResCastFromJson(json);
}
