import 'package:flutter/material.dart';

import '../Models/UserEnAttente.dart';

class PlayerInformationCard extends StatefulWidget {
  const PlayerInformationCard({super.key, required this.user});
  final UserEnAttente user;

  @override
  State<PlayerInformationCard> createState() => _PlayerInformationCardState();
}

class _PlayerInformationCardState extends State<PlayerInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://e7.pngegg.com/pngimages/911/5/png-clipart-computer-icons-icon-design-anonymous-avatar-anonymous-face-smiley.png"),
              ),
              const SizedBox(
                width: 35,
              ),
              Text(widget.user.name, style: const TextStyle(fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
