import 'dart:io';

import 'package:vp12_api_app/models/api_response.dart';
import 'package:vp12_api_app/storage/shared_pref_controller.dart';

mixin ApiHelper {
  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefController().loggedIn) {
      headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    }
    return headers;
  }

  ApiResponse<T> getGenericErrorResponse<T>() {
    return ApiResponse<T>(message: 'Something went wrong', status: false);
  }

  ApiResponse get errorServerResponse {
    return ApiResponse(message: 'Something went wrong', status: false);
  }
}
