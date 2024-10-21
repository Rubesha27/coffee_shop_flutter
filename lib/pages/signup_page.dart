import 'package:coffee_shop/const.dart';
import 'package:coffee_shop/firebase%20services/auth_service.dart';
import 'package:coffee_shop/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  authservice services = authservice();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      services
          .signUp(_emailController.text, _passwordController.text)
          .then((user) {
        if (user != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
        }
      });
    }
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      services
          .signIn(_emailController.text, _passwordController.text)
          .then((user) {
        if (user != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bg_color,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Welcome to the Coffee Shop",
                    style: GoogleFonts.roboto(
                        fontSize: 20, color: Colors.brown.shade800),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "lib/images/espresso.png",
                        width: 300,
                        height: 300,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.lato(),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      validator: _validateEmail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      style: GoogleFonts.lato(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _signIn,
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.brown)),
                        child: const Text('Sign In'),
                      ),
                      ElevatedButton(
                        onPressed: _signUp,
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.brown)),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
