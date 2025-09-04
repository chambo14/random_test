import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_test/models/user_model.dart';

class ContactCardPage extends StatelessWidget {
  const ContactCardPage({super.key, required this.user});
  final Result user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.picture!.thumbnail.toString()),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.name?.first} ${user.name?.last}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email.toString(),
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),

            // --- Téléphone ---
            Row(
              children: [
                const Icon(Icons.phone, size: 20, color: Colors.blueGrey),
                const SizedBox(width: 10),
                Text(user.phone.toString(), style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),),
              ],
            ),
            const SizedBox(height: 20),

            // --- Mobile ---
            Row(
              children: [
                const Icon(Icons.smartphone, size: 20, color: Colors.blueGrey),
                const SizedBox(width: 10),
                Text(user.cell.toString(),  style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),

            // --- Address ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 20, color: Colors.blueGrey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${user.location?.street?.name}, ${user.location?.city}, ${user.location?.state}, ${user.location?.country}",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
