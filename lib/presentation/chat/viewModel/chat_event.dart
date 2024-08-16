part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendMessage extends ChatEvent {
  final String input;

  SendMessage({required this.input});
}

final class SendMessageWithImage extends ChatEvent {
  final String input;
  final String image;
  SendMessageWithImage({
    required this.input,
    required this.image,
  });
}

final class PickImage extends ChatEvent {}
