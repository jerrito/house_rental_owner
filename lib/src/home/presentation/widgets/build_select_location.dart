import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';

buildSelectLocation(BuildContext context, Map<String, dynamic> params) {
  TextEditingController controller = TextEditingController();
  final homeBloc = locator<HomeBloc>();
  return showModalBottomSheet(
      // enableDrag: false,
      elevation: 1.0,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return SingleChildScrollView(
            child: Container(
                height: Sizes().height(context, 0.85),
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes().width(context, 0.054),
                  vertical: Sizes().height(context, 0.02),
                ),
                decoration: BoxDecoration(
                  //  color: shaqBackground,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      Sizes().height(context, 0.04),
                    ),
                  ),
                ),
                //  decoration: BoxDecoration(),
                child: Column(
                  children: [
                    const Text("Search location"),

                    //Space(context,0.02 ),

                    Row(
                      children: [
                        BlocConsumer(
                          bloc: homeBloc,
                          listener: (context, state) {
                            if (state is PlaceSearchLoaded) {
                              print(state.placeSearch);
                            }

                            if (state is PlaceSearchError) {
                              print(state.errorMessage);
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: 290,
                              child: DefaultTextfield(
                                onChanged: (value) {
                                  Map<String, dynamic> params = {
                                    "place": value
                                  };
                                  homeBloc
                                      .add(PlaceSearchEvent(params: params));
                                },
                                controller: controller,
                                label: 'Search place',
                              ),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            // showModalBottomSheet(
                            //     context: context,
                            //     builder: ((context) {
                            //       return const SelectFromMapPage();
                            //     }));
                            print("nav");
                            Map<String, dynamic> param = {};
                            final result = await context.pushNamed(
                              "map",
                            );
                            //if (!context.mounted) return;
                            print(result);

                            setState(() {
                              param = result as Map<String, dynamic>;
                            });
                            print(param);
                            if (context.mounted) {
                              
                              context.pop(param);
                            }
                          },
                          child: SvgPicture.asset(
                            callSVG,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    BlocConsumer(
                        bloc: homeBloc,
                        listener: (context, state) {
                          if (state is PlaceSearchError) {
                            return;
                          }
                        },
                        builder: (context, state) {
                          if (state is PlaceSearchLoaded) {
                            return Flexible(
                              child: ListView.builder(
                                  itemCount:
                                      state.placeSearch.results?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, item) {
                                    final data =
                                        state.placeSearch.results?[item];
                                    return ListTile(
                                      onTap: () {
                                        params = {
                                          "formatted_address":
                                              data?.formatedAddress,
                                          "lng": data?.geometry?.location.lng,
                                          "lat": data?.geometry?.location.lat,
                                        };
                                        context.pop(params);
                                      },
                                      //leading: ,
                                      title: Text(data?.name ?? ""),
                                      subtitle:
                                          Text(data?.formatedAddress ?? ""),
                                    );
                                  }),
                            );
                          }
                          ;
                          return SizedBox();
                        })
                  ],
                )),
          );
        });
      });
}
