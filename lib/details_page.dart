import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'hexcolor.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.item, {Key? key}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final _matiereJson = item["matiere_json"] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(item["formation_json_v2"]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Table(
                    border: TableBorder.all(
                      color: HexColor.fromHex(item["formation_color_json_v2"]),
                    ),
                    columnWidths: {0: FractionColumnWidth(.3)},
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Début",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["debut_fin_json_v2"].substring(0, 5),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Fin",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text(item["debut_fin_json_v2"].substring(8))),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Salle",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item["salle_json_v2"],
                            style: TextStyle(
                              fontSize: 16,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = Colors.green,
                            ),
                          ),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Formation",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["formation_json_v2"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Intervenant",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["intervenant_json"]),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Cours",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_matiereJson,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic)),
                        )
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Nbr Places",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("un certain nombre"),
                        )
                      ]),
                    ],
                  ),
                ),
                Text("Emplacement sur la carte",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  child: Image.asset(nomDuPlanAvecSalle(item["salle_json_v2"]),
                      fit: BoxFit.fill),
                ),
                Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  child: Image.asset('assets/images/Biopark.png',
                      fit: BoxFit.fill),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String nomDuPlanAvecSalle(String salle) {
  return 'assets/images/Plan_' + salle + '.jpg';
}
