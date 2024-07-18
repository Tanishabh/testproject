import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pod_player/pod_player.dart';
import 'package:testproject/geo_tagging/photo_location.dart';
import 'package:testproject/languageDir/languageScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en','hn']);
  PodVideoPlayer.enableLogs = true;
  runApp(const MyApp());
}
double height = 0.0;
double width = 0.0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = kIsWeb ? 380 : MediaQuery.of(context).size.width;
    return LocaleBuilder(
        builder: (locale) => MaterialApp(
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          title: "flutterr",
          debugShowCheckedModeBanner: false,
          home: LanguagePage(),

        )
    );
  }
}


