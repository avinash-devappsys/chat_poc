import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinode/tinode.dart';

class RecentChatScreen extends StatefulWidget {
  const RecentChatScreen({super.key, required this.tinode});

  final Tinode tinode;

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen> {
  @override
  Widget build(BuildContext context) {
    print("tinodeChats: ${widget.tinode.getMeTopic()}");
    return const Scaffold(
      body: Text("No chats"),
    );
  }
}
