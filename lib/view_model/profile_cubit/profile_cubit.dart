import 'package:bloc/bloc.dart';
import 'package:dashboard/model/user_model.dart';
import 'package:dashboard/view_model/profile_cubit/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  UserModel? currentUser;
  Future<void> getLoggedInUser() async {
    emit(ProfileLoadingState());
    final uId = FirebaseAuth.instance.currentUser!.uid;
    final documentList =
        await FirebaseFirestore.instance.collection('users').doc(uId).get();
    currentUser = UserModel.fromJson(documentList.data());
    if (currentUser != null) {
      emit(ProfileSuccessState());
    } else {
      emit(ProfileErrorState());
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(ProfileLogoutState());
  }
}
