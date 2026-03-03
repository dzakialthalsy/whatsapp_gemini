import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../updates_provider.dart'; // Import file provider yang dibuat di atas

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Membaca data dari provider
    final updatesData = Provider.of<UpdatesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ), // <-- Ganti di sini
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ), // <-- Ganti di sini
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION: STATUS ---
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Status',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount:
                    updatesData.statuses.length + 1, // +1 untuk 'Add Status'
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildAddStatusCard();
                  }
                  final status = updatesData.statuses[index - 1];
                  return _buildStatusCard(status);
                },
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[900], thickness: 1),

            // --- SECTION: CHANNELS ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Channels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF202C33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Explore',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: updatesData.channels.length,
              itemBuilder: (context, index) {
                return _buildChannelTile(updatesData.channels[index]);
              },
            ),
            const SizedBox(height: 80), // Padding bawah agar tidak tertutup FAB
          ],
        ),
      ),

      // Floating Action Buttons (Pensil dan Kamera)
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "edit_status",
            mini: true,
            backgroundColor: const Color(0xFF202C33),
            onPressed: () {},
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "camera_status",
            backgroundColor: const Color(0xFF25D366),
            onPressed: () {},
            child: const Icon(Icons.camera_alt, color: Color(0xFF0B141B)),
          ),
        ],
      ),
    );
  }

  // Widget: Card Tambah Status Sendiri
  Widget _buildAddStatusCard() {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF202C33),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 55,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF25D366),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Add status',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget: Card Status Orang Lain
  Widget _buildStatusCard(StatusModel status) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF202C33),
        borderRadius: BorderRadius.circular(16),
        image: status.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(status.imageUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ), // Efek gelap sikit
              )
            : null,
      ),
      child: Stack(
        children: [
          if (status.imageUrl == null)
            const Center(
              child: Icon(
                Icons.image_not_supported,
                color: Colors.white54,
                size: 40,
              ),
            ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: status.isViewed
                      ? Colors.grey
                      : const Color(0xFF25D366),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[800],
                backgroundImage: status.imageUrl != null
                    ? NetworkImage(status.imageUrl!)
                    : null,
                child: status.imageUrl == null
                    ? const Icon(Icons.person, color: Colors.white, size: 20)
                    : null,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                status.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget: List Item Channel
  Widget _buildChannelTile(ChannelModel channel) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[800],
        backgroundImage: channel.imageUrl != null
            ? NetworkImage(channel.imageUrl!)
            : null,
        child: channel.imageUrl == null
            ? const Icon(Icons.campaign, color: Colors.white)
            : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              channel.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (channel.isVerified) const SizedBox(width: 4),
          if (channel.isVerified)
            const Icon(Icons.verified, color: Colors.green, size: 16),
        ],
      ),
      subtitle: Text(
        channel.description,
        style: const TextStyle(color: Colors.white70),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            channel.time,
            style: TextStyle(
              color: channel.unreadCount > 0
                  ? const Color(0xFF25D366)
                  : Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          if (channel.unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF25D366),
                shape: BoxShape.circle,
              ),
              child: Text(
                channel.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
