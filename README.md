# flutter-mvvm-todo-app
MVVMアーキテクチャ、viewModel-repositoryパターンで作ったFlutter TODO App

# OverView
<img width="250" src="https://user-images.githubusercontent.com/52367439/127565837-0093ecf5-5bd8-400f-87f6-cb98c785c091.gif"/>

# Architecture
<img width="700" src="https://user-images.githubusercontent.com/52367439/127564365-851468eb-3fb2-4459-bfb5-39423bfb2d8f.png"/>

# MVVM Logic

### TaskRepositoryImpl.dart (Repository)
```dart
// define riverpod provider. using TaskRepository for parameter type to keep testability.
final taskRepositoryProvider = Provider<TaskRepository>((ref) => TaskRepositoryImpl());

class TaskRepositoryImpl implements TaskRepository {

  @override
  Future<List<Task>> getAllTasks() async {
    final db = await databaseProvider.database;
    final result = await db.rawQuery('SELECT * FROM $taskTable');
    return result.map((json) => Task.fromJson(json)).toList();  // freezed json mapping
  }
}
```

### HomeViewModel.dart (ViewModel)
```dart
// define riverpod provider
final homeViewModelNotifierProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref.read(taskRepositoryProvider)));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._taskRepository);

  final TaskRepository _taskRepository;
  List<Task>? _taskList;
  List<Task>? get taskList => _taskList;

  // fetch tasks from repository
  Future<void> fetchTaskList() {
    return _taskRepository.getAllTasks().then((value) {
      _taskList = value;
    }).catchError((error) {
      // handle errors
    }).whenComplete(notifyListeners); // notifiy the data changed
  }
}
```

### HomePage.dart (View)
```dart
class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // injection with riverpod provider
    final viewModel = useProvider(homeViewModelNotifierProvider);

    useEffect(() {
      viewModel.fetchTaskList();
      return viewModel.dispose;
    }, const []);
    
     // use viewModel.taskList and we can get task list data from local database
    return // some widget
  }
}

```

# KeyWords
- Flutter Hooks
- Riverpod
- ChangeNotifier
- sqflite
- MVVM
- repository pattern
- freezed
