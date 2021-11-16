import 'package:flutter/material.dart';
import 'package:restaurant_denis/common/style.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preference"),
        elevation: 0,
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          Material(
            child: ListTile(
              title: Text('Dark Mode'),
              trailing: Switch.adaptive(
                value: false,
                onChanged: (value) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Not available'),
                        content: Text('This feature will be coming soon!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Ok'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
