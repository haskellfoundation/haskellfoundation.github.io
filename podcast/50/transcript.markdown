*Matthías Páll Gissurarson (0:00:15)*: Hi, and welcome to this episode of the Haskell Interlude. My name is Matti, and I’m here with my co-host, Niki.

*Niki Vazou (0:00:23)*: Hello.

*MPG (0:00:24)*: Today, we’re joined by Tom Sydney, author of many tools like sydtest, Dekking, and nix-ci. He’ll tell us about the rules for sustainable Haskell, how Haskell lets one man do the job of 50, and the secret sauce for open source.

Welcome, Syd. So, how did you get into Haskell?

*Tom Sydney Kerckhove (0:00:44)*: I think I remember at university, before we even started learning about declarative languages, I was looking into which programming language I might use to build my own things, and I tried a bunch of them. And eventually, I stumbled onto Haskell because someone said, “You look like the kind of person that would enjoy this.” And then there we started. And then it turned out that that fell right into place very well, because now I’m still convinced that it’s an excellent way to build something maintainable over a long period of time. And you can tell because many of my projects are almost 10 years old now, which is about when I started.

*NV (0:01:19)*: So, you learned Haskell completely by yourself?

*TSK (0:01:22)*: Yeah.

*NV (0:01:22)*: From what resources? It’s like, I’m always curious about that.

*TSK (0:01:26)*: I think it was Learn You a Haskell at the time. And this was right before Stack existed. So, I got the last bit of Cabal Hell, but not enough to have been through it professionally.

*MPG (0:01:37)*: Yeah, I think I was exactly at the same time when Stack kind of came as this promised solution to all our problems, right?

*TSK (0:01:43)*: Yeah.

*NV (0:01:44)*: It is much better than before. 

*TSK (0:01:46)*: Yes. 

*MPG (0:01:46)*: Yeah.

*TSK (0:01:46)*: And then after university, I was looking around for jobs, and I ended up at FP Complete. And ever since, I’ve been doing various things, and Haskell has always been somewhat involved. 

*NV (0:01:57)*: And what are the projects that you have when they are 10 years old?

*TSK (0:02:01)*: So there’s, for example, Intray, which is one of my products, but you can find all of the products on the front page of my website. They are variously successful, which is a nice way of saying not. There’s one project that people have actually liked, and I was very surprised that I could actually build something that people like because surely the products work, but if no one’s using them, that doesn’t really matter, does it? So, I made this dance website because I’ve been dancing longer than I’ve been programming. And so, I made a website where you can find the places where you can go dancing. And now a few thousand people use that every month. And it’s been very helpful that I rooted in Haskell just because it’s much easier to maintain. It has a bunch of data sources that change at various times. And then I need to go update the code, and nothing else may break when I do that.

*MPG (0:02:46)*: You have a bunch of projects, right? I remember, I think, I saw on Twitter once that you were the second most mentioned person in the Haskell newsletter or something like that.

*TSK (0:02:55)*: Right. The second most mentioned individual person, because there are some groups on there as well. Yes, I remember something like that. And I was surprised by it myself because surely I wouldn’t have been so active, but it turns out that I have been. It probably also isn’t the case anymore because I haven’t been writing so much anymore. I’ve been writing various little things over the years and then writing a blog post of it usually, because I find it much easier to link to a blog post than to a Hackage page, let’s say. Nowadays, I just end up writing something and putting it on Twitter and not bothering writing a blog post anymore.

*NV (0:03:27)*: And you maintain all these projects by yourself?

*TSK (0:03:30)*: Yes, that’s right. So, I found that Haskell is what allows me to maintain about a quarter of a million lines of code by myself in my spare time. And I don’t think I could have done that with any other language. I used to be at a company where there were five people full time for maintaining about 50,000 lines of code, and I thought surely this is something we can do better. But that was CoffeeScript, so.

*NV (0:03:51)*: And you didn’t try to push Haskell there?

*TSK (0:03:53)*: Well, we did, and very successfully so. But then all sorts of things happened that I can’t, in good conscience, talk about for certain legal reasons that made me not work there anymore. And so, I don’t think they’re using Haskell anymore. And I remember that various people who worked there agreed that that was not a great decision, but I don’t know what the current reality is there.

*MPG (0:04:14)*: But you did a bunch of work on your testing framework, sydtest, right? 

*TSK (0:04:22)*: Right. I had been using hspec at the time, and there were some things missing, some very small things missing all over the place. And then I thought, ‘I have some extra time.’ I think it was between jobs or something. ‘Let me just see what I can do if I try to do it myself.’ And then I wrote something, and it turns out that by choosing the right defaults or different defaults, let’s say, you can find a lot of extra problems with the same amount of testing effort. So, for example, if you run tests in parallel by default, you’ll find thread safety issues just by doing that. And if you run them in random order by default, then you’ll find problems where some – it’s called test pollution or, let’s say, I’ve called it test pollution. I don’t know what it’s actually called. It’s where two tests can either pass or fail, depending on whether they’re being run at the same time or before or after other tests. And you’ll find those problems by running tests in parallel, for example. And there are all sorts of defaults like that that I could choose because I was making the thing. And then I ended up choosing some things that are controversial, but then found a whole bunch of extra problems for me. 

So, another is that I wanted this thing to be good for running in CI because that’s where I run my tests for the most part, which means that all of the randomness that was being generated when executing tests needed to be reproducible. So, there’s a set seed for all randomness, all controllable randomness, let’s say, when you run a test suite so that it’s easy to reproduce.

*NV (0:05:39)*: Wait, but as a Haskell programmer, I’m confused. Why is the ordering important? 

*TSK (0:05:44)*: So, for example, if you have two tests, A and B, where A writes a file and B reads a file, expecting to exist, and then if you run B first, then it will read the file that doesn’t exist. If you run B second, then it will read a file and it will be there. If you have this kind of dependencies between tests—I call it test pollution—then you cannot run tests in parallel. And it turns out that being able to run tests in parallel a goal lets a lot of puzzle pieces fall into place automatically. If all tests can be run in parallel and in any order, then running test suites and tests in parallel, it turns them embarrassingly parallelizable. So, that’s the first puzzle piece, right? You can parallelize tests. 

The second puzzle piece is that it turns out that individual test run times are more or less Pareto distributed as you get more and more tests, which means by running them in a random order in parallel, because that’s possible because you’ve solved test pollution, the runtime of the entire test suite approximates the runtime of the longest test instead of the runtime of the sum of all the tests. So, you can run your entire suite in the time it takes to run the longest test, more or less. So then I was able to speed up most of my test suites by between 20 and 30x just by doing it that way. And I have a lot of trouble with flakiness over the past few years. Over a long period, you run into various issues that you wouldn’t over a short period. So, I wanted to see, can I have sydtest help me to find these flakiness issues and to diagnose them? And so the first thing that sydtest does is, it’s called flakiness diagnostics. Anytime a test fails, it’ll check if the failure is probably flaky or not.

*NV (0:07:17)*: So what is a flaky test?

*TSK (0:07:20)*: Flaky means it sometimes passes and it sometimes fails.

*NV (0:07:23)*: And this has to do again with effects with the output word, right?

*TSK (0:07:28)*: Yes, that’s right. So, let’s say if your test generates a random number between 0 and 1, and then you assert that it’s less than 0.9, 1 in 10 times your test will fail. Now you can argue about whether that’s a wrong test, and clearly it is. But the question is, how do you find such a problem? And so when a test fails, sydtest will run it again to see if it’s flaky. And if it is flaky, tell you. And if it isn’t flaky or doesn’t look flaky, rather, it’ll tell you it’s probably not flaky because we ran it multiple times and it failed every time. So, that’s the first thing that it does. And then, once you know that a test is flaky, you might not have the resources to go and fix it right then and there. So, you can actually mark a test suite as flaky, meaning I acknowledge that this is flaky, but I can’t fix it right now. So, in the meantime, if a test fails, run it again. And if it passes the second time, consider it passed instead of failed. And this is unsound if your test – wait, I have to check how it works. In the docs, there is a reasoning about when it’s unsound and when it isn’t unsound. You should assume it’s unsound, but at least you can keep running your tests instead of having to delete them, which is what otherwise happens, or even worse, if you get one person on the team, just clicking retry on CI every time something fails.

*MPG (0:08:37)*: Right. Now, this is all very like pragmatic, right? Because you’re very much embedded in industry, right?

*TSK (0:08:43)*: I like trying to be because I would hope to use Haskell as a competitive advantage for actually building products. And I believe I have. It’s just that I happen to be terrible at making any money off my products. Well, that’s the way I look at it. You might have the hypothesis that it’s because of Haskell that I’m not making any money, but that’s – well, I’m hoping that that’s not the case.

*MPG (0:09:04)*: But you have been – at least on Twitter, you’ve been having – or X now, you have some perspective on like – because Haskell is a very academically driven language, right?

*TSK (0:09:15)*: Yeah. 

*MPG (0:09:15)*: So, do you bump into that a lot in industry? Like how does that affect your work in the real world?

*TSK (0:09:21)*: So, there has been some pushback about using Haskell at all. And the scapegoat has often been, “It’s a research language. This doesn’t make sense for us.” Whereas you and I clearly see that there is a competitive advantage to using Haskell. And it doesn’t seem to reach the people that need to be convinced. And then there are also some actual, valid concerns that frustrate me a little bit because I think it could be a real superpower for actual entrepreneurship. So, for example, I looked at the contributions to Hackage over the last few years. And one thing I noticed is that the most productive Haskellers were industrial Haskellers, which makes some amount of sense because they get paid to put stuff there. But then also, the most productive Haskellers have all left more or less recently. And there are some exceptions. There is Kmett, but I don’t know what he’s doing at the moment. I’m guessing he’s not left.

*NV (0:10:10)*: I think he’s in the industry.

*MPG (0:10:11)*: I think he’s in the AI accelerator thing with the other hardware people.

*TSK (0:10:15)*: Yeah. And then there were some more exceptions. But yeah, what I saw was that the most productive Haskellers had been industrial Haskellers, and most of them had left by now. And to some degree, that’s to be expected because ecosystems evolve over time. They also get more stable over time. So, the graph I made was new versions of libraries over time. So, it makes sense that the most new versions of a certain library happen when the library starts not much later, and also that slows down. But it was a bit concerning at the time. And so, that’s something I posted about. And I had been frustrated at various points that the industrial use case of Haskell wasn’t as prioritized as I would have liked it to have been. So, I had various disagreements with people about that, but they always seemed to point out communication difficulties of mine rather than actual disagreements. 

*NV (0:11:07)*: But what do you mean productive? I mean, it’s very difficult to measure this, and especially, I mean, academics do more things than code writing, right?

*TSK (0:11:18)*: Exactly. Yes. So, it was a bit of a perverse use of that word in the sense that what I was talking about is number of versions of a package published on Hackage. And so, that’s really a terribly wrong metric if you’re going to measure productivity, but that’s what I was using at the time. So, it makes complete sense to say, “Well, that’s somewhat productivity means,” but on the other hand, that’s the only thing I’ve looked at so far.

*NV (0:11:41)*: Yeah. And I guess in the research Haskell development is more, “Let’s make a project.” I think like if we also have a Hackage library, which is a big research success, then we leave it because we want to go on to the next one.

*TSK (0:11:56)*: Yeah, absolutely.

*NV (0:11:58)*: Yeah. I’m impressed that you are maintaining all this by yourself. 

*TSK (0:12:02)*: But I’ve really developed some rules of thumb over the years that have made that easier. So, I don’t think you can do it with any code, Haskell codebase. There are some extra restrictions that you have to put on yourself, so to say, in order to make that possible. So, at some point, I was dealing with a team of more juniors, more non-Haskellers. And I wrote this list that was a bit controversial, which was called Syd’s Rules for Maintainable Haskell. It had certain Haskell-specific rules, like use prefix naming. Don’t use any of the extensions that make naming for records different. Don’t use any effect systems. Don’t have any instances that you don’t use. Don’t implement custom show or read instances. So, very opinionated rules, really. And I’m sure I’ve done all of these things wrong at some point or differently, let’s say, in various code bases. But we were going for some rules of thumb, and they were helpful at the time. And then I also refer to these two repositories called the Dangerous Functions list, which is just a list of functions you should be aware or really dangerous and properly avoid. And then there’s the WAT list, which is various unexpected results for common functions in Haskell.

*NV (0:13:12)*: What is a danger function? An example?

*TSK (0:13:15)*: Okay. So an example is forkProcess. ForkIO is also dangerous. ForkProcess is really dangerous. ForkIO is quite dangerous. And then there’s all the partial functions in base, for example. Anything to do with doubles is probably scary, let’s say.

*MPG (0:13:30)*: So a lot of like the real world problems force you to use these things that aren’t as clean as the rest, I guess, or –

*TSK (0:13:37)*: Right. It happens quite a lot that we’d work with a more junior Haskeller, and they would bump into a problem where we would say, “Oh yeah, you should know that this is a problem.” We know that this is a problem, but it’s not clear from looking at it. So, now you’re going to have to spend a day being unproductive just because you bumped into this problem. And so, at various stages, I’ve tried to go in and contribute some fixes to things, and then being frustrated when that was a lot more frictionful than I expected. So then I started writing these lists on my own GitHub repositories instead of trying to make tickets or issues or try to upstream things so that I could do the work of documenting the issue and then get on with the rest of what I was doing. 

*MPG (0:14:16)*: I would say you’ve been able to maintain a lot of code on your own, right? So, what do you think would need to change for Haskell to be more widely used? Do you have any ideas?

*TSK (0:14:26)*: So, I don’t know how intellectually consistent this is, but I’ve always thought that what Haskell needs is a boatload more money, and the rest will more or less solve itself. If you have a Facebook for PHP or a Google for Go in Haskell, then most of the problems that I’ve observed would have probably disappeared. Now, I don’t know how true that is, but that’s what my guess has been.

*MPG (0:14:53)*: Right. So, like the Jane Street or OCaml Haskell version. Yeah.

*TSK (0:14:57)*: Yeah, I guess so.

*NV (0:14:59)*: I am trying to think what is the biggest project that there exists in Haskell. 

*TSK (0:15:04)*: I’m guessing it’s private, not public because Facebook at the time, and that’s 10 years ago, we were working on a code base with 2000 modules.

*MPG (0:15:12)*: I know that Mercury. They have huge banking stuff in Haskell that nobody’s ever seen. So, there’s a lot of stuff behind closed doors.

*TSK (0:15:21)*: I mean, there’s also certain repositories of mine that are private as well. For example, the SALSA website is private just because it does search ranking, and I don’t want people who can put stuff in search results to know how the ranking algorithms. So, when it comes to solving these problems with money, that’s one thing. Given that we don’t have as much money as we might want in the ecosystem, I would have really liked if there was more of a commitment to the industrial use case from, let’s say, Haskell leadership. I don’t even know what that would mean if it had a definition. But I think you know what I’m trying to say.

*MPG (0:15:54)*: Right. But I do know that the Haskell Foundation tries to work with industrial users, right? So, part of the problem is this tragedy of the commons, right? It’s open source. So, why should they be paying if nobody else is paying? So, it’s very hard to get companies to donate money, as I understood from the foundation. 

*TSK (0:16:14)*: Yes. And they also have this working group for stability because people identified that the stability of APIs over time was quite the issue for migrations. So, for example, at Facebook, they were committing about a person year of engineering time for every GHC upgrade. And on the one hand, and this is a true belief of mine, that makes sense because a lot of things will break if you catch more stuff at compile time. On the other hand, it would be nice if we didn’t break backwards compatibility so much. So, there’s this working group around it and they’ve done some great stuff. And what I really found was missing is that even if you say that you’re committing to stability, there needs to be something to back up this promise. And so, I proposed, for example, doing something like having CI for GHC that actually checks, does this break anything downstream? That might have been very expensive as well. And then we get back to the main problem.

*MPG (0:17:08)*: But there is some project that builds a bunch of packages, right?

*NV (0:17:11)*: From Hackage. Yeah.

*MPG (0:17:13)*: Yeah.

*TSK (0:17:13)*: So, for this purpose, I started using Horizon, which is Nix-based package sets, just like LTSs, except, let’s say, faster to update. And so, that’s what I use to make sure that my libraries are forward-compatible with what would be new LTSs. So, the problem I have quite often is that a newer version of a dependency would break my stuff. And then I could not fix that until the LTS for that was out, because that’s what I use in my CI, which means that my stuff would not be in the LTS because it was broken with the system dependency. And so, there was this catch-22 of I couldn’t fix my things until the breakage was apparent to users. And so, that’s what I use Horizon for right now. And that lets me update inputs, and then suddenly I see what breaks, and I can go and fix it. And it also is in *(0:17:56 unintelligible)*.

*MPG (0:17:56)*: There’s definitely been some push because I know, at least from the technical working group, we have these proposal process where you can kind of propose things that the foundation should fund, right? And I think two of the three or four recent proposals have all been like, let’s get binary distribution more stable, right? Or let’s make Cabal more not prone to changing as much, right? I mean, there’s a lot of push to rewrite things. I think that’s one of the problems with being a very academic community is that you just want to see what happens if you change something, right? Because that’s interesting in itself, right? Whereas if you’re an industrial user, you want things to be the same. I mean, of course, you want to see change as well, but you don’t want to have to interact with it too much, right? Because that’s not part of the fund.

*NV (0:18:44)*: And if you have to make a change, you need to provide strong evidence that you actually need this change.

*MPG (0:18:50)*: Right. 

*NV (0:18:51)*: I think in Haskell, it’s like a new language feature is enough evidence to add and break some backward compatibility. 

*MPG (0:18:59)*: Yeah, exactly. 

*NV (0:19:00)*: Yeah. But I also think Haskell Foundation wants to stabilize that. They have a full-time employer working on GHC, I think.

*MPG (0:19:07)*: So, you would mostly want more stability. So, do you think that a lot of the industrial contributors are then just burning out because of a lot of churn or –

*TSK (0:19:16)*: They certainly spend more effort in open source than they think would have been necessary or should have been necessary rather. I also think that Haskell is being held to a way higher standard than other languages. I’m not clear on why, but if you look at how much we argue about packaging and build tooling, it is really unfair to complain about Haskell when I then go to Python and find the hell that that is. I know I’ve done work with a client where I was just packaging Python applications, and that broke every time, as opposed to the very nice situation that we have in Haskell. And then if you look at, I don’t know, C projects, the idea that there is a central repository of dependencies that you can just pull from is such a wild thing to those people that it’s really unfair to complain to the degree that we do about the situation in Haskell. I guess that some of what makes people Haskellers is that they’re not satisfied with the default way of doing things. Maybe that’s why we complain so loudly. I can’t tell.

*MPG (0:20:14)*: Right. And even, I think we test a lot, right? So, you discovered some calendar bug, right? 

*TSK (0:20:19)*: Right. 

*MPG (0:20:19)*: So, that was just a sydtest finding something or –

*TSK (0:20:22)*: So actually, no, someone found that in production because it turns out that there was a thread safety issue with the way that if you run the same SQL query at the same time, then you might have segfaults, something like that. And there was no way to find that unless you actually tried the exact same query at the same time for various threads. And so, that’s one thing we found there. I built this project called Dekking, which is next-generation coverage reports for Haskell, which doesn’t work in some cases for complicated type safety reasons, but it produces some nice reports for me. And now I can see that the coverage that I get from my repositories, and I hope you’d be surprised to find out that the coverage is usually around 60%. So, it’s not astronomically higher, but I’m starting to measure it, which is already something weird, apparently.

*NV (0:21:07)*: The coverage of the code that is run, this is not about testing, right?

*TSK (0:21:11)*: Oh, I’m sorry. I’m now talking about testing, but you can use this tool to get the coverage of anything that’s run, yes.

*NV (0:21:17)*: But 60% is the coverage that your unit test provides you on your code. And how do you measure that?

*TSK (0:21:23)*: So, there’s this project called Dekking. It replaces every expression in your code by unsafePerformIO, mark this thing as covered, and then return the value. But it turns out that that’s actually not something that preserves. It compiles according to GHC, which is really weird. But that way, you can see which parts of your tests were covered and which weren’t. And then you can have some really nice, colorful reports for them as well.

*MPG (0:21:46)*: How does this compare to the Haskell program coverage thing?

*TSK (0:21:50)*: Have you ever looked into the source code for that? It’s not built into GHC. That’s one of the differences. Sorry. HPC is checking this.

*MPG (0:21:58)*: Right. Yeah.

*TSK (0:21:59)*: That’s the big difference. And I wanted to do it that way so that the GHC maintainers didn’t have to maintain my coverage report.

*MPG (0:22:06)*: So Dekking is like, it does a whole program transformation of the program when you’re compiling it?

*TSK (0:22:11)*: I think so. To be honest, I’m not clear with the term, but it sounds like that would be what it is. Yes. So, there’s a GHC plugin that just goes and replaces the source code. And that was actually part of the issue because I couldn’t pinky promise to GHC that this was correct type-wise. It turns out that if you replace an expression of type A by identity function of A, sometimes that doesn’t compile anymore. That was part of the issue. So, I had to build in something where you could say, “Don’t try to cover this because it’s not going to compile if you do.” That’s part of what makes it different from HPC, is that you sometimes have to do stuff like that.

*MPG (0:22:43)*: Right.

*TSK (0:22:43)*: So, you can mark certain sections of your code as not coverable. And that might actually be useful as well if you’re trying to – let’s say you have an admin panel in your website that maybe you don’t really care about testing that part and you can mark it as not coverable and it doesn’t show up in your test reports as not covered.

*NV (0:22:58)*: And what is the output? Like, how do you see what is covered?

*TSK (0:23:02)*: So, it outputs a line separated JSON. I forget what the name of this thing is called, but it’s just JSON objects with new lines in between. And so, it has information about which package the expression was in, which file, which line, which column, so you can go find where it is. So the plugin outputs two things. There’s coverables, which are these expressions and where they are, the new Haskell source code, and then the executable that you run, which you’ve just compiled with this new version. Outputs coverage .dat files, which are just these JSON blob files. And then there’s a report tool that puts them together and makes some nice HTML reports for you.

*NV (0:23:40)*: And so, what do you do with this? Stupid question, sorry, but if you know your program coverage, how do you use this information to improve your code?

*TSK (0:23:51)*: So, you can look at the coverage reports. They’re basically your source code, with the coverable code in yellow and covered code in green. I think that’s the way it works. And so, anything that’s yellow is something that hasn’t been evaluated during testing. And that way you can find which tests you have not written yet, for example. So, you can use it to improve your test suite. You can also use it in the process of code review. If you see that a PR lowers the amount of covered code in your process, for example, that might be something to point out as a reviewer. And so, you can use it to make certain arguments about whether your code is now more tested or less tested. That doesn’t mean better, of course, but –

*NV (0:24:25)*: And this works only with your testing suite, the sydtest, right? 

*TSK (0:24:30)*: No, no, because it just does expression replacements, so you can – it doesn’t even have to be a test suite. You can do this in production, I guess, but might be a bit slower. 

*MPG (0:24:37)*: Yeah. Because I think, I mean, HPC does something similar, but like you said, it’s not a – it’s called the STG level, right? So, down after the expressions. But I think you could combine the two really. I think you could just run the HPC and then not to use their libraries to produce nice output, right? Because the output library is a bit of a mess, right? Like there’s a C parser that parses these files. It’s a bit of a mess. Yeah.

*TSK (0:25:02)*: It’s also terribly difficult to get the HPC files that are output from the right packages into the right places when you’re building stuff across packages. So, cross package code coverage reports are really difficult to do with HPC to the point that I never figured it out. And it took me less time to build Dekking to figure it out.

*MPG (0:25:21)*: Because we use this for program repair, right? Because you know which tests failed and you know what parts of the code that test touched, right? So then you can say, “Ah, if you want to fix something, you should probably look here first.” Right?

*TSK (0:25:36)*: I’ve actually got an open proposal for a master’s thesis at the university, which is about making something where you could say, “This is my test suite. Can you try and figure out across the history of my code base which tests have been useful and how useful so every time a piece of code was run by a test, that test has been useful?” You could argue it that way. And then you can see across time which tests have been most useful, for example. No one’s ever started on it, but that would have been pretty interesting.

*MPG (0:26:06)*: That’s cool. So, you mentioned some other projects you were looking into, right?

*TSK (0:26:11)*: So, I’ve been struggling with GitHub Actions for CI for a long time now. And I found that because I have around 200 repositories on GitHub, I would have to set up, do the same work 200 times to get CI running. And then anytime I would get to a project, I would find that CI is actually broken because GitHub had changed something from under my notes. And so, what that meant is that I had maintenance overhead for every one of these repositories, while also not the benefit of actually getting CI. So, I ended up removing all of it and being frustrated by that. 

And then I started on a project called NixCI, which is taking advantage of the way Nix works, where you can build code without maintaining state about that code. So, you can build any code, let’s say, without maintaining any information about it. And so, what I was thinking that I could do, I had some requirements. One was that it wouldn’t take me more time to set up CI the more repositories I have. And so, I made something, which I now call zero config CI. So, you just click enable on all of your repositories, and now you have CI, and it’ll pass the first time instead of having 10 commits of setup CI, try it again, try it again. And the reason why it takes so long is that every time you try to set up CI, you have to change something in your repository, push it, and then wait. And so, the first thing I did is make sure you don’t have to push anything to try it out. The second is it’s fast because it’s using hosted runners. I used a very beefy machine to make this happen. And you don’t need to have state about any of these. So, you just need to activate it. There is no setting it up. And because it turns out that you can build these things without any state, there’s now also a reproduce locally button. So, whenever you have a CI build, there is something you can copy-paste to run that exact build on your machine so that if something fails in CI, you can try it out locally, mess with things, and then see if you can improve it. And so, I found that that’s possible. It’s way more effort than I expected. I expected it to be some little script or something, but nope. And it’s also terribly difficult to test because, when code is the subject of your code, you run into all sorts of trouble. The first being that when I launched it or tried to within hours, someone broke into it because I’ve made some terribly stupid mistakes, to be honest, but yeah, letting other people run code on your machine to solve that kind of problem.

*NV (0:28:24)*: Yeah. So, you provide the cloud.

*TSK (0:28:27)*: Yes, that’s right.

*NV (0:28:28)*: Yeah. This sounds dangerous.

*MPG (0:28:30)*: Yeah. So, everyone wants to run a Bitcoin miner. So, if you allow any compute to escape, they will try and harness that. 

*NV (0:28:38)*: And this is hooked with GitHub?

*TSK (0:28:40)*: Yeah. So, as of today, it also works with GitLab, but yes, with GitHub.

*NV (0:28:44)*: Okay.

*TSK (0:28:45)*: So actually, I’m still working on the GitLab integration, but it was important to me that it wasn’t just GitHub.

*NV (0:28:50)*: And we can run it with Actions?

*TSK (0:28:52)*: No, you can’t because you don’t need Actions for it. I didn’t phrase that right. But it is important that you don’t need to put anything in your repository in order to get it working.

*NV (0:29:03)*: But then how do we make it work?

*TSK (0:29:05)*: So, on GitHub, if you click Install on the app in the GitHub app store, so to say, then it asks you, do you want this for all repositories or just some of them? And then you click Okay, and that’s all you need to do.

*NV (0:29:16)*: And it just goes into the project and does stack install or cabal install or I can modify it too.

*TSK (0:29:23)*: No. So, it specifically only works with Nix flakes. So, when you do things with Nix flakes, you can do Nix build on everything that you can build a Nix flakes check for all the checks. So, whatever is available there, it will try and do everything for you so that you don’t have to go and figure out how to set it all and maintain that.

*NV (0:29:40)*: But we rely on your server?

*TSK (0:29:42)*: Right. And this is also not a product that you can use for free because it is terribly expensive to run these machines.

*MPG (0:29:49)*: Right. 

*NV (0:29:50)*: And you said you had users within a few hours of launch?

*TSK (0:29:53)*: Yeah. Well, I have people who wanted to try it out, and yes. But at the time, I was running everything for free because, first of all, I hadn’t built any payment methods, but also I just wanted to see what would happen if people tried it out. So, that security issues is the answer.

*MPG (0:30:07)*: Yeah, this is why we can’t have nice things, right?

*TSK (0:30:10)*: To be honest, I found out a whole bunch of new ways that I hadn’t expected that you could break into these things. So, it was quite nice, but I felt a bit violated at the time.

*NV (0:30:18)*: You have a nice story to tell us.

*TSK (0:30:20)*: Yeah. So, it turns out running things inside a Nix sandbox helps with some things, but it’s not reliable enough to actually solve the problem of security. So I had to run every build in a VM somewhere. It needs to be able to talk to the internet because you need to be able to fetch source code. But it needs to not be able to touch the rest of your local network. So, you have to somehow set up the appropriate hosts, guests, firewall rules in order to make sure that the thing can only access the internet. It’s actually a really cool engineering project.

*MPG (0:30:48)*: Yeah, it’s one of those things where it, like you said, sounds like a simple script, but there’s a lot of stuff that you need to write.

*TSK (0:30:54)*: Exactly. And I’m hoping that I can write this once and then use it for the rest of my career, so to say, as opposed to the GitHub Actions that I have to break every time.

*MPG (0:31:02)*: No, it’s cool. I think a lot of big projects started out this way, right? I think Docker was also just someone wanting something simple, and then it turned out into a whole thing. I think Slack also, it was just some internal chat tool. And they just stopped doing what they were doing and worked on their side project because it was better than what they were doing.

*TSK (0:31:20)*: Yeah, exactly.

*MPG (0:31:21)*: Very cool. But is it all just scripts, or is it written in Haskell or like what?

*TSK (0:31:26)*: Yeah, this is written in Haskell. The only scripts are the Python script that run the NixOS tests. And there is one bash script somewhere because there’s a feature where it goes and updates your dependencies every month, if you want that. But yeah, everything else is just Haskell. And it has a complicated testing just because it’s a system that is necessarily distributed. So, you have to have the leader, which receives the webhooks from GitHub and GitLab, and then the other workers, which are the very beefy machines, which have the engineering requirement of not having to maintain any state. And they need to talk to each other, which means that they need to be upgraded separately together, or hopefully not together, which is why I wrote this blog post called Hygienic Upgrades, which is about how you can upgrade versions of a distributed system. There’s a lot of very interesting engineering problems there.

*MPG (0:32:15)*: Yeah.

*NV (0:32:15)*: And did Haskell help you in any security enforcement? 

*TSK (0:32:20)*: Not really. There’s one little thing that it helps with, which is where the routes in use that are type safe. And if you put a subsite on your site, which is called, for example, account, then you can put in one place. Any route under here needs to be authenticated by an account instead of for every route. And in that way, it has helped a little bit. But this type safety doesn’t tend to help me when it comes to security. It does tend to help with making sure I don’t break things. The warnings I get from the system in total, I’ve got a whole bunch of little tools together, giving me all sorts of warnings and errors that make it a lot easier to work on projects and maintain them. So, there’s obviously -Wall, like -Wall and -Werror in CI. And then you have all sorts of extra warnings that you can turn on in GHC. One of them, it might be default by now, unused packages. It lets you get rid of certain dependencies. And it’s really important over a long period of time that you have negative pressure on the size of your codebase because otherwise it just keeps growing and unrelated things end up being there. And so, the other thing I started using last weekend is called Weeder, which lets you get rid of unused code in an entire application. So, if you have unused code in a module that’s not exported, let’s say, GHC will tell you about it, but it doesn’t tell you about cross package reads, as Weader calls it. And that way, I’ve been able to remove, let’s say, between 500 and a thousand lines of code per project in the last few days. 

*MPG (0:33:46)*: But one of the problems with warnings is that some of them are kind of unavoidable. You don’t want to change that thing, so you just end up with a bunch of warning you’re ignoring. And if you have all these things, how do you review it? You don’t look at GHC output. You must have some system if you have a lot of these things going on, right?

*TSK (0:34:04)*: So, the first important piece is that dependencies don’t get upgraded without my consent. So, all of them are pinned down. I will only see the same warning once, hopefully. And then the next part is that any warning that needs to be ignored needs to be ignored on a per-case basis, and that needs to have an artifact to reflect it as such. And the artifact needs to be proportional in length to the amount of time it took me to figure out why I need to ignore it. So usually, that’s a big comment or whatever. So, that you can actually strive for a warning-free output, and then you can turn on -Werror. And then the next thing you would like is that if the warning becomes obsolete, as in it doesn’t occur anymore for whatever reason, maybe upgrades, then the comment that turns off this warning should now also cause a warning because it’s no longer necessary. And that’s not usually possible.

*MPG (0:34:56)*: Because I remember sometimes in the proposals, they want to add a feature, which will then be supplemented with a warning saying something is deprecated, and then there’s pushback against that, right? Like in big companies, they just ignore the warnings or whatever. So, it’s good to have a system that allows you exactly to say, “I’ve seen this warning, I’m not going to change it.” But tell me, if it’s not coming up anymore, then something else is very wrong, right?

*TSK (0:35:19)*: Yep.

*MPG (0:35:20)*: But this is all in the NixCI system, or where does this –

*TSK (0:35:24)*: No, this is just the various little tools I use for any project. So, there is pre-commit hooks, which makes sure that my code is always formatted with the way I do that. It doesn’t really matter which one you use as long as – then there’s all the GHC warnings. There’s something called TagRef, which is amazing, and the people at the GHC team will love this if they haven’t heard about it. It’s based on the GHC node system, where pieces of code can refer to each other in a way that needs to stay consistent. And so, in TagRef, you say, “Here is a little explanation of something,” and now I can refer to that. And TagRef will just go and check that all those links are not there. And that way, you have consistent developer to itself main communication.

*NV (0:36:01)*: But this is for the comments?

*TSK (0:36:04)*: Yes, that’s right. That’s for any texts, really. So, for example, if you look at the Dekking source code, you’ll see all sorts of comments about linker issues that are figured out. And then if you refactor a lot of code, these get moved around, and sometimes these links breaks and then links break and then it doesn’t work anymore. So, that’s the second. And then there is HLint, which lets me catch a whole bunch of things, and it’s quite customizable. That’s nice. So, I usually put my entire Dangerous Functions list into HLint. So, that warns me when I use any of them. And I need to go and explicitly opt into using the dangerous function in order to do that. And then now there’s Weeder as well, which requires me to remove all the code that I’m not using, for example. 

*MPG (0:36:43)*: We need a book because everyone’s complaining about Haskell tooling, but it seems like all this stuff is out there. It’s just, nobody’s using it, right? So, you need something like real world Haskell 2.0, all the tools that you need or something like that, because people are complaining and they’re like just running GHC and looking at a lot of output. And you’re like, well, if you run the Java compiler and look at the output, you’re not going to do anything, right?

*NV (0:37:07)*: I think once in one project I had HLint in my commits, and when HLint broke, I was so pissed that I couldn’t push. And then I removed this.

*TSK (0:37:21)*: Exactly. And so, you see this very often. Whenever there’s a method that you rely on in CI that has false positives, we end up just removing it instead of listening to it because the false positives are something you need to be able to deal with. And so Weeder, for example, has a bunch of them, and you need to be able to turn the warning for it off. And it’s possible, so that’s nice. But then now you get weeds in that config file. And so, any system where you can ignore something like that needs to also be able to tell you when it’s no longer ignoring the thing you told it to ignore. So, the way I look about that is on a large-ish timescale, code seems to behave as a random walk through all possible existences of that code that would pass CI. That means that you need to be able to deal with what looks like a monkey typing on a keyboard. If CI doesn’t catch it, it will end up in your codebase at some point.

*MPG (0:38:11)*: That’s right. Cool.

*NV (0:38:12)*: So maybe do you have any ways what you want to change or to add in Haskell in the near future?

*TSK (0:38:19)*: I’m actually super happy, and I’ve said this before with funny responses. I said that everything that I liked about Haskell was there years ago. And so, that’s great for me. What gets better now is all the little paper cuts. The frustrations right now are usually people-related. If there’s any reason for me to not use Haskell, it will be because of people and not because of the tech. Absolutely, there can be silly disagreements, and that’s fine. But yeah, it’s usually not tech-related. The most recent one I had was in the time package. I wanted to add a sum type for days of the week. And that was rejected. And I was so surprised by how someone with the same interests, namely Haskell, would have such a dissonant opinion about something so fundamental to Haskell.

*MPG (0:39:04)*: It’s always difficult with communities because you have very different – you have people that share one interest, but they’re very different people, right? And you have to somehow manage that. But I feel like we’re not too bad. But you’re always biased because I’m not in many other programming communities, so you don’t really see how. But sometimes they just change the license, right? And then they have to fork everything. And you’re like, “What is going on on that side of the fence?” 

*TSK (0:39:33)*: I got some really good advice from my boss at the time about this, because I was talking about how someone else wants to use Hedgehog and I wanted to not use Hedgehog for various technical reasons. And my boss at the time said, “It’s funny that you talk about this because you agree on so many things. And this is the one thing that makes you unhappy about your exchange?” Like, “Oh, you’re a programmer. Excellent. Great. Oh, you like functional programming. Amazing. You do Haskell as well. That’s so cool. Your test stuff. Nice. You do property testing. Wow. Oh, but you use Hedgehog. Oh, well.”

*MPG (0:40:05)*: Yes, exactly. I think there was an XKCD saying that human communities are fractal, right? If there’s two people there, they’re going to disagree about something. 

*TSK (0:40:16)*: Right.

*MPG (0:40:17)*: All right. Yeah. I think it’s been good. Thanks for coming.

*TSK (0:40:19)*: Thank you very much for having me. 

*NV (0:40:21)*: Thank you. 

*MPG (0:40:22)*: Bye-bye.

*Narrator (0:40:24)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
