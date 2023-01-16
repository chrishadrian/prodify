import 'package:flutter/material.dart';
import 'package:prodify/model/todo.dart';
import '../constants/color.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "Prodify";
  final todoList = Todo.todoList();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: backgroundPrimary,
        appBar: _buildAppBar(),
        body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: const Text(
                        'All ToDos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: textPrimary,
                        ),
                      ),
                    ),
                    for (Todo todo in todoList) {
                      TodoItem(todo: todo)
                    }
                  ]),
                )
              ],
            )));
  }

  Widget searchBox() {
    const searchIcon = Icon(
      Icons.search,
      color: textPrimary,
      size: 20,
    );
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: backgroundSecondary,
            borderRadius: BorderRadius.circular(20)),
        child: const TextField(
          style: TextStyle(color: textPrimary),
          decoration: InputDecoration(
            prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 4.0, end: 7.0),
                child: searchIcon),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: textSecondary),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: backgroundPrimary,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(
            Icons.menu,
            color: textPrimary,
            size: 30,
          ),
          Text(title),
          SizedBox(
              height: 45,
              width: 45,
              child: ClipOval(
                child: Image.asset('assets/images/avatar.jpeg'),
              ))
        ]));
  }
}
