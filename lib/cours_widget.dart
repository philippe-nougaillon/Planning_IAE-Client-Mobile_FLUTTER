import 'package:flutter/material.dart';
import 'hexcolor.dart';
import 'details_page.dart';

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
    return SafeArea(
      child: InkWell(
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 80,
                  color: HexColor.fromHex(item["formation_color_json_v2"]),
                ),
              ),
              Expanded(
                flex: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(item["debut_fin_json_v2"].substring(0, 5),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(item["debut_fin_json_v2"].substring(5)),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  item["salle_json_v2"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = Colors.green,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(item["formation_json_v2"],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(item["intervenant_json"]),
                      Text(_matiereJson,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => DetailsPage(item)));
        },
      ),
    );
  }
}
