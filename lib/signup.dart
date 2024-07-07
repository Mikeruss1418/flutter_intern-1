import 'dart:io';

import 'package:day5/dashboard.dart';
import 'package:day5/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _HomeState();
}

class _HomeState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  //
  String? gender;
  String? maritalstatus;
  DateTime? dob;
  //index for bottom navigation
  int selectedindex = 0;
  //for password
  bool obscure = false;
  //for imagepicker
  final ImagePicker picker = ImagePicker();
  //filepicker
  // FilePickerResult? cvfile;
  File? image;
  File? cv;

  void ontap(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final fullname = prefs.getString('fullname') ?? '';
      final gender = prefs.getString('gender') ?? '';
      final dob = prefs.getString('dob') ?? '';
      final mobile = prefs.getString('mobile') ?? '';
      final maritalstatus = prefs.getString('maritalstatus') ?? '';
      final email = prefs.getString('email') ?? '';
      final password = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 49, 54, 57),
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 49, 54, 57),
        title: const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text('CV Form'),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white
                  ),
                ),
              ),
              TextFormField(
                controller: fullname,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-za-z _]'))
                ],
                maxLength: 40,
                maxLines: 2,
                minLines: 1,
                decoration: const InputDecoration(
                    label: Text('Fullname'),
                    prefixIcon: Icon(Icons.person_add_alt_outlined)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  } else {
                    return null;
                  }
                },
              ),
              DropdownButtonFormField(
                hint: const Text("Gender"),
                value: gender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please enter your dae of birth";
                  } else {
                    return null;
                  }
                },
              ),
              ListTile(
                trailing: const Icon(Icons.calendar_month_outlined),
                title: Text(dob == null
                    ? "Select Date of Birth"
                    : 'DOB: ${DateFormat('y-MM-dd').format(dob!)}'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (picked != null && picked != dob) {
                    setState(() {
                      dob = picked;
                    });
                  }
                },
              ),
              TextFormField(
                controller: mobile,
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    label: Text('Phone no:'),
                    prefixIcon: Icon(Icons.phone_android)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your number";
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                },
              ),
              DropdownButtonFormField(
                hint: const Text('Marital Status'),
                value: maritalstatus,
                items: const [
                  DropdownMenuItem(value: 'Single', child: Text('Single')),
                  DropdownMenuItem(value: 'Married', child: Text('Married')),
                  DropdownMenuItem(value: 'Divorce', child: Text('Divorce')),
                  DropdownMenuItem(value: 'Widow', child: Text('Widow')),
                ],
                onChanged: (value) {
                  setState(() {
                    maritalstatus = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please gives us your marital status";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: email,
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
                controller: password,
                maxLines: 1,
                obscureText: obscure!,
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
                    return "Please enter your email";
                  } else {
                    return null;
                  }
                },
              ),
              Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  TextButton.icon(
                      onPressed: () async {
                        XFile? gallery =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (gallery != null) {
                          setState(() {
                            image = File(gallery
                                .path); // the path keyword gets the path of the pickedimage
                          });
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Upload Image')),
                      
                  TextButton.icon(
                      onPressed: () async {
                        XFile? camera =
                            await picker.pickImage(source: ImageSource.camera);
                        if (camera != null) {
                          setState(() {
                            image = File(camera.path);
                          });
                        }
                      },
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Take a Picture')),
                ],
              ),
              
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: const Text('Upload CV'),
                  onPressed: () async {
                    FilePickerResult? cvfile = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom, allowedExtensions: ['pdf']);
                    if (cvfile != null) {
                      setState(() {
                        cv = File(cvfile.files.single.path!);
                        print('$cv');
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Signup successful'),
                      ));
                    }
                  },
                ),
               
              ),
               cv == null ? Container() : const Text('CV Uploaded'),
              
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && dob != null) {
                      print("gooodddddddddddddddddddddd");
                      print('$cv');
                      print('$image');
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('fullname', fullname.text);
                      await prefs.setString('gender', gender!);
                      await prefs.setString('dob', dob.toString());
                      await prefs.setString('mobile', mobile.text);
                      await prefs.setString('maritalstatus', maritalstatus!);
                      await prefs.setString('email', email.text);
                      await prefs.setString('password', password.text);
                      if (image != null) {
                        //getting a directory to save
                        Directory directory =
                            await getApplicationDocumentsDirectory();
                        //set a new path with addition of /image.png
                        final imagepath = '${directory.path}/image.png';
                        //copy the path
                        await image!.copy(imagepath);
                        await prefs.setString('imagepath', imagepath);
                      }
                      if (cv != null) {
                        Directory directory =
                            await getApplicationDocumentsDirectory();
                        final cvpath = '${directory.path}/cv.pdf';
                        await cv!.copy(cvpath);
                        await prefs.setString('cvpath', cvpath);
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),

      ////
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('Drawer')),
            // UserAccountsDrawerHeader(
            //   accountName: Text(fullname.text),
            //   accountEmail: Text(email.text),
            // ),
            ListTile(title: Text('Home')),
            ListTile(
              title: Text('Login'),
            ),
            ListTile(
              title: Text("dashboard"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ontap,
        iconSize: 20,
        elevation: 4,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: "Login",
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.amber)
        ],
        currentIndex: selectedindex,
      ),
    );
  }
}
