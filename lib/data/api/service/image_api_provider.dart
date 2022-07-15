import 'package:dio/dio.dart';
import 'package:flutter_application_3/domain/model/data.dart';

class ImageProvider {
  final Dio dio = Dio();
  final String baseUrl = 'http://gallery.prod1.webant.ru/api/photos';

  dynamic getImages({required page, required categoria}) async {
    Response response = await dio.get(baseUrl, queryParameters: {
      'page': page,
      'limit': 10,
      'popular': categoria == 'popular' ? true : false,
      'new': categoria == 'new' ? true : false,
    });
    if (response.statusCode == 200) {
      List<ImageData> imageList = [];
      for (var e in response.data['data']) {
        imageList.add(ImageData.fromJson(e));
      }
      return imageList;
    } else {
      throw Exception('Error fetching');
    }
  }
}
