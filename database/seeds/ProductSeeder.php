<?php

use Illuminate\Database\Seeder;
use Rap2hpoutre\FastExcel\FastExcel;
use App\Client;
use App\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        
        $collection = (new FastExcel)->import('products.xlsx');
        $collection->each(function($item,$key){
            $client = Client::where('client',$item['Client'])->first();
            if($client) {
                Product::create([
                    'product' => $item['Product'],
                    'total' => $item['Total'],
                    'client_id' => $client->id,
                    'Date' => $item['Date']->format('Y-m-d')
                ]);
                    
            }
                
        });
    }
}
