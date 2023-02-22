import 'package:dashboard/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  bool isPassword = false;
  IconData visibilityIcon = Icons.visibility_off;
  void toggleVisibility() {
    isPassword = !isPassword;
    visibilityIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterToggleVisibilityState());
  }

  void createUser(
      {required String email,
      required String name,
      required String uId,
      required String phone,
      required String image,
      required String age}) async {
    final user = UserModel(
        email: email,
        avatarImage: image,
        uId: uId,
        name: name,
        phone: phone,
        age: int.parse(age));
    FirebaseFirestore.instance.collection('users').doc(uId).set(user.toMap());
    emit(CreateNewUserSuccessState());
  }

  String uId = '';

  Future<void> registerUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context,
      String image =
          'https://www.misemacau.org/wp-content/uploads/2015/11/avatar-placeholder-01-300x250.png',
      required String age,
      required String phoneNumber}) async {
    emit(RegisterLoadingState());
    try {
      final userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCred.user != null) {
        createUser(
            email: email,
            name: name,
            uId: userCred.user!.uid,
            phone: phoneNumber,
            image: image,
            age: age);
        uId = userCred.user!.uid;
        emit(RegisterSuccessState(userCred.user!.uid));
        // SocialCubit.get(context).getCurrentUserData();
      } else {
        emit(RegisterErrorState(
            'Register error..,please check your credential'));
        throw (Exception('Register error'));
      }
    } on FirebaseAuthException catch (err) {
      print(err);
      emit(RegisterErrorState(err.message!));
    }
  }
}
