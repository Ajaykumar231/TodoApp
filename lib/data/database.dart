import 'package:hive/hive.dart';

class ToDODataBase {
  List toDOList = [];
  //reference our box

  final _myBox = Hive.box('mybox');

  //run this method if this is the first time ever opening this app
  void createInitialData() {
    toDOList = [
      ['Make TUtorial', false,],
      ['DO exercise', false,]
    ];
  }

  //load the data from database
  void loadData() {
    toDOList = _myBox.get("TODOLIST");
  }

  //update the data to database
  void updateDataDase() {
    _myBox.put("TODOLIST", toDOList);
  }
}
