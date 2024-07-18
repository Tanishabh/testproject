import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'languageScreenTwo.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          child: LocaleText("Welcome"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LanguageScreenTwo())),
        child: Icon(Icons.language),
      ),
    );
  }
}
