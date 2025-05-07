import 'package:flutter/material.dart';

class Postview extends StatefulWidget {
  const Postview({super.key});

  @override
  State<Postview> createState() => _PostviewState();
}

class _PostviewState extends State<Postview> {


  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("View Post",style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      centerTitle: true,),
      
    );
  }
}