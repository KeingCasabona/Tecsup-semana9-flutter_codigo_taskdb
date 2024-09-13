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
        child: ElevatedButton(
          onPressed: () {
            DbAdmin.db.initDatabase();
          },
          child: Text('Mostrar data'),
        ),
      ),
    );
  }
}
