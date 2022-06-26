import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_tabs/main.dart';
import 'package:two_tabs/repository/service_repository.dart';

import '../../../models/repository/Todo.dart';
import '../../screens_bloc/screens_bloc.dart';

Future todo = ServiceRepository.getTodo();
List<Todo>? listTodo;

class TodoScreenView extends StatefulWidget {
  const TodoScreenView(this.blocScreen, {Key? key}) : super(key: key);

  final ScreenBloc blocScreen;

  @override
  TodoScreenViewState createState() => TodoScreenViewState();
}

_scrollPosition() async {
  offsetTodo = controllerTodo.position.pixels;
}

class TodoScreenViewState extends State<TodoScreenView> {
  @override
  void initState() {
    super.initState();
    controllerTodo = ScrollController(initialScrollOffset: offsetTodo);
    controllerTodo.addListener(_scrollPosition);
  }

  @override
  Widget build(BuildContext context) {
    print('build $context');

    return SingleChildScrollView(
      controller: controllerTodo,
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
                    'TO-DO',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  )
                ],
              ),
            ),
          ),
          listTodo == null
              ? FutureBuilder(
                  future: todo,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Todo> todoList = snapshot.data;
                      listTodo = todoList;
                      return Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                _TodoView(widget.blocScreen, todoList),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : _TodoView(widget.blocScreen, listTodo!),
        ],
      ),
    );
  }
}

class _TodoView extends StatefulWidget {
  const _TodoView(this.blocScreen, this.todoList, {Key? key}) : super(key: key);
  final ScreenBloc blocScreen;
  final List<Todo> todoList;

  @override
  State<_TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<_TodoView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Text(
                            '${widget.todoList[index].id}. ${widget.todoList[index].title}')),
                    Expanded(
                        child: Text('${widget.todoList[index].completed}')),
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
