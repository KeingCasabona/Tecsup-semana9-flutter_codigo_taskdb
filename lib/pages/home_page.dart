import 'package:flutter/material.dart';
import 'package:flutter_codigo_taskdb/db/db_admin.dart';
import 'package:flutter_codigo_taskdb/models/task_model.dart';
import 'package:flutter_codigo_taskdb/widgets/my_form_widget.dart';
//import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  showDialogForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyFormWidget();
      },
    );
  }

  deleteTask(int taskId) {
    DbAdmin.db.deleteTask(taskId).then(
      (value) {
        if (value > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: 20,
                left: 10,
                right: 10,
              ),
              content: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Tarea eliminada',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogForm(context);
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: DbAdmin.db.getTask(),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            List<TaskModel> myTask = asyncSnapshot.data;
            return ListView.builder(
              itemCount: myTask.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: UniqueKey(),
                  // confirmDismiss: (DismissDirection direction) async {
                  //   print(direction);
                  //   return true;
                  // },
                  direction: DismissDirection.startToEnd,
                  background: Container(color: Colors.red),
                  //secondaryBackground: Text('2'),
                  onDismissed: (DismissDirection direction) {
                    deleteTask(myTask[index].id!);
                  },
                  child: ListTile(
                    title: Text(myTask[index].title),
                    subtitle: Text(myTask[index].description),
                    leading: Text(myTask[index].id.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        showDialogForm(context);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
