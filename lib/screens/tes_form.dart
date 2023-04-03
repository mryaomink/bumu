import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guest_book/model/yao_user.dart';

class TesForm extends StatefulWidget {
  const TesForm({super.key});

  @override
  State<TesForm> createState() => _TesFormState();
}

class _TesFormState extends State<TesForm> {
  final _formKey1 = GlobalKey<FormState>();
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _alamatC = TextEditingController();

  YaoUser user = YaoUser(
    email: '',
    alamat: '',
  );

  void _updateUser() {
    if (_formKey1.currentState!.validate()) {
      setState(() {
        user = YaoUser(
          email: _emailC.text.trim(),
          alamat: _alamatC.text.trim(),
        );
      });
      FirebaseFirestore.instance
          .collection('tamu')
          .doc(user.email)
          .set(user.toMap());
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
              'Name: ${user.email}',
            ),
            Text(
              'Email: ${user.alamat}',
            ),
            Form(
              key: _formKey1,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailC,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap di isi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _alamatC,
                    decoration: const InputDecoration(labelText: 'Alamat'),
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
