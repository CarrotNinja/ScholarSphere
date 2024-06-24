import 'package:flutter/material.dart';

class AdvancedChatbot extends StatefulWidget {
  @override
  _AdvancedChatbotState createState() => _AdvancedChatbotState();
}

class _AdvancedChatbotState extends State<AdvancedChatbot> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({
        'data': 1,
        'message': _controller.text,
      });
    });

    // Simulate a chatbot response
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'data': 0,
          'message': _generateResponse(_controller.text),
        });
        _scrollToBottom();
      });
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _generateResponse(String input) {
    // Response generation logic for a high school portfolio app
    String lowerInput = input.toLowerCase();
    if (lowerInput.contains("login") || lowerInput.contains("signup") || lowerInput.contains("get started")) {
      return "To get started, please login or signup first. Once logged in, you can explore the application, display and share your portfolio, and much more.";
    } else if (lowerInput.contains("upload transcript") || lowerInput.contains("grades") || lowerInput.contains("gpa")) {
      return "You can upload your transcripts and display your grades (like GPA) within the app. Simply navigate to the upload section and follow the instructions.";
    } else if (lowerInput.contains("awards") || lowerInput.contains("clubs") || lowerInput.contains("extracurriculars")) {
      return "You can showcase your personalized awards, clubs, and extracurricular activities in your portfolio. Head over to the portfolio section to add these details.";
    } else if (lowerInput.contains("forgot password")) {
      return "If you've forgotten your password, click on the 'Forgot Password' button on the login page to reset it.";
    } else if (lowerInput.contains("share portfolio") || lowerInput.contains("social media") || lowerInput.contains("save file")) {
      return "You can share your portfolio with others and post it on social media. Additionally, you can save your portfolio as a specific file type.";
    } else if (lowerInput.contains("welcome screen") || lowerInput.contains("to do list") || lowerInput.contains("home page") || lowerInput.contains("settings")) {
      return "Our app features a welcome screen, a to-do list, a home page, and a settings page to help you manage and customize your experience.";
    } else {
      return "I'm not sure how to respond to that. Please ask a question related to the high school portfolio app.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scholar Sphere Chatbot'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatMessage(
                data: _messages[index]['data'],
                message: _messages[index]['message'],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final int data;
  final String message;

  ChatMessage({required this.data, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: data == 1 ? Colors.orange : Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
