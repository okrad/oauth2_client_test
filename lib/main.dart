import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:kanbanapp/kanban.dart';
// import 'package:kanbanapp/rest_client/kanbanrestclient.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
// import 'package:rest_client/response.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  // KanbanRestClient client;
  // Future<List<Kanban>> kanbanList;

  _MyHomePageState() {
    // client = KanbanRestClient();
  }

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  fetchList() async {

    // List l;

    OAuth2Helper oauth2Helper;

    GitHubOAuth2Client client = GitHubOAuth2Client(redirectUri: 'com.teranet.app://oauth2redirect', customUriScheme: 'com.teranet.app');

    oauth2Helper = OAuth2Helper(
      client,
      clientId: '1b4ae3dce468cf11baec',
      clientSecret: '705144e604aae707696860a6b21934face94837a',
      scopes: ['repo']);

    // http.Response resp = await oauth2Helper.post(_getServiceUrl('list'));
    // http.Response resp = await oauth2Helper.get('https://www.googleapis.com/drive/v3/files');
    http.Response resp = await oauth2Helper.get('https://api.github.com/user/repos');

print(resp.body);

    // var list = jsonDecode(resp.body);

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
      body: Center(
        child: Text('TEST')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchList,
        tooltip: 'Get kanban list',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
/*
  Widget _buildKanbanList() {
    fetchKanbanList().then((list) {
      return ListView.builder(
        itemBuilder: (context, i) {
          return _buildRow(i);
        }
      );
    });

  }
*/
/*
  Widget _buildRow(Kanban k) {
    return ListTile(
      title: Text(
        k.name
        // style: _biggerFont,
      ),

    );
  }
*/
  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIos: 3,
        toastLength: Toast.LENGTH_LONG
    );
  }
/*
  Future<List<Kanban>> fetchKanbanList() async {

    List<Kanban> list;

    try {
      list = await client.list();

      if(list == null) {
        // toast('Cannot retrieve kanban list. Error: ' + r.getString('text'));
        toast('Cannot retrieve kanban list.');
      }
    } catch(err, s) {
      toast('Authorization error: ' + (err.toString()));
      print(err.toString());
      print(s);
      // rethrow;
      // throw err;
    }

    return list;

  }
*/
}
