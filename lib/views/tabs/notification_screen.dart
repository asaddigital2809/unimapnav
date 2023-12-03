import 'package:flutter/material.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.deepPurple),
            title: const Text('New Notification'),
            subtitle: Text('Description of notification #$index'),
           
            onTap: () {

            },
          );
        },
      ),
    );
  }
}
