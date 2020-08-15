import 'package:equatable/equatable.dart';

class Sitemaps {
  final List<Sitemap> sitemaps;

  Sitemaps({this.sitemaps});

  factory Sitemaps.fromJson(List<dynamic> json) {
    return Sitemaps(
      sitemaps: json != null ? new List<Sitemap>.from(json.map((x) => Sitemap.fromJson(x))) : null,
    );
  }
}

class Sitemap extends Equatable {
	String name;
	String label;
	String link;
	Homepage homepage;

	Sitemap({this.name, this.label, this.link, this.homepage});

	@override
	List<Object> get props => [name];

	factory Sitemap.fromJson(dynamic json) {
		return Sitemap(
			name: json['name'] as String,
			label: json['label'] as String,
			link: json['link'] as String,
			homepage: new Homepage.fromJson(json['homepage']),
		);
	}

	@override
	String toString() {
		return this.name;
	}
}

class Homepage extends Equatable {
	String id;
	String title;
	String link;
	bool leaf;
	bool timeout;
	Homepage parent;
	List<HabWidget> widgets;

	Homepage({
		this.id,
		this.title,
		this.link,
		this.leaf,
		this.timeout,
		this.parent,
		this.widgets,
	});

	@override
	List<Object> get props => [id];

	factory Homepage.fromJson(dynamic json) {
		return Homepage(
			id: json['id'] as String,
			title: json['title'] as String,
			link: json['link'] as String,
			leaf: json['leaf'] as bool,
			timeout: json['timeout'] as bool,
			parent: json['parent'] != null ? new Homepage.fromJson(json['parent']) : null,
			widgets: json['widgets'] != null ? new List<HabWidget>.from(json['widgets'].map((x) => HabWidget.fromJson(x))) : null,
		);
	}

	@override
	String toString() {
		return this.link;
	}
}

class HabWidget extends Equatable {
	String widgetId;
	String type;
	bool visibility;
	String label;
	String icon;
	Homepage linkedPage;
	List<HabWidget> widgets;

	HabWidget({
		this.widgetId,
		this.type,
		this.visibility,
		this.label,
		this.icon,
		this.linkedPage,
		this.widgets,
	});

	@override
	List<Object> get props => [widgetId];

	factory HabWidget.fromJson(dynamic json) {
		return HabWidget(
			widgetId: json['widgetId'] as String,
			type: json['type'] as String,
			visibility: json['visibility'] as bool,
			label: json['label'] as String,
			icon: json['icon'] as String,
			linkedPage: json['linkedPage'] != null ? new Homepage.fromJson(json['linkedPage']) : null,
			widgets: json['widgets'] != null ? new List<HabWidget>.from(json['widgets'].map((x) => HabWidget.fromJson(x))) : null,
		);
	}

	@override
	String toString() {
		return this.label;
	}
}
