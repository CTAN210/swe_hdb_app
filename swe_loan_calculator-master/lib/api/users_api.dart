import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/model/user.dart';
import 'package:http/http.dart' as http;
class UsersApi {
  static Future<List<User>> getUsers() async {
    final url =
        'https://firebasestorage.googleapis.com/v0/b/login-27dc9.appspot.com/o/users%20network.json?alt=media&token=7c018acc-469c-44c4-ab0a-a2195f00d4d0';
    final response = await http.get(url);
    final body = json.decode(response.body);

    return body.map<User>(User.fromJson).toList();
  }

  static Future<List<User>> getUsersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/users.json');
    final body = json.decode(data);

    return body.map<User>(User.fromJson).toList();
  }
}