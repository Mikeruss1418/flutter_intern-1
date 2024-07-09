import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
      home: Imagepicker(),
    );
  }
}

class Imagepicker extends StatefulWidget {
  const Imagepicker({super.key});

  @override
  State<Imagepicker> createState() => _HomeState();
}

class _HomeState extends State<Imagepicker> {
  //
  ImagePicker picker = ImagePicker();
  //
  var savedimage;
  var savedfromgallery;
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter sign up and Login'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: fullname,
            decoration: const InputDecoration(
              label: Text('Fullname'),
              // border: OutlineInputBorder(),
              // enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(),
            ),
          ),
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () async {
                  XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    savedimage = image;
                  });
                },
                child: const Text('capture image from camera'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    XFile? gallery =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      savedfromgallery = gallery;
                    });
                  },
                  child: const Text('Images from gallery')),
              ElevatedButton(
                  onPressed: () async {
                    XFile? video =
                        await picker.pickVideo(source: ImageSource.camera);
                  },
                  child: const Text("video from camera")),
              ElevatedButton(
                  onPressed: () async {
                    XFile? galleryvideo = await picker.pickVideo(
                        source: ImageSource.gallery,
                        maxDuration: const Duration(seconds: 10));
                  },
                  child: const Text('video from gallery')),
              ElevatedButton(
                  onPressed: () async {
                    XFile? imageorvideo = await picker.pickMedia();
                  },
                  child: const Text('Single image or video')),

              //for multiples
              ElevatedButton(
                  onPressed: () async {
                    List<XFile> multiimage = await picker.pickMultiImage();
                  },
                  child: const Text('Multiple image')),

              ElevatedButton(
                  onPressed: () async {
                    List<XFile> multimedia =
                        await picker.pickMultipleMedia(limit: 10);
                  },
                  child: const Text('Multiple image and videos'))
            ],
          ),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
              label: Text('Email'),
              // border: OutlineInputBorder(),
              // enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(),
            ),
          ),
          Wrap(
            children: [
              TextButton(
                  onPressed: () async {
                    FilePickerResult? filepick = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom, allowedExtensions: ['pdf'],
                             );
                    if (filepick != null) {
                      File file = File(filepick.files.single.path!);
                    } else {
                      print('Not Selected');
                    }
                  },
                  child: const Text('single File picker')),
              TextButton(
                  onPressed: () async {
                    FilePickerResult? multifilepicker =
                        await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['pdf']);
                    if (multifilepicker != null) {
                      List<File> multifiles =
                          multifilepicker.paths.map((e) => File(e!)).toList();
                    }
                  },
                  child: const Text('Multiple files')),
              TextButton(
                  onPressed: () async {
                    var selectDirectory =
                        await FilePicker.platform.getDirectoryPath();
                    if (selectDirectory == null) {
                      print('no directory');
                    }
                  },
                  child:
                      const Text('Directory')) //allows you to select directory
            ],
          )
        ],
      ),
    );
  }
}
