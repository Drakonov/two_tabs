import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_tabs/main.dart';

import '../../../models/repository/Users.dart';
import '../../../repository/service_repository.dart';
import '../../screens_bloc/screens_bloc.dart';

Future users = ServiceRepository.getUsers();
List<User>? listUser;

_scrollPosition() async {
  offsetUser = controllerUser.position.pixels;
}

class UsersScreenView extends StatefulWidget {
  const UsersScreenView(this.blocScreen, {Key? key}) : super(key: key);

  final ScreenBloc blocScreen;

  @override
  UsersScreenViewState createState() => UsersScreenViewState();
}

class UsersScreenViewState extends State<UsersScreenView> {
  @override
  void initState() {
    super.initState();
    controllerUser = ScrollController(initialScrollOffset: offsetUser);
    controllerUser.addListener(_scrollPosition);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build $context');
    return SingleChildScrollView(
      controller: controllerUser,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Users',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  )
                ],
              ),
            ),
          ),
          listUser == null
              ? FutureBuilder(
                  future: users,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // data loaded:
                      List<User> userList = snapshot.data;
                      listUser = userList;
                      return Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                _Users(widget.blocScreen, userList),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      // while data is loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : _Users(widget.blocScreen, listUser!),
        ],
      ),
    );
  }
}

class _Users extends StatelessWidget {
  const _Users(this.blocScreen, this.listUser, {Key? key}) : super(key: key);

  final ScreenBloc blocScreen;
  final List<User> listUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: listUser.length,
        itemBuilder: (BuildContext context, int index) {
          String initials = '';
          List<String> fioList = listUser[index].name.split(' ');
          for (var item in fioList) {
            initials = '$initials ${item[0]}';
          }

          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black26,
                      ),
                      child: Center(child: Text(initials)),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        child: Text(
                            '${listUser[index].name}\n${listUser[index].email}')),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
