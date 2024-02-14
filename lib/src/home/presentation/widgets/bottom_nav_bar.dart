// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int index;
  void Function()? addHome;
  void Function()? editHome;
  void Function()? profile;
  BottomNavigationBarWidget({
    super.key,
    this.editHome,
    this.profile,
    this.addHome,
    required this.index,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        if (value == 0) {
          widget.index = value;

          setState(() {});
          context.goNamed("homePage");
        }
        if (value == 1) {
          widget.index = value;

          setState(() {});
          //  context.pushNamed("addHome", 
          //       queryParameters: {
          //         "id": owner?.id ?? "",
          //         "name": "${owner?.firstName} ${owner?.lastName}",
          //         "phoneNumber": owner?.phoneNumber ?? ""
          //       });
          context.goNamed("addHome");
        }
        
        if (value == 2) {
          widget.index == value;
          setState(() {});
          context.goNamed("profile");
        }
      },
      items: [
        buildNav(callSVG, "Home"),
        buildNav(bookMarkSVG, "Add"),
        buildNav(userSVG, "Profile"),
      ],
    );
  }
}

//Function()

BottomNavigationBarItem buildNav(String svg, String? label) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(svg),
    activeIcon: SvgPicture.asset(
      svg,
      colorFilter: const ColorFilter.mode(Colors.lightBlue, BlendMode.srcIn),
    ),
    label: label,
  );
}
