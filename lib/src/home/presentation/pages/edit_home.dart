import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rental_admin/assets/svgs/svg_constants.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/core/strings/app_strings.dart';
import 'package:house_rental_admin/core/theme%20copy/colors.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/core/widgets/bottom_sheet.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:house_rental_admin/src/home/domain/entities/house.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/src/home/presentation/widgets/build_select_location.dart';
import 'package:oktoast/oktoast.dart';

class EditHomePage extends StatefulWidget {
  final HouseDetail house;
  final String id;

  const EditHomePage({
    super.key,
    required this.house,
    required this.id,
  });

  @override
  State<EditHomePage> createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {
  final homeBloc = locator<HomeBloc>();
  final homeBloc2 = locator<HomeBloc>();
  final authBloc = locator<AuthenticationBloc>();
  final formKey = GlobalKey<FormBuilderState>();
  String? homeNameController;
  String? amountController;
  String? bathRoomController;
  String? bedRoomController;
  String? descriptionController;

  HouseLocation? houseLocation;
  bool isImageAvailable = true;
  List<String> images = [];
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.house.images!.length; i++) {
      images.add(widget.house.images![i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpLoadMultipleImageLoaded) {
            Map<String, dynamic> params = {
              "name": homeNameController,
              "description": descriptionController,
              "amount": amountController,
              "bed_room_count": bedRoomController,
              "bath_room_count": bathRoomController,
              "images": state.imageURL,
              "id": widget.id,
            };
            homeBloc.add(UpdateHouseEvent(params: params));
          }

          if (state is UpLoadMultipleImageError) {
            debugPrint(state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is UpLoadMultipleImageLoading) {
            const Center(child: CircularProgressIndicator());
          }
          return bottomSheetButton(
            context: context,
            label: "Update Home",
            onPressed: () {
              if (formKey.currentState!.saveAndValidate() == true) {
                Map<String, dynamic> params = {
                  "phone_number": widget.house.houseName,
                  "path": images,
                  "images": images.length
                };
                homeBloc.add(UpLoadMultipleImageEvent(params: params));

                // Map<String, dynamic> params = {
                //   "phone_number": widget.owner.phoneNumber,
                //   "path": profileURL,
                // };
                // homeBloc.add(addHomeEvent(params: params));
              }
            },
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBarWidget(
      //   index: 1,
      // ),
      appBar: AppBar(
        title: const Text("Edit Home or Room"),
      ),
      body: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          child: BlocConsumer(
            listener: (BuildContext context, state) {
              if (state is AddHomeLoaded) {
                context.goNamed("homePage");
              }

              if (state is AddHomeError) {}
            },
            bloc: homeBloc,
            builder: (context, state) {
              // if (state is AddHomeLoading) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              // if(state is ){

              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04)),
                    child: FormBuilderField<String>(
                        name: "homeName",
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return fieldRequired;
                          }
                          if (value!.length <= 1) {
                            return mustBeCharacters;
                          }
                          return null;
                        },
                        builder: (context) {
                          return DefaultTextfield(
                            initialValue: widget.house.houseName,
                            hintText: "Enter home name",
                            label: "Home name",
                            errorText: context.errorText,
                           onChanged: (p0) {
                                context.didChange((p0!));
                                homeNameController = p0;
                              });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04)),
                    child: FormBuilderField<num>(
                        name: "rentAmount",
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return numberRequired;
                          }
                          if (value.isNaN) {
                            return numberRequired;
                          }
                          if (value <= 1) {
                            return mustBeAtleast;
                          }

                          return null;
                        },
                        builder: (context) {
                          return DefaultTextfield(
                              initialValue: widget.house.amount.toString(),
                              textInputType: TextInputType.number,
                              hintText: "Enter rent amount",
                              label: "Rent amount",
                              errorText: context.errorText,
                             onChanged: (p0) {
                                context.didChange((int.parse(p0!)));
                                amountController = p0;
                              });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04)),
                    child: FormBuilderField<int>(
                        name: "bedRooms",
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return numberRequired;
                          }
                          if (value.isNaN) {
                            return numberRequired;
                          }
                          if (value <= 0) {
                            return mustBeAtleast;
                          }
                          if (value >= 13) {
                            return mustBeAtmost;
                          }
                          return null;
                        },
                        builder: (context) {
                          return DefaultTextfield(
                            initialValue: widget.house.bedRoomCount.toString(),
                            textInputType: TextInputType.number,
                            hintText: "Enter number of Bed Rooms",
                            label: "Number of Bed Rooms",
                            errorText: context.errorText,
                            onChanged: (p0) {
                                context.didChange((int.parse(p0!)));
                                bedRoomController = p0;
                              });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04)),
                    child: FormBuilderField<int>(
                        name: "bathRooms",
                        validator: (value) {
                          if (value?.isNaN ?? true) {
                            return numberRequired;
                          }
                          if (value! <= 0) {
                            return mustBeAtleast;
                          }
                          if (value >= 13) {
                            return mustBeAtmost;
                          }
                          return null;
                        },
                        builder: (context) {
                          return DefaultTextfield(
                              initialValue:
                                  widget.house.bathRoomCount.toString(),
                              textInputType: TextInputType.number,
                              hintText: "Enter number of Bath Rooms",
                              label: "Number of Bath Rooms",
                              errorText: context.errorText,
                              onChanged: (p0) {
                                context.didChange((int.parse(p0!)));
                                bathRoomController = p0;
                              });
                        }),
                  ),
                  FormBuilderField<String>(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return mustBeAtleast;
                        }
                        return null;
                      },
                      name: "location",
                      builder: (field) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Sizes().width(context, 0.04),
                            ),
                            child: InputDecorator(
                              decoration:
                                  InputDecoration(errorText: field.errorText),
                              child: BlocConsumer(
                                bloc: homeBloc2,
                                builder: (context, state) {
                                  if (state is AddLocationLoaded) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: Sizes().height(context, 0.05),
                                          child: Center(
                                            child: Text(state
                                                        .houseLocation
                                                        .formatedAddress!
                                                        .length <=
                                                    35
                                                ? state.houseLocation
                                                    .formatedAddress!
                                                : "${state.houseLocation.formatedAddress?.substring(0, 35)}..."),
                                          ),
                                        ),
                                        Space().width(context, 0.02),
                                        GestureDetector(
                                          onTap: () async {
                                            final result =
                                                await buildSelectLocation(
                                                    context);
                                            if (!mounted) return;

                                            homeBloc2.add(AddLocationEvent(
                                                params: result));
                                          },
                                          child: SvgPicture.asset(
                                            editSVG,
                                            color: housePrimaryColor,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Location"),
                                      Space().height(context, 0.003),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height:
                                                Sizes().height(context, 0.05),
                                            child: Center(
                                              child: Text(widget
                                                          .house
                                                          .formatedAddress!
                                                          .length <=
                                                      35
                                                  ? widget
                                                      .house.formatedAddress!
                                                  : "${widget.house.formatedAddress?.substring(0, 35)}..."),
                                            ),
                                          ),
                                          Space().width(context, 0.02),
                                          GestureDetector(
                                            onTap: () async {
                                              final result =
                                                  await buildSelectLocation(
                                                      context);
                                              if (!mounted) return;

                                              print(result
                                                  as Map<String, dynamic>);
                                              homeBloc2.add(AddLocationEvent(
                                                  params: result));
                                            },
                                            child: SvgPicture.asset(
                                              editSVG,
                                              color: housePrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                                listener: (BuildContext context, state) {
                                  if (state is AddLocationLoaded) {
                                    houseLocation = state.houseLocation;
                                    setState(() {});
                                    field.didChange(
                                        houseLocation?.formatedAddress);
                                  }
                                  if (state is AddLocationError) {
                                    OKToast(child: Text(state.errorMessage));
                                  }
                                },
                              ),
                            ));
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04)),
                    child: Row(
                      children: [
                        const Text("House Image(s)"),
                        Space().width(context, 0.03),
                        GestureDetector(
                          onTap: () {
                            homeBloc
                                .add(AddMultipleImageEvent(params: NoParams()));
                          },
                          child: SvgPicture.asset(
                            editSVG,
                            color: housePrimaryColor,
                            // colorFilter: ColorFilter.mode(
                            //   color:housePrimaryColor

                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Space().height(context, 0.02),
                  FormBuilderField<List<String>>(
                      name: "house_images",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return fieldRequired;
                        }

                        return null;
                      },
                      builder: (field) {
                        return InputDecorator(
                          decoration:
                              InputDecoration(errorText: field.errorText),
                          child: BlocConsumer(
                            bloc: homeBloc,
                            builder: (context, state) {
                              if (state is AddMultipleImageLoaded) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: CarouselSlider.builder(
                                    itemCount: state.files.length,
                                    itemBuilder: (context, index, value) {
                                      final paths = state.files[index].path;

                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Sizes().width(context, 0.04)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            File(paths ?? ""),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 150,
                                          ),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: 150,
                                      reverse: true,
                                    ),
                                  ),
                                );
                              }
                              return SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: CarouselSlider.builder(
                                  itemCount: images.length,
                                  itemBuilder: (context, index, value) {
                                    final paths = images[index];

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Sizes().width(context, 0.04)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          paths,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 150,
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 150,
                                    reverse: true,
                                  ),
                                ),
                              );
                            },
                            listener: (BuildContext context, state) {
                              if (state is AddMultipleImageError) {
                                debugPrint(state.errorMessage);
                              }
                              if (state is AddMultipleImageLoaded) {
                                for (int i = 0; i < state.files.length; i++) {
                                  images.add(state.files[i].path!);
                                }
                                field.didChange(images);
                              }
                            },
                          ),
                        );
                      }),
                  FormBuilderField<String>(
                      name: "homeDescription",
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return fieldRequired;
                        }
                        if (value!.length <= 1) {
                          return mustBeCharacters;
                        }
                        return null;
                      },
                      builder: (field) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Sizes().width(context, 0.04)),
                          child: DefaultTextArea(
                            initialValue:descriptionController,
                            
                            hintText: "Enter home description",
                            label: "Home Description",
                            errorText: field.errorText,
                            onChanged: (p0) {
                                field.didChange((p0!));
                                descriptionController = p0;
                              }
                            
                          ),
                        );
                      }),
                  Space().height(context, 0.02)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
