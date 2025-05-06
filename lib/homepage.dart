import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoApplication extends StatefulWidget {
  TodoApplication({super.key});

  final List<Todo> todos = [
    Todo(
      id: "1",
      title: "This is title",
      description: "Mamaghar Janxu",
      isCompleted: true,
    ),
    Todo(
      id: "2",
      title: "This is title",
      description: "Mamaghar janxu",
      isCompleted: true,
    ),
    Todo(
      id: "3",
      title: "This is title",
      description: "Mamaghar janxu",
      isCompleted: false,
    ),
    Todo(
      id: "4",
      title: "This is title",
      description: "College janxu",
      isCompleted: false,
    ),
  ];

  @override
  State<TodoApplication> createState() => _TodoApplicationState();
}

class _TodoApplicationState extends State<TodoApplication> {
  String selectedFilter = "All";

  fetchTodos() async {
    final Dio dio = Dio();
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/todos',
    );

    for (var todo in response.data) {
      widget.todos.add(Todo.fromMap(todo));
    }
    return widget.todos;
  }

  final GlobalKey<FormState> todoFormKey = GlobalKey();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    List<Todo> displayTodos = widget.todos.where((todo) {
      if (selectedFilter == "Completed") return todo.isCompleted;
      if (selectedFilter == "Pending") return !todo.isCompleted;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo Application",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 4, 145),
        centerTitle: true,
      ),
      body: widget.todos.isEmpty
          ? Center(child: Text("Ooops No Any Todo List"))
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionChip(
                      label: Text("All", style: TextStyle(color:
                      selectedFilter == "All" ? Colors.white : Colors.black)),
                      backgroundColor:  selectedFilter == "All" ? Colors.deepPurpleAccent : null,

                      onPressed: () {
                        setState(() {
                          selectedFilter = "All";
                        });
                      },
                    ),
                    ActionChip(
                      label:
                          Text("Completed", style: TextStyle(color: selectedFilter == "Complted" ? Colors.white : Colors.black)),
                      backgroundColor: 
                      selectedFilter == "Completed" ? Colors.deepPurpleAccent : null,
                      onPressed: () {
                        setState(() {
                          selectedFilter = "Completed";
                        });
                      },
                    ),
                    ActionChip(
                      label:
                           Text("Pending", style: TextStyle(color: selectedFilter == "Pending" ? Colors.white : Colors.black)),
                      backgroundColor:  selectedFilter == "Pending" ? Colors.deepPurpleAccent : null,
                      onPressed: () {
                        setState(() {
                          selectedFilter = "Pending";
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: FutureBuilder(
                    future: fetchTodos(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: displayTodos.length,
                            itemBuilder: (ctx, i) {
                              final todo = displayTodos[i];
                              return ListTile(
                                leading: Checkbox(
                                  value: todo.isCompleted,
                                  onChanged: (value) {
                                    setState(() {
                                      todo.isCompleted = value ?? false;
                                      // Also update the original todo
                                      int index = widget.todos.indexWhere((t) => t.id == todo.id);
                                      if (index != -1) {
                                        widget.todos[index].isCompleted =
                                            value ?? false;
                                      }
                                    });
                                  },
                                ),
                                title: Text(todo.title),
                                subtitle: Text(todo.description ?? "-"),
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Are You Sure To Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: Text(
                                              "This action is irreversible"),
                                          actions: [
                                            FilledButton.tonal(
                                              style: FilledButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red.shade400,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  widget.todos.removeWhere(
                                                      (t) => t.id == todo.id);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes"),
                                            ),
                                            FilledButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error ${snapshot.error}"));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: todoFormKey,
                    child: Column(
                      children: [
                        Text("Add Todo", style: TextStyle(fontSize: 28)),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Title"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Provide Title";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            title = value!;
                          },
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Description"),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Provide Description";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            description = value!;
                          },
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FilledButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              FilledButton(
                                onPressed: () {
                                  if (!todoFormKey.currentState!.validate()) {
                                    return;
                                  }

                                  todoFormKey.currentState!.save();

                                  setState(() {
                                    widget.todos.add(
                                      Todo(
                                        id: widget.todos.length.toString(),
                                        title: title,
                                        description: description,
                                        isCompleted: false,
                                      ),
                                    );
                                  });

                                  Navigator.of(context).pop();
                                },
                                child: Text("Submit"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
