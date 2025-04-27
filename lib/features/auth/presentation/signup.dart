import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/component_widgets/reuse/reuse.dart';
import '../../../core/component_widgets/reuse/snackbar.dart';
import '../cubit/auth/authcubit.dart';
import '../cubit/auth/authstates.dart';
import 'login.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              SnackbarDemo().showAwesomeSnackbar(context, "Register Successful!",backgroundColor: Colors.green,icon: Icons.check_circle);
              Navigateto(context: context, ScreenName: LoginScreen());

              // Navigate to Home Screen
            } else if (state is AuthFailure) {
              SnackbarDemo().showAwesomeSnackbar(context,state.error,backgroundColor: Colors.red,icon: Icons.error);
            }
            if (state is AuthSuccess) {
              emailController.clear();
              passwordController.clear();
              nameController.clear();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditedTextField(
                    controller: emailController,
                    label: 'email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 10),
                  EditedTextField(
                    controller: passwordController,
                    label: 'password',
                    icon: Icons.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  EditedTextField(
                    controller: nameController,
                    label: 'name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    isstate: state is AuthLoading,
                    ontab: () {
                      BlocProvider.of<AuthCubit>(context).signUp(
                        name: nameController.text,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    },
                    name: "Sign up",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigateto(context: context, ScreenName: LoginScreen());
                    },
                    child: const Text('Already have an account! Log in'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
