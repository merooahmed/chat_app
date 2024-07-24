import 'package:chatapp/cubit/chat_cubit.dart';
import 'package:chatapp/cubit/login_cubit.dart';
import 'package:chatapp/cubit/register_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const scholarchat());
}

class scholarchat extends StatelessWidget {
  const scholarchat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(
          create: (context) => ChatCubit(),
          
        )
      ],
      child: MaterialApp(
        routes: {
          "RegisterPage": (context) => RegisterPage(),
          "LoginPage": (context) => LoginPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: "LoginPage",
      ),
    );
  }
}
