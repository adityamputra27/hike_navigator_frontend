import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hike_navigator/services/mountains_service.dart';

import '../models/mountains_model.dart';

part 'mountains_state.dart';

class MountainsCubit extends Cubit<MountainsState> {
  MountainsCubit() : super(MountainsInitial());

  void fetchMountains(String? keyword, int? provinceId) async {
    try {
      emit(MountainsLoading());

      List<MountainsModel> mountains =
          await MountainsService().fetchMountains(keyword, provinceId);

      emit(MountainsSuccess(mountains));
    } catch (e) {
      emit(MountainsFailed(e.toString()));
    }
  }
}
