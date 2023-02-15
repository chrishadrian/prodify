class Todo {
  String? id;
  String? text;
  bool isDone;

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
  });
  
  static List<Todo> getTodoList() {
    return[
      Todo(id: '3', text: 'Work on mobile apps', isDone: true),
      Todo(id: '4', text: 'Cook for dinner', isDone: true),
      Todo(id: '1', text: 'Check Emails'),
      Todo(id: '2', text: 'Buy Groceries'),
      Todo(id: '5', text: 'Team Meeting'),
      Todo(id: '6', text: 'Work on mobile apps for 2 hour'),
      Todo(id: '7', text: 'Dinner with Jenny'),
    ];
  }
}