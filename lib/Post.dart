import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  List posts = [];

  fetchTodos() async {
    final Dio dio = Dio();
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    setState(() {
      posts = response.data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final body = post['body'];
          final trimmedBody = body.length > 50 ? body.substring(0, 47) + "..." : body;
          return ListTile(
            
            subtitle: Text("Body: $trimmedBody"),
            title: Text(post['title']),
            leading: Text(post['id'].toString()),
            // trailing: Text(post['title']),
          );
        },
      ),
    );
  }
}
