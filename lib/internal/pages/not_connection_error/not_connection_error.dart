import 'package:flutter/material.dart';

class NotConnectionError extends StatefulWidget {
  const NotConnectionError({Key? key}) : super(key: key);

  @override
  State<NotConnectionError> createState() => _NotConnectionErrorState();
}

class _NotConnectionErrorState extends State<NotConnectionError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/1.png'),
            width: 50,
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Oh shucks!',
              style: TextStyle(color: Color.fromARGB(255, 22, 25, 83)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: const [
                Text('Slow or no internet connection.',
                    style: TextStyle(
                        color: Color.fromARGB(255, 118, 119, 128),
                        fontSize: 10)),
                Text('Please check your internet settings',
                    style: TextStyle(
                        color: Color.fromARGB(255, 118, 119, 128),
                        fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
