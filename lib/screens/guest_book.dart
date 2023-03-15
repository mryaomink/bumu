import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GuestBook extends StatefulWidget {
  const GuestBook({super.key});

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  html.File? file;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Tamu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                html.FileUploadInputElement uploadInput =
                    html.FileUploadInputElement();
                uploadInput.click();

                uploadInput.onChange.listen((event) {
                  final file = uploadInput.files!.first;
                  setState(() {
                    this.file = file;
                  });
                });
              },
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            if (file != null)
              Image.network(html.Url.createObjectUrlFromBlob(file!),
                  height: 150),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (file == null) return;
                final storageRef =
                    firebase_storage.FirebaseStorage.instance.ref();
                final imageRef = storageRef
                    .child('images/${DateTime.now().millisecondsSinceEpoch}');
                final uploadTask = imageRef.putBlob(file!);

                final snapshot = await uploadTask.whenComplete(() {});
                final imageUrl = await snapshot.ref.getDownloadURL();

                final formData = {
                  'title': _titleController.text,
                  'description': _descriptionController.text,
                  'imageUrl': imageUrl,
                  'timestamp': DateTime.now(),
                };

                final collectionRef =
                    FirebaseFirestore.instance.collection('my_guest');
                await collectionRef.add(formData);
                _titleController.clear();
                _descriptionController.clear();
                setState(() {
                  file = null;
                });
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
