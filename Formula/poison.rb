require 'formula'

class Poison < Formula
  homepage "https://github.com/stal888/Poison"
  url "https://kirara.ca/homebrew/poison-1.1.0plus.tar.gz"
  sha1 "7a97cf6f6e5423ff551565b6f44a0efb16524598"
  
  head 'https://github.com/stal888/Poison.git', :branch => 'master'

  option "with-silica", "Installs Silica for editing chat themes."
  option "with-inspectox", "Installs Inspectox for chacking DHT node connectivity."
  option "with-genki", "Installs genki for [slowly] bruteforcing custom public keys."
  option "with-kud-tool", "Installs kudryavka for manipulating Poison key files."

  depends_on :xcode
  depends_on "libsodium"

  def install
    if build.head?
      # Homebrew's normal git setup doesn't go deep enough. We submodule in DeepEnd, which submodules in ProjectTox-Core...
      # so this is a little hack (also quite inefficient and also doesn't work if core's latest breaks DE).
      # Fix this asap.
      system "git clone git://github.com/irungentoo/ProjectTox-Core.git DeepEnd/ProjectTox-Core"
    end
    # Clean up
    the_build_dir = "#{Dir.pwd}/__build"
    system "xcodebuild -workspace Poison.xcworkspace -scheme Everything -configuration Release clean CONFIGURATION_BUILD_DIR=#{the_build_dir}"
    # build Poison.app
    system "xcodebuild -workspace Poison.xcworkspace -scheme Poison -configuration Release build CONFIGURATION_BUILD_DIR=#{the_build_dir}"
    prefix.install "#{the_build_dir}/Poison.app"

    if build.include? "with-genki"
      system "xcodebuild -workspace Poison.xcworkspace -scheme genki -configuration Release build CONFIGURATION_BUILD_DIR=#{the_build_dir}"
      bin.install "#{the_build_dir}/genki"
    end

    # disabled for now because it doesn't run without the presence of DeepEnd.framework
    #if build.include? "with-kud-tool"
    #  system "xcodebuild -workspace Poison.xcworkspace -scheme KudryavkaTool -configuration Release build CONFIGURATION_BUILD_DIR=#{the_build_dir}"
    #  bin.install "#{the_build_dir}/kudryavka"
    #end

    if build.include? "with-silica"
      system "xcodebuild -workspace Poison.xcworkspace -scheme Silica -configuration Release build CONFIGURATION_BUILD_DIR=#{the_build_dir}"
      prefix.install "#{the_build_dir}/Silica.app"
    end

    if build.include? "with-inspectox"
      system "xcodebuild -workspace Poison.xcworkspace -scheme Inspectox -configuration Release build CONFIGURATION_BUILD_DIR=#{the_build_dir}"
      prefix.install "#{the_build_dir}/Inspectox.app"
    end
  end

  def caveats
    puts <<-EOS.undent
      I installed Poison (and its related utilities, if you wanted) to
          #{prefix}.
      If you chose to install them, genki and kudryavka have also been installed there.

      To link the application(s) to a normal Mac OS X location:
          brew linkapps
      or:
          ln -s #{prefix}/Poison.app ~/Applications
      EOS
    if build.include? "with-silica"
      puts "    ln -s #{prefix}/Silica.app ~/Applications"
    end
    if build.include? "with-inspectox"
      puts "    ln -s #{prefix}/Inspectox.app ~/Applications"
    end
  end
end