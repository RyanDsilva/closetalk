import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class FormComponent extends StatelessWidget {
  final bool termsAccepted;

  const FormComponent({super.key, required this.termsAccepted});

  void _changeAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an Avatar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: RandomAvatar('avatar1', height: 50, width: 50),
                  onTap: () {
                    // Handle avatar change
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: RandomAvatar('avatar2', height: 50, width: 50),
                  onTap: () {
                    // Handle avatar change
                    Navigator.of(context).pop();
                  },
                ),
                // Add more avatars as needed
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RandomAvatar(
              DateTime.now().toIso8601String(),
              height: 50,
              width: 52,
            ),
            TextButton(
              onPressed: () => _changeAvatar(context),
              child: const Text('Change Avatar'),
            ),
          ],
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'User Name'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Intro'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Language'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: termsAccepted ? () {} : null,
          child: const Text('Save'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {},
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
