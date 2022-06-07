import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp12_api_app/api/api_settings.dart';
import 'package:vp12_api_app/get/images_getx_controller.dart';
import 'package:vp12_api_app/models/api_response.dart';
import 'package:vp12_api_app/utils/helpers.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helpers {
  ImagesGetxController _controller = Get.put(ImagesGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //BlocProvider.of<ImagesBloc>(context).add(Event());
    //Provider.of<ImagesProvider>(context,listen: false).readImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'IMAGES',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/upload_image_screen'),
            icon: Icon(Icons.camera_alt),
          )
        ],
      ),
      body: GetX<ImagesGetxController>(
        // init: ImagesGetxController(),
        // global: true,
        builder: (controller) {
          if (controller.loading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.images.isNotEmpty) {
            return GridView.builder(
              itemCount: controller.images.length,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        cacheKey: controller.images[index].image,
                        width: double.infinity,
                        imageUrl: ApiSettings.imageUrl +
                            controller.images[index].image,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.black45,
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.images[index].image,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                color: Colors.red.shade800,
                                onPressed: () async =>
                                    await _deleteImage(index: index),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('NO DATA'),
            );
          }
        },
      ),
    );
  }

  Future<void> _deleteImage({required int index}) async {
    ApiResponse response =
        await ImagesGetxController.to.deleteImage(index: index);
    showSnackBar(context, message: response.message, error: !response.status);
  }
}
