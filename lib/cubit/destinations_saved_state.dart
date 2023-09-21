part of 'destinations_saved_cubit.dart';

abstract class DestinationsSavedState extends Equatable {
  const DestinationsSavedState();

  @override
  List<Object> get props => [];
}

class DestinationsSavedInitial extends DestinationsSavedState {}

class DestinationsSavedLoading extends DestinationsSavedState {}

class DestinationsSavedSuccess extends DestinationsSavedState {
  final List<DestinationsModel> destinationsSaved;

  const DestinationsSavedSuccess(this.destinationsSaved);

  @override
  List<Object> get props => [destinationsSaved];
}

class DestinationsSavedFailed extends DestinationsSavedState {
  final String error;

  const DestinationsSavedFailed(this.error);

  @override
  List<Object> get props => [error];
}
