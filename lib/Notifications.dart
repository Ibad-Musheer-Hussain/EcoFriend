import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationCard(
            title: 'Welcome to EchoFriendly App!',
            message:
                'Thank you for joining us. Explore and find great products.',
            time: '2 mins ago',
            icon: Icons.star,
            color: Colors.blue,
          ),
          _buildNotificationCard(
            title: 'New Feature Alert',
            message: 'We have added new filters for your searches.',
            time: '1 hour ago',
            icon: Icons.new_releases,
            color: Colors.orange,
          ),
          _buildNotificationCard(
            title: 'Update Available',
            message:
                'A new version of the app is available. Please update to get the latest features.',
            time: 'Yesterday',
            icon: Icons.update,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(time, style: const TextStyle(color: Colors.grey)),
        contentPadding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
