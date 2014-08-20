require "formula"

class Qtox < Formula
  homepage "https://github.com/tux3/qTox"
  head "git://github.com/tux3/qTox", :using => :git
  
  depends_on "libtoxcore"
  depends_on "qt5"

  def install
    mkdir "libs"
    FileUtils.ln_s "/usr/local/lib/", "libs/lib"
    FileUtils.ln_s "/usr/local/include/", "libs/include"
    
    system "qmake"
    system "make"

    prefix.install "qtox.app"
  end
end
