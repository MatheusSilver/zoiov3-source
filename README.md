## Discord:
https://discord.gg/rQpcpHpW88

## Compilação
Fique avisado que isso é nescessário só caso você utilizar a Source Code do game.
Você precisará de pelo menos **8 gigas livres no seu PC.**
1. [Instale o Haxe 4.1.5](https://haxe.org/download/version/4.1.5/)
2. [Instale HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)
----------------------------------------------------------------------------------------

Após isso, você vai precisar instalar algumas coisas individuais para a Build de Friday Night Funkin'.
Exemplo, dentro do "Project.xml", existem outras libs, como o flixel, e entre outros mil em um milhão.
```
flixel
flixel-addons
flixel-ui
hscript
newgrounds
```
Para instalar as extensões você precisará de algum terminal do Windows, como o Prompt de Comando, ou o Windows Powershell.
Utilize este comando de acordo com a lib:
`haxelib install [O nome da sua lib aqui]` 
Exemplo:
`haxelib install newgrounds`.

Instale as seguintes libs e extensões:
```
* haxelib install lime 7.9.0
* haxelib install openfl
* haxelib install flixel
* haxelib install flixel-tools
* haxelib install flixel-ui
* haxelib install hscript
* haxelib install flixel-addons
* haxelib install actuate
* haxelib install hxCodec
* haxelib run lime setup
* haxelib run lime setup flixel
* haxelib run flixel-tools setup
* haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
* haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
* haxelib git faxe https://github.com/uhrobots/faxe
* haxelib git polymod https://github.com/MasterEric/polymod.git
* haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
* haxelib git extension-webm https://github.com/KadeDev/extension-webm
```
Depois de instalar a extension-webm, será preciso um comando:
**lime rebuild extension-webm windows** (ou seu sistema operacional)


## Outras coisas que você precisa (para Windows):
Após tudo isso, você ainda precisará de 5GBS ou mais livres no seu HD ou SSD.
Será preciso instalar os seguintes componentes:
--
MSVC v142 - VS 2019 C++ x64/x86 build tools
Windows SDK (10.0.17763.0)

Para instalar o MSVC V142, você irá precisar do [Visual Studio 2019](https://drive.google.com/file/d/1_SebhNRvw5lpERz0R79P6zO5edllM7EJ/view?usp=sharing)
Recomendo utilizar um tutorial de instalação dessa coisinha, por conta de que é complicado explicar aqui por texto.

Para instalar o [Windows SDK](https://go.microsoft.com/fwlink/p/?LinkID=2033686), você precisará instalar por um link da Microsoft, já que ele não está disponivel no Visual Studio 2019. 
Depois de baixar o arquivo .iso, abra com o Winrar ou com um montador de ISOS.
Instale o componente com o arquivo "WinSDKSetup.exe".

Após instalar tudo, você já pode tentar compilar o FNF'.
`lime build windows`

## Na source
Se você não quer scripts em .lua, entre em Project.xml e apague a linha "LUA_ALLOWED" 
