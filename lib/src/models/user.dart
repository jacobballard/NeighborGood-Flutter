class User {
  final String username;
  final String id;
  final String realName;
  final double latitude;
  final double longitude;
  final bool isBaker;

  User(
      {required this.id,
      required this.username,
      required this.realName,
      required this.latitude,
      required this.longitude,
      required this.isBaker});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': username,
      'real_name': realName,
      'latitude': latitude,
      'longitude': longitude,
      'is_baker': isBaker
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        isBaker: map['is_baker'],
        realName: map['real_name'],
        username: map['username']);
  }
}
