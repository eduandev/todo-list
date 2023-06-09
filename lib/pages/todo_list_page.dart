import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';


class TodoListPage extends StatefulWidget {
     TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;
  String? errorText;

  @override
  void initState() {
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Adicione uma tarefa',
                          errorText: errorText,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String text = todoController.text;

                          if(text.isEmpty) {
                            setState(() {
                              errorText = 'Preencha o campo!';
                            });
                            return;
                          }

                          setState(() {
                            Todo newTodo = Todo(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                            todos.add(newTodo);
                            errorText = null;
                          });
                          todoController.clear();
                          todoRepository.saveTodoList(todos);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff00d7f3),
                          padding: EdgeInsets.all(16),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                        ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                     for(Todo todo in todos)
                       TodoListItem(
                         todo: todo,
                         onDelete: onDelete,
                       ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefa pendente!',
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeleteAllConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14),
                      ),
                      child: Text(
                        'Limpar tudo'
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);

ScaffoldMessenger.of(context).clearSnackBars();

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Tarefa ${todo.title} foi removida com sucesso!',
       style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    action: SnackBarAction(
      label: 'Desfazer',
      onPressed: () {
        setState(() {
            todos.insert(deletedTodoPos!, deletedTodo!);
        });
        todoRepository.saveTodoList(todos);
      },
    ),
    duration: const Duration(seconds: 5),
),
);
}

void showDeleteAllConfirmationDialog() {

    if(todos.isEmpty) {
      setState(() {
        errorText = 'Adicione uma tarefa na lista!';
      });
      return;
    }

      showDialog(context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Limpar tudo!'),
              content: Text(
                  'Você tem certeza que deseja apagar todas as tarefas?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    deleteAllTodos();
                  },
                  style: TextButton.styleFrom(primary: Colors.red),
                  child: Text('Limpar tudo'),
                ),
              ],

            ),
      );
}

void deleteAllTodos() {
    setState(() {
      todos.clear();
      });
    todoRepository.saveTodoList(todos);
}

}
