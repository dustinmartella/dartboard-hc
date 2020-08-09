import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeView extends StatefulWidget {
	@override
	_TimeViewState createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
	String _timeString;

	@override
	void initState() {
		_timeString = _formatDateTime(DateTime.now());

		Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Text(_timeString);
	}

	void _getTime() {
		final DateTime now = DateTime.now();
		final String formattedDateTime = _formatDateTime(now);

		setState(() {
			_timeString = formattedDateTime;
		});
	}

	String _formatDateTime(DateTime dateTime) {
		return DateFormat('hh:mm:ss').format(dateTime);
	}
}
