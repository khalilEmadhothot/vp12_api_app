import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vp12_api_app/api/api_helper.dart';
import 'package:vp12_api_app/api/api_settings.dart';
import 'package:vp12_api_app/models/api_response.dart';
import 'package:vp12_api_app/models/student_image.dart';
import 'package:vp12_api_app/storage/shared_pref_controller.dart';

class ImagesApiController with ApiHelper {
  //Upload, Read, Delete

  Future<http.StreamedResponse> uploadImage({required File file}) async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('/{id}', ''));
    var request = http.MultipartRequest('POST', url);

    //TODO: File
    var imageFile = await http.MultipartFile.fromPath('image', file.path);
    request.files.add(imageFile);

    //TODO: TEXT
    // request.fields['name'] = 'ABC';
    // request.fields['_method'] = 'PUT';

    //TODO: HEADERS
    request.headers[HttpHeaders.acceptHeader] = 'application/json';
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().token;

    return await request.send();
  }

  Future<ApiResponse<StudentImage>> indexImages() async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('/{id}', ''));
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 401) {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var jsonArray = jsonResponse['data'] as List;
        List<StudentImage> images = jsonArray
            .map((jsonObject) => StudentImage.fromJson(jsonObject))
            .toList();
        return ApiResponse<StudentImage>.listResponse(
            message: jsonResponse['message'],
            status: jsonResponse['status'],
            data: images);
      }
      return ApiResponse(message: 'You must login again!', status: false);
    }
    return getGenericErrorResponse<StudentImage>();
  }

  Future<ApiResponse> deleteImage({required int id}) async {
    var url = Uri.parse(ApiSettings.images.replaceFirst('{id}', id.toString()));
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], status: jsonResponse['status']);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      String message = response.statusCode == 404
          ? 'Selected image is not found'
          : 'Unauthorized access, login again';
      return ApiResponse(message: message, status: false);
    }
    return errorServerResponse;
  }
}
