class Utox < Formula
  desc "µTox the lightest and fluffiest Tox client"
  homepage "https://tox.chat"
  head "https://github.com/uTox/uTox", :branch => "develop"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libfilteraudio"
  depends_on "libtoxcore"

  def install
    mkdir "build" do
      args = []
      system "cmake", "..", *args, *std_cmake_args
      system "make"
      prefix.install "utox.app"
    end
  end

  def caveats
    <<~EOF
      To find the app run `open $(brew --prefix)/Cellar/utox/`
    EOF
  end
end
