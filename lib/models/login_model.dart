import 'dart:convert';

class LoginResponceModel {
  bool sucess;
  int statusCode;
  String code;
  String message;
  List data;
  LoginResponceModel({
    this.sucess,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'sucess': sucess,
      'statusCode': statusCode,
      'code': code,
      'message': message,
      //'data': data?.toMap(),
    };
  }

  factory LoginResponceModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var data = map['data'];
    List<dynamic> dataList = new List<dynamic>.from(data);

    return LoginResponceModel(
      sucess: map['sucess'],
      statusCode: map['statusCode'],
      code: map['code'],
      message: map['message'],
      data: dataList != null ? dataList : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponceModel.fromJson(String source) =>
      LoginResponceModel.fromMap(json.decode(source));
}

class Data {
  String token;
  int id;
  String email;
  String niceName;
  String firstName;
  String lastName;
  String displayName;
  Data({
    this.token,
    this.id,
    this.email,
    this.niceName,
    this.firstName,
    this.lastName,
    this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'id': id,
      'email': email,
      'niceName': niceName,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Data(
      token: map['token'],
      id: map['id'],
      email: map['email'],
      niceName: map['niceName'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      displayName: map['displayName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));
}
