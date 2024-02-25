import 'package:closetalk/models/user.dart';
import 'package:closetalk/screens/home.dart';
import 'package:closetalk/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

void main() {
  runApp(const HomeUI());
}

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: const Chatpage());
  }
}

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(129, 42, 83, 1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(129, 42, 83, 1), // AppBar color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), // Bottom left radius
              bottomRight: Radius.circular(20), // Bottom right radius
            ),
          ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Removes shadow
            leading: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: RandomAvatar("string1")), // Your leading widget

            // Uncomment title if you need it
            // title: const Text("Flutter app2"),
          ),
        ),
      ),
      body: ChatScreen1(), // Your chat screen widget
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          print('Floating Action Button Pressed');
        },
        child: Icon(Icons.add), // Plus icon
        backgroundColor: Color.fromRGBO(129, 42, 83, 1), // Customizable color
      ),
    );
  }
}
// class _ChatpageState extends State<Chatpage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(239, 227, 233, 1),
//       appBar: AppBar(
//         //title: const Text("Flutter app2"),
//         backgroundColor: const Color.fromRGBO(129, 42, 83, 1),
//         leading: RandomAvatar("string1"),

//         actions: [
//           // Adding Container around the icon
//           Row(
//             children: [RandomAvatar("string1")],
//             mainAxisAlignment: MainAxisAlignment.start,
//           ),
//         ],
//       ),
//       body: ChatScreen1(),
//     );
//   }
// }

class ChatScreen1 extends StatelessWidget {
  List<ChatBubble> users = [
    const ChatBubble(message: "Hello", sender: "Ria", timestamp: "10:00"),
    const ChatBubble(message: "work", sender: "Maya", timestamp: "12:00")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(223, 186, 204, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListView.builder(
            itemCount: users.length, // Number of chat messages
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(radius: 28, child: RandomAvatar("avatar2")),
                  title: Text(users.elementAt(index).sender),
                  subtitle: Text(users.elementAt(index).message),
                  trailing: Text(users.elementAt(index).timestamp),
                  onTap: (){
                    print("tap is being initialed");
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
                  }
                  );

              // message: 'Message $index', // Message content
              // sender: 'Sender $index', // Sender's name
              // timestamp: '10:00 AM',
            }));
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String sender;
  final String timestamp;

  const ChatBubble({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(sender[0]), // Display first letter of sender's name
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(129, 42, 83, 1),
                      height: 3),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.0),
          // Text(
          //   timestamp,
          //   style: TextStyle(fontSize: 12.0, color: Colors.grey),
          // ),
        ],
      ),
    );
  }
}
