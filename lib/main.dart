import 'package:dashboard/styles/themes.dart';
import 'package:dashboard/view_model/item_cubit/item_cubit.dart';
import 'package:dashboard/view_model/observer_cubit.dart';
import 'package:dashboard/view/layout/home_layout.dart';
import 'package:dashboard/view/screens/edit_product_screen.dart';
import 'package:dashboard/view/screens/home_screen.dart';
import 'package:dashboard/view/screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ItemCubit()..getAllData(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': (ctx) => AuthScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            HomeLayout.routeName: (ctx) => const HomeLayout(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen()
          },
        ));
  }
}
