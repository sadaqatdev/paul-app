import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:paul_app/controllers/staticcart.dart';

import 'package:paul_app/models/categories.dart' as cat;
import 'package:paul_app/models/customer.dart';
import 'package:paul_app/models/login_model.dart';
import 'package:paul_app/models/new_order_model.dart';
import 'package:paul_app/models/product.dart';
import 'package:paul_app/utils/config.dart';

import 'payment-service.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final storage = GetStorage();

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

  // Future<bool> createOrder(NewOrder order) async {
  //   bool isOrderCreated = false;

  //   var authToken = base64.encode(
  //     utf8.encode(Config.CK + ":" + Config.CS),
  //   );
  //   try {
  //     var responce = await Dio().post(
  //       'https://www.threadandthread.com/wp-json/wc/v3/orders',
  //       data: order.toJson(),
  //       options: Options(
  //         headers: {
  //           HttpHeaders.authorizationHeader: 'Basic $authToken',
  //           HttpHeaders.contentTypeHeader: "application/json",
  //         },
  //       ),
  //     );
  //     if (responce.statusCode == 201) {
  //       isOrderCreated = true;
  //     }
  //   } on DioError catch (e) {
  //     print('-------------------------------------------eeeee-');
  //     print(e.response.statusMessage);
  //     if (e.response.statusCode == 404) {
  //       print(e.response.statusCode);
  //     } else {
  //       print(e.toString());
  //     }
  //   }
  //   return isOrderCreated;
  // }

  payViaNewCard(BuildContext context) async {
    // ProgressDialog dialog = new ProgressDialog(context);
    // dialog.style(message: 'Please wait...');
    // await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    //await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  Future<bool> orderC(NewOrder order) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic Y2tfNThhZWFiMGUyMzJkMmYzYjQ4NWRhNTQxY2Q3ZjEzMTdjNDE5MDA2Yzpjc181MmU5YjVlMGMwN2I3MmY4YjIyMmY4NGMzNGUzYTIzMjU0M2Y5NTFm'
    };
    var request = http.Request('POST',
        Uri.parse('https://www.threadandthread.com/wp-json/wc/v3/orders'));
    print("oooooooooooooooooo-----------------");
    print(newOrderToJson(order));
    request.body = newOrderToJson(order);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
      storage.write('order', StaticCart.listLineItem);
      return true;
    } else {
      print(response.statusCode);
      print(response.stream.bytesToString());
      print(response.reasonPhrase);
      return false;
    }
  }
}
// ''{  "payment_method": "bacs",  "payment_method_title": "Direct Bank Transfer",  "set_paid": true,  "billing": {    "first_name": "John",    "last_name": "Doe",    "address_1": "969 Market",    "address_2": "",    "city": "San Francisco",    "state": "CA",    "postcode": "94103",    "country": "US",    "email": "john.doe@example.com",    "phone": "(555) 555-5555"  },  "shipping": {    "first_name": "John",    "last_name": "Doe",    "address_1": "969 Market",    "address_2": "",    "city": "San Francisco",    "state": "CA",    "postcode": "94103",    "country": "US"  },  "line_items": [    {      "product_id": 44,      "quantity": 12    }   ],  "shipping_lines": [    {      "method_id": "flat_rate",      "method_title": "Flat Rate",      "total": "10000.00"    }  ]};
//  Map<String, dynamic> body = {
//       "payment_method": "bacs",
//       "payment_method_title": "Direct Bank Transfer",
//       "set_paid": true,
//       "billing": {
//         "first_name": "John",
//         "last_name": "Doe",
//         "address_1": "969 Market",
//         "address_2": "",
//         "city": "San Francisco",
//         "state": "CA",
//         "postcode": "94103",
//         "country": "US",
//         "email": "john.doe@example.com",
//         "phone": "(555) 555-5555"
//       },
//       "shipping": {
//         "first_name": "John",
//         "last_name": "Doe",
//         "address_1": "969 Market",
//         "address_2": "",
//         "city": "San Francisco",
//         "state": "CA",
//         "postcode": "94103",
//         "country": "US"
//       },
//       "line_items": [
//         {"product_id": 44, "quantity": 12},
//       ],
//       "shipping_lines": [
//         {
//           "method_id": "flat_rate",
//           "method_title": "Flat Rate",
//           "total": "10000.00"
//         }
//       ]
//     };
