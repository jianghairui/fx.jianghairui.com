/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.24-0ubuntu0.16.04.1 : Database - fenxiao
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`fenxiao` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `fenxiao`;

/*Table structure for table `fx_admin` */

DROP TABLE IF EXISTS `fx_admin`;

CREATE TABLE `fx_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(15) DEFAULT '0' COMMENT '关联经销商代码',
  `realname` varchar(30) DEFAULT NULL COMMENT '管理员姓名',
  `username` varchar(30) DEFAULT NULL COMMENT '账号',
  `gender` tinyint(4) DEFAULT NULL COMMENT '1男2女',
  `email` varchar(50) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL COMMENT '手机号',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '添加时间',
  `last_login_ip` varchar(20) DEFAULT '0.0.0.0',
  `last_login_time` int(10) unsigned DEFAULT NULL COMMENT '最后登录时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态0冻结1正常',
  `login_times` int(11) DEFAULT '0' COMMENT '登陆次数',
  `level` tinyint(4) DEFAULT '1' COMMENT '管理员等级',
  `desc` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_admin` */

insert  into `fx_admin`(`id`,`code`,`realname`,`username`,`gender`,`email`,`tel`,`password`,`create_time`,`last_login_ip`,`last_login_time`,`status`,`login_times`,`level`,`desc`) values (1,'0','姜海蕤','jianghairui',1,'1873645345@qq.com','13102163019','cb8155233c38b99f3ad4ecc34e37c27b',1540099895,'59.42.129.122',1548722662,1,127,1,'好人啊\n'),(4,'0','仓管','cang',1,'1873645345@qq.com','18526860284','f91f03f716c406c14e268c4ebcbb040d',1540103141,'60.25.12.188',1547360493,1,17,1,''),(5,'1547516141','Jiang','jiang',1,NULL,'13102163019','f91f03f716c406c14e268c4ebcbb040d',1546957182,'60.25.12.159',1548682062,1,13,1,''),(6,'1547534379','钟','zzzzz',1,NULL,'13556036196','182190c915daadda6d909f9691819e45',1547185010,'59.42.129.122',1548723821,1,20,1,'');

/*Table structure for table `fx_auth_group` */

DROP TABLE IF EXISTS `fx_auth_group`;

CREATE TABLE `fx_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `desc` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `fx_auth_group` */

insert  into `fx_auth_group`(`id`,`title`,`desc`,`status`,`rules`) values (1,'一级分销商','负责确认订单',1,'96,97,109,108,98,101,100,99,105,106,103'),(2,'仓管','负责备货，发货',1,'83,86,98,107,102');

/*Table structure for table `fx_auth_group_access` */

DROP TABLE IF EXISTS `fx_auth_group_access`;

CREATE TABLE `fx_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `fx_auth_group_access` */

insert  into `fx_auth_group_access`(`uid`,`group_id`) values (4,2),(5,1),(6,1);

/*Table structure for table `fx_auth_rule` */

DROP TABLE IF EXISTS `fx_auth_rule`;

CREATE TABLE `fx_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(30) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

/*Data for the table `fx_auth_rule` */

insert  into `fx_auth_rule`(`id`,`name`,`title`,`type`,`status`,`condition`,`pid`) values (4,'Admin/adminlist','查看管理员列表',1,1,'',3),(3,'Admin','管理员管理',1,1,'',0),(5,'Admin/adminadd','添加管理员',1,1,'',3),(6,'Admin/adminadd_post','添加管理员POST',1,1,'',3),(101,'Op/orderReject','订单审核（拒绝）',1,1,'',98),(31,'Admin/adminmod','修改管理员',1,1,'',3),(33,'Admin/admindel','删除管理员',1,1,'',3),(32,'Admin/adminmod_post','修改管理员POST',1,1,'',3),(34,'Admin/admin_multidel','批量删除管理员',1,1,'',3),(35,'Admin/adminstop','冻结管理员',1,1,'',3),(36,'Admin/adminstart','启用管理员',1,1,'',3),(48,'Admin/rulelist','查看节点列表',1,1,'',3),(38,'Admin/ruleadd','添加节点',1,1,'',3),(39,'Admin/ruleadd_post','添加节点POST',1,1,'',3),(40,'Admin/ruledel','删除节点',1,1,'',3),(41,'Admin/grouplist','查看角色列表',1,1,'',3),(42,'Admin/groupadd','添加角色',1,1,'',3),(43,'Admin/groupadd_post','添加角色POST',1,1,'',3),(44,'Admin/groupmod','修改角色',1,1,'',3),(45,'Admin/groupmod_post','修改角色POST',1,1,'',3),(46,'Admin/groupdel','删除角色',1,1,'',3),(47,'Admin/group_multidel','批量删除角色',1,1,'',3),(100,'Op/orderPass','订单审核（通过）',1,1,'',98),(99,'Op/orderlist','订单列表',1,1,'',98),(83,'System','系统管理',1,1,'',0),(97,'User/userlist','用户列表',1,1,'',96),(96,'User','用户管理',1,1,'',0),(86,'System/syslog','查看系统日志',1,1,'',83),(98,'Op','业务管理',1,1,'',0),(109,'User/usermod','用户编辑POST',1,1,'',96),(108,'User/userdetail','用户编辑',1,1,'',96),(107,'Op/sendlist','发货列表',1,1,'',98),(105,'Op/stockReject','备货审核（拒绝）',1,1,'',98),(106,'Op/stockPass','备货审核（通过）',1,1,'',98),(103,'Op/stocklist','备货列表',1,1,'',98),(102,'Op/deliver','订单发货',1,1,'',98);

/*Table structure for table `fx_order` */

DROP TABLE IF EXISTS `fx_order`;

CREATE TABLE `fx_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `top_code` char(15) DEFAULT NULL COMMENT '根级分销商代码',
  `code` char(15) NOT NULL COMMENT '分销商代码',
  `order` char(25) DEFAULT NULL COMMENT '订单号',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '订单价格',
  `unit_price` decimal(10,2) DEFAULT '0.00' COMMENT '单价',
  `name` char(10) DEFAULT NULL COMMENT '客户姓名',
  `tel` char(11) DEFAULT NULL COMMENT '客户手机号',
  `address` varchar(255) DEFAULT NULL COMMENT '收货地址',
  `num` int(11) DEFAULT '1' COMMENT '订单数量',
  `short_num` int(11) DEFAULT '0' COMMENT '订单数量不足部分',
  `stock_num` int(11) DEFAULT '0' COMMENT '订单数量库存部分',
  `status` tinyint(4) DEFAULT '0' COMMENT '0待确认1已确认2已发货',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '下单时间',
  `confirm_time` int(10) unsigned DEFAULT NULL COMMENT '确认时间',
  `send_time` int(10) unsigned DEFAULT NULL COMMENT '发货时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_order` */

insert  into `fx_order`(`id`,`top_code`,`code`,`order`,`price`,`unit_price`,`name`,`tel`,`address`,`num`,`short_num`,`stock_num`,`status`,`create_time`,`confirm_time`,`send_time`) values (1,'1547534379','1547534379','P154788577599582200','1468.00','1468.00','徐栢浩','13392119515','广州花都新华街公益路宏城大厦',1,1,0,2,1547885775,1548473242,1548481149),(2,'1547534379','1547516119','P154842075108635900','5072.00','1268.00','儿童','13599999999','现阶段解放后',4,4,0,2,1548420751,1548421250,1548421256),(3,'1547534379','1547516119','P154842295068529300','32040.00','1068.00','吹过','13534443546','吹过风蛋糕',30,30,0,2,1548422950,1548423534,1548466778),(4,'1547534379','1547516119','P154842364254981100','10680.00','1068.00','sbbkxk','14473447675','你自己的',10,10,0,2,1548423642,1548466749,1548466780),(6,'1547516141','1547516141','P154842705061848200','49452.00','1268.00','姜海蕤','13102163019','天津市宝坻区',39,27,12,2,1548427050,1548427322,1548427347),(8,'1547534379','1547534379','P154847505625897300','7340.00','1468.00','Alex','18822334455','花都',5,4,1,2,1548475056,1548481141,1548481151),(10,'1547534379','1547516119','P154850512076954500','222500.00','890.00','大姐夫','13644574647','记得哪些',250,229,21,2,1548505120,1548505196,1548505216),(12,'1547516141','1548509678','P154851016561342100','25360.00','1268.00','清流','18526860284','深圳市宝安区福永塘尾',20,10,10,2,1548510165,1548510358,1548511480),(14,'1547516141','1548509678','P154851093652869300','126800.00','1268.00','清流','18526860284','泰国清迈',100,88,12,2,1548510936,1548510959,1548511490),(15,'1547516141','1548509678','P154851135748950900','106800.00','1068.00','清流','18526860284','梵蒂冈',100,50,50,2,1548511357,1548511455,1548511496),(16,'1547516141','1547551950','P154851232855356000','1468.00','1468.00','涛','18555555555','顺丰发货',1,1,0,2,1548512328,1548512661,1548685384),(17,'1547516141','1547551950','P154851263996025000','14680.00','1468.00','涛','15399999999','中北',10,10,0,2,1548512639,1548512659,1548685386),(20,'1547534379','1547534379','P154866151811562700','1268.00','1268.00','cc','17822288899','hd',1,0,1,2,1548661518,1548661584,1548685388),(22,'1547534379','1547516119','P154867914119027300','8100.00','810.00','充斥着吧','13555796867','虚幻',10,0,10,2,1548679141,1548679173,1548685390),(23,'1547534379','1548681285','P154868136495450900','1468.00','1468.00','我','13343333333','呜呜呜',1,1,0,2,1548681364,1548684055,1548685391),(24,'1547516141','1548681141','P154868197478330200','14680.00','1468.00','测试了','13821452840','天津市西青区宝庆里',10,10,0,2,1548681974,1548682081,1548685393),(27,'1547534379','1547516119','P154868623363729200','1620.00','810.00','发','15773233668','需呃我一',2,0,2,2,1548686233,1548686427,1548686519),(28,'1547534379','1547516119','P154868638357322600','20250.00','810.00','我在外面玩','14663368647','新风',25,1,24,2,1548686383,1548686443,1548686528),(29,'1547516141','1547516141','P154868858686828100','8100.00','810.00','马梦荣','18777777777','河北省保定',10,0,10,1,1548688586,1548688600,NULL),(30,'1547534379','1548722407','P154872251684814000','1468.00','1468.00','那地方比较','13566658486','东京教父',1,1,0,1,1548722516,1548723848,NULL);

/*Table structure for table `fx_price` */

DROP TABLE IF EXISTS `fx_price`;

CREATE TABLE `fx_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) DEFAULT NULL COMMENT '区间价格',
  `min` int(11) DEFAULT '0' COMMENT '起始区间数量',
  `max` int(11) DEFAULT '0' COMMENT '结束区间数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_price` */

insert  into `fx_price`(`id`,`price`,`min`,`max`) values (1,'1468.00',0,1),(2,'1268.00',2,18),(3,'1068.00',19,58),(4,'890.00',59,228),(5,'810.00',229,868),(6,'810.00',869,99999999);

/*Table structure for table `fx_stock` */

DROP TABLE IF EXISTS `fx_stock`;

CREATE TABLE `fx_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` char(35) DEFAULT NULL COMMENT '订单号',
  `top_code` char(15) DEFAULT NULL COMMENT '根级分销商代码',
  `code` char(15) NOT NULL COMMENT '分销商代码',
  `unit_price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `num` int(11) DEFAULT '0' COMMENT '备货数量',
  `create_time` int(11) DEFAULT NULL COMMENT '申请时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '0待确认1已确认2拒绝',
  PRIMARY KEY (`id`),
  KEY `USER_CODE` (`code`),
  KEY `CREATE_TIME` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_stock` */

insert  into `fx_stock`(`id`,`order_sn`,`top_code`,`code`,`unit_price`,`price`,`num`,`create_time`,`status`) values (1,'S154788580447658300','1547534379','1547534379','1468.00','2936.00',2,1547885804,1),(2,'S154842299084143100','1547534379','1547534379','1068.00','32040.00',30,1548422990,1),(3,'S154842376686777600','1547534379','1547516119','1068.00','1068.00',1,1548423766,1),(4,'S154842658573209700','1547516141','1547516141','1468.00','2936.00',2,1548426585,1),(5,'S154842692866646800','1547516141','1547516141','1268.00','12680.00',10,1548426928,1),(6,'S154846682148724800','1547534379','1547516119','1068.00','21360.00',20,1548466821,1),(7,'S154850896225141500','1547516141','1547516141','1068.00','34176.00',32,1548508962,1),(8,'S154851007767959700','1547516141','1548509678','1468.00','14680.00',10,1548510077,1),(9,'S154851051245633400','1547516141','1548509678','1468.00','29360.00',20,1548510512,2),(10,'S154851055245627400','1547516141','1548509678','1468.00','14680.00',10,1548510552,1),(11,'S154851061337091700','1547516141','1548509678','1268.00','2536.00',2,1548510613,1),(12,'S154851068506544400','1547516141','1547516141','890.00','26700.00',30,1548510685,1),(13,'S154851078552813900','1547516141','1547516141','890.00','267000.00',300,1548510785,2),(14,'S154851080169449400','1547516141','1547516141','890.00','445000.00',500,1548510801,1),(15,'S154851123497924600','1547516141','1548509678','1468.00','73400.00',50,1548511234,1),(16,'S154851289311482300','1547516141','1547551950','1468.00','1174400.00',800,1548512893,1),(17,'S154851292727451700','1547516141','1547516141','810.00','1620000.00',2000,1548512927,1),(18,'S154865259211593000','1547534379','1547516119','810.00','8100.00',10,1548652592,1),(19,'S154865728263583300','1547534379','1547534379','1268.00','2536.00',2,1548657282,2),(20,'S154865915963444300','1547534379','1547534379','1268.00','3804.00',3,1548659159,1),(21,'S154865939479889900','1547534379','1547534379','1268.00','7608.00',6,1548659394,2),(22,'S154865958030153500','1547534379','1547534379','1268.00','5072.00',4,1548659580,2),(23,'S154867847117658500','1547534379','1547534379','1268.00','1268000.00',1000,1548678471,1),(24,'S154867876779938600','1547534379','1547516119','810.00','4860.00',6,1548678767,1),(25,'S154868579736593900','1547534379','1547516119','810.00','8100.00',10,1548685797,1),(26,'S154868589993364100','1547534379','1547516119','810.00','8100.00',10,1548685899,1),(27,'S154872131273187100','1547534379','1547516119','810.00','12960.00',16,1548721312,0);

/*Table structure for table `fx_syslog` */

DROP TABLE IF EXISTS `fx_syslog`;

CREATE TABLE `fx_syslog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '0登录1增2删3改',
  PRIMARY KEY (`id`),
  KEY `sys_admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_syslog` */

insert  into `fx_syslog`(`id`,`admin_id`,`detail`,`create_time`,`ip`,`type`) values (1,1,'登录账号',1547481427,'60.25.12.188',0),(2,1,'登录账号',1547481906,'60.25.12.188',0),(3,1,'登录账号',1547516882,'218.68.102.24',0),(4,1,'登录账号',1547522914,'59.42.128.205',0),(5,1,'登录账号',1547555330,'117.136.79.19',0),(6,1,'登录账号',1547587649,'59.42.128.91',0),(7,1,'登录账号',1547606944,'59.42.128.91',0),(8,1,'登录账号',1547606986,'59.42.128.91',0),(9,1,'登录账号',1547616320,'59.42.128.91',0),(10,1,'登录账号',1547712647,'223.104.64.239',0),(11,1,'登录账号',1548069746,'60.25.12.160',0),(12,1,'登录账号',1548075116,'60.25.12.160',0),(13,1,'登录账号',1548163461,'121.33.131.204',0),(14,1,'登录账号',1548170692,'121.33.173.207',0),(15,6,'登录账号',1548171457,'121.33.173.207',0),(16,1,'登录账号',1548331797,'60.25.12.160',0),(17,1,'登录账号',1548419893,'59.41.95.238',0),(18,6,'登录账号',1548423013,'59.41.95.238',0),(19,1,'登录账号',1548423376,'59.41.95.238',0),(20,6,'登录账号',1548423476,'59.41.95.238',0),(21,1,'登录账号',1548425825,'60.25.12.160',0),(22,6,'登录账号',1548466600,'59.41.95.238',0),(23,1,'登录账号',1548466725,'59.41.95.238',0),(24,6,'登录账号',1548467276,'59.41.95.238',0),(25,1,'登录账号',1548468436,'113.103.0.234',0),(26,6,'登录账号',1548472385,'121.8.161.130',0),(27,1,'登录账号',1548472492,'121.8.161.130',0),(28,1,'登录账号',1548472593,'113.103.0.234',0),(29,1,'登录账号',1548481069,'121.8.161.130',0),(30,1,'登录账号',1548481159,'113.103.0.234',0),(31,1,'登录账号',1548505048,'59.41.95.238',0),(32,1,'登录账号',1548508252,'60.25.12.159',0),(33,1,'登录账号',1548509843,'60.25.12.159',0),(34,5,'登录账号',1548509853,'60.25.12.159',0),(35,5,'登录账号',1548509899,'60.25.12.159',0),(36,5,'登录账号',1548512377,'60.25.12.159',0),(37,1,'登录账号',1548512804,'60.25.12.159',0),(38,5,'登录账号',1548512838,'60.25.12.159',0),(39,1,'登录账号',1548655089,'117.136.32.84',0),(40,1,'登录账号',1548655270,'113.103.3.85',0),(41,1,'登录账号',1548675755,'59.42.129.122',0),(42,1,'登录账号',1548678152,'59.42.129.122',0),(43,6,'登录账号',1548678602,'59.42.129.122',0),(44,1,'登录账号',1548681925,'60.25.12.159',0),(45,5,'登录账号',1548682062,'60.25.12.159',0),(46,6,'登录账号',1548683901,'59.42.129.122',0),(47,1,'登录账号',1548684388,'59.42.129.122',0),(48,6,'登录账号',1548685703,'59.42.129.122',0),(49,1,'登录账号',1548686512,'59.42.129.122',0),(50,1,'登录账号',1548687417,'60.25.12.159',0),(51,1,'登录账号',1548687909,'60.25.12.159',0),(52,6,'登录账号',1548722611,'59.42.129.122',0),(53,1,'登录账号',1548722662,'59.42.129.122',0),(54,6,'登录账号',1548723821,'59.42.129.122',0);

/*Table structure for table `fx_user` */

DROP TABLE IF EXISTS `fx_user`;

CREATE TABLE `fx_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `top_code` char(15) DEFAULT '0' COMMENT '根级分销商代码',
  `code` char(15) DEFAULT NULL COMMENT '经销商代码',
  `pcode` char(15) DEFAULT '0' COMMENT '父级代码',
  `openid` char(35) DEFAULT '',
  `realname` char(10) DEFAULT NULL COMMENT '真实姓名',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `tel` char(11) DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `level` mediumint(9) unsigned NOT NULL DEFAULT '0' COMMENT '层级',
  `sales` int(11) NOT NULL DEFAULT '0' COMMENT '销售业绩',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存数',
  `order` int(11) NOT NULL DEFAULT '0' COMMENT '下单数',
  `team` int(11) NOT NULL DEFAULT '0' COMMENT '团队销量',
  `upper_limit` int(11) DEFAULT '2' COMMENT '限购上限',
  `status` tinyint(4) DEFAULT '1' COMMENT '0禁用1正常',
  `create_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CODE_UNI` (`code`),
  KEY `OPENID` (`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_user` */

insert  into `fx_user`(`id`,`top_code`,`code`,`pcode`,`openid`,`realname`,`nickname`,`tel`,`avatar`,`level`,`sales`,`stock`,`order`,`team`,`upper_limit`,`status`,`create_time`) values (1,'1547516085','1547516085','9999999999','ovL4C1gIiKC2s79fy5sW_9oxY7JQ','张小姐','Viki?','18622905098','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJIM3EqqrFHlCiaqJWpp0icCa0azcibyycHtIlnNVXGyX37J2FVluxJwefN03Fmlqf2mux3UJsm9iceXQ/132',1,0,0,0,0,19,1,1547516085),(2,'1547534379','1547516119','1547534379','ovL4C1sSl1FkZXzHbiosCKaTqcuA','zhong','龙','13556036196','http://thirdwx.qlogo.cn/mmopen/vi_32/WIBqQagDENcUl8teFVTopA3CkqxzAbu1eia0tx113b1V9BNNDeq0YV31cxFtXvpQrPpsz0uOhbnBDicBUnAdheSA/132',2,0,0,331,0,868,1,1547516119),(3,'1547516141','1547516141','9999999999','ovL4C1sV5LD1XSvrJVTf5DR71z0E','姜海蕤','姜海蕤','13102163019','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIb51aL9OUf23Z52WPicYBsjMNSZn6xcM7VDyIWSOq42iahiaZaPOjF5gPblicMqQVmbuC7iaJUTAbjibIA/132',1,0,1511,39,1041,100000000,1,1547516141),(4,'1547516553','1547516553','9999999999','ovL4C1tv6zeT7dNJDqtiaU0hJzLs','杨先生','杨振华 Jeffrey','18002265908','http://thirdwx.qlogo.cn/mmopen/vi_32/5bkH6vEDqic6CtYuxu5gCHiazMa9JpPcPWibqE3o5icViak605EmbLAYkOzNkXiaiclLaMJrqj5WwvqiblicAJeiamricGvXg/132',1,0,0,0,0,2,1,1547516553),(5,'1547534379','1547534379','9999999999','ovL4C1gmR2Xo3GCBJCkwb2barsYI','徐栢浩','辰华东智Alex','13392119515','http://thirdwx.qlogo.cn/mmopen/vi_32/WmNvLibyrWZwrXT0fvBF5NwLnIsSF0H6EiareEal6uPPX6jtkwmTwjtdoLQYlkSKy2hCZqBd7EHG77hASHutCv7w/132',1,0,963,7,39,100000000,1,1547534379),(6,'1547534963','1547534963','9999999999','ovL4C1javkeaKxRtzbV1cH9Cd_xc','常冬苗','扬名教育??','13711710848','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLZ6URoxFemDicicTOytnzSYhVqB0zQlUUNpgtNVdHAFdK9HkaDtPIibAia91Ym1eR1nn2p8WJibDOlTvw/132',1,0,0,0,0,2,1,1547534963),(7,'0','1547536983','0','ovL4C1lRIvc_dEUZbReZ8H2egKWU',NULL,'陈  斌丨红尾巴AI英语','','http://thirdwx.qlogo.cn/mmopen/vi_32/FWP4GsVQXLkiaHtNSKzdhQRIDwnXOvTICvJTLbwU9qhH0SNicKVYZtycyCEH3rDwpo8JQaEQXPCdiadT5Z762h2fQ/132',0,0,0,0,0,2,1,1547536983),(8,'1547516141','1547551950','1548509678','ovL4C1obnCDP9NrsUfDcgUNToJkI','复仇者','28℃的微笑','13821506212','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKBmicYZMcrDPgFWRt9v7c1QgIn0vlGM5HtWlduOZZZTVZ2Dj2wMdaHJKSeVF1feDubrd6ialMhr8JA/132',3,0,800,11,0,100000000,1,1547551950),(9,'1547553729','1547553729','9999999999','ovL4C1nclKlEUbViVjuXN4K6Yek0','江泽琴','?米姐?','13826162857','http://thirdwx.qlogo.cn/mmopen/vi_32/cu1JaBmRuiaibCJTZ2DDa9IUlH00sNpHoUJus4WBxvpcS3r7fX6BXuClRULf9VEnFcibMdCokR2O74uOxqfKcCK3w/132',1,0,0,0,0,2,1,1547553729),(10,'0','1547555928','0','ovL4C1mBmp54cFatmQzMDUU2FKh0',NULL,'红尾巴智能英语伊雪儿公举','','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIxUs41OibzN4XWkKgicEibaIuFBd7ze5fjLJZAvq1SPo5yS5AtCDFlTciavujxUSekibIdSAoAGAtUE8Q/132',0,0,0,0,0,2,1,1547555928),(11,'0','1547695884','0','ovL4C1ltWCyz7bfcuZxSjJmIKxv8',NULL,'风起时','','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIQFdqAmeo8WlgWCFW5V3BAIhCPxyBgyDsWD1jXfas4zYq4iaa3IEvUL4rgNlficY3qPwtBTthERj0w/132',0,0,0,0,0,2,1,1547695884),(12,'1547888314','1547888314','9999999999','ovL4C1uKEK7kz6Y4qnidimmkaHK8','利远齐','AI利远齐','18520782570','http://thirdwx.qlogo.cn/mmopen/vi_32/wdKXwxJpq8NRKzr3xxd6ZPeO0NlEGhzsUZ81AoGFX2sLI8MBhOdoCjQ4gTxOKSWSdGnQYJB8QJGiauibu714HYlg/132',1,0,0,0,0,2,1,1547888314),(13,'0','1547890152','0','ovL4C1hxpJoggs7j3lH-yyOOc_uk',NULL,'?yapp?','','http://thirdwx.qlogo.cn/mmopen/vi_32/O4g5ZCP8ia5BWkYibycEF17Qia5lhry33QeZFSoSfLzMkYCLQa8COoAhdlmRvYibvialw8OgxtaSyjZBQIk8zXPVl5Q/132',0,0,0,0,0,2,1,1547890152),(14,'0','1547894754','0','ovL4C1pdV__TmSom5KygWt_Oiq78',NULL,'宋宛婵','','http://thirdwx.qlogo.cn/mmopen/vi_32/O4g5ZCP8ia5BWkYibycEF17dLwicSAzeo7S05nEHqcqqvnxVk3f7Nk7pfYyo9v1GX2m4DmEKrXf7kPp6nicqVQdHIw/132',0,0,0,0,0,2,1,1547894754),(15,'1547516141','1548509678','1547516141','ovL4C1qPSpeNk0UyaDXWWZ-xqtxg','清流','清流','18526860284','http://thirdwx.qlogo.cn/mmopen/vi_32/QIN2yfQ5N9wDrrj85FM2u3DXkRXXYJsretmPcgz8yzygITuwC0MwSe3eNvwMguow64AjP3JvaItdFH8HiaaSOiaA/132',2,0,0,220,0,869,1,1548509678),(16,'1547516141','1548681141','1547516141','ovL4C1sJ6wmS5qQdPN9_mdYLaBwA','测1','$','13821452840','http://thirdwx.qlogo.cn/mmopen/vi_32/LEb9K3lqxic6Zvv6TL0M28JH9750nXfBTzubiaia6m5DYViaqiahySntSicqvXXhA6qKPGAItIrQTzziblZgbvchub2gg/132',2,0,0,10,0,100000000,1,1548681141),(17,'1547534379','1548681285','1547516119','ovL4C1tF3aFQ9ImaU4sqbnBSpI2w','林','jerry','15918465033','http://thirdwx.qlogo.cn/mmopen/vi_32/D9DKa10yQewN33pwhw8BmFr3yAGCdWN8N6P3GGJR3WXib2wYYMLmlsHYzKUI9Rib2HLbchCIySlzqB1yvV4cMasw/132',3,0,0,1,0,2,1,1548681285),(18,'1547534379','1548722407','1547516119','ovL4C1lNSCpvIhX_t9cylYSFde0c','龙2','龙2','18202040207','',3,0,0,0,0,2,1,1548722407);

/*Table structure for table `fx_verify` */

DROP TABLE IF EXISTS `fx_verify`;

CREATE TABLE `fx_verify` (
  `tel` char(11) DEFAULT NULL COMMENT '手机号',
  `code` char(6) DEFAULT NULL COMMENT '短信验证码',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '发送短信时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_verify` */

insert  into `fx_verify`(`tel`,`code`,`create_time`) values ('13392119515','450582',1547534414),('13711710848','120156',1547535015),('13352895855','419771',1547537027),('13826162857','366650',1547555550),('18622905098','103776',1547616417),('18002265908','342524',1547718232),('18520782570','822864',1547888340),('13556036196','294759',1548163897),('13102163019','384902',1548426213),('18526860284','666070',1548509718),('13821506212','107041',1548512268),('13821452840','953538',1548681153),('15918465033','480851',1548681300),('18202040207','544781',1548722465);

/*Table structure for table `fx_whitelist` */

DROP TABLE IF EXISTS `fx_whitelist`;

CREATE TABLE `fx_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tel` char(11) DEFAULT NULL COMMENT '顶级分销商手机号',
  `level` tinyint(4) DEFAULT '1' COMMENT '1顶级分销商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_whitelist` */

insert  into `fx_whitelist`(`id`,`tel`,`level`) values (1,'13711710848',1),(2,'13392119515',1),(3,'13600019072',1),(4,'13826162857',1),(5,'13318869333',1),(6,'13929585955',1),(7,'13794330006',1),(8,'18926223180',1),(9,'18520782570',1),(10,'18622905098',1),(11,'18002265908',1),(12,'13556036196',1),(13,'13102163019',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
