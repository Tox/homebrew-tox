class Qtox < Formula
  desc "The most feature-rich Tox client; P2P instant messaging, audio & video calls"
  homepage "https://qtox.github.io/"
  head "git://github.com/qTox/qTox"

  option "with-static", "Static build, allows you to run the app without having Qt installed"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "Tox/tox/libfilteraudio"
  depends_on "Tox/tox/libtoxcore"
  depends_on "libexif"
  depends_on "openal-soft"
  depends_on "ffmpeg"
  depends_on "qrencode"
  depends_on "qt"
  depends_on "sqlcipher"

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    if build.with? "static"
      system "macdeployqt", "./qTox.app"
    end
    prefix.install "qtox.app"
  end

  def caveats
    <<~EOF
      To find the app run `open $(brew --prefix)/Cellar/qtox/`
    EOF
  end
end
