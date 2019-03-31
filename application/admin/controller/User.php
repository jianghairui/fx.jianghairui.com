<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2018/10/15
 * Time: 20:30
 */
namespace app\admin\controller;

use think\Db;
class User extends Common {

    public function userlist() {

        $param['status'] = input('param.status','0');
        $param['logmin'] = input('param.logmin');
        $param['logmax'] = input('param.logmax');
        $param['search'] = input('param.search');

        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);

        $where = [];

        if($param['status'] !== '0') {
            if($param['status'] == '1') {
                $where[] = ['level','=',1];
            }
            if($param['status'] == '2') {
                $where[] = ['level','<>',1];
            }
        }

        $code = session('code');

        if(session('username') !== config('superman') && !is_null($code)) {
            $where[] = ['top_code','=',$code];
        }

        if($param['logmin']) {
            $where[] = ['create_time','>=',strtotime(date('Y-m-d 00:00:00',strtotime($param['logmin'])))];
        }

        if($param['logmax']) {
            $where[] = ['create_time','<=',strtotime(date('Y-m-d 23:59:59',strtotime($param['logmax'])))];
        }

        if($param['search']) {
            $where[] = ['nickname|realname|tel|code','like',"%{$param['search']}%"];
        }

        $count = Db::table('fx_user')->where($where)->count();
        $page['count'] = $count;
        $page['curr'] = $curr_page;
        $page['totalPage'] = ceil($count/$perpage);

        $list = Db::table('fx_user')->where($where)->limit(($curr_page - 1)*$perpage,$perpage)->select();
        $this->assign('list',$list);
        $this->assign('page',$page);
        $this->assign('status',$param['status']);
        return $this->fetch();
    }

    public function userdetail() {
        $id = input('param.id');
        $info = Db::table('fx_user')->where('id',$id)->find();
        $upper = Db::table('fx_price')->column('max');
        $this->assign('info',$info);
        $this->assign('upper',$upper);
        return $this->fetch();
    }

    public function whitelist() {
        $param['search'] = input('param.search');

        $where = [];
        if($param['search']) {
            $where[] = ['tel','like',"%{$param['search']}%"];
        }

        $count = Db::table('fx_whitelist')->where($where)->count();
        $list = Db::table('fx_whitelist')->where($where)->select();
        $this->assign('list',$list);
        $this->assign('count',$count);
        return $this->fetch();
    }

    public function teladd() {
        return $this->fetch();
    }

    public function teladdPost() {
        $data['tel'] = input('post.tel');

        $exist = Db::table('fx_whitelist')->where('tel',$data['tel'])->find();
        if($exist) {
            return ajax('手机号已存在',-1);
        }

        try {
            Db::table('fx_whitelist')->insert($data);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function usermod() {
        $data['id'] = input('post.id');
        $data['realname'] = input('post.realname');
        $data['tel'] = input('post.tel');
        $data['team'] = input('post.team');
        $data['upper_limit'] = input('post.upper_limit');
        try {
            Db::table('fx_user')->where('id',$data['id'])->update($data);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }

        return ajax();

    }

    //拉黑用户
    public function userStop() {
        $id = input('post.id');
        $map[] = ['id','=',$id];
        try {
            $res = Db::table('fx_user')->where($map)->update(['status'=>0]);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        if($res) {
            return ajax([],1);
        }else {
            return ajax('拉黑失败',-1);
        }
    }
    //恢复用户
    public function userGetback() {
        $id = input('post.id');
        $map[] = ['status','=',0];
        $map[] = ['id','=',$id];
        try {
            $res = Db::table('fx_user')->where($map)->update(['status'=>1]);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        if($res) {
            return ajax([],1);
        }else {
            return ajax('恢复失败',-1);
        }
    }

}