import 'dart:convert';
import 'dart:developer';

import 'dart:io';

// import 'package:day5/dashboard.dart';
// import 'package:day5/login.dart';
//  import 'package:day5/models/signup_model.dart';
// import 'package:day5/sharedforsignup.dart';
import 'package:day5/signup/dashboard.dart';
import 'package:day5/signup/sharedforsignup.dart';
import 'package:day5/signup/signup_model.dart';
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
  SaveModel? saveModel;
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

  //for password
  bool obscure = false;
  //for imagepicker
  final ImagePicker picker = ImagePicker();
  //filepicker
  // FilePickerResult? cvfile;
  File? image;
  File? cv;
  // String? imagepath;

  //

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> save(SaveModel model) async {
    Helper().addUserModel(model);
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // String cvString = json.encode(model.toJson());
    // log(cvString);
    // await prefs.setString('user_data', cvString);
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonmodel = prefs.getString('user_data');
    if (jsonmodel != null) {
      setState(() {
        //instance of ExpModel
        saveModel = SaveModel.fromJson(jsonDecode(jsonmodel));
        log(jsonmodel);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    password.dispose();
    mobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? imagepath;
    String? cvpath;
    Directory directoryimage;
    Directory directorycv;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 49, 54, 57),
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 49, 54, 57),
        title: const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text('CV Form'),
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(),
                curve: Curves.easeIn,
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/test.jpg')
                    // child: ,
                    )),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ));
              },
              leading: const Icon(Icons.dashboard),
              title: const Text("dashboard"),
            ),
          ],
        ),
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
                        var gallery = await picker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 150,
                            maxWidth: 150);
                        if (gallery != null) {
                          setState(() {
                            // image = gallery;
                            // saveModel =SaveModel(imagepath: gallery.path);
                            image = File(gallery.path);
                            // the path keyword gets the path of the pickedimage
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
                            // image = camera;
                            // saveModel=SaveModel(imagepath: camera.path);
                            image = File(camera.path);
                          });
                          //
                        }
                      },
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Take a Picture')),
                ],
              ),
              image == null ? Container() : Image.file(image!),
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: const Text('Upload CV'),
                  onPressed: () async {
                    FilePickerResult? cvfile = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom, allowedExtensions: ['pdf']);
                    if (cvfile != null && cvfile.files.single.path != null) {
                      final pickedcv = File(cvfile.files.single.path!);
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final newpath =
                          '${directory.path}/${cvfile.files.single.name}';
                      await pickedcv.copy(newpath);
                      setState(() {
                        cv = pickedcv;
                        cvpath = newpath;

                        print('$cv');
                      });
                    } else {
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text('Signup successful'),
                      // ));
                    }
                  },
                ),
              ),
              cv == null ? Container() : const Text('CV Uploaded'),
              ElevatedButton(
                  onPressed: () async {
                    // final prefs = await SharedPreferences.getInstance();
                    if (_formKey.currentState!.validate() && dob != null) {
                      String? imagebase64;
                      if (image != null) {
                        List<int> imagesbytes = await image!.readAsBytes();
                        imagebase64 = base64Encode(imagesbytes);
                      }

                      if (cv != null) {
                        directorycv = await getApplicationDocumentsDirectory();
                        cvpath = '${directorycv.path}/cv.pdf';
                        await cv!.copy(cvpath!);
                      }
                      SaveModel model = SaveModel(
                        fullname: fullname.text,
                        maritalstatus: maritalstatus ?? '',
                        email: email.text,
                        dob: dob?.toIso8601String() ?? '',
                        password: password.text,
                        mobile: mobile.text,
                        gender: gender ?? '',
                        imagebase64: imagebase64,
                        cvpath: cvpath,
                      );
                      save(model);
                      setState(() {
                        fullname.clear();
                        gender = null;
                        dob = null;
                        mobile.clear();
                        maritalstatus = null;
                        email.clear();
                        password.clear();
                        image = null;
                        cv = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data Saved')),
                      );
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),

      ////
    );
  }
}
// Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Login(),
                      //     ));
                      //}
                      // if (_formKey.currentState!.validate() &&
                    //     dob != null &&
                    //     image != null) {
                    //   final directory =
                    //       await getApplicationDocumentsDirectory();
                    //   final imagepath = '${directory.path}/image.png';
                    //   await image!.copy(imagepath!);
                    //   await prefs.setString('imagepath', imagepath);

                    //   SaveModel model = SaveModel(
                    //     fullname: fullname.text,
                    //     maritalstatus: maritalstatus,
                    //     email: email.text,
                    //     dob: dob!.toString(),
                    //     password: password.text,
                    //     mobile: mobile.text,
                    //     gender: gender,
                    //     imagepath: image!.path,
                    //     cvpath: cv!.path,
                    //   );
                    //   save(model);

                    // }