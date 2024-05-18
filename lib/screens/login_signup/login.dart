import 'dart:convert';
import 'package:ecommerce_app/main_page.dart';
import 'package:ecommerce_app/provider/global_provider.dart';
import 'package:ecommerce_app/screens/home/home_page.dart';
import 'package:ecommerce_app/utils/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/customButton.dart';
import 'package:http/http.dart' as http;
import '../../widgets/customTextfield.dart';
import '../../widgets/mTextStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> moveToHome(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('https://fakestoreapi.com/auth/login'));
    request.body = json.encode(
      {
        "username": usernameController.text,
        "password": passwordController.text,
      },
    );
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody =
          await response.stream.bytesToString(); // Read the stream only once
      if (kDebugMode) {
        print(responseBody); // Print the response for debugging
      }
      Map<String, dynamic> jsonMap = json.decode(responseBody);

      if (jsonMap.containsKey("token")) {
        await Provider.of<Global_provider>(context, listen: false)
            .saveToken(jsonMap["token"]);
        if (kDebugMode) {
          print(await Provider.of<Global_provider>(context, listen: false)
              .getToken());
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MainPage()));
      } else {
        showErrorMessage(context, "Token not found in response");
      }
    } else {
      showErrorMessage(context, "Login failed: ${response.reasonPhrase}");
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightMedium,
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightMax,
                heightMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    heightMedium,
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    heightMedium,
                    Text(
                      'Forgot your password',
                      style: meTextStyle(),
                    ),
                    heightMax,
                    CustomButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await moveToHome(context);
                        }
                      },
                      text: 'LOGIN',
                    ),
                  ],
                ),
                heightMedium,
                heightMedium,
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          ' Or continue with ',
                          style: meTextStyle(),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    heightMedium,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/google.png'),
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(width: 20), // Adjusted spacing
                        Image(
                          image: AssetImage('assets/images/facebook.png'),
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                    heightMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Not a member? Register now',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
