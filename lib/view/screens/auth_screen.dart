import 'package:dashboard/view_model/register_cubit/register_cubit.dart';
import 'package:dashboard/view_model/register_cubit/register_state.dart';
import 'package:dashboard/view/layout/home_layout.dart';
import 'package:dashboard/view/views/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/custom_text_form__field.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  final passwordController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      lazy: false,
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            } else if (state is CreateNewUserSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('successful sign up'),
                backgroundColor: Colors.green,
              ));
              Navigator.of(context).pushReplacementNamed(HomeLayout.routeName);
            }
          },
          builder: (context, state) {
            final registerCubit = RegisterCubit.get(context);
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image.asset(
                          alignment: AlignmentDirectional.topEnd,
                          'assets/images/Ellipse.png',
                          width: size.width,
                          height: size.height * 0.3,
                        ),
                        Image.asset(
                          alignment: AlignmentDirectional.topStart,
                          'assets/images/Ellipse-1.png',
                          width: size.width,
                          height: size.height * 0.3,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextFormField(
                                raduis: 50.0,
                                keyBoardType: TextInputType.emailAddress,
                                controller: emailAddressController,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'you must enter a valid email';
                                  }
                                  return null;
                                },
                                hintText: ' Please Enter your Email'),
                            CustomTextFormField(
                              raduis: 50.0,
                              isPassword: registerCubit.isPassword,
                              keyBoardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty || value.length > 10) {
                                  return 'you must enter a valid password';
                                }
                                return null;
                              },
                              hintText: 'Please Enter Your Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  registerCubit.toggleVisibility();
                                },
                                icon: Icon(registerCubit.visibilityIcon),
                              ),
                            ),
                            CustomTextFormField(
                                raduis: 50.0,
                                keyBoardType: TextInputType.phone,
                                controller: phoneController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'you must enter a valid phone number';
                                  }
                                  return null;
                                },
                                hintText: ' Please Enter your Phone Number'),
                            CustomTextFormField(
                                raduis: 50.0,
                                keyBoardType: TextInputType.text,
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'you must enter a valid name';
                                  }
                                  return null;
                                },
                                hintText: ' Please Enter your  Name'),
                            CustomTextFormField(
                                raduis: 50.0,
                                keyBoardType: TextInputType.number,
                                controller: ageController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'you must enter a valid age';
                                  }
                                  return null;
                                },
                                hintText: ' Please Enter your  Age'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text('Forget Password?'),
                                )
                              ],
                            ),
                            state is RegisterLoadingState
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    radius: 30.0,
                                    onPressed: () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      } else {
                                        print(passwordController.text);
                                        print(passwordController.text);
                                        await registerCubit.registerUser(
                                            email: emailAddressController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            context: context,
                                            age: ageController.text,
                                            phoneNumber: phoneController.text);
                                      }
                                    },
                                    buttonTitle: 'Login',
                                    color: Colors.deepOrangeAccent)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
