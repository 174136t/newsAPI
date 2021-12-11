import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_rest/constants/strings.dart';
import 'package:news_rest/models/news_info.dart';

class APIManager {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;
    try {
      var response = await client.get(Uri.parse(Strings.news_url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);
        print(newsModel.articles[0].title);
      }
    } catch (e) {
      print("error $e");
      return newsModel;
    }
    return newsModel;
  }
}
