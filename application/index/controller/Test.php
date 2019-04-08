<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2019/4/8
 * Time: 22:22
 */
namespace app\index\controller;

use think\Controller;

class Test extends Controller {

    public function qrcode() {
        include ROOT_PATH . '/extend/phpqrcode/phpqrcode.php';
        $value= 'http://' . $_SERVER['HTTP_HOST'] . '/home?pcode=123456';
        $errorCorrectionLevel = "L"; // 纠错级别：L、M、Q、H
        $matrixPointSize = "6"; // 点的大小：1到10
        header('Content-Type:image/png');
        \QRcode::png($value, false, $errorCorrectionLevel, $matrixPointSize);
        exit;
    }

    public function mixQrcode() {
        header('Content-Type:image/png');
        $path_1 = 'http://' . $_SERVER['HTTP_HOST'] . '/index/test/qrcode';
        $path_2 = "static/assets/img/mix.jpg";
        $image_1 = imagecreatefrompng($path_1);
        $image_2 = imageresize($path_2,750,1334);
        imagecopyresampled($image_2,$image_1,265,880,0,0,imagesx($image_1),imagesy($image_1),imagesx($image_1),imagesy($image_1));
        imagegif($image_2);
        exit();
    }

//    public function qrcode() {
//        include ROOT_PATH . '/extend/phpqrcode/phpqrcode.php';
//        $value= 'http://' . $_SERVER['HTTP_HOST'] . '/home?pcode=123456';
//        $errorCorrectionLevel = "L"; // 纠错级别：L、M、Q、H
//        $matrixPointSize = "6"; // 点的大小：1到10
//        header('Content-Type:image/png');
//        \QRcode::png($value, false, $errorCorrectionLevel, $matrixPointSize);
//        exit;
//    }
//
//    public function mixQrcode() {
//        header('Content-Type:image/png');
//        $path_1 = 'http://' . $_SERVER['HTTP_HOST'] . '/index/index/qrcode';
//        $path_2 = "static/assets/img/mix.jpg";
//        $image_1 = imagecreatefrompng($path_1);
//        $image_2 = imageresize($path_2,750,1334);
//        imagecopyresampled($image_2,$image_1,265,880,0,0,imagesx($image_1),imagesy($image_1),imagesx($image_1),imagesy($image_1));
//        imagegif($image_2);
//        exit();
//    }

}