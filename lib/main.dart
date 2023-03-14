import 'package:flutter/material.dart';
import 'package:guest_book/screens/yao_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Tamu Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.amber,
      ),
      initialRoute: 'input',
      routes: {
        'input': (context) => const YaoForm(),
      },
    );
  }
}
