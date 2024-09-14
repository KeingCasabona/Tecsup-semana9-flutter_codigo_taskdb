import 'package:flutter/material.dart';
import 'package:flutter_codigo_taskdb/db/db_admin.dart';
import 'package:flutter_codigo_taskdb/models/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
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
