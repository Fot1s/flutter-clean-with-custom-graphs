class DataPoint {
  final String id;
  final int millisSinceEpoch;
  final double value ;

  DataPoint(this.id, this.millisSinceEpoch, this.value) ;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DataPoint &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              millisSinceEpoch == other.millisSinceEpoch &&
              value == other.value;

  @override
  int get hashCode => id.hashCode ^ millisSinceEpoch.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'User{id: $id, millisSinceEpoch: $millisSinceEpoch, value: $value}';
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'millisSinceEpoch': millisSinceEpoch,
      'value': value,
    };
  }

  static DataPoint fromJson(Map<String, dynamic> json) {
    return DataPoint(
      json['id'] as String,
      json['millisSinceEpoch'] as int,
      json['value'] as double,
    );
  }

}