import 'dart:io';

// import 'package:day5/models/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, required this.filepath});
final String filepath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View CV'),
      ),
      body: SfPdfViewer.file(File(filepath)),
    );
  }
}


