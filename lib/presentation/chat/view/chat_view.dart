import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sokoai/app/di.dart';
import 'package:sokoai/presentation/resources/values_manager.dart';

import '../../../app/app_constants.dart';
import '../viewModel/chat_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(getIt()),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppWidth.s16, vertical: AppHeight.s12),
              child: Column(
                children: [
                  Expanded(
                    child: DashChat(
                      typingUsers:
                          state is ChatLoading ? state.typingUsers : [],
                      readOnly: true,
                      currentUser: ChatUser(id: '0', firstName: 'Me'),
                      onSend: (ChatMessage m) {},
                      messages: state.messages,
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
                          // getAiResponse();
                          context
                              .read<ChatBloc>()
                              .add(SendMessage(input: controller.text));
                          controller.clear();
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
        },
      ),
    );
  }
}
