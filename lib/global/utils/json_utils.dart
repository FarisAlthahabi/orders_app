import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orders_app/global/dio/dio_client.dart';

abstract class JsonUtils {
  static String? setFileUrlFromJson(Map<String, dynamic> json) {
    final path = json['photo'] as String?;
    final image = json['image'] as String?;
    if (path != null) {
      return '$baseUrl$path';
    } else if (image != null) {
      return '$baseUrl$image';
    } else {
      return null;
    }
  }

  static Object? readValue(
    Map<dynamic, dynamic> json,
    String key,
  ) {
    return json;
  }

  static Future<MultipartFile?> fileToJson(XFile? image) async {
    return image != null
        ? await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
        : null;
  }
}
