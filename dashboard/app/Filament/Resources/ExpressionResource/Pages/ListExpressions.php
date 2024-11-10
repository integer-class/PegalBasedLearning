<?php

namespace App\Filament\Resources\ExpressionResource\Pages;

use App\Filament\Resources\ExpressionResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListExpressions extends ListRecords
{
    protected static string $resource = ExpressionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
