import 'package:vp12_api_app/models/user.dart';

class BaseApiResponse {
  late bool status;
  late String message;
  late List<User> data;

  BaseApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      // json['data'] == JSONArray == List<Map>
      json['data'].forEach((jsonObjectMap) {
        data.add(User.fromJson(jsonObjectMap));
      });
    }
  }
}
