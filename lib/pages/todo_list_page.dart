import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
     TodoListPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Adicione uma tarefa',
                  ),
                ),
              ),

              SizedBox(width: 8,),

              ElevatedButton(
                  onPressed: () {},
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
        ),
      ),
    );
  }

  void login() {
    String text = emailController.text;
    print(text);
  }
}