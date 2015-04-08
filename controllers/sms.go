package controllers

import (
	"dream_api_web_v1/models"
//	"github.com/astaxie/beego"
//	"net/http"
	"dream_api_web_v1/helper"
	//"fmt"
	//"strings"
)

//短信(每个用户短信发送限制为1分钟的一次)
type SmsController struct {
	BaseController
}

// @Title 短信验证码验证
// @Description 短信验证码验证(token: md5(pkg))
// @Param	mobilePhoneNumber	path	string	true	手机号码
// @Param	num					form	string	true	验证码
// @Param	sign				header	string	false	签名(暂时不用)
// @Param	pkg					header	string	true	包名(值暂时为：webdream)
// @Success	200 {object} models.MResp
// @Failure 401 无权访问
// @router /valid/:mobilePhoneNumber [post]
func (u *SmsController) Smsvalid() {
	//log
	u.logRequest()
	//ini return
	datas := map[string]interface{}{"responseNo": -1}
	//model ini
	var smsObj *models.MSms
	var pkgObj *models.MPkg
	//parse request parames
	u.Ctx.Request.ParseForm()
	mobilePhoneNumber := u.Ctx.Input.Param(":mobilePhoneNumber")
	num := u.Ctx.Request.FormValue("num")
	pkg := u.Ctx.Request.Header.Get("Pkg")
	//check sign
	datas["responseNo"] = u.checkSign()
	//check white ip
	if datas["responseNo"] == 0{
		if !u.checkIp(){
			datas["responseNo"] = -1
		}
	}
	//检查参数
	if datas["responseNo"] == 0 && helper.CheckMPhoneValid(mobilePhoneNumber) && len(num) > 0 {
		datas["responseNo"] = -1
		pkgConfig := pkgObj.GetPkgConfig(pkg)
		if len(pkgConfig) > 0{
			res := smsObj.ValidMsm(pkg,num,mobilePhoneNumber,pkgConfig["F_app_id"],pkgConfig["F_app_key"])
			if len(res) == 0{
				datas["responseNo"] = 0
				smsObj.AddMsmActionvalid(mobilePhoneNumber,pkg,num)
			}
		}
	}else if datas["responseNo"] == 0{
		datas["responseNo"] = -1
	}
	//return
	u.jsonEcho(datas)
}

// @Title 发送一条短信验证码
// @Description 发送一条短信验证码(token: md5(pkg))
// @Param	mobilePhoneNumber	path	string	true	手机号码
// @Param	sign			header	string	false	签名(暂时不用)
// @Param	pkg			header	string	true	包名(值暂时为：webdream)
// @Success	200 {object} models.MResp
// @Failure 401 无权访问
// @router /:mobilePhoneNumber [get]
func (u *SmsController) GetSms() {
	//log
	u.logRequest()
	//ini return
	datas := map[string]interface{}{"responseNo": -1}
	//model ini
	var smsObj *models.MSms
	var pkgObj *models.MPkg
	//parse request parames
	u.Ctx.Request.ParseForm()
	mobilePhoneNumber := u.Ctx.Input.Param(":mobilePhoneNumber")
	pkg := u.Ctx.Request.Header.Get("Pkg")
	//check sign
	datas["responseNo"] = u.checkSign()
	//check white ip
	if datas["responseNo"] == 0{
		if !u.checkIp(){
			datas["responseNo"] = -1
		}
	}
	//检查参数
	if datas["responseNo"] == 0 && helper.CheckMPhoneValid(mobilePhoneNumber) {
		datas["responseNo"] = -1
		pkgConfig := pkgObj.GetPkgConfig(pkg)
		if len(pkgConfig) > 0 && smsObj.CheckMsmRateValid(mobilePhoneNumber,pkg){
			smsObj.AddMsmRate(mobilePhoneNumber,pkg)
			res := smsObj.GetMsm(mobilePhoneNumber,pkgConfig["F_app_id"],pkgConfig["F_app_key"],pkgConfig["F_app_name"],pkgConfig["F_app_msm_template"],pkg)
			if len(res) == 0{
				datas["responseNo"] = 0
				smsObj.AddMsmRate(mobilePhoneNumber,pkg)
			}else{
				smsObj.DeleteMsmRate(mobilePhoneNumber,pkg)
			}
		}
	}else if datas["responseNo"] == 0{
		datas["responseNo"] = -1
	}

	//return
	u.jsonEcho(datas)
}

// @Title 发送一条短信通知
// @Description 发送一条短信通知(token: md5(pkg))
// @Param	mobilePhoneNumber	path	string	true	手机号码
// @Param	orderNum			query	string	false	订单号码
// @Param	smsTemplate			query	string	false	短信模板名称(订单通知:orderNotice)
// @Param	sign				header	string	false	签名(暂时不用)
// @Param	pkg					header	string	true	包名(值暂时为：webdream)
// @Success	200 {object} models.MResp
// @Failure 401 无权访问
// @router /notice/:mobilePhoneNumber [get]
func (u *SmsController) GetNoticeSms() {
	//log
	u.logRequest()
	//ini return
	datas := map[string]interface{}{"responseNo": -1}
	//model ini
	var smsObj *models.MSms
	var pkgObj *models.MPkg
	//parse request parames
	u.Ctx.Request.ParseForm()
	mobilePhoneNumber := u.Ctx.Input.Param(":mobilePhoneNumber")
	pkg := u.Ctx.Request.Header.Get("Pkg")
	smsTemplate := u.Ctx.Request.FormValue("smsTemplate")
	//check sign
	datas["responseNo"] = u.checkSign()
	//check white ip
	if datas["responseNo"] == 0{
		if !u.checkIp(){
			datas["responseNo"] = -1
		}
	}
	//检查参数
	if datas["responseNo"] == 0 && helper.CheckMPhoneValid(mobilePhoneNumber) {
		datas["responseNo"] = -1
		//判断模板
		switch smsTemplate{
			case "orderNotice":	//订单通知
				template := "template3"
				orderNum := u.Ctx.Request.FormValue("orderNum")
				if len(orderNum) > 0{
					pkgConfig := pkgObj.GetPkgConfig(pkg)
					if len(pkgConfig) > 0 && smsObj.CheckMsmRateValid(mobilePhoneNumber,pkg){
						smsObj.AddMsmRate(mobilePhoneNumber,pkg)
						res := smsObj.GetOrderMsm(mobilePhoneNumber,pkgConfig["F_app_id"],pkgConfig["F_app_key"],pkgConfig["F_app_name"],template,pkg,orderNum)
						if len(res) == 0{
							datas["responseNo"] = 0
							smsObj.AddMsmRate(mobilePhoneNumber,pkg)
							smsObj.AddOrderMsm(orderNum,mobilePhoneNumber,pkg)
						}else{
							smsObj.DeleteMsmRate(mobilePhoneNumber,pkg)
						}
					}
				}
		}
	}else if datas["responseNo"] == 0 {
		datas["responseNo"] = -1
	}

	//return
	u.jsonEcho(datas)
}

//检查ip是否存在于白名单中
func (u *SmsController) checkIp()bool {
//	var smsObj *models.MSms
//	return smsObj.CheckWhiteIp(u.Ctx.Input.IP())
	return true
}