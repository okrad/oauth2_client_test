import 'package:flutter/material.dart';
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/linkedin_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client_test/discord_oauth2_client.dart';
import 'package:oauth2_client_test/spotify_oauth2_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'oauth2_client Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'oauth2_client Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String accessToken;

  final clientIdController = TextEditingController();
  final clientSecretController = TextEditingController();
  final scopesController = TextEditingController();

  final redirectUri = 'mytestapp://oauth2redirect';
  final customUriScheme = 'mytestapp';

  List _clientNames = ["GitHub", "Google", "LinkedIn", "Spotify", "Discord"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentClient;

  _MyHomePageState() {}

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentClient = _dropDownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String clientName in _clientNames) {
      items.add(
          new DropdownMenuItem(value: clientName, child: new Text(clientName)));
    }
    return items;
  }

  void changedDropDownItem(String selectedClient) {
    setState(() {
      _currentClient = selectedClient;
    });
  }

  authorize() async {
    var client = getClient();

    if (client != null) {
      List scopes =
          scopesController.text.split(',').map((s) => s.trim()).toList();

      String clientId = clientIdController.text;
      String clientSecret = clientSecretController.text;

      var hlp = OAuth2Helper(client,
          clientId: clientId, clientSecret: clientSecret, scopes: scopes);

      var tokenResp = await hlp.getToken();

      setState(() {
        accessToken = tokenResp.accessToken;
      });
    }
  }

  OAuth2Client getClient() {
    var client;

    switch (_currentClient) {
      case 'GitHub':
        client = GitHubOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;

      case 'Google':
        client = GoogleOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;

      case 'LinkedIn':
        client = LinkedInOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;

      case 'Spotify':
        client = SpotifyOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;

      case 'Discord':
        client = DiscordOAuth2Client(
            redirectUri: redirectUri, customUriScheme: customUriScheme);
        break;
    }

    return client;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Client Type', style: TextStyle(fontSize: 14)),
          ),
          DropdownButton(
            value: _currentClient,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text('Client Id', style: TextStyle(fontSize: 14))),
          TextField(
            controller: clientIdController,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text('Client Secret', style: TextStyle(fontSize: 14))),
          TextField(
            controller: clientSecretController,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text('Scopes', style: TextStyle(fontSize: 14))),
          TextField(
            controller: scopesController,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Access Token', style: TextStyle(fontSize: 14)),
          ),
          Text('$accessToken', style: TextStyle(fontSize: 14))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: testAuthorize,
        onPressed: authorize,
        label: Text('Authorize'),
        icon: Icon(Icons.lock_open),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    clientIdController.dispose();
    clientSecretController.dispose();
    scopesController.dispose();

    super.dispose();
  }
}
