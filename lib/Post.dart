import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/approutes.dart';
import 'package:todo_app/model/post.dart';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  List<Post> posts = [];

  Future<void> fetchPosts() async {
    try {
      final Dio dio = Dio();
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts/',
      );
      setState(() {
        posts = (response.data as List)
            .map((item) => Post.fromJson(item))
            .toList();
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final trimmedBody = post.body.length > 50
                    ? '${post.body.substring(0, 47)}...'
                    : post.body;
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    Approutes.postviewScreen,
                    arguments: post.id,
                  ),
                  child: Card(
                    child: ListTile(
                      subtitle: Text("Body: $trimmedBody"),
                      title: Text(
                        post.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Text(post.id.toString()),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
