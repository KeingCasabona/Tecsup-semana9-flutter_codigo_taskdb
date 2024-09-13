import 'package:flutter/material.dart';
import 'package:flutter_codigo_taskdb/db/db_admin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.getTask();
              },
              child: Text('Mostrar data'),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.insertTask();
              },
              child: Text('Insertar Tarea'),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.updateTask();
              },
              child: Text('Actualizar Tarea'),
            ),
            ElevatedButton(
              onPressed: () {
                DbAdmin.db.deleteTask();
              },
              child: Text('Eliminar Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
