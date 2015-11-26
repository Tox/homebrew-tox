Homebrew formulae to install Tox.  

**Tap it**:

    brew tap Tox/tox

**Install [core](https://github.com/irungentoo/toxcore)**:

    brew install --HEAD libtoxcore

*Supported flags in libtoxcore*:

- `--without-av`
- `--with-daemon` (builds the DHT bootstrap daemon)

**Install [toxic](https://github.com/JFreegman/toxic)**:

    brew install --HEAD toxic

**Install [uTox](https://github.com/grayhatter/uTox)**:

    brew install --HEAD utox

**Install [qTox](https://github.com/tux3/qTox)**:

    brew install --HEAD qtox

Note that qTox requires qt5 which can take a very long time to compile. You might want to install it from bottle:

    brew install qt5
    brew install --HEAD qtox
