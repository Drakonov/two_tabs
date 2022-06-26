import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_tabs/home/screens/news_promo/todo_screen_view.dart';

import '../screens/news_promo/users_screen_view.dart';
import '../widgets/buttom_nav_bar.dart';
import 'screens_bloc.dart';
import 'screens_event.dart';
import 'screens_state.dart';

final ValueNotifier<int> currentIndexNavBar = ValueNotifier<int>(0);
//int currentIndexNavBar = 0;
var counter = 0;
List stateList = [];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (BuildContext context) => ScreenBloc()..add(InitEvent()),
      ),
    ], child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final blocScreen = BlocProvider.of<ScreenBloc>(context);

    return BlocListener<ScreenBloc, ScreenState>(
      listener: (context, state) {
        if (state is InitState) {
          blocScreen.add(InitEvent());
        }
        //if(state is UserIsAuthorizedState){
        //  bloc.add(UserNotAuthorizedEvent());
        //}
        //if(state is UserNotAuthorizedState){
        //  bloc.add(UserIsAuthorizedEvent());
        //}
      },
      child: WillPopScope(
        onWillPop: () async {
          //if (blocScreen.state is RegistrationState) {
          //  blocScreen.add(LoginScreenEvent());
          //  print('back');
          //  return false;
          //}
          if (blocScreen.state is! UsersScreenState) {
            currentIndexNavBar.value = 0;
            blocScreen.add(UsersScreenEvent());
            print('back');
            return false;
          }

          return true;
        },
        child: SafeArea(child: _body(blocScreen)),
      ),
    );
  }

  Widget _body(ScreenBloc blocScreen) {
    return Scaffold(
        body: BlocBuilder<ScreenBloc, ScreenState>(
          builder: (context, state) {
            ///todo add MainScreenView
            //return Container();
            if (state is UsersScreenState) {
              return UsersScreenView(blocScreen);
              //return MainScreenView(blocScreen, blocAuth);
            }
            if (state is TodoScreenState) {
              return TodoScreenView(blocScreen);
            }

            return UsersScreenView(blocScreen);
            //return MainScreenView(blocScreen, blocAuth);
          },
        ),
        bottomNavigationBar: NotAuthNavBar(blocScreen));
  }
}
