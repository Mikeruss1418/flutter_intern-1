import 'package:day5/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _HomeState();
}

class _HomeState extends State<Login> {
  @override
  void initState() {
    super.initState();
    // load();
  }

  // void load() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     final fullname = prefs.getString('fullname') ?? '';
  //     final gender = prefs.getString('gender') ?? '';
  //     final dob = prefs.getString('dob') ?? '';
  //     final mobile = prefs.getString('mobile') ?? '';
  //     final maritalstatus = prefs.getString('maritalstatus') ?? '';
  //     final email = prefs.getString('email') ?? '';
  //     final password = prefs.getString('password') ?? '';
  //   });
  // }

  final _formKey = GlobalKey<FormState>();
  TextEditingController confirmemail = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: Padding(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: confirmemail,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      label: Text('Email'),
                      prefixIcon: Icon(Icons.email_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: confirmpassword,
                  maxLines: 1,
                  // obscureText: obscure!,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.password_outlined),
                    // suffixIcon: IconButton(
                    //     onPressed: () {
                    //       if (obscure == false) {
                    //         setState(() {
                    //           obscure = true;
                    //         });
                    //       }
                    //     },
                    //     icon: Icon(obscure == false
                    //         ? Icons.visibility_off
                    //         : Icons.visibility),
                    //         ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final prefs = await SharedPreferences.getInstance();
                        final email = prefs.getString('email');
                        final password = prefs.getString('password');
                        //
                        if (confirmemail.text == email &&
                            confirmpassword.text == password) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Invalid Credentials'),
                                content: const Text(
                                    "The email and password didn't match"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('ok'))
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const Text('Submit'))
              ],
            ),
          ),
        ));
  }
}
