import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guest_book/model/guest.dart';

class YaoSubmit extends StatelessWidget {
  final Guest guest;
  const YaoSubmit({super.key, required this.guest});

  void _submit(BuildContext context) async {
    try {
      final docRef = await FirebaseFirestore.instance
          .collection('tamu')
          .add(guest.toMap());
      log('Data sudah disimpan: ${docRef.id} ');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'splash');
    } catch (e) {
      log("Error menambahkan data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _submit(context),
      child: const Text('Submit'),
    );
  }
}
