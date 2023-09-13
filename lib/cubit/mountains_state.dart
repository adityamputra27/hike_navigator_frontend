part of 'mountains_cubit.dart';

abstract class MountainsState extends Equatable {
  const MountainsState();

  @override
  List<Object> get props => [];
}

class MountainsInitial extends MountainsState {}

class MountainsLoading extends MountainsState {}

class MountainsSuccess extends MountainsState {
  final List<MountainsModel> mountains;

  const MountainsSuccess(this.mountains);

  @override
  List<Object> get props => [mountains];
}

class MountainsFailed extends MountainsState {
  final String error;

  const MountainsFailed(this.error);

  @override
  List<Object> get props => [error];
}
