import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'E-Mail',
              hintText: 'email@exemplo.com',
              //border: OutlineInputBorder(),
              //border: InputBorder.none,
              //errorText: 'Campo obrigatorio!'
              prefixText: 'R\$ ',
              suffixText: 'cm',
            ),
            //obscureText: true,
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
    );
  }
}