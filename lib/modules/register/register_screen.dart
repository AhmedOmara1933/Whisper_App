import 'package:chat_app_firebase/modules/register/register_cubit/chat_register_cubit.dart';
import 'package:chat_app_firebase/modules/register/register_cubit/chat_register_state.dart';
import 'package:chat_app_firebase/shared/components/default_button.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/textFormField.dart';
import '../../shared/function/function.dart';
import '../login/login_screen.dart';

// ignore: must_be_immutable
class ChatRegisterScreen extends StatelessWidget {
  const ChatRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatRegisterCubit(),
      child: BlocConsumer<ChatRegisterCubit, ChatRegisterState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ChatCreateUserSuccessState) {
            navigateTo(context, const ChatLoginScreen(), true);
            snakeBar(
              context: context,
                text: 'Registration successful! Welcome to the app.', color: Colors.green);
          } else if (state is ChatRegisterErrorState) {
            snakeBar(
              context: context,
                text: 'Registration failed. Please try again.', color: Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = ChatRegisterCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: cubit.formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/messaging.png'),
                              height: 240.0,
                              fit: BoxFit.cover,
                              width: 240.0,
                            ),
                          ],
                        ),
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Register here to communicate with friends',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DefaultTextFormField(
                                controller: cubit.nameController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return ' Name must be fill';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Name',
                                prefixIcon: Icon(Icons.person_outlined),
                              ),
                            ),
                            SizedBox(width: 15.0,),
                            Expanded(
                              child: DefaultTextFormField(
                                controller: cubit.phoneController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return ' phone must be fill';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                hintText: 'Phone',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                          ],
                        ),
                        DefaultTextFormField(
                          controller: cubit.emailController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address must be fill';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email Address',
                          prefixIcon: Icon(Icons.email),
                        ),
                        DefaultTextFormField(
                          controller: cubit.passwordController,
                          obscureText: cubit.isPassword,
                          keyboardType: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password must be fill';
                            }
                            return null;
                          },
                          // suffixIcon: cubit.isPassword == true
                          //     ? Icons.visibility
                          //     : Icons.visibility_off,
                          // suffixOnPressed: () {
                          //   cubit.isPasswordVisibility();
                          // },
                          suffixIcon: IconButton(
                              onPressed: (){
                                cubit.isPasswordVisibility();
                              },
                              icon: Icon(cubit.isPassword == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,)
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        ConditionalBuilder(
                          condition: state is! ChatRegisterLoadingState,
                          builder: (context) => DefaultButton(
                            text: 'Sign Up',
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: cubit.nameController.text,
                                    phone: cubit.phoneController.text,
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text);
                              }
                            },
                          ),
                          fallback: (context) =>
                               Center(child: CircularProgressIndicator(color: baseColor,)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Do you have an account ',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatLoginScreen(),
                                    ));
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
