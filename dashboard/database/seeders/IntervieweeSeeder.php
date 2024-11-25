<?php

namespace Database\Seeders;

use App\Models\Interviewee;
use Illuminate\Database\Seeder;

class IntervieweeSeeder extends Seeder
{
    public function run(): void
    {
        $interviewees = [
            [
                'name' => 'John Doe',
                'email' => 'john@example.com',
                'gender' => 'male',
                'status' => 'pending',
            ],
            [
                'name' => 'Jane Smith',
                'email' => 'jane@example.com',
                'gender' => 'female',
                'status' => 'accepted',
            ],
            [
                'name' => 'Mike Johnson',
                'email' => 'mike@example.com',
                'gender' => 'male',
                'status' => 'rejected',
            ],
            [
                'name' => 'Sarah Williams',
                'email' => 'sarah@example.com',
                'gender' => 'female',
                'status' => 'pending',
            ],
            [
                'name' => 'David Brown',
                'email' => 'david@example.com',
                'gender' => 'male',
                'status' => 'accepted',
            ],
        ];

        foreach ($interviewees as $interviewee) {
            Interviewee::create($interviewee);
        }
    }
}
