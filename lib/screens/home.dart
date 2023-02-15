import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.getTodoList();
  List<Todo> _currentTodoList = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _currentTodoList = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All Todos',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: textPrimary),
                        ),
                      ),
                      for (Todo currTodo in _currentTodoList)
                        TodoItem(
                          todo: currTodo,
                          onTodoChanged: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
                addTodo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String toDo) {
    setState(() {
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.text!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _currentTodoList = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: textPrimary,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: textSecondary),
        ),
      ),
    );
  }

  Widget addTodo() {
    return Row(children: [
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
            right: 20,
            left: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.0),
                blurRadius: 10.0,
                spreadRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _todoController,
            decoration: const InputDecoration(
                hintText: 'Add a new todo item', border: InputBorder.none),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 20,
        ),
        child: ElevatedButton(
          onPressed: () {
            _addTodoItem(_todoController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size(60, 60),
            elevation: 10,
          ),
          child: const Text(
            '+',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    ]);
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundPrimary,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: textPrimary,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
      ]),
    );
  }
}
