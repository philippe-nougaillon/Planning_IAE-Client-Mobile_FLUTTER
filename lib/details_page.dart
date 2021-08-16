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
                    columnWidths: const {0: FractionColumnWidth(.3)},
                    children: [
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Horaire",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["debut_fin_json_v2"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Salle",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item["salle_json_v2"],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Formation",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item["formation_json_v2"]))
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Intervenant",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["intervenant_json"]),
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Intitulé",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_matiereJson,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic)),
                        )
                      ]),
                      const TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Nbr Places",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("un certain nombre"),
                        )
                      ]),
                    ],
                  ),
                ),
                const Text("Emplacement sur la carte",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image.asset(nomDuPlanAvecSalle(item["salle_json_v2"]),
                      fit: BoxFit.fill),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
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
