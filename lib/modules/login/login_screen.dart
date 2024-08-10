import 'package:chat_app_firebase/shared/components/default_button.dart';
import 'package:chat_app_firebase/shared/network/local/cache_helper.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/chat_home_layout.dart';
import '../../shared/components/textFormField.dart';
import '../../shared/function/function.dart';
import '../register/register_screen.dart';
import 'login_cubit/chat_login_cubit.dart';
import 'login_cubit/chat_login_state.dart';

// ignore: must_be_immutable
class ChatLoginScreen extends StatelessWidget {
  const ChatLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatLoginCubit(),
      child: BlocConsumer<ChatLoginCubit, ChatLoginStates>(
        listener: (context, state) {
          if (state is ChatLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              snakeBar(
                  context: context,
                  text: 'Login successful! Welcome back.',
                  color: Colors.green);

              navigateTo(context, ChatHomeLayout(), true);
            });
          } 
          else if (state is ChatLoginErrorState) {
            snakeBar(
                context: context,
                text:
                    'Login failed. Please check your credentials and try again.',
                color: Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = ChatLoginCubit().get(context);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('images/messaging.png'),
                              fit: BoxFit.cover,
                              height: 240.0,
                              width: 240.0,
                            ),
                          ],
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Login here to communicate with friends',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        DefaultTextFormField(
                          controller: cubit.email,
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
                          controller: cubit.password,
                          onChanged: (value) {},
                          keyboardType: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password must be fill';
                            }
                            return null;
                          },
                          obscureText: cubit.isPassword,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.isVisibility();
                              },
                              icon: Icon(
                                cubit.isPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              )),
                        ),
                        ConditionalBuilder(
                          condition: state is! ChatLoginLoadingState,
                          builder: (context) => DefaultButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: cubit.email.text,
                                    password: cubit.password.text);
                              }
                            },
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: baseColor,
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                    context, ChatRegisterScreen(), false);
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
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
