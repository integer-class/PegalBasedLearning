<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use App\Models\Expression;

class Interviewee extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'gender', 'email', 'cv', 'expression_id'];

    public function expression(): HasOne
    {
        return $this->hasOne(Expression::class);
    }

    public function expressions()
    {
        return $this->hasMany(Expression::class);
    }
}
