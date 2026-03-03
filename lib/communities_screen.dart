import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'communities_provider.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final communitiesData = Provider.of<CommunitiesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communities'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- TILE: NEW COMMUNITY ---
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.groups,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B141B),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF0B141B),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 10,
                        backgroundColor: Color(0xFF25D366),
                        child: Icon(Icons.add, color: Colors.black, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              title: const Text(
                'New community',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onTap: () {},
            ),

            Divider(color: Colors.grey[900], thickness: 8), // Pembatas tebal
            // --- LIST KOMUNITAS ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: communitiesData.communities.length,
              itemBuilder: (context, index) {
                final community = communitiesData.communities[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Komunitas
                    ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: community.imageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(community.imageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey[800],
                        ),
                        child: community.imageUrl == null
                            ? const Icon(Icons.groups, color: Colors.white)
                            : null,
                      ),
                      title: Text(
                        community.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(color: Colors.grey[900], thickness: 1, indent: 76),

                    // Notifikasi khusus (seperti "New group added")
                    if (community.notificationText != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 28,
                          right: 16,
                          bottom: 8,
                          top: 8,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.notifications,
                              color: Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                community.notificationText!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFF25D366),
                            ),
                          ],
                        ),
                      ),

                    // List Sub-Grup (Announcements, dll)
                    ...community.subGroups.map((subGroup) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 18,
                          right: 16,
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: subGroup.isAnnouncement
                                ? const Color(0xFF103629)
                                : Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            subGroup.isAnnouncement
                                ? Icons.campaign
                                : Icons.group,
                            color: subGroup.isAnnouncement
                                ? const Color(0xFF25D366)
                                : Colors.white,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          subGroup.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          subGroup.lastMessage,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          subGroup.time,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }),

                    // Tombol View All
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 28,
                        right: 16,
                      ),
                      leading: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                      title: const Text(
                        'View all',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey[900],
                      thickness: 8,
                    ), // Pembatas antar komunitas
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
