<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Client;
use Illuminate\Support\Facades\DB;

class ChartController extends Controller
{
   
    public function chartData() {
        $data =  $this->getChartData();
        return response()->json($data);
    }

    public function search(Request $request) {

        $criteria = $request->all();
        $data =  $this->getChartData($criteria);
        return response()->json($data);

    }

    protected function getChartData($criteria = []) {
        $colors = [
            '#466FFF',
            '#FF4286',
            '#31DDA9'
        ];
        $data = [];
        $keywords = ['client','product','date','total'];
        $keyword = !empty($criteria['keyword']) ? $criteria['keyword'] : null;
        $query = !empty($criteria['query']) ? $criteria['query'] : null;
       
        if(!in_array($keyword,$keywords)) $keyword = null;

        
        $label = Product::select('date')->groupBy('date')->orderBy('date')->get()->pluck('date')->toArray();
        $clients = Client::with(array(
            'products' => function ($q) use($query,$keyword){
                if($query) {
                    if($keyword && $keyword != 'client') {
                        switch($keyword) {
                            case 'date':
                                $date = date('Y-m-d',strtotime($query));
                                $q->where($keyword,$date);
                            break;
                            default:
                                $q->where($keyword,'like','%' .$query . '%');    
                        }
                        
                    }
                }
                $q->orderBy('date', 'asc');
        }));
        if($query && $keyword == 'client') $clients->where($keyword,$query);
        $clients = $clients->get();

        $data['labels'] = $label;
        $data['datasets'] = [];
        $clients->each(function($client,$key) use(&$data,$colors,$label) {
            $dt = array_fill(5, count($label), 0);
            $products = $client->products;
            
            $prodSet = [
                'label'=> $client->client,
                'lineTension'=> 0,
                'fill'=> false,
                'borderColor'=> $colors[$client->id-1],
                'backgroundColor'=> "#ffffff00",
            ];
            if($products->count()) {
                foreach($products as $prod) {
                    $key = array_search($prod->date, $label);
                    $dt[$key] = $prod->total;
                }
            }
            else $dt = [];
            $prodSet['data'] = $dt;
            $data['datasets'][] = $prodSet;
        });
        return $data;
        

        
        // $data = [
        //     'labels'=> ['12.02.2015','13.02.2015','14.02.2015','15.02.2015','16.02.2015','18.02.2015','19.02.2015'],
        //     'datasets'=> [
               
        //         [
        //             'label'=> 'Acme',
        //             // 'backgroundcolor'=>'#F26202',
        //             'data'=>[41,42,43,44,45,46,47],
        //             'lineTension'=> 0,
        //             'fill'=> false,
        //             'borderColor'=> "#466FFF",
        //             'backgroundColor'=> "#ffffff00",
        //         ],
        //         [
        //             'label'=> 'Apple',
        //             'data'=>[10000,100000,339],
        //             'lineTension'=> 0,
        //             'fill'=> false,
        //             'borderColor'=> "#FF4286",
        //             'backgroundColor'=> "#ffffff00",
        //         ]
        //     ]
        // ];
    }
    

    public static function dQ($builder, $returnQuery = false){
        $query = str_replace(array('?'), array('\'%s\''), $builder->toSql());
        $query = vsprintf($query, $builder->getBindings());
        if($returnQuery) return $query;
        echo($query);
        die;
    }
    // public static function escape_like(string $value, string $char = '\\'): string
    // {
    //     return str_replace(
    //         [$char, '%', '_'],
    //         [$char.$char, $char.'%', $char.'_'],
    //         $value
    //     );
    // }
}
