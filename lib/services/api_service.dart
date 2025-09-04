import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:random_test/services/url.dart';
import '../models/user_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Url.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );

  Future<UserModel?> fetchUserContact(int page, {int results = 50}) async {
    String url = Url.baseUrl;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await _dio.get(url,
        queryParameters: {
          "results": results,
          "page": page,
        },
      );

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        if (kDebugMode) {
          print('Valeur de catégorie: $userModel');
        }
        return userModel;
      } else {
        try {
          Map<String, dynamic> map = json.decode(response.data);
          if (kDebugMode) {
            print("Erreur: ${map["message"]}");
          }
        } catch (decodeError) {
          if (kDebugMode) {
            print("Erreur de décodage de la réponse: $decodeError");
          }
        }
        return UserModel();
      }
    } catch (e) {
      if (kDebugMode) {
        print("la valeur de $e");
      }
      return UserModel();
    }
  }
}
