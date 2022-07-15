import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/image_bloc.dart';
import 'package:flutter_application_3/bloc/image_event.dart';
import 'package:flutter_application_3/bloc/image_state.dart';
import 'package:flutter_application_3/domain/model/data.dart';
import 'package:flutter_application_3/internal/pages/image_description/image_description.dart';
import 'package:flutter_application_3/internal/pages/not_connection_error/not_connection_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageGrid extends StatefulWidget {
  int page;
  final String title;
  final List<ImageData> imageList;
  ImageGrid(this.title, this.imageList, this.page, {Key? key})
      : super(key: key);
  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    final ImageBloc imageBloc = context.read<ImageBloc>();
    imageBloc.add(ImageLoadEvent(widget.page));
    widget.page++;
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {
          imageBloc.add(ImageLoadEvent(widget.page));
          widget.page++;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageBloc, ImageState>(
      listener: ((context, state) {
        log(state.toString());
        if (state is ImageLoadedState) {
          if (state.loadedImage.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('List is Empty')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Images is Loaded')));
          }
        }
      }),
      builder: (context, state) {
        if (state is ImageEmptyState) {
          return const Center(
            child: Text(
              'No data received. Please scroll list',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        if (state is ImageLoadingState) {
          return Container(
            margin: EdgeInsets.only(bottom: 100),
            alignment: Alignment.bottomCenter,
            child: const CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 0, 115),
            ),
          );
        }

        if (state is ImageLoadedState) {
          return RefreshIndicator(
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            backgroundColor: Color.fromARGB(0, 255, 255, 255),
            color: const Color.fromARGB(255, 255, 0, 115),
            onRefresh: (() async {
              await Future.delayed(const Duration(seconds: 3));
              final ImageBloc imageBloc = context.read<ImageBloc>();
              imageBloc.add(ImageClearEvent());
              imageBloc.add(ImageLoadEvent(1));
              setState(() {
                widget.page = 2;
              });
            }),
            child: GridView.count(
              controller: _controller,
              physics:
                  const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
              padding: const EdgeInsets.all(20),
              mainAxisSpacing: 60,
              childAspectRatio: 2,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              children: List.generate(
                widget.imageList.length,
                (index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ImageDescription(
                            widget.imageList, index, widget.title))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        widget.imageList[index].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        if (state is ImageErrorState) {
          return const NotConnectionError();
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// Future<int> _refreshData(BuildContext context, int page) async {
//   await Future.delayed(const Duration(seconds: 3));
//   final ImageBloc imageBloc = context.read<ImageBloc>();
//   imageBloc.add(ImageClearEvent());
//   imageBloc.add(ImageLoadEvent(1));
//   return 1;
// }
