import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  // hive box
  final _mybox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // to create default data on first time open
    if(_mybox.get('TODOLIST') == null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  // controller
  final _controller = TextEditingController();



// when the checkbox is tapped do this
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = ! db.toDoList[index][1];
    });
    db.updateDataBase();

  }

  // save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask(){
    showDialog(context: context, builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: ()=> Navigator.of(context).pop(),
        );
    },);
  }

  // delete task
  void deleteTask(int index){
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
         backgroundColor: Colors.yellow,
         title: Text('To Do')
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: createNewTask,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 35,),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                      taskName: db.toDoList[index][0],
                      taskCompleted: db.toDoList[index][1],
                      onChanged: (value) => checkBoxChanged(value, index),
                      deleteFunction: (context) => deleteTask(index),

          );
        },






      ),
    );
  }
}