import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final String name;
  final String body;
  final String version;
  final Function openLink;

  static AppInfo? _fromPackageInfo;

  AppInfo(
      {required this.name,
      required this.version,
      required this.body,
      required this.openLink});

  static Future<AppInfo> get getDetails => _setDetails();

  static Future<AppInfo> _setDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _fromPackageInfo = AppInfo(
        name: packageInfo.appName,
        version: packageInfo.version,
        body: 'A simple expense tracker. Monitor your finances.',
        openLink: _openBrowser);

    return _fromPackageInfo!;
  }

  static Future<void> _openBrowser() async {
    Uri url = Uri.parse('https://github.com/if3chi');
    if (await canLaunchUrl(url)) {
      if (!await launchUrl(url,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration:
              const WebViewConfiguration(enableDomStorage: false))) {
        throw 'Could not launch $url';
      }
    }
  }
}
