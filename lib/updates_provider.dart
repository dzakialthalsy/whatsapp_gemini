import 'package:flutter/material.dart';

// --- MODELS ---
class StatusModel {
  final String name;
  final String? imageUrl; // Jika null, kita pakai ikon
  final bool isViewed;

  StatusModel({required this.name, this.imageUrl, this.isViewed = false});
}

class ChannelModel {
  final String name;
  final String description;
  final String? imageUrl;
  final String time;
  final int unreadCount;
  final bool isVerified;

  ChannelModel({
    required this.name,
    required this.description,
    this.imageUrl,
    required this.time,
    this.unreadCount = 0,
    this.isVerified = false,
  });
}

// --- PROVIDER ---
class UpdatesProvider extends ChangeNotifier {
  // Data Fiktif untuk Status
  final List<StatusModel> _statuses = [
    StatusModel(
      name: 'Budi Santoso',
      imageUrl: 'https://picsum.photos/200/300?random=1',
      isViewed: false,
    ),
    StatusModel(
      name: 'Siska (Kampus)',
      imageUrl: 'https://picsum.photos/200/300?random=2',
      isViewed: false,
    ),
    StatusModel(
      name: 'Pak Dosen',
      imageUrl: null, // Akan menampilkan Icon
      isViewed: true,
    ),
  ];

  // Data Fiktif untuk Channels
  final List<ChannelModel> _channels = [
    ChannelModel(
      name: 'Info Beasiswa 2026',
      description: 'Pendaftaran beasiswa LPDP telah dibuka...',
      imageUrl: 'https://picsum.photos/100?random=3',
      time: '14:53',
      unreadCount: 8,
      isVerified: true,
    ),
    ChannelModel(
      name: 'Kajian Koding',
      description: '✅ Jawaban: A 👍 (Implementasi OOP...',
      imageUrl: 'https://picsum.photos/100?random=4',
      time: '05:06',
      unreadCount: 4,
    ),
    ChannelModel(
      name: 'Komunitas Flutter ID',
      description: 'You followed the channel',
      imageUrl: null, // Akan menampilkan Icon
      time: 'Yesterday',
      unreadCount: 0,
    ),
  ];

  List<StatusModel> get statuses => _statuses;
  List<ChannelModel> get channels => _channels;
}
