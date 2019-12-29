import 'package:Sprintz/themes/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatefulWidget {
  bool darkModeEnabled;

  SideDrawer() {
    // Fetch dark mode preference from the SettingsProvider
    this.darkModeEnabled = true;
  }

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  TapGestureRecognizer _tapGestureRecognizer;

  _SideDrawerState() {
    this._tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        this._launchURL(Constants.authorDomain);
      };
  }

  void _launchURL(String url) async {
    print("Launching URL: $url");

    if (await canLaunch(url)) {
      print("$url can launch");
      await launch(url);
    } else {
      print("$url cannot launch");
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: UniqueKey(),
      semanticLabel: "Settings Menu",
      elevation: 24,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: ThemeColors.dp24,
        child: Padding(
          padding: Constants.defaultPaddingEdgeInset,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  SwitchListTile(
                    onChanged: (bool value) {
                      print("Clicked Slider");
                      widget.darkModeEnabled = !widget.darkModeEnabled;
                    },
                    value: widget.darkModeEnabled,
                    title: Text("Dark Mode"),
                    activeColor: ThemeColors.secondaryDp24,
                    inactiveThumbColor: Colors.white,
                    secondary: Icon(
                      Icons.lightbulb_outline,
                      color: ThemeColors.secondaryDp24,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: Constants.defaultPaddingEdgeInset,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '',
                    semanticsLabel: "Built by sleeplessdev.io",
                    children: [
                      TextSpan(
                        text: "Built by\n",
                        style: Theme.of(context).textTheme.overline,
                      ),
                      TextSpan(
                        text: "sleeplessdev.io",
                        style: Theme.of(context).textTheme.subhead,
                        recognizer: _tapGestureRecognizer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
