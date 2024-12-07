import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  List<dynamic> searchResults = [];

  // Function to fetch search results from the API
  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Replace this with your actual API key and URL
    final apiKey = 'YOUR_API_KEY';
    final apiUrl =
        'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        setState(() {
          searchResults = responseJson['articles'];
        });
      } else {
        // Handle error if response is not successful
        setState(() {
          searchResults = [];
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        searchResults = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Search News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for news...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchNews(_searchController.text);
                  },
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  searchNews(query);
                }
              },
            ),
            SizedBox(height: 10),

            // Loading Indicator
            if (isLoading)
              Center(child: CircularProgressIndicator()),

            // Results
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var article = searchResults[index];
                  return ListTile(
                    title: Text(article['title'] ?? 'No Title'),
                    subtitle: Text(article['description'] ?? 'No Description'),
                    leading: article['urlToImage'] != null
                        ? Image.network(article['urlToImage'])
                        : null,
                    onTap: () {
                      // Handle tap event, e.g., navigate to article details screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
