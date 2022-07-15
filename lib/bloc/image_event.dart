abstract class ImageEvent {}

class ImageLoadEvent extends ImageEvent {
  int page;
  ImageLoadEvent(this.page);
}

class ImageClearEvent extends ImageEvent {}
