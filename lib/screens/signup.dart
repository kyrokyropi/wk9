import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:wk9/models/name_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fnameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();

    final email = TextFormField(
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
      },
      
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        int length = passwordController.text.length;
        if (value == null || value.isEmpty) {
          return 'Please enter your password!';
        } else if (length < 6){
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );

    final firstname = TextFormField(
      controller: fnameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name!';
        }
        return null;
      },
    );

        final lastname = TextFormField(
      controller: lnameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your second name!';
        }
        return null;
      },
    );

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
             if (_formKey.currentState!.validate()) {
            FullName fullname = FullName.fromJson({
              'firstname': fnameController.text,
              'lastname': lnameController.text,
              'email': emailController.text
            });

            await context.read<MyAuthProvider>().signUp(
                fullname, emailController.text, passwordController.text);
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
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
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                firstname,
                lastname,
                email,
                password,
                SignupButton,
                backButton
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
