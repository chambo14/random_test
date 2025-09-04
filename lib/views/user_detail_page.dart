import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_test/models/user_model.dart';
import 'package:random_test/widgets/contact_card_page.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key, required this.user});
  final Result user;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Detail contact", style: GoogleFonts.inter(fontSize: 14),),
            const SizedBox(width: 5,),
            Text("${widget.user.name?.first.toString()}", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.90,
          child: ContactCardPage(user: widget.user)),
    );
  }
}
