abstract class DataState {}

class ItemInitial extends DataState {}

class ItemDeleting extends DataState {}

class ItemDeleted extends DataState {}

class ItemError extends DataState {
  final String error;

  ItemError(this.error);
}

class ItemFailed extends DataState {
  final String message;

  ItemFailed(this.message);
}