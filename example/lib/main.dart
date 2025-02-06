import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'common/common.dart';
import 'router.dart';
import 'util/configure_non_web.dart'
    if (dart.library.html) 'util/configure_web.dart';
import 'widgets/widgets.dart';

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortune Wheel Example',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  StreamController<int> selected = StreamController<int>();

  final items = <String>[
    'Jeh',
    'Grogu',
    'Mace Windu',
    'Obi-Wan Kenobi',
    'Han Solo',
    'Luke Skywalker',
    'Darth Vader',
    'Yoda',
    'Ahsoka Tano',
  ];

  List<FortuneItem> _getItems() {
    debugPrint('jella-get new item list');
    final _iList = <FortuneItem>[];

    for (var it in items) {
      if (items.indexOf(it) == 0) {
        debugPrint('jella');
        _iList.add(
          FortuneItem(child: Text(it), weight: 0.5),
        );
      } else {
        _iList.add(
          FortuneItem(child: Text(it)),
        );
      }
    }

    return _iList;
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fortune Wheel'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected.add(
              Fortune.randomInt(0, items.length),
            );
          });
        },
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                items: _getItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  configureApp();
  runApp(DemoApp());
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeModeScope(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'Fortune Wheel Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
