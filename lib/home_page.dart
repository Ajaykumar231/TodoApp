import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/dialog_box.dart';
import 'package:todoapp/utils/todo_title.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Reference the Hive box
  final _myBox = Hive.box('mybox');
  ToDODataBase db = ToDODataBase();

  @override
  void initState() {
    // If this is the first time ever opening this app, create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // There already exists data
      db.loadData();
    }
    super.initState();
  }

  // Text controller
  final _controller = TextEditingController();

  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDOList[index][1] = !db.toDOList[index][1];
    });
    db.updateDataDase();
  }

  // Save New Task
  void saveNewTask() {
    setState(() {
      db.toDOList.add([_controller.text, false,]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataDase();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancle: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDOList.removeAt(index);
    });
    db.updateDataDase();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Center(child: Text('TO DO')),
        backgroundColor: Colors.blue[200],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: LiquidPullToRefresh(
        color: Colors.blue.shade200,
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: db.toDOList.length,
          itemBuilder: (context, index) {
              return ToDoTitle(
                taskName: db.toDOList[index][0],
            taskCompleted: db.toDOList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
              );
          },
        ),
      ),
    );
  }
}
