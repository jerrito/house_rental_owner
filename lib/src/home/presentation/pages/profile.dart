import 'package:flutter/material.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  final Owner owner;
  const ProfilePage({
    super.key,
    required this.owner,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Profile")
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        index: 3,
      ),
      body: Column(
        children: [

          Container(
            decoration:BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image:Image.asset("name").image
              )
            )
          ),
          const Center(
            child: Text("Profile"),
          ),


        ],
      ),
    );
  }
}
