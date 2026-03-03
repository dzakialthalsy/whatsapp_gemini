import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calls_provider.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final callsData = Provider.of<CallsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calls'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTopButton(Icons.add_ic_call, 'Call'),
                  _buildTopButton(Icons.calendar_month, 'Schedule'),
                  _buildTopButton(Icons.dialpad, 'Keypad'),
                  _buildTopButton(Icons.favorite_border, 'Favorites'),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Recent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: callsData.recentCalls.length,
              itemBuilder: (context, index) {
                return _buildCallTile(callsData.recentCalls[index]);
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF25D366),
        onPressed: () {},
        child: const Icon(Icons.add_call, color: Color(0xFF0B141B)),
      ),
    );
  }

  Widget _buildTopButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFF202C33),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildCallTile(RecentCallModel call) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.deepPurple[900],
        backgroundImage: call.imageUrl != null
            ? NetworkImage(call.imageUrl!)
            : null,
        child: call.imageUrl == null
            ? Text(
                call.name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )
            : null,
      ),
      title: Text(
        call.name,
        style: TextStyle(
          color: call.isMissed ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (call.subName != null)
            Text(
              call.subName!,
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
          Row(
            children: [
              Icon(
                call.isMissed
                    ? Icons.call_missed
                    : (call.isIncoming ? Icons.call_received : Icons.call_made),
                color: call.isMissed
                    ? Colors.redAccent
                    : const Color(0xFF25D366),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(call.time, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
      trailing: Icon(
        call.isVideo ? Icons.videocam_outlined : Icons.call_outlined,
        color: Colors.white,
      ),
      onTap: () {},
    );
  }
}
