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
                return ListTile(
                  title: Text(myTask[index].title),
                  subtitle: Text(myTask[index].description),
                  trailing: Text(myTask[index].status),
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
