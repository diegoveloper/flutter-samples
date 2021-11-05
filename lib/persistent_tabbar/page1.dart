import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<dynamic>? list = [];

  _loadList() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/"));
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          list = json.decode(response.body) as List?;
        });
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  void initState() {
    _loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: list!.length,
            itemBuilder: (BuildContext context, int index) {
              final data = list![index];
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Text(data['title']),
                subtitle: Text(
                  data['body'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
