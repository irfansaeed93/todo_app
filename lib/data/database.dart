import 'package:hive/hive.dart';

class ToDoDataBase{
  final _mybox = Hive.box('mybox');

  List toDoList = [];

  void createInitialData(){
    // list of to do tasks
    List toDoList = [
      ['Make Tutorial', false],
      ['Do Excercise', false],
    ];
  }

  void loadData(){
    toDoList = _mybox.get('TODOLIST');
  }


  void updateDataBase(){
    _mybox.put('TODOLIST', toDoList);
  }

}