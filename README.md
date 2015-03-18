Homebrew formulae to install Tox.  

**Tap it**:

    brew tap Tox/tox

**Install core**:

    brew install --HEAD libtoxcore

**Install toxic**:

    brew install --HEAD toxic

*Supported flags in libtoxcore*:

- `--without-av`
- `--with-daemon` (builds the DHT bootstrap daemon)

*Supported flags in toxic*:

- `--without-audio` (you must specify this if libtoxcore was installed with `--without-av`)

**Note**:
The formulae to install libfilteraudio and qTox were written by [ReDetection](https://github.com/ReDetection) in [ReDetection/homebrew-qtox.](https://github.com/ReDetection/homebrew-qtox)