import 'package:flutter/material.dart';

class YaoSplash extends StatefulWidget {
  const YaoSplash({super.key});

  @override
  State<YaoSplash> createState() => _YaoSplashState();
}

class _YaoSplashState extends State<YaoSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3)).then(
      (value) => Navigator.pushNamed(context, 'input'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
