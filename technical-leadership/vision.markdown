We believe that Haskell is awesome and that it can provide unique value to
everyone, because it sits at an interesting intersection between human
craftsmanship and machine automation:

* It is good for humans to write by hand: Type safety, powerful abstractions
  and referential transparency have enabled engineers all over the world
  in startups and big tech to deliver and maintain complex systems.
* It is good for responsible AI workflows: review is a significant bottleneck in
  modern AI-workflows and Haskell's strengths heavily favor the reviewer.
  Additionally, the ability to quickly design eDSLs and express constraints
  where it matters allows to set up strong guardrails for code generation,
  without losing flexibility.

There may be better languages for formal verification or for vibecoding, but
there's no better language for "human in the loop". Haskell is where we
maintain control of our work, build institutional knowledge and ship responsibly.

We're driven to improve Haskell for everyone:

1. Beginners: the onboarding experience must be our benchmark for usability
2. Experts: enabling advanced workflows and improving productivity
3. Industry: focussing on stability and scaling

## A vision of productivity

Imagine Haskell had the iteration speed of golang, the debugging capabilities
of C# and the onboarding experience of rust. And all that while providing
stronger guarantees and better performance!

### Iteration speed

Modern workflows require fast iteration times: compilation, interactive repl,
remote dependency caching, CI and test integration. All of this affects both
human and machine workflows.

While Haskell scales well in terms of code complexity... it doesn't scale well
in terms of build times. As an example, GHC's own CI has turnaround times of 6
hours. We want to bring them down to 2.

### Debugging and profiling

Instead of helplessly dumping logs and binaries into LLM chats, we envision
deterministic tools that allow precise and ergonomic enquiries:

* live step-through debugging
* actually useful stack traces
* beautiful performance analysis reports

And all of that in your editor/IDE as well as through powerful CLI and scripting interfaces, the latter enabling power users as well as LLM-driven debugging (natively, without requiring any custom adapters like MCP).

Debugging must be fun again, without littering `Debug.Trace.trace` all over
your codebase.

Documentation and interactive exploration will assist newcomers in understanding all caveats
of laziness and GHC and should clearly explain how to leverage these tools.


### Onboarding and DevX

In these times of low frustration tolerance, we are going to build the best
onboarding experience in the programming language ecosystem, because it is
the ultimate benchmark for developer experience as a whole.

* installation so quick that you're wondering whether the installer even worked
* documentation so comprehensive and accessible that you never get stuck
* tooling so intuitive that you don't have to constantly ask for support

This can only be done if we commit to unix principles, which we summarize as:

- write programs that do one thing and do it well
- write programs that work together
- write programs that are extensible

Documentation should be a joy to read, written by humans, for humans.

## A vision of a secure and trustworthy ecosystem

Security and trust don't get established by accident. Once trust is lost,
it's often irrecoverably lost.

To protect our community assets and reputation, we need to:

- have the fastest incident response time among language ecosystems
- have penetration testers go through our infrastructure regularly
- make end users aware of vulnerabilities and mitigations
- build a robust cryptography library stack
- harden our supply chain

We should further support attempts to utilize or extend the strengths of the
Haskell language to boost practical applications of secure design and architecture,
such as [Information Flow Control](https://hackage.haskell.org/package/lio) or
[Mandatory Access Control](https://hackage.haskell.org/package/mac).
We're also monitoring the efforts of [dependent types](https://ghc.serokell.io/dh)
and [liquidhaskell](https://ucsd-progsys.github.io/liquidhaskell/).

## A vision of stability

What if we could compile Haskell software that's 10 years old with the latest
GHC, without any source code changes?

While this might seem like an impossible goal to achieve... embarking on that
journey is going to get us closer to a robust, stable and predictable ecosystem
anyway.

The questions we need to answer along the way are:

- how can users opt out of breaking changes?
- how long can we keep support windows open?
- how can we make the upgrade experience better?

Not only requires this investment in GHC and core tooling, but also potentially
support community efforts to maintain stable package sets or coordinate ecosystem
upgrades, make cabal more ergonomic for complex use cases, spearhead and
support stability policies and gather data about what parts of the ecosystem
cause churn.

We want Haskell to not only be a choice for fast moving startups, but also for
large or conservative companies that do not want their workflows or
software stacks disrupted. Stability will benefit both of these types of users,
reduce cost and friction and build a reputation for Haskell as a modern
language with a predictable ecosystem.

## A vision of a flourishing open source ecosystem

All of the above is an attempt to support the Haskell open source ecosystem
that we love. We are committed to open source, its values and the social
aspect of it. Collaboration is how we engage with and inspire each other.

We want to enable all the maintainers and volunteers who keep this ecosystem
alive, many of them unknown, doing their part on a Saturday evening
at the other end of the world.

We code because we love to ship products. But we also code, because we want
to socialize, meet people and have a good time. We're committed to both of
these values.

