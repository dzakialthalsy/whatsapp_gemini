import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'updates_provider.dart';
import 'updates_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UpdatesProvider())],
      child: const WhatsAppClone(),
    ),
  );
}

class WhatsAppClone extends StatelessWidget {
  const WhatsAppClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(
          0xFF0B141B,
        ), // Warna background gelap WA
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF25D366), // Hijau khas WA
          surface: Color(0xFF0B141B),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B141B),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar halaman untuk setiap tab
  final List<Widget> _pages = [
    const ChatListScreen(),
    const UpdatesScreen(), // Masukkan layar yang baru kita buat
    const Center(child: Text('Communities Screen')),
    const Center(child: Text('Calls Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
            }
            return const TextStyle(color: Colors.white70, fontSize: 12);
          }),
        ),
        child: NavigationBar(
          height: 65,
          backgroundColor: const Color(0xFF0B141B),
          indicatorColor: const Color(
            0xFF103629,
          ), // Warna highlight hijau gelap
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Badge(
                label: const Text('28'), // Fiktif unread badge
                backgroundColor: const Color(0xFF25D366),
                textColor: Colors.black,
                child: const Icon(Icons.chat_outlined, color: Colors.white70),
              ),
              selectedIcon: Badge(
                label: const Text('28'),
                backgroundColor: const Color(0xFF25D366),
                textColor: Colors.black,
                child: const Icon(Icons.chat, color: Colors.white),
              ),
              label: 'Chats',
            ),
            const NavigationDestination(
              icon: Icon(Icons.data_usage_outlined, color: Colors.white70),
              selectedIcon: Icon(Icons.data_usage, color: Colors.white),
              label: 'Updates',
            ),
            const NavigationDestination(
              icon: Badge(
                smallSize: 8, // Green dot badge
                backgroundColor: Color(0xFF25D366),
                child: Icon(Icons.groups_outlined, color: Colors.white70),
              ),
              selectedIcon: Badge(
                smallSize: 8,
                backgroundColor: Color(0xFF25D366),
                child: Icon(Icons.groups, color: Colors.white),
              ),
              label: 'Communities',
            ),
            const NavigationDestination(
              icon: Icon(Icons.call_outlined, color: Colors.white70),
              selectedIcon: Icon(Icons.call, color: Colors.white),
              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }
}

// --- Komponen Layar Chats ---
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        actions: [
          IconButton(
            onPressed: () {}, // <-- Ganti di sini
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          IconButton(
            onPressed: () {}, // <-- Ganti di sini
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          // Meta AI / Search Bar Fiktif
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF202C33),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search, color: Colors.white54, size: 20),
                  SizedBox(width: 12),
                  Text(
                    'Ask Meta AI or Search',
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // List Chat Fiktif
          Expanded(
            child: ListView(
              children: [
                _buildChatTile(
                  name: 'Project Alpha Team',
                  message: 'Alex: @Budi tolong cek PR nya ya',
                  time: '16:39',
                  unreadCount: 2,
                  isGroup: true,
                ),
                _buildChatTile(
                  name: 'Siska UI/UX',
                  message: 'Sticker',
                  time: '16:32',
                  unreadCount: 5,
                  isMuted: true,
                ),
                _buildChatTile(
                  name: 'John Doe',
                  message: 'Wah mantap cuyy',
                  time: '15:56',
                  isRead: true, // Centang biru fiktif
                ),
                _buildChatTile(
                  name: 'Kelompok 5 Sistem',
                  message: 'You: kayaknya lebih mudah bikin yg das...',
                  time: 'Yesterday',
                  isRead: true,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "meta_ai_btn",
            mini: true,
            backgroundColor: const Color(0xFF202C33),
            onPressed: () {},
            child: const Icon(
              Icons.lens_blur,
              color: Colors.blueAccent,
            ), // Meta AI icon fiktif
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "new_chat_btn",
            backgroundColor: const Color(0xFF25D366),
            onPressed: () {},
            child: const Icon(Icons.add_comment, color: Color(0xFF0B141B)),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk membuat List Item Chat
  Widget _buildChatTile({
    required String name,
    required String message,
    required String time,
    int unreadCount = 0,
    bool isRead = false,
    bool isGroup = false,
    bool isMuted = false,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[800],
        child: Icon(isGroup ? Icons.group : Icons.person, color: Colors.white),
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Row(
        children: [
          if (isRead) const Icon(Icons.done_all, color: Colors.blue, size: 16),
          if (isRead) const SizedBox(width: 4),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              color: unreadCount > 0 ? const Color(0xFF25D366) : Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMuted)
                const Icon(Icons.volume_off, color: Colors.white54, size: 16),
              if (isMuted && unreadCount > 0) const SizedBox(width: 4),
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF25D366),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
