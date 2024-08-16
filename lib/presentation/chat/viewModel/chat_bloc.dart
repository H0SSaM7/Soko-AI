import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sokoai/data/network/failture.dart';
import 'package:sokoai/data/repository/repository.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Repository _repository;
  ChatBloc(this._repository) : super(ChatInitial()) {
    on<SendMessage>(_sendMessage);
  }
  final ChatUser _me = ChatUser(id: '0', firstName: 'Me');
  final ChatUser _ai = ChatUser(id: '1', firstName: 'Gemini Pro');
  final List<Content> _inputs = [];
  FutureOr<void> _sendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    List<ChatMessage> messages = state.messages.map((e) {
      return e;
    }).toList();

    messages.insert(0,
        ChatMessage(user: _me, createdAt: DateTime.now(), text: event.input));

    emit(ChatLoaded(messages));
    _inputs.add(Content.text(event.input));
    emit(ChatLoading(messages, [_ai]));
    final response = await _repository.getContent(_inputs);
    response.fold((Failture failture) {
      emit(ChatError());
    }, (String response) {
      messages.insert(
          0, ChatMessage(user: _ai, createdAt: DateTime.now(), text: response));
      emit(ChatLoaded(messages));
    });
  }
}
