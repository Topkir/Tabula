import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabula/ui/views/anasayfa.dart';
import '../cubit/secim_sayfa_cubit.dart';

class SecimSayfa extends StatefulWidget {
  const SecimSayfa({super.key});

  @override
  State<SecimSayfa> createState() => _SecimSayfaState();
}

class _SecimSayfaState extends State<SecimSayfa> {
  //SecimSayfa Slider default değerler.
  double turSayisi = 5;
  double saniye = 120;
  double tabu = 3;
  double pas = 3;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white30,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage(
                    'asset/image/secimLogin.png',
                  ),
                  centerSlice: Rect.fromCenter(center: Offset.zero, width: double.minPositive, height: CircularProgressIndicator.strokeAlignCenter)
              ),
            ),
            height: 100,
          ),

          Column(
            children: [
              const Positioned(
                child: Center(
                  child: Text('Ayarlar',style: TextStyle(fontSize: 40,)),
                ),
              ),

              const Padding(
                // Ayarlar yazısı ile tabu yazısı arasındaki yükseklik ve tabu genişliği ayarlar.
                padding: EdgeInsets.only(right: 300,top: 150),
                child: Text(
                  'TABU',
                  style: TextStyle(
                    fontFamily: 'MadimiOne',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Slider.adaptive(
                      min: 1,
                      max: 10,
                      value: tabu.toDouble(),
                      divisions: 9,
                      activeColor: const Color.fromRGBO(67, 69, 74, 5),
                      onChanged: (double newValue) {
                        setState(() {
                          tabu = newValue;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${tabu.round()}',
                      style: const TextStyle(
                        height: 3,
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'MadimiOne',
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(right: 300),
                child: Text(
                  'SÜRE',
                  style: TextStyle(
                    fontFamily: 'MadimiOne',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Slider.adaptive(
                      min: 30,
                      max: 180,
                      value: saniye.toDouble(),
                      divisions: 5,
                      activeColor: const Color.fromRGBO(67, 69, 74, 5),
                      onChanged: (double newValue) {
                        setState(() {
                          saniye = newValue;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${saniye.round()}',
                      style: const TextStyle(
                        height: 3,
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'MadimiOne',
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ],
              ),
              /*const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(right: 300),
                child: Text(
                  'TUR',
                  style: TextStyle(
                    fontFamily: 'MadimiOne',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Slider.adaptive(
                      min: 1,
                      max: 10,
                      value: turSayisi.toDouble(),
                      divisions: 9,
                      activeColor: Color.fromRGBO(67, 69, 74, 5),
                      onChanged: (double newValue) {
                        setState(() {
                          turSayisi = newValue;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${turSayisi.round()}',
                      style: TextStyle(
                        height: 3,
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'MadimiOne',
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ],
              ),*/
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(right: 300),
                child: Text(
                  'PAS',
                  style: TextStyle(
                    fontFamily: 'MadimiOne',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Slider.adaptive(
                      min: 1,
                      max: 10,
                      value: pas.toDouble(),
                      divisions: 9,
                      activeColor: const Color.fromRGBO(67, 69, 74, 5),
                      onChanged: (double newValue) {
                        setState(() {
                          pas = newValue;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${pas.round()}',
                      style: const TextStyle(
                        height: 3,
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'MadimiOne',
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Değerleri geri döndür
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Anasayfa(
                saniye: saniye.toInt(),
                // turSayisi: turSayisi.toInt(),
                tabu: tabu.toInt(),
                pas: pas.toInt(),
              ),
            ),
          ).then((value) {
            context.read<SecimSayfaCubit>().kaydet(
              turSayisi,
              saniye,
              tabu,
              pas,
            );
          });
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.check),
      ),
    );
  }
}
