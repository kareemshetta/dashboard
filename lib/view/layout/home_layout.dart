import 'package:dashboard/view_model/app_cubit/app_cubit.dart';
import 'package:dashboard/view_model/app_cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static const routeName = '/home-layout';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final appCubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: appCubit.currentIndex,
              onTap: appCubit.changeBottomNavigation,
              items: appCubit.items,
            ),
            body: appCubit.screens[appCubit.currentIndex],
          );
        },
      ),
    );
  }
}
