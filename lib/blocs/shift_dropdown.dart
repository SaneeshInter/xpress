import 'package:rxdart/rxdart.dart';

class PersonBloc{

List<String> names = ['Male','Female'];

final _getmanager = PublishSubject<List<String>>();


Stream<List<String>> get genderStrem => _getmanager.stream;

final _name = BehaviorSubject<String>.seeded("");
Stream<String> get outName  => _name.stream;
Function(String) get inName => _name.sink.add;
//TODO - Don't forget to dispose this _name

  addItem() async {
    _getmanager.add(names);

  }


  dispose() {
    _name.close();
  }
}

final   dropdownBloc= PersonBloc();