import 'package:chatapp/cubit/chat_cubit.dart';
import 'package:chatapp/cubit/chat_states.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/widgets/chat_bubble.dart';
import 'package:chatapp/widgets/chat_forward_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final _controller = ScrollController();
  List<Message> messageList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff314F6A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/scholar.png",
              height: 60,
            ),
            const Text(
              ' Chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatStates>(
              listener: (context, state) {
                if (state is SuccessState) {
                  messageList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(
                              message: messageList[index],
                            )
                          : ChatForwardBubble(message: messageList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(email:email , data: data);
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                  hintText: ' Send Message',
                  suffixIcon: const Icon(
                    Icons.send,
                    color: Color(0xff314F6A),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff314F6A))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff314F6A)))),
            ),
          )
        ],
      ),
    );
  }
}
