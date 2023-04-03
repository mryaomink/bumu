class Guest {
  final String? id;
  final String nama;
  final String instansi;
  final String keperluan;
  final String phoneNum;
  final String ditemui;
  final String jumlahTamu;
  final String keterangan;

  Guest(
      {required this.nama,
      required this.instansi,
      this.id,
      required this.keperluan,
      required this.phoneNum,
      required this.ditemui,
      required this.jumlahTamu,
      required this.keterangan});

  Guest copyWith(
      {String? nama,
      String? id,
      String? instansi,
      String? keperluan,
      String? phoneNum,
      String? ditemui,
      String? jumlahTamu,
      String? keterangan}) {
    return Guest(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        instansi: instansi ?? this.instansi,
        keperluan: keperluan ?? this.keperluan,
        phoneNum: phoneNum ?? this.phoneNum,
        ditemui: ditemui ?? this.ditemui,
        jumlahTamu: jumlahTamu ?? this.jumlahTamu,
        keterangan: keterangan ?? this.keterangan);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'instansi': instansi,
      'keperluan': keperluan,
      'phoneNum': phoneNum,
      'ditemui': ditemui,
      'jumlahTamu': jumlahTamu,
      'keterangan': keterangan,
    };
  }
}
