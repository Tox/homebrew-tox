require "formula"

class Qtox < Formula
  homepage "https://github.com/qTox/qTox"
  head "git://github.com/qTox/qTox", :using => :git
  
  depends_on "Tox/tox/libtoxcore"
  depends_on "qt5"
  depends_on "ffmpeg"
  depends_on "openal-soft"
  depends_on "Tox/tox/libfilteraudio"
  depends_on "qrencode"
  depends_on "sqlcipher"

  def install
    mkdir "libs"
    FileUtils.ln_s "/usr/local/lib/", "libs/lib"
    FileUtils.ln_s "/usr/local/include/", "libs/include"
    
    system "qmake"
    system "make"

    prefix.install "qtox.app"
  end
end
