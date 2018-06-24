import 'dart:math';

import 'package:adaptive_master_detail_layouts/presentation/item.dart';
import 'package:adaptive_master_detail_layouts/presentation/item_details.dart';
import 'package:adaptive_master_detail_layouts/presentation/item_listing.dart';
import 'package:adaptive_master_detail_layouts/presentation/main2.dart';
import 'package:flutter/material.dart';


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

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class MasterDetailContainer extends StatefulWidget {
  MasterDetailContainer(Post data);

  @override
  _ItemMasterDetailContainerState createState() =>
      _ItemMasterDetailContainerState();
}

class _ItemMasterDetailContainerState extends State<MasterDetailContainer> {
  final Future<Post> post;

  static const int kTabletBreakpoint = 600;

  Item _selectedItem;

  Widget _buildMobileLayout() {
    return Container(
      child: FutureBuilder<Post>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildLayout(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return CircularProgressIndicator();
        },
      )
    );
  }

  Widget _ buildLayout(Post data){
    return ItemListing(
      itemSelectedCallback: (item) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemDetails(
                isInTabletLayout: false,
                item: item,
              );
            },
          ),
        );
      },
    )
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Container(
          child:  Flexible(
            flex: 1,
            child: Material(
              elevation: 4.0,
              child: ItemListing(
                itemSelectedCallback: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
                selectedItem: _selectedItem,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: ItemDetails(
            isInTabletLayout: true,
            item: _selectedItem,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

//    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
//    } else {
//      content = _buildTabletLayout();
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Master-detail flow sample'),
      ),
      body: content,
    );
  }
}
