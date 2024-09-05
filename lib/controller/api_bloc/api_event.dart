part of 'api_bloc.dart';

abstract class ApiEvent {}

final class FetchPosts extends ApiEvent {}

final class FetchComments extends ApiEvent {}

final class FetchAlbums extends ApiEvent {}

final class FetchPhotos extends ApiEvent {}

final class FetchTodos extends ApiEvent {}

final class FetchUsers extends ApiEvent {}
