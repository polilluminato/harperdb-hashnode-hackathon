import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:harperdb_hashnode_hackathon/models/failure_model.dart';
import 'package:http/http.dart' as http;
import 'package:harperdb_hashnode_hackathon/models/post_model.dart';
import 'package:intl/intl.dart';

class ScheduleRepository {
  static String _baseUrl = '${dotenv.env['HARPER_DB_URL']}';
  final http.Client _client;

  ScheduleRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Post>> getPosts() async {
    try {
      final response = await _client.post(
        Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic ${dotenv.env['HARPER_DB_SECRET_KEY']}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json
            .encode({"operation": "sql", "sql": "SELECT * FROM schedule.post"}),
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => Post.fromJson(e))
            .toList()
              ..sort((a, b) => a.postDate.compareTo(b.postDate));
      } else {
        throw const Failure(message: 'Something went wrong! - 1');
      }
    } catch (_) {
      throw const Failure(message: 'Something went wrong! - 2');
    }
  }

  Future<bool> insertPost(Post postToInsert) async {
    try {
      final response = await _client.post(
        Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic ${dotenv.env['HARPER_DB_SECRET_KEY']}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json.encode({
          "operation": "sql",
          "sql": "INSERT INTO schedule.post (link,platform,post_date,text,title) " +
              " VALUE ('${postToInsert.link}','${postToInsert.platform}'" +
              ",'${DateFormat('yyyy-MM-dd HH:mm:ss').format(postToInsert.postDate)}'" +
              ",'${postToInsert.text}','${postToInsert.title}')"
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> updatePost(Post postToUpdate) async {
    try {
      final response = await _client.post(
        Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic ${dotenv.env['HARPER_DB_SECRET_KEY']}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json.encode({
          "operation": "sql",
          "sql": "UPDATE schedule.post " +
              " SET link = '${postToUpdate.link}', platform = '${postToUpdate.platform}'" +
              ", post_date = '${DateFormat('yyyy-MM-dd HH:mm:ss').format(postToUpdate.postDate)}'" +
              ", text = '${postToUpdate.text}', title = '${postToUpdate.title}'" +
              " WHERE id = '${postToUpdate.id}'"
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }
}
