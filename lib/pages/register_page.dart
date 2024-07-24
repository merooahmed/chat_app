import 'package:chatapp/cubit/register_cubit.dart';
import 'package:chatapp/cubit/register_states.dart';
import 'package:chatapp/helper/show_message.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isloading = true;
        } else if (state is RegisterFailure) {
          showMessage(context, state.errormsg);
          isloading = false;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isloading = false;
        }
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
                        "Register",
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
                        BlocProvider.of<RegisterCubit>(context)
                            .toregister(email: email!, password: password!);
                      }
                    },
                    text: "REGISTER",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        " Already have an account",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "  Login",
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

  Future<void> toregister() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
