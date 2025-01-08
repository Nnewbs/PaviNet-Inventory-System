import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pavinet/customstyles/customStyles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // Ensure Firebase is initialized
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }
  runApp(const Chat());
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _formKey = GlobalKey<FormState>();
  final List<ChatList> _allChats = [];
  final TextEditingController userController = TextEditingController();
  final TextEditingController msgController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _setupChatsListener();
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  void _setupChatsListener() {
    FirebaseFirestore.instance
        .collection('messages')
        .orderBy("datetime", descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _allChats.clear();
        for (var doc in snapshot.docs) {
          final data = doc.data();

          // check fetch in debug console
          print(doc.data());

          _allChats.add(ChatList(
            id: doc.id,
            user: data['user'] ?? '',
            message: data['message'] ?? '',
            datetime:
                (data['datetime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          ));
        }
      });
    });
  }

  Future<void> _fetchUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .timeout(const Duration(seconds: 10));

        if (userDoc.exists) {
          if (mounted) {
            setState(() {
              userController.text = userDoc.data()?['name'] ?? '';
            });
          }
        } else {
          if (mounted) {
            setState(() {
              userController.text = '';
            });
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user is logged in')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error fetching user: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch user: ${e.toString()}')),
        );
        setState(() {
          userController.text = '';
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('Failed...');
      return;
    }

    // final bool

    setState(() => _isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Must logged in to send message')),
        );
      }
      return;
    } else {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(const Duration(seconds: 10));

      if (userDoc.exists) {
        if (mounted) {
          setState(() {
            userController.text = userDoc.data()?['name'] ?? 'Default Supplier';
          });
        }
      }
    }

    final msgData = {
      'datetime': DateTime.now(),
      'message': msgController.text,
      'user': userController.text,
      'userId': user.uid,
    };

    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .add(msgData)
          .timeout(const Duration(seconds: 10));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully')),
        );

        // clear field after successful submission
        msgController.clear();
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                // message text box container
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            child: Scrollbar(
                              child: TextField(
                                controller: msgController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.multiline,
                                minLines:
                                    1, //Normal textInputField will be displayed
                                maxLines:
                                    5, // when user presses enter it will adapt to it
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                style: CustomButtonStyle.bgButton,
                                onPressed: _isLoading ? null : _sendMessage,
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'SEND',
                                        style: CustomeTextStyle.txtWhiteBold,
                                      )),
                          ),
                          SizedBox(height: 16),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _allChats.length,
                  itemBuilder: (context, index) {
                    final chat = _allChats[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 1,
                      ),
                      color: Colors.grey.shade200,
                      child: ListTile(
                        title: Text(
                          chat.user,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(chat.message),
                        trailing: Text(
                            chat.datetime.toLocal().toString().split('.')[0]),
                      ),
                    );
                  }))
        ],
      ),
      // ),
      // )
    );
  }
}

class ChatList {
  final String id;
  final String user;
  final String message;
  final DateTime datetime;

  ChatList({
    required this.id,
    required this.user,
    required this.message,
    required this.datetime,
  });
}
