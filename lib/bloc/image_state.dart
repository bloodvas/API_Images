import 'package:flutter_application_3/domain/model/data.dart';

abstract class ImageState {}

class ImageEmptyState extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImageLoadedState extends ImageState {
  List<ImageData> loadedImage;
  ImageLoadedState({
    required this.loadedImage,
  });
}

class ImageErrorState extends ImageState {}
