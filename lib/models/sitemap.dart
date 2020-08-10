class Sitemaps {
  final List<Sitemap> sitemaps;

  Sitemaps({this.sitemaps});

  factory Sitemaps.fromJson(List<dynamic> json) {
    return Sitemaps(
      sitemaps: json != null ? new List<Sitemap>.from(json.map((x) => Sitemap.fromJson(x))) : null,
    );
  }
}

class Sitemap {
	String name;
	String label;
	String link;
	Homepage homepage;

	Sitemap(this.name, this.label, this.link, this.homepage);

	factory Sitemap.fromJson(dynamic json) {
		return Sitemap(
			json['name'] as String,
			json['label'] as String,
			json['link'] as String,
			Homepage.fromJson(json['homepage']),
		);
	}

	@override
	String toString() {
		return this.name;
	}
}

class Homepage {
	String id;
	String title;
	String link;
	bool leaf;
	bool timeout;
	List<HabWidget> widgets;

	Homepage(this.id, this.title, this.link, this.leaf, this.timeout, [this.widgets]);

	factory Homepage.fromJson(dynamic json) {
		return Homepage(
			json['id'] as String,
			json['title'] as String,
			json['link'] as String,
			json['leaf'] as bool,
			json['timeout'] as bool,
			json['widgets'] != null ? new List<HabWidget>.from(json['widgets'].map((x) => HabWidget.fromJson(x))) : null,
		);
	}

	@override
	String toString() {
		return this.link;
	}
}

class HabWidget {
	String widgetId;
	String type;
	bool visibility;
	String label;
	String icon;
	List<HabWidget> widgets;

	HabWidget(this.widgetId, this.type, this.visibility, this.label, this.icon, [this.widgets]);

	factory HabWidget.fromJson(dynamic json) {
		return HabWidget(
			json['widgetId'] as String,
			json['type'] as String,
			json['visibility'] as bool,
			json['label'] as String,
			json['icon'] as String,
			json['widgets'] != null ? new List<HabWidget>.from(json['widgets'].map((x) => HabWidget.fromJson(x))) : null,
		);
	}

	@override
	String toString() {
		return this.label;
	}
}

