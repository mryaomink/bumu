import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guest_book/model/guest.dart';

class YaoInput extends StatefulWidget {
  const YaoInput({
    super.key,
  });

  @override
  State<YaoInput> createState() => _YaoInputState();
}

class _YaoInputState extends State<YaoInput> {
  final _formKey = GlobalKey<FormState>();

  Guest guest = Guest(
      nama: '',
      instansi: '',
      keperluan: '',
      phoneNum: '',
      ditemui: '',
      jumlahTamu: '',
      keterangan: '');
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _ditemuiController = TextEditingController();
  final TextEditingController _jumlahTamuController = TextEditingController();
  final TextEditingController _ketController = TextEditingController();

  void _updateUser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        guest = Guest(
            nama: _namaController.text.trim(),
            instansi: _asalController.text.trim(),
            keperluan: _keperluanController.text.trim(),
            phoneNum: _phoneNumController.text.trim(),
            ditemui: _ditemuiController.text.trim(),
            jumlahTamu: _jumlahTamuController.text.trim(),
            keterangan: _ketController.text.trim());
      });
      FirebaseFirestore.instance
          .collection('tamu')
          .doc(guest.id)
          .set(guest.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Name: ${guest.nama}',
            ),
            Text(
              'Email: ${guest.instansi}',
            ),
            Text(
              'Phone Number: ${guest.keperluan}',
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _asalController,
                    decoration: const InputDecoration(labelText: 'instansi'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _keperluanController,
                    decoration: const InputDecoration(labelText: 'Keperluan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumController,
                    decoration: const InputDecoration(labelText: 'No.Telp'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ditemuiController,
                    decoration: const InputDecoration(labelText: 'ditemui'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _jumlahTamuController,
                    decoration:
                        const InputDecoration(labelText: 'Jumlah Bertamu'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ketController,
                    decoration: const InputDecoration(labelText: 'Keterangan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _updateUser,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
