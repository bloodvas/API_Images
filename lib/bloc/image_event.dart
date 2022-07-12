abstract class ImageEvent {}

class ImageLoadEvent extends ImageEvent {
  int page;

  ImageLoadEvent({this.page = 1});
}

class ImageClearEvent extends ImageEvent {}
