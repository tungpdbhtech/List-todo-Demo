import 'package:flutter/material.dart';
import 'package:todolist_app/todo.dart';
import 'package:todolist_app/todocard.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
   List<Todo> todos = [
    Todo(title: 'Task 1', isDone: false),
    Todo(title: 'Task 2', isDone: true),
    Todo(title: 'Task 3', isDone: false),
    Todo(title: 'Task 4', isDone: false),
    Todo(title: 'Task 5', isDone: true),
    Todo(title: 'Task 6', isDone: false),
    
  ];
  
    @override
  void initState() {
    super.initState();
    _sortTodos();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoCard(
            key: Key('$index'), 
            title: todos[index].title,
            isSelected: todos[index].isDone,
            onDelete: () {
              setState(() {
                todos.removeAt(index);
              });
            },
            onTitleChanged: (newTitle) {
              setState(() {
                todos[index].title = newTitle; 
              });
            },
              toggleItem: () {
              setState(() {
                todos[index].isDone = !todos[index].isDone ;
                 _sortTodos();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewTaskDialog(BuildContext context) {
    String newTaskTitle = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            onChanged: (value) {
              newTaskTitle = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter task title',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (newTaskTitle.isNotEmpty) {
                    todos.add(Todo(title: newTaskTitle, isDone: false));  
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

   void _sortTodos() {
    todos.sort((a, b) {
      if (a.isDone && !b.isDone) {
        return 1;
      } else if (!a.isDone && b.isDone) {
        return -1;
      } else {
        return 0;
      }
    });
  }

}
