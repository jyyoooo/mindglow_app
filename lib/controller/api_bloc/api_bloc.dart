import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'api_event.dart';
part 'api_state.dart';

class APIBloc extends Bloc<ApiEvent, APIState> {
  APIBloc() : super(APIInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<FetchComments>(_onFetchComments);
    on<FetchAlbums>(_onFetchAlbums);
    on<FetchPhotos>(_onFetchPhotos);
    on<FetchTodos>(_onFetchTodos);
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<APIState> emit) async {
    emit(APILoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final posts = jsonDecode(response.body);
      log(posts.toString());

      emit(APILoaded(posts: posts));
    } catch (e) {
      log(e.toString());
      emit(APIError('Something went wrong!!'));
    }
  }

  Future<void> _onFetchComments(
      FetchComments event, Emitter<APIState> emit) async {
    emit(APILoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      final comments = jsonDecode(response.body);
      emit(APILoaded(comments: comments));
    } catch (e) {
      log(e.toString());
      emit(APIError('Something went wrong!!'));
    }
  }

  Future<void> _onFetchAlbums(FetchAlbums event, Emitter<APIState> emit) async {
    emit(APILoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
      final albums = jsonDecode(response.body);
      emit(APILoaded(albums: albums));
    } catch (e) {
      log(e.toString());
      emit(APIError('Failed to fetch albums'));
    }
  }

  Future<void> _onFetchPhotos(FetchPhotos event, Emitter<APIState> emit) async {
    emit(APILoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      final photos = jsonDecode(response.body);
      emit(APILoaded(photos: photos));
    } catch (e) {
      log(e.toString());
      emit(APIError('Failed to fetch photos'));
    }
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<APIState> emit) async {
    emit(APILoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      final todos = jsonDecode(response.body);
      emit(APILoaded(todos: todos));
    } catch (e) {
      log(e.toString());
      emit(APIError('Failed to fetch todos'));
    }
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<APIState> emit) async {
    emit(APILoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      final users = jsonDecode(response.body);
      emit(APILoaded(users: users));
    } catch (e) {
      log(e.toString());
      emit(APIError('Failed to fetch users'));
    }
  }
}
