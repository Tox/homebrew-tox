class LibtoxcoreAT01 < Formula
  desc "Tox library written in C"
  homepage "https://tox.chat"
  url "https://github.com/TokTok/c-toxcore.git",
    :tag => "v0.1.11",
    :revision => "fc0cc08b2115d037551369f69519e95e841643aa"

  option "without-av", "Compile without A/V support"
  option "with-daemon", "Builds the bootstrap server daemon"
  option "without-shared", "Build shared (dynamic) libraries for all modules"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  if build.with? "daemon"
    depends_on "libconfig"
  end
  depends_on "libsodium"

  unless build.without? "av"
    depends_on "libconfig"
    depends_on "opus"
    depends_on "libvpx"
  end

  def install
    args = []
    unless build.with? "daemon"
      args << "-DDHT_BOOTSTRAP=OFF"
    end
    if build.without? "av"
      args << "-DBUILD_TOXAV=OFF"
    end
    if build.without? "shared"
      args << "-DENABLE_SHARED=OFF"
    end

    ENV["LDFLAGS"] = "-mmacosx-version-min=10.6"
    ENV["CFLAGS"] = "-mmacosx-version-min=10.6"
    
    system "mkdir _build"
    chdir "_build" do
      system "cmake ..", *args, *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <tox/tox.h>

      int main()
      {
        TOX_ERR_NEW err_new;
        Tox *tox = tox_new(NULL, &err_new);
        assert(err_new == TOX_ERR_NEW_OK);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-ltoxcore", "-o", "test"
    system "./test"
  end

  def caveats
    <<~EOF
      libtoxcore has no UI. If you want to make use of it, try Toxic for a CLI:
        brew install --HEAD toxic
      or uTox for a GUI (X11):
        brew install --HEAD utox
      or qTox for a GUI (Qt):
        brew install --HEAD qtox
    EOF
  end
end
