import 'package:dash_chat_2/dash_chat_2.dart';
import '../services/chat_services.dart';

class ChatState {
  List<ChatMessage> messages = [];
  List<ChatUser> typing = [];
  ChatService chatService;
  ChatUser bot;

  ChatState({required this.chatService, required this.bot});

  void addMessage(ChatMessage message) {
    messages.insert(0, message);
  }

  Future<void> sendMessage(String text, ChatUser user) async {
    // Adiciona imediatamente a mensagem do usuário
    ChatMessage userMessage = ChatMessage(
      text: text,
      user: user,
      createdAt: DateTime.now(),
    );
    addMessage(userMessage);

    // Indicador de "digitando" do bot
    setUserTyping(bot, true);

    // Aguarda a resposta do bot
    ChatMessage? response = await chatService.sendMessage(text);

    // Remove o indicador de "digitando" do bot
    setUserTyping(bot, false);

    if (response != null) {
      addMessage(response);
    }
  }

  void setUserTyping(ChatUser user, bool isTyping) {
    if (isTyping) {
      typing.add(user);
    } else {
      typing.remove(user);
    }
  }
}
