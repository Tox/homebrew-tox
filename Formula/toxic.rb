require 'formula'

class Toxic < Formula
  head "git://github.com/Tox/toxic", :using => :git
  homepage "https://tox.im"

  depends_on "libsodium"
  depends_on "libtoxcore"
  depends_on "autoconf"
  depends_on "automake"
  
  def install
    system "cd build"
    system "make", "PREFIX='#{prefix}'"
    system "make install", "PREFIX='#{prefix}'"
  end
end
