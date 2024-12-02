import 'dart:convert';

import '../models/articles.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  List<Articles> news = [];


  Future<void> getNews() async{
    String apiUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7b18baf4d7174a108438c839b3ef336a";

    var response = await http.get(apiUrl as Uri);

    //jsonData
    var responseJson = jsonDecode(response.body);

    if(responseJson['status'] == "ok"){
      responseJson["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){

          Articles articles = Articles(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              articleUrl: element['url'],
              urlToImg: element['urlToImage'],
              content: element['content'],
              dateTime: element['publishedAt'],
          );
        }

      });
    }
}

}