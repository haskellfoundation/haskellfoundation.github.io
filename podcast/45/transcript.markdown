*Andres Löh (0:00:15)*: This is the Haskell Interlude. I’m Andres Löh, and my co-host is Matthias Pall Gissurarson. Our guest today is András Kovács, a postdoc in type theory at Gothenburg. We are going to discuss how to go from economics to functional programming, how GHC’s runtime system is superior to Rust’s, the importance of looking at GHC Core for spotting stray closures, and why staging might be the answer to all your optimization problems.

Hi, András.

*András Kovács (0:00:45)*: Hi.

*AL (0:00:46)*: So how did you first get into contact with Haskell?

*AK (0:00:50)*: Okay. So, just to give a little bit of background, I started just doing programming in general, I guess, a bit later than many people. And so, I first picked up programming when I was finishing my bachelor’s thesis in Economics.

*AL (0:01:08)*: Oh, okay.

*AK (0:01:09)*: And at that point, I just started playing a very stupid flash game, which was about Turing machines, and just writing some random Turing machines to implement adders and multipliers and whatever. And I enjoyed it so much, and I thought that I should pick up programming a bit more seriously. So then I picked up Python, and I started doing Project Euler challenges in Python. I found that very addictive as well, so I just got obsessed with programming in general. So, I started picking up a bunch of different programming languages, like C and C++.

*AL (0:01:44)*: But you did all this on your own then driven by your own motivation or – 

*AK (0:01:49)*: Yes, yes. So, I did this on my own and actually in parallel with doing a bunch of other things, like having an internship in finance and writing some bachelor’s theses. And it was a bit detrimental that I got obsessed because I was not very focused on the other things. So, I just picked up a bunch of random programming languages. And then in the next year, I tried to pick up Haskell. And the first time I bounced off because it was not accessible enough, I guess.

*AL (0:02:22)*: Why did you try to pick up Haskell? Was it something – how did you hear about it, or –

*AK (0:02:28)*: I think I was just reading programming language blocks.

*AL (0:02:32)*: Okay.

*AK (0:02:33)*: I don’t remember which one exactly, but I also happened upon Lambda the Ultimate blog. And there was a lot of Haskell, so I just saw it being mentioned. So, I was motivated to try to pick up Haskell. But then the first time I bounced off because it was kind of mathematical, and I never seriously studied mathematics at that point in my life. So, when I looked at the documentation of Data.Monoid and there was something like Endo, and there’s like one line of description which mentions endomorphism. I was like, “What the hell? What is this?” And so, it was not super accessible. So, I bounced off. But actually, maybe like three or four months later, I tried again. And then I got much further. I was able to write more interesting small programs in Haskell. And then I got very motivated because it was very clear to me that this strong typing and the higher order functions just can be extremely expressive and convenient to do programming in general. So, I just had this feeling that this is actually a very good thing. And then I just went down into this rabbit hole.

*AL (0:03:47)*: Okay. So, did you use a particular book or other teaching materials when looking at Haskell, or just random stuff?

*AK (0:03:55)*: So, it was a combination of a few random things. I think I did look at “Learn You a Haskell for Great Good!” I also looked at the Hasker Wiki books. And of course, I also looked at people’s blogs. Also, I tried to read Edward Kmett’s blog as well.

*AL (0:04:16)*: So, by the way, which year roughly was this?

*AK (0:04:19)*: So, this was, I think, 2012.

*AL (0:04:23)*: Okay.

*AK (0:04:23)*: So, 2012 was when I got into Haskell.

*AL (0:04:27)*: Yeah. Okay.

*AK (0:04:28)*: Yeah. So, just a bunch of blogs, some books, Wiki books, and also Stack Overflow. And I used to be very active on Stack Overflow, so –

*AL (0:04:36)*: And what kind of programs did you initially try to write?

*AK (0:04:40)*: Project Euler. So, that’s what I started programming with. So, okay, let’s just redo a bunch of Project Euler in Haskell. And then just random stuff. But I pretty quickly moved to trying to write type checkers and type inference in Haskell because, as I mentioned, I was obsessed with just programming languages. And then I started to focus more on types and type systems. So, I was most interested in doing the type-level programming in Haskell, but then that’s painful. So then that motivated me to get into Agda as well.

*AL (0:05:24)*: Okay. 

*AK (0:05:25)*: So I think I very quickly found like my calling in type systems and type theory. And from that point, I mostly used Haskell to implement type systems.

*AL (0:05:36)*: So you looked at Agda like a relatively short time after you actually acquired Haskell knowledge. Do I understand that right?

*AK (0:05:43)*: Yes. So, I don’t know. Maybe it was – maybe a year roughly from starting Haskell, and I also got into Agda.

*AL (0:05:53)*: But you then did not drop Haskell completely and do everything in Agda from then on, but you continued using –

*AK (0:06:01)*: No, of course. No, because you can’t write programs in Agda, or some people would disagree, but then –

*AL (0:06:09)*: Yeah. I would say that this is somewhat controversial. 

*AK (0:06:11)*: Definitely. I know people who write programs in Agda, but not me. I write formalization in Agda and just experiments.

*AL (0:06:20)*: Right, right. So, you’re interested in running your program sufficiently?

*AK (0:06:27)*: Yes, definitely.

*AL (0:06:28)*: Okay. But you did – I mean, or you are, since then, mostly using Haskell in order to implement type systems for other languages? 

*AK (0:06:38)*: Yes. 

*AL (0:06:39)*: Okay.

*AK (0:06:39)*: Yes. Very much. Actually, almost everything that I brought for these prototype implementations and practical stuff is in Haskell.

*AL (0:06:48)*: Right. But then at some point, you must have decided that you also want to continue some sort of academic career in that direction, right? Or –

*AK (0:06:57)*: Right. So, after I did the bachelor’s in Economics, I went into Finance Master’s.

*AL (0:07:02)*: Which university was this?

*AK (0:07:04)*: So this was a university in Budapest, which is very hard to pronounce for most people.

*AL (0:07:10)*: That’s fine. 

*AK (0:07:11)*: So, I went into Finance Master’s, but then I was too much into programming. And actually, I completely lost motivation to study Finance. And then I just dropped out from Finance and went into Computer Science Master’s instead. And after that, I continued in Computer Science PhD. So, the PhD research direction was more like type theory in a more theoretical sense. So, not really type systems, but actually, I continued to do my hobby research on type inference elaboration, implementation of type systems. I never really dropped this, so I just continued doing it. And actually, I also published one ICFE paper, which was related to type inference, but all of my other publications were in pure type theory.

*AL (0:08:03)*: Yeah. It’s actually interesting because you were saying that when you first attempted Haskell, you were put off by all the mathematical phrasing of certain concepts. And then you have been switching over to something which is very strongly connected to mathematics, like type theory. So, did that ever cause problems and that you didn’t have a classical background like with an actual mathematics or a computer science bachelor, or did you just easily pick that all up on the side?

*AK (0:08:36)*: I would say I picked up quite easily what was required from me, the computer science education. Like in Computer Science Master’s, I did that very easily. And I think really the keyword is being a self-motivated learner in certain topics. So, if you’re a motivated learner, it’s not that hard. Or at least it’s not so much of a pain and stress to try to get to higher education if you are already motivated. Like, I also experienced the other kind of higher education when you are actually stressed and in pain most of the time, and nervous about exams and nervous about the future and how can you pass and whatever. So, it was like a huge contrast between these two different flavors of higher education. So, one was like pure pain, and the other one was like pure bliss. Maybe not pure bliss, but I had this perspective that I just really appreciated that now I can study something that I like.

*AL (0:09:43)*: I think there are quite a few Haskellers who are interested in type theory, but have never really got into it. I mean, perhaps, with your background of having done all this transition can give some recommendations as to like if you’re already familiar with Haskell, but you would like to know more about dependent types, type theory, whatnot, but feel like that space is huge and daunting, where to start? What would you say?

*AK (0:10:14)*: I would say I definitely try to do some proof assistance based on dependent type theory.

*AL (0:10:22)*: And would you recommend Agda then?

*AK (0:10:24)*: I think Agda is good. I definitely recommend, especially so if you are interested in type theory for the sake of type theory and type systems and not for the sake of formalizing random mathematics. And I think Agda is a good choice. So, if you can just pick up Agda and maybe this PLFA book (Programming Language Foundations in Agda—that’s pretty nice for an introduction), then you can start from there.

*AL (0:10:53)*: So, I think there are at least two questions that I would like to ask at this point. I don’t know which one you want to answer first. I know that you are now at Chalmers, so perhaps there is something interesting to say between the transition from Budapest to there and what the difference is between your postdoc now and what you’ve done before. But the other is how – you said used Haskell as an implementation language for type checkers, and probably you have all sorts of experiences to share, like whether that was an overall fruitful endeavor or a painful endeavor. So, you can just pick one of these.

*AK (0:11:35)*: Okay. So, maybe let’s start out with this Haskell and then trying to use Haskell. So, most of the stuff that I brought is in Haskell, and also, I really care about performance. So, I’m not sure why, but it’s just something that I do, that I care about performance. 

*AL (0:11:55)*: But was there like a moment when that happened where you noticed, okay, I’m writing something, but it’s not fast enough, or it’s clearly not good enough?

*AK (0:12:05)*: So, performance optimization is something that I always enjoyed. For example, like already when I was doing these Project Euler challenges, like there was also a competition in the forums. Like, who can –

*AL (0:12:17)*: Who can write the fastest?

*AK (0:12:19)*: Who can write the fastest version, and then yeah. And another thing is that I think it matters a lot for user experience in compilers and type checkers if they are fast. I think it matters a lot. So, just being able to get quick and interactive feedback from compilers is a massive bonus in writing any kind of program. So, this also just practically motivated this, is that, okay, how can we write fast type checkers? How can we write fast compilers, fast optimizers, fast interpreters, and so on? It is just something that’s convenient. 

*AL (0:12:59)*: Yeah.

*AK (0:13:00)*: And so then there is this interesting question. So, why am I using Haskell all the time to do all this high-performance type-checking and elaboration stuff? And there’s a bit of this meme, is that why don’t you just write it in Rust? I’ve been asked like, why do you use Haskell if you are really focused on performance? And interestingly, the answer is that, for the things that I write, Haskell is the best choice.

*AL (0:13:27)*: Okay.

*AK (0:13:28)*: And there are several reasons. So, one is that there’s a runtime system in Haskell, in GHC Haskell, which is very best suited to compilers and type checkers because it’s a high throughput copying garbage collector. And essentially, in compilers and type checkers and interactive proof assistance, what we really care about is that there’s some kind of interaction, there’s some kind of command, and we want to finish that workload as quickly as possible. We don’t care about having sub-millisecond latencies because you just hit your key and then you expect to get an answer like half a second later, or like 0.1 second later. So, we don’t really care about latency. And there’s also a reason that we cannot really do any manual fine-grain memory management for many things. For example, to do type checking for independently typed programs, we essentially have to run arbitrary higher-order functions, higher-order programs at compile time. And this workload has completely intractable space behavior. Like it’s completely statically intractable memory allocation patterns, so we really need to have a garbage collector. 

So, to do this kind of stuff, what we really need is a high-throughput garbage collector. We don’t really care about latency. And we need this garbage collector because it’s not possible to do manual memory management in a sensible way. So, we can try to use maybe some kind of arenas in the Rust or in C++. But then we run the risk of leaking too much space, so then we still need to have a garbage collector. 

So, the runtime system in GHC is really good, and the language itself is also quite good in comparison to other programming languages. The type system is nice and expressive. Type classes are nice. Higher-order functions are nice. Just strong typing in general is nice. So, the code quality and the code generation, and the optimization is also – it’s not the best, really, but it’s good enough. So, the machine code, which we get from GHC, is usually good enough for my purposes.

*AL (0:15:48)*: So, you spent a long time now saying some very positive and nice things about Haskell. So, I’m feeling that there is this big but coming at some point. I mean, I guess there are still problems when it comes to performance and Haskell, right? It’s not all easygoing.

*AK (0:16:07)*: No, no. It’s not all easygoing. So, the issue in Haskell is that although it is possible to write Haskell code, which is very fast, but to do it, we have to do like a huge amount of extra work. And the huge amount of extra work is just going over what GHC is actually doing with our source code and how it’s being compiled and then looking over it and then checking it. And the only way to do this that I know about is to write some Haskell code, compile it, dump out the generated GHC Core, which is the intermediate representation used by GHC, and then look over it and then check if something is wrong there. And if there’s something wrong there, then you go back to your storage file and then you fix it.

*AL (0:16:58)*: What would – like I mean, let’s just explain this in a little bit more detail for people who have never looked at Core. I mean, what would be an example or something that could be wrong?

*AK (0:17:10)*: So, wrong things are usually laziness, which is not necessary. So really, we want to get rid of thunks which should not be there, and closures which are not necessary. So, we also want to get rid of closures because closures incur some heal allocation, and they also introduce some dynamic control flow, which blocks other optimizations in the pipeline. And we also want to get as much unboxing as possible. And this last point, this unboxing, actually introduces its own set of inconveniences in Haskell because unboxing and code reuse is kind of at odd in Haskell programming.

*AL (0:17:57)*: Can you briefly say what unboxing is?

*AK (0:17:59)*: So for example, the int type in Haskell is not something primitive. It’s defined as a data type, which has a single constructor which contains a real primitive int, which is called int hash. And the int hash is a type of actual machine integer, which takes up one word. And the actual machine integer is the thing that we can do the machine instructions on, and it can be passed in registers or it can be stored on the stack. And if you want to do any kind of operation with int, and if we are using the boxed version of int, then it’s a pointer to some object which has a header, and it also has like one primitive machine integer, and then we have to unbox it.

*AL (0:18:50)*: Right. And the reason that boxing is done in the first place is because it makes all Haskell types look alike and because it enables us to represent unevaluated computations and basically gives you polymorphism and laziness as an approximation.

*AK (0:19:11)*: Yes. So, if all the Haskell objects which have types of kind \* are represented exactly the same way, in the uniform way at runtime, then that indeed provides a very easy way to implement polymorphism.

*AL (0:19:30)*: Okay. Yeah. So, you want things to get unboxed, but you were just saying that there is a tension between unboxing and reuse, I think you said, or sharing. Did I – yeah. 

*AK (0:19:42)*: Yeah. For example, if I define the list type or some tree type in Haskell, then for code reuse, I want it to be parameterized by some type. But reasonably, I can only parameterize the ordinary Haskell types of kind \*. But that means that at runtime, I am introducing this extra boxing. For example, if I have a list of ints, it’s going to be a list of boxed ints if the list type itself is parameterized. So, what I can do is I can just manually specialize. I just write a different definition of a list, which would be like just a list of ints. And now, because it’s not parameterized, it can be represented as a list of actual machine ints. Now, I lost some code we use.

*AL (0:20:32)*: So I can see if you’re looking at Core outputs that you can see whether GHC manages to do some unboxing itself. I mean, like I guess there are optimizations that GHC is applying, such as worker/wrapper or similar, that help with unboxing certain values. But if that is not happening, then what do you do?

*AK (0:20:58)*: I mean, sometimes I just write a Haskell code which uses primitive types.

*AL (0:21:03)*: Okay. 

*AK (0:21:04)*: That’s always an option. And then the code looks probably very weird to most Haskell programmers. That’s definitely possible. So, sometimes the issues can be resolved just by adding a bit more strictness or adding some INLINE pragmas or specialized pragmas. So, there’s like a spectrum of what kind of intervention is needed. Sometimes you can just write a very ordinary-looking Haskell code and maybe make a couple of fixes. But in general, the more indirection between your Haskell source code and what you would like to get in the generated code output, like the more abstraction you use, maybe you use some fancy types, maybe you use some type classes, maybe you are just writing some monadic code, and the monadic code already introduces a lot of indirection between what you would like to get and what you actually write in the source language. Because every single monadic binding is a higher-order function, which takes a function as its second argument. And if you take any kind of monadic code in Haskell and you compile it with -O0, what you get is a huge amount of dynamic closure being generated from every single monadic bind. So, if you just program with monad, you already have – you run this risk of things not being optimized enough. And then if you move on to maybe monad transformers or effect systems or your own custom monads, like your own parser monad stuff like that, you have to be more and more conservative and more and more on the lookout of things that can go wrong. 

*AL (0:22:45)*: So you said -O0 just now. So, in your experience, if you are writing any kind of monadic code in Haskell, are you basically already lost if you’re not defining your own special monads, or are there – like, is GHC’s optimization good enough, or what’s your personal take on this space?

*AK (0:23:10)*: So, GHC’s optimization is fine. So, I think for many concrete monads, GHC optimization is good. And it also depends on how much do we care about performance. Because if we are really laser-focused on performance, then even some very innocent-looking monads like Reader can be also a bit dangerous. So, for example, if you write a function which goes from bool to Reader, something of a, then you implement this function by just immediately casing on your bool argument. And then you have like case true, case false, and then you write something, GHC will sometimes make a mistake here because GHC will compile this function to return closures from this pattern matching on the bools. So, it’s like a case something of true and then lambda and case something false of lambda. So, even something extremely simple like Reader can be a bit dangerous. And if you get to something like error monads, then that is actually a big problem if you’re really focused on performance because now it introduces some unboxings and re-boxings because of this inability to specialize the error and the non-error constructors to unbox types. And it also introduces a bunch of complications in the strictness analysis because, usually in the standard library, these constructors are defined to have lazy fields.

*AL (0:24:50)*: Yeah. I mean, I guess we should put all this discussion a little bit in context because, like you were already mentioning, it depends a bit on how much you’re focused on performance, right? I mean, it’s not the case that you cannot write any program using monads or monad transformers or something. And depending on your applications, you may still have something which is objectively entirely fine. But if you’re like András focused on having everything run as fast as possible, then there’s certainly the observation that things could be much faster, right? And that there is quite a bit of overhead that you’re accumulating. And I guess you have seen examples. I think you’re working on Agda now, and you said you have seen examples where this is really an issue, like monadic code?

*AK (0:25:36)*: Yeah. So, in Agda, there are many issues. There are many issues in general in the code base. And probably the biggest issues are just the fundamental design. So, the fundamental design is really old. And it’s very, very easy to completely overhaul it. But there are also performance issues, which really just come from the style of the Haskell code that is being used in the code base. And one issue is MTL library in particular. So, I think this Agda code base is very interesting from this perspective because I think it’s one of the largest code bases that uses MTL in a very heavy way. So, the Agda is around 150,000 lines of code, and there’s MTL in many, many places and using a very heavy way.

*AL (0:26:31)*: Yeah. You’re saying in a very heavy way. Like just to get an idea, does that mean that there are many transformers being trained on top of each other, and how many? Like, I mean –

*AK (0:26:43)*: So, I can give an example. So, you know that in this MTL style of programming, people usually use these monad x classes. So, class is such that certain monads are the instances of this class. And essentially, using this monad x, we can abstract over any monad which supports a certain operation. And I don’t remember the exact number, but I think Jesper Cockx counted how many different custom monad x classes are being used in Agda, and it was around 30. So, I would consider that to be a very heavy usage of this.

*AL (0:27:22)*: Yeah. But I mean, there is a difference whether they are used individually at different places or whether they’re all stacked on top of each other, right? 

*AK (0:27:30)*: And they are also all stacked on top of each other. So, there is, for example, maybe a type synonym for a collection of maybe 10 different monad x constraints. So, it’s like type monad, whatever is defined to be a couple of constraints, which is itself a constraint. And there might be like 10 another constraints. And then there is like substantial amount of code, which is written with this particular 10 large bundle of monad x constraints. And so, the initial motivation for doing this in Agda, it was mostly done by Jesper, and his motivation was that he needed some kind of capability typing system because, like for example, there are things in the type checker or in Agda in general that we want to run in a pure way without introducing certain side effects. There are things that we want to run in a somewhat effectful way, like being able to do a mutable update on certain things, but maybe not everything. And then if you want to get fine-grained with this, then we can indeed use MTL to implement this capability system. 

And I think it’s a very good idea to have this such a system in types, but using MTL to implement it is a really bad way to do it from the performance and also from the compile times perspective. And the big issue is that if you write a lot of code in MTL, which depends on a bunch of monad x, then at some point, we will need to instantiate it into specific monads. But those points can be very, very far from the actual original definitions of the logic that we brought. And so, if we write a substantial amount of code, which is polymorphic in monad x, and then maybe in one module which imports that module, we specialize it to some concrete monad. And in a different module, we specialize it to a different concrete monad. There’s already a huge issue of code duplication, which is very much implicit and almost invisible in many cases. So, if you write big, complicated programs, then all these specializations happen automatically by GHC.

So, at this point, my usual method of writing code and looking at the Core fails because there is no single definition, single place of definition where I can generate Core and look at it, and check if it’s fine. Instead, I get a huge amount of duplication across different modules and a bunch of different versions of the same code. And usually, this MTL style also generates a bunch of code, which is in a larger monad than what’s actually needed, because you write some polymorphic code, and there’s usually like the simplest monad in which this logic can be implemented. But the MTL will result in basically code pessimization. And if you do like these specialization options in GHC – so, for example, in the Agda code base, we use the specialized aggressively flag, which generates a huge amount of code. And it will also pessimize a huge amount of code because of this MTL style.

*AL (0:31:06)*: I see. So, yeah. Do you have suggestions or what should one – I mean, not necessarily – I mean, I know that there are practical problems for rewriting a large code base from one day to the next, but if one were to start from scratch, one still wants in principle this sort of like fine-grained effects or something like that, then what could one do in order to avoid these kinds of problems? 

*AK (0:31:38)*: So, I think the general good solution to problems like this is to use staging.

*AL (0:31:45)*: Okay.

*AK (0:31:47)*: So what do we mean by staging? So maybe we can restrict ourselves to just two-stage programming where we have a compile time phase and then we have a runtime phase. And in a two-stage language, we essentially write a bunch of code-generating metaprograms in the surface language. And we can also embed definitions in the runtime language into the whole system. So, basically, we are metaprogramming as users of the language. And then in the first stage, or in the first phase of compilation, all the metaprograms are being executed, and they generate a bunch of code. And in the downstream pipeline, then we just take this code and then compile it further. 

And if you know about Template Haskell, that’s also a form of staging. And there’s also typed Template Haskell, which is a somewhat more strongly typed form of staging in Haskell. But Template Haskell is not very commonly used in the grand scheme of things in Haskell. It’s inconvenient. It’s weakly typed. Even if you use the strongly typed version of it, there is no full guarantee of well-typing of code output.

*AL (0:33:01)*: It’s interesting that you’re saying it’s not commonly used because, I mean, I know other people who are complaining that it is too widely used. So, I guess it all depends on perspective, right? So, I think it is very commonly used for certain things, but you are proposing to use it for different things for which it is not actually being used. So, like for example, I don’t know, Template Haskell being used to derive lenses or something like that. It’s like something, which is, I guess, a widespread application. But you are talking specifically about metaprogramming to perform optimizations at compile time, rather than just generate code that you don’t want to write by hand.

*AK (0:33:48)*: I mean, in a sense, even like – so, this use case of generating lenses is also about optimization because you could try to use generics instead. And then there’s this difference between the generic, like using generics to get lenses and using Template Haskell to get lenses, which I think illustrates the difference quite well, is that in one case, you are doing fancy things with type classes and types and then relying on the general-purpose simplification in GHC to try to get good code out of it. In the other solution, you are just writing the code generator yourself, and then you are not relying on anything to get decent code output. 

And I think it’s a very good idea if you really get this programmable layer of your compiler in the form of staging such that you can get some guarantees that you really get the code that you want to get. And instead of doing the general-purpose compiler optimizations, which are inscrutable and fragile, we try to take that logic. So, the general-purpose simplifier logic from GHC, we try to take that and just try to instead move it to the fully deterministic metaprogramming layer. But usually, the drawback and the reason that people are not doing this a lot or not doing it like very pervasively in programming is that the users have to work a bit more because we don’t just rely on the legendary sufficiently good compiler, but instead, we have to work ourselves. And the way that the staging and metaprogramming is implemented in programming languages is just not that nice to use, usually. It’s just not that ergonomic. It’s annoying and noisy, adds a lot of boilerplate. You have to write quotations and splices everywhere. And you have annoying module restrictions. In Haskell, for example, you have to put certain code in a different module. You cannot just reuse the same thing in the same module. So, it is just annoying. 

But what I think is that it could be implemented in a much, much nicer way, in a very unobtrusive way, and the quotes and splices could be inferred almost all the time. The module restrictions could be entirely removed. And we could also get extremely strong, essentially mathematical formal guarantee of that, I think of code output. And in such a system, I think it would be very nice to use this stage programming. 

*AL (0:36:39)*: So what you’re talking about now is basically your work on two-level type theory, right? 

*AK (0:36:46)*: Yes. 

*AL (0:36:46)*: That’s basically what you’re alluding to. Yeah.

*AK (0:36:49)*: So this is closely related to something that I’m working on right now, which is just to take this two-level type theory and just try to reimplement just ordinary Haskell functional programming abstractions using staging instead of using higher-order functions. So, for example, the question is, can we have monads, monads transformers, lenses, stream fusion, whatever, such that we never actually use any runtime closures? Because, as I mentioned, runtime closure is one of the evils that we usually want to purge when we are looking at GHC Core. And interestingly, essential usage of runtime closures, even in Haskell programming, is rare because people use higher-order functions and type classes for code abstraction. But what they really want to see is that the higher-order functions will be sufficiently inlined, also the type classes will be sufficiently inlined so that there are no actual runtime closures in the generative code and discover most of the use cases of higher-order functions. And by reformulating all of these abstractions in two-stage programming, we can make this very explicit, and we actually get a formal guarantee that we will not get any dynamic closures.

*AL (0:38:09)*: Right. So, just to get a little bit of a clearer idea, because we have to distinguish like the implementer of the libraries and the end user, right? I mean, in the ideal world where we had a full implementation of two-level type theory and somehow integrated into Haskell, how much would normal monadic programming or sort of monadic programming where you actually have several different effects? How would that look? How much would that look different for the end user?

*AK (0:38:40)*: Not very different. It would definitely change. So, for example, maybe you want to use monad transformers, but you want to get full formal guarantee of closure-free code generation. And by the way, if you have this guarantee, you also get the guarantee that all monadic binds will be sufficiently inlined and simplified because, as I mentioned, monadic binding is higher order if you just look at the surface language. So, if you do want to get this guarantee, then for example, if you want to store a monodic action in some data structure, then you have to somehow explicitly box it up, so you can just say, “Okay, let’s put a state action into a list,” because then you definitely need to introduce a runtime closure. So, you have to mark it as box of state action or something. But if you’re not doing that, then the style of code that you write is actually very close to what people are just doing in Haskell. 

So, this is actually what I’m working on right now. So, I’m writing a paper about this, and I’m also writing typed Template Haskell notes as a supplement to the paper. And most of the things can be just implemented in typed Template Haskell as well. And it’s very useful just trying to – just run it and see what happens. Like just to check whether something is actually feasible. But funnily enough, I have some monad transformer library, which is purely at compile time in typed Template Haskell, and you can write some MTL code.

*AL (0:40:19)*: So, that’s available right now?

*AK (0:40:21)*: It’s incomplete, but I will publish it when the paper is finished.

*AL (0:40:26)*: Okay.

*AK (0:40:27)*: And it’s funny that I can write some MTL style code and compile it with -O0, and I will get almost the optimal code.

*AL (0:40:36)*: Yeah. That’s quite nice. I mean, I certainly think that, I mean, there are many things wrong or imperfect with the current implementation of typed Template Haskell, but it is still underused, I think. Like, I mean, it is like there are many things that you can actually do with it right now. And it has a lot of potential for getting you further along this predictable performance line that – so yeah. I think it deserves more attention. But I mean, there are also many improvements possible.

*AK (0:41:07)*: Yeah. I mean, I do have to mention that you have to squint a bit and try to disregard all the quotes and splices and some explicit like lifting and other operations that you have to write in this time because these are the boilerplate that we get from typed Template Haskell. But maybe in a different implementation, we would have, as I mentioned, stage inference. So, inference for stage annotations.

*AL (0:41:32)*: Yeah. But I mean, even quotes and splices are – I mean, they’re easy noise to eliminate, right? Because they’re really just like extra annotations. And if you emit them, then the code still makes sense. I mean, there are other kinds of rewrites you can be doing, just as an example, because you’ve already mentioned this, like writing things using unboxed types everywhere. I feel like there’s more obfuscation going on if you are doing something like that than if you just put quotes on splices in a couple of places. So, I feel like people are sometimes willing to do much more heavyweight, invasive modifications of their code just to get it a little bit more efficient. So yeah, I think it’s – that part is not that bad. But of course, if stages can be inferred, it would be even better. 

So, circling back to the starting point, which was the use of or overuse or excessive use of MTL and Agda, if you had to redo Agada in Haskell right now as it is, like without waiting a couple of years for your perfect improvements to two-level type theory, what’s general advice for people like writing heavily monodic code in Haskell right now? Is it to basically do what you’ve already been doing to do like MTL style thing, but using typed Template Haskell? Or are there libraries instead of MTL that are readily available that you could better use or that, in your opinion, have less problems?

*AK (0:43:09)*: So, this typed Template Haskell monad transformers is just kind of, at this point, a proof of concept and some kind of experiment that I wouldn’t really try to use in real Haskell. And in real Haskell – so, if you want to write fast Haskell code, I think by far the most important thing is just this reading Core frequently thing. And without that, it is not really possible because then you just have some kind of – it’s too much of a black box. So, I’ve seen attempts at people trying to optimize Haskell code by doing fancy profiling and using some kind of tools to do analysis. But at the end of the day, it’s not possible because you will never actually understand what’s happening. So, I think reading Core is the most important thing.

And for like this using monads or like what kind of effect system to use if you want to get good performance – so, there’s this ReaderT IO pattern, which is pretty good. It can get slightly wrong. It can go slightly wrong, but not really wrong. So, this has definitely – I mean, it has been discovered a long time ago by people that if you use this ReaderT IO or try to base your effect system essentially on ReaderT IO, then it’s going to have a good performance. But if that’s too plain or too bare-bones for you, I think it’s definitely possible to implement some kind of this capability system in a way such that all of your type magic will be erased. So, I think it’s important that if you want to have strong typing for your effect, then you should try to erase as much of the type magic as possible. And this is the issue with MTL, is that you can use it to implement some magic, but then the magic will also show up in the generated code and cause some problems. So, for your capabilities, I’m not sure how this could be done, but for example, trying to use just dummy type class constraints, just constraints of nullary type classes with no methods, for example. Or phantom types is another way to do this. And this will be completely erased. And this is a safe way of doing – to getting a bit more safety.

*AL (0:45:44)*: But you would not say that, for example, like if you just use extensible effects library X, Y, Z rather than MTL, then half the problem is already solved.

*AK (0:45:54)*: Not really. I mean, I have not been keeping up with extensible effects libraries in the last couple of years, but my impression has always been that they are even a bit harder to optimize than MTL. So, another approach is to use the continuation primitives instead of trying to rely on GHC. And I think it’s not a bad idea. 

*AL (0:46:18)*: You mean the new delimited continuation primitives that have been added? 

*AK (0:46:21)*: Yes. So, I think it’s very good to have these continuation primitives in GHC. But if you really want to go for good performance for many effects, it will not be the best choice. So, for example, you just want to have a Reader effect. And then if you try to implement that with the continuation primitives, it means that whenever you just write an ask in your code, your whole runtime stack will be copied over to the heap up until the point of your handler and then discarded. So, if you just want to get an int from writing ask, then it should be just implemented as passing an int to a function instead of copying your stack over to the heap and then doing just this dance to get your int.

*AL (0:47:12)*: So, one slightly different question I have left. This is perhaps also with respect to your postdoc. I mean, you said like you’re very much interested in programming languages, and you have started using Haskell to implement type systems for more ambitious programming languages very soon. And then you said, well, Agda is one of those, and you’re also working on Agda, but Agda is not quite ready to be used. So, when or how close are we to a language that is better than Haskell that could also be used for writing highly performant code?

*AK (0:47:52)*: I mean – so, I don’t really have plans which are that long term. But I think – so, this very strongly typed two-stage language where we have the usual functional programming abstractions, but also with very strong guarantees about code generation, it doesn’t really exist. And personally, I’m very motivated to try to implement something like this myself. But if I’m being realistic, this is not a job for just one person, or maybe it is a job for one person, but then the one person has to work on it for at least five or 10 years.

*AL (0:48:30)*: Right. How would you see this as a completely new language, or would you add it to either Haskell or another existing language?

*AK (0:48:40)*: So, for existing languages, Idris by far is the easiest to extend with the staging feature. And I also briefly looked at this as a potential project. So, just try to add like this essentially two-level type theory feature too would be by far the easiest because Idris code base is small. The pipeline is simple. It is easy to modify. I mean, relative to everything else, it’s much easier to modify than GHC or Agda or Lean or whatever. It’s a much simpler and much leaner thing. And the type system is already perfect for the job because we just have a dependently typed programming language. And then we can just essentially just say that, okay, now we don’t just have one stage; we have two stages, and just add a bunch of texts to some internal data structures. Like just say, okay, now, I’m just tagging a bunch of things in the internal implementation with a bool, which says which stage I’m in. And if you compare it to something like GHC Haskell, the type system is a mess with all these different features of type families, type classes, and dozens of commonly used language extensions. And there is this difference between the runtime language and the type language. There’s also a non-trivial amount of erasure going on. So, it would be much more complicated to try to basically support all of the Haskell features in the generated code.

*AL (0:50:22)*: Yeah. So, I mean, to be honest, I mean, one of the things that I’ve always found a little bit confusing so far, but perhaps it is also just because I’ve not been reading the right papers in the correct order, is that when it comes to having both staging and full spectrum dependent types available in a language, there seems to be a certain overlap of concepts because all this type level programming is already a way of specifying certain computations that happen or ought to happen at compile time. In fact, one of the reasons why people are writing type level programs in Haskell is not so much because they’re interested in formalization, but it’s because they want certain things to happen at compile time. And then staging is effectively giving you the same thing, just in a more reliable way. So, do you actually need dependent types if you have staging or is there some –

*AK (0:51:21)*: So, I think this description is not entirely correct.

*AL (0:51:24)*: Yeah, yeah, sure.

*AK (0:51:26)*: Because if I have a dependently typed language, in order to type check my program, I need to run programs at compute time. But the programs that I run at compile time, they do not affect code generation in any way. So, there’s no such notion as running something at compile time and then generating code if you just have a dependently typed language without staging. So, I think there’s a lot of synergy between dependent types, at least in the compile time language fragment and staging. Because, for example, there’s a lot of generic programming research in Idris and Agda, and I think you also brought some of that yourself with this generic programming with index functors.

*AL (0:52:14)*: A long time ago. Yeah. 

*AK (0:52:16)*: A very long time ago in Agda. But there, what happens is that now because you have dependent types, you can write generic functions. The generic functions are like metaprogramming, but you still do not have any control over code generation because now you just have an interpretive overhead in your metaprograms because, yes, you can write a generic function, which pretty prints anything, but the way that it works is that you take a runtime description of your data type and then you do a runtime recursion on your description of your data time, and you still have no control over code generation. But now you can combine this with staging, and you can write the same program, which is still completely well-typed because you have dependent types. And now you can also make sure that you generate a specialized code for each data description.

*AL (0:53:12)*: Yeah. I mean – again, I mean, I don’t exactly know how to make the relation precise, but perhaps what I meant is that some of the things that you are doing using, say, GADTs or inductive families, you can as well also do using staging. Like if you take the standard example of dependently typed programming as always linked index lists like vectors. And so, you can see that as basically a computation from an integer that you know statically to some kind of type. And even if you don’t have full dependent types, you could try to do something similar if you just have staging available, right?

*AK (0:53:54)*: I mean – so, this example is something that you can do if you have no staging, but you do have dependent types because you can write a function which goes from number to types. And then you need dependent types to be able to write like a map function over the vectors that you define in this way. So, this is kind of – you don’t need staging to do this, but if you want to do this with staging, then actually you need dependent types to be able to do this with staging because you write exactly the same program that I just mentioned, except that now you also have a control over code generation. 

*AL (0:54:34)*: Okay. Yeah.

*AK (0:54:36)*: So, this is actually a good example for something that you can do without staging, but if you want to generate code, then you need dependent types for it.

*AL (0:54:45)*: Okay. 

*AK (0:54:46)*: And this is actually one reason that Template Haskell and meta is limited and annoying to use because, while in ordinary programming dependent types are usually not needed, you can just write ordinary programs without dependent types, in metaprogramming, the dependent types are much more useful. 

*AL (0:55:08)*: Yeah. So yours are basically saying that – yeah, that there is in fact a big synergy of these two concepts. Yeah. Then yeah, thank you so much for taking the time to talk to us, and hopefully, we all learned a lot about how to write more performant Haskell code.

*AK (0:55:28)*: Thanks a lot. Thank you for inviting me.

*Narrator (0:55:40)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
