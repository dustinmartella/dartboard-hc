import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// provides the currently selected sitemap, saves changed sitemap preferences to disk
class SitemapController extends ChangeNotifier {
  static const sitemapPrefKey = 'sitemap';

  SitemapController(this._prefs) {
    // load sitemap from preferences on initialization
    _sitemapLink = _prefs.getString(sitemapPrefKey) ?? 'howdy';
  }

  final SharedPreferences _prefs;
  String _sitemapLink;

  /// get the current sitemap link
  String get sitemapLink => _sitemapLink;

  void setSitemapLink(String sitemapLink) {
    _sitemapLink = sitemapLink;

    // notify the app that the sitemap link was changed
    notifyListeners();

    // store updated sitemap link on disk
    //_prefs.setString(sitemapPrefKey, sitemapLink);
  }

  /// get the controller from any page of your app
  static SitemapController of(BuildContext context) {
		final SitemapControllerProvider provider = context.dependOnInheritedWidgetOfExactType<SitemapControllerProvider>();

    return provider.controller;
  }
}

/// provides the sitemap controller to any page of your app
class SitemapControllerProvider extends InheritedWidget {
  const SitemapControllerProvider({Key key, this.controller, Widget child}) : super(key: key, child: child);

  final SitemapController controller;

  @override
  bool updateShouldNotify(SitemapControllerProvider old) => controller != old.controller;
}

//	static const noSitemapJson = '{"name":"_dartboard","label":"Dartboard","link":"local://dartboard","homepage":{"link":"local://dartboard/dartboard","leaf":false,"timeout":false,"widgets":[]}}';
