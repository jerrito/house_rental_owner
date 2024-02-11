import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/profile_list.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/show_dialog.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/show_dialog_pin.dart';

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
  final formKey = GlobalKey<FormBuilderFieldState>();
  String? newRepeatValue;
  String? newChangeValue;
  String? oldValue;
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
                      onPressed: () async {
                        await showProfileDialog(
                            context,
                            owner.houseGPSAddress ?? "",
                            "House GPS Address",
                            authBloc,
                            owner.id ?? "",
                            "house_GPS_address");

                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner.firstName} ${owner.lastName}"),
                  ProfileList(
                      onPressed: () async {
                        await showProfileDialog(context, owner.email ?? "",
                            "Email", authBloc, owner.id ?? "", "email");
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner.email}"),
                  ProfileList(
                      onPressed: () async {
                        await showProfileDialog(
                            context,
                            owner.phoneNumber ?? "",
                            "House GPS Address",
                            authBloc,
                            owner.id ?? "",
                            "house_GPS_address");
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner.phoneNumber}"),
                  ProfileList(
                      onPressed: () async {
                        await showProfileDialog(
                            context,
                            owner.townORCity ?? "",
                            "Town Or City",
                            authBloc,
                            owner.id ?? "",
                            "town_or_city");
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner.townORCity}"),
                  ProfileList(
                      onPressed: () async {
                        await showProfileDialog(
                            context,
                            owner.houseGPSAddress ?? "",
                            "House GPS Address",
                            authBloc,
                            owner.id ?? "",
                            "house_GPS_address");
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner.houseGPSAddress}"),
                  ProfileList(
                      onPressed: () async {
                        await showProfileDialog(
                          context,
                          owner.role ?? "",
                          "Role",
                          authBloc,
                          owner.id ?? "",
                          "role",
                        );
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "${owner.role}"),
                  ProfileList(
                      onPressed: () async {
                        await showPinChangeProfileDialog(
                            context,
                            owner.password ?? "",
                            "Password",
                            authBloc,
                            owner.id ?? "",
                            "password",
                            owner.email ?? "",
                            oldValue ?? "",
                            newChangeValue ?? "",
                            newRepeatValue ?? "",
                            formKey);
                        authBloc.add(const GetCacheDataEvent());
                      },
                      data: "Change Pin"),
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
