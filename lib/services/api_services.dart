import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:paul_app/models/categories.dart' as cat;
import 'package:paul_app/models/customer.dart';
import 'package:paul_app/models/login_model.dart';
import 'package:paul_app/models/product.dart';
import 'package:paul_app/utils/config.dart';

class ApiServices {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(utf8.encode(Config.CK + ":" + Config.CS));

    bool ret = false;
    try {
      var responce = await Dio().post(Config.url + Config.cutomUrl,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: 'application/jason'
          }));
      print('-----respone');
      print(responce.statusCode);
      if (responce.statusCode == 201) {
        ret = true;
      } else {
        ret = false;
      }
    } on DioError catch (e) {
      print('-------------');
      print(e.toString());
    }
    return ret;
  }

  Future<LoginResponceModel> loginCustomer(
      String userName, String password) async {
    LoginResponceModel model;
    try {
      var responce = await Dio().post(
        Config.tokenUrl,
        data: {'username': userName, 'password': password},
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          },
        ),
      );

      print('----------responce-----------');
      print(responce.data);
      if (responce.statusCode == 200) {
        //  model = LoginResponceModel.fromMap(responce.data);
      }
    } on DioError catch (e) {
      print('error in login $e');
    }
    return model;
  }

  Future<List<cat.Category>> getCategories() async {
    List<cat.Category> data = [];

    String url = Config.url +
        Config.categoryUrl +
        "?consumer_key=${Config.CK}&consumer_secret=${Config.CS}";

    try {
      var responce = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
      print('-------------------responce');
      print(responce.data);
      if (responce.statusCode == 200) {
        data = (responce.data as List)
            .map((e) => cat.Category.fromMap(e))
            .toList();
        print('-------------------data-----');
        print(data.toString());
      }
    } on DioError catch (e) {
      print(e);
    }
    return data;
  }

  Future<List<Product>> getProduct(
      {int pageNumber,
      int pageSize,
      String strSearch,
      String tagName,
      categoryId,
      String sortBy,
      String sortOrder = 'asc'}) async {
    List<Product> data = [];

    String parameters = '';

    if (strSearch != null) {
      parameters += "&search=$strSearch";
    }
    if (pageSize != null) {
      parameters += "&per_page=$pageSize";
    }
    if (pageNumber != null) {
      parameters += "&page=$pageNumber";
    }
    if (tagName != null) {
      parameters += "&tag=$tagName";
    }
    if (categoryId != null) {
      parameters += "&category=$categoryId";
    }
    if (sortBy != null) {
      parameters += "&orderby=$sortBy";
    }

    if (sortOrder != null) {
      parameters += "&order=$sortOrder";
    }

    String url = Config.url +
        Config.productUrl +
        "?consumer_key=${Config.CK}&consumer_secret=${Config.CS}&tag=${parameters.toString()}";

    try {
      var responce = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
      print('-------------------responce');
      print(responce.data);
      if (responce.statusCode == 200) {
        data = (responce.data as List).map((e) => Product.fromJson(e)).toList();
        print('-------------------responce-----');
        print(data.length);
      }
    } on DioError catch (e) {
      print(e);
    }
    return data;
  }
}
