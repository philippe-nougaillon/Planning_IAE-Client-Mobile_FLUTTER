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
    return SafeArea(
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: HexColor.fromHex(item["formation_color_json_v2"]),
                ),
              ),
              Expanded(
                flex: 67,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item["debut_fin_json_v2"].substring(0, 5),
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                                    // ..color = Color.fromRGBO(
                                    //     0, 255, 0, item.capacite / 100),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(item["formation_json_v2"],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text(item["intervenant_json"]),
                      Text(_matiereJson,
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic,
                              fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
