import 'dart:convert';

import 'package:vp12_api_app/api/api_settings.dart';
import 'package:http/http.dart' as http;
import 'package:vp12_api_app/models/base_api_response.dart';
import 'package:vp12_api_app/models/user.dart';

class UserApiController {
  Future<List<User>> readUsers() async {
    var url = Uri.parse(ApiSettings.readUsers);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // BaseApiResponse baseApiResponse = BaseApiResponse.fromJson(jsonResponse);
      // return baseApiResponse.data;

      print('Message: ${jsonResponse['message']}');
      var dataJsonArray = jsonResponse['data'] as List;
      List<User> users = dataJsonArray
          .map((userJsonObjectMap) => User.fromJson(userJsonObjectMap))
          .toList();
      return users;
    }
    return [];
  }
}
