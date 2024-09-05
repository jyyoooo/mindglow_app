import 'package:flutter_bloc/flutter_bloc.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc() : super(MoodInitial()) {
    on<NewMood>((event, emit) {
      emit(MoodInitial());
      switch (event.mood) {
        case 'happyFace.png':
          emit(GoodMood());
        case 'okayFace.png':
          emit(OkayMood());
        case 'notGoodFace.png':
          emit(NotOkayMood());
        case 'veryBadFace.png':
          emit(ReallyBadMood());
        default:
          emit(MoodInitial());
      }
    });
  }
}

// Mood events
abstract class MoodEvent {}

class NewMood extends MoodEvent {
  final String mood;
  NewMood({required this.mood});
}

abstract class MoodState {}

// Mood states
class MoodInitial extends MoodState {}

class GoodMood extends MoodState {}

class OkayMood extends MoodState {}

class NotOkayMood extends MoodState {}

class ReallyBadMood extends MoodState {}
