import 'package:bloc/bloc.dart';

import 'package:dashboard/view/screens/home_screen.dart';
import 'package:dashboard/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];
  List<Widget> screens = [HomeScreen(), ProfileScreen()];

  int currentIndex = 0;
  void changeBottomNavigation(int index) async {
    currentIndex = index;
    emit(BottomNavigationChangeState());
  }
}
