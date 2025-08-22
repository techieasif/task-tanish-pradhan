import 'package:flutter/material.dart';
import 'package:task/core/reusable_widgets/add_new_todo_bottom_sheet.dart';
import 'package:task/core/reusable_widgets/todo_item.dart';
import 'package:task/data/model/todo_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TodoModel> todoList = [];
  Set<String> selectedTodos = {};

  Future<void> addMainTodo() async {
    final todo = await addTodoBottomSheet(context: context);

    if (todo != null) {
      setState(() {
        todoList.add(TodoModel(mainTodo: todo, subTodos: []));
      });
    }
  }

  Future<void> addSubTodo(String mainTodo) async {
    final newSubTodo = await addTodoBottomSheet(context: context);

    if (newSubTodo != null) {
      for (var todo in todoList) {
        if (todo.mainTodo == mainTodo) {
          setState(() {
            todo.subTodos?.add(newSubTodo);
          });
        }
      }
    }
  }

  void updateSelectedTodosList(String todo, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        selectedTodos.add(todo);
      } else {
        selectedTodos.remove(todo);
      }
    });
  }

  void removeMainTodo(String todo) {
    setState(() {
      todoList.removeWhere((e) => e.mainTodo == todo);
    });
  }

  void removeSubTodo(String mainTodo, String subTodo) {
    for (var todoElement in todoList) {
      if (todoElement.mainTodo == mainTodo) {
        setState(() {
          todoElement.subTodos?.removeWhere((element) => element == subTodo);
        });
      }
    }
  }

  Widget divider() {
    return Divider(
      thickness: 1.0,
      height: 1.0,
      color: Colors.black26,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO-DO"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addMainTodo(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            divider(),
            ListView.separated(
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final mainTodo = todoList[index].mainTodo;
                final subTodoList = todoList[index].subTodos;

                if (subTodoList == null || subTodoList.isEmpty) {
                  return TodoItem(
                    todo: mainTodo,
                    isSelected: selectedTodos.contains(mainTodo),
                    onChanged: (newValue) =>
                        updateSelectedTodosList(mainTodo, newValue),
                    deletePressed: () => removeMainTodo(mainTodo),
                    addButtonPressed: () => addSubTodo(mainTodo),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoItem(
                      todo: mainTodo,
                      isSelected: selectedTodos.contains(mainTodo),
                      onChanged: (newValue) =>
                          updateSelectedTodosList(mainTodo, newValue),
                      deletePressed: () => removeMainTodo(mainTodo),
                      addButtonPressed: () => addSubTodo(mainTodo),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 12.0),
                      child: divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: subTodoList.length,
                        itemBuilder: (context, index) {
                          final element = subTodoList[index];
                          return TodoItem(
                            todo: element,
                            isSelected: selectedTodos.contains(element),
                            onChanged: (newValue) =>
                                updateSelectedTodosList(element, newValue),
                            deletePressed: () => removeSubTodo(mainTodo, element),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                            child: divider(),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: divider(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}