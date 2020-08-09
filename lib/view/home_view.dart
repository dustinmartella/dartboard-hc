import 'package:flutter/material.dart';

import 'package:dartboardhc/view/oh_sitemaps_view.dart';
import 'package:dartboardhc/view/time_view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
			_counter = _counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
				actions: [
					Center(
						child: TimeView(),
					)
				],
      ),
			drawer: Drawer(
				child: ListView(
					padding: EdgeInsets.zero,
					children: <Widget>[
						DrawerHeader(
								decoration: BoxDecoration(
										color: Colors.blue,
								),
								child: Text(
										'Drawer Header',
										style: TextStyle(
												color: Colors.white,
												fontSize: 24,
										),
								),
						),
						ListTile(
								leading: Icon(Icons.message),
								title: Text('Messages'),
								onTap: () => Navigator.pushNamed(context, '/chucky'),
						),
						ListTile(
								leading: Icon(Icons.account_circle),
								title: Text('Profile'),
						),
						const Divider(),
						ListTile(
								leading: Icon(Icons.settings),
								title: Text('Settings'),
								onTap: () => Navigator.pushNamed(context, '/settings'),
						),
					],
				),
			),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
