import 'package:flutter/material.dart';
import 'package:guest_book/model/guest.dart';
import 'package:guest_book/model/yao_user.dart';
import 'package:guest_book/screens/yao_input.dart';

class GuestUtama extends StatefulWidget {
  const GuestUtama({super.key});

  @override
  State<GuestUtama> createState() => _GuestUtamaState();
}

class _GuestUtamaState extends State<GuestUtama> {
  late Guest guest;
  late YaoUser user;
  @override
  void initState() {
    guest = Guest(
        nama: '',
        instansi: '',
        keperluan: '',
        phoneNum: '',
        ditemui: '',
        jumlahTamu: '',
        keterangan: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PageView(children: [])),
    );
  }
}
