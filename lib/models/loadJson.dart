import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_example3/models/post.dart';

// DECODE CONVERT'DEN GELİYOR.

Future<Post> getPost() async{
  final response = await http.get("https://jsonplaceholder.typicode.com/posts/1");
  if(response.statusCode == 200){
    return Post.fromJson(json.decode(response.body));  //GELEN RESPONSE'UN BODYSİNİ AYIKLA DEMEK.
  }else{
    throw Exception("Veriler getirilirken hata oluştu. Hata kodu: ${response.statusCode}");
  }
}

class LoadJson extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Data"),
      ),
      body: new Center(
        child: new FutureBuilder(
            future: getPost(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("user id: ${snapshot.data.userId}"),
                    new Text("id: ${snapshot.data.id}"),
                    new Text("title: ${snapshot.data.title}"),
                    new Text("body: ${snapshot.data.body}"),
                  ],
                );
              }else if(snapshot.hasError){
                return new Text("hata oluştu: ${snapshot.error}");
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
