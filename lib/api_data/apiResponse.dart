import 'dart:convert';
import '../api_key.dart';
import '../models/articles.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  List<Articles> news = [];


  Future<void> getNews() async{
    final apiKey = ApiKey.apiKey;
    String apiUrl = 'https://newsapi.org/v2/everything?q=general&sortBy=popularity&apiKey=$apiKey';

    try{
      var response = await http.get(Uri.parse(apiUrl));
      //jsonData
      var responseJson = jsonDecode(response.body);

      if(responseJson['status'] == "ok") {
        responseJson["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            Articles articles = Articles(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              articleUrl: element['url'],
              urlToImg: element['urlToImage'],
              content: element['content'],

            );
            news.add(articles);
          }
        }
        );
      }
    }catch(e){
      print("Error fetching news data");
    }
  }
}
class SortByCategory {
  List<Articles> categoryNews = [];
  final apiKey = ApiKey.apiKey;

  Future<void> getCategoryNews(String category) async {
    String apiUrl = 'https://newsapi.org/v2/top-headlines?category=${category.toLowerCase()}&apiKey=$apiKey';

    try{
        var response = await http.get(Uri.parse(apiUrl));
        //jsonData
        var responseJson = jsonDecode(response.body);

        if (responseJson['status'] == "ok") {
          responseJson["articles"].forEach((element) {
            if (element["urlToImage"] != null && element["description"] != null) {
              Articles articles = Articles(
                title: element['title'],
                author: element['author'],
                description: element['description'],
                articleUrl: element['url'],
                urlToImg: element['urlToImage'],
                content: element['content'],
                //dateTime: element['publishedAt'],
              );
              categoryNews.add(articles);
            }
          });
        }
    }catch(e){
      print("Error fetching category news");
    }
  }
}