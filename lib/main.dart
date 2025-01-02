import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String notification = "";

  @override
  void initState() {
    super.initState();
    OneSignal.shared.setAppId(
        "503e0036-a335-4362-847b-eae9dbee987a"); // Initialize OneSignal
  }

  void checkForAlarm() async {
    final response =
        await http.get(Uri.parse('https://onesignal.com/api/v1/notifications'));
    if (response.statusCode == 200) {
      setState(() {
        notification = "Check your car!";
      });
    } else {
      setState(() {
        notification = "No alarm";
      });
    }
  }

  void stopNotification() {
    setState(() {
      notification = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Alarm Notifier"),
        backgroundColor: Colors.black, // AppBar background color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                notification,
                style: const TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 243, 240, 240), // Button color
                ),
                onPressed: stopNotification,
                child: const Text("Stop Notification"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black, // FloatingActionButton color
        onPressed: checkForAlarm,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
