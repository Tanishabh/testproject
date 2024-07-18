import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LanguageScreenTwo extends StatefulWidget {
  const LanguageScreenTwo({super.key});

  @override
  State<LanguageScreenTwo> createState() => _LanguageScreenTwoState();
}

class _LanguageScreenTwoState extends State<LanguageScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("language"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("English"),
            onTap: () {
              Future.delayed(Duration.zero, () {
                LocaleNotifier.of(context)!.change("en");
              });
            },
          ),
          ListTile(
            title: Text("स्वागत"),
            onTap: () {
              Future.delayed(Duration.zero, () {
                LocaleNotifier.of(context)!.change("hn");
              });
            },
          ),
        ],
      ),
    );
  }
}
