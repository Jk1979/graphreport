<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Rap2hpoutre\FastExcel\FastExcel;
use App\Client;

class ClientSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $collection = (new FastExcel)->import('clients.xlsx');
        $collection->each(function($item,$key){
            Client::create($item);
        });
    }
}
