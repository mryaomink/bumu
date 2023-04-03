class YaoUser {
  final String email;
  final String alamat;

  YaoUser({required this.email, required this.alamat});
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'alamat': alamat,
    };
  }
}
