import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sokoai/app/di.dart';
import 'package:sokoai/presentation/resources/values_manager.dart';
import 'package:typewritertext/typewritertext.dart';

import '../viewModel/chat_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final TextEditingController controller;
  final GlobalKey<ScaffoldState> homekey = GlobalKey();
  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(getIt()),
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            log(state.err);

            final snackbar = SnackBar(content: Text(state.err));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppWidth.s16, vertical: AppHeight.s12),
              child: Column(
                children: [
                  Expanded(
                    child: state.messages.isEmpty
                        ? Center(
                            child: TypeWriter.text(
                              'My name is Soko AI and I\'m here to help you. \n What is going on in your mind?',
                              textAlign: TextAlign.center,
                              duration: const Duration(milliseconds: 50),
                            ),
                          )
                        : DashChat(
                            typingUsers:
                                state is ChatLoading ? state.typingUsers : [],
                            currentUser: ChatUser(id: '0', firstName: 'Me'),
                            onSend: (ChatMessage m) {},
                            messages: state.messages,
                            readOnly: true,
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
                      SizedBox(width: AppWidth.s10),
                      InkWell(
                        onTap: () => context.read<ChatBloc>().add(PickImage()),
                        child: const Icon(Icons.image),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ChatBloc>()
                              .add(SendMessage(input: controller.text));
                          controller.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            minimumSize: Size(AppWidth.s35, AppHeight.s35)),
                        child: Icon(
                          Icons.send,
                          size: AppSize.s18,
                        ),
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
