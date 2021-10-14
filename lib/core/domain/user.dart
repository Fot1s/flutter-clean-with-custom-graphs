class User {
  final String id;
  final String displayName;
  final String photoUrl;

  User(this.id, this.displayName, this.photoUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              displayName == other.displayName &&
              photoUrl == other.photoUrl;

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ photoUrl.hashCode;

  @override
  String toString() {
    return 'User{id: $id, displayName: $displayName, photoUrl: $photoUrl}';
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      json['id'] as String,
      json['displayName'] as String,
      json['photoUrl'] as String,
    );
  }

}