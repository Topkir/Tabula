import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabula/data/repo/tabuladao_repository.dart';

class SecimSayfaCubit extends Cubit<void> {
  SecimSayfaCubit() : super(0);

  var krepo = TabulaDaoRepository();

  Future<void> kaydet(
      double turSayisi, double saniye, double tabu, double pas) async {
    await krepo.kaydet(pas,tabu,turSayisi,saniye);
  }
}
