Word Chainer
============

This is one of the problems from [Ruby Quiz](http://web.archive.org/web/20130215052516/http://rubyquiz.com/quiz44.html). This command line program will take a word and display a path of words to another word (provided they are of the same length).

For example, running

```shell
ruby word_chainer.rb puppy kitty
```

will result in the following output:

```shell
puppy
pappy
happy
harpy
harry
parry
party
patty
batty
bitty
kitty
```

The program takes command line arguments, as can be seen above. If given no arguments, it defaults to `puppy` and `kitty`.

This program was written while I was attending [App Academy](http://www.appacademy.io), where I received a lot of guidance on this particular program.


