_Joachim Breitner_: Welcome to the episode of Haskell Interlude with our guest Sebastian Graf. He's a GHC developer and we'll learn about patterns and the pattern match checker, see how demanding it is to work on the demand analyzer and why you should not put `!`s ("bangs") in your code.

Today, together with Alejandro, I'm interviewing Sebastian Graf who is a very active GHC developer at the moment. So the first natural question, of course, is "How did you get to GHC?", and, maybe starting before that, "How did you get to get to Haskell?"

_Sebastian Graf_: Hi there. I'm Sebastian, thanks for having me here. I got into Haskell basically when I was in my fifth semester back at university and I was interested in finding other programming languages. I remember I had this website tab open all the time which was something like fledgling languages list. It listed all the current and new programming languages of late and I kept on clicking on new entries to find out what was their deal. So, of course, Haskell has been around for a long time back them. But, actually, the first time around I remember having seen it, I wasn't very convinced because of camel case. Basically, syntactic concerns.  But I think that after a while it really made a click back when my main language actually was D. So I basically came from C# to D and then Haskell.

_JB_: What is D?

_SG_: D is a language which, in spirit, is a bit like a better C++. Also, feature wise is better C++. It took the whole template stuff to a whole new level, this metaprogramming stuff. It is a very engineered language.

_Alejandro Serrano_: I remember before Rust made its appearance there being a new systems programming language you should learn because everyone agreed that C++ was not so nice, 20 years ago when nobody knew how to do it better.

_SG_: So, basically, I think D started from C, I guess, and tried to iterate upon it very muck like C++ did. But it isn't compatible with C++. It included a C parser though, I think, so that you can include your C headers directly.

Regardless, so this was what I started out with and I liked D for its metaprogramming stuff. And then i found out about Haskell and was very surprised that you could actually compile programms that would execute efficiently.

_AS_: In what ways was that surprinsing?

_SG_: It's all this laziness stuff and these theorical underpinnings. It's a very high level language, right? You declare your program in expressions and the compiler figures out how to execute this program for you. It's not all clear in which order you execute it and how to do it efficiently. The compiled is allowed certain things but it also has to preserve lazy semantics. This preservation of lazy semantics, in my head, gave rise to a very inefficient underlying execution.

_JB_: But how did you find out that Haskell actually can compile reasonable efficiently? Because I think one of the misperceptions of what you said there is that Haskell is an academic language and it's not usable, it's slow. But how did you notice that this is not the case?

_SG_: Well, I think I saw and read a few blog posts. I saw the entries in the benchmarks game which were like "Whoa, Haskell reaches C performance in some benchmarks".

_JB_: What is the benchmarks game?

_SG_: It's the language shootout. I'm not sure if it has been renamed in the past couple of years.

_JB_: Okay, is it this website that compares implementations in different programming languages for the same task?

_SG_: Exactly.

_JB_: Ok.

_SG_: So basically what got me into Haskell in the first place was, of course, this radically new idea of writing programs. But also then I was very amazed to find out that it can be executed efficiently, that the optimizer does such a good job.

Ultimately, I decided to finish my Bachelor's, of course, and then go to Karlsruhe for my Master's. The fact that a certain Joachim Breitner -- who is now the chair for the Programming Paradigms group where I work at --, the fact that Joachim worked there was part of the decision to go to Karlsruhe. I wanted to do more stuff in Haskell and I knew that Joachim was there so it was quite natural for me to go to Karlsruhe.

_AS_: I find it quite interesting though that the usual story when people go to do some Haskell is that they are interested in the type level or very high level parts of the language and your story is that you were actually interested in this part which we don't talk about so often. I mean, we usually blame laziness more than be inspire by it. So I find it quite nice that the story takes a different turn at some point.

_SG_: Yes. I mean, the type level stuff I find interesting to write. But often I find more interesting the fact that you can do this high level type stuff and make it so that the compiler generates an efficient program out of it. I like types and efficiency is basically what I'm saying.

Of course, now I'm not playing around too much with type level stuff these days but I really appreciate that Haskell has the means to express as much of my invariants as I want to in types.

_AS_: So what are you playing around with these days, then?

_SG_: Well, just today I'm planning to use Generics SOP to do some generic programming. For example, some higher level type stuff. Not sure about that actually but I follow the developments very closely. Maybe also because I'm a GHC dev.

So, I really am into this linear typing stuff and I'm exploring these days whether we can have a language extension that automatically derives mutable constructor fields -- for which we have a proposal, actually -- in a way that allows a transient workflow, where we can freeze and thaw our data types.

_JB_: I think we need to unpack that a little bit.

_SG_: Maybe we should come back later for that.

_JB_: Yes, let's finish the story from the Bachelor's point to where we are now. So, you said you are a GHC dev now. How did that come to be?

_SG_: So, I did my masters in Karlsruhe and then I prodded Joachim enough to work with me so that he would work with me. I did my masters thesis then with a topic he devised. Namely he wanted to compare two analysis passes in GHC and see if one subsumes the other or how they're related to each other.

I wrote my Master's thesis and then Joachim recommended me to Simon, or tried to nudge Simon into starting a new project with me. From there on, I worked pretty closely with Simon Peyton Jones.

_JB_: Did you actually go to Cambridge or was this purely via email?

_SG_: So, first off, this was all purely by email. And, of course, Skype, Zoom or whatever technology. Simon then started to recommend me to visit him in Cambridge as part of a sponsored internship from Microsoft Research. We were very happy when Microsoft actually accepted my application.

So I went to Cambridge to work with Simon in person for 3 months. It was a very productive and very valuable time to me. This was in the summer of 2019. I think that Joachim did the same a couple of years back, so I was just another copycat, basically.

_AS_: So what I'm wondering is what was your first commit in, I don't know, were they using Phabricator or they had already moved to GitHub and GitLab?

_SG_: They definitely still used Phabricator, which was the old project for code review, I think ultimately based on or started by Facebook. Meanwhile, GHC development has moved to GitLab. But at the time I started it was still on Phabricator. So I had to learn the old ways of commiting stuff and reviewing patches and so on. I'm not actually sure what was my first commit.

_JB_: I just looked it up. So your very first commit was from February 2018, "make `shell.nix` less broken". So it looks like you were fixing the Nix setup which some people were using back then.

And then the first real commit is "Add 'addWordC#' PrimOp"

_SG_: Ah, yes, alright.

_AS_: No, not yet, this is not allowed here. You have to explain yourself. I see hash (`#`). For me hash is an acronym for magic in GHC. So I guess there's some internal thing, some new optimization primitive?

_SG_: Maybe. So the `shell.nix` commit was basically useless because I think it was broken afterwards still.

_JB_: That's why it said "less broken".

_SG_: Yeah. So the "Add 'addWordC# PrimOp" commit I think was related to an add with carry instruction that we didn't have any primops before. I think I wanted to use it to write a more efficient `EnumFromToThen` implementation which is used in the `Enum` instance of `Word` for example.

So the `Enum` instance is basically responsible for the syntax that you use when you write `[0..]`. So this is the instance I was trying to optimize basically.

_JB_: So I'm trying to see what we can get out of this for people who may be thinking if they could contribute to GHC. We see now the end result: you've submitted a patch and it was somehow merged into master. But what happened before? Like, and maybe we can take a different example or this one, just as you like, but how did you even know that there was something to do? And then, how did you get that in? Was it hard, especially in the beginning when you were still an outsider to GHC development?

_SG_: So, I had some help from you and Simon. The actual way in which I felt I could simply get work done on GHC -- the best tips I have --, is just pick an issue that you think you can solve or that you feel like it's important to you. So you have to identify that with an issue that you think "this is worth fixing and I really would like this to be fixed".

Then you basically go ahead and write a comment below, "I want to fix this. Do you think this would be possible for me to fix?". Basically ask for help and guidance, more like guidance I guess.

Then you should join the `#ghc` IRC channel where most of the offline -- no, not really, online -- communication takes place, where the behind the scenes communication takes place at least. There you quite often get pretty instant help if you don't know something. In the best case, you get a reply within a day on your issue and someone says "Yeah, go ahead. Here is someone who has made some work or some progress on this. I thought about it in the past. I think we should basically do this and that".

Then you got your roadmap set and you can begin hacking. I think the "begin hacking" part is a bit daunting, because GHC is a really big codebase. It's not like super huge, but it has an intricate build system because there are all kinds of bootstrapping going on -- which means that the compiler has to compile itself, basically you compile the compiler with an old version of GHC and then the compiler compiles itself anew with this bootstrapped version.

_AS_: I think you're making it short. I think it compiles the new one, the new `base` library and then with the new `base` library a new compiler compiles itself and then... So there are so many places where it can break.

_SG_: So it not only compiles `base`. It also compiles all the -- I think we call it -- boot libraries or boot packages: `transformers` for example or the `unix` package, `text`, `network`, ...

_JB_: `directory`.

_SG_: Not sure if `network` is included. Maybe at some point it was.

_JB_: `cabal`.

_SG_: Yeah, `cabal`. It takes like five minutes or something you have to suffer through for each bootstrap.

So, first understanding the build system itself is a task and then, of course, you have to basically set up your machine to be even able to build, right? So there are wiki pages that explain this and there's actualy now a working `shell.nix` that you can use as an external repository which is maintained by Alp -- I forgot his full name at the moment.

_AS_: Is it Alp like in Alp the editor of our podcast?

_JB_: I think that's our very own.

_AS_: I cannot pronounce his name either.

_SG_: Alp, our frontend telling guy. He hosts this -- I think he's Italian, I'm not sure actually --, so he hosts this `ghc.nix` repository.

_JB_: We didn't make the connection as well. I started using that as well not that I tried to get back into GC development a few weeks ago after some years of being too busy with other stuff. Now I'm using it and it's very useful. So, thanks Alp! While you're editing this episode we can give you some praise.

_SG_: So, we're basically using  his work on `ghc.nix`. I think it's now became a community effort to keep the repository up to date. It works flawlessly as far as I can tell. You just point your Nix shell at a particular URL or local checkout you want and you get a working environment in which you can build GHC including or excluding all LLVM, build the docs and whatever else. This is very useful in getting you started.

Oh, I'm also using Laurie (??) and a couple of extension apps that make it easier for me to get the right environment and still work in zshell.

_JB_: That sounds all very Nix heavy so far. Is that something that if you want to contribute to GHC you better be willing to also learn Nix or is it not a requirement?

_SG_: It's not really a requirement but,... I've not checked the wiki page in the past couple of years. What I really like about Nix is that basically whenever it starts breaking I only have to pull the new `ghc.nix` repository and rebuild my Nix shell and everything works as I expected.

_JB_: So I guess it's just like anything else with Haskell and Nix: no, you don't have to use Nix, but if you try it, you won't come back anymore.

_AS_: I am the person who never uses Nix because I have a Mac laptop from work where I use it because that's the beefy machine and Nix sort of works but it doesn't always. I think it's better than Windows. So I still use the old build system -- I mean it's new now, also the build system is being changed to this new Hadrian thing which is no longer Make. You can do it, it works. So, usually, when I tell people about this, I first recommend to try to use it. I think there is a `ghc.dev` or something like there that is like a tutorial. This is before people have to, you know, buy into the whole Nix, because it's hard to convince to adopt two things at once. It can be done, and maybe it's more pleasant to use Nix but `ghc.dev` is good enough.

_SG_: Yeah, I completely forgot about `ghc.dev` which is a URL you can put into your browser and it lists a couple of workflows and it tells you what you have to put in your command line. But I see it also uses Nix, specifically `ghc.nix`.

_AS_: Maybe it's been updated since I last looked at it.

_SG_: I hope that the wiki page still works. But I'm not the one who maintains it so I can't tell actually and I'm not using it either.

In the past, I rememeber, when I moved to a new machine I had to re-setup all the stuff that is listed there and I remember that it was quite tricky at times, especially when I worked on a Windows machine -- the whole MinGW shell. It breaks all the time.

_AS_: It's Windows.

_SG_: Yeah. So nowadays it's much better to work on Windows. You can just use the Windows Subsytem for Linux. With the second version you are basically on Linux on a Ubuntu image and if you want you can use Nix too.

_JB_: Do you know if Simon Peyton Jones uses this subsystem too now?

_SG_: Yes. I'm not sure if he uses version 2 actually. I think he is because he reported some errors on the mailing list a couple of months back, but I'm not too sure. But I know that he uses it, he used version 1.

_JB_: Before that, for a long time, Simon Peyton Jones was probably the only active GHC developer on Windows. He was actually building on Windows so while all these other people were working on the build system and everything on Linux it was always Simon himself that was the first to stumble about some problem building on Windows. In a way, it's a waste of time because you don't really want Simon to be the one who has to discover these build errors. On the other hand it probably was very good to keep GHC buildable on Windows and Haskell in general be so good for cross-platform development.

_SG_: So I think back then we didn't have a Windows job in CI. Today we have a Windows job in CI so at least the configuration we run in CI should work -- well, for some definition of "should work", because there are many fragile tests and so on that will or will not fail. But I think building should still be possible on Windows. I think Andrea ______ _(??) who work's basically on GHC's backend stuff is also on Windows. Not sure if nowadays he uses the Windows Subsytem for Linux or not.

_AS_: Good, so I think we've convinced everybody that, you know, if you put in the effort, nowadays getting the source and building GHC is easier than it used to be. But I think it's also interesting to know what you are doing apart of how you do it. You know, what kind of contributions? Do you have a long-term project that you are working on? Do you work on small things here and there? How does it work for you?

_SG_: I think it's a mixture. So I have a couple of smaller things that I committed over the past couple of years which were more like bug fixes. It's interesting in GHC because if you only focus on a component of the compiler and keep on fixing bugs there is almost always a pattern that emerges and in case of the pattern match coverage checker -- which I basically adopted I think 3 years ago ...

_AS_: You mean "adopt" as in "taking care of it". Like a "foster parent", so we call it?

_SG_: Yeah. So it was basically Simon saying "oh, you got some spare cycles?" and I was like "umm, maybe?" and he was "oh, look at the pattern matching coverage checker". This emits the pattern match warning in the compiler. There were some open issues there, I fixed a couple of them.

_AS_: Can you maybe give us an overview of what coverage checker means? So you mentioned it's about patterns. But what is the role? What is that part of the compiler?

_SG_: Right. So the most basic part is, you want your patterns to be exhaustive -- which mean, if you match only on `True` your function fails to match on `False`; then if it's called with `False` you get an error at runtime. So, surely, the compiler should yell at you and say "well, are you sure you don't want to match on `False`?". This is exactly what the compiler does. Now, there are more tricky examples with nested matches and so on.

_AS_: But anyway, the role of the coverage checker is the part which emits those warning.

_SG_: Exactly. So it analyzes your source code and then finds out which cases are missing in your patterns. It also emits warnings when there are redundant equations. But I think the missing patterns are often more harmful.

_JB_: But that has been around for like decades. What is it that you do?

_SG_: Exactly. So, there a couple of unique Haskell features that interact in pattern matches. For example, strictness (respectively laziness), which means that an equation might not be totally redundant. But if it has a `!` somewhere, if it forces something, then you can't leave it out because if you put an error in the place where you are forcing something then it crashes at the call site. But if you don't force this thing and just ignore it, then it will just call the function and it will return `True` or something like that.

_AS_: Right. So it's this case -- not the same thing exactly -- when you list all the constructors versus listing all but one and then leaving the other one as an `_` or something like this? I mean the best example where it will be forced, because you know the constructor. But sometimes saying what should go there is different than saying `_` because then you are not forcing the value.

_SG_: So, imagine that you have the `Void` data type. The `Void` data type doesn't have any inhabitants. But if you write a function that goes from `Void` to `Int`, by defining `f x = 2`, then if you call it with an error (because there is always an error inhabitant of any type in Haskell) then this function will return 2. But if you put a `!` on this x (`f !x = 2`), then it will crash. This is the basic difference here. So, strictness is one of these issues where it's terribly important to take care of the details and track which things are false and which aren't.

Another thing is type level evidence, right? Matching on GADTs constructors can unleash type evidence which may render some other cases in your pattern match redundant. Programmers might even write their programs in a way that they think that the compiler knows that some case can't happen anymore. They will leave out that case and it's important that the compiler doesn't then yell "well, you forgot this case here". The user thinks "well, I omitted it because it can't happen". It's important that -- for a suitable definition of "can't happen" -- the compiler should also see that it can't happen.

Since you embed basically any Turing complete language in type level Haskell stuff via GADTs and what not -- for example, a Turing machine or a Prolog interpreter --, it's also pretty obvious that you have to stop at some point with this reasoning and that it can be inefficient at times.

Most of the open issues at the time were about the inefficiencies of the pattern checker. I fixed bugs and fixed bugs and I was like plugging one leak after another and at some point Simon came in and said "Wait, explain what you did here". I explained it to him and said "I need this" and "I need this" and then "I need some kind of some crazy constraint system" and what not. A day later he said "Well, let's just change this. Let's just break it down into simpler problems first".

He basically broke it down to 3 different data constructors for the intermediate representation in this analysis and it made it all vastly simple. This is basically how one of my papers came to life, featuring Simon and me.

_AS_: So, something I was wondering about. You mentioned that GADTs make the type level Turing complete but we also have guards in patterns, right? I always assumes that the coverage checker will not look at those except for like, I have a `False` and a `otherwise`, that simple. So, now that you mentioned this, I'm actually wondering, does the coverage checker look at guards as part of this thing? So does it know that if I write `n > 0` then it will be smaller in the other branch?

_SG_: So, it does look at guards, but only if there are pattern guards. So a pattern guard is a guard where you match on some constructor in the result of some arbitrary expression. Right now, if you manage to always put the same expression on the right hand side on the different guards that you want to match and you cover all the cases on the left hand side then I can guarantee with reasonable certainty that this will actually not emit a warning.

So, there is some reasoning but it's pretty syntactic. It just assigns one representative to each syntactically equal expression and it just replaces the expression with one variable and reasons about the value of this variable. So, it sees that every case this value can take has been handled by one of the guards.

But, it doesn't do any arithmetic reasoning at the moment. So, if you write `n > 0` and on the other case `n <= 0` it won't catch it. So you still would have to write `otherwise`, which has some special handling because, basically, it's just `True` and it will never fail.

_JB_: I didn't know that it was actually looking at guards.

_SG_: We need that because you also want to support view patterns. For example, if you have a view pattern and the part inside is `Maybe Int` for example and in one case you use this pattern `f -> Nothing` and in the next case you say `f -> Just n`, then this will also be discovered as a complete match. So it won't flag any missing patterns for example.

_JB_: Ok, that's good to know.

_SG_: It's very beautiful because the core of all of this is, I hope you see it, the similarity between view patterns and the guards that I alluded to before. You can basically desugar view patterns into guards and the paper was all about what can you desugar into these guards. It turns out most of the source level complexity can be desugared to guards. So we called our paper "Lower Your Guards". Maybe "Lower to Guards" would be better but "Lower Your Guards" was the catchier phrase.

_JB_: So you're writing papers about the stuff you do on GHC. Does that mean that your work on GHC is a part of your academic career?

_SG_: Yeah, one could say so. It's also probably responsible for the fact that I've been doing my PhD for almost 4 years and there is no end in sight yet. It takes a toll because it's a trade-off. GHC has many industrial users but it's still a research compiler. Naturally, if you want your code to land in GHC, you have to satisfy certain quality standards, in regards to documentation but also in regards to performance and basically all quality of the code. It's frustrating a bit at times because much of your time isn't actually spent working on the actual problem. But you also have to make sure that you actually nail all the special cases and that the compiler doesn't get slower, and that Simon understands your code, and so on.

_AS_: I could imagine this like if you are working on some kind of idea of functional language and you put it into GHC and then suddenly, I don't know, you have linear arrows. So, have you thought about linear arrows? No?, okay then more work for you.

_JB_: So the performance test suite can be very merciless. You've built this fancy idea and you know it's the right thing and you really want it out there and then some random test case degrades by 15% and you just wish it wasn't there because now you have to track down why that gets slow. Finding out why something got slow when it looks like it's compiled the same means it must be some of the libraries and you have to compile the libraries and so on.

_SG_: Or the compiler itself might have slowed down because of the optimization that you tweaked actually affected how the compiler was compiled and then there is a space leak somewhere that you have to debug as well. It's a bit frustrating, as I said.

I think many of the suff I focus my work on is related to optimizations and analysis based on the Core IR. So I had a couple of times that I had to debug performance issues.

_AS_: So what kind of analyses are you working on?

_SG_: Actually, nowadays I'm working on the demand analyzer. Most importantly, it's a strictness analysis which means it tries to figure out which heap objects it can evaluate before it calls a function. The strictness analyzer tries to find out which arguments are used strictly -- which means are evaluated in every code path -- and then a transformation goes by and just evaluates all arguments at the call site prior to actually calling the function -- which is what we are used to from strict languages, for example OCaml, Lean, Java, ...

_AS_: So it goes a bit on the idea that analysis is really cool but if we can remove it we can get some time back, right?

_SG_: Right, so the ideas is that you run this analysis to do the transformation afterwards. Both combine to an optimization which means that the generated code will get faster, and if you run your program frequently then you will get back some time.

_AS_: Cool. So I have a couple of questions about this. So the first is, can you tell us a bit how you can actually reason about this? Because apart from the usual case of, you know, I have a `!` in my argument, and then my usage is simple, what kind of reasoning can you do with real Haskell functions about this demand analysis?

_SG_: I think there is actually not really a simple way. First off, you can always check whether you assumed right by looking at the Core, which is GHC intermediate representation. You can dump out the Core with a simple flag you pass to GHC and then see the optimized Core. So, if something goes wrong, you can be really certain that you see it in the optimized Core. This is a bit frustrating to do because you would have to repeatedly dump the Core when you make changes to your program, which is probably not worthwhile. There should be some automated tests to catch that. I'm saying that because Joachim wrote something in this regard which is introspection testing.

_JB_: Inspection testing. Yeah.

_SG_: I think that library could see whether some function is strict in its arguments or unboxes its arguments for example. This is crucial for `Integer` performance for example. So, unboxing happens when GHC knows or thinks that some argument is used strictly and when it knows that the function doesn't actually use the boxed version of the integer. Then it can simply unbox the integer, which means that you don't get a heap record at all.

I think I'm drifting away from the original question which was how can I reason about the strictness of my code? The simplest thing is just play "strictness analysis" in your head.

_AS_: Which is a bit my question. Like I don't know how could I play a strictness analysis in my head, apart from the very very naive cases. So it somehow it looks to me like a harder question than the pattern match analysis which seems to be more syntactic in nature.

_SG_: I think the idea is you have to think what gets evaluated if you evaluate the function body. So if you have a function body you only put a `seq` on it, you don't evaluate it any further. You don't evaluate it any further, because every call site puts the `seq` on it, but only some evaluate it any further.

_JB_: So `seq` is this Haskell function that  takes two arguments and just looks at the first one a little bit to make sure it's not a thunk, it's not an unevaluated expression. But it doesn't use it for anything else and just returns the second one.

_SG_: Yeah, it's basically like if you do a case or a pattern match just on the outermost constructor and then you don't do anything further with the rest of it. Maybe put it in a list or something, like a lazy use.

So imagine that you put the function body under a `seq` and from then you reason about how does this expression under `seq` uses its free variables, the variables that it references. For example, if you're `seq`-ing an addition, the addition is strict itself, so you need to know whether or not the function that you call is strict in its arguments. Addition for example is always strict, so you get to know that `(+)` uses both arguments strictly. You use the results strictly and then you get ro reason recursively and combine your results afterwards. This works for non-recursive functions pretty well. But in the case of recursive functions, like, let's say the factorial function which returns `1 * 2 * ...` until the `n` argument, if you write it in a non tail recursive way (return `1` for `0` case and `n * factorial (n - 1)` for the recursive case), for such a recursive function then you just assume that the recursive call just uses all its arguments strictly. Then you analyze the whole function and combine the 2 clauses and if you did so and the function actually uses its arguments strictly then you guessed right. Otherwise you have to reiterate and maybe it is that factorial uses the argument lazily (because of some fact you've found) and then you reiterate until you reach a fixed point.

This sounds complicated and is complicated in a few special cases. But I think it often gets the job done rather well. So this is how I normally reason about strictness of course.

One other way to make sure that your function is strict in an argument is to just put a bang pattern on eveyr case of your function in that argument position. This is the conservative thing to do.

_AS_: But, for example, is your analysis more compositional? In the sense that maybe you know you can discover that this function which calls these other 2 functions, toghether they are strict so you can actually optimize the code better than you would do by hand. Reasoning about functions which call other functions strictly and so on becomes very hairy, very very easily.

_SG_: Yeah, exactly. So that is actually a problem. So, try putting `!` on arguments that you think you want to evaluate strictly, if you know that you don't ever want to call with an argument that could be used lazily (which would be very costly), I think it's actually a good thing. But it clutters your code and it's unclear whether if you put `!` everywhere if they are necessary or you put them there because you wanted to make sure.

_AS_: There are proponents of this style. There is a strict language extension which is essentially adding this and making every argument strict. So i guess some people find some use for this.

_SG_: Yeah. I also find myself doing this when I want to tune code and I  want to just see where I can get if just everything was strictly used and see if I basically oversaw an optimization opportunity in my code in terms of where I could put a `!`. So, the upper bound would be to just use everything strictly.

Surprisingly often if you do this the overall performance of your module gets worse. Because you evaluate stuff that you weren't supposed to evaluate, that you wouldn't have to evaluate. But sometimes it also gets better. So I drill down to where I have to put that one `!` to force just enough to have performant code again.

_JB_: I think I once saw a paper where they tried to basically randomly put `!`s everywhere and tried to find the combination that gives the best result

_SG_: Yeah, I forgot how it was called. But it was like a genetic programming approach where they just tried `!` and saw what stuck.

I mean obviously, this is only if you don't want to touch the code afterwards. Because if you touch the code and refactor it and maybe put some clause before some other then you also change the strict properties of your function.

_AS_: So, something that maybe it's not immediate but I guess, the GHC has to save this information somehow. I always wonder how this is saved because it's something that you cannot easily inspect and I would myself love to be able to say in some kind of type signature -- I'm not really sure how this would look like --  but say "look, I really think this should be strict, so compiler please make my thing strict". This is something which is not available to us in GHC as far as I know. So we are allowed to do a lot of things with our types but it seems to me that we don't have the same abilities on the memory representation of the values themselves. Maybe you can shine some light about how we can actually see these or what are your ideas on this.

_SG_: So you can actually see the strictness signatures of the functions that are exported from your module. We have this mostly for debugging stuff, but you can always debug your own code and look at how the strictness signature of some exported function looks. The flag is called `-ddump-str-signatures`, or something like that.

_AS_: Okay, so something like that right.

_SG_: Yeah, the flag is not particularly important right now but you can dump these signatures and then you get a certain syntax out of it and see how often some argument is used and how its componets are used. You don't only get information about the outermost constructor, you also get to know if the function uses the first field strictly and the second lazily and the third maybe not used at all -- which means it's absent and if we unbox the record we don't even need to pass it. So yeah, this information is readily available and you can check it if you want to see if something went wrong during your optimization. Then maybe put a `!` there and recompile and see if it works better.

_JB_: So it shouldn't be too hard to write a little GHC plugin that maybe allows you to put annotations in the source code for the strict signatures you expect and then it will complain if it's not matching and then you can paste the real one there if you got it wrong or work on your code.

_SG_: Yes, it seems that would be very useful. Our test suite has some regression tests for strictness signatures and it compares them textually. I always thought that it would be far more comfortable and easily testable if we just had this kind of annotations but I didn't get around to writing them.

_JB_: Might be nice. I wonder if you can use GHC plugins in the test suite because sometimes you often want to test something for the GHC that you just build. It doesn't have all the necessary dynamic libraries needed to load plugins, but maybe it's not too bad.

_SG_: I think we can use this for a lot of internal annotation stuff. But nobody has implemented it yet, so we stick with what we have. I think you're right in that this would also be valuable to Haskell users, for the reasons we just mentioned. It might be work to think about it. The compiler could emit a warning or whatever and you would see in advance whether you need to put a `!` on some argument rather than litter your code with all these bangs. Alternatively, you could just maybe have a strict pragma on a function granularity. That might also be worthwhile.

_JB_: I guess one practical problem would be that the strictness analysis GHC of course evolves and changes from version to version, including the way that these are printed out. It's always the problem that once you surface some feature people care about it being more stable and then it's harder to evolve at some times.

_SG_: So this plugin would probably mostly be worthwhile for me a GHC developer.

_JB_: So with all the work that you're pouring into GHC to make it better and faster and whatnot, are you actually using it? Like a developer, to build something else? Or it is just that's all you do and there's no time left for anything else?

_SG_: Actually I like building GHC. so this is actually the single project that I'm working on. Actually I have a couple of libraries on Hackage but they are mostly even boring. So I have a library that replicates the map data type but for partial orders and it's a flop because it's not even faster than just using an association list. Anyways, stuff like that. I explore some ideas as libraries sometimes, but I don't have anything I actively work on at the moment because I spend the free time that I have with playing music in orchestra and whatnot and there isn't actually much time left to put into other Haskell things at the moment. But that might change in the future.

_JB_: This is also an effect that I reckon I know: Once you're stepped down one layer below and you're working on the compiler then it's hard to use it because everytime you use it you find something you want to change about the compiler and then you end up working on the compiler again.

_SG_: Yeah, exactly. I think the problems in the compiler are the most interesting for me to solve at the moment. So I spend my time there and well maybe I also lack a little bit of exploratory imagination for coming up with problems I want to solve in Haskell, other that compiler problems.

_AS_: Don't worry, I think we have enough problems already. It's better to imagine solutions than problems I would say.

_SG_: Yeah, I agree. So no other projects at the moment that I push along.

_AS_: Cool. So, yeah, maybe one last question about all this. So we've been talking a lot about strictness analysis and all of that. I always wondered given that you know how GHC is, when we talk about performance in Haskell, apart from using the right data structure, we talk a lot about strictness. So do you think, and maybe this is more an overarching question, that laziness and strictness are the things you really need to know to get performant Haskell code or is it actually that we like to focus there because it's something which we can actually change because it is so easy to write `!` there. So what are your takes about how we write this performance code in Haskell?

_SG_:a So, I said that the strictness analysis is pretty important but there isn't much to gain anymore in terms of strictness analysis, at least as implemented in GHC. I wouldn't know how to do it in a way that would find out more strictness information.

_AS_: That's what I mean. So if I as a use want to make my Haskell program more performant, is learning more about the strictness a good thing or is the strictness analysis already good enough and it's hard to squeeze more juice out of the strictness lemon?

_SG_: Exactly, there is not much left in the strictness lemont. If the function you write in inherently lazy in some argument the compiler can't just evaluate it because there might always be an error something that blows under the argument..

_JB_: Unless the compiler sees all the places where you call the function.

_SG_:  That's actually an interesting problem, right? In that case you could actually exploit it. We don't do at the moment but we might in the future. so, other than that, the only way you can help the strictness analysis at the moment is to put bangs there and that's not terribly satisfying. But there's not much you can do other than putting `!` ther eon inline the function. GHC already tries pretty hard to do this. It inlines all kinds of stuff, it's pretty crazy how the inliner works. Actually the inliner is one of those transformations that makes the lazyness bearable in Haskell or any language for that matter. If you inline something you can put the stuff that is used lazily as near to the users as you can. Then it might become strict and be as performing as in the strict languages as there is no laziness involved any longer. I think this is how laziness scales and how GHC achieves its performance. By doing strictness analysis and so much inlining. You get a hot loop which most of the time is pretty strict and therefore you get no overhead.

But if you have a program that doesn't really have this hot loop then you often suffer death by thousand paper cuts. I think this is also in GHC itself. It has its own hot loops but I think that there is performance left on the table by the very fact that Haskell itself is lazy. But that's my opinion based on what I've seen so far and based on the problems that I've looked at and optimized so far.

_JB_: But I guess that one can always question that it is true that if you are writing Haskell and performance is of relevance to you then understanding evaluation order and understanding what strictness is, understanding where thunks are coming from and what a space leak might be -- this all ties together, the better your strictness analyzers are, the less likely you are to have unwanted thunks or space leaks. But there's something where the compiler can't do in the end, maybe this is the primary thing you have to worry about. Maybe after algorithmic complexity of your code.

_SG_: Right. So the compiler will optimize your program pretty well if you don't care about performance. That's the most important part here. And for that you don't need to worry about bang patterns and whatnot.

_JB_: That's a very nice slogan. I like that one.

Maybe that's a good slogan to end this episode on? Sebastian, thanks a lot for being on the show.

_SG_: Yeah, thanks for having me.

_JB_: Thanks Alejandro for co-hosting.

_SG_: Good bye.
