import 'package:json_annotation/json_annotation.dart';

part 'base_pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasePagination<T> {
  BasePagination({
    this.page,
    this.results,
  });

  final int? page;
  final T? results;

  factory BasePagination.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BasePaginationFromJson<T>(json, fromJsonT);
}
