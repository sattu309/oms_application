import 'package:flutter/material.dart';

import 'Homepage.dart';

class UserSelectionScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Chat User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter receiver's email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final receiverEmail = _controller.text.trim();
                if (receiverEmail.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(receiverEmail: receiverEmail),
                    ),
                  );
                }
              },
              child: Text("Start Chat"),
            ),
          ],
        ),
      ),
    );
  }
}
