import 'dart:convert';

class FullName{
  String? id;
  String firstname;
  String lastname;
  String email;

  FullName({this.id, required this.firstname, required this.lastname, required this.email});

  factory FullName.fromJson(Map<String, dynamic> json) {
    return FullName(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email']
    );
  }

  static List<FullName> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<FullName>((dynamic d) => FullName.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(FullName fullname) {
    return {
      'id': fullname.id,
      'firstname': fullname.firstname,
      'lastname': fullname.lastname,
      'email': fullname.email
    };
  }
}