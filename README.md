# Dic

[![Build History][2]][1]

[1]: http://travis-ci.org/tracksun/di
[2]: https://secure.travis-ci.org/tracksun/di.png?branch=master

Simple Dependency injection container


### Example

    require 'dic'

    class MyDic < Dic
      def initialize
        super
        # set name to 'Thomas'
        name 'Thomas'

        # use proc to computer values lazily
        answer { long_computation() }

        # properties can be defined in any order
        upfoo { foo.upcase }
        foo { 'bar' }

        # you can use #set
        set answer, 42
      end
    end

    mc = MyDic.new
    mc.foo    # => 'bar'
    mc[:foo] # => 'bar'
