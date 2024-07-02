import 'dart:convert';

import 'package:chatapp/Model/emojies.dart';
import 'package:dio/dio.dart';

class Emojies_Method {
  static Future<List<emojies>> getEmojies() async {
    Dio dio = Dio();
    List<emojies> emojiesList = [];

    dio.interceptors.add(LogInterceptor(responseBody: true));
    Response response = await dio.get(
        'https://emoji-api.com/emojis?access_key=86efd485f59a5b757d95816ddcc7f2847c7f009d');
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;

      // Map each JSON object to an Emojies object using fromJson method
      List<emojies> emojiesList =
          jsonList.map((json) => emojies.fromJson(json)).toList();

      return emojiesList;
    } else {
      throw Exception('Failed to load emojis');
    }
  }
}
