import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabula/data/repo/tabuladao_repository.dart';

class OyunSayfaCubit extends Cubit<void> {
  OyunSayfaCubit() : super(0);

  var krepo = TabulaDaoRepository();


}
