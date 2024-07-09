// import 'package:day5/dashboard.dart';
//  import 'package:day5/models/signup_model.dart';
// import 'package:day5/sharedforsignup.dart';
import 'package:day5/signup/dashboard.dart';
import 'package:day5/signup/sharedforsignup.dart';
import 'package:day5/signup/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _HomeState();
}

class _HomeState extends State<Login> {
  List<SaveModel> modelList = [];
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    Helper helper = Helper();
    List<SaveModel> loadModelList = await helper.getModelList();
    setState(() {
      modelList = loadModelList;
    });
  }

  

  final _formKey = GlobalKey<FormState>();
  TextEditingController confirmemail = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool obscure = false;
  SaveModel sModel = SaveModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white
                    ),
                  ),
                ),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: confirmpassword,
                  maxLines: 1,
                  obscureText: !obscure,
                  decoration: InputDecoration(
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.password_outlined),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: obscure
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //here check is used as a flag to indicate that match is found
                        bool check = false;
                        //innitially ther boolen is set to false indicating that match is ot found

                        for (var e in modelList) {
                          if (e.email == confirmemail.text &&
                              e.password == confirmpassword.text) {
                            check = true;
                            // if the if statement is satisfied check is changed to true which executes tha break statement
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashboard(),
                              ),
                            );
                            break; // \
                          }
                        }
                        // even after the whole list is iterated, and the value is not found then only the dialog box is executes
                        if (!check) {
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
                                      Navigator.pop(context);
                                    },
                                    child: const Text('ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
