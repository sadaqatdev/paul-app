import 'dart:convert';

class CustomerModel {
  String email;
  String firstName;
  String lastName;
  String password;
  CustomerModel({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  CustomerModel copyWith({
    String email,
    String firstName,
    String lastName,
    String password,
  }) {
    return CustomerModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CustomerModel(
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(email: $email, firstName: $firstName, lastName: $lastName, password: $password)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CustomerModel &&
        o.email == email &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        password.hashCode;
  }
}
