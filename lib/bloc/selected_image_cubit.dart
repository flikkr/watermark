import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedImageCubit extends Cubit<int> {
  SelectedImageCubit() : super(0);

  void selectImage(int index) => emit(index);
}
