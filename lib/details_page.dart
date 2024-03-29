import 'package:flutter/material.dart';
import 'hexcolor.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.item, {Key? key}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final matiereJson = item["matiere_json"] ?? '';
    final salle = item["salle_json_v2"];

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
                          child: Text("Date"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["date_json_v3"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Horaire"),
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
                          child: Text("Formation"),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item["formation_json_v2"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)))
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Intervenant"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item["intervenant_json"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Intitulé cours"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(matiereJson,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic)),
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Salle"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(salle,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ]),
                      const TableRow(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Nbr Places"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("un certain nombre"),
                        )
                      ]),
                    ],
                  ),
                ),
                Container(
                  child: _salleAvecPlan(salle)
                      ? Image(image: AssetImage(nomDuPlanAvecSalle(salle)))
                      : Container(),
                ),
                Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Image(
                        image: AssetImage('assets/images/Biopark.png'),
                        fit: BoxFit.fill)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String nomDuPlanAvecSalle(String salle) {
  return 'assets/images/Plan_$salle.jpg';
}

bool _salleAvecPlan(String salle) {
  List<String> plan = ['B1', 'B2', 'B3'];

  return (plan.contains(salle));
}
