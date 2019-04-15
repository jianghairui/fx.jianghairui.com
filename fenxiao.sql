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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_admin` */

insert  into `fx_admin`(`id`,`code`,`realname`,`username`,`gender`,`email`,`tel`,`password`,`create_time`,`last_login_ip`,`last_login_time`,`status`,`login_times`,`level`,`desc`) values (1,'0','姜海蕤','jianghairui',1,'1873645345@qq.com','13102163019','cb8155233c38b99f3ad4ecc34e37c27b',1540099895,'121.33.172.66',1555169873,1,142,1,'好人啊\n'),(4,'0','仓管','cang',1,'1873645345@qq.com','18526860284','f91f03f716c406c14e268c4ebcbb040d',1540103141,'60.25.12.188',1547360493,1,17,1,''),(5,'1547516141','Jiang','jiang',1,NULL,'13102163019','f91f03f716c406c14e268c4ebcbb040d',1546957182,'60.25.57.65',1549940891,1,14,1,''),(6,'1547534379','钟','zzzzz',1,NULL,'13556036196','182190c915daadda6d909f9691819e45',1547185010,'59.42.129.191',1548864254,1,22,1,''),(7,'','张涛','zhangtao',1,NULL,'','6d2ce804b79357607ba030289392b84a',1549940553,'60.25.11.29',1554895966,1,3,1,'');

/*Table structure for table `fx_article` */

DROP TABLE IF EXISTS `fx_article`;

CREATE TABLE `fx_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `desc` varchar(100) DEFAULT NULL COMMENT '副标题',
  `content` text COMMENT '内容',
  `pic` varchar(255) DEFAULT NULL COMMENT '封面',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `admin_id` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1' COMMENT '0隐藏1正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_article` */

insert  into `fx_article`(`id`,`title`,`desc`,`content`,`pic`,`create_time`,`admin_id`,`status`) values (2,'AI商业趋势有哪些?','AI商业趋势有哪些?','<p style=\"text-indent: 0em; text-align: center;\"><img src=\"/ueditor/php/upload/image/20190410/1554896411780274.jpg\" title=\"1554896411780274.jpg\" alt=\"20180731045240333.jpg\"/></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">对于创新工场创始人&amp;管理合伙人汪华，多见诸媒体笔下的形象是：IT宅男、不喜社交以及李开复光环背后的男人。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">关于前者有一个例子是，汪华曾经一个月没有踏出过创新工场总部的门，在他的办公室里研究互联网趋势，看创业公司资料，管投后，困了就靠在沙发上睡会儿。而后两者之间其实有些联系，因为不喜且也不擅长社交，汪华索性也不再勉强自己，创新工场对外的事宜几乎都是李开复在发声，“如果李开复愿意花很多时间在社交和工作上，在非必要的情况下，如果有别人能做得更好，那我就没有必要做那些，资源最大化嘛。”</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">早在2011年，汪华就在创新工场提出了 “纵横合力产业链式”投资方法论，认为移动互联网的大机遇要从基础工具、娱乐和本地商务这三个大阶段来进行投资布局。后面几年互联网的发展也正印证了汪华的投资思路。有投资人后来表示，要密切关注汪华最近说了什么，“汪华对趋势的分析判断，我们可以拿来做投资的风向标。”</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">汪华从2012年开始，带着创新工场开始投资人工智能，创新工场也称为国内最早的规模化的投资人工智能的基金和投资机构之一。汪华做了以AI为主题的分享，表达了三个观点：</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">1、AI的最大推动力是黑科技和需求</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">2、AI的三波浪潮</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">第一波：商业的自动化或者是虚拟世界的、数据世界的自动化</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">第二波：实体世界智能化和我们怎么把真实世界完全数字化</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">第三波：从线下实体的发展拓展到每个人，每个家庭，包括从虚拟的自动化，拓展到实体的机器人自动化，然后到全方位的自动化。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">3、AI可以提升中国的效率</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">无论是说供给侧改革还是中国经济将来提高质量和效率，其实本质上来说都要靠AI解决这个问题，AI为整个中国经济赋能。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">以下为演讲实录，界面创业略作编辑：</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">AI最大的推动力：黑科技推动，需求推动</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">黑科技推动我们从2012年就注意到，无论是互联网数据，GPO计算能力，尤其是深度学习和增强现实的进展，导致我们计算机系统开始解决从来没有解决的一些问题。比如以前我们发现计算机系统跟人对比有一个有趣的特点，很多对于人复杂的问题，比如说计算非常复杂的加减乘除和成千上万的数据探索的检索，检索、查询这些工作，对人来讲很难做到，对计算机系统来说非常容易。但是很多对人来说非常容易的事情，比如说识别一张照片，这里面有什么问题，听懂别人说的话，这些对人来说非常简单的事情，对计算机系统来说，却很难到。而深度学习和增强学习这一点的突破，其实是解决了这个问题，开始通过这个边界。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">以前来说，比如图象识别，视频，声音这些，对于计算机难以解析的事情，随着计算机的进展，可以开始解决。而以前很多没有办法被明确的总结经验，总结准确规律的事情，比如说下围棋，再比如说像一个人现在是高兴还是不高兴。这些不能用程序解决的问题，却开始能突破，被深度学习解决。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">所以，这个就意味这是什么呢?意味这第一次有可能计算机系统把人从简单重复的那些事情里面解放出来。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">过去人工智能说了很多年了，从60年代开始，为什么这次是真正意义上的有了特别关键性标志。第一个就是有没有达到和超过人的水准。这些计算机成熟，无论是下棋，或者识别图片这些工作，并不是要做到100%准确，它能够大规模实用化和应用标准化，这是人工智能第一个领域做得比人强，还有很重要一点，这些很东西能不能泛化，也就是说如果只能用来下围棋或者只能用来识别图片，那这样的突破只能像是一个玩具。但是，要看接下来进程会深度学习，和机器学习做法是可以被泛化的，从最早视觉拓展到语音的理解，拓展到BI，比如商业智能，自动化，比如最近阿里看到用AI来帮美工自动生成双11成千上万张的海报，这个是可以被泛化出来的。所以这就是所谓黑客驱动，是整个AI最原始的推动力。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">但是如果只是科技本身的推动的话，其实人类历史上有很多科技的进程，但是很多科技的突破没有转化成现实的生产力。所以科技的推动另外一条腿就是刚需。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">我们是09年最早投资移动互联网的一个机构，但是到2013年开始，我在思考一个问题，过去的10年的互联网和移动互联网做到了什么?他们的下一步又是什么?</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">比如过去的十多年互联网和移动互联网做到什么?把万事万物随时随地，所有的数据、所有的场景和行为、交易，源源不断的搬到网上，我们所有的东西都搬到线上。线下发生什么?我们过去的现象就是所有的数据一旦数字化，一旦行为被搬到线上，第一个发生事情就是所有交易行为的数量会以几何数字上升。如果我们做了电子商务会发现，一旦买东西的行为搬上线上之后，你每一次买东西的数量提升了10倍。过去的十几年的时间，中国的快递包裹的总量，你说以双11为例，过去这几年都提高了不是几十倍，而是几百上千倍。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">比如说移动支付，电子支付，把付钱这个行为搬到线上，电子化，数据化之后，你会发现交易的总量在过去短短几年间提高了几百上千倍。所以所有东西搬到线上的时候，就要解决自动化的问题。面临了成千上万倍交易的增长之后，你一定不可能像以前一样用人一个个去解决这些问题了。你就必须要使用算法，使用机器人，把这些交易采用自动化的方式处理掉。但是光是自动化也是没有用的，因为自动化解决了量的问题，但是到底做得好还是不好是不确定的，下一步的话，其实是优化和智能化的问题。因为一旦一个行业进入到AI之后，其实竞争是无边界的。比如说阿里把电商搬到线上了以后，一个商户小店本来可能在一个街区竞争，现在在全球范围跟所有商家进行竞争。而这些竞争你就必须获得优势，如何获得?就是要优化和智能化，而无论是自动化还是智能化，优化，这些都是需要通过AI来解决这个问题。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">从某种意义上来说，AI不仅仅因为技术驱动，也是需求驱动，是互联网和移动互联网下一步走的必然优势，也是互联网和移动互联网、大数据发展下的升级版本。所以从这个点角度来讲AI离我们不远，甚至是已经发生，是我们下一步必然发展的方向和趋势。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">AI发展史上的三波浪潮</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">具体到第一波来说的话，就是所谓的商业的自动化或者是虚拟世界的、数据世界的自动化。我们大家在问AI是不是离我们很远的时候，或者AI商业化是不是很远的时候，其实我们已经在用上了AI了。我们每一次在百度上做搜索的时候，我们每一次在阿里购物的时候，我们每一次在使用手机的时候，其实背后我们都已经用上了这些AI。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">AI是不是能商业化?其实第一家被AI大规模商业化的公司，其实就是谷歌。谷歌在它广告系统，它的搜索系统，包括它一年几十亿人民币的收入，它的本质的技术来源就是机器学习。所以，大家在问AI是不是已经商业化了，其实已经有公司在AI里面挣的成百上千亿的钱，已经有很多年了。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">第一波的AI实际上就是这些已经被充分的数字化和在线交易化的领域。比如说像金融，互联网，电商零售这些领域，是在用AI实现智能化或者交易的公司。为什么这个谷歌，百度，阿里这样的公司是第一波AI公司?其实很简单，他们第一波实现全面数字和线上化。传统的银行，保险，金融然后证券这些领域，包括电商零售这些领域，也会最早的实现AI，是因为这些领域实际上是已经充分的实现了线上化。他们实现了从数据自动化，到流程自动化，到交易自动化，这么一步一步走过来，这些领域随着互联网和移动互联网的普及，往更多行业发展。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">比如说我们会看到餐饮行业，其实像饿了吗，美团这样的公司把餐饮行业也逐渐的数字和在线化。我们会看到教育，医疗、能源这些行业也逐步实现线上化自动化。这些行业逐渐的是AI下一个主要的战场。第一波AI浪潮里面很重要一点是场景、数据和算法。算法和技术非常的重要，但是其实对第一波AI来说，现在的技术已经非常的成熟了。技术已经没有那么稀缺，更重要的实际上是数据和场景。我们基于什么领域，是不是实现在线化，是不是有充足数据可以当做AI的燃料，所以这个领域里面我们会看到这些公司其实是非常综合的一个团队，需要一个对于垂直行业非常有经验的CEO，需要一个对大数据非常有理解，需要一个非常好的年轻的AI工程师，把这三者结合起来就能产生直接的应用。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">而AI的第一波的浪潮要实现实体世界智能化。刚才说的所有的这些的话，实际上还是发生在线的这个过程中。那真实的世界里面，毕竟我们大量的商业，场景和这些活动，还不能离开现实实体世界。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">所以实体世界智能化和我们怎么把真实世界完全数字化是AI能够做到第二波浪潮。刚才说的无论计算机在视觉，语音，感知上面的这些突破，正是这一波浪潮的根基。计算机能够看得懂这个视频，图象，能看懂周围真实的世界。意味着无论是在线下的，无论阿里所谓新零售，亚马逊的，还是安防，这些真实的世界场景交易，可以充分的被AI进行赋能。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">而在这个领域里面的AI的话，实际上重要的是核心的这些技术，科学家和产品化，工程化能力。实际上当发生什么事情，计算机能看，能听，能理解我们周围发生的这些事情是什么含义，能听懂人说什么话的时候，计算机系统能对于世界能做的事情和赋能是无与伦比的。这无论是在制造业还是在无人驾驶，还是在包括人工智能的家庭。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">第三波的自动化浪潮就是真正全面的自动化。这一波会比较慢，可能将来5-10年时间，因为硬件的进步速度远远低于软件和算法的进步速度。而包括在开放世界和真人的场合的话，有太多不可控的因素。所以，这个会比较晚。而在这一点上，自动驾驶会是第一波促进技术发展和行业应用的催化剂，接下来就是机器人。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">在这方面的话，实际上我们这的布局也是非常充分的，这方面实际上是投资未来黑科技，投资未来5-10年，核心就是无人驾驶，芯片传感器，和机器人的核心技术。我们在各自领域都布局了很多公司。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">AI可以提升中国的效率</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">整个互联网的发展，从当年的比如说新浪的时代，纯线上，整个互联网对真实的经济影响力可能只有几个百分点的GDP。等到电商时代的时候，进一步拓展，人可以在网上买东西了，这样其实把整个互联网扩展到了GDP百分之十几。接下来移动互联网的普及，然后让整个互联网扩展到了线下的服务业或者其他的行业，能让这些东西能扩展到GDP30%。但是依然我们整个经济还有70%的部分没有被充分的覆盖。这些要依靠是什么?其实就是要依靠AI，依靠自动化，依靠AI把真实世界数据化的能力。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">对中国经济另外一个行业，就是AI为整个中国经济赋能。我们会发现过去十几年，互联网的发展，中国前端已经非常的先进了。中国移动支付可能领先了美国5、6年，中国移动互联网包括最后一公里，外卖，大家享受所有东西比美国领先的5、6年，但是中国的后端依然不够先进。中国的后端，比如供应链，生产，包括所有的中国物流，流程这些还是比欧美落后很多年的。无论是说供给侧改革还是中国经济将来提高质量和效率，其实本质上来说都要靠AI解决这个问题。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">而中国是做AI里面最有优势的。因为AI，我们中国的起步实际上还是非常早的，而且AI本身一开始阶段就有很多华人，他们实际上是在AI领域里是顶尖的玩家。而AI的发展，最主要的是靠人脑和智商，我相信，说起人脑和智商，我相信我们中国人不输于，还优于世界上大部分人种。中国政府大力支持和开放，实际上也是AI最重要的处理，因为AI很多领域突破，无论数据还是新的共享，新的顶层架构，实际上都是要有政府在顶层界面上的设计和介入，中国政府对AI的重视，开放的心态，包括中国政府强大的执政能力，最有可能让中国在这个领域里能产生返超的优势。</span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">所以，无论从政府，中国巨大的市场或者中国的这些智力资源角度，中国有可能在AI领域里成为世界最领先的国家。</span></p><p><br/></p>','static/upload/2019-04-07/155464473750954700.png','2019-04-07 21:45:37',1,1),(4,'AI商业趋势的优缺点都有哪些','AI商业趋势的优缺点都有哪些AI商业趋势的优缺点都有哪些?','<p>AI商业趋势的优缺点都有哪些AI商业趋势的优缺点都有哪些<br/></p>','static/upload/2019-04-07/155464519776455500.jpg','2019-04-07 21:53:17',1,1),(7,'杨柳青画社','天津杨柳青青年画社','<p style=\"text-indent: 2em;\"><span style=\"font-size: 14px; text-indent: 2em;\">天津杨柳青画社成立于1958年，由杨柳青画业合作社、天津荣宝斋、天津德裕公画庄合并组成。画社生产的杨柳青木版年画，始创于明代末年，已有300多年历史，在我国民间年画中以其木版套印与手工彩绘相结合的特色独特一帜。建社以来，已搜集、整理杨柳青年画资料3000余种，出已复制出版约四、五百种。同时出版胶印年画、中堂画以及其他绘画、摄影作品，并有各类画册和美术书籍，其中《中国儿童》在1988年全国少年儿童图书评奖中，获优秀图书奖。</span></p><p style=\"text-indent: 0em; text-align: center;\"><span style=\"font-size: 14px; text-indent: 2em;\"><img src=\"/ueditor/php/upload/image/20190410/1554896235674936.jpg\" title=\"1554896235674936.jpg\" alt=\"se12232567f.jpg\"/></span></p><p style=\"text-indent: 2em;\"><span style=\"font-size: 14px;\">天津杨柳青画社珍藏着丰富的杨柳青年画资料与刻版，是杨柳青木版年画勾、刻、印、绘四大工艺的传承之源，被公推为“中国年画之首”。依据传统工艺出品的年画产品以中国“年文化”的独特艺术魅力，沟通了国际性的文化往来和交流。2005年，被列为首批“中国非物质文化遗产项目”。画社生产的传统民间艺术品还包括：木版水印画、册页、线装书籍、胶印年画、装饰画以及文房四宝、工艺品、礼品等文化用品，是“中华老字号”之一，在业界享有较高商誉。</span></p><p style=\"text-indent: 0em; text-align: center;\"><span style=\"font-size: 14px;\"><img src=\"/ueditor/php/upload/image/20190410/1554896252151952.jpg\" title=\"1554896252151952.jpg\" alt=\"se21719317.jpg\"/></span></p>','static/upload/2019-04-10/155489612914464800.jpg','2019-04-10 19:35:29',7,1);

/*Table structure for table `fx_auth_group` */

DROP TABLE IF EXISTS `fx_auth_group`;

CREATE TABLE `fx_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `desc` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `fx_auth_group` */

insert  into `fx_auth_group`(`id`,`title`,`desc`,`status`,`rules`) values (1,'一级分销商','负责确认订单',1,'96,97,109,108,98,101,100,99,105,106,103'),(4,'用户管理员','只负责用户管理',1,'96,111,97,110,109,108'),(2,'仓管','负责备货，发货',1,'83,86,98,107,102'),(5,'资讯编辑','资讯编辑',1,'112,120,119,118,117,116,115,114,113,83,86');

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

insert  into `fx_auth_group_access`(`uid`,`group_id`) values (4,2),(5,1),(6,1),(7,5);

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
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;

/*Data for the table `fx_auth_rule` */

insert  into `fx_auth_rule`(`id`,`name`,`title`,`type`,`status`,`condition`,`pid`) values (4,'Admin/adminlist','查看管理员列表',1,1,'',3),(3,'Admin','管理员管理',1,1,'',0),(5,'Admin/adminadd','添加管理员',1,1,'',3),(6,'Admin/adminadd_post','添加管理员POST',1,1,'',3),(101,'Op/orderReject','订单审核（拒绝）',1,1,'',98),(31,'Admin/adminmod','修改管理员',1,1,'',3),(33,'Admin/admindel','删除管理员',1,1,'',3),(32,'Admin/adminmod_post','修改管理员POST',1,1,'',3),(34,'Admin/admin_multidel','批量删除管理员',1,1,'',3),(35,'Admin/adminstop','冻结管理员',1,1,'',3),(36,'Admin/adminstart','启用管理员',1,1,'',3),(48,'Admin/rulelist','查看节点列表',1,1,'',3),(38,'Admin/ruleadd','添加节点',1,1,'',3),(39,'Admin/ruleadd_post','添加节点POST',1,1,'',3),(40,'Admin/ruledel','删除节点',1,1,'',3),(41,'Admin/grouplist','查看角色列表',1,1,'',3),(42,'Admin/groupadd','添加角色',1,1,'',3),(43,'Admin/groupadd_post','添加角色POST',1,1,'',3),(44,'Admin/groupmod','修改角色',1,1,'',3),(45,'Admin/groupmod_post','修改角色POST',1,1,'',3),(46,'Admin/groupdel','删除角色',1,1,'',3),(47,'Admin/group_multidel','批量删除角色',1,1,'',3),(100,'Op/orderPass','订单审核（通过）',1,1,'',98),(99,'Op/orderlist','订单列表',1,1,'',98),(120,'Article/articleShow','显示资讯',1,1,'',112),(119,'Article/articleHide','隐藏资讯',1,1,'',112),(118,'Article/articleDel','删除资讯',1,1,'',112),(117,'Article/articleModPost','资讯编辑',1,1,'',112),(116,'Article/articleDetail','文章内容',1,1,'',112),(115,'Article/articleAddPost','添加资讯POST',1,1,'',112),(114,'Article/articleAdd','添加资讯',1,1,'',112),(113,'Article/articleList','资讯列表',1,1,'',112),(112,'Article','资讯管理',1,1,'',0),(111,'User/userGetback','恢复用户',1,1,'',96),(83,'System','系统管理',1,1,'',0),(97,'User/userlist','用户列表',1,1,'',96),(96,'User','用户管理',1,1,'',0),(86,'System/syslog','查看系统日志',1,1,'',83),(98,'Op','业务管理',1,1,'',0),(110,'User/userStop','拉黑用户',1,1,'',96),(109,'User/usermod','用户编辑POST',1,1,'',96),(108,'User/userdetail','用户编辑',1,1,'',96),(107,'Op/sendlist','发货列表',1,1,'',98),(105,'Op/stockReject','备货审核（拒绝）',1,1,'',98),(106,'Op/stockPass','备货审核（通过）',1,1,'',98),(103,'Op/stocklist','备货列表',1,1,'',98),(102,'Op/deliver','订单发货',1,1,'',98);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_order` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_stock` */

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
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_syslog` */

insert  into `fx_syslog`(`id`,`admin_id`,`detail`,`create_time`,`ip`,`type`) values (1,1,'登录账号',1547481427,'60.25.12.188',0),(2,1,'登录账号',1547481906,'60.25.12.188',0),(3,1,'登录账号',1547516882,'218.68.102.24',0),(4,1,'登录账号',1547522914,'59.42.128.205',0),(5,1,'登录账号',1547555330,'117.136.79.19',0),(6,1,'登录账号',1547587649,'59.42.128.91',0),(7,1,'登录账号',1547606944,'59.42.128.91',0),(8,1,'登录账号',1547606986,'59.42.128.91',0),(9,1,'登录账号',1547616320,'59.42.128.91',0),(10,1,'登录账号',1547712647,'223.104.64.239',0),(11,1,'登录账号',1548069746,'60.25.12.160',0),(12,1,'登录账号',1548075116,'60.25.12.160',0),(13,1,'登录账号',1548163461,'121.33.131.204',0),(14,1,'登录账号',1548170692,'121.33.173.207',0),(15,6,'登录账号',1548171457,'121.33.173.207',0),(16,1,'登录账号',1548331797,'60.25.12.160',0),(17,1,'登录账号',1548419893,'59.41.95.238',0),(18,6,'登录账号',1548423013,'59.41.95.238',0),(19,1,'登录账号',1548423376,'59.41.95.238',0),(20,6,'登录账号',1548423476,'59.41.95.238',0),(21,1,'登录账号',1548425825,'60.25.12.160',0),(22,6,'登录账号',1548466600,'59.41.95.238',0),(23,1,'登录账号',1548466725,'59.41.95.238',0),(24,6,'登录账号',1548467276,'59.41.95.238',0),(25,1,'登录账号',1548468436,'113.103.0.234',0),(26,6,'登录账号',1548472385,'121.8.161.130',0),(27,1,'登录账号',1548472492,'121.8.161.130',0),(28,1,'登录账号',1548472593,'113.103.0.234',0),(29,1,'登录账号',1548481069,'121.8.161.130',0),(30,1,'登录账号',1548481159,'113.103.0.234',0),(31,1,'登录账号',1548505048,'59.41.95.238',0),(32,1,'登录账号',1548508252,'60.25.12.159',0),(33,1,'登录账号',1548509843,'60.25.12.159',0),(34,5,'登录账号',1548509853,'60.25.12.159',0),(35,5,'登录账号',1548509899,'60.25.12.159',0),(36,5,'登录账号',1548512377,'60.25.12.159',0),(37,1,'登录账号',1548512804,'60.25.12.159',0),(38,5,'登录账号',1548512838,'60.25.12.159',0),(39,1,'登录账号',1548655089,'117.136.32.84',0),(40,1,'登录账号',1548655270,'113.103.3.85',0),(41,1,'登录账号',1548675755,'59.42.129.122',0),(42,1,'登录账号',1548678152,'59.42.129.122',0),(43,6,'登录账号',1548678602,'59.42.129.122',0),(44,1,'登录账号',1548681925,'60.25.12.159',0),(45,5,'登录账号',1548682062,'60.25.12.159',0),(46,6,'登录账号',1548683901,'59.42.129.122',0),(47,1,'登录账号',1548684388,'59.42.129.122',0),(48,6,'登录账号',1548685703,'59.42.129.122',0),(49,1,'登录账号',1548686512,'59.42.129.122',0),(50,1,'登录账号',1548687417,'60.25.12.159',0),(51,1,'登录账号',1548687909,'60.25.12.159',0),(52,6,'登录账号',1548722611,'59.42.129.122',0),(53,1,'登录账号',1548722662,'59.42.129.122',0),(54,6,'登录账号',1548723821,'59.42.129.122',0),(55,6,'登录账号',1548845052,'59.42.129.191',0),(56,1,'登录账号',1548856427,'59.42.129.191',0),(57,6,'登录账号',1548864254,'59.42.129.191',0),(58,1,'登录账号',1549245685,'117.11.108.56',0),(59,1,'登录账号',1549356133,'117.11.108.56',0),(60,1,'登录账号',1549940368,'60.25.57.65',0),(61,7,'登录账号',1549940580,'60.25.57.65',0),(62,5,'登录账号',1549940891,'60.25.57.65',0),(63,1,'登录账号',1549940973,'60.25.57.65',0),(64,7,'登录账号',1549941138,'60.25.57.65',0),(65,1,'登录账号',1554640246,'60.25.63.79',0),(66,1,'登录账号',1554727664,'60.25.63.79',0),(67,1,'登录账号',1554730838,'60.25.63.79',0),(68,1,'登录账号',1554816100,'60.25.63.79',0),(69,1,'登录账号',1554895644,'60.25.11.29',0),(70,7,'登录账号',1554895966,'60.25.11.29',0),(71,1,'登录账号',1554896314,'60.25.11.29',0),(72,1,'登录账号',1554899118,'223.104.64.238',0),(73,1,'登录账号',1554899140,'223.104.64.238',0),(74,1,'登录账号',1555143212,'113.103.1.116',0),(75,1,'登录账号',1555169873,'121.33.172.66',0);

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_user` */

insert  into `fx_user`(`id`,`top_code`,`code`,`pcode`,`openid`,`realname`,`nickname`,`tel`,`avatar`,`level`,`sales`,`stock`,`order`,`team`,`upper_limit`,`status`,`create_time`) values (1,'1553699130','1553699130','9999999999','oekyqw_4tV8i0FeWgvXp38x1MPjE','姜海蕤','姜海蕤','13102163019','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJ5kGlkibuL0OibtDzQ15SOF1rWrTOeJrPCJn9DQkQic6BbPPicVR1at5uCNEhaet25XCALk6sMO5lyvQ/132',1,0,0,0,0,2,1,1553699130),(2,'1554640127','1554640127','9999999999','oekyqw5VLYk2ru7k7cr5RV9n02FA','柠檬','不吃猫的鱼?','13821506212','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIvR70LhzRNoicSEY5kW3gyQBTsRNrCRkyWTdicaOIRjXO4lz1j8e3X6qxRIhic8vKho4GI2Raibrw8LA/132',1,0,0,0,0,2,1,1554640127),(4,'1553699130','1554735263','1553699130','oekyqw14UMKlcjYpDtm23dh2CQOU','张三','环形山','13114857103','http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqKiaa7OE3FelJBUcA4ibCP1gtM89EPm0od31lZvqbpLk0PQZzbvEL74CZWK7SgZDViczGcvWKtalic7w/132',2,0,0,0,0,2,1,1554735263),(5,'1553699130','1554898941','1553699130','oekyqw_ZtE37m2eko2cmGFF6estE','龙','龙','13556036196','http://thirdwx.qlogo.cn/mmopen/vi_32/wQa3HGYJUXnVmmKUq3bppibFsCytQPs14Vw6ktbEK6iaD4CKDXVmhBQZrpYWITAic4JmMqBEL1MkeQibljnIiaZqQZQ/132',2,0,0,0,0,2,1,1554898941),(6,'1553699130','1554901848','1553699130','oekyqw6iBDozJnv0OwFUKE3RF608','测试','Viki?','18622905098','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIuVj6O1fZXjwnP9vPiaFdjohBicRlxgNpwYhjK8McnxGMx0Z3O8pHH8Zxok8sCgk2Msq4BmprRibuwA/132',2,0,0,0,0,2,1,1554901848),(7,'0','1555143691','0','oekyqw97lOTru7L_o2ZivRvYaAjk',NULL,'杨振华 Jeffrey','','http://thirdwx.qlogo.cn/mmopen/vi_32/iaSVpG00LNwibaENRVvJ1oDcMicBmlicc3mCxTdD4FicfGYUwbeIrMmxIaZEIV2X5HproG1D0uibJ0dBGQcm3uweIb5A/132',0,0,0,0,0,2,1,1555143691),(8,'0','1555162193','0','oekyqw-9ElyzLrmTpbVFExeTYM2Y',NULL,'$','','http://thirdwx.qlogo.cn/mmopen/vi_32/6Mj2NyTMW6FNJMaSB4wNT2Fwjdk9IXuEUyM1wIWsxpatWkqjGGaCYjkVc8guGzvhke0ZztELHRqde8N0c1KbLA/132',0,0,0,0,0,2,1,1555162193),(9,'0','1555162301','0','oekyqw09oiu3o1boBqr2IyY8u738',NULL,'晚秋','','http://thirdwx.qlogo.cn/mmopen/vi_32/ZgyJXQ2SNTznl3vgePEcfbWIWsgOVun3O0zaHnUDuVbicl9vVtJCngJSp7vrLKWW3nuxibCO5IZiaC97shM0d4QrQ/132',0,0,0,0,0,2,1,1555162301),(11,'1553699130','1555163278','1553699130','oekyqw-NxQKrLacS8JvU6Gse7xmo','清流','清流?','18526860284','http://thirdwx.qlogo.cn/mmopen/vi_32/8pFAETc92OvialBUicHEjgdDwECZNN3icrPOjlt4icXjiaTNOc1hsHab6phxdlCQ5tSBeDBFrQov2lXeibauolhwCwhA/132',2,0,0,0,0,2,1,1555163278),(12,'0','1555163606','0','oekyqw1KjtA_1KB0G4mZGrG7b0c4',NULL,'??','','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJkolDibCVhMsRlZm2v66pVIen2AzVfnuJaX51pbECwrWLFPpGHN8yROWgANfIiaakQyHRcvYfbicD5Q/132',0,0,0,0,0,2,1,1555163606);

/*Table structure for table `fx_verify` */

DROP TABLE IF EXISTS `fx_verify`;

CREATE TABLE `fx_verify` (
  `tel` char(11) DEFAULT NULL COMMENT '手机号',
  `code` char(6) DEFAULT NULL COMMENT '短信验证码',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '发送短信时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_verify` */

insert  into `fx_verify`(`tel`,`code`,`create_time`) values ('13102163019','166521',1555163300),('13821506212','560448',1554640286),('18526860284','166521',1555163300),('13114857103','155444',1554897123),('13556036196','567431',1554899000),('18622905098','166521',1555163300);

/*Table structure for table `fx_whitelist` */

DROP TABLE IF EXISTS `fx_whitelist`;

CREATE TABLE `fx_whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tel` char(11) DEFAULT NULL COMMENT '顶级分销商手机号',
  `level` tinyint(4) DEFAULT '1' COMMENT '1顶级分销商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

/*Data for the table `fx_whitelist` */

insert  into `fx_whitelist`(`id`,`tel`,`level`) values (1,'13711710848',1),(2,'13392119515',1),(3,'13600019072',1),(4,'13826162857',1),(5,'13318869333',1),(6,'13929585955',1),(7,'13794330006',1),(8,'18926223180',1),(9,'18520782570',1),(10,'18622905098',1),(11,'18002265908',1),(12,'13556036196',1),(13,'13102163019',1),(14,'13821506212',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
