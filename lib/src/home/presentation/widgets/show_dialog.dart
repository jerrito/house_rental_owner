import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';

Widget showProfileDialog(
  BuildContext context,
  String data,
  String? label,
  AuthenticationBloc bloc,
  String id,
  String update,
) {
  return SimpleDialog(
    title: const Text("Edit profile"),
    children: [
      Space().height(context, 0.02),
      DefaultTextfield(
        initialValue: data,
        label: "Edit $label",
        onChanged: (value) {},
      ),
      Space().height(context, 0.02),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DefaultButton(
            label: "Cancel",
            onTap: () {
              context.pop();
            },
          ),
          BlocConsumer(
            bloc: bloc,
            listener: (context, state) {
              if (state is UpdateUserLoaded) {
                context.pop();
              }
              if (state is UpdateUserError) {}
            },
            builder: (context, state) {
              if (state is UpdateUserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return DefaultButton(
                label: "Update",
                onTap: () {
                  Map<String, dynamic> params = {"id": ""};
                  bloc.add(
                    UpdateUserEvent(params: params),
                  );
                },
              );
            },
          ),
        ],
      )
    ],
  );
}
