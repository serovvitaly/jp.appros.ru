<?php namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model {

    protected $fillable = ['name', 'parent_id', 'project_id'];

    public function products()
    {
        return $this->belongsToMany('\App\Models\Product');
    }

}
