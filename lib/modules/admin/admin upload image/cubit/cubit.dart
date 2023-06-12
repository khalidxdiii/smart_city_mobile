import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'states.dart';


class AdminCameraCubit extends Cubit<AdminCameraStates> {
  AdminCameraCubit() : super(CameraInitialState());

  static AdminCameraCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  
  File? image;
  String? selectedValue='الصحه'; 
  void clearImage() {
    image = null;
    emit(ClearImageState());
  }

  void isLoadingTrue() {
    isLoading = true;
    emit(LoadingTrue());
  }

  void isLoadingFalse() {
    isLoading = false;
    emit(LoadingFalse());
  }
  void setDropdownSelectedValue(String value ) { // <-- new method to update selected value
    selectedValue = value;
    emit(CameraSetSelectedValueState());
  }

  Future<void> getimage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(CameraImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(CameraImagePickedErrorState());
    }
  }
}
