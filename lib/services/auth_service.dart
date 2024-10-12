import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/login_response.dart';

import 'package:realtime_chat/models/user.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authenticate = false;

  final _storage = const FlutterSecureStorage();

  bool get authenticating => _authenticate;
  set authenticating(bool value) {
    _authenticate = value;
    notifyListeners();
  }

  // Getters static token
  static Future<String> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  // Login
  // -----
  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      // Save token
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  // Registration
  // -----
  Future register(String name, String email, String password) async {
    authenticating = true;
    final data = {'name': name, 'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    authenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      // Save token
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      Map mapBody = respBody;

      // If not a valid email
      if (mapBody.containsKey('errors')) {
        return mapBody['errors']['email']['msg'];
      } else {
        return respBody['msg'];
      }
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token') ?? '';
    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token});
    print(token);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
