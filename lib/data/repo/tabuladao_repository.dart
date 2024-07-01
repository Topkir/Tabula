class TabulaDaoRepository {

  Future<void> kaydet(double pas, double tabu, double turSayisi, double saniye) async {
    var degerler = Map<String,dynamic>();
    degerler['pas'] = pas;
    degerler['tabu'] = tabu;
    degerler['turSayisi'] = turSayisi;
    degerler['saniye'] = saniye;
  }




}