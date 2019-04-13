<?php
namespace app\index\controller;
use think\Db;
use think\Exception;
class Index extends Common
{

    public function index() {
        $openid = session('openid');
        $user = Db::table('fx_user')->where('openid',$openid)->find();
        if(!$user['tel']) {
            $this->redirect('Index/reg');
        }
        $undone_stock_num = Db::table('fx_order')->where([
            ['code','=',$user['code']],
            ['status','in',[0,1]]
        ])->sum('stock_num');
        session('code',$user['code']);
        session('top_code',$user['top_code']);
        $this->assign('user',$user);
        $this->assign('achieve',($user['stock']+$user['order']+$user['team']+$undone_stock_num));
        return $this->fetch();
    }

    public function topay() {
        return $this->fetch();
    }

    public function reg() {
        return $this->fetch();
    }

    public function sendSms() {
        $sms = new \my\Sendsms();
        $code = rand(100000,999999);
        $tel = input('post.tel');

        $exist = Db::table('fx_verify')->where('tel',$tel)->find();
        if($exist && (time() - $exist['create_time']) < 60) {
            return ajax('1分钟内不可重复发送',-1);
        }
        $param = [
            'tel' => $tel,
            'code' => $code
        ];
        $res = $sms->send($param);
        if($res->Code === 'OK') {
            $param['create_time'] = time();
            try {
                if($exist) {
                    Db::table('fx_verify')->where('tel',$tel)->update($param);
                }else {
                    Db::table('fx_verify')->insert($param);
                }
            }catch (\Exception $e) {
                return ajax($e->getMessage(),-1);
            }
            return ajax('OK',1);
        }else {
            return ajax( $res->Message,-1);
        }
    }

    public function regPost() {
        $openid = session('openid');
        $data['tel'] = input('post.tel');
        $data['realname'] = input('post.realname');
        $code = input('post.code');
        if(!$this->checkCode($data['tel'],$code)) {
            return ajax('无效的验证码',-1);
        }
        $tel_exist = Db::table('fx_user')->where('tel',$data['tel'])->find();
        if($tel_exist) {
            return ajax('手机号已注册',-1);
        }
        //验证手机白名单(需要再写)
        $white = Db::table('fx_whitelist')->column('tel');

        if(session('pcode')) {
            $pcode = session('pcode');
            //验证pcode
            $exist = Db::table('fx_user')->where('code',$pcode)->find();
            if(!$exist) {
                return ajax('无效的邀请码',-1);
            }
            $data['pcode'] = $pcode;
            $data['level'] = $exist['level'] + 1;
            $data['top_code'] = $exist['top_code'];
        }else {
            if(!in_array($data['tel'],$white)) {
                return ajax('此手机号无法注册顶级经销商',-1);
            }
            $exist = Db::table('fx_user')->where('openid',$openid)->find();
            $data['pcode'] = '9999999999';
            $data['level'] = 1;
            $data['top_code'] = $exist['code'];
        }
        try {
            Db::table('fx_user')->where('openid',$openid)->update($data);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function order() {
        return $this->fetch();
    }

    public function orderPost() {
        $data['tel'] = input('post.tel');
        $data['name'] = input('post.name');
        $data['address'] = input('post.address');
        $data['num'] = input('post.num');
        $data['code'] = session('code');
        $data['top_code'] = session('top_code');
        $data['create_time'] = time();

        if(!preg_match('/^\d{1,8}$/',$data['num'])) {
            return ajax('请输入合法数字',-1);
        }

        if($data['num'] < 1 || $data['num'] > 999999) {
            return ajax('购买数量区间1-999999',-1);
        }
        /*-----二期----*/
        $openid = session('openid');
        $user = Db::table('fx_user')->where('openid',$openid)->find();
        $total_num = $user['stock']+$user['order']+$user['team'];

        $undone_num = Db::table('fx_order')->where([
            ['code','=',$user['code']],
            ['status','in',[0,1]]
        ])->sum('num');

        $undone_stock_num = Db::table('fx_order')->where([
            ['code','=',$user['code']],
            ['status','in',[0,1]]
        ])->sum('stock_num');

        $current_num = $total_num + $undone_num + $data['num'];
        if(($current_num) >= $user['upper_limit']) {
            return ajax('权限不足',-2);
        }

        if($current_num >= 59 && $current_num <= 228) {
            if($user['stock'] < 8) {
                return ajax('订单量已达59,备货最少8台方可继续',-1);
            }
        }
        if($current_num >= 229 && $current_num <= 868) {
            if($user['stock'] < 16) {
                return ajax('订单量已达229,备货最少16台方可继续',-1);
            }
        }
        if($current_num > 868) {
            if($user['stock'] < 32) {
                return ajax('订单量已达869,备货最少32台方可继续',-1);
            }
        }

        /*-----二期结束-----*/
        $number = $total_num + $undone_stock_num;
        $map = [
            ['min','<=',$number],
            ['max','>=',$number]
        ];
        $res = Db::table('fx_price')->where($map)->find();
        $data['unit_price'] = $res['price'];
        $data['price'] = $res['price']*$data['num'];
        $data['order'] = create_unique_number('P');


        if($user['stock'] > 0) {
            if($user['stock'] > $data['num']) {
                $data['stock_num'] = $data['num'];
                $data['short_num'] = 0;
            }else {
                $data['stock_num'] = $user['stock'];
                $data['short_num'] = $data['num'] - $data['stock_num'];
            }
        }else {
            $data['stock_num'] = 0;
            $data['short_num'] = $data['num'];
        }
        Db::startTrans();
        try {
            Db::table('fx_order')->insert($data);
            Db::table('fx_user')->where('openid',$openid)->setDec('stock',$data['stock_num']);
            Db::commit();
        }catch (\Exception $e) {
            Db::rollback();
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function achievement() {
        $code = session('code');
        $openid = session('openid');
        $user = Db::table('fx_user')->where('openid',$openid)->find();

        $map = [
            ['pcode','=',$code]
        ];
        $list = Db::table('fx_user')->where($map)->select();

        $this->assign('achieve',$user['order']+$user['stock']);
        $this->assign('list',$list);
        return $this->fetch();
    }

    public function stock() {
        $map = [
            'code' => session('code'),
            'status' => 0
        ];
        $exist = Db::table('fx_stock')->where($map)->find();
        if($exist) {
            return $this->fetch('stockings');
        }

        $openid = session('openid');
        $user = Db::table('fx_user')->where('openid',$openid)->find();
        $this->assign('stock',$user['stock']);
        return $this->fetch();
    }

    public function stocking() {
        $map = [
            'code' => session('code'),
            'status' => 0
        ];
        $exist = Db::table('fx_stock')->where($map)->find();
        if($exist) {
            return $this->fetch('stockings');
        }
        return $this->fetch();
    }

    public function stockingPost() {
        $data['code'] = session('code');
        $data['top_code'] = session('top_code');
        $data['num'] = input('post.num');
        $data['create_time'] = time();
        $data['order_sn'] = create_unique_number('S');

        $map = [
            'code' => $data['code'],
            'status' => 0
        ];
        $exist = Db::table('fx_stock')->where($map)->find();
        if($exist) {
            return ajax('有审核中订单,无法提交新订单',-1);
        }

        /*-----二期----*/
        $openid = session('openid');
        $user = Db::table('fx_user')->where('openid',$openid)->find();
        $total_num = $user['stock']+$user['order']+$user['team'];

        $undone_num = Db::table('fx_order')->where([
            ['code','=',$user['code']],
            ['status','in',[0,1]],
        ])->sum('num');

        $undone_stock_num = Db::table('fx_order')->where([
            ['code','=',$user['code']],
            ['status','in',[0,1]]
        ])->sum('stock_num');

        $current_num = $total_num + $undone_num + $data['num'];
        if(($current_num) >= $user['upper_limit']) {
            return ajax('权限不足',-2);
        }
        /*-----二期结束-----*/
        $number = $total_num + $undone_stock_num;
        $map = [
            ['min','<=',$number],
            ['max','>=',$number]
        ];
        $res = Db::table('fx_price')->where($map)->find();
        $data['unit_price'] = $res['price'];
        $data['price'] = $res['price']*$data['num'];

        try {
            Db::table('fx_stock')->insert($data);

        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function orderlist() {
        $act = input('param.act','1');
        $code = session('code');

        if($act === '1') {
            $map = [
                ['code','=',$code]
            ];
        }
        if($act === '2') {
            $map = [
                ['code','=',$code],
                ['status','=',0]
            ];
        }
        if($act === '3') {
            $map = [
                ['code','=',$code],
                ['status','=',1]
            ];
        }
        if($act === '4') {
            $map = [
                ['code','=',$code],
                ['status','=',2]
            ];
        }
        $list = Db::table('fx_order')->where($map)->select();
        $this->assign('list',$list);
        $this->assign('act',$act);
        return $this->fetch();
    }

    public function articleList() {
        $where = [
            ['a.status','=',1]
        ];
        try {
            $list = Db::table('fx_article')->alias('a')
                ->join("fx_admin ad","a.admin_id=ad.id","left")
                ->field('a.*,ad.realname')
                ->where($where)->select();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('list',$list);
        $this->assign('code',session('code'));
        return $this->fetch();
    }

    public function articleDetail() {
        $id = input('param.id');
        $where = [
            ['a.id','=',$id]
        ];
        try {
            $info = Db::table('fx_article')->alias('a')
                ->join("fx_admin ad","a.admin_id=ad.id","left")
                ->field('a.*,ad.realname')
                ->where($where)->find();
            if(!$info) {
                die('非法参数');
            }
        }catch (\Exception $e) {
            die($e->getMessage());
        }

        $this->assign('info',$info);
        return $this->fetch();
    }

    public function qrcode() {
        include ROOT_PATH . '/extend/phpqrcode/phpqrcode.php';
//        $value= 'http://' . $_SERVER['HTTP_HOST'] . '/home?pcode=' . $_GET['pcode'];
        $value = 'http://' . $_SERVER['HTTP_HOST'] . '/index/index/qrcode?pcode='.$_GET['pcode'];

        $errorCorrectionLevel = "L"; // 纠错级别：L、M、Q、H
        $matrixPointSize = "6"; // 点的大小：1到10
        header('Content-Type:image/png');
        \QRcode::png($value, false, $errorCorrectionLevel, $matrixPointSize);
        exit;
    }

    public function mixQrcode() {
        header('Content-Type:image/png');
//        $path_1 = 'http://' . $_SERVER['HTTP_HOST'] . '/index/index/qrcode?pcode='.$_GET['pcode'];
        $path_1= 'http://' . $_SERVER['HTTP_HOST'] . '/home?pcode=' . $_GET['pcode'];
        $path_2 = "static/assets/img/mix.jpg";
        $image_1 = imagecreatefrompng($path_1);
        $image_2 = imageresize($path_2,750,1334);
        imagecopyresampled($image_2,$image_1,265,880,0,0,imagesx($image_1),imagesy($image_1),imagesx($image_1),imagesy($image_1));
        imagepng($image_2);
        exit();
    }

    public function articleQrcode() {
        include ROOT_PATH . '/extend/phpqrcode/phpqrcode.php';
        $value= 'http://' . $_SERVER['HTTP_HOST'] . '/index/index/articleList?pcode=' . session('code');
        $errorCorrectionLevel = "L"; // 纠错级别：L、M、Q、H
        $matrixPointSize = "6"; // 点的大小：1到10
        header('Content-Type:image/png');
        \QRcode::png($value, false, $errorCorrectionLevel, $matrixPointSize);
        exit;
    }

    public function code() {
        $this->assign('pcode',session('code'));
        return $this->fetch();
    }

    public function notice() {
        return $this->fetch();
    }

    public function frozen() {
        return $this->fetch();
    }


    /**
     * 1、获取微信用户信息，判断有没有code，有使用code换取access_token，没有去获取code。
     * @return array 微信用户信息数组
     */
    public function auth(){
        if (!isset($_GET['code'])){ //没有code，去微信接口获取code码
            $callback = 'http://'.$_SERVER['HTTP_HOST'] . '/index/index/auth?act='.$_GET['act'];//微信服务器回调url，这里是本页url http://fx.jianghairui.com/index/index/get_user_all
            $this->get_code($callback);
        } else {    //获取code后跳转回来到这里了
            $code = $_GET['code'];
            $act = $_GET['act'];
            $data = $this->get_access_token($code);//获取网页授权access_token和用户openid
            $data_all = $this->get_user_info($data['access_token'],$data['openid']);//获取微信用户信息

            /*保存用户信息到数据库并设置session*/
            $insert_data = [
                'openid' => $data_all['openid'],
                'nickname' => $data_all['nickname'],
                'avatar' => $data_all['headimgurl']
            ];
            $user_exist = Db::table('fx_user')->where('openid',$data_all['openid'])->find();
            try {
                if($user_exist) {
                    Db::table('fx_user')->where('openid',$data_all['openid'])->update($insert_data);
                }else {
                    $insert_data['code'] = time();
                    $insert_data['create_time'] = time();
                    Db::table('fx_user')->insert($insert_data);
                }
            }catch (\Exception $e) {
                die('系统错误,请联系管理员 :' . $e->getMessage());
            }
            session('openid',$data_all['openid']);
        }
        if($act == 'auth') {
            $url = 'http://'.$_SERVER['HTTP_HOST'] . '/home';
        }else {
            $url = 'http://'.$_SERVER['HTTP_HOST'] . '/index/index/articleList';
        }
        header("Location:".$url);exit;

    }



    /**
     * 2、用户授权并获取code
     * @param string $callback 微信服务器回调链接url
     */
    private function get_code($callback){
        $appid = $this->appid;
        $scope = 'snsapi_userinfo';
        $state = md5(uniqid(rand(), true));//唯一ID标识符绝对不会重复
        $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' . $appid . '&redirect_uri=' . urlencode($callback) .  '&response_type=code&scope=' . $scope . '&state=' . $state . '#wechat_redirect';
        header("Location:".$url);exit;
    }
    /**
     * 3、使用code换取access_token
     * @param string 用于换取access_token的code，微信提供
     * @return array access_token和用户openid数组
     */
    private function get_access_token($code){
        $appid = $this->appid;
        $appsecret = $this->appsecret;
        $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=' . $appid . '&secret=' . $appsecret . '&code=' . $code . '&grant_type=authorization_code';
        $user = json_decode(file_get_contents($url));
        if (isset($user->errcode)) {
            if($user->errcode == '40163') {
                echo 'Code been used!!!';exit;
            }
            echo 'error:' . $user->errcode.'<hr>msg :' . $user->errmsg;exit;
        }
        $data = json_decode(json_encode($user),true);//返回的json数组转换成array数组
        return $data;
    }
    /**
     * 4、使用access_token获取用户信息
     * @param string access_token
     * @param string 用户的openid
     * @return array 用户信息数组
     */
    private function get_user_info($access_token,$openid){
        $url = 'https://api.weixin.qq.com/sns/userinfo?access_token=' . $access_token . '&openid=' . $openid . '&lang=zh_CN';
        $user = json_decode(file_get_contents($url));
        if (isset($user->errcode)) {
            echo 'error:' . $user->errcode.'<hr>msg  :' . $user->errmsg;exit;
        }
        $data = json_decode(json_encode($user),true);//返回的json数组转换成array数组
        return $data;
    }

    /*
     * 验证短信验证码
     * */
    private function checkCode($tel='',$code='') {
        $map = [
            ['tel','=',$tel],
            ['code','=',$code]
        ];
        $exist = Db::table('fx_verify')->where($map)->find();
        if(!$exist) {
            return false;
        }
        if((time() - $exist['create_time']) > 300) {
            return false;
        }
        return true;
    }


}
