import 'package:flutter/material.dart';
import 'package:flutter_application_3/domain/model/data.dart';

class ImageDescription extends StatefulWidget {
  final List<ImageData?> imageList;
  final int index;
  final String title;
  const ImageDescription(this.imageList, this.index, this.title, {Key? key})
      : super(key: key);

  @override
  _ImageDescription createState() => _ImageDescription();
}

class _ImageDescription extends State<ImageDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(children: [
          if (widget.imageList[widget.index]?.url != null) ...{
            Expanded(
              flex: 3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    widget.imageList[widget.index]!.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          } else ...{
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 2,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  widget.imageList[widget.index]!.description,
                  style: const TextStyle(
                      fontSize: 40, decoration: TextDecoration.none),
                ),
              ),
            ),
          },
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 2,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  widget.imageList[widget.index]!.description,
                  style: const TextStyle(
                      fontSize: 40, decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
