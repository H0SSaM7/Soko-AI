part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  final List<ChatMessage> messages;

  const ChatState({
    this.messages = const [],
  });
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {
  final List<ChatMessage> currentMessages;
  final List<ChatUser> typingUsers;

  @override
  List<ChatMessage> get messages => currentMessages;
  @override
  const ChatLoading(
    this.currentMessages,
    this.typingUsers,
  );
}

final class ChatLoaded extends ChatState {
  final List<ChatMessage> loadedMessages;

  @override
  List<ChatMessage> get messages => loadedMessages;
  @override
  const ChatLoaded(
    this.loadedMessages,
  );
}

final class ChatError extends ChatState {}
