import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../shared/component/componant.dart';
import '../../../shared/component/icon_card_widget.dart';
import '../../../shared/network/remote/image_uploader.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class UserUploadReport extends StatelessWidget {
  const UserUploadReport({super.key});

  @override
  Widget build(BuildContext context) {
    var textcontroller = TextEditingController();
    var titlecontroller = TextEditingController();
    var locationcontroller = TextEditingController();

    var formKey = GlobalKey<FormState>();
    //bool isLoading = true;

    return BlocProvider(
      create: (BuildContext context) => CameraCubit(),
      child: BlocConsumer<CameraCubit, CameraStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CameraCubit cubit = CameraCubit.get(context);

          void showPickerDialog() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Select Image"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        GestureDetector(
                          child: const Text("التقط صوره"),
                          onTap: () {
                            Navigator.of(context).pop();
                            cubit.getimage(ImageSource.camera);
                          },
                        ),
                        const Padding(padding: EdgeInsets.all(8.0)),
                        GestureDetector(
                          child: const Text("اختر من المعرض"),
                          onTap: () {
                            Navigator.of(context).pop();
                            cubit.getimage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return ModalProgressHUD(
            inAsyncCall: context.watch<CameraCubit>().isLoading,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: kDprimaryColor[300],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          IconCardGetImageWidget(
                            //onTap: CameraCubit.get(context).getimage(ImageSource.camera),
                            onTap: showPickerDialog,
                            onDelete: () {
                              context.read<CameraCubit>().clearImage();
                              debugPrint("del");
                            },
                            image: context.watch<CameraCubit>().image,
                            isSelectedImage:
                                context.watch<CameraCubit>().image != null,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultTextFild(
                            label: 'عنوان التقرير',
                            controller: titlecontroller,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء ادخال عنوان التقرير';
                              }
                              return null;
                            },
                            prefixIcon: Icons.task,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultTextFild(
                            label: 'المكان',
                            controller: locationcontroller,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء ادخال المكان ';
                              }
                              return null;
                            },
                            prefixIcon: Icons.explore,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          DefaultDropdownFormField(
                            labelText: 'تحديد القطاع',
                            initialValue: 'الصحه',
                            options: const ['الصحه', 'التعليم', 'طرق وكبارى','النظافه','المياه والصرف','النقل والمواصلات'],
                            onChanged: (value) {
                              context
                                  .read<CameraCubit>()
                                  .setDropdownSelectedValue(value!);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultTextFild(
                            label: 'تفاصيل التقرير',
                            controller: textcontroller,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'برجاء كتابه وصف التقربر';
                              }
                              return null;
                            },
                            prefixIcon: Icons.edit,
                            minLines: 7,
                            maxLines: 7,
                          ),

                          //
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultButton(
                              function: () async {
                                try {
                                  if (formKey.currentState!.validate()) {
                                    context.read<CameraCubit>().isLoadingTrue();
                                    var imUp = ImageUploader();
                                    var url = await imUp.uploadImage(
                                        context.read<CameraCubit>().image!);
                                    bool isDone = await imUp.storeProblem(
                                      url: url,
                                      titleDisc: titlecontroller.text.trim(),
                                      locationDisc:
                                          locationcontroller.text.trim(),
                                      problemDisc: textcontroller.text.trim(),
                                      dropdownSelectedValue: context
                                          .read<CameraCubit>()
                                          .selectedValue!,
                                    );

                                    if (isDone) {
                                      debugPrint('done upload image');
                                    } else {
                                      debugPrint('finish upload image');
                                    }
                                    context.read<CameraCubit>().clearImage();
                                    titlecontroller.clear();
                                    textcontroller.clear();
                                    locationcontroller.clear();
                                    //context.read<CameraCubit>().isLoading = false;
                                    context
                                        .read<CameraCubit>()
                                        .isLoadingFalse();

                                    var snackBar = SnackBar(
                                      content: Text(
                                        'تم رفع التقرير بنجاح',
                                        style: GoogleFonts.almarai(),
                                      ),
                                      backgroundColor: kDprimaryColor,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              },
                              text: 'حفظ')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
