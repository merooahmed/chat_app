import 'package:chatapp/cubit/chat_states.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(Initialstate());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMessage({required String email, required String data}) {
    messages.add({
      'message': data,
      'CreatedAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessage() {
    messages.orderBy('CreatedAt', descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc)) ;
      }
      emit(SuccessState(messages: messageList));
    });
  }
}
