import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/image_bloc.dart';
import 'package:flutter_application_3/bloc/image_event.dart';
import 'package:flutter_application_3/data/api/service/image_repository.dart';
import 'package:flutter_application_3/domain/model/data.dart';
import 'package:flutter_application_3/internal/pages/image_grid/image_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';
  List<ImageData> imagePopularList = [];
  List<ImageData> imageNewList = [];
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      initialRoute: '/popular',
      routes: <String, WidgetBuilder>{
        '/popular': (context) =>
            SomethingPage('popular', 0, imagePopularList, page),
        '/new': (context) => SomethingPage('new', 1, imageNewList, page),
      },
    );
  }
}

class SomethingPage extends StatefulWidget {
  final int flag;
  final String title;
  final List<ImageData> imageList;
  int page;

  SomethingPage(this.title, this.flag, this.imageList, this.page, {Key? key})
      : super(key: key);

  @override
  State<SomethingPage> createState() => _SomethingPageState();
}

class _SomethingPageState extends State<SomethingPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ImageRepository(),
      child: BlocProvider(
        create: (context) => ImageBloc(
            categoria: widget.title,
            loadedImageList: widget.imageList,
            imageRepository: context.read<ImageRepository>()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 0, 115),
            title: Text(widget.title.toUpperCase()),
          ),
          body: ImageGrid(widget.title, widget.imageList, widget.page),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: 'Popular',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_rate_rounded),
                label: 'New',
              ),
            ],
            selectedItemColor: const Color.fromARGB(255, 255, 0, 115),
            onTap: (index) {
              final routes = ['/popular', '/new'];
              debugPrint(index.toString());
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(routes[index], (route) => false);
            },
            currentIndex: widget.flag,
          ),
        ),
      ),
    );
  }
}
