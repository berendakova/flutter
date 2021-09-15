import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChatState createState() => _ChatState();
}


class _ChatState extends State<Chat> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _sms = [];
  String message = 'Чтобы добавить сообщение напишите в формате : Ivan:hello!';

  void _addToList(BuildContext context, String text) {
    setState(() {
        if(text.split(':').length != 2) {
          showSnackBar(context, 'Некорректное сообщение');
        }
      _sms.add(text.split(':')[0] + '\n'+ '-' + text.split(':')[1]);
    });
    _textEditingController.clear();
  }

  void showSnackBar(BuildContext context, String text)
  {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),//default is 4s
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(
            color: Colors.green, fontSize: 16),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child:
                    ListTile(
                      title: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 16),
                          ),
                        ),
                      ),
                  Expanded(
                    child:
                      ListView(
                      children: _sms.map((item) {
                        return ListTile(
                          title: Text(
                            item,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Chat(title: item)));
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Icon(Icons.add, color: Colors.white,),
                        onTap: () {
                          _addToList(context, _textEditingController.text);
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


