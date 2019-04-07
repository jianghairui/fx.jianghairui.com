<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2019/4/7
 * Time: 20:58
 */
namespace app\admin\controller;
use think\Db;
class Article extends Common {

    //资讯列表
    public function articleList()
    {
        $param['search'] = input('param.search');
        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);
        $where = [];
        if($param['search']) {
            $where[] = ['a.title|a.desc','like',"%{$param['search']}%"];
        }
        $count = Db::table('fx_article')->alias('a')->where($where)->count();

        $page['count'] = $count;
        $page['curr'] = $curr_page;
        $page['totalPage'] = ceil($count/$perpage);
        try {
            $list = Db::table('fx_article')->alias('a')
                ->join('fx_admin ad','a.admin_id=ad.id','left')
                ->field('a.*,ad.realname')
                ->where($where)->limit(($curr_page - 1)*$perpage,$perpage)->select();
        }catch (\Exception $e) {
            die('SQL错误: ' . $e->getMessage());
        }

        $this->assign('list',$list);
        $this->assign('page',$page);
        return $this->fetch();
    }
    //添加资讯页面
    public function articleAdd() {
        return $this->fetch();
    }
    //添加资讯提交
    public function articleAddPost() {
        $val['title'] = input('post.title');
        $val['desc'] = input('post.desc');
        $val['status'] = input('post.status');
        $this->checkPost($val);
        $val['content'] = input('post.content');
        $val['admin_id'] = session('admin_id');

        if (!empty($_FILES)) {
            $info = $this->upload(array_keys($_FILES)[0]);
            if($info['error'] === 0) {
                $val['pic'] = $info['data'];
            }else {
                return ajax($info['msg'],-1);
            }
        } else {
            return ajax('请上传图片', 3);
        }
        try {
            Db::table('fx_article')->insert($val);
        }catch (\Exception $e) {
            if(isset($val['pic'])) {
                @unlink($val['pic']);
            }
            return ajax($e->getMessage(),-1);
        }
        return ajax([]);

    }
    //修改资讯页面
    public function articleDetail() {
        $article_id = input('param.id');
        $exist = Db::table('fx_article')->where('id',$article_id)->find();
        if(!$exist) {
            $this->error('非法操作');
        }
        $this->assign('info',$exist);
        return $this->fetch();
    }
    //修改资讯提交
    public function articleModPost() {
        $val['title'] = input('post.title');
        $val['desc'] = input('post.desc');
        $val['status'] = input('post.status');
        $val['id'] = input('post.id');
        $this->checkPost($val);
        $val['content'] = input('post.content');
        $val['admin_id'] = session('admin_id');

        foreach ($_FILES as $k=>$v) {
            if($v['name'] == '') {
                unset($_FILES[$k]);
            }
        }
        if(!empty($_FILES)) {
            $info = $this->upload(array_keys($_FILES)[0]);
            if($info['error'] === 0) {
                $val['pic'] = $info['data'];
            }else {
                return ajax($info['msg'],-1);
            }
        }
        try {
            $exist = Db::table('fx_article')->where('id',$val['id'])->find();
            $res = Db::table('fx_article')->update($val);
        }catch (\Exception $e) {
            if(isset($val['pic'])) {
                @unlink($val['pic']);
            }
            return ajax($e->getMessage(),-1);
        }
        if($res !== false) {
            if(!empty($_FILES)) {
                @unlink($exist['pic']);
            }
            return ajax();
        }else {
            if(!empty($_FILES)) {
                @unlink($val['pic']);
            }
            return ajax('修改失败',-1);
        }

    }
    //删除资讯
    public function articleDel() {
        $val['id'] = input('post.id');
        $this->checkPost($val);
        $exist = Db::table('fx_article')->where('id',$val['id'])->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }
        $model = model('Article');
        try {
            $model::destroy($val['id']);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }

        return ajax([],1);
    }
    //停用资讯
    public function articleHide() {
        $val['id'] = input('post.id');
        $this->checkPost($val);
        $exist = Db::table('fx_article')->where('id',$val['id'])->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        $res = Db::table('fx_article')->where('id',$val['id'])->update(['status'=>0]);
        if($res !== false) {
            return ajax([],1);
        }else {
            return ajax([],-1);
        }
    }
    //启用资讯
    public function articleShow() {
        $val['id'] = input('post.id');
        $this->checkPost($val);
        $exist = Db::table('fx_article')->where('id',$val['id'])->find();
        if(!$exist) {
            return ajax('非法操作',-1);
        }

        $res = Db::table('fx_article')->where('id',$val['id'])->update(['status'=>1]);
        if($res !== false) {
            return ajax([],1);
        }else {
            return ajax([],-1);
        }
    }

}