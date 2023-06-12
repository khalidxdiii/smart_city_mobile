import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(ReportInitialState());

  static ReportCubit get(context) => BlocProvider.of(context);
}
