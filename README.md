# Cache-translate
Package for translating text, made during the hackathon in Czech Republic 2.02-3.02

# Usage

After importing classes inside src directory, execute the following inside terminal
(This example shows how to translate from English to Russian):
```
set tr = ##class(TRL.Translator).Translate("en","ru","Some text")
w tr
Здравствуйте!
```

If you have your own key to use Yandex Translate API, write it as fourth parameter in method Translate()
```
set APIKey = "trnsl.1.1.20170201T221936Z.49cebd838c47a0a3.0c13eb7fa04797d9c5b7b784de147213e57fc6a0"
set tr = ##class(TRL.Translator).Translate("en","ru","Some text", APIKey)
w tr
Здравствуйте!
```
