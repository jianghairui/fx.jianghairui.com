<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2019/1/5
 * Time: 23:09
 */
namespace app\admin\controller;
use think\Db;
class Op extends Common {

    public function orderlist() {

        $param['status'] = input('param.status','');
        $param['logmin'] = input('param.logmin');
        $param['logmax'] = input('param.logmax');
        $param['search'] = input('param.search');

        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);

        $where = [];

        if(session('username') !== config('superman')) {
            $where[] = ['o.top_code','=',session('code')];
            $where[] = ['o.code','<>',session('code')];
        }

        if($param['status'] !== '') {
            $where[] = ['o.status','=',$param['status']];
        }

        if($param['logmin']) {
            $where[] = ['o.create_time','>=',strtotime(date('Y-m-d 00:00:00',strtotime($param['logmin'])))];
        }

        if($param['logmax']) {
            $where[] = ['o.create_time','<=',strtotime(date('Y-m-d 23:59:59',strtotime($param['logmax'])))];
        }

        if($param['search']) {
            $where[] = ['o.name|o.tel|o.order|o.code','like',"%{$param['search']}%"];
        }

        $count = Db::table('fx_order')->alias('o')->where($where)->count();
        $page['count'] = $count;
        $page['curr'] = $curr_page;
        $page['totalPage'] = ceil($count/$perpage);

        $list = Db::table('fx_order')->alias('o')
            ->join('fx_user u','o.code=u.code','left')
            ->where($where)->order(['o.create_time'=>'DESC'])
            ->field('o.*,u.realname')
            ->limit(($curr_page - 1)*$perpage,$perpage)->select();
        $this->assign('list',$list);
        $this->assign('page',$page);
        $this->assign('status',$param['status']);
        return $this->fetch();
    }

    public function orderPass() {

        $map[] = ['status','=',0];
        $map[] = ['id','=',input('post.id',0)];

        if(session('username') !== config('superman')) {
            $mycode = session('code');
            $map[] = ['top_code','=',$mycode];
            $map[] = ['code','<>',$mycode];
        }

        $exist = Db::table('fx_order')->where($map)->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        if(session('username') !== config('superman')) {
            $myinfo = Db::table('fx_user')->where('code','=',$mycode)->find();
            if($myinfo['stock'] < $exist['num']) {
                return ajax('您的库存不足,无法确认',-1);
            }
        }
        Db::startTrans();
        try {
            $update_data = [
                'status' => 1,
                'confirm_time' => time()
            ];
            Db::table('fx_order')->where($map)->update($update_data);
            if(session('username') !== config('superman')) {
                Db::table('fx_user')->where('code','=',$mycode)->setDec('stock',$exist['short_num']);
                Db::table('fx_user')->where('code','=',$mycode)->setInc('team',$exist['short_num']);
            }
            Db::commit();
        }catch (\Exception $e) {
            Db::rollback();
            return ajax($e->getMessage(),-1);
        }
        return ajax([],1);
    }

    public function orderReject() {
        $map[] = ['status','=',0];
        $map[] = ['id','=',input('post.id',0)];

        if(session('username') !== config('superman')) {
            $mycode = session('code');
            $map[] = ['top_code','=',$mycode];
            $map[] = ['code','<>',$mycode];
        }

        $exist = Db::table('fx_order')->where($map)->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        try {
            Db::table('fx_order')->where($map)->delete();
            Db::table('fx_user')->where('code',$exist['code'])->setInc('stock',$exist['stock_num']);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax([],1);
    }

    public function sendlist() {

        $param['logmin'] = input('param.logmin');
        $param['logmax'] = input('param.logmax');
        $param['search'] = input('param.search');

        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);

        $where = [];

        $where[] = ['o.status','=',1];

        if($param['logmin']) {
            $where[] = ['o.create_time','>=',strtotime(date('Y-m-d 00:00:00',strtotime($param['logmin'])))];
        }

        if($param['logmax']) {
            $where[] = ['o.create_time','<=',strtotime(date('Y-m-d 23:59:59',strtotime($param['logmax'])))];
        }

        if($param['search']) {
            $where[] = ['o.name|o.tel|o.order','like',"%{$param['search']}%"];
        }

        $count = Db::table('fx_order')->alias('o')->where($where)->count();
        $page['count'] = $count;
        $page['curr'] = $curr_page;
        $page['totalPage'] = ceil($count/$perpage);

        $list = Db::table('fx_order')->alias('o')
            ->join('fx_user u','o.code=u.code','left')
            ->where($where)
            ->limit(($curr_page - 1)*$perpage,$perpage)
            ->field('o.*,u.realname')
            ->select();
        $this->assign('list',$list);
        $this->assign('page',$page);
        return $this->fetch();
    }

    public function deliver() {
        $map[] = ['status','=',1];
        $map[] = ['id','=',input('post.id',0)];

        $exist = Db::table('fx_order')->where($map)->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        try {
            $update_data = [
                'status' => 2,
                'send_time' => time()
            ];
            Db::table('fx_order')->where($map)->update($update_data);
            Db::table('fx_user')->where('code',$exist['code'])->setInc('order',$exist['num']);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax([],1);
    }

    public function stocklist() {

        $param['status'] = input('param.status','');
        $param['logmin'] = input('param.logmin');
        $param['logmax'] = input('param.logmax');
        $param['search'] = input('param.search');

        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);

        $where = [];
        if(session('username') !== config('superman')) {
            $where[] = ['s.top_code','=',session('code')];
            $where[] = ['s.code','<>',session('code')];

        }

        if($param['status'] !== '') {
            $where[] = ['s.status','=',$param['status']];
        }

        if($param['logmin']) {
            $where[] = ['s.create_time','>=',strtotime(date('Y-m-d 00:00:00',strtotime($param['logmin'])))];
        }

        if($param['logmax']) {
            $where[] = ['s.create_time','<=',strtotime(date('Y-m-d 23:59:59',strtotime($param['logmax'])))];
        }

        if($param['search']) {
            $where[] = ['s.code','like',"%{$param['search']}%"];
        }

        $count = Db::table('fx_stock')->alias('s')->where($where)->count();
        $page['count'] = $count;
        $page['curr'] = $curr_page;
        $page['totalPage'] = ceil($count/$perpage);

        $list = Db::table('fx_stock')->alias('s')
            ->join("fx_user u","s.code=u.code","left")
            ->where($where)->limit(($curr_page - 1)*$perpage,$perpage)
            ->order(['s.create_time'=>'DESC'])
            ->field("s.*,u.realname,u.tel,u.avatar")
            ->select();
        $this->assign('list',$list);
        $this->assign('page',$page);
        $this->assign('status',$param['status']);
        return $this->fetch();
    }

    public function stockPass() {
        $map[] = ['status','=',0];
        $map[] = ['id','=',input('post.id',0)];

        if(session('username') !== config('superman')) {
            $mycode = session('code');
            $map[] = ['top_code','=',$mycode];
        }

        $exist = Db::table('fx_stock')->where($map)->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        if(session('username') !== config('superman')) {
            $myinfo = Db::table('fx_user')->where('code','=',$mycode)->find();
            if($myinfo['stock'] < $exist['num']) {
                return ajax('您的库存不足,无法确认',-1);
            }
        }
        Db::startTrans();
        try {
            $update_data = [
                'status' => 1
            ];
            Db::table('fx_stock')->where($map)->update($update_data);
            Db::table('fx_user')->where('code',$exist['code'])->setInc('stock',$exist['num']);
            if(session('username') !== config('superman')) {
                Db::table('fx_user')->where('code','=',$mycode)->setDec('stock',$exist['num']);
                Db::table('fx_user')->where('code','=',$mycode)->setInc('team',$exist['num']);
            }
            Db::commit();
        }catch (\Exception $e) {
            Db::rollback();
            return ajax($e->getMessage(),-1);
        }
        return ajax([],1);
    }

    public function stockReject() {
        $map[] = ['status','=',0];
        $map[] = ['id','=',input('post.id',0)];

        if(session('username') !== config('superman')) {
            $mycode = session('code');
            $map[] = ['top_code','=',$mycode];
        }

        $exist = Db::table('fx_stock')->where($map)->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        try {
            $update_data = [
                'status' => 2,
            ];
            Db::table('fx_stock')->where($map)->update($update_data);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax([],1);
    }


}