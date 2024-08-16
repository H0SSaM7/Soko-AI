part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendMessage extends ChatEvent {
  final String input;

  SendMessage({required this.input});
}
