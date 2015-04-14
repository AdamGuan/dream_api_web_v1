INSERT INTO `dream_api_web_v1`.`t_config_response` (`F_response_no`, `F_response_msg`) VALUES (-27, '短信模板不存在');

UPDATE `dream_api_web_v1`.`t_config_pkg` SET `F_app_msm_template`='{"valid":"template2","orderNotice":"template3","orderShipment":"template4"}' WHERE  `F_pkg`='webdream';