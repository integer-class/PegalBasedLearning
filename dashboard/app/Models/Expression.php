<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Expression extends Model
{
    use HasFactory;

    protected $fillable = ['sad', 'disgust', 'surprise', 'angry', 'fear', 'happy', 'neutral'];

    public function interviewee(): BelongsTo
    {
        return $this->belongsTo(Interviewee::class);
    }
}
