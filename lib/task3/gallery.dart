import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'image.dart';
import 'image_store.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

import 'constants.dart' as Constants;

class Gallery extends StatefulWidget {
  const Gallery({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _GalleryState createState() => _GalleryState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _GalleryState extends State<Gallery> {

  ImageStore _imageStore = Modular.get<ImageStore>();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  double scale = 1;

  _render(ImageDetails img) {
    Widget? image = Container();
    image = Image.file(
      File(img.file!.path),
      fit: BoxFit.fill,
    );
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _imageStore.fetchImageFromCamera(onAdd: () {
                  listKey.currentState!
                      .insertItem(_imageStore.images.length - 1);
                });
              },
              icon: Icon(Icons.add_a_photo)),
          IconButton(
              onPressed: () {
                _imageStore.fetchImageFromGallery(onAdd: () {
                  listKey.currentState!
                      .insertItem(_imageStore.images.length - 1);
                });
              },
              icon: Icon(Icons.add_photo_alternate_sharp))
        ],
        title: new Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Constants.FONT_SIZE, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(Constants.PADDING),
          child: Column(
            children: [
              Expanded(child: Observer(builder: (context) {
                return Observer(builder: (context) {
                  return AnimatedList(
                    key: listKey,
                    initialItemCount: _imageStore.images.length,
                    itemBuilder: (BuildContext context, int index,
                        Animation<double> animation) {
                      ImageDetails item = _imageStore.images[index];
                      return ScaleTransition(
                        scale: animation,
                        child: Container(
                          padding:
                              EdgeInsets.only(top: Constants.PADDING, left: Constants.PADDING, right: Constants.PADDING),
                          child: PinchZoomImage(
                            image: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(Constants.CIRCULAR_RADIUS)),
                              child: _render(item),
                            ),
                            zoomedBackgroundColor:
                                Color.fromRGBO(255, 255, 255, 1.0),
                            hideStatusBarWhileZooming: true,
                            onZoomStart: () {
                              print('zooming');
                            },
                            onZoomEnd: () {
                              print('unzooming');
                            },
                          ),
                        ),
                      );
                    },
                  );
                });
              })),
            ],
          ),
        )),
      ),
    );
  }
}
