import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/profile_list.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/show_dialog.dart';

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
  final homeBloc = locator<HomeBloc>();
  final authBloc = locator<AuthenticationBloc>();
  @override
  Widget build(BuildContext context) {
    authBloc.add(const GetCacheDataEvent());
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: BottomNavigationBarWidget(
        index: 3,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer(
          bloc: authBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetCacheDataLoaded) {
              final owner = state.owner;
              return Column(
                children: [
                  Container(
                      height: Sizes().height(context, 0.2),
                      width: Sizes().width(context, 0.4),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(owner.profileURL ?? "")
                                  .image))),
                  ProfileList(
                      onPressed: null,
                      data: "${owner.firstName} ${owner.lastName}"),
                  ProfileList(onPressed: null, data: "${owner.email}"),
                  ProfileList(onPressed: null, data: "${owner.phoneNumber}"),
                  ProfileList(onPressed: null, data: "${owner.townORCity}"),
                  ProfileList(
                      onPressed: () {
                        showProfileDialog(
                            context,
                            owner.houseGPSAddress ?? "",
                            "House GPS Address",
                            authBloc,
                            owner.id ?? "",
                            "house_GPS_address");
                      },
                      data: "${owner.houseGPSAddress}"),
                  ProfileList(
                      onPressed: () {
                        showProfileDialog(
                            context, owner.role ?? "", "Role", authBloc,owner.id ?? "","house_GPS_address");
                      },
                      data: "${owner.role}"),
                  ProfileList(onPressed: () {}, data: "Change Pin"),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
