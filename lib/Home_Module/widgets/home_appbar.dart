import 'package:bluecs_assignment/common_widgets/assetSvgIcon.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      leadingWidth: 50,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton(
          icon: const AssetSvgIcon('more_option'),
          onPressed: () {
            // Handle menu tap
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Container(
        height: 40,
        
        decoration: const BoxDecoration(),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Search here...',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[400],
              size: 20,
            ),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 10,
            ),
          ),
          onSubmitted: (value) {
            // Handle search
            print('Search: $value');
          },
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton(
            icon: const AssetSvgIcon('map'),
            onPressed: () {
            // Handle menu tap
            Scaffold.of(context).openDrawer();
          },
        ),

              IconButton(
            icon: const AssetSvgIcon('notification'),
            onPressed: () {
            // Handle menu tap
            Scaffold.of(context).openDrawer();
          }
              )

            ],
          ),
        ),
      ],
    );
  }
}