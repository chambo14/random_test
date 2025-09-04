import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';

class UserTile extends StatelessWidget {
  final Result user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.picture!.thumbnail.toString()),
      ),
      title: Text("${user.name!.first} ${user.name!.last}", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal),),
      subtitle: Text(user.email.toString(), style: GoogleFonts.inter(fontSize: 12),),
    );
  }
}
