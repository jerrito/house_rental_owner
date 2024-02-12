import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental_admin/core/size/sizes.dart';
import 'package:house_rental_admin/core/spacing/whitspacing.dart';
import 'package:house_rental_admin/core/strings/app_strings.dart';
import 'package:house_rental_admin/core/widgets/bottom_sheet.dart';
import 'package:house_rental_admin/locator.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';
import 'package:house_rental_admin/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_button.dart';
import 'package:house_rental_admin/src/authentication/presentation/widgets/default_textfield.dart';
import 'package:oktoast/oktoast.dart';
import 'package:string_validator/string_validator.dart';

class ChangeNumberPage extends StatefulWidget {
  final String? phoneNumber;
  const ChangeNumberPage({
    super.key,
    this.phoneNumber,
  });

  @override
  State<ChangeNumberPage> createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState extends State<ChangeNumberPage> {
  final phoneNumberController = TextEditingController();
  final newNumberController = TextEditingController();
  final repeatNumberController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final authBloc = locator<AuthenticationBloc>();
  Owner? owner;
  String? newNumberValue;
  String? repeatNumberValue;
  String? id;
  @override
  void initState() {
    authBloc.add(const GetCacheDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Number")),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
          ),
          child: FormBuilder(
            key: formKey,
            child: Column(children: [
              Space().height(context, 0.02),
              FormBuilderField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: "phoneNumber",
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return fieldRequired;
                  }
                  if (!isNumeric(value!)) {
                    return "Only numbers required";
                  }
                  if (!isLength(value, 9, 9)) {
                    return 'Nine numbers required';
                  }

                  return null;
                },
                onChanged: (value) {
                  if (value!.startsWith("0", 0)) {
                    phoneNumberController.text = value.substring(1);
                  }
                },
                builder: (field) => DefaultTextfield(
                  enabled: false,
                  initialValue: widget.phoneNumber,
                  textInputType: TextInputType.number,
                  label: "Old Number",
                  errorText: field.errorText,
                  onChanged: (p0) => field.didChange(p0),
                ),
              ),
              Space().height(context, 0.02),
              FormBuilderField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: "newNumber",
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return fieldRequired;
                  }
                  if (!isNumeric(value!)) {
                    return "Only numbers required";
                  }
                  if (!isLength(value, 9, 9)) {
                    return 'Nine numbers required';
                  }

                  if (repeatNumberValue != value) {
                    return "Numbers doesn't much";
                  }

                  return null;
                },
                onChanged: (value) {
                  if (value!.startsWith("0", 0)) {
                    newNumberController.text = value.substring(1);
                  }
                },
                builder: (field) => DefaultTextfield(
                    textInputType: TextInputType.number,
                    controller: newNumberController,
                    label: "Enter New Number",
                    errorText: field.errorText,
                    onChanged: (p0) {
                      newNumberValue = p0;
                      field.didChange(p0);
                    }),
              ),
              Space().height(context, 0.02),
              FormBuilderField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                name: "repeatNumber",
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return fieldRequired;
                  }
                  if (!isNumeric(value!)) {
                    return "Only numbers required";
                  }
                  if (!isLength(value, 9, 9)) {
                    return 'Nine numbers required';
                  }
                  if (newNumberValue != value) {
                    return "Numbers doesn't much";
                  }

                  return null;
                },
                onChanged: (value) {
                  if (value!.startsWith("0", 0)) {
                    repeatNumberController.text = value.substring(1);
                  }
                },
                builder: (field) => DefaultTextfield(
                    textInputType: TextInputType.number,
                    controller: repeatNumberController,
                    label: "Repeat New Number",
                    errorText: field.errorText,
                    onChanged: (p0) {
                      repeatNumberValue = p0;
                      field.didChange(p0);
                    }),
              ),
            ]),
          )),
      bottomSheet: BlocConsumer(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpdateUserLoaded) {
            context.goNamed("profile");
          }
          if (state is UpdateUserError) {
            OKToast(
              child: Text(
                state.errorMessage,
              ),
            );
            print(state.errorMessage);
          }
          if (state is GetCacheDataLoaded) {
            id = state.owner.id;
            setState(() {
              
            });
          }
        },
        builder: (context, state) {
          return bottomSheetButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  Map<String, dynamic> params = {
                    "id": id ?? "",
                    "phone_number": newNumberValue ?? newNumberController.text
                  };
                  authBloc.add(
                    UpdateUserEvent(params: params),
                  );
                }
              },
              context: context,
              label: "Change Number");
        },
      ),
    );
  }
}
