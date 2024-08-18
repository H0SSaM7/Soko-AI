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

  const ChatLoading(
    this.currentMessages,
    this.typingUsers,
  );
}

final class ChatLoaded extends ChatState {
  final List<ChatMessage> loadedMessages;

  @override
  List<ChatMessage> get messages => loadedMessages;

  const ChatLoaded(
    this.loadedMessages,
  );
}

final class ChatError extends ChatState {
  final String err;
  final List<ChatMessage> currentMessages;

  @override
  List<ChatMessage> get messages => currentMessages;

  const ChatError(this.currentMessages, this.err);
}

// final class ChatSpeechLoading extends ChatState {
//   final List<ChatMessage> currentMessages;

//   @override
//   List<ChatMessage> get messages => currentMessages;

//   const ChatSpeechLoading(
//     this.currentMessages,
//   );
// }

// final class ChatSpeechLoaded extends ChatState {
//   final List<ChatMessage> currentMessages;

//   @override
//   List<ChatMessage> get messages => currentMessages;

//   const ChatSpeechLoaded(
//     this.currentMessages,
//   );
// }

// final class ChatSpeechError extends ChatState {
//   final List<ChatMessage> currentMessages;

//   @override
//   List<ChatMessage> get messages => currentMessages;

//   const ChatSpeechError(
//     this.currentMessages,
//   );
// }
