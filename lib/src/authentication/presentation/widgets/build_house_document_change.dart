import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental_admin/src/home/presentation/bloc/home_bloc.dart';

buildHouseDocumentChangeBottomSheet(
  BuildContext context,
  HomeBloc homeBloc,
) {
  return showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Container(
            height: 200,
            padding: EdgeInsets.all(Sizes().width(context, 0.04)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space().height(context, 0.02),
                const Text("Add House Document Picture"),
                Space().height(context, 0.04),
                DefaultButton(
                  label: "Camera",
                  onTap: () {
                    
                    homeBloc
                        .add(GetHouseDocumentCameraEvent(params: NoParams(),),);
                        //Navigator.pop(context);
                  },
                ),
                Space().height(context, 0.02),
                BlocConsumer(
                    bloc: homeBloc,
                    listener: (context, state) {
                      if (state is GetProfileError) {
                        debugPrint(state.errorMessage);
                      }
                      if (state is GetProfileLoaded) {}
                    },
                    builder: (context, state) {
                      return DefaultButton(
                          label: "Gallery",
                          onTap: () {
                            //context.pop();
                            homeBloc.add(GetHouseDocumentGalleryEvent(
                                params: NoParams()));

                               // Navigator.pop(context);

                            // Navigator.pop(context);
                          });
                    }),
              ],
            ));
      }));
}
