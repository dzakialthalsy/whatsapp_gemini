import 'package:flutter/material.dart';

class RecentCallModel {
  final String name;
  final String? subName;
  final String time;
  final bool isMissed;
  final bool isIncoming;
  final bool isVideo;
  final String? imageUrl;

  RecentCallModel({
    required this.name,
    this.subName,
    required this.time,
    this.isMissed = false,
    this.isIncoming = true,
    this.isVideo = false,
    this.imageUrl,
  });
}

class CallsProvider extends ChangeNotifier {
  final List<RecentCallModel> _recentCalls = [
    RecentCallModel(
      name: '+62 822-8467-0022',
      subName: '~ ihsan rmd',
      time: 'Yesterday, 21:38',
      isIncoming: false,
    ),
    RecentCallModel(
      name: 'Abdul',
      time: 'Yesterday, 21:27',
      isMissed: true,
      isIncoming: true,
      isVideo: true,
      imageUrl: 'https://picsum.photos/100?random=20',
    ),
    RecentCallModel(
      name: '+62 822-8467-0022',
      subName: '~ ihsan rmd',
      time: 'Yesterday, 21:06',
      isMissed: true,
      isIncoming: true,
    ),
    RecentCallModel(
      name: '+62 822-8467-0022 & dafa',
      time: 'Yesterday, 20:48',
      isIncoming: true,
    ),
    RecentCallModel(
      name: '+62 896-1866-7937 (2)',
      subName: '~ Abi Abdillah',
      time: 'Yesterday, 19:30',
      isMissed: true,
      isIncoming: true,
    ),
  ];

  List<RecentCallModel> get recentCalls => _recentCalls;
}
