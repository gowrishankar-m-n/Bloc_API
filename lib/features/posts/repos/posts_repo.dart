import 'dart:convert';
import 'dart:developer';

import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),

        headers: {
          "Accept": "application/json",
          "User-Agent":
              "Mozilla/5.0 (Flutter; Dart)", // Pretend to be a browser
        },
      );

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromMap(
          result[i] as Map<String, dynamic>,
        );
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPosts() async {
    var client = http.Client();

    try {
      var response = await client.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {"title": "Mr Cooper", "body": "Youtuber", "userId": "27"},

        headers: {
          "Accept": "application/json",
          "User-Agent":
              "Mozilla/5.0 (Flutter; Dart)", // Pretend to be a browser
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
