# Contributors Guide

## Bug Reports

Please [open an issue](https://github.com/haskellfoundation/haskellfoundation.github.io/issues/new) if you have a bug to report.

The more detailed your report, the faster it can be resolved and will ensure it
is resolved in the right way. I personally appreciate it when people not only open
issues, but attempt to resolve them on their own by submitting a pull request. I am
always open to constructive feedback, and I am by no means an expert, so guidance
should always be considered welcome.

## Documentation

If you would like to help with documentation, please remember to update any and
all module headers with the appropriate copyright dates, ranges, and authorship.

Expansions to the documentation are welcome, and appreciated. Every contribution counts.

## Code

If you would like to contribute code to fix a bug, add a new feature, or
otherwise improve this site, pull requests are most welcome. It's a good idea to
[submit an issue](https://github.com/haskellfoundation/haskellfoundation.github.io/issues/new) to
discuss the change before plowing into writing code.

If relevant, any and all claims of "performance" should be backed up with benchmarks. You can
add them to the existing benchmark suite in your PR, as long as you do not make
unjustifiable changes to the existing code.

### Building the site

Refer to the [README](README.md) for more information on building the site. Since `haskell.foundation` is a Hakyll-based site,
it has a `watch` feature which allows for fast iteration. However, due to the limitations of the Github pages framework,
the site is watched through the `docs` directory. In order to build the site *and* have those changes propagated, you *must run
the `./build.sh` at the root of this project!*

To run the `build.sh`, simply issue the following when you are done making changes:

```bash
./build.sh
```

Please remember to include this with your merge requests.

## Code Quality

The `haskell.foundation` project intends to focus on integration and usability,
balanced with maintainability.
