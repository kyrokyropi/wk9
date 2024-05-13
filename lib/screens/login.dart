import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final email = TextFormField(
      key: const Key('emailField'),
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (value) {
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text);
        if (value == null || value.isEmpty) {
          return 'Please enter an email!';
        } else if (emailValid == false) {
          return 'Please give a valid email!';
        }
        return null;
      }
    );

    final password = TextField(
      key: const Key('pwField'),
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );

    final loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
              await context.read<MyAuthProvider>().signIn(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
        },
        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            email,
            password,
            loginButton,
            signUpButton,
          ],
        ),
      ),
    );
  }
  
}

