import 'package:flutter/material.dart';

import '../pages/first_screen.dart';
import '../pages/second_screen.dart';
import '../services/firebase_sign_in.dart';
import '../services/sign_in_biasa.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const FlutterLogo(size: 150),
              const SizedBox(height: 50),
              _signInButtonGoogle(),
              const SizedBox(height: 10),
              _signInButtonEmail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButtonGoogle() {
    return OutlinedButton(
        onPressed: () {
          signInWithGoogle().then((result) {
            if (result != null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const FirstScreen();
              }));
            }
          });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(3),
            shadowColor:
                MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/google_logo.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _signInButtonEmail() {
    return OutlinedButton(
      onPressed: () {
        _showEmailSignInDialog();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(3),
        shadowColor:
            MaterialStateProperty.all<Color>(Colors.black.withOpacity(0.5)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: const <Widget>[
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Sign in with Email',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEmailSignInDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign In with Email'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildEmailField(),
                const SizedBox(height: 10),
                _buildPasswordField()
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sign In'),
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                signInWithEmail(email, password).then((result) {
                  if (result != null) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SecondScreen();
                    }));
                  }
                });
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      obscureText: _obscurePassword,
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
          labelText: 'Email', border: OutlineInputBorder()),
    );
  }
}
