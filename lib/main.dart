import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2757), // change to baklazhan
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("Baklandoro App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "00:00:00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {},
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue)),
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.flag)),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {},
                      fillColor: Colors.blue,
                      shape: StadiumBorder(),
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
