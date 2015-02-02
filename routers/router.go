// @APIVersion 1
// @Title 用户系统 API v1
package routers

import (
	"dream_api_web_v1/controllers"

	"github.com/astaxie/beego"
)

func init() {
	ns := beego.NewNamespace("/v1",
		beego.NSNamespace("/sms",
			beego.NSInclude(
				&controllers.SmsController{},
			),
		),
	)
	beego.AddNamespace(ns)
}
