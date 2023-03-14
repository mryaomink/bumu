import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guest_book/screens/yao_form.dart';
import 'package:get_it/get_it.dart';
import 'package:guest_book/screens/yao_splash.dart';
import 'package:guest_book/service/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
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
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const YaoSplash(),
        'input': (context) => const YaoForm(),
      },
    );
  }
}
