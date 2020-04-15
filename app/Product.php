<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    public function client()
    {
        return $this->belongsTo('App\Client');
    }
}
