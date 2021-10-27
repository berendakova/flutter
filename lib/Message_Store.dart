import 'package:dio/dio.dart';
import 'Message.dart';
import 'package:mobx/mobx.dart';
import 'api_client.dart';
import 'package:uuid/uuid.dart';

part 'Message_Store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  String url = 'https://itis-chat-app-ex.herokuapp.com/chat';

  @observable
  ObservableList<Message> messages = ObservableList.of([]);

  @action
  void fetchNewMessage() {
    RestClient restClient = RestClient(Dio());
    restClient.getMessages().then((List<Message> messages) {
      this.messages.clear();
      this.messages.addAll(messages);
    }).catchError((error) {
      print(error.toString());
    });
  }

  @action
  void sendMessage(String text) {
    RestClient restClient = RestClient(Dio());
    try {
      var uuid = Uuid();

      restClient.sendMessage(Message(id: uuid.v1(), author: 'Tanya B', message: text));
    } catch(error) {
      print(error.toString());
    }
  }
}