import 'package:flutter/material.dart';
import 'package:tabula/ui/views/secim_sayfa.dart';

import 'oyun_sayfa.dart';

class Anasayfa extends StatefulWidget {
  Anasayfa(
      {required this.saniye,
      // required this.turSayisi,
      required this.tabu,
      required this.pas});
  int? saniye;
  // int? turSayisi;
  int? tabu;
  int? pas;

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.amber[500],
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecimSayfa(),
                  ));
            },
            child: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.amber[500],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.amber[500],
          //color: Color.fromRGBO(80, 60, 93, 25)
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              const Text(
                'TABULA',
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.white,
                    fontFamily: 'MadimiOne',
                    letterSpacing: 10),
              ),
              const Text(
                'ANLAT BAKALIM',
                style: TextStyle(
                    height: 1,
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'MadimiOne',
                    letterSpacing: 5),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset('asset/image/card.png'),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Navigator.push kullanarak SecimSayfa'yı aç ve dönen değeri sakla
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OyunSayfa(
                        saniye: widget.saniye!.toDouble(),
                        // turSayisi: widget.turSayisi!.toDouble(),
                        tabu: widget.tabu!.toDouble(),
                        pas: widget.pas!.toDouble(),
                        turMin: 1,
                      ),
                    ),
                  );

                  // Eğer result null değilse (yani geri dönüş yapıldıysa) ve result bir liste ise:
                  if (result != null && result is List<double>) {
                    // İlgili değerleri al ve Anasayfa'ya değerine ata
                    setState(() {
                      // widget.turSayisi =
                      //     result[0].toInt(); // Tur değeri index 0'da
                      widget.saniye =
                          result[1].toInt(); // Saniye değeri index 1'de
                      widget.tabu = result[2].toInt(); // Tabu değeri index 2'de
                      widget.pas = result[3].toInt(); // Pas değeri index 3'te
                    });
                  }
                },
                child: Text('BAŞLA',
                    style: TextStyle(
                        fontFamily: 'MadimiOne',
                        letterSpacing: 10,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
