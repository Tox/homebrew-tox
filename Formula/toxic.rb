require 'formula'

class Toxic < Formula
  head "git://github.com/Tox/toxic", :using => :git
  homepage "http://tox.im"

  depends_on "libsodium"
  depends_on "libtoxcore"
  depends_on "autoconf"
  depends_on "automake"
  depends_on "libtoxcore"
  
  def install
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
