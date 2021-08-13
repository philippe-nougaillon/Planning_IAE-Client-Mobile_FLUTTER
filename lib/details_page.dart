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
      body: Container(
        decoration: new BoxDecoration(color: Colors.white),
        height: 240,
        child: Stack(
          children: <Widget>[
            Image.asset(nomDuPlanAvecSalle(item["salle_json_v2"]),
                fit: BoxFit.fill),
            Positioned(
              bottom: 15,
              right: 15, //give the values according to your requirement
              child: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}

String nomDuPlanAvecSalle(String salle) {
  return 'images/Plan_' + salle + '.jpg';
}
