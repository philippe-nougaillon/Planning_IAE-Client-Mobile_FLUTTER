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
  String _searchText = "";
  bool _planningLoaded = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    final _coursProvider = Provider.of<CoursProvider>(context);
    ScrollController _scrollController = ScrollController();

    if (!_planningLoaded) {
      setState(() {
        _coursProvider.chargerCoursDuJour(
            _currentDate, _currentPage, _searchText);
        _planningLoaded = true;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cours >= ' +
              formatCurrentDateToFrench(_currentDate) +
              ' ' +
              (_searchText != "" ? '($_searchText)' : '')),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              tooltip: 'Changer de date',
              onPressed: () {
                setState(() {
                  _planningLoaded = false;
                  _scrollController.jumpTo(0.0);
                });
                _selectionDate(context).then((value) {
                  setState(() {
                    _currentDate = value;
                    _currentPage = 1;
                    _searchText = "";
                    _coursProvider.chargerCoursDuJour(
                        value, _currentPage, _searchText);
                    _planningLoaded = true;
                  });
                });
              },
            ),
            IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Filtrer',
                onPressed: () {
                  _scrollController.jumpTo(0.0);
                  _displayTextInputDialog(context).then((value) {
                    _coursProvider.chargerCoursDuJour(
                        _currentDate, _currentPage, _searchText);
                  });
                })
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
                    : ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                            ),
                        controller: _scrollController,
                        itemCount: _coursProvider.lesCours.length + 1,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item = <String, dynamic>{};
                          // Tester si il y a encore des items à afficher
                          if (index < _coursProvider.lesCours.length) {
                            item = _coursProvider.lesCours[index];
                          }
                          // , sinon afficher le bouton pour en voir plus
                          return (item.isNotEmpty)
                              ? CoursWidget(item: item)
                              : _searchText == ""
                                  ? TextButton(
                                      child: const Text(
                                          "Afficher plus de cours...",
                                          style: TextStyle(fontSize: 20)),
                                      onPressed: () {
                                        _scrollController.jumpTo(0.0);
                                        setState(() {
                                          _currentPage++;
                                          _coursProvider.chargerCoursDuJour(
                                              _currentDate,
                                              _currentPage,
                                              _searchText);
                                        });
                                      },
                                    )
                                  : Container();
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
    } else {
      _result = DateTime.now().toString();
    }
    return (_result);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Filtrer'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Entrez un texte"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  setState(() {
                    _searchText = "";
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
