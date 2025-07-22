*Mike Sperber (0:00:15)*: Welcome to the Haskell Interlude. I’m Mike Sperber, and I’m here with Niki Vazou. We talked to Sandy Maguire, lead compiler engineer at Manifold Valley. We discuss a wide range of topics about the benefits of using Haskell, of course, specifically over PHP, about all the books Sandy has written on programming in Haskell and also on Agda, on effects and the problems with monads, on combinator libraries, and programming with laws.

So, Sandy, how did you originally get into Haskell?

*Sandy Maguire (0:00:44)*: It’s a good question. I had a class in university where it was an AI class, and this was back in 2014, before AI meant what it meant now. And the final exam was to do programming but written with a pencil and paper. And so no one was ever going to evaluate this code except in the brain. And I figured that I would get a better mark on the exam if I were to write it in a language that I didn’t think the proctors would understand. So that was it. I actually, at the time, didn’t understand that Haskell is much more popular in academia than it is in industry. So they might have understood it perfectly fine.

But yeah, at the time, I had this friend whose name was Alex Klen, a super smart guy, and we called him Dr. Monad because he learned Haskell off at an internship somewhere. He would come back, and we teased him because he would always be talking about how great Haskell is and how good monads are and all these sorts of things. 

So the impetus to learn this was from this AI class and the means of learning. It was through Dr. Monad, who would sit beside me and explain how a writer worked and a reader, and gave me a good sense of how can I actually write programs in this super weird language that really didn’t correspond with my mental model of computation at the time. So yeah, it was fantastic of him to do it. So, thanks, Alex. 

*MS (0:02:03)*: So, presumably you’ve had more contact with Haskell since.

*SM (0:02:06)*: That is true. Yeah. 

*MS (0:02:08)*: Is that something you use in your current job, among other things? 

*SM (0:02:10)*: Yeah. So I guess this was the start of a long descent. I had been programming for a decade at this point, and I started with PHP or something stupid. Like all of these insane languages—C#, Lua, JavaScript, C, C++. And after 10 years, I felt I knew all there was to know about programming, which wasn’t true, but I stopped. I got to a point where I felt it just solved the problems I got put in front of me. And part of that was having just finished university, and nobody was putting particularly hard problems in front of me. But programming got to a point where it felt blasé. And so when I was writing Haskell, it felt like I had fell down the rabbit hole, and I’ve been writing for a decade now, and I still feel like I’m consistently learning cool new things, and I haven’t gotten bored with it yet.

But I guess, to answer your question more closely, after I finished university, I was sufficiently enamored with this language that I had an excuse to try out that I spent like 10 months before getting a job of just writing little video games in Haskell and having a blast, like getting a sense of pushing this weird thing through my skull and getting a sense of how you can use it to solve relatively real world problems.

*Niki Vazou (0:03:28)*: And then after that, did you use Haskell at your job?

*SM (0:03:31)*: I didn’t, no, out of the gate. So, between the 10 months of university, I had gotten a job at Google, but I wasn’t allowed to start until September for whatever reason. That might’ve been my choice. I don’t recall. So I got a job to write C++ at Google, and then spent 10 months learning Haskell. And by the time I got to Google, I was thoroughly disillusioned with C++. And I spent my entire year at Google saying like, “Why don’t we just rewrite this in Haskell,” which the forces that be are never going to let that happen. But in some sense, I made myself significantly less employable during those 10 months of getting this brain works.

So I spent, I think, 53 weeks at Google, which was as minimum as I could spend and keep all the money they promised me. And I immediately went out and joined a Haskell startup, which at the time was called Takt, and I think then changed its name to Formation, and now I’m not sure if it exists anymore, but they were doing advertising technology in Haskell. And it wasn’t particularly good for my soul, the advertising technology, but the engineering team was all-star, and I really put most of the things I know how to do. Now, most of the benefit that comes with having such fantastic and brilliant coworkers who taught me all these things, and to be in an environment where you’re being paid to learn is a fantastic feeling. 

*NV (0:04:53)*: So when did you start writing books? 

*SM (0:04:55)*: So my work at Takt, I was there maybe a year and a half, and like I said, it was hard on the soul. So after a year and a half, I took a vacation, and when I came back, I realized, “Why am I working here? This sucks.” That’s not true. That’s not entirely true, but it wasn’t for me. And so I decided I was going to retire extremely early. I sold everything I owned, and I moved to Eastern Europe. Didn’t have a lot of contacts there and didn’t have a lot of reason to be there, except that it seemed like a cool place to be. And so after a few months of watching as much TV as I possibly could, I got really bored, and I thought I should probably do something more productive with my time.

So I started writing a book called Thinking With Types, and that was distilling all the folklore I had picked up at my last job, where we were doing all these crazy dependently typed compiling techniques. And just all the things I had learned in that time got written down. I pushed a version online. It was like 37 pages, and it was much snarkier than the eventual thing, but people seemed to eat it up and really like it. So that was enough impetus to push it out the door.

*NV (0:06:04)*: You said it is about dependent types in Haskell, right?

*SM (0:06:08)*: I don’t know if the book is about dependent types in Haskell, but it certainly was inspired by having to learn about dependent types in Haskell. The book itself, I think, is more on types and all the things I wish someone had sat down and explained to me. So, like, what is the algebra of algebraic data types, and how can you actually use type variables to enforce constraints in your code? How does the GHC Generics library work, and what can you do with it? How can you get the compiler to write code that’s type-directed for you, like deriving instances for classes that aren’t known by the compiler? Anything that’s type-directed, or maybe type-adjacent, were the things I tried to put in that book. 

I can’t say it was particularly well thought out. I just started writing, and I think I was in the right place at the right time, and there was clearly a market for it, and I stumbled my way into success.

*MS (0:07:02)*: But that was not the only book you wrote, right?

*SM (0:07:04)*: No, you’re right. In some sense, I think I got a little unlucky with that, where I put not a huge amount of energy into this book, and it was significantly more successful than I could have imagined. And so I got the sense that maybe writing a book is just really easy, or I’m super good at it, or something. Like, I’ve got a bit of a hubris problem where I just assume it’s me and not luck.

So after that, I spent another year thinking, like, well, why isn’t functional programming more successful in the real world? My feeling was that perhaps it’s because we don’t really know how to do functional programming in large. We’re quite good at it in the small of writing little functions, but how do you structure big problems? So I spent a year researching that, and then maybe another year writing, or trying to write that into a book. 

I don’t know if I was super successful in what I set out to do, but I ended up with a second book called Algebra-Driven Design, which was more about thinking, about writing combinator libraries and how you can structure bigger problems in terms of combinators. That turned out to be much harder to write than I was expecting, and it burned me out a little bit on the book-writing front. 

*MS (0:08:21)*: Yeah. But I’ll say that it’s a tremendously valuable book, right?

*SM (0:08:25)*: Thank you.

*MS (0:08:26)*: I mean, one of the funny things is that combinators or combinator libraries, a lot of them you can do in Java in principle, right?

*SM (0:08:34)*: Mm-hmm.

*MS (0:08:35)*: But they’re virtually unknown outside of functional programming. And one of the reasons is that, I mean, there’s lots of ICFP papers on this combinator library or that combinator library, but there’s very little... except your book now on the methodology of how do you actually design a combinator library.

*SM (0:08:51)*: Yeah. 

*MS (0:08:51)*: And I think something similar might be true of your first book, right? Is that you... we have all these intro books into Haskell and other functional languages, but we have, as you point out, those intro books, like three-line, five-line, maybe 10-line programs. But they don’t say much about functional programming in the large or not.

*SM (0:09:10)*: Right.

*MS (0:09:11)*: About more advanced functional programming techniques. You mentioned the brilliance of your coworkers in your first Haskell job, right?

*SM (0:09:18)*: Mm-hmm.

*MS (0:09:19)*: I mean, having written those books, obviously, that maybe lowered the level a little bit, how brilliant you need to be in order to write Haskell code. But do you have a take on, is that a problem that you need to learn more or learn deeper stuff to be effective writing Haskell than maybe writing, you mentioned, PHP or Java, or something like that? 

*SM (0:09:39)*: I think it’s the goalpost changes, which is, the way we feel about Haskell is, like, our expectations are just much higher for the Haskell code than they are for PHP. We expect that the PHP code isn’t going to work, right? And if it does, it’s by accident or, you know, that’s probably more inflammatory than it needs to be. But it’s due to a huge amount of engineering and debugging and trying one’s best, because the language doesn’t pull any punches. 

I think there is a skill to wielding Haskell that is relatively unexplored, and maybe it can be taught, but right now it seems to be mostly in terms of, like, in folklore and in just being in the community and learning from people around you. I don’t know if there’s been an effective means of more officially teaching these things. But, yeah, I suppose it’s true where I think a junior Haskell programmer will probably get less done than a junior JavaScript programmer, but the stuff that they do get done will work better, right? But I think it’s probably nonlinear as well, where once you’re a really good Haskell programmer, you’re getting huge amounts more done than if you’re a really good JavaScript programmer, just because of the way the language forces you to think and in terms of the level of abstraction you can deal with. So, I don’t know if that answers your question or not, but...

*NV (0:10:59)*: You’re saying that it’s worth the cost of learning, right?

*SM (0:11:03)*: I think it is, but I’m obviously biased.

*MS (0:11:06)*: Let me try to rephrase that a little bit, right?

*SM (0:11:08)*: Sure. 

*MS (0:11:09)*: A possible implication here is that, I mean, writing JavaScript is you top out at a certain point, right?

*SM (0:11:15)*: Yeah, I think that’s a good way of looking at it. 

*MS (0:11:16)*: Right. And maybe there’s an advantage to that. A lot of hiring managers say, “Well, no problem. If somebody quits, we just go out on the street and we put up a sign, ‘Java programmer wanted,’ and we can hire somebody to jump in.”

*SM (0:11:30)*: Right.

*MS (0:11:31)*: And with the help of the Domain-Driven Design Community and so on, there’s ways to successfully structure projects so that onboarding is a manageable job. On the other hand, it’s unclear to me how you can apply skills beyond whatever, 10 years of job experience, or something like that. But it seems with Haskell or with functional programming, and specifically with Haskell, all the nifty features in the type system is you can spend years and years and years. And if it’s not a new feature in GHC, it will be a new technique to apply those features. Is that fair to say? 

*SM (0:12:09)*: I think it is, and I wonder if some of the distinction here boils down to, is your problem effort constrained or is it insight constrained? If you just need more code written, then you can hire people to write more code. But if you don’t know what code you should be writing, then writing more code doesn’t really help. 

*MS (0:12:28)*: Yeah.

*SM (0:12:29)*: Right. So I think a lot of the domains that we throw Haskell at, at least in industry, are ones that we have a reason to throw Haskell at, where either we’re looking for strong guarantees, or we don’t know how to solve the problem otherwise. And so I’m not sure like the method of putting up a sign saying, “We’re hiring JavaScript programmers,” and just like, bring in as many people as you can and throw as many fingers on keyboards as you can. I don’t know if that scales to all problems, but I suspect there probably is a bias in these strategies and the problems where we try to apply these strategies to.

*NV (0:13:04)*: What problems is Haskell good at?

*SM (0:13:06)*: My feeling is that Haskell is really, really good at problems where you want to delay the interpretation of something, where you want an abstraction layer between... I mean, compilers are always the obvious example where there’s a couple of constraints that are fantastic, one of which is you don’t talk to the outside world very often. I think the story in Haskell is like, as soon as IO gets involved, things get messy, but it’s really fantastic until IO gets involved. Still good afterwards, but not as good, where there aren’t existing libraries that you really want or really need, because those libraries are almost never written in Haskell. And so as soon as you need to pull in another library, then a lot of the things we like about Haskell—the guarantees we get from the type system, the purity, the things we like thinking about—all of those get thrown out the door.

So I guess, the high-level thing is if you’re in a domain where you can get away with not reusing code, I think that probably does speak a lot to the feeling of “not invented here” syndrome in Haskell. And I myself am very bad at this. But partly I think that’s because you get creative people who like solving problems, and partly it’s because you need to, because existing solutions don’t map very well to the domain we want to think in. 

*MS (0:14:26)*: So, your latest book is not with Haskell, right?

*SM (0:14:30)*: That’s right. 

*MS (0:14:31)*: So, what is missing, or how did that come about? Do you want to tell us a little bit about that book?

*SM (0:14:35)*: Sure. So that book is called Certainty by Construction, and it’s Agda. It’s about how does one think about writing in Agda. And it doesn’t get as into the weeds in like, how does one solve programming problems in Agda? Because I’m not yet convinced Agda is the tool for solving programming problems. But it’s a book on thinking about dependent types and how you can use these, and what is a proof object and how does one go about proving things. Necessarily, a lot of that looks like doing mathematics because that’s the only domain in human history that has a market success at proving things. 

I felt like my work was already cut out for me, writing a book about Agda, not necessarily on how do I also prove this novel thing. It follows the same trajectory as my other books, which is, how do you use types to show off things that you want? And it seems like a natural progression of what if your type system were way stronger, and how does that force you to think, and where should you go from there?

*MS (0:15:41)*: So, I want to backtrack a little bit to what you said about doing IO in Haskell. I mean, I think everybody knows that IO is kind of Pandora’s box. Everything got thrown in there, and I think everybody’s tried monad transformers, also is kind of unhappy about them. But you did this library. I think you’re no longer actively involved in Polisemy, but you originally wrote this library...

*SM (0:16:03)*: That’s right. Yeah.

*MS (0:16:04)*: ...for doing effects. So it’s something that we use in all our Haskell projects pretty much. If you want to shed a little bit of perspective on how you view your work on that, maybe you should say what it does for people who don’t know, among our listeners. 

*SM (0:16:17)*: Okay. So, for context, I wrote a library in 2018, I want to say, called Polisemy, and the idea was the Monad Transformer Library (MTL). It’s pretty fantastic for structuring programs, but the problem is there’s this distinction between, like, you have this constraint called MonadState or MonadError or whatever, and that’s the interface to this abstraction. And then you also have the implementation. So that might be StateT or AcceptT. And at the time, I felt like there was this really big problem where people didn’t introduce more of these effects because there was a lot of boilerplate involved in doing it. 

So let’s say I wanted to introduce MonadNetwork, right, which mediated calls to the network. Rather than pulling in all of IO, I only want to interact with the subset that can only talk to the network. Maybe it can only make getRequest or something. In principle, that should be a really easy thing to do, and I can make a class for it, then I can make an interface, or sorry, an implementation for it. So I might make NetworkT, and then the problem is, how does NetworkT interact with state? Do I have a MonadState instance for a NetworkT? Do I have a MonadError? In those ones, probably yes. But then, if I pull in, like, the Redis library, maybe, now I have MonadRedis, and do I have an instance of MonadRedis for my NetworkT? So you get into the situation where you need to write n-squared instances if you want all of these things to work. So I need to write MonadState of NetworkT and MonadNetwork of StateT. And I need to do that for any combination of these things. 

So, my feeling was that people wrote a lot and probably too much code in IO because it was frustrating to do anything else. So I was looking for a solution to that. And my brilliant coworker at the time at Takt, he was using this library called Freak in Scala. It was this idea of free monads based on... I don’t know. I didn’t really understand it, but he was bringing this in and claiming it was as good as sliced bread. So a lot of the work we did at Takt was investigating how one can use free monads to solve problems.

This all culminated in Polisemy, which was an approach to using free monads as a solution to this problem of how do I structure effects, where effects are these things like monads, MonadNetwork. The free monad thing of that is, rather than giving an interpretation, I would just give you the syntax, and I delay the interpretation of it. And so sometime later, I come in and say, “Well, I have this network effect, and how do I turn that into code?” Maybe I give a transformation from network into IO, and that means my application code can be written against this abstract interface, and later, I can then reinterpret it in terms of code I’m actually going to run. And so, in some sense, you get this structured pattern where your application code looks a lot like a series of micro-transformations, like a compiler. Each effect gets transformed into something else, and you can reinterpret that again. And so maybe you transform your network, you GetRequest into NetworkRequest, your NetworkRequest into SSL connections, and you can invisibly add dependency injection while you’re doing this. So, it seemed like a really nice solution to the problem. And without too much real-world throwing at the problem, I got really loud about free monads and how fantastic they were. 

I no longer use Polisemy. I don’t use monads very much anymore, in fact. I think in retrospect, the problem with Polysemy, at least as far as I see it, is the separation of interface from implementation. And that seems like a good thing at the high level, but I guess the bigger problem, maybe the bigger problem, is not that. It’s not so much that. It’s the lack of semantics around these things. Monad transformers have this issue where, if I have a state over StateT of either versus an AcceptT of state, I get different semantics in whether my changes get rolled back if I throw an exception. So, I might change some state and then throw an exception and catch it, and then in the catch block, do I get to observe that state or not? That turns out to be, in some sense, extremely flexible and really cool. On the other hand, it means in your application code, you have no idea what the state is because it depends on some implementation detail that someone has made later. I don’t get to choose that when I’m writing the application code. Someone comes in and does these passes of micro-transformations in order to evaluate the syntax I provided. And so, this is a huge source of bugs, at least in the few times I tried to use Polysemy in production, where we had, like, 50 effects, all reinterpreting in terms of each other. And figuring out actually what was happening was really, really hard, and when there was a bug, it was impossible to debug. 

*NV (0:21:19)*: So, the composition happens from the library or from the user? 

*SM (0:21:23)*: The composition happens in main, right? So, main is the only part of your program that’s written in IO, and what it looks like is that it says, like, runState, runAccept, runDatabase, runNetwork. And often those orders can be permuted. So, instead of runState at the beginning, I could put runState at the end. And depending on where I put it in that series of natural transformations, I get completely different semantics for this program. 

*NV (0:21:51)*: Yeah. Well, with the monad transformers, like the composition, you can compose only in one way, the one you decided when you created the type. 

*SM (0:22:00)*: That’s true if you write against a concrete monad stack. But if you’re doing the MTL thing, where you say, “I’ve got MonadState, MonadError,” you have the same problem. I guess it’s less egregious. Because of the pain of n-squared instances, often, people don’t do this, and so it doesn’t come to bite them as much in practice. But if you program against a concrete instance, or sorry, a concrete monad stack, then that problem goes away. But now you’ve sort of lost the ability to talk about the abstraction part, where you say, “I only need the ability to talk to state. I only need this thing.” Instead, in any part of your program, you can do any of these things. 

*MS (0:22:34)*: So, I mean, you mentioned that Polysemy solves this problem of dependency injection, right? At least at the outer levels or outer layer of your program. 

*SM (0:22:43)*: Right.

*MS (0:22:44)*: And then you said, “Well, there’s this problem that we don’t have semantics,” but this kind of... I mean, you lose some semantics as part of having dependency injection so that you can... Whatever. Instead of accessing the file system, you can access something virtual for testing purposes or something like that.

*SM (0:22:58)*: Right. 

*MS (0:22:58)*: So, what’s the right way to specify the semantics at a level that still allows for dependency injection, or is that an unsolvable problem? 

*SM (0:23:06)*: That’s a good question. I’ve spent a lot of time thinking about this. Nick Wu has a paper on what should the semantics of effect handlers be, and I don’t recall the name of the paper right now. But the idea is, if you have two different effects, you should be able to switch the order of them relative to one another. You should get the same result if you swap them. 

*MS (0:23:28)*: Okay.

*SM (0:23:28)*: If you say, like, statement A that has effect A and statement B that has effect B, statement A followed by statement B should be the same as statement B followed by statement A.

*MS (0:23:36)*: Okay.

*SM (0:23:36)*: Makes sense, right? Which is to say, like, these effects should not interact with one another, and they should interact only with themselves. So that goes some direction towards providing semantics for these. I think the dependency injection thing is not a huge problem, but the problem... I guess the challenge is, you need a base layer of truth from which you are providing your semantics. And so, I would say you want a denotational semantics for these things to say, “Here is what my program means, here is what evaluation of it should do, and here is how I measure it for success.” Is the answer I get the same as what the denotational model says I should get, right? Which is punting on the problem.

*MS (0:24:14)*: Yeah, I was going to say, well, then you have the exact same problem at the level of a denotational semantics.

*SM (0:24:20)*: Yeah. It’s true, but I think a lot of the challenge comes from the fact that monads are often hard to give denotational semantics for, and it’s because of this necessary structuring of things that now you need to worry about threading state through all of your things. You need to handle. So, when you try to assign a denotational semantics, again, it doesn’t compose very well. And the way I feel that all this has bubbled up is that maybe the problems with monads. Maybe the problem is not really anywhere else in the stack. It’s that the concept of “monad” is kind of crap. 

*NV (0:24:54)*: Monad and effect, right? The same thing.

*SM (0:24:56)*: I don’t think necessarily. I think monads use the notion of sequential computation. I have this bind operator that says, “I have m of a and I get a continuation from a to m of b, and I can compose those things.” And so, what that necessitates is I have a structure, or sorry, an order in which I will evaluate these things, because the only way the types can line up is if I do them one after another.

Effects, I think, more generally just say, “Here’s what I’m allowed to do,” and they don’t necessarily require this ordering. But often, the way we think about it in Haskell is like monads provide effects to us because the mixed language is pure. And so I think it’s a common misperception that in order to do effects, you must have a monad, which is not necessarily true. We could have a pure effect that we then interpret outside of the language. That thing doesn’t need to be monadic, which is really what IO is anyway.

Applicatives give us often the same thing, except applicatives give us the notion of parallelism rather than sequentiality. And so, you can say at least these things will run roughly at the same time, for some notion of roughly and at the same time.

So, no, I don’t think that monads and effects are necessarily the same thing. It’s convenient to think of them because in that way because Haskell forces us to think that way or encourages at least. 

*MS (0:26:19)*: I think of this problem as a deeper one because syntax in our program is sequential. So, we have applicative do notation, but the notation is still sequential. 

*SM (0:26:29)*: Yeah. That’s true. Do notation is fantastic for writing little things, where I can reason about it all in one case. And to the extent that I’d like to use monads these days, I’ll say, like, run StateT of do of something, and that fills 15 lines. And then I’ve introduced the effect, and I’ve handled it locally. And so it’s easy to think about it. It’s easy to debug. But I think if we had more things like idioms, idiom brackets, or arrow notation, maybe, it would go a long way. Just having different ways of structuring programs that aren’t this tree structure that we’re usually used to when we’re writing pure code, and not this list structure of statements when we’re thinking about do notation. 

*MS (0:27:12)*: Yeah. That makes sense. But you’re still... I mean, you’re writing Haskell in your current job, right?

*SM (0:27:17)*: I am. Yeah.

*MS (0:27:17)*: So, is that just a whole lot of non-monadic code and then there’s just a tiny little bit of IO shell around it?

*SM (0:27:25)*: Yeah. I get a little lucky because we’re writing a compiler at work. And so, again, it’s this domain of like, it’s pretty clearly one in which you don’t need to do a lot of IO. S, I get away with it. But also in my personal projects, I’ll write Ludum Dare, this video game jam, every few months, and I’ll do that in Haskell. And it’s amazing how far you can go, even writing a video game without doing much IO. 

*MS (0:27:50)*: Yeah, yeah.

*SM (0:27:51)*: Right? You say, “I need to draw things in IO. I need to render some sound or play some sound.” And that’s it. 

*NV (0:27:58)*: So you’re not using the FRP for your video game. I have never written a video game, but in my mind, these are the things that are very heavy on monadic programming.

*SM (0:28:10)*: Yeah. I have started writing them in FRP using Yampa in particular, which is a delightful way to think about writing video games. I used to work at a video game shop in C++ where if you had a timer, you needed to initialize a global float and you’d say this is five, and then every frame you’d decrement from five, and then when it got to zero, it’s like your timer’s up. And that was like a really common pattern. And in FRP, you don’t do that. You just say like, “I’m going to take the integral of my time function and when that gets to five, then I’ll send an event and I’ll handle that event somewhere,” and it really destructures a lot of it. So, yeah, I do use FRP, but I guess the point is often those FRP libraries are not monadic explicitly. Or if they are, they’re only in a very shallow way monadically. But the application itself is not usually written against the monadic interface. 

*MS (0:28:59)*: I mean, certainly, Conal’s original FRP formulation was not... I think a lot of the successor libraries like Yampa go in a monadic direction. But I think Conal thinks about this in a very declarative way and gets slightly upset when there’s too much monadicness.

*SM (0:29:17)*: Yes.

*MS (0:29:19)*: Modern interpretations of his work, let’s put it like that.* 

*SM (0:29:22)*: Yeah. I think that’s fair. They seem to miss a lot of the things that he sees to be valuable, as my understanding is, having the real numbers rather than the floats for your notion of time. That seems to be really important in the Conal interpretation of FRP, or formulation is probably a better word. Anyway, forgot how we got here. 

*MS (0:29:42)*: That’s okay. I think I want to backtrack even further. I think...

*SM (0:29:46)*: Sure.

*MS (0:29:47)*: ...you mentioned... I mean, when we write software, originally... I mean, somebody comes up with a bunch of requirements when we write software. And so you mentioned that doing all the stuff with proofs and with types and so on is very good when we understand the problem domain very well, and then we can express all those things in the types. Can we put that on its head and say that this is the only things that functional programming or Haskell is good at? 

*SM (0:30:13)*: Is things at which we understand the problem and in principle could do a proof on?

*MS (0:30:17)*: Yeah. Do we need to understand the problem well to benefit from functional programming? 

*SM (0:30:21)*: That’s a spicy question. I would say, why are we doing programming at all if we don’t understand the problem, right?

*MS (0:30:29)*: I want to hear your... I have an answer, but I want to hear yours. 

*SM (0:30:31)*: Sure. Yeah. No, I don’t think it is. I think a lot of the brain patterns that come from writing functional programs necessitate you thinking more deeply about the problem, and often that leads to a better understanding of it. But I think that’s just having better tools for tackling things. I have yet to come across a problem that someone could write in an imperative language that I was unable to give an adequate solution in Haskell for. And often those solutions at Haskell have nothing like the imperative version. 

So, no, I don’t think it is. I think if you’re writing code, you’re at least striving towards understanding some problem domain. Whether or not you accomplish that is up to you. 

*MS (0:31:19)*: Right.

*SM (0:31:21)*: But I don’t think there are any problems which cannot be understood, or we don’t even have a surface-level understanding of. And so no is the answer. 

*MS (0:31:34)*: Yeah. I mean, one aspect of this I want to get at is that outside of functional programming, the process of requirements gathering is often separate from the process of programming. 

*SM (0:31:45)*: Right. 

*MS (0:31:46)*: And I’m specifically thinking of your combinators book, Algebra-Driven Design, where you kind of structure your problem domain. I mean, you use combinators, and the great thing about combinators is that they sometimes seem to anticipate future requirements, right?

*SM (0:32:03)*: Right.

*MS (0:32:03)*: So, I mean, you’re looking at a concrete problem. You decompose it using combinators, but then you can recompose them in different ways than your original problem statement set. And so they seem to anticipate future requirements. Or another way to put it is you structure your problem domain in ways that are not implicit, in the way that domain experts talk about it. 

*SM (0:32:28)*: I think that’s fair to say. The way I think about combinators in particular is in some sense, you’re modeling some notion of reality. And you’re like trying to carve reality at its joints to figure out, like what exactly is this thing I’m trying to talk about, and what are meaningful operations to talk about on it, even if nobody has ever needed to talk about that. So I think this is where this future proofing comes from, which is, Conal actually has this fantastic quote where he says he’s trying to write libraries that people will find uses for that he himself could never consider, right?

*MS (0:33:08)*: Yeah, exactly.

*SM (0:33:08)*: Like, probably couldn’t even consider. If you have infinite capability in this thing, then your brain isn’t big enough to anticipate all the things that could be used for. I wish we wrote more software like this, where you solve the problem once and for all, and you anticipate all the things that could be done with it, or at least provide the opportunity for someone to come along later who has a better understanding of the problem than you do and reuse that code rather than need to rewrite it. 

*MS (0:33:33)*: I mean, earlier, you mentioned, right? I mean, we’re thinking in some sense, doing combinators, maybe doing mathematics when we program, is about applying brain patterns or putting brain patterns into our software. 

*SM (0:33:45)*: I like that. 

*MS (0:33:46)*: So, I don’t want to correct you there, but I think combinators are not so much about reality, but they are about the way that we think about it. They’re a particularly useful way to think about reality. 

*SM (0:33:56)*: Yeah. That’s fair. 

*MS (0:33:57)*: That seems to go well with how our brains work, even if my object-oriented friends don’t agree with me. 

*SM (0:34:03)*: I think that that’s a really good way of putting it, which is in some sense, functional programming seems to work because it really matches our mental model of abstraction, which is I want to be able to ignore all the bits of it and there’s only the salient aspects, and the salient aspects composed in a really denotational way. I need to think only about meanings and not about implementations because my brain can only remember seven things at a time. There’s no way I’m ever going to remember anything that requires paying attention to the details. I can only get vibes. 

*MS (0:34:38)*: Yeah. That’s a great way to think about it. 

*SM (0:34:41)*: So yeah. So maybe make those vibes correspond at least a little bit to the thing you’re actually trying to talk about. 

*MS (0:34:48)*: So arguably, as an industry, we’re underusing the capabilities that code has to communicate about our domain. 

*SM (0:34:56)*: 100%. So long as you continue to think about programming as commanding the computer to do things, you’re constrained in things you think the computer can do. 

*MS (0:35:05)*: Okay. So, having backtracked. So, still want to go a little bit about your Agda book, or rather... I mean, this is the Haskell podcast, right?

*SM (0:35:17)*: Right.

*MS (0:35:19)*: So, why didn’t you do it in Haskell? Or is it not a good idea to try to do in Haskell what you’re doing with Agda there? 

*SM (0:35:26)*: Haskell can’t articulate these things, or that’s probably not true. We have this weird dependently typed thing on top of Haskell, where we have GADTs that can express type-level things, and you can bridge the gap with singleton constructors that build GADTs that move values from the value level to the type level. And then there’s the singletons library, which is a fantastic piece of engineering that allows you to do this somewhat more easily. But in Haskell, the value level and the type level are not the same thing. And the easiest way to point at this is we have functions that operate on values, and we have type families that operate on types and are kind of like functions, but type families always need to be saturated, which is that you always need to fill in every argument. Because we don’t have any notion of a type-level Lambda, it means you don’t get any higher-order things ever. So, if you want to be able to map over a list with a function F, you need to make map F. You want to do map with a function G, you need to make map G at the type level. And there is no higher order mapping function that takes another function, because you can’t articulate that function,n because everything always needs to be fully saturated. So you could do it in Haskell, but you’d be fighting the language. A lot of your energy would be spent thinking about how to express this in Haskell, not what am I trying to express. 

*MS (0:36:51)*: Okay.

*SM (0:36:51)*: So in Agda, a lot of those difficulties go away where the value level and the type level are just the same thing, and you can just call value-level functions and types and vice versa. I mean, I guess you can’t actually do that because the types aren’t values. But one of those directions is really, really, solved. 

*MS (0:37:09)*: Was it that you were trying to do something in Haskell and you thought, “Oh, I’m fighting the language, I need to move to a different one,” or is it that you always wanted? I mean, what drove you to then... what is the process that led you to then end up with Agda? 

*SM (0:37:23)*: While I was writing Algebra-Driven Design, I was trying to get a sense of how do laws compose, like algebraic laws. And so if I want to say this combinator has this property... so an example I had always was if I’m designing a key value store sort of thing, I might want to say that the key value store corresponds to the lens laws where I can put something in and take something out and this thing I get out is the thing I put in. And if I put something in twice, that’s the same as only putting it in once. And so that gives me a bunch of laws that must be true about this, which is, I guess, get of set is the same as not doing anything and just returning the thing that I set. That’s interesting, but then maybe I want this. Maybe I want my keys to form a monoid. Maybe it’s not for any K, any key K. It’s over some particular key because I’m modeling some piece of software. I think at the time, it doesn’t matter what I was modeling. So now I’ve got two sets of laws that I want. I want my map to satisfy the lens laws, and I want my keys to satisfy the monoid laws, and sometimes these laws compose, and sometimes they don’t.

And so at the time, I was writing a little solver thing where you would say, “Here’s all my laws, and give me all of the downstream implications of what happens when I compose these laws.” And I found when I added this monoid thing, all of a sudden, I was getting like, it was impossible to satisfy one of the lens laws because something about mempty. I don’t remember exactly the details. But it seemed like a really cool thing where a fantastic strategy for designing software which is write down all the laws you want to make sure that they’re confluent. Before I write any code, just make sure that my ideation of the problem makes sense. So while I was trying to code this up, it turned into quite a boondoggle and led me to finding QuickSpec, which is what I talk about in Algebraic-Driven Design. It’s a fantastic library. But I kept this problem in mind of how should I be reasoning about my code at a level above implementation? 

*NV (0:39:32)*: So QuickSpec automatically derives the theorems, right?

*SM (0:39:36)*: It does. Yeah. So QuickSpec is like QuickCheck where you give it some generators, and then you say, “Here is the vocabulary. Here’s the combinators and my thing,” and it will generate all sorts of random things and try to find identities. It’ll say if I compose these two functions, I always get the same result as composing these two functions. And so it will try to stochastically spit out a bunch of laws that seem to hold of your combinators, which was the same thing I wanted, except it would find them by default rather than me saying, “Here are the things I want.” 

It turns out, I think, in practice, QuickSpec, I haven’t ended up using too much. In Algebra-Driven Design, I think a lot of the value is you write this model, and then you find out which identities hold. And then you turn those into property tests. And then you write a real implementation, and the real implementation must satisfy all those identities. And so it’s quite cool if you want to generate tests, especially when you’re moving between domains, which you can imagine as I’m modeling this in Haskell, and I’m going to implement it in Python. So I could generate Python tests and then rewrite it in Python and make sure it agrees exactly. 

But I found QuickCheck has not been as useful for thinking about the problem because it composes a bunch of laws that seem to be true, but I think are not true in any deep way. It’ll tell you things that don’t correspond to any property as a human I would ever want to talk about. 

*NV (0:41:04)*: Do you have an example...

*SM (0:41:06)*: Oh.

*NV (0:41:08)*: ...in your book? 

*SM (0:41:09)*: Yeah. The book has... I think one of the chapters has three pages worth of just randomly generated properties. You can reason through why they might make sense, but it seems like... you know, it’s like if you have a Boolean and you negate it, it’s the same as taking one from the enum value, which I don’t think is true for any deep reason. It’s like a property of the encoding rather than of the problem itself. 

*NV (0:41:33)*: So there are properties that hold, but you don’t see why you care. 

*SM (0:41:37)*: Yeah. I think that’s a good phrasing of it. 

*MS (0:41:39)*: Yeah. I like it.

*SM (0:41:40)*: They don’t seem to say anything deep. 

*NV (0:41:43)*: Okay. 

*SM (0:41:44)*: So I guess long story short is, I was looking to model how should you actually be thinking about laws, and Agda was a good tool for doing that in a way I never figured out how to do adequately in Haskell. 

*MS (0:41:54)*: Is that a general direction that, I mean, if we like programming Haskell today, should we want to program in some descendant of Agda in the future at some point?

*SM (0:42:06)*: I’m on the fence about this because, Agda, the barrier for getting things done is so much higher. And that’s both in terms of ergonomics, but it’s also in terms of the things I think about are deeper, and because of that, I get less done. And so in Agda, I often find myself proving things that are clearly true, but proving them is nontrivial. 

And so, for example, at work right now, I’m trying to compile a stack machine. And so I’ve got a stack somewhere, and I want to say I’m just going to find the lambda calculus down to a stack machine, and I want to say, “Well, the things like the left bindings in the lambda calculus never go off the stack until it’s fine.” And so to prove this is quite challenging in Agda because all of a sudden I need to model what the stack is, and I need to model where things are on the stack, and I need to give a proof that says this thing can’t come off the stack until sometime. And if I were to just write the compile function, it’d be clear that it doesn’t happen. But as soon as I switch to the Agda mode, I’m like, “Oh, I need to prove it.” And because of that, I don’t get anything done. It’s very satisfying. It’s a lot of fun, but I don’t get anything done. 

*MS (0:43:20)*: That’s a good point. I think we need to watch out for that. I talk to people from the Domain-Driven Design Community, who were around in the ‘80s. And at least in Germany in the ‘80s, a formalization craze swept through the country, apparently, and everybody. And you were not considered a serious computer science person if you didn’t prove your programs correct or if you didn’t prove everything about your programs correct. 

*SM (0:43:47)*: I love it. 

*MS (0:43:48)*: People are still traumatized by that. They feel great about having won that fight against the formalization people. But of course, the whole field kind of overcompensated if that’s what it did. 

*SM (0:44:05)*: I’m pretty woefully ignorant of the approaches that exist. So, Niki, I know that you’re very involved with LiquidHaskell, which I must admit I’ve never actually tried, but it seems like a good trade off in the space of saying, “Here are some properties that hold and figure it out for me,” rather than I need to go through the proof of of doing it. It’s like, get the computer down, you know? It’s like find a different space in the ergonomics where Agda is very clearly a Haskell descendant of what if we make the type system way more expressive, but in the same sort of way where all of it I just have pattern matching and now I have equalities that can come out of it and what can we do with that? And you can do a lot, but a lot of things around numbers are not very ergonomic because I need to think about how do I model the rationals, for example. And now do I want to say that division by zero is impossible by construction? And if so, just propagating all of that sucks. Just every time I went to do anything in Agda, I found myself in a deep rabbit hole trying to solve a completely unrelated problem because either I couldn’t find where in the library was solved or the solution didn’t work for me or I was just proving some lemma that turned out to be false, but I spent a day on it. 

*NV (0:45:19)*: You should have QuickCheck it first. 

*SM (0:45:22)*: I don’t think Agda has QuickCheck. Yeah. That was the thing that I really liked in Lean, I think it was, where there’s a library function saying, “Try to QuickCheck this,” and it’ll try it before you know if you should try proving or not. But as far as I know, that doesn’t exist in Agda. 

*NV (0:45:35)*: Yeah. Maybe Lean is in a better setting between a real programming language and a tool that helps you prove theory.

*SM (0:45:44)*: Yeah. 

*NV (0:45:45)*: It is designed more with this in mind. 

*SM (0:45:47)*: I looked briefly into Lean, but it felt much more like a descendant of C++ than it did of the language I want to write. And I found I managed to prove quite a lot of Lean, but I had absolutely no idea what I was doing or how it would work. And so the tactic rewriting, I would just type things in, and it would say proved. I don’t wouldn’t know why. And so I found I learned a lot more about computation by going through the path of Agda, where it says, “Well, if I pattern match on this, then I know these things are equal,” and that worked much better for my Haskell brain to understand what was going on behind the hood. 

*NV (0:46:26)*: So what is next? 

*SM (0:46:28)*: I’m vaguely considering writing another book because I’m a masochist and I keep forgetting how awful it is. And in particular, I’m pretty excited about exploring this idea of functional design patterns. And I had a job a little while ago, and a lot of what I found I was doing in reviews was like wishing my coworkers had more folklore knowledge of just how to shape solutions to problems. And I realized I don’t think anyone’s ever written that down, and there’s probably quite a lot of value in it. 

So, for example, things like when I was working on the Haskell language server, we had this problem where we would cache values, and we’d pull them out of the cache, and they might be stale if they came out of the cache. And that was fine, and you could forward, fast forward to them to the future by some diff solution. But if you pulled two things out of the cache, they might come from different times in the past. So we had all these bugs where these two things were marked as stale, but they were differently stale, and so they didn’t correspond to the same state of code base. So, one solution for that was to add an existential type variable to the constructor of stale such that you got the stale out and it told you it was stale, but two things that were stale were not comparable to one another because you couldn’t prove that this has an existential type variable or the same. And so we introduced this change, and all of a sudden, every bug in the program that had this thing got a red underline underneath, saying, “Oh, all of a sudden, you’re doing causality problems.” And so it was like a tiny change that rippled to the code base, and it showed us a bunch of bugs that were already there that we didn’t know about. 

That’s the flavor of things I want to explore if I were to write this book, which I’m not committing to. But what sorts of little design patterns like that will go a long way into solving problems that seem really hard otherwise? 

*MS (0:48:20)*: It seems quite a few people are thinking, you know, for the longest time, the functional programming community has had this high and mighty attitude that we don’t need no stinking patterns, or all the Gang of Four patterns are just code...

*SM (0:48:31)*: Right. 

*MS (0:48:32)*: ...in our functional language, and therefore, we don’t need this thing at all. So, looking forward to that.

*SM (0:48:37)*: Again, not promising anything. But I’ve gotten to a point where it feels like I can’t not work on this. So usually that leads to a few years of frustration and pain, and then some cool artifact comes at the end of it. But it’s never a great process. 

*MS (0:48:51)*: All right. Well, that was a long arc connected to Haskell in all kinds of different places, from practical programming to books to types. Thank you so much, Sandy.

*NV (0:49:01)*: Thank you. 

*SM (0:49:02)*: My pleasure. Thank you for having me.

*Narrator (0:49:08)*: The Haskell Interlude Podcast is a project of the Haskell Foundation. It is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
