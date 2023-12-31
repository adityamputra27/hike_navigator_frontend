import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/services/destinations_service.dart';

part 'destinations_state.dart';

class DestinationsCubit extends Cubit<DestinationsState> {
  DestinationsCubit() : super(DestinationsInitial());

  void fetchDestinations(String? keyword, int? provinceId) async {
    try {
      emit(DestinationsLoading());

      List<DestinationsModel> destinations =
          await DestinationsService().fetchDestinations(keyword, provinceId);

      emit(DestinationsSuccess(destinations));
    } catch (e) {
      emit(DestinationsFailed(e.toString()));
    }
  }
}
