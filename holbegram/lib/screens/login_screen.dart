import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
<<<<<<< HEAD
import '../methods/auth_methods.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
=======

class LoginScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool _passwordVisible;

  const LoginScreen({
    Key? key,
    required this.emailController,
    required this.passwordController,
    bool passwordVisible = true,
  })  : _passwordVisible = passwordVisible,
        super(key: key);
>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
<<<<<<< HEAD
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;
  final AuthMethode _authMethode = AuthMethode();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String result = await _authMethode.login(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login"),
          backgroundColor: Colors.green,
        ),
      );
      // Naviguer vers l'écran d'accueil (à implémenter plus tard)
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

=======
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget._passwordVisible;
  }

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.asset(
<<<<<<< HEAD
              'assets/images/image.png',
=======
              'assets/logo.png',
>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54
              width: 80,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFieldInput(
<<<<<<< HEAD
                    controller: emailController,
=======
                    controller: widget.emailController,
>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
<<<<<<< HEAD
                    controller: passwordController,
=======
                    controller: widget.passwordController,
>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54
                    isPassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
<<<<<<< HEAD
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: _isLoading ? null : loginUser,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),
=======
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Forgot your login details? '),
                      Text(
                        'Get help logging in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(flex: 0, child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 2),
<<<<<<< HEAD
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                          child: const Text(
=======
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        TextButton(
                          onPressed: null,
                          child: Text(
>>>>>>> 47bc055c42476e572a9cb81e27dfb64b62649f54
                            'Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(218, 226, 37, 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Flexible(child: Divider(thickness: 2)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('OR'),
                      ),
                      Flexible(child: Divider(thickness: 2)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: NetworkImage('https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png'),
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 8),
                      Text('Sign in with Google'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}