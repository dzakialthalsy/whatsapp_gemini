import 'package:flutter/material.dart';

// --- MODELS ---
class SubGroupModel {
  final String name;
  final String lastMessage;
  final String time;
  final bool isAnnouncement;
  final bool hasUnread; // Untuk titik hijau

  SubGroupModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.isAnnouncement = false,
    this.hasUnread = false,
  });
}

class CommunityModel {
  final String name;
  final String? imageUrl;
  final String? notificationText; // Teks hijau seperti "New group... added"
  final List<SubGroupModel> subGroups;

  CommunityModel({
    required this.name,
    this.imageUrl,
    this.notificationText,
    required this.subGroups,
  });
}

// --- PROVIDER ---
class CommunitiesProvider extends ChangeNotifier {
  final List<CommunityModel> _communities = [
    CommunityModel(
      name: 'HALO MABA || FILKOM 2024',
      imageUrl: 'https://picsum.photos/100?random=10', // Placeholder gambar
      subGroups: [
        SubGroupModel(
          name: 'Announcements',
          lastMessage: 'You were added',
          time: '3/8/24',
          isAnnouncement: true,
        ),
        SubGroupModel(
          name: 'HALO MABA || FILKOM 2024',
          lastMessage: '+62 896-5917-5865: 🖼️ FILKOM RANGERS...',
          time: '12:31',
        ),
      ],
    ),
    CommunityModel(
      name: 'Fordi Mapelar 2026',
      imageUrl: 'https://picsum.photos/100?random=11',
      notificationText: 'New group "Bendahara Fordi 26" added',
      subGroups: [
        SubGroupModel(
          name: 'Announcements',
          lastMessage: '~ 24 - Ghazy added the group "Bendahara F...',
          time: 'Yesterday',
          isAnnouncement: true,
        ),
        SubGroupModel(
          name: 'ANGGOTA FORDI MAPELAR',
          lastMessage: 'Farhan: Siap kak, nanti saya cek...',
          time: 'Yesterday',
        ),
      ],
    ),
  ];

  List<CommunityModel> get communities => _communities;
}
