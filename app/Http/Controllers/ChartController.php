<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Client;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use App\Mail\OrderReport;

class ChartController extends Controller
{
   
    public function testData() {
        $data =  $this->getData();
        return response()->json($data);
    }
    public function chartData() {
        $data =  $this->getChartData();
        return response()->json($data);
    }

    public function updateProduct(Request $request) {
        $data = $request->data;
        $data['date'] = !empty($data['date']) ? date('Y-m-d',strtotime($data['date'])) : date('Y-m-d');
        $id = intval($data['id']);
        
        try 
        {
            $affectedRows = Product::where('id', $id)->update($data);
            return response()->json('product updated' . $affectedRows);
        }
    
        catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
    public function deleteProduct(Request $request) {
       
        $id = intval($request->id);
        try 
        {
            Product::where('id', $id)->delete(); 
            return response()->json('product deleted');
        }
    
        catch (Exception $e) {
            return response()->json($e->getMessage(), 500);
        }
    }
    public function sendReport(Request $request)
    {
        
        $criteria = $request->all();
        $criteria['nopagin'] = true;
        $data =  $this->getData($criteria);

      
        $to  = 'nick@webscribble.com';
        $to2 = 'alexander@webscribble.com';

        $emailData = !empty($data['tableData']) ? $data['tableData'] : null;
       
        if($emailData) {
            Mail::to($to)->send(new OrderReport($emailData));
            Mail::to($to2)->send(new OrderReport($emailData));
            return response()->json('Report has been sent');
        }
        return response()->json('Error occurred while sending email');
    }

    public function search(Request $request) {

        $criteria = $request->all();
        $data =  $this->getData($criteria);
        return response()->json($data);

    }

    protected function getData($criteria = []) {
        $colors = [
            'acme'=>'#466FFF',
            'microsoft'=>'#FF4286',
            'apple'=>'#31DDA9'
        ];
        $data = [];
        $keywords = ['client','product','date','total'];
        $keyword = !empty($criteria['keyword']) ? $criteria['keyword'] : null;
        $sort = !empty($criteria['sort']) ? $criteria['sort'] : 'client';
        $sortdir = !empty($criteria['sortdir']) ? $criteria['sortdir'] : 'asc';
        $query = !empty($criteria['query']) ? $criteria['query'] : null;
        $nopagin = !empty($criteria['nopagin']) ? $criteria['nopagin'] : false;
        if($keyword !== 'all' && !in_array($keyword,$keywords)) $keyword = null;
        
        
        $query = !empty($criteria['query']) ? $criteria['query'] : null;
        unset($keywords['client']);$keywords[]='client_id';
        
        $label = Product::select('date')->groupBy('date')->orderBy('date')->get()->pluck('date')->toArray();
        
        $dbData = DB::table('products as p')
        ->join('clients as c','p.client_id','=','c.id')
        ->selectRaw('p.*,c.client');
        
        if($query ) {
         
            switch($keyword) {
                case 'client':
                    $dbData->where('c.client','like','%' .$query . '%');    
                break;
                case 'date':
                    $date = date('Y-m-d',strtotime($query));
                    $dbData->where('p.'.$keyword,$date);
                break;
                case 'all':
                    $dbData->where(function ($q) use($query,$keywords) {
                        foreach($keywords as $kword) {
                            $q->orWhere($kword,'like','%'.$query.'%');
                        }
                    });   
                break;
                default:
                    $dbData->where('p.'.$keyword,'like','%'.$query.'%');   
            }
        }
        if($sort == 'client') $sort = "c.client $sortdir, p.date ASC"; 
        elseif($sort == 'date') $sort = "p.date $sortdir";
        else $sort = "$sort $sortdir, p.date ASC";
        
        // DB::enableQueryLog();
        if($nopagin) $dbData = $dbData->orderByRaw($sort)->get();
        else $dbData = $dbData->orderByRaw($sort)->paginate(10);
        // dd( DB::getQueryLog());
        $data['labels'] = $label;
        $data['datasets'] = [];
        $grouped = $dbData->groupBy('client');
        
        foreach($grouped as $client => $row) {
            $newlabels = [];
            $dt = array_fill(0, count($label), 0);
            // $dt=[];
            
            
            $prodSet = [
                'label'=> $client,
                'lineTension'=> 0,
                'fill'=> false,
                'borderColor'=> !empty($colors[mb_strtolower($client)]) ? $colors[mb_strtolower($client)] : '#466FFF',
                'backgroundColor'=> "#ffffff00",
            ];
            
            if($row->count()) {
                foreach($row as $prod) {
                   
                    $key = array_search($prod->date, $label);
                    $dt[$key] = $prod->total;
                    $newlabels[] = $prod->date;
                }
            }
            else $dt = [];
            $prodSet['data'] = $dt;
            $prodSet['lbs'] = $newlabels;

            $data['datasets'][] = $prodSet;
        }
        // sort($newlabels);
        // $data['labels'] = $newlabels;

        return [
            'tableData' => $dbData->toArray(),
            'chartData' => $data
        ];


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
       
        if($keyword !== 'all' && !in_array($keyword,$keywords)) $keyword = null;
       
        //  DB::enableQueryLog();
        $label = Product::select('date')->groupBy('date')->orderBy('date')->get()->pluck('date')->toArray();
        $clients = Client::with(array(
            'products' => function ($q) use($query,$keyword, $keywords){
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
                    else{
                        $q->where(function ($qor) use($query,$keywords) {
                            foreach($keywords as $kword) {
                                if($kword == 'client') continue;
                                $qor->orWhere($kword,'like','%'.$query.'%');
                            }
                        });
                    }
                }
                $q->orderBy('date', 'asc');
        }));
        if($query && $keyword == 'client') $clients->where($keyword,$query);
        $clients = $clients->get();
        //  dd( DB::getQueryLog());
       
        $data['labels'] = $label;
        $data['datasets'] = [];
        $clients->each(function($client,$key) use(&$data,$colors,$label) {
            $dt = array_fill(0, count($label), 0);
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
