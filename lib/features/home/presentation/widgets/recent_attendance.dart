import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class RecentAttendanceList extends StatelessWidget {
  const RecentAttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recent = [
      {
        "date": "23.03.2025",
        "in": "08:57",
        "out": "17:32",
        "status": IconlyBold.tick_square,
        "color": Colors.green,
      },
      {
        "date": "22.03.2025",
        "in": "09:15",
        "out": "17:40",
        "status": IconlyBold.danger,
        "color": Colors.orange,
      },
      {
        "date": "21.03.2025",
        "in": "08:55",
        "out": "17:30",
        "status": IconlyBold.tick_square,
        "color": Colors.green,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Oxirgi davomadlar",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...recent.map(
              (entry) => Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: Icon(entry['status'], color: entry['color'], size: 28),
              title: Text(entry['date']),
              subtitle: Text("Kelgan: ${entry['in']}, Chiqqan: ${entry['out']}"),
            ),
          ),
        ),
      ],
    );
  }
}
