import 'package:flutter/material.dart';


class message extends StatelessWidget {
  const message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildNotification(
          icon: Icons.star,
          title: 'New favorite',
          subtitle: 'Your post has been favorited by John',
          color: Colors.yellow,
        ),
        buildNotification(
          icon: Icons.comment,
          title: 'New comment',
          subtitle: 'Alice commented on your post',
          color: Colors.blue,
        ),
        buildNotification(
          icon: Icons.thumb_up,
          title: 'New like',
          subtitle: 'Bob liked your post',
          color: Colors.green,
        ),
      ],
    );
  }
}


Widget buildNotification({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
}) {
  return ListTile(
    leading: CircleAvatar(
      child: Icon(icon),
      backgroundColor: color,
      foregroundColor: Colors.white,
    ),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(subtitle),
  );
}
