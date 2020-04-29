import 'package:flutter/material.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/github_oauth2_client.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String accessToken;

  final clientIdController = TextEditingController();
  final clientSecretController = TextEditingController();
  final scopesController = TextEditingController();

  _MyHomePageState() {
  }

  @override
  void initState() {
    super.initState();
  }

  authorize() async {
    AccessTokenResponse tokenResp;

    String clientId = clientIdController.text;
    String clientSecret = clientSecretController.text;
    List scopes = scopesController.text.split(',').map((s) => s.trim()).toList();

    GitHubOAuth2Client client = GitHubOAuth2Client(redirectUri: 'com.test.app://oauth2redirect', customUriScheme: 'com.test.app');
    tokenResp = await client.getTokenWithAuthCodeFlow(clientId: clientId, clientSecret: clientSecret, scopes: scopes);

    setState(() {
      accessToken = tokenResp.accessToken;
    });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Client Id', style: TextStyle(fontSize: 14))
          ),
          TextField(
            controller: clientIdController,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Client Secret', style: TextStyle(fontSize: 14))
          ),
          TextField(
            controller: clientSecretController,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Scopes', style: TextStyle(fontSize: 14))
          ),
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
        onPressed: authorize,
        label: Text('Authorize'),
        // icon: Icon(Icons.add),
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
