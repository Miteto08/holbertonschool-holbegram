import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../methods/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthMethode _authMethode = AuthMethode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    String result = await _authMethode.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFieldInput(
            controller: emailController,
            isPassword: false,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldInput(
            controller: passwordController,
            isPassword: true,
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
          ),
          ElevatedButton(
            onPressed: loginUser,
            child: const Text('Log in'),
          ),
        ],
      ),
    );
  }
}