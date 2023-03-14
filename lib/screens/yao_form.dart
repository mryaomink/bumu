import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class YaoForm extends StatefulWidget {
  const YaoForm({super.key});

  @override
  State<YaoForm> createState() => _YaoFormState();
}

class _YaoFormState extends State<YaoForm> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _dataKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _ditemuiController = TextEditingController();
  final TextEditingController _jumlahTamuController = TextEditingController();
  final TextEditingController _ketController = TextEditingController();

  File? _docImage;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth! * 0.05,
              vertical: _deviceHeight! * 0.07),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                _titleWidget(),
                const SizedBox(
                  height: 20,
                ),
                _submitData(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "Buku Tamu\nDiskominfo BJB",
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _optionalText() {
    return const Text(
      'Optional',
      style: TextStyle(fontSize: 18.0, color: Colors.red),
    );
  }

  Widget _submitData() {
    return SizedBox(
      height: _deviceHeight! * 1,
      child: Form(
        key: _dataKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _nameTextField(),
            _asalTextField(),
            _keperluanTextField(),
            _phoneTextField(),
            _ditemuiTextField(),
            _jumlahTamuTextField(),
            _ketTextField(),
            const SizedBox(
              height: 20,
            ),
            _optionalText(),
            const SizedBox(
              height: 14,
            ),
            _addFoto(),
            const SizedBox(
              height: 20,
            ),
            _simpanData(),
          ],
        ),
      ),
    );
  }

  Widget _simpanData() {
    return MaterialButton(
      onPressed: _saveData,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.05,
      color: Colors.red,
      child: const Text(
        'Save',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400),
      ),
    );
  }

  // Fungsi Simpan Data Ke DB
  void _saveData() {
    if (_dataKey.currentState!.validate() && _docImage != null) {
      _dataKey.currentState!.save();
      print("Valid!");
    }
  }

  Widget _addFoto() {
    var imageDocProvider = _docImage != null
        ? FileImage(_docImage!)
        : const AssetImage('assets/images/paper.png');
    return GestureDetector(
      onTap: () {
        // fungsi untuk memilih dokument
        FilePicker.platform.pickFiles(type: FileType.any).then((result) {
          setState(() {
            _docImage = File(result!.files.first.path!);
          });
        });
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageDocProvider as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      controller: _namaController,
      decoration: const InputDecoration(
        hintText: "Nama",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Tolong Masukkan Nama Anda",
      onSaved: (newValue) {
        setState(() {
          _namaController.text = newValue!;
        });
      },
    );
  }

  Widget _asalTextField() {
    return TextFormField(
      controller: _asalController,
      decoration: const InputDecoration(
        hintText: "Asal Instansi",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Tolong Masukkan Instansi Anda",
      onSaved: (newValue) {
        setState(() {
          _asalController.text = newValue!;
        });
      },
    );
  }

  Widget _keperluanTextField() {
    return TextFormField(
      controller: _keperluanController,
      decoration: const InputDecoration(
        hintText: "Keperluan",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Data Tidak Boleh Kosong",
      onSaved: (newValue) {
        setState(() {
          _keperluanController.text = newValue!;
        });
      },
    );
  }

  Widget _phoneTextField() {
    return TextFormField(
      controller: _phoneNumController,
      decoration: const InputDecoration(
        hintText: "Nomor Telp.",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Data Tidak Boleh Kosong",
      onSaved: (newValue) {
        setState(() {
          _phoneNumController.text = newValue!;
        });
      },
    );
  }

  Widget _ditemuiTextField() {
    return TextFormField(
      controller: _ditemuiController,
      decoration: const InputDecoration(
        hintText: "Yang Ditemui",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Data Tidak Boleh Kosong",
      onSaved: (newValue) {
        setState(() {
          _ditemuiController.text = newValue!;
        });
      },
    );
  }

  Widget _jumlahTamuTextField() {
    return TextFormField(
      controller: _jumlahTamuController,
      decoration: const InputDecoration(
        hintText: "Jumlah Tamu",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Data Tidak Boleh Kosong",
      onSaved: (newValue) {
        setState(() {
          _jumlahTamuController.text = newValue!;
        });
      },
    );
  }

  Widget _ketTextField() {
    return TextFormField(
      controller: _ketController,
      maxLines: 3,
      decoration: const InputDecoration(
        hintText: "Keterangan",
      ),
      validator: (value) =>
          value!.isNotEmpty ? null : "Data Tidak Boleh Kosong",
      onSaved: (newValue) {
        setState(() {
          _ketController.text = newValue!;
        });
      },
    );
  }
}
