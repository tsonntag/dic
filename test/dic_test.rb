# encoding: UTF-8
$:.unshift File.expand_path( '../lib/', File.dirname( __FILE__))

require 'minitest/autorun'
require 'dic'

class DicTest < MiniTest::Unit::TestCase

  class MyDic < Dic
    def initialize
      super

      foo 'bar'
      once { @once||=0; @once=+1 }
      name { 'Thomas' }
      upfoo { foo.upcase }

      circle1 { circle2 }
      circle2 { circle1 }
    end
  end

  def test_dic
    dic = MyDic.new
    assert_equal 'bar', dic.foo
    assert_equal 'bar', dic[:foo]
  end

  def test_once
    dic = MyDic.new
    assert_equal 1, dic.once
    assert_equal 1, dic.once
  end

  def test_circular
    assert_raises DicError do
      dic = MyDic.new
      dic.circle1
    end
  end
end
