<?php

namespace App\Filament\Resources\IntervieweeResource\Pages;

use App\Filament\Resources\IntervieweeResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditInterviewee extends EditRecord
{
    protected static string $resource = IntervieweeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
