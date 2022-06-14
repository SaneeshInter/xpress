import 'package:rxdart/rxdart.dart';
import '../resources/respository.dart';

import '../model/utility_respo.dart';

class UtilityBloc {
  final _repo = Repository();
  final _utilbloc = PublishSubject<UtilityResop>();

  Stream<UtilityResop> get utilStream => _utilbloc.stream;

  fetchUtility() async {
    UtilityResop respo = await _repo.fetchUtility();
    _utilbloc.sink.add(respo);
  }

  dispose() {
    _utilbloc.close();
  }
}
final utility_bloc = UtilityBloc();
