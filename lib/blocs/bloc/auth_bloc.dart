import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';
//bloc: بيستقبل event ويطلع states
class AuthCubitBloc extends Bloc<AuthEvent, AuthCubitState> {
  AuthCubitBloc() : super(AuthCubitInitial()) {
    //on method ==event handler
    //عشان اضيف event عشان trigger uiبستخدم method(add)
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  //نقدر نعرف ال events السببه ل state معينه
  @override
  void onTransition(Transition<AuthEvent, AuthCubitState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }
}
//i bloc ican track events but in cubit i can track only states