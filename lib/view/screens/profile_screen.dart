import 'package:dashboard/view/screens/auth_screen.dart';
import 'package:dashboard/view/views/custom_button.dart';
import 'package:dashboard/view_model/profile_cubit/profile_cubit.dart';
import 'package:dashboard/view_model/profile_cubit/profile_state.dart';

import 'package:dashboard/view/views/custom_text_form__field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';
  final emailAddressController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: BlocProvider(
            create: (context) => ProfileCubit()..getLoggedInUser(),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final profileCubit = ProfileCubit.get(context);
                if (state is ProfileLoadingState &&
                    profileCubit.currentUser == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProfileErrorState) {
                  return Center(
                    child: Text('something went wrong'),
                  );
                }
                final currentUser = profileCubit.currentUser!;
                emailAddressController.text = currentUser.email;
                phoneController.text = currentUser.phone;
                ageController.text = currentUser.age.toString();
                nameController.text = currentUser.name;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    children: [
                      CircleAvatar(
                          child:
                              Icon(Icons.person, color: Colors.white, size: 60),
                          radius: 55.0),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: emailAddressController,
                        raduis: 10.0,
                        isEnable: false,
                        labelWidget: Text('Email'),
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        raduis: 10.0,
                        isEnable: false,
                        labelWidget: Text('Name'),
                      ),
                      CustomTextFormField(
                        controller: phoneController,
                        raduis: 10.0,
                        isEnable: false,
                        labelWidget: Text('Phone'),
                      ),
                      CustomTextFormField(
                        controller: ageController,
                        raduis: 10.0,
                        isEnable: false,
                        labelWidget: Text('age'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          radius: 20.0,
                          color: Colors.deepOrange,
                          onPressed: () async {
                            await profileCubit.logout();
                            Navigator.of(context).pushReplacementNamed('/');
                            ;
                          },
                          buttonTitle: 'logout')
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
