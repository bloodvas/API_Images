import 'package:flutter_application_3/data/api/service/image_api_provider.dart';

class ImageRepository {
  final ImageProvider _imageProvider = ImageProvider();
  dynamic getAllImages(int page) => _imageProvider.getImages(page: page);
}
