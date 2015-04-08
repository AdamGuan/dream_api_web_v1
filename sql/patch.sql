CREATE TABLE `t_ip_white_list` (
	`F_ip` CHAR(15) NOT NULL COMMENT 'IP地址',
	`F_type` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '1:IP',
	`F_status` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '1:有效,0无效'
)
COMMENT='ip白名单'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

ALTER TABLE `t_sms_action_valid`
	ADD COLUMN `F_last_timestamp` DATETIME NOT NULL COMMENT '最后更新时间' AFTER `F_action`;

ALTER TABLE `t_token`
	ALTER `F_user_name` DROP DEFAULT;
ALTER TABLE `t_token`
	CHANGE COLUMN `F_user_name` `F_user_name` VARCHAR(50) NOT NULL COMMENT '用户ID' FIRST;

CREATE TABLE `t_sms_order` (
	`F_order_smsnum` VARCHAR(10) NOT NULL COMMENT '验证码',
	`F_phone` VARCHAR(50) NOT NULL COMMENT '手机号码',
	`F_pkg` VARCHAR(50) NOT NULL COMMENT '包名',
	`F_create_datetime` DATETIME NOT NULL COMMENT '创建时间'
)
COMMENT='发送的订单通知短信'
COLLATE='utf8_general_ci'
ENGINE=MyISAM
;

DROP TABLE `t_user`;

DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-2 AND `F_response_msg`='已注册' LIMIT 1;
DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-3 AND `F_response_msg`='密码不符合规则' LIMIT 1;
DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-4 AND `F_response_msg`='没有注册' LIMIT 1;
DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-5 AND `F_response_msg`='用户名或密码错误' LIMIT 1;
DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-8 AND `F_response_msg`='现有密码错误' LIMIT 1;
DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-9 AND `F_response_msg`='密码错误' LIMIT 1;
DELETE FROM `dream_api_web_v1`.`t_config_response` WHERE  `F_response_no`=-10 AND `F_response_msg`='参数错误' LIMIT 1;