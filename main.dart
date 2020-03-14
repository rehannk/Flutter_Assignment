import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment',
      home: MyHomePage(title: 'GitHub Users List'),
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
  Future<List<Employee>> _getUsers() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/users");

    var jsonData = json.decode(data.body);

    List<Employee> users = [];

    for (var u in jsonData) {
      Employee user = Employee(
        u["id"],
        u["name"],
        u["username"],
        u["email"],
        u["street"],
        u["suite"],
        u["city"],
        u["zipcode"],
        u["lat"],
        u["lng"],
        u["phone"],
        u["website"],
        u["company"]["name"],
        u["catchPhrase"],
        u["bs"],
      );

      users.add(user);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.black87),
                    title: Text(snapshot.data[index].name),
                    //subtitle: Text(snapshot.data[index].cname),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class Employee {
  final int id;
  final String name;
  final String username;
  final String email;

  //Address
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  //Geo Location
  final String lat;
  final String lng;

  final String phone;
  final String website;

  //Company
  final String cname;
  final String catchPhrase;
  final String bs;

  Employee(
      this.id,
      this.name,
      this.username,
      this.email,
      this.street,
      this.suite,
      this.city,
      this.zipcode,
      this.lat,
      this.lng,
      this.phone,
      this.website,
      this.cname,
      this.catchPhrase,
      this.bs);
}

class DetailPage extends StatelessWidget {
  final Employee user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF424242),
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text("About"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment(-0.90, 0.90),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://www.twilight-zone.nl/WebRoot/Pins/Shops/Twilightzone/5DE8/E6F3/5F9D/7B0D/0944/0A0C/05BA/7BE7/SS400329_0_ml.jpg'),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      user.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      user.phone,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  children: <Widget>[
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                      color: Colors.black,
                      child: ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Color(0xFF424242),
                        ),
                        title: Text(
                          'Member Since',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF424242),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro'),
                        ),
                        subtitle: Text(
                          '11 March 2011',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Color(0xFF424242),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 01.0, horizontal: 5.0),
                      color: Colors.black,
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Color(0xFF424242),
                        ),
                        title: Text(
                          'Achievements',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF424242),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro'),
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(15.0, 5.0, 5.0,20.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              width: 120.0,
                              padding: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            SizedBox(width:10),
                            Container(
                              height: 100.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            SizedBox(width:10),
                            Container(
                              height: 200.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            SizedBox(width:10),
                            Container(
                              height: 200.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            SizedBox(width:10),
                            Container(
                              height: 200.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.moveTo(0, 40);

    var controllPoint = Offset(20, 0); //
    var endPoint = Offset(50, 0);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return null;
  }
}

