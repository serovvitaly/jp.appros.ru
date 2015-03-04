<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model {

    protected $fillable = ['user_id', 'name', 'description'];

    public function purchases()
    {
        return $this->belongsToMany('\App\Models\Purchase');
    }

    public function categories()
    {
        return $this->belongsToMany('\App\Models\Category');
    }

    public function attributes()
    {
        return $this->hasMany('\App\Models\AttributeValue');
    }

    /**
     * Возвращает коллекцию цен данного продукта для связанных "Ценовых сеток"
     * @return mixed
     */
    public function prices()
    {
        return \DB::table(\App\Helpers\Project::PRICES_TABLE_NAME)->where('product_id', $this->id)->get(['column_id', 'price']);
    }

}
