Homebrew formulae to install Tox.  

**Tap it**:

    brew tap Tox/tox

**Install core**:

    brew install --HEAD libtoxcore

*Supported flags in libtoxcore*:

- `--without-av`
- `--with-daemon` (builds the DHT bootstrap daemon)

**Install toxic**:

    brew install --HEAD toxic

*Supported flags in toxic*:

- `--without-audio` (you must specify this if libtoxcore was installed with `--without-av`)

**Install qTox**:

    brew install --HEAD qtox

Note that qTox requires qt5 which can take a very long time to compile. You might want to install it from bottle:

    brew install qt5
    brew install --HEAD qtox
