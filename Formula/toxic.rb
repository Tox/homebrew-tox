require 'formula'

class Toxic < Formula
  head "git://github.com/Tox/toxic", :using => :git
  homepage "https://tox.im"

  depends_on "libtoxcore"
  depends_on "homebrew/dupes/ncurses"
  depends_on "freealut"
  depends_on "libconfig"

  option "without-audio", "Build toxic without audio call support"

  def install
    Dir.chdir("build")
    cflags = ["-DPACKAGE_DATADIR=\\\"/usr/local/Cellar/toxic/HEAD/share/toxic/\\\"", "-I/usr/local/opt/ncurses/include", "-I/usr/local/include", "-g"]
    ldflags = ["-L/usr/local/lib", "-L/usr/local/opt/ncurses/lib", "-lncursesw", "-ltoxcore", "-ltoxdns", "-lresolv", "-lalut", "-lconfig", "-ltoxencryptsave", "-g"]

    unless build.without? "audio"
      cflags.push "-framework OpenAL"
      ldflags.push "-ltoxav"
    end

    ENV["USER_CFLAGS"] = cflags.join " "
    ENV["USER_LDFLAGS"] = ldflags.join " "

    system "make", "PREFIX='#{prefix}'", "DISABLE_DESKTOP_NOTIFY=YES", "DISABLE_X11=YES"
    system "make", "install", "PREFIX='#{prefix}'", "DISABLE_DESKTOP_NOTIFY=YES", "DISABLE_X11=YES"
  end

  def caveats
    <<-EOF.undent
    toxic is a command-line application. For a GUI, try uTox:
      brew install --HEAD utox
    EOF
  end
end
