package routers

import (
	"github.com/astaxie/beego"
)

func init() {
	
	beego.GlobalControllerRouter["dream_api_web_v1/controllers:SmsController"] = append(beego.GlobalControllerRouter["dream_api_web_v1/controllers:SmsController"],
		beego.ControllerComments{
			"Smsvalid",
			`/valid/:mobilePhoneNumber`,
			[]string{"post"},
			nil})

	beego.GlobalControllerRouter["dream_api_web_v1/controllers:SmsController"] = append(beego.GlobalControllerRouter["dream_api_web_v1/controllers:SmsController"],
		beego.ControllerComments{
			"GetSms",
			`/:mobilePhoneNumber`,
			[]string{"get"},
			nil})

}
