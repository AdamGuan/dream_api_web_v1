-- --------------------------------------------------------
-- 主机:                           115.29.40.242
-- 服务器版本:                        5.1.73 - Source distribution
-- 服务器操作系统:                      redhat-linux-gnu
-- HeidiSQL 版本:                  9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 dream_api_web_v1 的数据库结构
DROP DATABASE IF EXISTS `dream_api_web_v1`;
CREATE DATABASE IF NOT EXISTS `dream_api_web_v1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dream_api_web_v1`;


-- 导出  表 dream_api_web_v1.t_config_pkg 结构
DROP TABLE IF EXISTS `t_config_pkg`;
CREATE TABLE IF NOT EXISTS `t_config_pkg` (
  `F_pkg` varchar(250) NOT NULL COMMENT '包名',
  `F_app_name` varchar(250) NOT NULL COMMENT '包对应的应用名字',
  `F_app_id` varchar(250) NOT NULL COMMENT 'leancloud对应的app id',
  `F_app_key` varchar(250) NOT NULL COMMENT 'leancloud对应的app key',
  `F_app_master_key` varchar(250) NOT NULL COMMENT 'leancloud对应的master key',
  `F_app_msm_template` varchar(250) NOT NULL COMMENT 'leancloud对应的短信模板名',
  UNIQUE KEY `F_pkg` (`F_pkg`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='包相关信息';

-- 正在导出表  dream_api_web_v1.t_config_pkg 的数据：1 rows
DELETE FROM `t_config_pkg`;
/*!40000 ALTER TABLE `t_config_pkg` DISABLE KEYS */;
INSERT INTO `t_config_pkg` (`F_pkg`, `F_app_name`, `F_app_id`, `F_app_key`, `F_app_master_key`, `F_app_msm_template`) VALUES
	('webdream', '追梦网站', 'ogxif29tbur554rh6n2m9yefhajgqkjqwspvr4lzu9rczxvn', '2qdmwrqh979waj4emidd0yh07jcu9xm5rz4vuqam1bt4lq0k', '06midcv0qs66lq3w4e8r7s7njngcd18t19wv53huegtga47s', 'template2');
/*!40000 ALTER TABLE `t_config_pkg` ENABLE KEYS */;


-- 导出  表 dream_api_web_v1.t_config_response 结构
DROP TABLE IF EXISTS `t_config_response`;
CREATE TABLE IF NOT EXISTS `t_config_response` (
  `F_response_no` smallint(5) NOT NULL COMMENT '响应code',
  `F_response_msg` varchar(50) NOT NULL COMMENT '响应信息'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='api的响应配置';

-- 正在导出表  dream_api_web_v1.t_config_response 的数据：4 rows
DELETE FROM `t_config_response`;
/*!40000 ALTER TABLE `t_config_response` DISABLE KEYS */;
INSERT INTO `t_config_response` (`F_response_no`, `F_response_msg`) VALUES
	(0, '成功'),
	(-1, '失败'),
	(-6, '签名错误'),
	(-7, '包名不存在');
/*!40000 ALTER TABLE `t_config_response` ENABLE KEYS */;


-- 导出  表 dream_api_web_v1.t_ip_white_list 结构
DROP TABLE IF EXISTS `t_ip_white_list`;
CREATE TABLE IF NOT EXISTS `t_ip_white_list` (
  `F_ip` char(15) NOT NULL COMMENT 'IP地址',
  `F_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:IP',
  `F_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:有效,0无效'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='ip白名单';

-- 正在导出表  dream_api_web_v1.t_ip_white_list 的数据：3 rows
DELETE FROM `t_ip_white_list`;
/*!40000 ALTER TABLE `t_ip_white_list` DISABLE KEYS */;
INSERT INTO `t_ip_white_list` (`F_ip`, `F_type`, `F_status`) VALUES
	('118.144.94.29', 1, 1),
	('14.118.134.34', 1, 1),
	('14.29.69.14', 1, 1);
/*!40000 ALTER TABLE `t_ip_white_list` ENABLE KEYS */;


-- 导出  表 dream_api_web_v1.t_sms_action_valid 结构
DROP TABLE IF EXISTS `t_sms_action_valid`;
CREATE TABLE IF NOT EXISTS `t_sms_action_valid` (
  `F_action` char(32) NOT NULL COMMENT '动作，(md5(pthone+pkg+sms))',
  `F_last_timestamp` datetime NOT NULL COMMENT '最后更新时间',
  UNIQUE KEY `F_action` (`F_action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='记录每个动作对应的短信验证码，用于安全验证。暂时的，会改为redis';

-- 正在导出表  dream_api_web_v1.t_sms_action_valid 的数据：0 rows
DELETE FROM `t_sms_action_valid`;
/*!40000 ALTER TABLE `t_sms_action_valid` DISABLE KEYS */;
INSERT INTO `t_sms_action_valid` (`F_action`, `F_last_timestamp`) VALUES
	('200ea582eca8cb65d52738367ab576b9', '2015-04-08 14:49:04'),
	('6af1a69fca1cfdd0c752cdfa1e99b1c3', '2015-04-08 14:14:19'),
	('17c277eb2d2cc3460b3810d2cdbc4989', '2015-04-08 14:12:46');
/*!40000 ALTER TABLE `t_sms_action_valid` ENABLE KEYS */;


-- 导出  表 dream_api_web_v1.t_sms_order 结构
DROP TABLE IF EXISTS `t_sms_order`;
CREATE TABLE IF NOT EXISTS `t_sms_order` (
  `F_order_smsnum` varchar(10) NOT NULL COMMENT '验证码',
  `F_phone` varchar(50) NOT NULL COMMENT '手机号码',
  `F_pkg` varchar(50) NOT NULL COMMENT '包名',
  `F_create_datetime` datetime NOT NULL COMMENT '创建时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发送的订单通知短信';

-- 正在导出表  dream_api_web_v1.t_sms_order 的数据：7 rows
DELETE FROM `t_sms_order`;
/*!40000 ALTER TABLE `t_sms_order` DISABLE KEYS */;
INSERT INTO `t_sms_order` (`F_order_smsnum`, `F_phone`, `F_pkg`, `F_create_datetime`) VALUES
	('0123456789', '18675399699', 'webdream', '2015-04-07 15:27:14'),
	('12312ab', '13417747867', 'webdream', '2015-04-07 16:10:23'),
	('12312abasd', '13417747867', 'webdream', '2015-04-07 16:25:20'),
	('0123456', '18675399699', 'webdream', '2015-04-07 17:01:14'),
	('987654321', '18675399699', 'webdream', '2015-04-07 17:18:28'),
	('987654321', '18675399699', 'webdream', '2015-04-07 17:56:12'),
	('9876543210', '13417747867', 'webdream', '2015-04-08 12:35:07'),
	('9876543210', '13417747867', 'webdream', '2015-04-08 15:11:22'),
	('6666666666', '18675399699', 'webdream', '2015-04-08 15:17:35'),
	('6666666666', '18675399699', 'webdream', '2015-04-08 15:19:55');
/*!40000 ALTER TABLE `t_sms_order` ENABLE KEYS */;


-- 导出  表 dream_api_web_v1.t_sms_rate 结构
DROP TABLE IF EXISTS `t_sms_rate`;
CREATE TABLE IF NOT EXISTS `t_sms_rate` (
  `F_action` char(32) NOT NULL COMMENT '动作，(md5(pthone+pkg))',
  `F_last_timestamp` datetime NOT NULL COMMENT '时间',
  UNIQUE KEY `F_action` (`F_action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='记录短信发送的频率，用于限制短信的频繁发送，暂时的，会改为redis';

-- 正在导出表  dream_api_web_v1.t_sms_rate 的数据：66 rows
DELETE FROM `t_sms_rate`;
/*!40000 ALTER TABLE `t_sms_rate` DISABLE KEYS */;
INSERT INTO `t_sms_rate` (`F_action`, `F_last_timestamp`) VALUES
	('0b30ac3c4d2a959b7e64d9f014f20bfd', '2015-02-02 09:07:57'),
	('5216017ac1d357258c6b2c9810ab4feb', '2015-04-08 15:11:22'),
	('d28c4c2ae23899440cae4a3bd4ce8ca6', '2015-04-08 15:19:55'),
	('4821a80cdb92324830d0f9ee226125bf', '2015-04-08 11:16:32'),
	('d92074d6eb40d48ab5c01ab26fe66349', '2015-04-07 15:08:43'),
	('aedb41ae0187c85fd29d590eff9c2873', '2015-02-04 11:51:25'),
	('35191c3ff797ad8d96f51d41ce8700f0', '2015-03-18 11:00:09'),
	('4e521279dce9ff24941d49524b7c1fe3', '2015-04-07 15:10:23'),
	('a7c8bc593dd9fcf7be5c96c50241c20e', '2015-02-06 09:34:26'),
	('fff21c1a42070a1ee107d4ca156a88ef', '2015-03-17 15:55:20'),
	('4e8e76d9fd77299e1da5a4d091684cdc', '2015-02-06 16:35:35'),
	('1358912028e0141a91f1d9bc9a2b635e', '2015-02-06 16:38:14'),
	('9004d284636ce63b093f51accff5a4cf', '2015-02-06 16:43:54'),
	('594f3c02a9cb05d32257e79a5ff95871', '2015-02-06 16:44:37'),
	('0bde8b9ee46c7cd91fa7792dd7bf2b1d', '2015-03-18 10:11:52'),
	('549a1bb96471d35ff90941cbec8a7d6f', '2015-02-26 10:59:19'),
	('11553aa5774253461e1aee34318be9b9', '2015-02-26 11:14:46'),
	('d24748e8a35ba45d467401ae238544a9', '2015-02-26 11:15:42'),
	('8a238fb781021c591dffc621a1dc05f9', '2015-02-26 11:54:34'),
	('1babe156d2bed7156f024173f67a1395', '1001-01-01 00:00:00'),
	('f95ca5684030f7850e1ea755232b9e71', '2015-02-26 13:41:35'),
	('6970e36b2db0d3260a901d8baf410c78', '2015-02-26 15:29:56'),
	('62a4ce1c0a352e9f03e86d24ea0620b9', '2015-02-26 16:34:23'),
	('d976302c99184634ac49b780c7a9f7c9', '2015-03-05 10:27:01'),
	('8ac694f7aee83ce5c5f9af4e8ddda067', '2015-03-05 11:01:42'),
	('d8050084a3f5dc901f3767ae41643656', '2015-03-09 11:04:38'),
	('ceef21446d15c92ffb9a783077f29cbe', '2015-03-09 15:07:55'),
	('a08f40833b168b77020ebae852a519f0', '2015-03-09 19:08:41'),
	('8d38645d6d0c9cd4d233ff73e4276681', '2015-03-10 10:03:09'),
	('1f17baefc646a2c645629be03cba4aa2', '2015-03-10 12:06:53'),
	('84cf65e650c654b6dc16f08259dafdcd', '2015-03-10 13:53:00'),
	('763968ab30f13bd22e24a393d417d59c', '2015-03-17 15:30:49'),
	('b63271fe293675c0716d7d0edc04a7c6', '2015-03-11 16:06:40'),
	('9cf14915d27be79a68189bb78cbefba9', '2015-03-18 08:42:42'),
	('9064bb341e49840af356ca3def8bb8d7', '2015-03-18 16:11:46'),
	('71737f32f352c21f466b08568b4f44cd', '2015-04-08 14:13:54'),
	('6d96964c43e78f790fdc64f2f4f90ae0', '2015-03-19 09:51:42'),
	('f5ef995388df0eb9ff4d18008c80e95b', '2015-03-19 10:19:33'),
	('e3758ac04ab3f52d0defe7e3db8d2847', '2015-03-19 13:25:23'),
	('ac1c803ad4e606c027c226dd99685828', '2015-03-20 22:35:01'),
	('77279b0d38ec24cfdd99b95863bb2f69', '2015-03-22 11:35:15'),
	('449579922bc01d9808b883c0dc5b73c1', '2015-03-22 12:31:48'),
	('ca148631dd9c8e710c3aee39099a6c6c', '2015-03-22 12:46:37'),
	('17645ae797d3bfdc06ee3e22f93b06cc', '2015-03-22 21:38:43'),
	('7ff6c8025bf27d274f312f82ce2efd9e', '2015-03-23 21:59:07'),
	('6008d187e9a106126a22414fc1e4f336', '2015-03-27 17:17:16'),
	('f874032a73cfbe4960f170eeb986589e', '2015-04-01 11:24:34'),
	('e12be6ed0ec7583bd84665024e2fd081', '2015-04-06 14:27:30'),
	('303e7152a831e9101590c4e9e483745b', '2015-04-06 15:26:38'),
	('b152c1cd7415763403013b95a0445116', '2015-04-06 15:37:22'),
	('1892b5ff82e7eb0b037508bc8389ae72', '2015-04-08 14:48:11'),
	('9657342c5d7f3fd76a7bc348eb648472', '2015-04-07 17:02:44'),
	('1cc1022509558b92b892cb12396a89c6', '2015-04-07 10:14:22'),
	('63c223bad9762a86d787f79641421d85', '2015-04-07 10:14:48'),
	('63e1edb5395a9374bd35f4669b5f1529', '2015-04-07 10:18:04'),
	('a7025fabce8aa3b8a1fdaa22a861ba0d', '2015-04-07 10:16:10'),
	('b28a1a3846d0eec32cd6bcd48128a047', '2015-04-07 10:21:19'),
	('bb533280cb187e82ecbd7d0e4f713c1d', '2015-04-07 10:26:44'),
	('a942f6825900dca95f216ce2c2d0f053', '2015-04-07 10:31:20'),
	('01daf5f2d863a8d59cead4f0a10041fa', '2015-04-07 11:23:01'),
	('b8e3140445bae66e286a3bc39279c42d', '2015-04-08 10:37:30'),
	('5ac9dc8845024bb0916affc6a24653a6', '2015-04-07 16:35:56'),
	('7639ede1d4a72d48273a03de7d6925d1', '2015-04-08 08:46:37'),
	('381f0f2c135ef292978669400d018067', '2015-04-08 08:50:21'),
	('e003aaa25bc6c1721abe8839c5a314b8', '2015-04-08 14:12:21'),
	('faace28fb459902b0a61391ed7290c57', '2015-04-08 10:14:09');
/*!40000 ALTER TABLE `t_sms_rate` ENABLE KEYS */;


-- 导出  表 dream_api_web_v1.t_token 结构
DROP TABLE IF EXISTS `t_token`;
CREATE TABLE IF NOT EXISTS `t_token` (
  `F_user_name` varchar(50) NOT NULL COMMENT '用户ID',
  `F_pkg` varchar(250) NOT NULL COMMENT '包名',
  `F_token` char(32) NOT NULL COMMENT 'token',
  `F_expire_datetime` datetime NOT NULL COMMENT 'token到期时间',
  UNIQUE KEY `F_user_name` (`F_user_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='token表';

-- 正在导出表  dream_api_web_v1.t_token 的数据：1 rows
DELETE FROM `t_token`;
/*!40000 ALTER TABLE `t_token` DISABLE KEYS */;
INSERT INTO `t_token` (`F_user_name`, `F_pkg`, `F_token`, `F_expire_datetime`) VALUES
	('13417747867', 'abc', 'e67c668edcb2c9bb8c198fcbbc9b20ab', '2015-03-04 09:13:40');
/*!40000 ALTER TABLE `t_token` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
