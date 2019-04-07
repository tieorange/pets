import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_master_detail_layouts/domain/Post.dart';
import 'package:adaptive_master_detail_layouts/presentation/master_detail_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// https://ua-pl-pets.herokuapp.com/api/test


Future<Post> fetchPost() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  const MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master-Detail example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MasterDetailContainer(new Post()) ,
    );
  }


  MasterDetailContainer buildMasterDetailContainer(Post data) => MasterDetailContainer(data);

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugger(when: snapshot.hasData, );
              return buildMasterDetailContainer(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

}
