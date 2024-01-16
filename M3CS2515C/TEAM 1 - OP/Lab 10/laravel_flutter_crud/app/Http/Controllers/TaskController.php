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
