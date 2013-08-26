require 'formula'

class Libtoxcore < Formula
  head "git://github.com/irungentoo/ProjectTox-Core", :using => :git
  homepage "http://tox.im"

  depends_on "libsodium"
  depends_on "autoconf"
  depends_on "automake"
  depends_on "libconfig"
  depends_on "libtool"
  depends_on "check"
  depends_on "pkg-config"

  option "without-dht-bootstrap", "Install the DHT bootstrap server."
  option "without-ntox", "Don't install the nTox test client."

  def install
    args = ["--prefix=#{prefix}",]
    args << "--disable-ntox" if build.include? "without-ntox"
    # FIXME bootstrap never gets built, no idea why
    args << "--disable-dht-bootstrap-daemon" if build.include? "without-dht-bootstrap"
    
    system "autoreconf", "-i"
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end