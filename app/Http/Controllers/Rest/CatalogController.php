<?php namespace App\Http\Controllers\Rest;

use App\Http\Requests;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;

class CatalogController extends RestController {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
        return [];
	}

	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
        return 'create';
	}

	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$name = trim(\Input::get('name'));
		$parent_id = intval(\Input::get('parent_id'));

        if (empty($name)) {
            return ['success' => false];
        }

        if (!$parent_id) {
            $parent_id = \App\Models\CatalogModel::ROOT_NESTED_SETS_ID;
        }

        $parent = \App\Models\CatalogModel::find($parent_id);

        if (!$parent) {
            return ['success' => false, 'msg' => 'Parent not found'];
        }

        $item = \App\Models\CatalogModel::create(['name' => $name], $parent);

        return ['success' => true, 'item' => $item->get(['id', 'name'])];
	}

	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($node_id)
	{
        $node_id = intval($node_id);

        if (!$node_id) {
            $node_id = \App\Models\CatalogModel::ROOT_NESTED_SETS_ID;
        }

        $node_obj = \App\Models\CatalogModel::find($node_id);

        if (!$node_obj) {
            return [];
        }

        $children = $node_obj->children()->get(['id', 'name']);
        $children_arr = [];
        foreach ($children as $child) {
            $sub_children_count = $child->children()->count();
            $children_arr[] = [
                'id' => $child->id,
                'text' => $child->name . ' (' . $child->id . ')',
                'leaf' => $sub_children_count ? false : true
            ];
        }

        return [
            'text' => $node_obj->name,
            'children' => $children_arr
        ];
	}

	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		return 'edit';
	}

	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($node_id)
	{
        $node_obj = \App\Models\CatalogModel::find($node_id);

        if (!$node_obj) {
            return;
        }

        $parent_id = intval(\Input::get('parentId'));

        $node_obj->parent_id = $parent_id;
        $node_obj->save();
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
        \App\Models\CatalogModel::destroy($id);
	}

}
