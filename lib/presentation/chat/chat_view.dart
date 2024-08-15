import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sokoai/presentation/resources/values_manager.dart';

import '../../app/app_constants.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Me',
    lastName: '',
  );
  ChatUser ai = ChatUser(
    id: '2',
    firstName: 'Gemini',
    lastName: 'Pro',
  );
  List<Content> aiConversation = [];
  List<ChatMessage> messages = [];
  late final GenerativeModel model;
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    model = GenerativeModel(
        model: AppConstants.geminiPro, apiKey: AppConstants.apiKey);
    super.initState();
  }

  void getAiResponse() async {
    aiConversation.add(Content.text(controller.text));
    final message = ChatMessage(
      text: controller.text,
      user: user,
      createdAt: DateTime.now(),
    );

    messages.insert(0, message);

    setState(() {});
    final content = aiConversation;
    controller.clear();
    final response = await model.generateContent(content);

    final aiMessage = ChatMessage(
      text: response.text ?? "ERROR, TRY LATER",
      user: ai,
      createdAt: DateTime.now(),
    );
    messages.insert(0, aiMessage);
    setState(() {});
  }

  String aiResponse = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidth.s16, vertical: AppHeight.s12),
        child: Column(
          children: [
            Expanded(
              child: DashChat(
                readOnly: true,
                currentUser: user,
                onSend: (ChatMessage m) {},
                messages: messages,
              ),
            ),
            SizedBox(height: AppHeight.s16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    getAiResponse();
                  },
                  child: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      minimumSize: Size(AppWidth.s40, AppHeight.s40)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
