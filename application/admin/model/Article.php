<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2018/10/7
 * Time: 17:17
 */
namespace app\admin\model;
use think\Model;

class Article extends Model
{
    protected $pk = 'id';
    protected $table = 'fx_article';

    protected static function init()
    {

        self::afterDelete(function ($data) {
            //控制需要用destroy方法触发,不可用delete
            @unlink($data['pic']);
        });

    }



}