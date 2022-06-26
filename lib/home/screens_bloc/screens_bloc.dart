import 'package:bloc/bloc.dart';
import 'package:two_tabs/home/screens_bloc/screens_event.dart';
import 'screens_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  int counter = 0;

  ScreenBloc() : super(UsersScreenState()) {
    on<InitEvent>((event, emit) => mainScreen(emit));
    on<UsersScreenEvent>((event, emit) => mainScreen(emit));
    on<TodoScreenEvent>((event, emit) => todoScreen(emit));
  }

  Future<void> mainScreen(Emitter<ScreenState> emit) async {
    emit(UsersScreenState());
  }

  Future<void> todoScreen(Emitter<ScreenState> emit) async {
    emit(TodoScreenState());
  }
}
