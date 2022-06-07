import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vp12_api_app/api/controllers/images_api_controller.dart';
import 'package:vp12_api_app/models/api_response.dart';
import 'package:vp12_api_app/models/student_image.dart';

typedef UploadImageCallback = void Function(ApiResponse apiResponse);

class ImagesGetxController extends GetxController {
  static ImagesGetxController get to => Get.find();
  final ImagesApiController _apiController = ImagesApiController();

  RxBool loading = false.obs;
  RxList<StudentImage> images = <StudentImage>[].obs;

  @override
  void onInit() {
    readImages();
    super.onInit();
  }

  void readImages() async {
    loading.value = true;
    ApiResponse<StudentImage> apiResponse = await _apiController.indexImages();
    loading.value = false;
    if(apiResponse.status) images.value = apiResponse.data ?? [];
  }

  Future<void> uploadImage(
      {required File file,
      required UploadImageCallback uploadImageCallback}) async {
    StreamedResponse streamedResponse =
        await _apiController.uploadImage(file: file);
    streamedResponse.stream.transform(utf8.decoder).listen((String body) {
      if (streamedResponse.statusCode == 201) {
        var jsonResponse = jsonDecode(body);
        StudentImage studentImage =
            StudentImage.fromJson(jsonResponse['object']);
        images.add(studentImage);
        uploadImageCallback(
          ApiResponse(
            message: jsonResponse['message'],
            status: jsonResponse['status'],
          ),
        );
      }else {
        print(body);
        print(streamedResponse.statusCode);
        uploadImageCallback(ApiResponse(message: 'Error',status: false));
      }
    });
  }

  Future<ApiResponse> deleteImage({required int index}) async {
    ApiResponse apiResponse = await _apiController.deleteImage(id: images[index].id);
    if(apiResponse.status) {
      images.removeAt(index);
    }
    return apiResponse;
  }
}
