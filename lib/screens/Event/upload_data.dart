import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaldindi/Widgets/widget.dart';

class UploadEventData extends StatefulWidget {
  const UploadEventData({super.key, this.onUploaded, required this.title});

  final Function? onUploaded;
  final String title;

  @override
  State<UploadEventData> createState() => _UploadEventDataState();
}

class _UploadEventDataState extends State<UploadEventData> {
  String filename = "";
  final subjectController = TextEditingController();
  final titleController = TextEditingController();
  FilePickerResult? filePickerResult;
  double _progress = 0;
  File? pickedFile;
  late Uint8List fileBytes;

  Future<void> _openFileExplorer() async {
    try {
      filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      setState(
        () {
          if (kIsWeb) {
            fileBytes = filePickerResult!.files.first.bytes!;
          } else {
            pickedFile = File(filePickerResult!.files.single.path!);
          }
          filename = File(filePickerResult!.files.single.name).toString();
        },
      );
    } catch (e) {
      // print('Error picking files: $e');
    }
  }

  _uploadDataToStorage() {
    if (filename == "") {
      _addDataToFirestore();
    } else {
      final metadata = SettableMetadata(contentType: "image/jpeg");
      final storageRef = FirebaseStorage.instance.ref();
      if (kIsWeb) {
        final uploadTask =
            storageRef.child("${widget.title}/$filename").putData(fileBytes, metadata);
        uploadTask.snapshotEvents.listen(
          (TaskSnapshot taskSnapshot) async {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress = 100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                setState(
                  () {
                    _progress = progress;
                  },
                );
                break;
              case TaskState.paused:
                showSnackBar("Paused", context, Icons.error, Colors.red);
                break;
              case TaskState.canceled:
                showSnackBar(
                    "Upload Was Cancelled", context, Icons.error, Colors.red);
                break;
              case TaskState.error:
                showSnackBar(
                    "Something Gone Wrong!", context, Icons.error, Colors.red);
                break;
              case TaskState.success:
                _addDataToFirestore();
                showSnackBar("Uploaded", context, Icons.done, Colors.green);
                break;
            }
          },
        );
      } else {
        final uploadTask =
            storageRef.child("${widget.title}/$filename").putFile(pickedFile!, metadata);
        uploadTask.snapshotEvents.listen(
          (TaskSnapshot taskSnapshot) async {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress = 100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                setState(
                  () {
                    _progress = progress;
                  },
                );
                break;
              case TaskState.paused:
                showSnackBar("Paused", context, Icons.error, Colors.red);
                break;
              case TaskState.canceled:
                showSnackBar(
                    "Upload Was Cancelled", context, Icons.error, Colors.red);
                break;
              case TaskState.error:
                showSnackBar(
                    "Something Gone Wrong!", context, Icons.error, Colors.red);
                break;
              case TaskState.success:
                _addDataToFirestore();
                showSnackBar("Uploaded", context, Icons.done, Colors.green);
                break;
            }
          },
        );
      }
    }
  }

  _addDataToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    if (filename == "" && widget.title=='Event') {
      firestore.collection("${widget.title} Upload").doc(DateTime.now().toString()).set(
        {
          "name": auth.currentUser!.uid,
          "title": titleController.text,
          "message": subjectController.text,
          "file location": "",
          "timestamp": DateTime.now().toString(),
        },
      );
    } else {
      final storageRef = FirebaseStorage.instance.ref();
      final imageUrl =
          await storageRef.child("${widget.title}/$filename").getDownloadURL();

      firestore.collection("${widget.title} Upload").doc(DateTime.now().toString()).set(
        {
          "name": auth.currentUser!.uid,
          "title": titleController.text,
          "message": subjectController.text,
          "file location": imageUrl,
          "timestamp": DateTime.now().toString(),
        },
      );
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload ",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upload ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontFamily: 'Rubik'),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _openFileExplorer();
                          },
                          icon: const Icon(
                            Icons.attach_file_outlined,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _uploadDataToStorage();
                          },
                          icon: const Icon(
                            Icons.arrow_circle_up_rounded,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BorderedTextField(
                  maxContentLines: 1,
                  hintText: "Title of Notice",
                  labelText: "Title",
                  fieldController: titleController),
              BorderedTextField(
                  maxContentLines: 15,
                  hintText: "Details",
                  labelText: "Message",
                  fieldController: subjectController),
              const SizedBox(height: 16.0),
              if (_progress > 0)
                LinearProgressIndicator(
                  value: _progress,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
