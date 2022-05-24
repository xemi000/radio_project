import 'package:Radios/pages/genre.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

const avatarImageRadius = 60.0;

class SmartScreen extends StatefulWidget {
  @override
  State<SmartScreen> createState() => _SmartScreenState();
}

class _SmartScreenState extends State<SmartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Color.fromARGB(227, 255, 229, 236),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(227, 255, 229, 236),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(227, 255, 229, 236),
                          width: 0.05)),
                  labelText: 'search',
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Featured Smart Scans',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Row(children: [
                Expanded(
                    child: CircleAvatar(
                  backgroundImage: AssetImage('Assets/download (1).jpg'),
                  radius: avatarImageRadius,
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: CircleAvatar(
                  backgroundImage: AssetImage('Assets/images.jpg'),
                  radius: avatarImageRadius,
                )),
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 45,
                  ),
                  GestureDetector(
                    child: Expanded(
                      child: Container(
                          child: Text(
                        'Rock',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Genre(
                                  isFavouriteOnly: false,
                                ))),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        'Alternative',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: const [
                  Expanded(
                      child: CircleAvatar(
                    backgroundImage: AssetImage('Assets/download (2).jpg'),
                    radius: avatarImageRadius,
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CircleAvatar(
                    backgroundImage: AssetImage('Assets/download.jpg'),
                    radius: avatarImageRadius,
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Expanded(
                    child: Container(
                        child: Text(
                      'Jazz',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        'Hip Pop',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Radio Station by Genre',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 2,
                thickness: 1,
                color: Color.fromARGB(227, 255, 229, 236),
                indent: 0,
              ),
              const ListTile(
                title: Text('Alternative'),
                trailing: Icon(Icons.arrow_forward),
              ),
              const Divider(
                height: 2,
                thickness: 1,
                color: Color.fromARGB(227, 255, 229, 236),
                indent: 0,
              ),
              const ListTile(
                title: Text('Blues'),
                trailing: Icon(Icons.arrow_forward),
              ),
              const Divider(
                height: 2,
                thickness: 1,
                color: Color.fromARGB(227, 255, 229, 236),
                indent: 0,
              ),
              const ListTile(
                title: Text('hip pop'),
                trailing: Icon(Icons.arrow_forward),
              ),
              const Divider(
                height: 2,
                thickness: 1,
                color: Color.fromARGB(227, 255, 229, 236),
                indent: 0,
              ),
              const ListTile(
                title: Text('jazz'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
