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

	Homepage(this.id, this.title, this.link, this.leaf, this.timeout);

	factory Homepage.fromJson(dynamic json) {
		return Homepage(
			json['id'] as String,
			json['title'] as String,
			json['link'] as String,
			json['leaf'] as bool,
			json['timeout'] as bool,
		);
	}

	@override
	String toString() {
		return this.link;
	}
}
