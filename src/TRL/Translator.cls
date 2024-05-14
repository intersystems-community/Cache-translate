Class TRL.Translator
{

Parameter SSLConfigName = "TranslatorSSL";

ClassMethod Translate(inputLang As %String, outputLang As %String, text As %String, APIKey As %String = "trnsl.1.1.20170201T221936Z.49cebd838c47a0a3.0c13eb7fa04797d9c5b7b784de147213e57fc6a0")
{
	set format = "plain"
	set url = "key=" _ APIKey _ "&lang=" _ inputLang _ "-" _ outputLang _ "&format=" _ format
	set string = ..GetText(url, text)	
	return string
}

ClassMethod GetText(url As %String, text As %String) As %String
{
	set flag = 0 
    set request = ##class(%Net.HttpRequest).%New() 
    set request.Https = 1
    set request.SSLConfiguration = ..GetSSLConfigurationName()
    Set request.Server= "translate.yandex.net"
	Set request.Port= 443
	if ($listvalid(text) = 1){
		set flag = 1 
		for i=1:1:$listlength(text){
			do request.InsertFormData("text", $listGet(text, i))	
		}
	}
	else { do request.InsertFormData("text", text) }
    Do request.Post("/api/v1.5/tr.json/translate?" _url)
    set data = request.HttpResponse.Data
    do ##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(data, , .obj, 1)
    if (flag = 1){
	    set n = obj.text.Count()
	    set list = $LB()
	    for i=1:1:n {
		    set $list(list, i)=obj.text.GetAt(i)
		}
	    return list
	}
    return obj.text.GetAt(1)
}

ClassMethod GetSSLConfigurationName() As %String
{
    new $namespace
    zn "%SYS"
    if ('##class(Security.SSLConfigs).Exists(..#SSLConfigName)) {
        set st = ##class(Security.SSLConfigs).Create(..#SSLConfigName)
        return:(st '= 1) "UnableToCreateSSLConfig:"_$System.Status.GetErrorText(st)
    }
    return ..#SSLConfigName
}

}
