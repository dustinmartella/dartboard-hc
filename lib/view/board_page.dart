import 'package:flutter/material.dart';

class BoardPage extends StatelessWidget {

	const BoardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Board'),
				automaticallyImplyLeading: true,
				leading: IconButton(icon:Icon(Icons.arrow_back),
					onPressed: () => Navigator.pop(context, false),
				),
			),
			body: Container(),
		);
  }
}
