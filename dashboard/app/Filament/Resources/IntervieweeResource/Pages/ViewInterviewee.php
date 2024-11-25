<?php

namespace App\Filament\Resources\IntervieweeResource\Pages;

use App\Filament\Resources\IntervieweeResource;
use Filament\Resources\Pages\ViewRecord;
use App\Filament\Widgets\ExpressionPieChart;

class ViewInterviewee extends ViewRecord
{
    protected static string $resource = IntervieweeResource::class;

    protected function getHeaderWidgets(): array
    {
        return [
            ExpressionPieChart::class,
        ];
    }
} 