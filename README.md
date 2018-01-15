# Konsulta Vortaro

![logo](http://cacilhas.info/misc/vortaro.png)

## Introdução

Konsulta Vortaro foi uma aplicação que criei quando comecei a estudar
[Esperanto](http://esperanto.org.br/info/), lá por volta do ano 2000, para
servir de dicionário *desktop* para meus estudos.

Inicialmente escrevi o código em [Tcl/Tk](http://tcl.tk/). Usava
[SQLite](https://sqlite.org/) para gerenciar as palavras do dicionário, mas
depois percebi que, para o que se propõe a aplicação, um arquivo texto
funcionaria melhor. Foi quando reescrevi em [Python](https://www.python.org/),
removendo o SQLite.

Mais tarde reescrevi em
[Objective-C para GNUstep](http://www.gnustep.org/) e depois finalmente em
[Racket](http://racket-lang.org/), usando
[MrEd Designer](https://docs.racket-lang.org/scheme/mred.html), que é a
[versão oficial atual](https://bitbucket.org/cacilhas/konsulta-vortaro).

## Código

Você encontra o código atualizado
[aqui](https://github.com/cacilhas/vortaro/blob/master/Main.elm).

## Versão *on-line*

Como exercício de
[ML](https://pt.wikipedia.org/wiki/ML_(linguagem_de_programação)), resolvi
escrever uma versão *on-line* do dicionário usando
[Elm](http://elm-lang.org/), um linguagem da família que compila para
Javascript.

O código todo está contido em
[apenas um arquivo](https://github.com/cacilhas/vortaro/blob/master/Main.elm),
divido nas seções definidas pela
[arquitetura Elm](https://guide.elm-lang.org/architecture/).

## Repositórios

- [Versão *desktop*](https://bitbucket.org/cacilhas/konsulta-vortaro)
- [Versão *on-line*](https://github.com/cacilhas/vortaro)

## Autor

[ℜodrigo Arĥimedeς ℳontegasppα ℭacilhας](http://cacilhas.info/montegasppa/author.html)
