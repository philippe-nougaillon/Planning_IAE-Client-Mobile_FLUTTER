import 'package:flutter/material.dart';
import 'hexcolor.dart';

class CoursWidget extends StatelessWidget {
  const CoursWidget({
    Key? key,
    required this.item,
    required matiereJson,
  })  : _matiereJson = matiereJson,
        super(key: key);

  final Map<String, dynamic> item;
  final String _matiereJson;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 100,
                width: 3,
                color: HexColor.fromHex(item["formation_color_json_v2"]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["debut_fin_json_v2"]),
                Text(item["formation_json_v2"]),
                Text(item["intervenant_json"]),
                Text(_matiereJson),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
