<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AttributeValue extends Model {

    public $timestamps = false;

    protected $fillable = ['attribute_id', 'value', 'product_id'];

}
