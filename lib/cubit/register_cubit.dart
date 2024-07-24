import 'package:chatapp/cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> toregister(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errormsg: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errormsg: 'email-already-in-use'));
      }
    } catch (e) {
      emit(RegisterFailure(errormsg: 'something wrong'));
    }
  }
}
