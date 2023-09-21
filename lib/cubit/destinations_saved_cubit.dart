import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/services/destinations_saved_service.dart';

part 'destinations_saved_state.dart';

class DestinationsSavedCubit extends Cubit<DestinationsSavedState> {
  DestinationsSavedCubit() : super(DestinationsSavedInitial());

  void fetchDestinationsSaved() async {
    try {
      emit(DestinationsSavedLoading());

      List<DestinationsModel> destinationsSaved =
          await DestinationsSavedService().fetchDestinationsSaved();

      emit(DestinationsSavedSuccess(destinationsSaved));
    } catch (e) {
      emit(DestinationsSavedFailed(e.toString()));
    }
  }
}
