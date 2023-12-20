import 'package:flutter/material.dart';
import 'package:order/pages/order_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: ()async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('TOKEN', "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJEZXZpY2VJZCI6IkRWQzAwMDAxMCIsIkJyYW5jaElkIjoiU1lMMDAwMiIsImlhdCI6MTcwMjg3MTYxNSwiZXhwIjoxNzAzNDc2NDE1fQ.GqAhnrEG8OKCxWqV58oHphhn-BVqlFjSTGv_EjJu_rk");
print(prefs.get("TOKEN"));
                if (mounted) setState(() {});
              },
              child: Text('Looks like a RaisedButton'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderListPage()),
                );
              },
              child: Text('Looks like a RaisedButton'),
            )
          ],
        ),
      ),

    );
  }
}
