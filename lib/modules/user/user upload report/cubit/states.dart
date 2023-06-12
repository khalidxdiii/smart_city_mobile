abstract class CameraStates {}

class CameraInitialState extends CameraStates {}

class CameraImagePickedSuccessState extends CameraStates {}

class CameraImagePickedErrorState extends CameraStates {}

class ClearImageState extends CameraStates {}

class LoadingTrue extends CameraStates {}

class LoadingFalse extends CameraStates {}

class CameraSetSelectedValueState extends CameraStates {}

class CameraLoadingState extends CameraStates {}
