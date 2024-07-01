import 'package:flutter/material.dart';
import 'package:tabula/ui/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Anasayfa': (context) => Anasayfa(
              saniye: 120,
              tabu: 3,
              pas: 3,
            ),
      },
      debugShowCheckedModeBanner: false,
      title: 'Tabula',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Anasayfa(
        // Anasayfa Başlat butonunda bastığımızda Oyun Sayfasına atanan default değerler.
        tabu: 3,
        saniye: 120, //120 olacak
        pas: 3,
      ),
    );
  }
}
