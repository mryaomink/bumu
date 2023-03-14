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
    required File imgDoc,
  }) async {
    try {
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(imgDoc.path);
      UploadTask task = _strorage.ref('dokument/$fileName').putFile(imgDoc);
      return task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection("dataTamu").doc().set({
          "nama": nama,
          "instansi": asal,
          "keperluan": keperluan,
          "no.telp": phoneNum,
          "diTemui": diTemui,
          "jumlah Tamu": jumTamu,
          "keterangan": ket,
          "dokument": downloadUrl,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }
}
