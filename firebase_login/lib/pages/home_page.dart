import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_login/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//Mark McMurtury
//Vincent Josephs
//Jack Primiani
//Cody Butler


import 'package:flutter/foundation.dart';
import 'package:firebase_login/Entry.dart';
var patientid;
final databaseReference = Firestore.instance;
getUID() async{
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final uid = user.uid;
  return uid;
}

getPatientUID() async{
  String patientUID = getUID().toString();
  print(patientUID);
  return patientUID;
}
var uider = getPatientUID();

createRecord(Entry e) async{
  await databaseReference.collection("entries").document()
      .setData({
    'patientID': await getUID(),
    'injuried': e.getInjuried(),
    'location': e.getLocation(),
    'date': new DateTime.now(),
    'description': e.getDescription(),
    'severity': e.getSeverity(),
    'time': e.getTimeDay()

  });
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {




  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter login demo'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(child: ListTile(title: Text('Viewable list sample'),
              onTap:(){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenListDisplay(entries: List<String>.generate(25, (i) => "Entry $i"),)),);})),
          Card(
            child: ListTile(
                title: Text('Data input sample'),
                onTap:(){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputName()),);}
            ),
          ),
          Card(
            child: ListTile(
                title: Text('Create Entry'),
                onTap: (){CreateEntry(context);}
            ),
          ),
          Card (
            child: ListTile(
              title: Text('View Entry'),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UserDataView()),);}
            )
          )
        ],
      )
      /*Center(
        child: RaisedButton(
          child: Text("Sample Data input"),
          onPressed: (){
            Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => GenListDisplay(entries: List<String>.generate(25, (i) => "Entry $i"),)),
                MaterialPageRoute(builder: (context) => InputName()),
            );
          },
        ),
      )*/,
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Back')
        ),
      ),
    );
  }
}

//generated strings to display a scrollable list.
class GenListDisplay extends StatelessWidget {
  final List<String> entries;
  GenListDisplay({Key key, @required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final title = 'Viewable Long list';
    return Scaffold(
      appBar: AppBar(title: Text(title),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index){
          return ListTile(title: Text('${entries[index]}'),
          );
        },
      ),
    );
  }
}

class InputName extends StatefulWidget {
  @override
  InputPageState createState() => new InputPageState();
}
class InputPageState extends State<InputName> {
  String username = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Input Data'),
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(hintText: 'Data'),
                onChanged: (String textinput) {
                  setState((){
                    username = textinput;
                  });
                },
              ),
              new Text(username),
            ],
          ),
        ));
  }
}


class ImageDisplayer extends StatefulWidget{
  final Entry E; //Container for the entry
  ImageDisplayer({Key key, @required this.E}) : super(key: key);
  @override
  ImageDispState createState() => ImageDispState(E: E);
}

class ImageDispState extends State<ImageDisplayer>{
  final Entry E; //Container for the entry
  ImageDispState({Key key, @required this.E});
  @override
  Widget build(BuildContext context) {
    AssetImage('assets/images/Grade1.png');
    AssetImage('assets/images/Grade2.png');
    AssetImage('assets/images/Grade3.png');
    AssetImage('assets/images/Grade4.png');
    return Scaffold(
        appBar: AppBar(title: Text('Hopkins Scale')),
        body: new Container(
            padding: EdgeInsets.all(20.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () { E.setSeverity(1);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LastEntryScreen(E: E)),);},
                    padding: EdgeInsets.all(8),
                    child: Image.asset('images/Grade1.png'),
                  ),
                  FlatButton(
                    onPressed: () { E.setSeverity(2);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LastEntryScreen(E: E)),);},
                    padding: EdgeInsets.all(8),
                    child: Image.asset('images/Grade2.png'),
                  ),
                  FlatButton(
                    onPressed: () { E.setSeverity(3);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LastEntryScreen(E: E)),);},
                    padding: EdgeInsets.all(8),
                    child: Image.asset('images/Grade3.png'),
                  ),
                  FlatButton(
                    onPressed: () { E.setSeverity(4);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LastEntryScreen(E: E)),);},
                    padding: EdgeInsets.all(8),
                    child: Image.asset('images/Grade4.png'),
                  )
                ]
            )
        )
    );
  }
}
//Last entry screen, the description for the fall.
class LastEntryScreen extends StatelessWidget {
  final Entry E; //Container for the entry
  LastEntryScreen({Key key, @required this.E}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please describe your fall:'),
      ),
      body: ListView(
        children: <Widget>[
          Card(child: ListTile(title: Text('While going to the bathroom'),
              onTap:(){
                E.setDescription("While going to the bathroom");
                createRecord(E);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()),);}
          ),
          ),
          Card(
            child: ListTile(
                title: Text('Lightheadedness when standing'),
                onTap:(){
                  E.setDescription("Lightheadedness when standing.");
                  createRecord(E);
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()),);}
            ),
          ),
          Card(
              child: ListTile(
                  title: Text('Related to feeling dizzy'),
                  onTap: (){
                    E.setDescription("Related to feeling dizzy");
                    createRecord(E);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);}
              )
          ),
          Card(
            child: ListTile(
                title: Text('Tripped over object'),
                onTap: (){
                  E.setDescription("Tripped over object.");
                  createRecord(E);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);}
            ),
          ),
          Card(
              child: ListTile(
                  title: Text('Was due to a poorly lit environment'),
                  onTap: (){
                    E.setDescription("Was due to a poorly lit environment.");
                    createRecord(E);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);}
              )
          ),
          Card(
              child: ListTile(
                  title: Text('Other.'),
                  onTap: (){
                    //E.setDescription("Related to feeling dizzy");
                    createRecord(E);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);}
              )
          ),
        ],
      ),
    );
  }
}

CreateEntry(BuildContext context) {
  //Widget construction
  Widget noButton = FlatButton(
    child: Text("No"),
    onPressed: (){
      Navigator.of(context).pop(); // Removes the dialog box.
    },
  );
  Widget yesButton = FlatButton(
    child: Text("Yes"),
    onPressed: () { // A new entry will be created.
      Entry dataEntry = new Entry();
      EntryInjury(context, dataEntry);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => TODO()),);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Did you fall?"),
    content: Text("Did you experince a fall?"),
    actions: [
      noButton,
      yesButton,
    ],
  );
  //Show the dialog box
  showDialog(
    context: context,
    builder: (BuildContext context){
      return alert;
    },
  );
}
EntryInjury(BuildContext context, Entry E) {
  //Widget construction
  Widget noButton = FlatButton(
    child: Text("No"),
    onPressed: (){
      E.setInjuried(false);
      Navigator.push(context, MaterialPageRoute(builder: (context) => EntryThirdScreen(E: E)),);
    },
  );
  Widget yesButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      E.setInjuried(true);
      Navigator.push(context, MaterialPageRoute(builder: (context) => EntryThirdScreen(E: E)),);
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      //Navigator.of(context).popUntil(ModalRoute.withName('Main Page'));
      //Navigator.push(context, MaterialPageRoute(builder: (context) => TODO()),);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Injury"),
    content: Text("Did you experince an injury because of your fall?"),
    actions: [
      noButton,
      yesButton,
      cancelButton,

    ],
  );
  //Show the dialog box
  showDialog(
    context: context,
    builder: (BuildContext context){
      return alert;
    },
  );
}

//Third entry screen, the time of day for the fall.
class EntryThirdScreen extends StatelessWidget {
  final Entry E; //Container for the entry
  EntryThirdScreen({Key key, @required this.E}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What Time of day was your fall?'),
      ),
      body: ListView(
        children: <Widget>[
          Card(child: ListTile(title: Text('Morning'),
              onTap:(){
                E.setTimeDay("Morning");
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageDisplayer(E: E,)),);}
          ),
          ),
          Card(
            child: ListTile(
                title: Text('Daytime'),
                onTap:(){
                  E.setTimeDay("Daytime");
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageDisplayer(E: E,)),);}
            ),
          ),
          Card(
              child: ListTile(
                  title: Text('Evening'),
                  onTap: (){
                    E.setTimeDay("Evening");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDisplayer(E: E,)),);}
              )
          ),
          Card(
            child: ListTile(
                title: Text('Night'),
                onTap: (){
                  E.setTimeDay("Night");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDisplayer(E: E,)),);}
            ),
          ),
        ],
      ),
    );
  }
}
DateTime dateQ = new DateTime.now();

class DateList extends StatefulWidget{
  State createState() => new DateState();
}

class DateState extends State<DateList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose From when'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Entries From today'),
              onTap: (){
                dateQ = new DateTime.now();
                dateQ = dateQ.subtract(new Duration(days: 1));
                Navigator.push(context, MaterialPageRoute(builder: (context) => EntryList()),);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Entries From the past week'),
              onTap: (){
                dateQ = new DateTime.now();
                dateQ = dateQ.subtract(new Duration(days: 7));
                Navigator.push(context, MaterialPageRoute(builder: (context) => EntryList()),);
              },
            ),

          ),
          Card(
            child: ListTile(
              title: Text('Entries From the past 30 days'),
              onTap: (){
                dateQ = new DateTime.now();
                dateQ = dateQ.subtract(new Duration(days: 30));
                Navigator.push(context, MaterialPageRoute(builder: (context) => EntryList()),);
              },
            ),

          ),
        ],
      ),
    );
  }

}
class DateList2 extends StatefulWidget{
  State createState() => new DateState2();
}
class DateState2 extends State<DateList2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose From when'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Entries From today'),
              onTap: (){
                dateQ = new DateTime.now();
                dateQ = dateQ.subtract(new Duration(days: 1));
                Navigator.push(context, MaterialPageRoute(builder: (context) => EntryList()),);
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Entries From the past week'),
              onTap: (){
                dateQ = new DateTime.now();
                dateQ = dateQ.subtract(new Duration(days: 7));
                Navigator.push(context, MaterialPageRoute(builder: (context) => EntryList()),);
              },
            ),

          ),
          Card(
            child: ListTile(
              title: Text('Entries From the past 30 days'),
              onTap: (){
                dateQ = new DateTime.now();
                dateQ = dateQ.subtract(new Duration(days: 30));
                Navigator.push(context, MaterialPageRoute(builder: (context) => EntryList()),);
              },
            ),

          ),
        ],
      ),
    );
  }

}
String patientUID;
class UserDataView extends StatefulWidget{
  State createState() => new UserViewState();
}
class UserViewState extends State<UserDataView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose User data to view'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('View mytest123@gmail.com Entries'),
              onTap: (){
                patientUID = 'y1KvwpD26dT3nEloeFtXvJMx6Dr2';
                Navigator.push(context, MaterialPageRoute(builder: (context) => DateList()),);
              },
            ),

          ),
          Card(
            child: ListTile(
              title: Text('View captester202.com Entries'),
              onTap: (){
                patientUID = 'XGCeGQMcBvPKkUIYTEqUPQ67IaK2';
                Navigator.push(context, MaterialPageRoute(builder: (context) => DateList()),);
              },
            ),

          ),
          Card(
            child: ListTile(
              title: Text('View all Entries'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DateList()),);
              },
            ),

          ),

        ],
      ),
    );
  }
}
class EntryList extends StatefulWidget{
  State createState() => new EntryListState();
}

class EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('entries').where('date', isGreaterThanOrEqualTo: dateQ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new Card(
                  child: ListTile(
                  title: new Text(document['date'].toDate().toString()),
                    subtitle: new Text(document['patientID'].toString()),
                  )
                );
              }).toList(),
            );
        }
      },
    );
  }
}

class EntryList2 extends StatefulWidget{
  State createState() => new EntryListState2();
}

class EntryListState2 extends State<EntryList2> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('entries').where('patientID', isEqualTo: patientUID).where('date', isGreaterThanOrEqualTo: dateQ).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new Card(
                    child: ListTile(
                      title: new Text(document['date'].toDate().toString()),
                      subtitle: new Text(document['patientID'].toString()),
                    )
                );
              }).toList(),
            );
        }
      },
    );
  }
}
