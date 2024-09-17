import 'package:flutter/material.dart';
import 'package:flutter_codigo_taskdb/db/db_admin.dart';
import 'package:flutter_codigo_taskdb/models/task_model.dart';

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  State<MyFormWidget> createState() => _MyFormWidgetState();
}

bool isFinished = false;
final TextEditingController _titleController = TextEditingController();
final TextEditingController _DescriptionController = TextEditingController();

addTask() {
  TaskModel taskModel = TaskModel(
    title: _titleController.text,
    description: _DescriptionController.text,
    status: isFinished.toString(),
  );

  DbAdmin.db.insertTask(taskModel);
}

class _MyFormWidgetState extends State<MyFormWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Agregar Tarea'),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: _titleController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
            ),
            controller: _DescriptionController,
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text('Estado'),
              SizedBox(width: 6),
              Checkbox(
                value: isFinished,
                onChanged: (value) {
                  isFinished = value!;
                  setState(() {});
                },
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text('Guardar'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
