import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'cours_provider.dart';
import 'cours_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planning4 Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => CoursProvider(),
        child: const MyHomePage(title: 'Planning'),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', 'FR'),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final _coursProvider = Provider.of<CoursProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              tooltip: 'Changer de date',
              onPressed: () {
                _selectionDate(context)
                    .then((value) => _coursProvider.chargerCoursDuJour(value));
              },
            ),
          ],
        ),
        body: _coursProvider.lesCours.isEmpty
            ? const Center(
                child: Text(
                  "Rien à afficher pour la date choisie...",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: _coursProvider.lesCours.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item =
                      _coursProvider.lesCours[index];
                  final _matiereJson = item["matiere_json"] ?? '';
                  return CoursWidget(item: item, matiereJson: _matiereJson);
                }),
      ),
    );
  }

  Future<String> _selectionDate(BuildContext context) async {
    String _result = '';

    DateTime? _dateChoisie = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));

    if (_dateChoisie != null) {
      _result = _dateChoisie.toString().substring(0, 10);
    }
    return (_result);
  }
}
