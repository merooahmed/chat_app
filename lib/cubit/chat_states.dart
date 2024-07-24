import 'package:chatapp/models/message_model.dart';

abstract class ChatStates {}

class Initialstate extends ChatStates {}

class SuccessState extends ChatStates {
  List<Message> messages;
  SuccessState({required this.messages});
}
