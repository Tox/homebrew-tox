class Toxic < Formula
  desc "An ncurses-based Tox client"
  homepage "https://tox.chat"
  head "git://github.com/Tox/toxic"

  depends_on "pkg-config" => :build
  depends_on "freealut"
  depends_on "libconfig"
  depends_on "libtoxcore"
  depends_on "ncurses"
  depends_on "qrencode"

  def hacks
    # openal-soft doesn't seem to work so we will use apple's openal
    pc = <<~EOF
      Name: openal
      Description: This is a dummy file to help toxic find Apple's OpenAL framework.
      Version: 0.0.0
      Libs: -framework OpenAL
      Cflags: -framework OpenAL
    EOF

    Dir.mkdir(File.join(Dir.pwd, "_hacks"))
    File.write(File.join(Dir.pwd, "_hacks", "openal.pc"), pc)
  end

  def install
    hacks

    orig_pkg_config_path = ENV["PKG_CONFIG_PATH"]
    ENV["PKG_CONFIG_PATH"] = "#{Dir.pwd}/_hacks:#{orig_pkg_config_path}"

    ENV.append "CFLAGS", "-DPACKAGE_DATADIR=\\\"#{prefix}/share/toxic\\\""

    ENV["USER_CFLAGS"] = ENV["CFLAGS"]
    ENV["USER_LDFLAGS"] = ENV["LDFLAGS"]

    system "make", "PREFIX='#{prefix}'", "DISABLE_DESKTOP_NOTIFY=YES", "DISABLE_X11=YES"
    system "make", "install", "PREFIX='#{prefix}'", "DISABLE_DESKTOP_NOTIFY=YES", "DISABLE_X11=YES"
  end

  def caveats
    <<~EOF
      toxic is a command-line application. For a GUI, try uTox or qTox:
        brew install --HEAD utox
        brew install --HEAD qtox
    EOF
  end
end
