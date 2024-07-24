import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> toSign({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errormsg: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errormsg: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailure(errormsg: 'something wrong'));
    }
  }
}
//event :هو الشئ او الحدث اللي ممكن اليوزر يقوم بيه