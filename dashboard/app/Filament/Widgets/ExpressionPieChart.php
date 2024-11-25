<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;

class ExpressionPieChart extends ChartWidget
{
    public $record;

    protected static ?string $heading = 'Expression Analysis';

    protected function getData(): array
    {
        @$expressions = $this->record->expressions()->latest()->first();

        if (!$expressions) {
            return [
                'datasets' => [
                    [
                        'data' => [0],
                        'backgroundColor' => ['#808080'],
                    ],
                ],
                'labels' => ['No data available'],
            ];
        }

        return [
            'datasets' => [
                [
                    'data' => [
                        $expressions->sad,
                        $expressions->disgust,
                        $expressions->surprise,
                        $expressions->angry,
                        $expressions->fear,
                        $expressions->happy,
                        $expressions->neutral,
                    ],
                    'backgroundColor' => [
                        '#FF6B6B', // sad
                        '#4ECDC4', // disgust
                        '#45B7D1', // surprise
                        '#FF4136', // angry
                        '#B10DC9', // fear
                        '#FFD93D', // happy
                        '#95A5A6', // neutral
                    ],
                ],
            ],
            'labels' => ['Sad', 'Disgust', 'Surprise', 'Angry', 'Fear', 'Happy', 'Neutral'],
        ];
    }

    protected function getType(): string
    {
        return 'pie';
    }
} 