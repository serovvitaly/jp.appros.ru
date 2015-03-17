<?php namespace App\Http\Controllers;


class ExtGeneratorController extends Controller {

    public function getComponent($alias)
    {
        $alias_mix = [];

        preg_match('/([\d\w]+)\/([\d\w]+)\.js/', $alias, $alias_mix);

        if (count($alias_mix) != 3) {
            return;
        }

        $model_name = $alias_mix[2];

        $model_full_name = $this->getModelFullName($model_name);

        switch (strtolower($alias_mix[1])) {
            case 'store':
                $content = view('ext.data.Store', ['model_name' => $model_name]);
                break;
            case 'treestore':
                $content = view('ext.data.TreeStore', ['model_name' => $model_name]);
                break;
            case 'model':

                $fields_str = '';

                if ($model_full_name) {
                    $model = new $model_full_name;

                    $column_listing = \Schema::getColumnListing($model->getTable());

                    $fields = array_diff($column_listing, $model->getHidden());

                    $fields_str = '"' . implode('","', $fields) . '"';
                }

                $content = view('ext.data.Model', ['model_name' => $model_name, 'fields' => $fields_str]);
                break;
            case 'controller':
                //
                break;
        }

        return response($content, 200)->header('Content-Type', 'application/javascript');
    }


    public function restModel($model_name, $id = null)
    {
        $model_full_name = $this->getModelFullName($model_name);

        switch (strtolower(\Request::method())) {
            case 'get':

                if ($id) {
                    return $model_full_name::find($id);
                }

                $page  = intval(\Input::get('page'));
                $start = intval(\Input::get('start'));
                $limit = intval(\Input::get('limit'));

                return $model_full_name::offset($start)->take($limit)->get();

            case 'post':

                $data_fields = \Input::all();

                $id = 0;
                if (array_key_exists('id', $data_fields)) {
                    $id = intval($data_fields['id']);
                }

                if ($id) {
                    $model = $model_full_name::find($id);
                    $model->update($data_fields);
                } else {
                    $model = $model_full_name::create($data_fields);
                }

                return ['success'=>true, 'model' => $model];

                break;

            case 'delete':

                $id = intval(\Input::get('id'));

                if ($id) {
                    $model_full_name::destroy($id);
                }

                break;
        }
    }


    protected function getModelFullName($model_name)
    {
        $model_name = ucfirst(strtolower($model_name));

        $model_full_name = '\App\\' . $model_name;
        if (!class_exists($model_full_name)) {
            $model_full_name = '\App\Models\\' . $model_name;
            if (!class_exists($model_full_name)) {
                $model_full_name = null;
            }
        }

        return $model_full_name;
    }

}