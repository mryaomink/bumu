import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseService {
  final FirebaseStorage _strorage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();

  Future<bool> upDatabase({
    required String nama,
    required String asal,
    required String keperluan,
    required String phoneNum,
    required String diTemui,
    required String jumTamu,
    required String ket,
    File? imgDoc,
  }) async {
    try {
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(imgDoc!.path);
      UploadTask task = _strorage.ref('dokument/$fileName').putFile(imgDoc);
      return task.then((snapshot) async {
        // String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection("datatamu").doc().set({
          "nama": nama,
          "instansi": asal,
          "keperluan": keperluan,
          "notelp": phoneNum,
          "ditemui": diTemui,
          "jumlahtamu": jumTamu,
          "keterangan": ket,
          // "dokumen": downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }
}
