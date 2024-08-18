import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sokoai/app/common.dart';
import 'package:sokoai/data/network/failture.dart';
import 'package:sokoai/data/repository/repository.dart';
import 'package:sokoai/presentation/resources/constants_manager.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Repository _repository;
  ChatBloc(this._repository) : super(ChatInitial()) {
    on<SendMessage>(_sendMessage);

    on<PickImage>(_pickImage);
    // on<StartListeningToVoice>(_startListening);
  }
  // final SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  // initChat() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   emit(ChatInitial());
  // }

  final ChatUser _me = ChatUser(id: '0', firstName: 'Me');
  final ChatUser _ai = ChatUser(id: '1', firstName: ConstantsManager.appName);
  final List<Content> _inputs = [];
  FutureOr<void> _sendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    final String input = event.input;
    List<ChatMessage> messages = _getCurrentMessage();

    if (messages.isNotEmpty &&
        messages.first.medias != null &&
        messages.first.medias!.isNotEmpty) {
      log('has image');
      final image = File(messages.first.medias!.first.url);

      Uint8List bodybytes = await image.readAsBytes();
      _inputs.add(Content.multi([
        TextPart(input),
        DataPart('image/jpeg', bodybytes),
      ]));
    } else {
      _inputs.add(Content.text(input));
    }
    messages.insert(
        0,
        ChatMessage(
          user: _me,
          createdAt: DateTime.now(),
          text: input,
        ));

    emit(ChatLoaded(messages));

    emit(ChatLoading(messages, [_ai]));
    final response = await _repository.getContent(_inputs);
    response.fold((Failture failture) {
      messages[0].status = MessageStatus.failed;

      emit(ChatError(messages, failture.message));
    }, (String response) {
      messages.insert(
          0, ChatMessage(user: _ai, createdAt: DateTime.now(), text: response));
      emit(ChatLoaded(messages));
    });
  }

  FutureOr<void> _pickImage(PickImage event, Emitter<ChatState> emit) async {
    final image = await getImage();
    if (image != null) {
      List<ChatMessage> messages = _getCurrentMessage();
      messages.insert(
        0,
        ChatMessage(
          user: _me,
          createdAt: DateTime.now(),
          text: '',
          medias: [
            ChatMedia(
              url: image.path,
              fileName: image.path,
              type: MediaType.image,
            ),
          ],
        ),
      );
      emit(ChatLoaded(messages));
    }
  }

  // FutureOr<void> _startListening(
  //     StartListeningToVoice event, Emitter<ChatState> emit) async {
  //   await _speechToText.listen(onResult: (SpeechRecognitionResult result) {});
  // }

  List<ChatMessage> _getCurrentMessage() {
    final List<ChatMessage> messages = state.messages.map((e) {
      return e;
    }).toList();
    return messages;
  }
}
