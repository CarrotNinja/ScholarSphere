import 'package:flutter/material.dart';

class AdvancedChatbot extends StatefulWidget {
  @override
  _AdvancedChatbotState createState() => _AdvancedChatbotState();
}

class _AdvancedChatbotState extends State<AdvancedChatbot> {
  final TextEditingController _textController = TextEditingController();
  List<String> _chatMessages = [];

  final Map<String, String> responses = {
    "login": "To get started, please login or signup first. Once logged in, you can explore the application, display and share your portfolio, and much more.",
    "signup": "To get started, please login or signup first. Once logged in, you can explore the application, display and share your portfolio, and much more.",
    "get started": "To get started, please login or signup first. Once logged in, you can explore the application, display and share your portfolio, and much more.",
    "upload transcript": "You can upload your transcripts and display your grades (like GPA) within the app. Simply navigate to the upload section and follow the instructions.",
    "grades": "You can upload your transcripts and display your grades (like GPA) within the app. Simply navigate to the upload section and follow the instructions.",
    "gpa": "You can upload your transcripts and display your grades (like GPA) within the app. Simply navigate to the upload section and follow the instructions.",
    "awards": "You can showcase your personalized awards, clubs, and extracurricular activities in your portfolio. Head over to the portfolio section to add these details.",
    "clubs": "You can showcase your personalized awards, clubs, and extracurricular activities in your portfolio. Head over to the portfolio section to add these details.",
    "extracurriculars": "You can showcase your personalized awards, clubs, and extracurricular activities in your portfolio. Head over to the portfolio section to add these details.",
    "forgot password": "If you've forgotten your password, click on the 'Forgot Password' button on the login page to reset it.",
    "share portfolio": "You can share your portfolio with others and post it on social media. Additionally, you can save your portfolio as a specific file type.",
    "social media": "You can share your portfolio with others and post it on social media. Additionally, you can save your portfolio as a specific file type.",
    "save file": "You can share your portfolio with others and post it on social media. Additionally, you can save your portfolio as a specific file type.",
    "welcome screen": "Our app features a welcome screen, a to-do list, a home page, and a settings page to help you manage and customize your experience.",
    "to do list": "Our app features a welcome screen, a to-do list, a home page, and a settings page to help you manage and customize your experience.",
    "home page": "Our app features a welcome screen, a to-do list, a home page, and a settings page to help you manage and customize your experience.",
    "settings": "Our app features a welcome screen, a to-do list, a home page, and a settings page to help you manage and customize your experience.",
    "how does the app work": "Our app allows you to create and manage your high school portfolio. You can upload your transcripts, display your grades, showcase your awards and extracurricular activities, and share your portfolio with others. Explore the app to discover more features!",
    "app functionality": "Our app allows you to create and manage your high school portfolio. You can upload your transcripts, display your grades, showcase your awards and extracurricular activities, and share your portfolio with others. Explore the app to discover more features!",
    "features": "Our app allows you to create and manage your high school portfolio. You can upload your transcripts, display your grades, showcase your awards and extracurricular activities, and share your portfolio with others. Explore the app to discover more features!",
    "what can this app do": "This app helps you manage and showcase your high school portfolio. You can upload and display your grades, achievements, and extracurricular activities, share your portfolio on social media, and customize your profile with various features.",
    "how to reset password": "If you forgot your password, you can reset it by clicking on the 'Forgot Password' button on the login page and following the instructions.",
    "forgot my password": "If you forgot your password, you can reset it by clicking on the 'Forgot Password' button on the login page and following the instructions.",
    "customize my profile": "To customize your profile, go to the settings page where you can update your personal information, change your profile picture, and adjust other preferences.",
    "profile settings": "To customize your profile, go to the settings page where you can update your personal information, change your profile picture, and adjust other preferences."
  };

  void _handleSubmitted(String message) {
    setState(() {
      _chatMessages.add("User: $message");
      String response = responses[message.toLowerCase().trim()]!;
      _chatMessages.add("Bot: $response");
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scholar Sphere Chatbot'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[100]!, Colors.purple[50]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.orange[100] : Colors.purple[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      _chatMessages[index],
                      style: TextStyle(
                        color: index % 2 == 0 ? Colors.orange[900] : Colors.purple[900],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    _handleSubmitted(_textController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
