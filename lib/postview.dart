import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/post.dart';

class Postview extends StatefulWidget {
  const Postview({super.key});

  @override
  State<Postview> createState() => _PostviewState();
}

class _PostviewState extends State<Postview> {


  
  @override
  Widget build(BuildContext context) {
    Post? post;

    fetchPostDetails() async {
   
       int id = ModalRoute.of(context)!.settings.arguments as int;
       final Dio dio = Dio();
       try{
        final response = await dio.get("https://jsonplaceholder.typicode.com/posts/$id");
        post = response.data;
        return post;
       }
       catch(e)
       {
        print(e);
       }
    }
   
   
    return  FutureBuilder(future: fetchPostDetails(), builder: (ctx,snapshot)
    {
      if (snapshot.connectionState == ConnectionState.done)
      {
        if (snapshot.hasData)
        {
          return Scaffold(
            appBar: AppBar(title: Text(post!.title),),
            body: Text(post!.body),
          );
        }
        else if (snapshot.hasError)
        {
          return Scaffold(
             appBar: AppBar(title: Text(post!.title),),
            body: Center(
              child: Text("Error"),
            ),
          );
        }
      }
    });
  }
}