import 'package:chat/features/auth/presentation/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/component_widgets/reuse/reuse.dart';
import '../../../core/component_widgets/reuse/snackbar.dart';
import '../../bottom_nav/presentaion/HomePage.dart';
import '../cubit/auth/authcubit.dart';
import '../cubit/auth/authstates.dart';
import 'login.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              SnackbarDemo().showAwesomeSnackbar(context, "Login Successful!",backgroundColor: Colors.green,icon: Icons.check_circle);
              Navigatetopush(context: context, ScreenName: Homepage());


            } else if (state is AuthFailure) {
              SnackbarDemo().showAwesomeSnackbar(context,state.error,backgroundColor: Colors.red,icon: Icons.error);

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
                    iconcolor: Colors.green
                  ),
                  const SizedBox(height: 10),
                  EditedTextField(
                      iconcolor: Colors.green,
                      controller: passwordController,
                    label: 'password',
                    icon: Icons.password,
                    obscureText: true
                  ),
                  const SizedBox(height: 20),
                  Button(
                    isstate: state is AuthLoading,
                      ontab: (){
                    BlocProvider.of<AuthCubit>(context).signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  }, name: "login"),
                  TextButton(
                    onPressed: () {
                      Navigateto(context: context, ScreenName: SignUpScreen());
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
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
