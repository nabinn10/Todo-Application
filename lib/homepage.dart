import 'package:flutter/material.dart';
import 'package:todoapplication/model/todo.dart';

class TodoApplication extends StatefulWidget {
  TodoApplication({super.key});

  final List<Todo> todos = [
    Todo(
      id: "1",
      title: "This is title",
      description: "Mamaghar janxu",
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
      isCompleted: true,
    ),
    Todo(
      id: "4",
      title: "This is title",
      description: "Mamaghar janxu",
      isCompleted: true,
    ),
  ];

  @override
  State<TodoApplication> createState() => _TodoApplicationState();
}

class _TodoApplicationState extends State<TodoApplication> {
  String title = "";
  String description = "";
  final GlobalKey<FormState> todoformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo Application",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: widget.todos.isEmpty ? Center(
        child: Text("No Todos Available"),
      ):
       ListView.builder(

        itemCount: widget.todos.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: Checkbox(
              value: widget.todos[i].isCompleted,
              onChanged: (value) {
                setState(() {
                  widget.todos[i].isCompleted = value!;
                });
              },
            ),
            title: Text(widget.todos[i].title),
            subtitle: Text(widget.todos[i].description),
            trailing: IconButton(onPressed: ()
            {
              showDialog(context: context, builder: (context)
              {
                return AlertDialog(
                  title: Text("Are you sure to Delete"),
                  content: Text("This action is irreversible"),
                  actions: [
                 FilledButton.tonal(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel")),
                 FilledButton.tonal(
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                  setState(() {
                    widget.todos.removeAt(i);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                   
                    SnackBar(
                      
                      backgroundColor: Colors.blueGrey,
                      behavior: SnackBarBehavior.floating,
                      content: Text("Deleted Successfully"),
                      duration: Duration(seconds: 4),
                      showCloseIcon: true,
                    )
                  );
                  Navigator.of(context).pop();
                  },
                  child: Text(
                  "Yes!",
                  style: TextStyle(color: Colors.white),
                  ),
                 ),

                ],);
              });
              // setState(() {
              //   widget.todos.remove(widget.todos[i]);
                
              // });
            }, icon: Icon(Icons.delete)),
          );
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: Form(
                      key: todoformkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Add Todo",
                              style: TextStyle(fontSize: 28)),
                          TextFormField(
                            onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
                            decoration:
                                const InputDecoration(labelText: "Title"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please provide Title";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              title = value!;
                            },
                          ),
                          TextFormField(
                            onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
                            decoration:
                                const InputDecoration(labelText: "Description"),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please provide description";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              description = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FilledButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              FilledButton(
                                  onPressed: () {
                                    if (!todoformkey.currentState!
                                        .validate()) {
                                      return;
                                    }
                                    todoformkey.currentState!.save();
                                    setState(() {
                                      widget.todos.add(
                                        Todo(
                                          id: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          title: title,
                                          description: description,
                                          isCompleted: false,
                                        ),
                                      );
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Submit")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
