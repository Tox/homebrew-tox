require 'formula'

class Utox < Formula
  head "git://github.com/GrayHatter/uTox", :using => :git, :branch => "develop"
  homepage "https://tox.chat"

  depends_on "libtoxcore"
  depends_on "pkg-config" => :build
  depends_on "libfilteraudio"

  def install
    system "make", "-f", "src/cocoa/Makefile", "uTox.app"
    prefix.install "uTox.app"
  end
end
