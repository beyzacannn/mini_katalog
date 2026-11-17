import 'package:flutter/material.dart';

/// iOS tarzı "‹ Back" butonu (AppBar leading için).
class BackLabel extends StatelessWidget {
  const BackLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.maybePop(context),
      child: const Padding(
        padding: EdgeInsets.only(left: 12),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
            SizedBox(width: 4),
            Text('Back', style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
