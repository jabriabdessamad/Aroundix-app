import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String token;
  final List products;
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.token,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'token': token,
      'products': products,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        fullName: map['fullName'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        token: map['token'] ?? '',
        products: List.from(
          (map['products'] ?? []),
        ));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
