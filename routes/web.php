<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/chart-data', 'ChartController@chartData');
Route::get('/test-data', 'ChartController@testData');
Route::post('/chart-data', 'ChartController@search');
Route::delete('/delproduct/{id}','ChartController@deleteProduct');
Route::put('/updproduct','ChartController@updateProduct');
Route::post('/report','ChartController@sendReport');
