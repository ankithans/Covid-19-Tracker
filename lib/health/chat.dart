import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:covid19_tracker_application/health/chat_bubble.dart';
import 'package:covid19_tracker_application/health/animations/typing_message.dart';

class Chat extends StatefulWidget {
  final String text;

  Chat({this.text});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool showTyping = true;
  TypingMessage _typingMessage;

  @override
  void initState() {
    _typingMessage = TypingMessage();
    Future.delayed(const Duration(seconds: 1), () {
      showTyping = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showTyping
        ? DelayedDisplay(
      child: _typingMessage,
    )
        : ChatBubble(
      child: Text(
        widget.text,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          //fontWeight: FontWeight.normal,
          color: Color(0xFF325384),
        ),
      ),
    );
  }
}
