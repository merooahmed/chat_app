import 'package:chatapp/cubit/chat_cubit.dart';
import 'package:chatapp/cubit/login_cubit.dart';
import 'package:chatapp/helper/show_message.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginFailure) {
          showMessage(context, state.errormsg);
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
            backgroundColor: const Color(0xff314F6A),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formkey,
                child: ListView(children: [
                  Container(
                    height: 100,
                  ),
                  Image.asset(
                    "assets/images/scholar.png",
                    height: 100,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "scholar Chat",
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'pacifico',
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                  ),
                  const Row(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hinttext: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    obstracttext: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hinttext: 'Password',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          isloading = true;

                          BlocProvider.of<LoginCubit>(context)
                              .toSign(email: email!, password: password!);
                        } else {}
                        isloading = false;
                      },
                      text: "LOGIN"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "RegisterPage");
                        },
                        child: const Text(
                          "  Register",
                          style: TextStyle(color: Color(0xffC6EAE8)),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> toSign() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
