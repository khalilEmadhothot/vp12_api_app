import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vp12_api_app/api/api_helper.dart';
import 'package:vp12_api_app/api/api_settings.dart';
import 'package:vp12_api_app/models/api_response.dart';
import 'package:vp12_api_app/models/base_api_response.dart';
import 'package:vp12_api_app/models/student.dart';
import 'package:vp12_api_app/storage/shared_pref_controller.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonObject = jsonResponse['object'];
        Student student = Student.fromJson(jsonObject);
        SharedPrefController().save(student: student);
      }
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    } else {
      return errorServerResponse;
    }
  }

  Future<ApiResponse> logout() async {
    var url = Uri.parse(ApiSettings.logout);
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      unawaited(SharedPrefController().clear());
      if (response.statusCode == 200) {
        return ApiResponse(
            message: jsonResponse['message'], status: jsonResponse['status']);
      } else {
        return ApiResponse(message: 'Logged out successfully', status: true);
      }
    }
    return errorServerResponse;
  }

  Future<ApiResponse> register({required Student student}) async {
    var url = Uri.parse(ApiSettings.register);
    var response = await http.post(url, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender,
    });

    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServerResponse;
  }

  Future<ApiResponse> forgetPassword({required String email}) async {
    var url = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(url, body: {
      'email': email,
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) print(jsonResponse['code']);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServerResponse;
  }

  Future<ApiResponse> resetPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    var url = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(url, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    }
    return errorServerResponse;
  }
}
