import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentDate = "";
  bool _planningLoaded = false;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    final _coursProvider = Provider.of<CoursProvider>(context);

    if (!_planningLoaded) {
      _coursProvider.chargerCoursDuJour(_currentDate);
      setState(() {
        _planningLoaded = true;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Planning du ' + formatCurrentDateToFrench(_currentDate)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              tooltip: 'Changer de date',
              onPressed: () {
                setState(() {
                  _planningLoaded = false;
                });
                _selectionDate(context).then((value) {
                  setState(() {
                    _currentDate = value;
                  });
                  _coursProvider.chargerCoursDuJour(value);
                  setState(() {
                    _planningLoaded = true;
                  });
                });
              },
            ),
          ],
        ),
        body: _planningLoaded
            ? Container(
                child: _coursProvider.lesCours.isEmpty
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
                          return CoursWidget(
                              item: item, matiereJson: _matiereJson);
                        }),
              )
            : const Center(child: CircularProgressIndicator(value: null)),
      ),
    );
  }

  // Formater la date à la française // 23/08/2021
  String formatCurrentDateToFrench(String _date) {
    String _dateFormatFR = "";
    if (_date != "") {
      _dateFormatFR = DateFormat('dd/MM/yyyy').format(DateTime.parse(_date));
    }
    return _dateFormatFR;
  }

  Future<String> _selectionDate(BuildContext context) async {
    String _result = '';

    DateTime? _dateChoisie = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(_currentDate),
        firstDate: DateTime(2010),
        lastDate: DateTime(2030));

    if (_dateChoisie != null) {
      _result = _dateChoisie.toString().substring(0, 10);
    }
    return (_result);
  }
}
