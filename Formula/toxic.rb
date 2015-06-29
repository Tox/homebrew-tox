require 'formula'

class Toxic < Formula
  head "git://github.com/Tox/toxic", :using => :git
  homepage "https://tox.chat"

  depends_on "libtoxcore"
  depends_on "homebrew/dupes/ncurses"
  depends_on "freealut"
  depends_on "libconfig"
  depends_on "pkg-config" => :build

  option "without-audio", "Build toxic without audio call support"

  def install
    ENV.append "CFLAGS", "-DPACKAGE_DATADIR=\\\"#{prefix}/share/toxic\\\""
    ENV.append "CFLAGS", "-g"
    ENV.append "LDFLAGS", "-lncursesw -ltoxcore -ltoxdns -lresolv -lalut"
    ENV.append "LDFLAGS", "-lconfig -ltoxencryptsave -g"

    if build.with? "audio"
      ENV.append "CFLAGS", "-framework OpenAL"
      ENV.append "LDFLAGS", "-ltoxav"
    end

    ENV["USER_CFLAGS"] = ENV["CFLAGS"]
    ENV["USER_LDFLAGS"] = ENV["LDFLAGS"]

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
