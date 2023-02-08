import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDwu14OWv1RcDNYDKk8rvCiENjGu_pJWbU';

  final storage = FlutterSecureStorage();

  //Si retornamos algo, está mal
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // debugPrint(decodedResp.toString());

    if(decodedResp.containsKey('idToken')) {
      //Guardar token
      // return decodedResp['idToken'];
      storage.write(key: 'idToken', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  //Si retornamos algo, está mal
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // debugPrint(decodedResp.toString());

    if(decodedResp.containsKey('idToken')) {
      //Guardar token
      // return decodedResp['idToken'];
      storage.write(key: 'idToken', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'idToken');
  }

  Future<String> isAuthenticated() async {
    return await storage.read(key: 'idToken') ?? '';
  }

}