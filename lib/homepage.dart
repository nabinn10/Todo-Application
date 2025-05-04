import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoApplication extends StatefulWidget {
  TodoApplication({super.key});

  final List<Todo> todos = [
    Todo(
      id: "1",
      title: "This is title",
      description: "Hero Arun",
      isCompleted: true,
    ),
    Todo(
      id: "2",
      title: "This is title",
      description: "Don Arun",
      isCompleted: true,
    ),
    Todo(
      id: "3",
      title: "This is title",
      description: "Timro Babe",
      isCompleted: true,
    ),
    Todo(
      id: "4",
      title: "This is title",
      description: "Binisha Don",
      isCompleted: true,
    ),
  ];

  @override
  State<TodoApplication> createState() => _TodoApplicationState();
}

class _TodoApplicationState extends State<TodoApplication> {

  fetchTodos() async {
   final Dio dio=Dio();
 final response= await  dio.get('https://jsonplaceholder.typicode.com/todos');
  

  for(var todo in response.data){
    widget.todos.add(Todo.fromMap(todo));
  }
  }
  final GlobalKey<FormState> todoFormKey = GlobalKey();

  String title = "";
  String description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo Application",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 4, 145),
        centerTitle: true,
      ),
      body:widget.todos.isEmpty ?
       Center(
        child: Text("Ooops No Any Todo List"),
       )
     :FutureBuilder(
         future: fetchTodos(),
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.done) {
             if (snapshot.hasData) {
               return ListView.builder(
                 itemCount: widget.todos.length,
                 itemBuilder: (ctx, i) {
                   return ListTile(
                     leading: Checkbox(
                       value: widget.todos[i].isCompleted,
                       onChanged: (value) {
                         setState(() {
                           widget.todos[i].isCompleted = value ?? false;
                         });
                       },
                     ),
                     title: Text(widget.todos[i].title),
                     subtitle: Text(widget.todos[i].description ?? "-"),
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
                               content: Text("This action is irreversible"),
                               actions: [
                                 FilledButton.tonal(
                                   style: FilledButton.styleFrom(
                                     backgroundColor: Colors.red.shade400,
                                     foregroundColor: Colors.white,
                                   ),
                                   onPressed: () {
                                     setState(() {
                                       widget.todos.remove(widget.todos[i]);
                                     });

                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(SnackBar(
                                       backgroundColor:
                                           Colors.green.shade500,
                                       behavior: SnackBarBehavior.floating,
                                       duration: Duration(seconds: 3),
                                       showCloseIcon: true,
                                       content: Text("Successfully Deleted"),
                                     ));
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
               return Center(
                 child: Text("Error ${snapshot.error}"),
               );
             } else {
               return Center(child: CircularProgressIndicator());
             }
           } else {
             return Center(child: CircularProgressIndicator());
           }
         },
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
                              return "Please Provide Description";
                            } else {
                              return null;
                            }
                          },

                          onSaved: (value) {
                            setState(() {
                              title = value!;
                            });
                          },

                          onTapOutside:
                              (event) => FocusScope.of(
                                context,
                              ).requestFocus(FocusNode()),
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
                            setState(() {
                              description = value!;
                            });
                          },

                          onTapOutside:
                              (event) => FocusScope.of(
                                context,
                              ).requestFocus(FocusNode()),
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