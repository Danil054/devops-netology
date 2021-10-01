* 1. 
  полный хэш: aefead2207ef7e2aa5dc81a34aedf0cad4c32545
  Комментарий: Update CHANGELOG.md
  Получили командой: git show aefea

* 2.
  Тэг: v0.12.23
  Получили командой: git show 85024d3

* 3.
  Два родителя:
  56cd7859e05c36c06b56d013b55a252d0bb7e158
  9ea88f22fc6269854151c571162c5bcf958bee2b
  
  в git show b8d720 видно, что это мердж коммит (Merge: 56cd7859e 9ea88f22f)
  так же при переходе на этот коммит: git checkout b8d720
  и выполнив: git log --pretty=format:'%H %P' -1 видно, что у него два родителя и их хэши

* 4.
  33ff1c03bb960b332be3af2e333462dde88b279e - v0.12.24
  b14b74c4939dcab573326f4e3ee2a62e23e12f89 - [Website] vmc provider links
  3f235065b9347a758efadc92295b540ee0a5e26e - Update CHANGELOG.md
  6ae64e247b332925b872447e9ce869657281c2bf - registry: Fix panic when server is unreachable
  5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 - website: Remove links to the getting started guide's old location
  06275647e2b53d97d4f0a19a0fec11f6d69820b5 - Update CHANGELOG.md
  d5f9411f5108260320064349b757f55c09bc4b80 - command: Fix bug when using terraform login on Windows
  4b6d06cc5dcb78af637bbb19c198faff37a066ed - Update CHANGELOG.md
  dd01a35078f040ca984cdd349f18d0b67e486c35 - Update CHANGELOG.md
  225466bc3e5f35baa5d07197bbc079345b77525e - Cleanup after v0.12.23 release
  
  командой: git log --pretty=format:'%H - %s' v0.12.23..v0.12.24

* 5. Коммит с хэшем: 8c928e83589d90a031f811fae52a81be7153e82f
  Нашли хэши командой : git log -S 'func providerSource' --oneline
  Потом git show хэш проанализировали изменения , в котором и видно объявление функции:
   func providerSource(services *disco.Disco) getproviders.Source {
       // We're not yet using the CLI config here because we've not implemented
   ....

* 6.
  78b12205587fe839f10d946ea3fdc06719decb05
  52dbf94834cb970b510f2fba853a5b49ad9b1a46
  41ab0aef7a0fe030e84018973a64135b11abcd70
  66ebff90cdfaa6938f26f908c7ebad8d547fea17
  8364383c359a6b738a436d1b7745ccdce178df47
  
  Командой git grep 'func globalPluginDirs' нашли в каком файле функция объявлена была.
  Потом командой: git log -L :globalPluginDirs:plugins.go нашли коммиты и сделанные изменения в ней.

* 7.
  Martin Atkins <mart@degeneration.co.uk>
  Командой git log -S 'func synchronizedWriters' --oneline нашли коммиты
  После посмотрели их git show
