part of 'api_bloc.dart';

abstract class APIState {}

final class APIInitial extends APIState {}

final class APILoading extends APIState {}

final class APILoaded extends APIState {
  final List<dynamic> posts;
  final List<dynamic> comments;
  final List<dynamic> albums;
  final List<dynamic> photos;
  final List<dynamic> todos;
  final List<dynamic> users;

  APILoaded({
    this.posts = const [],
    this.comments = const [],
    this.albums = const [],
    this.photos = const [],
    this.todos = const [],
    this.users = const [],
  });
}

final class APIError extends APIState {
  final String message;

  APIError(this.message);
}
