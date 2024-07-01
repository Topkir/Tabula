import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class OyunSayfa extends StatefulWidget {
  final double saniye;
  late double tabu;
  late double pas;
  late double turMin;

  OyunSayfa({
    required this.saniye,
    required this.tabu,
    required this.pas,
    required this.turMin,
  });

  @override
  State<OyunSayfa> createState() => _OyunSayfaState();
}

class _OyunSayfaState extends State<OyunSayfa> with TickerProviderStateMixin {
  int resimSayi = 1;
  int dogruSayisi = 0;
  List<int> gorulenSayilar = [];

  Duration _saniye = Duration.zero;
  late Timer _timer;
  late AnimationController controller;
  bool isPaused = false;

  void _yeniKartSec() {
    setState(() {
      if (gorulenSayilar.length == 21) {
        gorulenSayilar = [];
      }

      int yeniSayi;
      while (true) {
        yeniSayi = Random().nextInt(21) + 1;
        if (!gorulenSayilar.contains(yeniSayi)) {
          gorulenSayilar.add(yeniSayi);
          resimSayi = yeniSayi;
          break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.saniye.toInt()),
    )..addListener(() {
        setState(() {});
      });

    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!isPaused && _saniye.inSeconds < widget.saniye) {
          _saniye += const Duration(seconds: 1);
          controller.value =
              _saniye.inSeconds / widget.saniye; // İlerleme yüzdesini güncelle
        } else if (!isPaused && _saniye.inSeconds == widget.saniye) {
          turBitir();
        }
      });
    });
  }

  void turBitir() {
    _timer.cancel();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Süre Bitti', textAlign: TextAlign.center),
          content: Text('Tebrikler Toplam: $dogruSayisi Kelime Bildiniz'),
          actions: [
            TextButton(
              onPressed: () {
                print('Anasayfa ya dönüldü');
                var Anasayfa =
                    '/Anasayfa'; // Rotanın adını doğrudan string olarak belirtin
                Navigator.pushNamed(context,
                    Anasayfa); // pushNamed fonksiyonuna rotanın adını doğru bir şekilde verin
              },
              child: const Text('Ana Sayfa', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.amber, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Skor',
                          style: TextStyle(height: 0, fontSize: 20),
                        ),
                        Text(
                          '$dogruSayisi',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 110.0,
                        height: 110.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned.fill(
                        child: CircularProgressIndicator(
                          strokeWidth: 8,
                          value: controller.value,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.shade500),
                          backgroundColor: Colors.lightGreen.shade300,
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            (widget.saniye - (_saniye.inSeconds)).toStringAsFixed(0),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPaused = !isPaused;
                        if (isPaused) {
                          controller.stop();
                        } else {
                          controller
                            ..forward(from: controller.value)
                            ..repeat();
                        }
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          isPaused ? 'Devam Et' : 'Mola',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Image(
                image: AssetImage('asset/image/words/kelime$resimSayi.png'),
              ),
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (widget.tabu > 0) {
                            widget.tabu--;
                            resimSayi = Random().nextInt(21) + 1;
                            //resimSayi = (resimSayi % 7) + 1;
                          }
                        });
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                        elevation: MaterialStatePropertyAll(15),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.only(left: 30, right: 30)),
                      ),
                      child: Text(
                        'TABU ${widget.tabu.toInt()}',
                        style: const TextStyle(color: Colors.white, letterSpacing: 2),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (widget.pas > 0) {
                            widget.pas--;
                            resimSayi = Random().nextInt(21) + 1;
                          }
                        });
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.grey),
                        elevation: MaterialStatePropertyAll(15),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.only(left: 35, right: 35)),
                      ),
                      child: Text(
                        'PAS (${widget.pas.toInt()})',
                        style: const TextStyle(color: Colors.white, letterSpacing: 2),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          dogruSayisi++;
                          _yeniKartSec();
                        });
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                        elevation: MaterialStatePropertyAll(15),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.only(left: 25, right: 25)),
                      ),
                      child: const Text(
                        'DOĞRU',
                        style: TextStyle(color: Colors.white, letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
