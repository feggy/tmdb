import 'dart:convert';

class Failure {
  Failure({
    this.status,
    this.message,
  });

  final int? status;
  final String? message;

  Failure copyWith({
    int? status,
    String? message,
  }) {
    return Failure(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      status: map['status']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source));

  @override
  String toString() => 'Failure(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
