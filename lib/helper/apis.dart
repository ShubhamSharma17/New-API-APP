import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_api/keys/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/models/category_model.dart';
import 'package:news_api/models/headline_model.dart';

class HeadlinesApi {
  static Future<HeadlinesModel> fetchNewsChannelHeadlineApi(
      String channelName) async {
    String key = ApiKey.apiKey;
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$key";
    var response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return HeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }

  static Future<CategoryModel> fetchCategoryApi(String categoryName) async {
    String key = ApiKey.apiKey;
    String url =
        "https://newsapi.org/v2/everything?q=$categoryName&apiKey=$key";
    var response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return CategoryModel.fromJson(body);
    }
    throw Exception('error');
  }
}
