import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final bool isRead;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.isRead = false,
  });
}

class ChatDetailScreen extends StatelessWidget {
  final String chatName;

  const ChatDetailScreen({super.key, required this.chatName});

  List<ChatMessage> get _messages => [
    ChatMessage(
      text: 'Belum ngerjain tugas yang part 2 nih',
      isMe: true,
      time: '06:04',
      isRead: true,
    ),
    ChatMessage(
      text: 'Itu harus pakai gambar diagram ya?',
      isMe: true,
      time: '06:05',
      isRead: true,
    ),
    ChatMessage(text: 'Iya, yang soal nomor 4', isMe: false, time: '06:05'),
    ChatMessage(
      text: 'Ohh, berarti nomor 1 teks aja',
      isMe: true,
      time: '06:09',
      isRead: true,
    ),
    ChatMessage(text: 'Okedeh', isMe: true, time: '06:09', isRead: true),
    ChatMessage(
      text: 'Kalian kumpulinnya dalam bentuk PPT?',
      isMe: false,
      time: '06:14',
    ),
    ChatMessage(text: 'Iyaa', isMe: true, time: '06:14', isRead: true),
    ChatMessage(text: 'Sistemnya bahas apa?', isMe: false, time: '06:16'),
    ChatMessage(text: 'Bahas perpustakaan juga?', isMe: false, time: '06:16'),
    ChatMessage(text: 'Iyah', isMe: true, time: '06:16', isRead: true),
    ChatMessage(
      text: 'Kata kelompok lain sih perpustakaan yang disuruh dosen kemarin',
      isMe: true,
      time: '06:16',
      isRead: true,
    ),
    ChatMessage(text: 'Okeee', isMe: false, time: '06:16'),
    ChatMessage(
      text: 'Diagram yang nomor 4 udah kelar?',
      isMe: true,
      time: '07:57',
      isRead: true,
    ),
    ChatMessage(
      text: 'Belum, masih mentok di halaman 3',
      isMe: false,
      time: '07:58',
    ),
    ChatMessage(
      text: 'Eh, materi enterprise gak masuk kan?',
      isMe: true,
      time: '13:55',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B141B),
      appBar: _buildAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.08,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(_messages[index]);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: 70,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, color: Colors.white, size: 24),
            SizedBox(width: 4),
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://picsum.photos/100?random=99',
              ),
            ),
          ],
        ),
      ),
      title: InkWell(
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          child: Text(
            chatName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 8,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: message.isMe
                ? const Color(0xFF005C4B)
                : const Color(0xFF202C33),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: message.isMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: message.isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                "${message.text}  ",
                style: const TextStyle(color: Colors.white, fontSize: 15.5),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.time,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                  if (message.isMe) const SizedBox(width: 4),
                  if (message.isMe)
                    Icon(
                      message.isRead ? Icons.done_all : Icons.check,
                      color: message.isRead ? Colors.blue : Colors.white54,
                      size: 16,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 50, maxHeight: 150),
              decoration: BoxDecoration(
                color: const Color(0xFF202C33),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF25D366),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Color(0xFF0B141B)),
          ),
        ],
      ),
    );
  }
}
