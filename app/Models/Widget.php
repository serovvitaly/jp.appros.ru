<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Widget extends Model {

    protected $fillable = ['name', 'description', 'handler', 'region', 'status'];

}
