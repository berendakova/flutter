import 'dart:io';

import 'package:first_project/task2/api.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_project/task1/detail_info.dart';
import 'package:first_project/task3/gallery.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
          title: 'Flutter Demo',
          home: const MyHomePage(title: 'Homeworks'));
    });
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: ListTile.divideTiles(context: context, tiles: [
                        ListTile(
                          title: const Text(
                            'Task 1',
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Chat(title: 'task 1')));
                          },
                        ),
                        ListTile(
                          title: const Text(
                            'Task 2',
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ApiPage(title: 'task 2')));
                          },
                        ),
                        ListTile(
                          title: const Text(
                            'Task 3',
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Gallery(title: 'task 3')));
                          },
                        ),
                      ]).toList(),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}