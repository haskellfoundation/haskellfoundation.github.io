<p align="center">
<img src="https://haskellfoundation.github.io/static/images/logos/hf-logo-alpha.png" width="400" height="322" alt="Haskell Foundation" title="Haskell Foundation">
</p>

<p>&nbsp;</p>

# The Haskell Foundation Website

This repository is for the [haskell.foundation](https://haskell.foundation) website. It is a proud, Hakyll-based site, built as an in-kind contribution from [Obsidian Systems](https://obsidian.systems), and maintained by the Haskell Foundation and its volunteers. If you would like to get started with a merge request, please consult the documentation below.

## Table Of Contents

- [Building](#building)
  - [Nix](#nix)
  - [Cabal/Stack](#cabal/stack)
- [License](#license)


## Building


### Nix

To build the project:

```bash
nix-build
```

To run the local development server:

```bash
./watch.sh
```

Alternatively, you can drop into a nix-shell with

```bash
nix-shell
```

And call the website watch command directly via Cabal or Stack:

```bash
cabal run haskell-foundation -- watch
```

### Cabal/Stack

The site can be built locally with Cabal and Stack if the 3rd party dependencies are met, and by issuing the following in terminal:

```base
cabal run haskell-foundation -- watch
```

Or the stack equivalent.
