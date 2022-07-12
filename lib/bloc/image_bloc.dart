import 'package:flutter_application_3/bloc/image_event.dart';
import 'package:flutter_application_3/bloc/image_state.dart';
import 'package:flutter_application_3/data/api/service/image_repository.dart';
import 'package:flutter_application_3/domain/model/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;
  final List<ImageData> loadedImageList;
  bool responseIsEmpty = true;
  ImageBloc({required this.imageRepository, required this.loadedImageList})
      : super(ImageEmptyState()) {
    on<ImageLoadEvent>(
      (event, emit) async {
        emit(ImageLoadingState());
        try {
          if (event.page > 1) {
            loadedImageList
                .addAll(await imageRepository.getAllImages(event.page));
          } else {
            loadedImageList.addAll(await imageRepository.getAllImages(1));
          }
          emit(ImageLoadedState(loadedImage: loadedImageList));
        } catch (_) {
          emit(ImageErrorState());
        }
      },
    );
    on<ImageClearEvent>(
      (event, emit) async {
        loadedImageList.clear();
        emit(ImageEmptyState());
      },
    );
  }
}
