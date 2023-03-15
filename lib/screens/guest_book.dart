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
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _ditemuiController = TextEditingController();
  final TextEditingController _jumTamuController = TextEditingController();
  final TextEditingController _ketController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Tamu'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _asalController,
                  decoration: const InputDecoration(labelText: 'Asal Instansi'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _keperluanController,
                  decoration: const InputDecoration(labelText: 'Keperluan'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _nomorController,
                  decoration: const InputDecoration(labelText: 'No.Telp'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _ditemuiController,
                  decoration: const InputDecoration(labelText: 'yang ditemui'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _jumTamuController,
                  decoration: const InputDecoration(labelText: 'Jumlah Tamu'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _ketController,
                  decoration: const InputDecoration(labelText: 'Keterangan'),
                ),
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
                    'nama': _namaController.text,
                    'instansi': _asalController.text,
                    'keperluan': _keperluanController.text,
                    'nomor': _nomorController.text,
                    'ditemui': _ditemuiController.text,
                    'jumlahtamu': _jumTamuController.text,
                    'keterangan': _ketController.text,
                    'imageUrl': imageUrl,
                    'timestamp': DateTime.now(),
                  };

                  final collectionRef =
                      FirebaseFirestore.instance.collection('my_guest');
                  await collectionRef.add(formData);
                  _namaController.clear();
                  _asalController.clear();
                  _keperluanController.clear();
                  _nomorController.clear();
                  _ditemuiController.clear();
                  _jumTamuController.clear();
                  _ketController.clear();
                  setState(() {
                    file = null;
                  });
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
