class Toxic < Formula
  desc "An ncurses-based Tox client"
  homepage "https://tox.chat"
  head "https://github.com/Tox/toxic"

  option "with-notifications", "Build with desktop notifications"

  depends_on "pkg-config" => :build
  depends_on "freealut"
  depends_on "libconfig"
  depends_on "libtoxcore"
  depends_on "ncurses"
  depends_on "qrencode"
  depends_on "libpng"
  depends_on "curl"
  depends_on "openal-soft"
  depends_on "python" => :optional

  if build.with? "notifications"
    depends_on "libnotify"
  end

  def install
    args = []
    args << "PREFIX='#{prefix}'"
    args << "DISABLE_X11=YES"

    unless build.with? "notifications"
      args << "DISABLE_DESKTOP_NOTIFY=YES"
    end

    if build.with? "python"
      args << "ENABLE_PYTHON=YES"
    end

    ENV.append "CFLAGS", "-DPACKAGE_DATADIR=\\\"#{share}\\\""

    ENV["USER_CFLAGS"] = ENV["CFLAGS"]
    ENV["USER_LDFLAGS"] = ENV["LDFLAGS"]

    system "make", *args
    system "make", "install", *args
  end

  def caveats
    <<~EOF
      toxic is a command-line application. For a GUI, try uTox or qTox:
        brew install --HEAD utox
        brew install --HEAD qtox
    EOF
  end
end
