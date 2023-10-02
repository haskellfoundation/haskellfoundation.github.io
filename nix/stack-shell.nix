
{
  # This is the ghc that stack passes in, but we just ignore it.
  ghc
, ...
}:

with (import ./. {});

haskell.lib.compose.buildStackProject {
  name = "haskell-foundation-lib-stack-shell";
  ghc = haskell-foundation-pkg-set.ghc;
  nativeBuildInputs = [ bzip2 zlib ];
}
