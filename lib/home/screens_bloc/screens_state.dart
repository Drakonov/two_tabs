class ScreenState {
  ScreenState init() {
    return ScreenState();
  }

  ScreenState clone() {
    return ScreenState();
  }
}

class InitState extends ScreenState {}

class UsersScreenState extends ScreenState {}

class TodoScreenState extends ScreenState {}
