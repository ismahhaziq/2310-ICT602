# Flutter with Laravel

- folder laravel_flutter(flutter apps)
- for flutter application

- folder laravel_flutter_crud(Laravel)
- for laravel backend

https://youtu.be/siDAsX_8eY0




snipped code flutter for the api connection
```
class TaskProvider extends ChangeNotifier {
  final ApiService apiService = ApiService('http://192.168.0.108:8000/api'); // Adjust the URL

  List<Task> tasks = [];

  Future<void> fetchTasks() async {
    tasks = await apiService.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task newTask) async {
    await apiService.addTask(newTask);
    await fetchTasks(); // Refresh the task list after adding a new task
  }

  Future<void> updateTaskCompletion(int id, bool completed) async {
    await apiService.updateTaskCompletion(id, completed);
    await fetchTasks(); // Refresh the task list after updating task completion
  }

  Future<void> deleteTask(int id) async {
  // Remove the task from the list
  tasks.removeWhere((task) => task.id == id);

  // Notify listeners after removing the task
  notifyListeners();

  // Perform the API call or other necessary cleanup
  await apiService.deleteTask(id);
 }

}

```

taskController on laravel
```
<?php

namespace App\Http\Controllers;

use App\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TaskController extends Controller
{
    // Get all tasks
    public function index(Request $request)
    {
        $tasks = Task::all();
        return response()->json($tasks, 200);
    }

    // Update an existing task
    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'completed' => 'boolean',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $task->update([
            'completed' => $request->input('completed', $task->completed),
        ]);

        return response()->json($task, 200);
    }

    // Create a new task
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        $task = Task::create([
            'title' => $request->input('title'),
            'description' => $request->input('description', ''),
            'completed' => false, // Default value for a new task
        ]);

        return response()->json($task, 201);
    }

    // Delete an existing task
    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $task->delete();

        return response()->json(null, 204);
    }
}

```



