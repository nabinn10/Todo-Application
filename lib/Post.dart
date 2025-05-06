import 'package:flutter/material.dart';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {


  fetchTodos() async {
    final Dio dio = Dio();
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );

   
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Posts",style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      centerTitle: true,),
      body: Column(
        children: [
         ListTile(
          title: Text("User ID"),
          subtitle: Text("Body")  ,
          leading:Text("Title"),
          
          trailing: Text("Body"),
         )
          )
        ],
      ),
    );
  }
}