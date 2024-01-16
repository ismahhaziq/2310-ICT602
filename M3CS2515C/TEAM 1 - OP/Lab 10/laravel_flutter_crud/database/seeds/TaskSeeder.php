<?php

use Illuminate\Database\Seeder;
use App\Task; // Assuming your Task model is in the App namespace

class TaskSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Clear existing tasks
        Task::truncate();

        // Seed new tasks
        Task::create([
            'title' => 'Task 1',
            'description' => 'Description for Task 1',
            'completed' => false,
        ]);

        Task::create([
            'title' => 'Task 2',
            'description' => 'Description for Task 2',
            'completed' => true,
        ]);

        Task::create([
            'title' => 'Task 3',
            'description' => 'Description for Task 3',
            'completed' => false,
        ]);

        // Add more tasks as needed
    }
}
