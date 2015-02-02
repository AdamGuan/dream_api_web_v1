package docs

import (
	"encoding/json"
	"strings"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/swagger"
)

const (
    Rootinfo string = `{"apiVersion":"1","swaggerVersion":"1.2","apis":[{"path":"/sms","description":"短信(每个用户短信发送限制为1分钟的一次)\n"}],"info":{"title":"用户系统 API v1"}}`
    Subapi string = `{"/sms":{"apiVersion":"1","swaggerVersion":"1.2","basePath":"","resourcePath":"/sms","produces":["application/json","application/xml","text/plain","text/html"],"apis":[{"path":"/valid/:mobilePhoneNumber","description":"","operations":[{"httpMethod":"POST","nickname":"短信验证码验证","type":"","summary":"短信验证码验证(token: md5(pkg))","parameters":[{"paramType":"path","name":"mobilePhoneNumber","description":"手机号码","dataType":"string","type":"","format":"","allowMultiple":false,"required":true,"minimum":0,"maximum":0},{"paramType":"form","name":"num","description":"验证码","dataType":"string","type":"","format":"","allowMultiple":false,"required":true,"minimum":0,"maximum":0},{"paramType":"header","name":"sign","description":"签名(暂时不用)","dataType":"string","type":"","format":"","allowMultiple":false,"required":false,"minimum":0,"maximum":0},{"paramType":"header","name":"pkg","description":"包名(值暂时为：webdream)","dataType":"string","type":"","format":"","allowMultiple":false,"required":true,"minimum":0,"maximum":0}],"responseMessages":[{"code":200,"message":"models.MResp","responseModel":"MResp"},{"code":401,"message":"无权访问","responseModel":""}]}]},{"path":"/:mobilePhoneNumber","description":"","operations":[{"httpMethod":"GET","nickname":"发送一条短信验证码","type":"","summary":"发送一条短信验证码(token: md5(pkg))","parameters":[{"paramType":"path","name":"mobilePhoneNumber","description":"手机号码","dataType":"string","type":"","format":"","allowMultiple":false,"required":true,"minimum":0,"maximum":0},{"paramType":"header","name":"sign","description":"签名(暂时不用)","dataType":"string","type":"","format":"","allowMultiple":false,"required":false,"minimum":0,"maximum":0},{"paramType":"header","name":"pkg","description":"包名(值暂时为：webdream)","dataType":"string","type":"","format":"","allowMultiple":false,"required":true,"minimum":0,"maximum":0}],"responseMessages":[{"code":200,"message":"models.MResp","responseModel":"MResp"},{"code":401,"message":"无权访问","responseModel":""}]}]}],"models":{"MResp":{"id":"MResp","properties":{"responseMsg":{"type":"string","description":"","format":""},"responseNo":{"type":"int","description":"","format":""}}}}}}`
    BasePath string= "/v1"
)

var rootapi swagger.ResourceListing
var apilist map[string]*swagger.ApiDeclaration

func init() {
	err := json.Unmarshal([]byte(Rootinfo), &rootapi)
	if err != nil {
		beego.Error(err)
	}
	err = json.Unmarshal([]byte(Subapi), &apilist)
	if err != nil {
		beego.Error(err)
	}
	beego.GlobalDocApi["Root"] = rootapi
	for k, v := range apilist {
		for i, a := range v.Apis {
			a.Path = urlReplace(k + a.Path)
			v.Apis[i] = a
		}
		v.BasePath = BasePath
		beego.GlobalDocApi[strings.Trim(k, "/")] = v
	}
}


func urlReplace(src string) string {
	pt := strings.Split(src, "/")
	for i, p := range pt {
		if len(p) > 0 {
			if p[0] == ':' {
				pt[i] = "{" + p[1:] + "}"
			} else if p[0] == '?' && p[1] == ':' {
				pt[i] = "{" + p[2:] + "}"
			}
		}
	}
	return strings.Join(pt, "/")
}
