<?php
namespace app\admin\controller;
use my\Auth;
use think\Db;
use think\Exception;

class Index extends Common
{

    //首页
    public function index() {
        $auth = new Auth();
        $authlist = $auth->getAuthList(session('admin_id'));
        $this->assign('authlist',$authlist);
        return $this->fetch();
    }

}
