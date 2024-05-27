// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:bits_quicktask/register_page.dart';
import 'package:bits_quicktask/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    try {
      final TextEditingController _usernameController = TextEditingController();
      final TextEditingController _passwordController = TextEditingController();

      // final user = await ParseUser.login(_usernameController.text, _passwordController.text);
      // Navigate to home screen or show success message
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      // Handle login errors
      print('Login Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Task - Login', style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(33, 150, 243, 1))),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: const Text('Assignment 1',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 42, 42, 42))),
              ),
              SizedBox(
                height: 2,
              ),
              Center(
                child: const Text('Student ID: 2021MT70536',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 42, 42, 42))),
              ),
              SizedBox(
                height: 40,
              ),              
            Center(
                child: const Text('Quick Task',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromRGBO(33, 150, 243, 1))),
              ),
              SizedBox(
                height: 2,
              ),
              Center(
                child: const Text('Stay up-to-date with QuickTask App',
                    style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 42, 42, 42))),
              ),
              SizedBox(
                height: 26,
              ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
             SizedBox(
                height: 26,
              ),
            ElevatedButton(
              onPressed: () => _login(),
              child: Text('Login',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
              )
            ),
            TextButton(
              onPressed: () {
                // Navigate to registration screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      final user = ParseUser(username, password, null);
      var response = await user.login();

      if (response.success) {
        // Navigate to the todo page on successful login
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        // Show login error message if login fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Login failed: ${response.error!.message}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle any other exceptions during login
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}