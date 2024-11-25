<?php

namespace Database\Seeders;

use App\Models\Expression;
use App\Models\Interviewee;
use Illuminate\Database\Seeder;

class ExpressionSeeder extends Seeder
{
    public function run(): void
    {
        // Get all interviewees
        $interviewees = Interviewee::all();

        // For each interviewee, create multiple expression records
        foreach ($interviewees as $interviewee) {
            // Create 5 random expression records for each interviewee
            for ($i = 0; $i < 5; $i++) {
                $interviewee->expressions()->create([
                    'sad' => rand(0, 100),
                    'disgust' => rand(0, 100),
                    'surprise' => rand(0, 100),
                    'angry' => rand(0, 100),
                    'fear' => rand(0, 100),
                    'happy' => rand(0, 100),
                    'neutral' => rand(0, 100),
                ]);
            }
        }
    }
}
