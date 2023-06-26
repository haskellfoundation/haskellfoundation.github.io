*Joachim Breitner [0:00:12]*: Today, Wouter and I are talking to Andrew Lelechenko, also known as Bodigrim, who went from a mathematician in theory to a failed PHP developer, to the chair of the Haskell Core Libraries Committee. Let’s hear whether he prefers number theory or Haskell, whether he prefers working with compilers or working with PHP frameworks, and especially whether he prefers higher salaries for Haskell developers or breaking changes to the base library.

Welcome, Bodigrim.

*Bodigrim [0:00:38]*: Hi there guys.

*JB [0:00:40]*: Hi there. 

*Wouter Swierstra [0:00:41]*: So thanks for joining. I think a lot of our listeners will know you mostly for your work on the core libraries, but maybe we can rewind a little bit and start from the very beginning. So how did you get involved into Haskell?

*B [0:00:52]*: I got into Haskell by accident because I failed as a PHP developer. So basically, my first introduction to Haskell was in university. It has nothing to do with any official lectures or disciplines there. It just happened that a friend of mine, Roman Cheplyaka, who is probably known to the community as the author of the Tasty Testing Library. He basically just introduced me to Haskell informally. We’ve been studying together, and for some reason, Haskell just clicked with me. It’s been a nice, fun language to learn. And basically, Roman ran some courses for fellow students and postgraduates who’s been interested in this. And that was my first introduction to Haskell.

*WS [0:01:55]*: And what were you studying at the time?

*B [0:01:56]*: I’ve been doing number theory in the Odesa National University back in Ukraine. So yes, I am a mathematician in theory

*JB [0:02:11]*: Is there something like a mathematician in practice?

*B [0:02:14]:* Not really. I never planned to be a software developer, to be honest. If it was economically sensible, I would rather keep doing number theory. I’m still fascinated with this topic and with pure mathematics. And every time people speak about applied mathematics, I’m not my cup of tea, which is quite on contrary to my position where I am standing very clearly on the side of the industry, and I know nothing about the category theory at all. So there is some strange difference in my choices and tastes.* 

*JB [0:02:59]*: How did you become a theoretical mathematician without having to touch category theory? Doesn’t it pop up everywhere?

*B [0:03:07]*: Not really. To be honest, I never heard this word before, doing Haskell at all. So basically, the problem with my background, with my education is that you cannot really earn much money. To be honest, no money at all for doing number theory in Ukraine. So after finishing my PhD about the Riemann theta function, I had to find some job for living. And I’ve been doing some freelance things with web development like touching PHP, like JavaScript. So I tried to find some job in this area. I got a couple of interviews, failed all of them absolutely miserably. Mostly because like being a self-taught software developer in PHP, I had no idea about any framework, so whatever. It was not invented here, so I’ve been inventing things on my own, which have been cool and I still think that it’s been a valuable experience. But obviously, it doesn’t find understanding with employers. 

*WS [0:04:19]*: Yeah. So what was your first experience using Haskell in industry then?

*B [0:04:24]*: So basically, for some reason, as I mentioned, I failed my web developer interviews and I’ve been desperate, and I looked for some iOS development courses and Ruby on Rails courses and I’ve almost completed them. But suddenly, there was an open role basically. That’s another place where Roman Cheplyaka appears in my life because he just recently left a position of a Haskell developer in Kyiv and they’ve been extending the team and looking for some other developer. Well, I applied and since there are no frameworks in Haskell at all, I managed to pass that interview. I still don’t know how and why. And I wouldn’t expect me to hire myself, to be honest. I had no idea about monads at that moment. I’ve been barely able to use IO for some read-write things. But I got hired for a position of Haskell developer for compiler. It’s been pretty fun.

*JB [0:05:35]*: And was it fun doing a compiler in Haskell?

*B [0:05:38]*: It’s absolutely fun. Much better than doing web development in PHP.

*WS [0:05:44]*: So what were you compiling?

*B [0:05:45]*: We are compiling an imperative language, which is quite an odd choice because most of compilers implemented in Haskell are so heavily influenced by Haskell that they are functional pure languages themselves.

*WS [0:06:02]*: This was for an in-house imperative language that you were using for something specific, or what was the compiler used for?

*B [0:06:10]*: Yes, it’s an in-house programming language.

*WS [0:06:13]*: So why write a compiler? It seems like an odd thing to do for a company, I guess.

*B [0:06:17]*: I don’t know. It actually seems like everyone is writing their own compiler, but in this particular case, I think that actually having your own DSL is a good idea almost every time. I’ve seen too many systems which has been just bad, undocumented, and unspecified list inside. So if you can have a well-documented list or better-typed Haskell, it’s always better. So I strongly believe that every big system can use domain-specific language and obviously, your choice for implementing this domain-specific language should be Haskell.

*JB [0:07:00]*: But you’re still saying domain-specific language, not embedded domain-specific language. So you’re saying that dedicated languages are probably the way to go rather than trying to just make it a Haskell library and then call that library EDSL because it’s more fancy?

*B [0:07:15]*: It depends on your target audience mostly. If your target audience is software developers or more specifically Haskell software developers, you’re blessed and indeed you can go for an embedded DSL. But the idea of these domain-specific languages is basically to give users an opportunity to implement what they want. Because the usual scenario is that you have some dedicated core team which is developing new features for your product, for your business system. And then you have many internal clients of this system and they keep asking this core team to develop more and more and more features. And basically, it’s around two opportunities. One opportunity, you grow your developers team so that they can write more code and implement more features in a given amount of time. But another opportunity is you keep your core team small and you basically give your users an instrument to implement their desires. And in this case, the experience is that giving your users full-fledged Haskell, even in the form of limited embedded DSL, is too much. Basically, because you have no way to shield your business users from type checker errors, which can be quite horrible, and they never actually voted to see them. 

I guess, actually, the modern point of GHC evolution, you probably can have some type checker plugins. So basically, you have your embedded DSL and you have your domain-specific type checking which can alleviate this issue. But I haven’t seen any implementation of this idea In the wild. It would be quite interesting to look at an example that sounds plausible. But basically, old school way is just to invent your own language with its own syntax. 

*JB [0:09:23]*: I wonder if it’s something that Haskell should be doing better so that using Haskell as an EDSL host for a non-Haskell audience is actually viable. But yeah, you’re probably right. It’s not where it is right now. Chris Smith built this CodeWorld thing and he invests a lot of time in post-processing GHC’s error messages to make them amendable for the beginner audience. But even then, they are the pointers that people want to program, not solve business problems. So I understand that it’s harder if you have that audience.

*WS [0:10:01]*: So how did you get from writing an in-house compiler without knowing what a monad is, to running the Core Libraries Committee, I guess?

*B [0:10:12]*: Well, first, I learned what is a monad. I’m still not sure if I got the right idea about it, and I didn’t really understand monad transformers for another year or two afterwards, which really didn’t stop me from writing more code. But I guess it’s really pandemic which gave me more free time on my hands. And I got involved into wide string development, and then I went to help a bit with the random and vector libraries, and then for unix library and then for text library. And then suddenly, I found myself in an awkward position of a chair of CLC

*WS [0:11:01]*: Yeah, I think those are some of the most popular or widely used Haskell libraries, especially in industry. Things like bytestring and vectors and unix seem to pop up everywhere. So how do you run the CLC?

*B [0:11:15]*: So in its current installment, CLC is run completely remote and asynchronously. So we don’t have any calls or meetings at all. So basically, all of what is happening is happening in public, mostly in our Git repository, on GitHub issue tracker. And some conversations happen in our email list, which is again publicly accessible.

*WS [0:11:49]*: Yeah. So what are you responsible for doing as the whole committee?

*B [0:11:53]*: So the Core Libraries Committee is foremost responsible for the controlled evolution of the base package. There are also other responsibilities such as pvp, such as administration and management of other Core Libraries and stuff. But the main responsibility is the base package. 

*WS [0:12:17]*: Right. So I suppose I have a change that I’d want to see in base. How could I go about realizing that?

*B [0:12:25]*: So the first question to ask is whether your change is visible to clients. For example, if you are basically-- is anybody going to be affected in any way if they basically switch to a new version of base? If your change is, for example, documentation only, it doesn’t affect runtime clients at all. If you just want to add some comment, maybe rename some variables because they are obscure, or change some alignment, you don’t really need an approval from CLC. You can just raise the merge request and then GHC team will be able to take a look and basically say if they like it or not.

*JB [0:13:12]*: So maybe for context, the code of the base libraries hosted together with the code of GHC in the same GitLab instance. So the actual work of merging them and testing them is done by the same people that manage the GHC code base?

*B [0:13:26]*: That’s right. And if your change is actually visible, then you have to raise a CLC proposal. Basically, there is a lot of fear around proposal process. I know that many people think that it’s very difficult to create a proposal and that it’s a lot of work. We at CLC are absolutely happy for discussions to start informally without a properly written proposal. You can just basically jump with your idea and raise an issue. We would expect more or less specific proposals to appear in some in due course, but it’s not required for starters. So you can basically quickly check your idea with CLC members and the members of public to basically understand whether it’s feasible, whether you want to spend a couple of evenings of your life writing a proposal. It’s absolutely fine to quickly check the temperature.

*WS [0:14:30]*: And once you have, okay, some discussion and you’ve managed to write a proposal, what happens next? What proposals get accepted and which ones don’t?

*B [0:14:39]*: The next important step in the evolution of your proposal is to understand whether it’s breaking or non-breaking. And if your proposal is breaking, which means that there is an opportunity that there exists the client, which wouldn’t be able to compile their programs when migrating to a new version of base, this means that you need to prepare an impact assessment. So the usual way is you go and run your change, you compile GHC with your change to base, and then you try to compile an entire Stackage snapshot. And then you know basically how many packages are affected and what kind of patches are due to fix them.

*JB [0:15:31]*: So at that point, I already need to have an implementation of my change because I need to test the impact.

*B [0:15:37]*: That’s true. That’s an important difference between GHC proposals and CLC proposals. CLC proposals always need an implementation upfront. 

*WS [0:15:50]*: But that makes sense I guess because the threshold to, I don’t know, making some complicated change to GHC’s type system or optimization pipeline is a lot more work to do upfront, especially if you’re not sure if this change is going to be accepted or not. Whereas the Core Libraries’ proposal is hopefully-- I mean, you’d hope that many of these proposals are relatively small and that they change a few functions in base. Maybe these are functions which could get called a lot, but that’s a relatively easy change to make. And then you can test whether this change will break any other code.

*B [0:16:25]*: Yes. Usually, CLC proposals change only a small fraction of base. It’s usually you introduce some new function or maybe you move things from one module to another. So it’s reasonable expectations that you can just show what exactly you mean to do.

*WS [0:16:43]*: Yup. So suppose I have a non-breaking change. So I have a proposal fleshed out and we’ve had this discussion, but we realize this change shouldn’t impact any existing code, even if it is visible for end users. I’ve added a new function to Data.List or something. How do we decide whether it gets accepted or not?

*B [0:17:04]*: We just vote

*WS [0:17:06]*: Okay, that’s very democratic.

*B [0:17:11]*: So the members of the CLC will help vote and is required to get a majority of votes, which is currently four out of six members in favor of your proposal.

*WS [0:17:26]*: And if I have a breaking change and I’ve done my impact assessment and I see that whatever percentage of all Stackage packages breaks, how do I convince the rest of the committee that they still need to vote for this proposal?

*B [0:17:41]*: Well, one thing you must do, if it’s breaking change, you must prepare patches for all packages affected, because it’s a bad idea to expect that someone else likes your proposal more than you yourself. And if you want to see your proposal implemented, then please do work for everyone up front. And this is a good stop measure from breaking changes of wide impact. Important distinction here is that we do not ask people to raise pull requests, for example, because if your proposal affects like, I Dunno, even 30 packages, raising 30 pool requests to different repositories, some of which are, for example, in Darcs and in BitBucket and in Mercurial, it’s quite a complicated task. Your proposal hasn’t been accepted yet. You might not commit for that amount of work. But we do ask for patches to be ready so that if we accept your proposal, at least we can point maintainers to this list of patches and they can just take it and apply and that’s it.

*JB [0:18:59]*: How well does this work? Or maybe put it differently, what is maybe one of the most breaking changes that you’ve accepted and was it easy to build all the patches? Did they reach the maintainers or did maintainers ignore them? Did maintainers patch their stuff quickly? What is the actual experience?

*B [0:19:17]*: Well, the most breaking change we accepted was actually Joachim’s proposal to change--

*JB [0:19:28]*: The removal of not equal method from the type class and making it a normal function. 

*B [0:19:32]*: Yes. But it’s still not implemented on GHC side. So we have not pushed for migration of packages much so far, but we had all patches in place. And for other breaking changes, I believe the biggest was maybe around 10 packages affected.

*JB [0:19:55]*: Okay, that’s not too bad.

*B [0:19:56]*: There have been changes with regards to Eq1, Ord1, Show1 type classes. And basically, not only have patches been prepared, but for this amount of stuff, when changes are backward compatible, I believe they’ve been already pretty much all applied. So in this sense, we hope that by the moment when new GHC is released and by the moment when Stackage upgrades, we hope that all patches are already there.

*WS [0:20:30]*: Fair enough. So I imagine one of the hard things about being on these committees is, when you cast your vote is that there’s always this tension between people who claim we need to move forward with the language or you need to fix this war, which is there for historical reasons. And on the other hand, you have people who might be more conservative and say, “Well, is this really so important that we fix this? It’ll break so much code.” We’ve had various discussions about changes to type classes and functions from the Prelude even, which would break existing monad tutorials or break existing literature on certain subjects. So that must be pretty hard to decide which of these two ways more heavily. So what’s your view on this?

*B [0:21:20]*: It depends.

*WS [0:21:23]*: That’s a good answer.

*B [0:21:25]*: I mean, I think I am leaning-- recently, I am leaning to more conservative approach. But essentially, it’s up to each CLC member to decide what approach they choose and to decide their own guidelines for voting. Some CLC members can happily decide that they will never vote for breaking changes at all, for example, and that’s absolutely fine. And some can have a strong inclination to vote for every breaking change like, “Let’s break it as soon as possible so that a bright future comes sooner.” My own view is that basically, if the breakage is reasonably small, like up to maybe 10 packages, and we can apply all changes in time for a new GHC release, then I think that it’s acceptable. But again, it depends. It depends on how much value we can get from this breaking change.

*WS [0:22:31]*: Yeah. I guess that’s an interesting point of discussion. Is it worth the headache that we’re kind of creating for ourselves here? And if it’s something which is maybe imperfect but acceptable, then let’s not break a bunch of packages if the trade-off is not good.

*B [0:22:49]*: That’s true. I think that if we talk about functions, then there is quite a high bar to make breaking changes. Because if it’s just a function, like you don’t really have to use base, you can use any alternative prelude or you can get a new fancy function from some other package, yes, it might be a bit inconvenient, but it’s not an end of the war. And it’s not worth to break existing clients of base for the sake of, I don’t know, like adding some additional argument to an existing function or maybe changing its behavior unless it’s very much unreasonable. But type classes in Haskell, they remain to be a very difficult field because basically, if we decide that there is something wrong with Eq or something wrong with Foldable or something wrong with monad type class, it’s not something what users can fix in the user land. 

*WS [0:23:57]*: Yeah. That’s true, right? They’re globally visible and every instance you define is there forever. And a user can’t-- unlike with functions where you can import some and then hide others and then redefine them yourself and resolve this as soon as you have type classes involved, it becomes much-- I mean, the module system isn’t capable of hiding these instances and then changes to type classes, I guess.

*B [0:24:26]*: Exactly. So changes to type classes are pretty much global and it puts us in a very difficult position because from one point of view, breaking changes to type classes are breaking for everyone and people have very little opportunity not to be broken. On the other hand, if there is some genuine issue, something is genuinely wrong with the type class, we all are going to suffer with it forever and it makes sense to fix it at some point in time. So the big question is basically how to make such changes workable for a large audience for the existing amount of packages. And that’s basically where impact assessment plays a crucial role. Because if we do not do a very specific impact assessment using Stackage, we actually have no idea how bad is this breaking change. 

As I said, for functions role, like for types, we can just potentially-- at least in theory, we can accept the positions that we never make any breaking changes, and every breaking change should be made outside of base in the user land. For type classes, we might need to make some breaking changes. And that’s very similar to a situation in GHC world where if you have some type system issues, if you have some type checking in felicities and you want to fix them, this affects everybody. So take, for example, simplified subsumption. You cannot make a breaking change in the type checker in a way which would be invisible for your users. It’s even worse than type classes because potentially, I can imagine that someone implements its own hierarchy of type classes from the scratch, like not using any Eq or monoid from base, but you cannot really implement your own type checker. So every change to type checker is non-negotiable for clients. They just must adhere to it. 

And at this point, when we make these kind of breaking changes, we need to measure how many people are going to be broken, because we know for certain that someone could be broken. It’s breaking change. But if it’s only one package on Stackage, that’s probably more or less fine. If it’s 100 of packages, it’s probably not so good.

*WS [0:27:06]*: I think they do the same with other changes to GHC, right? They typically try to recompile all the Stackage or a subset of package just to check, okay, did this change to the type checker break anything? It’s sometimes really hard to tell because you think, oh okay, there’s maybe this one obscure case which I can’t handle quite as generally, but I can generate much better error messages instead. There might be some trade-offs like that. And then it’s only by collecting the data that you really have empirical evidence at least about what the consequences are of one of these changes.

*JB [0:27:43]*: Right. I think this brings me to a question that it’s been bothering me for a while. Like you mentioned, okay, people have to build patches to basically pay for the change they want to bring, but then the patches just sit there and it’s a good start. But it feels strange that these people who make a proposal and make a change and prepare the patches and the proposal gets accepted and that they can’t fix the fallout completely in the sense that it’s still at all-- these libraries that are kind of a common resource for the community cannot be modified and updated by the people making the changes all the way through so that the maintainer has to do close to nothing. And sometimes wondering if we should be more liberal in like a common ownership of the ecosystem beyond base so that when you make a change to GHC or to base, you not only get to prepare patches for all these things but actually get to fix them completely and they reach the users that way in a maybe more faster fashion. 

And there’s precedence in that I keep mentioning in the Isabelle world where there’s the Archive of Formal Proofs, which is equivalent to Hackage in a way. It’s this collection of contributed libraries, and they’re actually quite complicated theories. But still, when they make the change to the language, those who make the change to the language update all these codes from other people always. And because it’s in lockstep with the development version of Isabelle, that actually means that you know what you break very quickly. You don’t have the problem that you’re working on GHC and you can’t build all the Stackage with current GHC head for some reason because, well, that doesn’t happen. And I always wonder if that’s something we should maybe work towards to, or if that’s just not a good idea and wouldn’t scale anyway because it would still only affect a selection of packages and you still get the problem of breakage beyond that, all the libraries out there that are not open source. 

*B [0:29:43]*: One thing is that we encourage proposers to actually submit their patches once their proposal has been approved. And usually, people do this so that maintainers affected packages just have to merge a pull request and that’s it. Well, it’s a lie because they still have to make a release, which is quite an amount of work anyways, but it’s not too bad. The problem is, automatic application of patches to a large extent is that it’s easy to make some fix, but it’s not always easy to make a fix which will satisfy a particular maintainer. So for example, what degree of backward compatibility we are looking for, what kind of stylistic quality we’re looking for. And the experience is that sometimes maintainers have pretty strict opinions about this. So I don’t know. I don’t think we can automate this process. I do think that however, we should have more maintainers for key packages in our ecosystem.

*WS [0:30:56]*: And do you think standardization would help? So I think some languages like Elm has these very opinionated formatting rules about how everything should be laid out and everything looks kind of stylistically the same. And they have very-- I don’t agree with all their choices, but at least they’re very clear choices, right? Whereas in Haskell, you have half a dozen ways to just strike the identity function, which is very nice. I like this syntactic freedom and the way to kind of express yourself in however you see fit. But maybe that doesn’t work if you want the language to scale up in having so many different people involved all with their own style or taste.

*B [0:31:40]*: Well, can we expect GHC source code to follow the same format? Probably no. So why would we expect as developers, which are much more diverse than GHC headquarters, to follow the same stylistic standard?

*JB [0:31:57]*: Wait, you don’t like curly braces and semicolons at the beginning of the line? I’m not sure if actually source style is the more pressing point here, at least in terms of getting patches out there at light rather than repository layout. How you do CI? How you do releases? Is that automated? Because that I think would be stopping me from feeling confident about making an obviously trivial change in the terms of source code to some other person’s package and maybe even doing a release if that would be something that were accepted by the community and that diversity is. But on the other hand, it’s probably part of our culture. I mean, Haskell is-- part of it is still experimenting. I mean, I’m not saying experimental, but experimenting language. You want people who like to experiment, and people like to experiment, probably those who have strange ideas about how to run things when you let them to.

*WS [0:32:55]*: I mean, let a thousand flowers bloom. I think that’s kind of the approach here. And that works very well for the language. But you can see when you hit these standardization issues and you need to make some collective decision about core libraries. That’s not so easy, I guess.

*B [0:33:12]*: I think that the ongoing discussion about stability is actually a sign of culture change in Haskell because you cannot run a startup the same way you run an enterprise and vice versa. And basically, for a very long time, your biggest program written in Haskell was GHC. But this day, it’s no longer true, like Drac code bases at Cardano, at Standard Chartered, much larger than GHC in scale. And these code bases, they basically need other culture around Haskell around libraries. And I do believe, and I do hope that this new culture will prevail.

*JB [0:34:03]*: Even if it comes at the cost of Haskell no longer being the language where you find all the new experimental features, and that’s exciting stuff happening, and you can show things to people from other languages that you have, but they don’t?

*B [0:34:23]*: It’s not necessarily opposite things. What industry wants is more stability in core ecosystem and core infrastructure. It remains to be seen whether these can be combined with experimental bleeding edge developments in type systems. I don’t know.

*JB [0:34:45]*: I think it’s a good point that you’re making, that there’s a difference between stability and I guess reliability and tooling and these things versus adding more language feeds that maybe opt in or having like language additions that kind of protect existing users. That’s good to keep that in mind.

*B [0:35:05]*: There are multiple interesting bleeding edge developments in GHC, like linear types, impredicative types. And as an industrial user, I don’t mind absolutely great stuff. I absolutely don’t mind the GHC to contain some code to deal with linear types or impredicative types. That’s not a problem. My problem is that I cannot upgrade to new version of GHC, for example, or my dependencies are out of date and their maintainers are absent and I don’t know what to do.

*JB [0:35:43]*: Right. Yeah, I can understand that that’s more similar. There’s still some part of me at least that would want Haskell to be at any point in time, the Haskell that we would create, if we were to create it at that point in time. And I understand that maybe sounds dangerous to some people and it’s not absolute. It’s just something that would be a little bit sad to see go.

*B [0:36:07]*: Maybe. But you see, I am a very selfish person. I do Haskell for a living. And basically, industrial success of Haskell is my success. I want a bigger market for Haskell. I want higher salaries for Haskell developers. And if I had to sacrifice something, well--

*JB [0:36:31]*: All right, I guess there’s some amount of tension there. I’m sure we’ll get the best out of it as a community. So, other people have opinions about this and not just the two of us and they want to get involved on the Core Libraries Committee. How do you get on the committee? What do you have to bring to the table? What’s the process?

*B [0:36:49]*: We usually run elections about New Year and we accept nominations by the end of January. And we welcome people from various backgrounds. We are not really looking for the cleverest people in the world because you see, if we elect only the most clever people to the CLC, then Haskell will be accessible only to the galaxy brains. We’re actually looking for people from different backgrounds to join CLC to provide different perspectives on changes which are proposed. Because you can imagine that if you take six Comets, then basically you’ll have a blood-defined language for number theory or category theory, but probably no one else will be able to use it.

*WS [0:37:54]*: Yeah, I can imagine. Everyone has their own preferences and values when it comes to programming.

s 1 37:59]: Okay. And maybe last question about the whole CLC thing. In your perspective-- I could imagine that a committee process can either be very useful to be a gatekeeper and slow down the rate of change and raise the barn and just keep the quality very high and churn down. Or it could be that you actually have the committee because you feel like there’s not enough movement and you want more people involved and you want the committee to be like a place to help people. So in your perspective, what is the more, probably a bit of both, but what is right now the more pressing, more important aspect of base maintenance? Is it to stop too many weird ideas from reaching it or is it more the case that you think that base could see more development? Which shouldn’t be breaking development, but could just be-- I mean, it’s an important library. So is it active enough? What do you think?

*B [0:39:00]*: I believe that we have a fantastic community which is very active in its attempts to improve base, and there is no shortage of proposals. Fundamentally, basically, CLC serves as a body which takes all this proposal process off the shoulders of GHC developers. So CLC has to try to get public opinions on the proposal, ask questions, ask for impact assessment, and basically evaluate the proposal better. To be honest, I always hope for every proposal to succeed because I know that people spend their time and they know that for people, it’s a big deal to basically go upfront, open with their idea, with their proposal, which they apparently love. They put a lot of their effort into it. And so I always want them to succeed and basically be rewarded for their time. So I don’t feel that CLC is kind of a stop-gap measure of something like this. If there are many top-quality proposals, we’re happy to accept them all.

*JB [0:40:26]*: Okay. Maybe a few of our listeners will have good ideas for good proposals.

*WS [0:40:32]*: Is there anything else we should ask you about or anything you want to talk about or should we just wrap up here?

*B [0:40:38]*: Speaking of the impact assessment, I believe that as a community body in the Haskell ecosystem at the moment, do not run anything close to CLC because as far as I recall, GHC proposal process doesn’t require a formal impact assessment at all. It’s usually just some guesses, like this should break many packages or this should not break many packages, but almost never a hard data. And GHC merge requests, in the best-case scenario, are evaluated against head package only, which is a very small database, at least 10 times smaller than Stackage. So my deepest desire is for other community structures to accept at least the same standard of impact assessment and ideally better and more rigorous.

*WS [0:41:38]*: I can imagine. Yeah. And do you have any lessons learned from being like a community manager for other languages or other Haskell committees that you’d like to share? You must have bumped your head on something and regretted having handled a proposal in a certain way and then it keeps you up at night.

*B [0:42:01]*: I’m looking at Joachim at the moment!

*JB [0:42:06]*: I knew it. Maybe we should summarize what happened there for those part of the audience who don’t know the story. So from my point of view, what happened was that there was a new start of the Core Libraries Committee and Bodigrim was running it. And there was suddenly a better structure to before, before it was made in list, and it was unclear what was happening. And now there was a process and I thought, “Oh, the process. I like processes when they’re good.” And also, this thing I would do differently if maybe it’s worth doing. Let’s ask the committee. So ask the committee if we should clean up the Eq type class. In a really small way just removing a method that, I mean, who needs it as a method? It’s completely-- I mean, it’s just leading code. Whoever should be happy to lead code, right? That’s a good thing. And by making arguments like these, I kind of convinced the CLC committee to accept that as the very first proposal in the new process. And then the internet erupted for a week or so. And some people were surprisingly upset about that proposal. And then I later found that change, to make it really good in GHC, requires some unrelated changes somewhere else about how GHC handles single method versus multi-method type classes, which are compiled differently at the moment. And so now I have an excuse why this whole thing installed and nobody actually gets their feet trodden on by these completely uncalled-for changes. And maybe in the far future when GHC has adopted it and we have a tool to automatically update code and delete your unnecessarily define things as it goes, maybe you can move *[00:43:44 sound cuts out]*. 

*WS [0:43:52]*: Yeah.

*B [0:43:53]*: Yes. It’s been quite a challenge for a new CLC process and for a new committee at that time. But the lesson learned is basically that these kind of discussions are not that much technical. They are mostly about social dynamics and about community and about expectations in the community. Because the feedback after that discussion was not even that much about Eq or non-Eq or whatever. It’s been more like, okay guys, so you are a new committee and the most important thing you decided to do. Like really guys?

*JB [0:44:38]*: And that’s not fair because it’s not your fault. Just somebody else came and post this question and of course, the committee answers it. That’s the side of the committee.

*B [0:44:46]*: Yes, exactly. But I very much understand the viewpoint of the general public, was that you decided that the most pressing issue in the entire Haskell is Eq or non-eQ.

*WS [0:45:02]*: Yeah. Fair enough. Okay. So on that note, I just want to thank Bodigrim again for joining us today and sharing all those insights. 

*JB [0:45:11]*: Yeah, thanks. 

*WS [0:45:12]*: Thanks very much.

*B [0:45:13]*: Thank you, guys. You’re wonderful hosts.

*WS [0:45:16]*: Thank you. 

*JB [0:45:17]*: Oh, you’re far too kind.

*Narrator [0:45:22]*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the support of our sponsors, especially the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and Meta.
