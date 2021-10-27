import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'api_client.dart';
import 'Message.dart';
import 'package:uuid/uuid.dart';
import 'Message_Store.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Api createState() => Api();
}

class Api extends State<ApiPage> {
  final TextEditingController _textEditingController = TextEditingController();

  final MessageStore _messageStore = MessageStore();

  static const Color lightGray = Color(0xFF7D7D7D);

  String currentUser = "Default name";

  @override
  void initState() {
    super.initState();
    Timer.run(() => _asyncInputDialog(context));
  }

  _asyncInputDialog(BuildContext context) async {
    String username = '';
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x12929191),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Введите свое имя'),
          content: Row(
            children: [
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ваше имя...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(width: 2, color: lightGray),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(width: 2, color: lightGray),
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    onChanged: (value) {
                      username = value;
                    },
                  ))
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'Готово',
              ),
              onPressed: () {
                currentUser = username;
                Navigator.of(context).pop(username);
              },
            ),
          ],
        );
      },
    );
  }

  void _sendMessage(String text) {
    RestClient restClient = RestClient(Dio());
    var uuid = Uuid();
    restClient
        .sendMessage(Message(id: uuid.v1(), author: currentUser, message: text));
    _textEditingController.clear();
  }



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
                    child: Observer(builder: (context) {
                      return ListView(
                          children: _messageStore.messages.map((item) {
                          Container leading = Container(width: 0, height: 0);
                          Container trailing = Container(width: 0, height: 0);
                          return ListTile(
                            leading: leading,
                            trailing: trailing,
                            title: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.author,
                                      ),
                                      Text(
                                        item.message,
                                      )
                                    ]),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: _textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Сообщение...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.all(15),
                              ),
                            )),
                      ),
                      GestureDetector(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: const Icon(
                              Icons.send,
                            )),
                        onTap: () {
                          _sendMessage(_textEditingController.text);
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}