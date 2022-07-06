import 'package:flutter/material.dart';
import 'package:flutter_application_3/internal/pages/image_grid/image_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      initialRoute: '/popular',
      routes: <String, WidgetBuilder>{
        '/popular': (context) =>
            const MyStatefulWidget(true, 'POPULAR', 0, true),
        '/new': (context) => const MyStatefulWidget(true, 'NEW', 1, true),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final bool popular;
  final bool newImages;
  final String title;
  final int flag;
  const MyStatefulWidget(this.popular, this.title, this.flag, this.newImages,
      {Key? key})
      : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageView(widget.popular, widget.title, widget.newImages),
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
          Navigator.of(context).pushReplacementNamed(routes[index]);
        },
        currentIndex: widget.flag,
      ),
    );
  }
}
