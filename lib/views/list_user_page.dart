import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_test/widgets/user_tile.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/list_user_provider.dart';
import 'user_detail_page.dart';
import '../models/user_model.dart';

class ListUserPage extends ConsumerStatefulWidget {
  const ListUserPage({super.key});

  @override
  ConsumerState<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends ConsumerState<ListUserPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).fetchUser();
    });

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        ref.read(userProvider.notifier).fetchUser(refresh: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Liste des utilisateurs", style: GoogleFonts.inter(fontSize: 14),)),
      body: state.results.isEmpty && state.isLoading
          ? Center(child: buildShimmerListTile())
          : ListView.builder(
        controller: _scrollController,
        itemCount: state.results.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < state.results.length) {
            final Result user = state.results[index]; // 👉 type clair
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserDetailPage(user: user),
                  ),
                );
              },
              child: UserTile(user: user),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildShimmerListTile() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8, // nombre de placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              title: Container(
                height: 14,
                width: double.infinity,
                color: Colors.white,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  height: 12,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
