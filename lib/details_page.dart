import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.item, {Key? key}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item["formation_json_v2"]),
        ),
        body: Center(
          child: Column(
            children: [
              Text(item["formation_json_v2"]),
            ],
          ),
        ));
  }
}
