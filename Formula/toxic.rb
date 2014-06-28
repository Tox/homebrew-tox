require 'formula'

class Toxic < Formula
  head "git://github.com/Tox/toxic", :using => :git
  homepage "https://tox.im"

  depends_on "libtoxcore"
  depends_on "ncurses"
  
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  
  option "without-audio", "Build toxic without audio call support"
  
  def install
    Dir.chdir("build")
    cflags = ["-DPACKAGE_DATADIR=\\\"/usr/local/Cellar/toxic/HEAD/share/toxic/\\\""]
    ldflags = ["-L/usr/local/lib", "-lncursesw", "-ltoxcore", "-ltoxdns", "-lresolv"]
    
    unless build.without? "audio"
      cflags.push "-framework OpenAL"
      ldflags.push "-ltoxav"
    end
    
    ENV["USER_CFLAGS"] = cflags.join " "
    ENV["USER_LDFLAGS"] = ldflags.join " "

    system "make", "PREFIX='#{prefix}'"
    system "make", "install", "PREFIX='#{prefix}'"
  end
end
