_Niki Vazou_: This is the Haskell Interlude. I'm Niki Vazou, I'm here with Matthias Pall and our guest today is Jesper Cockx, one of the main developers of Agda and today we will talk about how to explain dependent types to your father, how Agda’s automation and proof search work, and how one uses Agda to verify your Haskell code bases.


_NV_: Hello everyone welcome to the Haskell Interlude. I'm Niki and I'm here with a co-host Matti and our guest today is Jesper Cockx. So Jesper, you want to tell us your background and how did you start with dependent types and functional programming.

_Jesper Cockx_: Yeah, hello and thank you for inviting me! I got started with functional programming and dependent types during my bachelor's degree in mathematics at Klevin. I first heard about Haskell from my dad, who is also a programmer, and initially thought it couldn't be used for anything useful because it doesn't allow side effects. However, I later took a course in declarative languages at Klevin that included both Haskell and Prolog and was immediately drawn to Haskell's practical and elegant approach. Until then, I had only worked with languages like Java and C#, and Haskell seemed like a much nicer way to do things. I was immediately hooked.

_NV_: That's very interesting because I also started programming with Prolog and Haskell I think this is why I stayed into programming.

_JC_: Yeah, yeah Prolog I wasn't so enthusiastic about it. I mean it was interesting but I didn't quite see the practical aspect of it but with Haskell it seemed like a
 very practical and very elegant way of doing things at the same time. 

_NV_: And your father is still programming Haskell?

_JC_: No, he doesn't. He's a C++ programmer but he's very interested also in all different languages and he told me about Lisp and about other languages. So  we sometimes discuss this I've also tried teaching him Agda and dependent types with various degrees of success. 

_NV_: That's cool, my father is a mathematician and I also have trouble explaining my work to him. I usually explain it by saying that I prove that X is equal to X by defining a function that takes an X and returns an X, but I understand it can be difficult to grasp. Can you share your approach for teaching your father Agda?

_JC_: Yeah, so I I guess so I usually start by explaining the core concept and for me the core concept of a I created the Curry Howard correspondence right? That's ah. This correspondence between types and propositions and the fact that you can use your type system to express logical properties and then in order to prove these properties. You just write a program right? and and yeah that's for me really what.
Ah, what got me into well actually from Haskell to actually want to work on dependent types and not just functional programming right? and the fact that you can do this and so yeah, so I tried explaining this also to him and it's.. It's very hard to explain in I mean I can explain all the mechanical aspects of it. But ah, you still have to get some of the intuition for it yourself. Um.
And but by understanding yourself and I also I noticed that also now when I'm teaching Agda to the 30 year bachelor students here in the delft that some of them really get it and get the idea and then ah, they're like very. Easy or need they they manage to do a lot of things with this and others. Yeah, get maybe the mechanical aspects of it but they never get this intuition for it and so this still something I'm trying to figure out how to actually give this intuition to people. Yeah.

_Matthias Pall_: Right? And I mean you're still trying to figure it out. But do you have an elevator pitch for the intuition behind Agda.

_JC_: Yeah, um, do I have I mean I can definitely give an elevator pitch so that works for some people. I don't think I ever truly got like the intuition true to him not yet I'm still trying from time to time. But um, yeah, so what's what would be my page. Yeah, it's ah.
Basically yes, starting from the concept of what is proof of something right? What what does it mean to prove something um and it it is to construct. A certain object right to to construct certain object that represents the proof and this is really the fundamental Id and that well depending on which thing you want to prove that object needs to have a certain structure right? and then the. Traditional example is well if you want to prove that a implies B while you have to produce some kind of function that transforms Proofs of a into Proofs of B Um, and and so this gives a very strong correspondence between well functional programming right? which is all about functions and theorem proving in the others.

_NV_: And on this topic where interesting because it's what you say like it's like monoids like once you get it. It's like I think it's so clear. But.

_JC_: Yeah, yeah, exactly So it's more Nots is another thing that I teach in my functional programming course and yes, it's very similar with that Some people just get it and like.
And and and others really don't and all I can do is really like help them to get to a point where they can understand but they have to take the understanding you have to do for yourself. Yeah.

_NV_: Do you remember the point that you got it.

_JC_:  Um, monoids um I got it while reading this learn new Haskell school tutorial which I was kind of reading in parallel with taking this declarative languages course. Um. Because this course didn't really cover Monos and I only realized this at the exam of this course where actually did use the list mono to solve a certain problem and and then yeah and I got to remark like this is a correct solution but take it you.
Maybe shouldn't have used monoids because you haven't learned this in this course.

And yeah, but oh yes, okay so yeah, the background story. So then how did I get into Agda I Guess the next question right.

_NV_: You nothing is your background story. We stopped you at the here we give live.

_JC_:  And so this was really thanks to my mentor and Jesus advisor so Dominique def friza who was at that time still doing finishing up his ph d in eleven and and so he worked. At that time he worked on ata in particular, he worked on extending agta with instance arguments which are kind of adu's way of doing type classes. So if you're no type classes from Haskell, that's ah, kind of a way to solve the same problem. Um, and so I was looking for these subjects and was looking through all the mathematics topics so in analysis and algebra and differential equations and such and then. Between those was also like a section with topics from theoretical computer science and so and then one of them was yeah proposed by Dominique and this mentioned this thing called dependent type theory which was kind of a mathematical logic. And that you could use to do theorem proving not just on the on the on paper but also on a computer and yeah, so at that point I was quite interested both in mathematical logic and in.
Functional programming I'll get you because I had encountered Haskell before so that sounded very interesting and so then I started to read more about that I read this book by Simon Thompson type 2 3 and functional programming I think it's called and and that was yeah, really super interesting and I wanted to learn more about this and so I decided to do a master thesis with him. Yeah, yeah, indeed and I was actually um.

_MP_:  And then you started contributing to Agda there right away or.

_JC_: Very soon already that I mean during my master teases I actually did my first modifications to the Agda compiler as kind of a prototype to in order to prove that the thing I did. Ah. Which was something related to pattern matching that they could actually implement it and it would be useful. Um, now this implementation wasn't quite up to part of the yeah, the usual code quality that Agda has. So it. It didn't end up getting merged but that was still very good experience for me to ah yeah to learn how the system works because aai is quite a large code base written in hos school. So. I think it's about 100000 lines maybe yeah maybe I mean it probably. It's bigger by now and that this couple of years ago yeah but it's um. So the number of modules I think went recently over 400 so that's ah, it's really a serious hu codebase and it's also it's quite an old code base by now I would say so it's from but this current implementation is from 2007 by of nagal and it has evolved quite a bit quite a lot of new features have been added by different people and including me also many other people who didn't necessarily know all the different components of Agda and so I think this is one of the nice things about Agdi is that it's really a research language. So many people use this to experiment with new type features or new language features. And adds their own things to it. But that also means that kind of the implementation is sometimes a bit messy and or a bit heterogeneous.

_MP_: Right? And so could you explain a bit you know how does that I work so you know it's kind of looks like Haskell right? but it it's not. It's not just haskell right.

_JC_: So no indeed. So the the basic idea of Agda was to provide a language a surface language that looks very much like Haskell but has this additional power of dependent types behind the scenes right. I mean and not just behind the scenes also in the surface syntax but um, because before agta I guess there were other dependency type languages. Well coke was there New Pearl was there a bunch of others but these were really meant as theorem provers right. And so in particular, they relies very heavily on tactics um to generate proof terms. So These tactics are kind of scripts that generates. So You never actually see the proof terms themselves in these languages. 

_MP_: So in Agda you can actually see the proof objects and manipulate them right? So you have more of a sense of what's going on.

_JC_: Exactly and that's because Agda is first of all, it's a programming language right? A functional programming language in tradition of hus school. So That means that whenever you're proving something. You're really just writing a function that. Happens to prove the the statement that you want to prove right? So That means you're directly writing the proof term and well to make that. Possible. Of course. There's a lot of features that Agda uses to make it so that you don't have to write out the full proof term So in particular, there are things like implicit arguments instant search that I mentioned. Um yeah, lots of yeah. Like you can define your own data types Index data types and then there is this whole machinery behind the scenes. So the elaborator which then elaborates the surface syntax into the actual proof terms so you still have. Like there is still a gap between the surface language and the actual proof terms that you're co producing in the end but the correspondence between these two 2 is much tighter than in a typical proof assistant such as cock. You.

_NV_: But the both terms are very similar to the core Calculus that the programmer is seeing and also like that the haskill is using to correct.

_JC_: Um, yeah, so in in a technical sense so Agda’s core theory is kind of based on the Martin Lof type theory so that's a full spectrum dependent type theory while. Hos school or at least Hos Ninety eight was ah using system f omega which is slightly weaker variant because you don't have full dependent types in those now of course I know that in the more recent times people have been proposing various.
Alternative core languages for Ho to also who have dependent types but and and doing lots of other extensions of this core language. Also I guess things like linear types and search. 

_NV_: Um, and what are the limitations of Agda so that this is allowed. So for example, my my understanding with I don't even know if it's correct is that you cannot have divergent. For example.

_JC_:  Yeah, so indeed. So that's one of the important differences I guess between Hasskill and Agta is that Haskell is a pure language so you cannot have side effects but you can still have non terminating programs and actually in Agda. We say no. Non termination is also a side effect. So we also do not allow you to write non terminating plugs right? and then there is a number of extra checks that need to be done in Agda in order to make sure that you don't have non terminating plugs. Um now. But. Maybe yeah first of course the reason why we want to have termination as a strong guarantee for language is because exactly we want to be able to use Agda as a tier improver and not just as a programming language right? So if you had non termination in your language. You could prove any. Possible proposition. Yeah, so so that means that you couldn't use Haskell even if Haskell was dependentently typed could still not use it as a tearer prover directly because of this non- termination and then so yeah, so the different checks that we have in Agda to and in order to ensure termination are. There is a termination checker so that checks that if you have a function that does recursion that there is some argument that gets smaller in each recursive call and so that you know that it will eventually terminate.
Um, we also need an extra condition on each data type so we need to ensure that all the data types are strictly positive and otherwise you might be able to define data types that have well it's. I Don't know it's It's a bit hard to explain on a podcast but you can define data types that basically express the Liars Paradox So say yeah this this data type is true. Even though if this data type is false.
It's one of the types that you can define in hospital school but you cannot define it in Agda precisely because again it would allow you to write a non terminating.

_MP_: Right? So you mentioned now the word positive that's something to do with the the type this of the functions right? Yeah so.

_JC_:  Thank you? So it's to do with Ah how can your data type your recursive data types where can the recursion occur and so this term positive comes from well this comes from Category theory where you have this requirement. Also if you have a function then it needs to be a positive function and in order to be able to take a fixed point of this.

_MP_: Right? right? exactly? So ah you mentioned that you know your first feature did not get into agta right? So so that's kind of the next question right? like so how.
How does a feature. What's a pipeline for Agda. How do you come up with an idea and you know write the code and get it merged and how do you make sure that Agda is correct. Yeah yeah.

_JC_:  So those are 2 separate questions I think um I'll let me start with the first question and so how do we decide on what new features get implemented I think we. Don't have as much of a formal process for this as hoskell does so and there's I mean so usually the process consists of but first of all identifying some kind of problem or lack in Agda right? And then that. Gets typically that gets discussed on the issue tracker on github or maybe on our zlip server on the mailing list. Um, and yeah, so typically the goal there is to try to find the kind of consensus that first of all, this is a problem or.
And and and second of all okay that there is some way to to fix this? Um, then the the second step is that well ideally someone once we know what there is to fix then someone has to do some implementation of this or even yeah. If. It's if it's not like fixing the full problem but at least making some first proposal for the implementation and then make a pull request. So again. We use Github nowadays back when I joined first we were using darks if any of the listeners are familiar with that. But, decided to move to github because well mostly because much more people are familiar with it. Um, yeah, and then so yeah, you make a pull request and there might be some reviews on this. 
I mean at least 1 other developer I guess is the typical requirement and and and then finally if this is this is positive and it fixes a problem and also if the whole test suite passes right? So we have some github actions that run all. The full test suite to make sure there's no recursion then it will get merged into the master branch and then finally you'll have to wait until we do the next proper release to get it in the the version of Agda that you can get via hackage.
So That's the process and it's It's quite open So Anyone who wants to like get something new into Agda and as long as like there's no strong arguments against this and you're willing to. Implement it and also to maintain it for a reasonable period after that I think those are the main requirements and then you can get your feature into Agda.

_MP_: 
Right? So do you have? ah an issue with like yeah like bit Rot in that like feature Rod kind of people who stop working on it. How do you how you deal with that. It's such a big project.

_JC_:  Definitely I Think that's a big problem and I don't think we have a great way to deal with it So what we do is we deal with it on a case-by-case basis. So there's a few options right? So either we have to find a new maintainer. Um, that's the ideal case right? If someone wants to pick it up and work on it. This is something that happened recently with a cubicle Agda. Actually so we got great new ah maintainer for that after Andrea well he left for industry and didn't have the time anymore to work in so that we have Amelia who works on this. Um, otherwise well if it's an important enough feature of Agda right? that we see. Okay, this is really something we want to continue supporting and that lots of people are using then one of the existing developers might pick it up right and decides. This is now something that I will maintain at least maybe not further develop it but least fix the box in it. Um, yeah so I did that with a bunch of features I think um yeah, um.

_MP_: Yeah, so you get so you get a lot of but right so you get a but lot of bug reports like you know if this is something that's not true and it is. Type checks or how to how how is it? How does an Agda bug report. Yeah.

_JC_: Yeah, yeah, um, so indeed we get. We do get a lot of bug reports and I'm very grateful for that because first of all, it shows that people are actually using Agda and are.
Experimenting with it or trying out new things. So and yeah, and and this this really helps to like also know what are the kind of things that people want to do with Agda and that we should pay attentions to in the future. So ah, yeah.
And and so book reports can be everything from yeah like you mentioned can be some inconsistency in the theory of Agda. Also often can just be an internal ago. Yeah, so sometimes there's some assertance in the code of Agda that fail.
And then you get this nice error message an internal arrow has curd these report this as a book. So um, can also be usability error or like arrows in the highlighting or the interactive mode even Agda right? So we get or maybe there's a buck in the pretty printer there. They're like everything every thinkable component of Agda probably has had bugs in it.

_MP_:  Yeah, yeah. So right? So you mentioned the yeah the the test cases right? So are those just programs that you then want to keep type checking or or yeah, how do you test a theorem prover yeah.

_JC_:  Yes, yeah, so we have um, a number of different test suites. So I think the biggest 2 are the the succeed and the fail test folder. So the succeed contains well just Agda files that should succeed when you type check them. And so these are typically regression tests or if we add a new feature. We add a bunch of tests that use this feature and then there's also the failing tests and I think this is like equally important that certain things that should not be accepted. They should actually.
Fail and they should have a particular error message right? So we also check that the arrow message doesn't change. Um and then the third big ah suite of tests is also the interactive tests. Um, so there we actually have a system set up with Interactive Scripts of messages that get sent back and forward to the ide or to emus in this case, um that that we actually replay and we check that Agda gives the right response to each of them. 

_MP_:  Right? Um, and that's to test the interactive mode right.

_JC_:  That's to a test. Well yes, so the Agda part of the interactive mode. So of course you also need then some code on the I E side that does the other side of this communication for that. We don't really have any wheel tests. Unfortunately  it's a bit harder to test because there you would actually need to have some simulation of the interaction of the yeah.

_MP_: Right? Um, so let's pause for a stop it? Well Nii and figures out I think I'll segue into typed holes next because they're right there? um.
No, but it's a I mean it's cool stuff right? because for me I'm like ah I'm on the lower level right? Just just Haskell stuff and it's this is all magic right.

_JC_: 
I I don't like I don't consider the host school to be a lower level than Agda. It's it's in a different dimension. So in particular, there are some things that are in Haskell that I'm really amazed by from Agda perspective. So one of the things I'm most jealous of is the whole constraint system. Um, and yeah, yeah, exactly the the fact that you can explicitly quantify over constraints. That's like.

_MP_: Yeah system FC yeah.


_JC_: It's automatically solved that's that's amazing. Yeah, that's really something That's yeah.

_MP_: Right? Yeah I think they had to I mean they had to rewrite the whole thing I Basically I'd like so now it's just constraints like all the way down like you're not you not actually compiling a program. You're just.You're just emitting constraints and solving them right and now and then you know constraints become this kind of first class thing 
So interactive mode that's where you kind of complete these typed holes right? That's where you really interact with the compiler in Agda right? and.

_JC_:  Indeed and I think this is another crucial part. So coming back to like how do you write Proofs in Agda I think this wouldn't be possible without the interactive mode because often like yeah the types get very involved very precise and in order to even write a program that has the correct type you need to well hold all of this information your head and then the interactive mode allows you to offload some of this information and.
Actually show you ah what type does this variable have at this point and what happens if I try this function or to apply this function here. Yeah.

_MP_: Right? So right? Yeah because you mentioned earlier that that you know other languages have kind of tactics but you know in Agda you you have. You. You're almost tactic is you have this proof synthesis kind of stuff right? where if it's not too Hard. You can kind of come up with something that could work right.

_JC_: Yeah, um, you're talking about the auto commands. Yeah, and indeed so that's actually interesting because I mentioned that ata the current implementation of ata is from 2007
Um, but this feature. Ah so the auto command is actually older than the current implementation of Agda from ah 2004 there was ah some ah publication. Um by Frederick Lind plottzAnd he yeah I just had to look this up also but he also he worked on implementing this Auto Feature. So. It's really something that has been in Agda for a very long time and is like very much part of the the. Old tradition of what Agda is supposed to be Yeah, what was ah I think yeah, a lot has changed since then since then and you can really see that in the code. Also so if you look at the implementation of Auto Um, this is ah quite.

_MP_: Right? And has that tradition changed or ah, right? yeah.

_JC_: Challenging to make any sense of unfortunately and it's one of these parts of the Agda code base where actually currently we do not have anyone maintaining it really? so sometimes there's like very basic bugs that we fix in it but most.
The um this is unmaintained at the moment. Yeah.

_NV_: So Auto is what it's I felt actor didn't have tactics..

_JC_: So Auto is an interactive command so it's built into the interactive mode of Agda that will try to well you have ah you have a hole in your program so whole like we have typed holes in Haskell in the in Agda. These are the basic interaction points. Used to interact with Agra compiler and then you can run certain commands and so auto is one of these commands and it will try to construct a term of the correct type right? So if you're asking for some simple type like bo or not and will just give you true or.
Um, but if it's some complex type like ah some kind of proof of ah of ah some propositional statements then it will try to actually construct the full lambda term that proves this statement.
And yeah, like Matti said in some cases it really works very well like surprisingly well and it will construct this huge term for you that maybe you wouldn't be able to write by yourself. Um, in other cases. It's really very stupid and it will not ah. Not even like use a variable that is right there in the context and that you think oh but could just use that and yeah, yeah, you can give it hints so there is some um, some flags that you can give to auto.

_NV_: Um, you cannot then use this variable. You cannot help. 

_JC_: Um, to yeah either give it some hints of try to use these ah these names of ah variables or functions or lemas Um, you can also give it a flag I think to construct a a recursive function or to try to. Make use of recursion and and there there's a couple of other you can configure how long it searches before giving up and search. Um, yeah, So it's a kind of proof search. But after you run it. The the actual proof term is in your source code as you would have written it yourself and that is a crucial difference with tactics in Coq which just there's still the tactic in your source code and it has to regenerate this proof term each time you actually run the tactic.

_NV_:  And can we I don't know who of your of the 2 of you are asking now but can we have this feature in Haskell.

_MP_: Yeah, yeah I mean so that that's not like my my next question like so how does interactive mode. Do it? How does it. It's it's got yeah, is it a server or like how does it? How do you? How does it know where it sat and what does it? How does it? 

_JC_: Yeah, so these auto command is part of the Agda executable. So when you are um, running the interactive mode of Agda. You're really just running an executable of Agda in the in the background and and so what will happen is well when you run auto It will kind of look at the type of the current hole and passe this to the auto. 
Function which is this part of the Agda codebase and this will try to construct the term and then this term that it tried to construct will be type checked and if it's type correct then it will replace the it will send it back to the editor and editor will then replace the hole with this solution at its fast. 

_MP_: Right? But but you have some motion of kind of current state like ah, you're not reloading the whole program every time. So.

_JC_: Yes, indeed So um, for auto that's correct so it will not reload the whole file so you have a current state in the of the of the type checker. So I mean.
Go into implementation details a little bit so we have a monoid called the Tcm. So the type checking monoid  that is used in well all of the type checker of Agda and so this has a state that includes a lot of information about well. What definitions are in scope. What Modules have been imported. What are their types. What are their definitions and also has information about what are all the interaction holes and and so yeah, so that is what is used by the actor. So it'  in a sense. It's very nice because you're using the actual Agda type checker to to do this right? and to make sure that the answer makes sense so it's not a separate tool um or not like some some other thing that is implemented as part of the ide. It's really just parts of the actor type checker.

_NV_: So what they find really impressive in this is like I understand why it works I don't understand how it is so fast. So. Do you do and like do you have a first version that started at being very slow and then you start doing heuristics and slow or.

_JC_: Yeah, so I'm I'm afraid I'm I'm not really qualified to answer this question exactly because it was already there way before I started working on Agda right? So This was even part of agda one. So It's from before my time. Um I. Can give you the link to this paper So the paper is called a tool for automated there improving in Agda and from the types conference in 2004. Um, and yeah, so um I can. And we send you the link I'll see you can good. Um, and yeah, so this this really uses a lot of the concepts from the field of automated through theorem proving right to make it.

_NV_:  Yeah, we will put it there.

_MP_:  Yeah, we'll put in there.

_JC_:  Work fast and I think there has been a lot of work in that field already to make sure that it works fast and then the the main problem with that is that well the logics that they use are typically not dependent type theories. They're nor classical logics.
Um, so that means that in some cases the tool will just yeah, kind of not know what to do um or be very confused by what Agdot Tros at this if it yeah. So I think this is the reason why sometimes it works surprisingly well. In other case, it it really doesn't work at all. Um, yes, no so I feel.

_MP_:  Um, right? but it's no, it's all in egg that there's no s SMT Solver for anything underneath right? yeah.

_JC_:  Maybe in this context I should also talk about a few of the more recent developments in this area that have been ah on an Agda. So more recently we have been expanding the reflection api of Agda quite a bit and so the reflection api can compare it to a so.
Like template Haskell so it allows you to analyze source codes of Agda and write Macros that that will kind of generate a new term and then splice it into your actual code.
So this is actually very similar to tactics in in Coq. So you actually write the macro in your source and it will during type checking run some reflection code and then puts the actual result as as the proof term right? 
And so there is also a way if you define such a macro. You can also run it interactively. So actually you do not have to rely on auto you can instead write your own ah macro and then just use that as the as the auto command instead.
So if you're looking for this. This is called elaborate and give the command in the I believe in the in the menu that emacs or other editors give you for agta. Um, and the command is.
Control C Control M for macro and so and then this will ah so in theory this allows you to very flexibly implement your own Macros that to proof search.
Ah, for specific type or for a general type and then yeah, run them interactively just as you would from ah Auto Um, in practice. Unfortunately, so I've done some experiments with this in practice. It's much much slower than the built in Auto at the moment.

_NV_: You know that right building out is ready fast.

_JC_: So yeah, yes, the built-in Auto is often very fast, not always but often it's very fast while it's very tricky to write reflection code for Agda that is fast. You can do it also but there is a lot of things that.
And you have to be very careful and if you do them wrong then it will blow up in your face and it will be unusably slow. So that's something I'm actually yeah, very interested in seeing if we can provide a better api for the reflection.
That's would allow us to actually just reimplement Auto in Agda and get rid of that very old legacy codes and just provide it directly.

_NV_: How do you have benchmarks say that you're implemented right at tactic or a user interactive thing and you're at the point that you want to replace the old one. How do you compare times.

_JC_:
Um, so I'm maybe not the right person to ask this question because I usually think much more about yeah how to make ah the type check really more correctly and make sure there's no box in it. Um, usually performance is not the first thing I think about but I mean kind of looking into this micros made first me to look in this direction. So I know that ah ol did some work a few years back on.
Really benchmarking the compile time evaluation performance of Agda So this is important because well as a dependency type language we need to evaluate Agda programs during type checking and so.
Ah, how fast we can evaluate Agda programs directly impacts. How fast is the type check. Um, and so the way Ulf did this was actually by implementing a custom backend. So yeah, have Agda has this.
Ah, mechanism for implementing backends I think it's a bit similar to how Gg plugins work. Um, and then yeah you can basically instead of generating some code in a target language. You can just run the benchmark and then.
Output some benchmarks as the output of this backend. So I think that's what I what I would use to benchmark this. 

_MP_: Yeah, because making proof search ah fast This Ah, it's a very difficult problem right? and we have ah it's a lot of people working on it right? yeah.

_JC_: Yeah, yes, and I think it's important for it to be fast. It's also important for it to be user extensible and that's kind of the biggest weak point of the current Auto is that it's really.
Hard code that into the Agda compiler and there's no way why? yeah like I said you can give some hints to it. But there's really no way to extend it with the new things. So yeah.

_MP_: Right? right? Yeah I think that's one of the things we tried to address in Haskell right?

_JC_: Yeah, exactly So I think if you if I would implement Auto again from scratch I would definitely pay much more attention to that.

_NV_: And is there any way to use all these features to generate Haskell code.

_JC_: Um, for me that you ask? Ah um, so ah, perhaps as you if if you were at the Haskell school symposium this year then you've seen that we had a paper there on a new tool that we've been working on called Agda two hs and so this is also a backend for Agda. But this generates Haskell codes from your Agda sources. Um, and actually I should rephrase that because the goal is not really to generate to translate arbitrary. Ah Agda code to Haskell but rather the goal is to have an embedding of a ah large subset of Haskell inside Agda.
So the idea that you can then write your Haskell code in Agda um proof things about it right? You can use Agda capabilities as Theorem Prover to prove that your code is doing the right thing and then extract.
The Haskell code out of it and just gets a nice and clean. Simple Haskell programken but where you now know that it has been proven correct. So that's really the goal that we have with Agda 2 HS.

_MP_: So yeah, right I Very impressive. So but how does it So how like how does it scale like can you do large programs and just.
Just here's my large has school program I'm going to rename it to dot Agda and it will work or like how much trouble do you have to go to prove all your things from scratch.

_JC_:  Yeah, so currently, um, that is still something that we're working on so there's currently no way to like easily convert a big Haskell code base fully automatically to Agda. And in fact, it's also very hard to do that fully automatically exactly because of the fact that Agda is a total language and so you have to make sure that the programs that you're writing are really terminating and that Agda can see that they're terminating. So so you cannot.

_JC_: Translate they just translate a partial Haskell program to ah Agda and expect it to work. Um, but then the other thing that you can do right? So if suppose you have a big Haskell code base and you want to start verifying it.
Um, another thing you can do is well just take one of your modules and like maybe like a really crucial part that does the security critical stuff in your whole coke and just implement that in agta right? You don't need to do the full program in ata right away.
Um, and and then but because Agda to Haskell just produces some very readable. Ah clean Huske codes. You can very easily then integrate that into the rest of your project and just replace your old host implementation with this new one.
Or at least that's the that's the Id but of course agra to Hs is still I have to say it's still ah a research project. So We're still working on it and still cleaning up some rough edges So We're actually working towards a. First official release of aga two Hs and having a 1.0 release soon. And yeah, and.

_NV_: And so well where can we see the announcement for this release.

_JC_: Oh um, this will definitely be on the Agda mailing list and on the on our Zullip channel and on on my matodon. Also yeah.

_NV_: Nice, but like in the translations. Do you keep any of the Proofs around or the theorems.

_JC_:  Ah, no, so okay so what we do for the translation of Agda to Haskell. Well obviously we cannot keep all of the dependent types around because Hokell wouldn't know what to do with those? 
So What we do Actually we make use of an existing mechanism in Agda which is called Erasure ah or the erasial modality and and so this is an Id from quantitative type theory. It's also used in Iterris Two. For example. Where you can annotate certain arguments as being runtime irrelevant or erased at Fronttime. So That means that these arguments are really only used for the proving part. So if we're proving that your click I does the writing thing. But they are not relevant for computing the final results of your pocket and so agra to just kind of plugs in into that ah mechanism that Agda already provides and to determine whether something.
Should be kept in the Haskell or should be just ah, removed from it.
And then you have in the in the erased parts. You have the full power of Agda on your site right? You can use all dependent types. Everything you want to prove the correctness of your program. Ah, while in the Non- erased parts. You have to kind of adhere to this.
Ah, common subset that we have identified which which we can compile to readable Haskell codes.

_NV_: Can you use Haskell’s dependent types for the truth.

_JC_:  That's a good question. So so far the answer is no, we haven't tried that yet.
So 1 thing we have considered is actually being able to translate index data types in Agda to Haskell in which would be quite useful for some things like one id we had was like if you want to implement a tactics interpreter for some calculus.
Um, then you could actually make use of Agda in the on the Haskell site for that and so you do that. But so far I would say that a dot to hs only generates simple Haskell codes.

_MP_:  Right? And it's the idea then to have mostly to target like runtime executable right? You're not, You're not targeting like a library that's been verified in Haskell verified in Agda for hackage or.

_JC_:  Well, you might have a a library also that you that you want to publish somewhere and you want to make sure that it actually satisfies some specification right? So that's something you can definitely do it I got to Hs as well. So.

_MP_: Right? right? right? But the library won't have like the GT's in and the or or what? yeah.

_JC_: No no I think yeah, well yeah, so there is always the question so you want to ah maybe make use of these fancy ght features but at the same time. Maybe you want your library to be usable by.
As many Haskell programmers as possible right? and in in that case, you might want to at least for the external interface of your program. You might want to make sure that it's really just simple types and simple hu.

_MP_: Right? Yeah, so you can be the person who pretends to write bug free code and it's because you proved it all correcting agda First yeah, very cool.

_JC_:  Yeah, it's It's just you're just cheating by proving it.


_NV_: Cool and what is next? what else do you want to see they're from Agda or from haskell.

_JC_: Ah, um, so many things so well first of on the relatively short term I really want to work towards this release of I got to Hs um, and.
Yeah, so that people can actually start with it and start playing around with it I'm look you looking forward to all the buck reports that we will no doubt be getting um and then also well 1 question i.
We don't have a very strong answer to at the moment is the question about the correctness of this translation right? So I mean Haskell and Agda are very similar and we're kind of exploiting that fact, by ah to to make the translation easier right.
Ah, but still we are translating from one language to another and it's not immediately obvious that this will always preserve the semantics of your so currently we have some informal arguments for why this should be the case but of course as someone working in the.
Dependent type systems and theorem improvers want to do better right? and we want to be able to actually formally verify the correctness of this translation. Um, yeah, and so and the first step towards that would be actually to have a formal specification of well.
What is the semantics of Agda or of some subset of Agda and what is actually the formal semantics of of Haskell right? or of some subset of Haskell that we're targeting again? Um, so yeah, so that is gonna be.
Fun and and so on the Agda side I've been working on that for a while and unfortunately hasn't been going as fast as I had hoped but I'm working on the Agda core project. So actually having a specification of a considerable subset of Agda in Agda itself. 
And and then this could be used as a starting point as a formal semantics for what is the Agda part and then and then hopefully also well either I Or maybe someone else wants to. 
Do some formal specification of well what is this Haskell language Actually that people are using and and yeah and and then we could prove that is translation preserves the semantics. So.
That I would find very cool.

_MP_: Right? The you'd have to pick which extensions are in scope right? And what Haskell are you talking about right? yeah.

_JC_: Yeah, so well, we're but that's ah I think 1 thing that makes this somewhat more feasible is the fact that we're not targeting ol of fual right? that we're not using Agda were like maybe using 1 or 2 extensions but kind of relatively simple ones. Um, and yeah, not using a lot of the more advanced Gg features which I mean might be difficult to give semantics to but and yeah.

_MP_: Right? And so I guess that's the other part of the question like as ag developers like what do you want from GItc apart from a formal specification.

_JC_: So right that we got this question also recently from the from someone people on the  the Haskell team. Um, and so we have a list of like 5 things that
were like particularly relevant or that would be nice if we could see them being improved again I can give you a link to that. But so 1 thing that I remember is ah yeah, the way we deal with.
Type classes and specialization of type classes in the Agda codebase is not very scalable at the moment and with which I mean we use a lot of Mtl type type classes to specify.
Which capabilities of the of this type checking more not we actually need at each place in the implementation and this um is quite useful right? So we can can kind of ah say oh we only need. 
Pretty printing of terms here right? We don't need any like we don't need to throw arrows here for example, but at the same time. This means that all the code that we write becomes polymorphic over which monot are we using.
And then it becomes really crucial data compiler knows at runtime which Mono ah is used and that it can inline that and specialize it and optimize things and so I mean of course yeah there is a. It's not that ok doesn't provide any ways to do this right? You can write specialized pragmas and assignable pragmas and and such but it's It's just very easy to forget one of those and then it ah completely ruins the performance effect that.
Um, so the alternative that we've been using for now is to enable two flags. So there is the F expose all unfoldings and specialize aggressively and and so well.
Kind of as far as I understand like I'm not a Gg internals expert. But as far as I understand this basically ah puts the implementation of every instance kind of in the interface file of each module and then it will just yeah use that to inline wherever it can um so it does solve the problem in a sense but also it leads to a lot of extra compilation time a lot of extra codes duplication in the binary. Um, and yeah, sometimes even people.
Don't manage to compile Agda at all with those 2 flex on just because it takes so much memory. Ah yeah, so having a better way to do this would I think be really useful for a.
And I'll send you the link with it so you can take a look at the other four which I cannot recall it top of my head. But.

_NV_: So you're in contact with ah did development team.

_JC_: So yes I think ah David Christiansen contacted us. Yeah.

_MP_: So that's for the future for you know Agda and and haskell but what about. Like you know the other kind of dependently type theorem provers out there. You know I think like baluga and like you know are doing very weird things right? There are they poaching on your territory or or or what do you Ah, gar you gonna are you learning from them. Are you're taking things and putting them into agar or how does that like how does the future look like. 4 dependent types. Ah in general right? so.

_JC_: I Think the the future looks great right? So I'm not worried at all that agta will get replaced or like get its position taken over um, and and the reason for this is because. From the beginning the goal of Agda was as a vehicle for doing research for figuring out. How do we implement these dependently typed languages in a way that people can actually use right and not just.
In a way that's theoretically satisfying but also in a way that is actually practically useful. Um, and so in that sense. It's great to see all these other languages popping up. Yeah, like biooka you mentioned or Andra Meda deducty cool tt um a
Ah, yeah, and then lean has been growing a lot in recent years so yeah so this is all these languages. It's great I think what we should be doing more is.
Talk more about the implementation of these languages and not just about their theories and I think there is still a lot of reinventing the wheel going on in the.
These languages and a lot of the same problems being solved again and again in like in in ad hoc manners and so I think it's important to start building a formal theory of how to implement.
Type checkers and elaborators and this was also the goal that Richard Eisenbergch and I had with the wiz workshop and so there's the workshop on implementation of type systems which was the first edition beginning of this year at POPL. Um.
And it will have a second edition in 2023 so not be colocated with POPL. But um, yeah, it's just stay tuned for that and and hopefully we'll have an announcement about that soon. So I really hope that we can bring these communities closer together.

_NV_: Cool. Thank you!

_JC_: Yeah, it was ah great talking to you! I think so I really like the Haskell interview and it's ah like having ah interesting things to talk about. So also I think yeah this this what I said about implementation. I think Haskell and Agda can also learn a lot from each other.

_NV_: Yes, that is true. Okay, cool. Thank you.

_MP_: Thank you.

_JC_: Yeah, thank you!

