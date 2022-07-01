import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/model/data.dart';
import 'package:flutter_application_3/data/api/service/dio.dart';
import 'package:flutter_application_3/internal/pages/ImageDescription/image_description.dart';
import 'package:pagination_view/pagination_view.dart';

class ImageView extends StatefulWidget {
  final bool popular;
  final bool newImages;
  final String title;
  const ImageView(this.popular, this.title, this.newImages, {Key? key})
      : super(key: key);
  @override
  _ImageView createState() => _ImageView();
}

class _ImageView extends State<ImageView> {
  var flag;
  final DioClient response = DioClient();
  List<Data> imagesList = [];
  // final ScrollController _controller = ScrollController();

  Future<List<Data>> refresher() async {
    return await Future.delayed(const Duration(seconds: 1),
        (() => response.getImage(1, widget.popular, widget.newImages)));
  }

  /* @override
  void initState() {
    flag = widget.order;
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        setState(() {});
      }
    });
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: refresher(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (flag != widget.title) {
            flag = widget.title;
            imagesList = [];
          }
          imagesList.addAll(snapshot.data!);
          return /* RefreshIndicator(
            color: const Color.fromARGB(255, 255, 0, 123),
            strokeWidth: 4.0,
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 2), () {
                imagesList = [];
                setState(() {});
              });
            },
            child:  */
              ImageGrid(imagesList, widget.title /* , _controller */,
                  widget.popular, widget.newImages);
          // );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /*  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  } */
}

class ImageGrid extends StatefulWidget {
  // final ScrollController _controller;
  final List<Data> imageList;
  final String title;
  final bool popular;
  final bool newImages;
  const ImageGrid(this.imageList, this.title /* , this._controller */,
      this.popular, this.newImages,
      {Key? key})
      : super(key: key);

  @override
  _ImageGrid createState() => _ImageGrid();
}

class _ImageGrid extends State<ImageGrid> {
  DioClient response = DioClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.start,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: PaginationView<Data>(
        preloadedItems: widget.imageList,
        itemBuilder: (BuildContext context, Data image, int index) =>
            GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  ImageDescription(widget.imageList, index, widget.title))),
          child: SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        pullToRefresh: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: 2),
        paginationViewType: PaginationViewType.gridView,
        pageFetch: (page) =>
            response.getImage(page, widget.popular, widget.newImages),
        onError: (dynamic error) => const Center(
          child: Text('Some error occured'),
        ),
        onEmpty: const Center(
          child: Text('Sorry! This is empty'),
        ),
        bottomLoader: const Center(
          // optional
          child: CircularProgressIndicator(),
        ),
        initialLoader: const Center(
          // optional
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


// GridView.count(
//           controller: widget._controller,
//           padding: const EdgeInsets.all(20),
//           mainAxisSpacing: 10,
//           childAspectRatio: 2,
//           crossAxisSpacing: 20,
//           crossAxisCount: 2,
//           children: List.generate(widget.imageList.length, (index) {
//             return GestureDetector(
//               onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       ImageDescription(widget.imageList, index, widget.title))),
//               child: SizedBox(
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   child: Image.network(
//                     widget.imageList[index].url,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             );
//           },
//           ),
//         ),