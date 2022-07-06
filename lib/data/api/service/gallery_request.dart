import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/model/data.dart';

class DioClient {
  final Dio dio = Dio();
  final perPage = 10;
  final String baseUrl = 'http://gallery.prod1.webant.ru/api/photos';

  Future<List<Data>> getImage(int page, bool popular, bool newImages) async {
    List<Data> imageList = [];
    try {
      Response imageData = await dio.get(baseUrl, queryParameters: {
        // 'query': 'home',
        'page': page,
        'limit': perPage,
        // 'client_id': 'eJu6nte0KBlnwd6L1jZHdOY1TXM2b30SobP9fnuym04',
        // 'order_by': order
        'popular': popular,
        'new': newImages,
      });
      for (var element in imageData.data["data"]) {
        imageList.add(Data.fromJson(element));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    debugPrint(
        'Lenght: ' + imageList.length.toString() + ' + ' + imageList[0].url);
    return imageList;
  }
}
