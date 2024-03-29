*Wouter Swierstra (0:00:14)*: Welcome to the next episode of the Haskell Interlude. I’m Wouter Swierstra, and I’m joined today by Andres Löh. And our guest is Edwin Brady, famous for creating the Idris programming language. Edwin will tell us a little bit about syntax that’s real or not, programming with first-class types, and the language strangeness budget for a programming language like Idris. Welcome, Edwin. The usual question we ask our guests is, how did you get into Haskell?

*Edwin Brady (0:00:46)*: That’s always a fun question, isn’t it? So, I first encountered Haskell in 19 – it’ll be 1996, as a student at Durham University, where in the second year – so, they taught us Modula-2 in the first year. That’s how up-to-date we were back in 1995. And then in the second year, they hit us with Gofer, which was, I don’t know if you remember Gofer. Gofer was a – I guess you’d call it a very cut-down Haskell. It was essentially Haskell. I mean, it was a way of learning functional programming in a small environment that ran on the little lab machines we had. 

*Andres Löh (0:01:32)*: It was the direct precursor of Hugs, right? 

*EB (0:01:36)*: Exactly. Yes. So, I mean, Hugs standing for Haskell User’s Gofer System. 

*AL (0:01:40)*: Yeah.

*EB (0:01:41)*: So, I’m just thinking about the things that Gofer didn’t have. The main thing I remember it not having, at least in the version we were using, was any way of writing interactive programs. So, naturally, as a result, we were all completely mystified as to why you would be using this kind of system. So, honestly, it just struck me as a needlessly hard way to write programs. And it took several years before something clicked. I enjoyed it. It was fun as a kind of – more as kind of an intellectual exercise than the kind of, “Oh, I’m going to do programming this way.” 

The thing that actually got me to think, “Oh, I want to go back to functional programming,” came a couple of years later. So, I didn’t go straight into academia after I graduated. I had a job at a natural language processing company that was a spinoff from the research that was happening at Durham University. So, they don’t exist anymore, but they were – sort of getting sidetracked here slightly, but they did natural language processing and attempted to understand the language and do some meaningful reasoning about the things that were said rather than, for example, guessing like other systems might do. 

Anyway, my role in that whole system was in the reasoning fragment. So, there was what I would now call domain-specific language, which we’re using for describing concepts and relationships between them. Anyway, while I was doing this all in C++, there was a point where I thought this would be so much easier if I had algebraic data types. And then my brain went back to Haskell and thought, “Oh, maybe I should – I’m not going to be able to do it for the job of this company because we were writing in C++,” because we had to. But we got the whole thing to fit on a 1.4-megabyte floppy, which was, I don’t know. Thinking about that now, I have no idea how we did that. So, I started thinking, “Okay, I’m going to have a play with Haskell again because that was quite cool.”

So, following onto that, the company ran out of money. I did a short-term contract at Sunderland University, and someone you might know, Alan Bundy, came and gave a talk about reasoning about CPU design. And I just thought, “Wow, that’s really cool that you can even think about proving the correctness of something on that scale. I want to go back to university and do this kind of stuff myself.” So, at that point, I thought, “Functional languages were good for this sort of thing. Maybe I should go and seriously look at this.”

Anyway, I ended up back at Durham University learning about type theory, learning about reasoning about software. And Haskell was just the natural implementation language for all of the messing about I was doing. So, it was quite a long path to Haskell, is what I’m saying.

*WS (0:04:45)*: So, this was for your PhD. You went back to Durham to do a PhD?

*EB (0:04:50)*: Yeah.

*WS (0:04:51)*: And I guess your supervisor at the time was James McKenna, is that right?

*EB (0:04:54)*: Yeah, James McKenna was my primary supervisor. Conor McBride was around – and he was a kind of unofficial second supervisor. So, this was the time when they were designing Epigram. So, I ended up not directly involved in the Epigram project itself, but thinking about, “Okay, this is cool, but how do we run these programs?” So, I started thinking about taking the core type theory and compiling it.* 

*WS (0:05:24)*: Right. So, this is related back to your first impression of Gofer, I guess, which didn’t have IO, and then you saw an even weirder dependently typed programming language.

*EB (0:05:35)*: Well, yes. I’m thinking the same thing. But I think I did later discover that Gofer did have some ways of doing IO. So, it was a response request. So, you get a stream of responses from the system, and you produce a stream of requests back to the system, which actually I still think is really neat. It’s not a particularly easy way to program, but there’s something quite pleasing about it. 

Anyway, yes, I did have similar sorts of feelings. I was playing with – so, my experiments were in a theorem prover that came out of Edinburgh called LEGO. And you’re using unary natural numbers to do arithmetic, and I’m thinking, “You can’t seriously be telling me that this is the way we’re supposed to program.” Of course, I know better now. I know that this is not actually what they’re for even. So, I was thinking, “What do I do to make these things run in some plausible, usable way?”

*WS (0:06:32)*: Right. So, your PhD was not yet on Idris, right? 

*EB (0:06:37)*: No, Idris came a few years after.

*WS (0:06:40)*: Yeah. I think your PhD – well, you can tell me what it was about, I guess. 

*EB (0:06:46)*: So, the title is—I laugh at this title now—Practical Implementation of a Dependently Typed Functional Programming Language. The thing that I find hilarious about that title is the word ‘practical.’ There’s no way I would ever use the word ‘practical’ now to describe, I don’t know, anything I do. Not because I think it’s impractical, but because I think it’s a judgment that other people make about your work. It’s not a judgment you get to make about your own work. 

Anyway, the point of the thesis was to figure out how to – or the central thesis, was we can take these programs with all of the proof information in them, and we can turn them into something that is runnable. So, correctness does not need to come at the expense of performance. And actually, the central idea, like the thing I did, really an incredibly simple thing, I think, which is that in a dependently typed data structure, you have to have additional bits of information just to be able to type-check it.

So, let’s go back to everybody’s favorites—the vectors. We have to have vectors. I’m talking about dependent types, so by law, I have to mention vectors. So, the comm cell in a vector contains the length of the rest of the vector. It’s just in there, and it’s duplicated throughout. And the central thing in the thesis was a transformation called forcing, which identified that that bit of information was in there twice. So, delete it, which sounds, looking back now – in fact, we wrote up a paper on this, and one reviewer said, “Reject this paper because this is so simple and so easy to understand that I can’t believe it hasn’t been done before.” Well, it hasn’t that nobody thought of it. Turns out it works really well for a huge number of programs. 

So, yeah, that was the basic idea, and it was – looking back now, it feels like a fairly simple idea, but nobody had even thought about making dependently typed programs run, not this kind of dependently typed program run. So, yeah, that’s why I got away with it.

*AL (0:08:53)*: But I guess, in fairness, that is actually part of it, right? I mean, not that many people have been interested in dependently typed programming for the purpose of actually running stuff at that time, right?

*EB (0:09:04)*: Yeah. So, I think James and Conor were really the first ones who were taking it seriously.

*AL (0:09:09)*: So, the language that you use within your thesis, was that sort of a specific toy language designed for your thesis, or was that Epigram or – 

*EB (0:09:21)*: It was always intended to be Epigram, but I mean, I was hoping that by the end. I would be able to plug everything into Epigram. But for various reasons – I mean, it’s too big a system for one thing. Putting everything together was just a bit too complicated. And at the end of the day, in a PhD or really in any piece of research, you don’t want the baggage of some massive system that you have to deal with. So, having just the essence of the idea in a small system is probably a safer thing to do. That’s not the reason I did it that way. I did it that way by accident. I just found myself implementing a theorem prover because I needed to have something simple to be able to compile the programs. So, I did that, and it went by the name of TT as I remember it. I was very creative in my naming. TT for type theory. People have suggested that I could have called it TT because it looks a bit like a capital Pi. So, I’m going to go with that. 

So, yeah, it was just a little system that allowed me to declare inductive data types. It allowed me to do inductive proofs. So, yeah, it didn’t even really have a nice surface language. It was interactive proofs, Cox style basically, where you say, “I’m going to do induction on n, now I’m going to give the base case and the inductive case.” 

So, it was a pretty painful way to program. And so, the programs that I was compiling were not that big. It was unrealistic to do any large-scale experiments on performance, but we could do things like implement an abstract machine and see how many instructions and how many memory accesses things took, so we could get some idea of how things were working. So, yeah, I implemented a compiler to a G-machine emulator, essentially. So, it was lazy at the time.

*WS (0:11:19)*: So, how did Idris come about? Because that’s probably what most people know you for.

*EB (0:11:25)*: Yeah. So, that was by accident. So many things happen by accident, don’t they? So, yeah, after finishing at Durham, I moved up to St. Andrews to do a postdoc with Kevin Hammond. And that was on – multi-stage programming was the idea, which is an interesting idea that I think I want to come back to in the next few weeks. But I was also kind of – while there, I was thinking about, okay, how can we get multi-stage programming into a dependently typed language? So, I need the language. I’m not going to use the toy I did for my PhD because it’s just so incredibly hacky and want to try something else, basically. 

So, one thing I did was work on a target language, basically. So, it’s something I could compile and run. So, this was partly intended as a target language for Epigram, but also just because, at the time, I fancied myself as someone who was able to write runtime systems. So, I wrote this thing that compiled a simple supercombinator language down to C, which we called Epic. That was James’ suggestion. So, Epigram to C, basically. So, Epic. So, that was a very simple untyped functional language. All it had was – well, it was the Lambda calculus plus simple case trees. Eventually, I added lambda lifting. So, it started with just supercombinators. So, all lambdas at the top level. Eventually, I added lambdas, so you didn’t have to do that by hand. 

So, yeah, I had this target language. And I write programs in it, and that they – because there was now some kind of human-writeable target language, they could go a bit larger scale. At the same time, because I was experimenting with multi-stage programming, I had a front end which I called Ivor—Ivor the Engine. So, British people who are about my age might understand why I called it Ivor the Engine. So, this was just a series of kid’s books and TV show. It was a proof engine. I needed a name because I needed to submit it. I didn’t need to, but I wanted to submit it to the Haskell Communities and Activities Report. So, I came up with a name in a hurry so that I could give it the title. And yeah, I went with Ivor, because Ivor seemed like a good name for a theorem prover. 

Now, once you’ve got a front end and a backend, you might as well glue them together and see what happens. So, Idris ended up being a front-end language that desugared to the Ivor syntax that then compiled through Epic to see. Then I could write dependently typed programs in an existing language. So, I didn’t set out to make it. There was just a point where I thought, “Hang on, it wouldn’t be that hard to add a desugaring step that makes this a language.” So, there it was. 

So, it was a horrible implementation because it was held together with duct tape and string, but it worked. And it then became a thing that I could probably experiment with. It had IO, for example. I could write interactive programs. I was doing things like network programming and just packet formatting, and just the things that I thought we ought to be able to do, but hadn’t been able to so far. And I think that this was roughly the time that the new Agda was starting to be built. They deliberately set out to make a system, and therefore it worked better that I had the system by accident. 

Actually, I mean, just as an aside, people do sometimes ask me, why make Idris when Agda exists? And part of the answer to that is, when I started, it didn’t. And another part of the answer is, I think it’s good to have multiple systems, even if on the surface they look like they do the same thing, because you are going to do different experiments, and also you’re going to learn from each other. I’ve certainly learned a lot from talking to Agda developers about how their system is implemented. I think they’ve learned things from me. I hope they’ve learned things from me about how Idris is implemented. We end up making both systems better. 

*WS (0:16:01)*: So, what are the differences between Idris and Agda?

*EB (0:16:06)*: That’s probably a better – someone who uses both systems actively might be a better place to answer that. But –

*WS (0:16:14)*: Maybe the design decisions then.

*EB (0:16:16)*: Yeah. Maybe the most important thing is that Idris started from the backend and Agda started from the front end. Is that fair? 

*WS (0:16:30)*: Did you tell me? I –

*EB (0:16:31)*: I mean, because I used to say, “Oh, well, Idris is a programming language and Agda is a theorem prover.” That’s not true, really. That’s not really fair because, well, for one thing, theorem provers and programming languages are the same thing, at least up to a point.

*WS (0:16:49)*: Conceptually, yes. But in practice, if you look at UI or UX or language features or support –

*EB (0:16:58)*: So, yeah, it’s a – but you’re right. That’s part of the point. It’s a question of the emphasis that the developers place on it. What goes in the standard libraries? So, I remember you could ask the question, is Agda strict or lazy? And I think people would answer yes. Now, Idris is definitely strict. The reason for that is, again, an accident. When I wrote Epic, I’d written a lazy backend, and I wanted to write a strict one this time just for a change. I actually now do think it was the right choice, but it was by accident. 

So, Idris, there is – you do know whether it’s going to be strict or lazy. It’s strict. And when you are writing your programs, when you’re writing libraries, you have to write with that in mind. So, if it could go either way, well, how do you write the libraries? So, it’s a tricky one. This does still – because I learned Haskell, this does still bite me occasionally when I forget that it is strict. But it doesn’t take long to work it out. 

I would say being strict – a strict language is occasionally annoying, but not that annoying. And the payoff is you know when things are going to happen. So, there’s one difference. Idris has a runtime that we have some kind of model in our heads, at least for what it does. And I’m not certain you can say that about Agda. Someone will probably shout at me that that’s not fair. 

*AL (0:18:30)*: I mean, independently of the whole laziness versus strictness discussion, I think it is just useful to have a clear idea of what the evaluation model is actually going to be because you see that even in Haskell when it comes to, say, the reduction of type families. There you don’t actually have a very clear model when these reductions are going to happen and to what extent. And that makes it actually extremely difficult to reason about compile time performance of certain programs. And I guess in either, it’s strict at all levels, right?

*EB (0:19:06)*: Well, that’s an interesting point actually about compile time performance. Because the compile time evaluator in Idris is, well, it’s a thing that I’ve been rewriting like the last year or so. So, I’ve essentially thrown away the old core, started on a new one because the compile time performance was occasionally quite bad. It was occasionally too strict. So, at compile time, I want to not evaluate things if I don’t have to. And this can be really important, it turns out. At compile time, Idris is lazy. The compile time evaluator is lazy. But compile time evaluation, runtime evaluation—well, I suppose this is also part of my thesis—are different things. 

*AL (0:19:59)*: Oh, they are very different in nature. But it is nevertheless also quite desirable to have some ability as a programmer to reason about compile time performance because that becomes much more important than a language in which you can write arbitrary computations to happen in the type system very easily. And you’re even encouraged to do that.

*EB (0:20:20)*: Yeah. We’ve certainly encountered programs where it would’ve been better at compile time to evaluate the whole thing. Other programs where it’s definitely better to not do that and only head normalize things, weak head normalize things. I mean, in practice, that’s what we want to do at compile time, is produce a weak head normal form, like only evaluate the head of the thing.

*WS (0:20:40)*: But why does Idris need to do compile time evaluation?

*EB (0:20:44)*: So, this is for type checking. This is – I know why you asked that question. So, I’m going to answer it in that spirit. So, let’s come up with a really small example of this. I’m going to go back to the vectors again. So, let’s imagine I have a function that requires a vector of length 4, and I have a vector of length 2 and another vector of length 2. So, I can concatenate them and get a vector of length 4, no problem. So, I will run the append function that takes my vector of length 2 and my other vector of length 2. So, what’s the type of append? Take the vector of length x, vector of length y, returns a vector of length x + y. So, I feed my two vectors of length 2 into that function. What do I get? Well, according to the type, I get a vector of length 2 + 2. Is 2 + 2 = 4?

*WS (0:21:44)*: If you evaluate.

*EB (0:21:45)*: Well, that depends, doesn’t it? That depends whether we’re talking about syntactically or semantically. So, the only way I know I have a vector of length 4 is by evaluating 2 + 2. So, compile time, if I have something of one type and I need something of another type, at least conceptually, what we can do is normalize the two types. So, just evaluate the two types and see if they’re the same. Practically, it’s a little bit cleverer than that, but conceptually, that’s how you can think of it, that it normalizes the types and see if they’re the same. So, the evaluator is there because you need to know if two things are convertible. 

*WS (0:22:26)*: Right. And does it make sense to have two different evaluation mechanisms? One for runtime, one for compile time?

*EB (0:22:33)*: Right. This is important because, at compile time, you don’t necessarily know what all – well, you hopefully don’t know what all of your inputs to your program are going to be. Because when you run it, a user is going to come along and start typing things. So, at compile time, you’re doing evaluation with incomplete knowledge. So, there are going to be – potentially, there’s going to be variables. That’s so unknown variables. 

As an example, is there a simple example of this? Not really without – depending on the actual implementation. But let’s say I’m evaluating, I don’t know, x plus – yeah, successor of x + y. That will evaluate to successor of x + y. I need to put brackets in there. So, there will be one step of evaluation we can do. And then we get stuck. So, we’ll do as much evaluation as we can until we get stuck. And then – oh, actually, no. There is an example we can do with our vectors, going back to our vectors. So, our vector of length 4 and our vector of length 2 + 2 but of unknown type. So, vector of a’s of length 4, vector of a’s of length 2 + 2. We don’t know a, so we can’t evaluate that bit. We get stuck on that bit. 

Now at runtime, we don’t evaluate things. We don’t progress with evaluation until we get the input. And you can take advantage of that. You say, every time I do a case analysis on something, it’s going to be in canonical form. There’s going to be a constructor there. I know that. So, the compiler can take advantage of that. Whereas a compile time, the evaluator needs to take into account that something might be unknown. A case expression might get stuck. Therefore, I have to be able to represent unevaluated expressions. 

Also, things like – so, I was talking about the forcing optimization from my thesis. So, at compile time, you need to know that two things really are equivalent. So, two subexpressions really are equivalent. So, you can’t apply the forcing optimization necessarily at compile time, whereas you can at runtime. So, at compile time, you’re checking that these things are the same. So, at runtime, you don’t have to. So, at runtime, you’ve raised a lot of the stuff that is needed for the compile time evaluation. Again, this is another – I’m getting sidetracked again, but another thing I think is worth noting. 

We sometimes talk about phase distinctions. So, types and values and type erasure. That was the analogy with a more mainstream type system. At runtime, you erase the types. So, a C compiler does not compile int to a runtime representation. It doesn’t compile char* to a runtime representation. So, it’s erasing the types. Now, in a conventional mainstream language, the distinction between types and values is just there. It’s a syntactic thing. So, there’s, in Haskell terms, left of the double colon, right, of the double colon, erase what’s right of the double colon. 

As soon as you have a dependently typed language, it’s a bit more complicated than that. You can still erase things right of the colon because the types aren’t going to be used. But there are things that are left of the colon in the things that look like terms that are actually compile time only. So, when we talk about phase distinctions, it’s not types and values; it’s compile time and runtime. And it is just a complete coincidence that in a mainstream simply type language they are equivalent. As soon as your type system gets in any way interesting, they’re not equivalent anymore. 

*WS (0:26:40)*: So, you mentioned this distinction between strict and lazy evaluation, but in a total language, surely there’s no difference.

*EB (0:26:51)*: Yeah. I mean, in terms of where you – the value you end up at, sure. You’ll get the same result. You won’t necessarily get it in the same time. So, we still want to reason about performance. All the same space. So, you might get space leaks, for example. And then the flip side of it is you might do unnecessary evaluation in the strict language. So, you still have to think about – you still have to reason about performance. So, yes, you will get the same answer eventually. 

Now, talking about total programming, Idris has a totality checker. It doesn’t require programs to be total by default. Now, sometimes people complain about that. Well, I think with some justification. So, Idris by default has a coverage checker, which means that all inputs to the function have to be handled by the case analysis. But it doesn’t by – well, you can turn that off if you like as well, but it doesn’t by default check for termination. 

I’d say it’s partly down to this concept of the language strangeness budget. I don’t know if you’ve encountered this. I really enjoy this concept. So, I believe it’s due to Steve Klabnik, one of the Rust developers. So, the idea is, when you make a new language, your users are only going to take so much strangeness before they give up. So, my feeling with Idris – because Idris was originally targeted at Haskell programmers just because that seemed to be the most obvious place where we’d find people who would even tolerate something this strange. 

So, Idris has this additional bit of strangeness beyond Haskell, which is the dependent types. And at that point, I thought we had spent our entire strangeness budget. I mean, we may overspend if we’re targeting Haskell programmers because we’re strict rather than lazy. So, maybe that’s part of the language strangeness. So, yeah, I thought, okay, we’ve spent the strangeness budget, we can’t require totality. We’ll kind of sneak that in later on as people get more used to it. Also, as we get better at it because the halting problem, we can’t know for certain whether a program – if a given program terminates, we can’t decide in all cases whether it does or not. So, our totality checker is only ever going to be a partial checker according to the rules that we understand how to implement. 

So, we have to introduce – well, we have introduced a few cheats if you know better than the compiler, that sort of thing. So, it’s not a thing that’s turned on by default. And therefore, your programs, we can’t be certain the programs are going to terminate in all cases. When we are certain there’s, there’s maybe some more aggressive optimizations we can do, but generally, we can’t.

*WS (0:30:09)*: So, you mentioned that Idris was targeted at Haskell programmers, but what’s the difference between Idris and Haskell?

*EB (0:30:18)*: The most obvious one, of course, is going to be the dependent types. Of course, Haskell has dependent types in various ways. Perhaps we’ll come back to that. But Idris’s form of dependent types, we used to call it full spectrum dependent types. These days, I like to call them first-class types. So, when we teach, or when I teach functional programming at least, one of the first things I say is functions are first class, meaning that you can pass or you can store them in variables, you can pass them to functions, you can return them from functions. If you can do it with an integer, you can do it with a function, kind of. You can’t add functions. But if you can store it in variable, then you can pass it to function, then it’s first class. 

So, Haskell and pure functional languages and, well, any language that supports functional programming, you have first-class functions. Idris, you have first-class types. So, exactly the same thing. You can pass types to functions, return types from functions, you can store them in variables. So, there’s nothing special about types, nothing special about values.

*WS (0:31:33)*: But you could argue that a polymorphic language with a big lambda still has first-class functions without being dependently typed, where you can abstract over functions and pass them around as arguments.

*EB (0:31:47)*: Yeah. Right. So, that’s fine for functional languages. But when you are passing types around, you’re passing them around with the big lambda. So, you have the special lambda for types, and then you have the lambda for values, the little lambda for values. So, Idris, only one lambda. So, that will take a type or a value. So, that distinction – now some people say that can make things incredibly complicated. I actually think it makes things a lot simpler. Makes your language a lot smaller. Gives me less to think about in the implementation because I only have one data structure for terms, and it captures types as well. So, I would say that maybe that’s another way of making the distinction. So, polymorphic languages will be based on some core language with a big lambda, whereas a dependently typed language with first-class types, there’s just the one lambda.

*AL (0:32:49)*: Yeah. So, I actually wanted to ask a little bit, because it’s so much fun, about concrete syntax. I mean, you made it relatively similar-looking to Haskell. And given that at the time, I think you were also working with languages like Epigram, or you mentioned LEGO. And what I’ve seen of these, they look very different from Haskell. So, was that a deliberate choice because you were targeting Haskell programmers, or was that because you thought Haskell has such a great syntax? What are the thoughts about it?

*EB (0:33:27)*: I do actually quite like Haskell syntax. So, it was a natural thing to do. But yeah, it was mostly because I was thinking – I mean, I was writing papers using the Epigram syntax. So, I was taking the horrible theorem prover notation—it’s not readable; it’s just write-only code—and turning it into something that looked like the program I had in mind using the Epigram syntax. And I kept getting the sense that people would look at this and say, “Yeah, but it’s not real, is it? This is not a language I could program in.” Well, fair enough. Eventually, I just started right. I’m going to give this a Haskell-like syntax. And instead of doing the fancy typeset version in the papers, I literally am going to write it in typewriter fonts, like it is in my program. So, the choice of syntax was partly because Haskell syntax, it’s nice enough. It’s an ideal syntax for this kind of pure functional language, I think, and because it makes it comfortable, familiar to Haskell programmers. 

Now, the one thing that is different that I absolutely have to mention, and I think this is vitally important, is that Idris uses a single colon for type declarations; Haskell uses a double colon for type declarations because that’s just the right way around. Now, that’s my view. Long after I made this choice, I actually learned why Haskell does it the way it does. So, I learned this from David Turner.

*AL (0:35:11)*: Is that differently from what I thought is the reason? But yeah, you go ahead. 

*EB (0:35:15)*: Oh, maybe.

*AL (0:35:16)*: Oh yeah. Go ahead. I’m curious.

*EB (0:35:19)*: Maybe we’ve both heard stories that are just developed over time or from different sources. Anyway, I heard from David Turner, the reason Haskell has a double colon goes back to Miranda. So, Miranda had the double colon. And the reason Miranda has the double colon for types is that, having type inference, David Turner’s feeling was that he would be writing more commas than types. And therefore, commas should have the shortest syntax. 

*AL (0:35:51)*: Yeah, no, I think that pretty much – I mean, that’s like a minor variance of what I thought.

*EB (0:35:56)*: I mean, it will be different. It will evolve over time as different people tell the story. 

*AL (0:36:03)*: Yeah. But certainly, I think at that time, right? At that time, when Miranda and Haskell – when Haskell started, I think lists were all the rage, right? I mean, lists were almost synonymous with functional programming. Richard Byrd was talking about how to program with lists. So, I think it was like, people felt this should be given the prominence. Yeah.

*EB (0:36:28)*: Yeah. I think that makes absolute sense for the way at the time. But just because something made sense in the ‘80s doesn’t mean it has to make sense now. We can go back and revisit these things. It can be a bit of a pain for people, I hear, but you get used to it anyway.

*WS (0:36:45)*: So, we’ve touched a little bit on the subject of dependent types and Haskell as well, but what are your thoughts on the development of Haskell as a dependently typed language?

*EB (0:36:58)*: I mean, it’s pretty cool, isn’t it? I should say, be clear before I attempt to answer this. So, these days, I do rarely use Haskell, which means it’s terrible for me to come on Haskell podcast. I do teach Haskell, to be fair. So, I use it. I certainly use it when teaching the undergrads. But yeah, I don’t use it so much for my own work ever since Idris became implemented in Idris.

*AL (0:37:30)*: Yeah. Perhaps, actually, we should change the order slightly around and first talk about when and why you decided to re-implement Idris in Idris and then come back to what do you think about dependent Haskell.

*EB (0:37:48)*: Sure. Why did I decide to write Idris in Idris? It was that there was a point in – it must’ve been about late 2018, something like that, where I was thinking, “I mess around a lot with this language. I do little toy things. It would be good to write something bigger. Let’s see how this scales,” and just thinking around for things I could implement. The things I know how to implement are Idris. You know, compilers. And then, well, it’s probably valuable to have a self-hosted compiler. Also, I was thinking this needs re-implementing. The system, it’s far too slow. There’s a lot of cruft in there. There’s some things that I think should be done differently that are hard to – the core needed rewriting. I thought, well, if I’m going to rewrite the core, I might as well try rewriting it in Idris and see if we can do it any better. 

So yeah, I made a few changes to how things worked and then got cracking on it. There was quite a bit of thinking about how – if we’re going to write Idris in Idris, we have a different type system. We have a more expressive type system. So, we’re going to have to think about how best to take advantage of that. That’s a whole topic in itself. That’s a paper I aim to write at some point. 

I’ll just cut to the conclusion, which is we’ve ended up with a core representation, where the representation of terms is indexed by the names that are in scope. So, if you have an environment containing the variables x, y, z, then the term also must contain the variables x, y, z. So, if I’m unifying two terms – so, it’s part of the type checking process where we’re checking the two terms are equivalent. And so, those two terms have to have the same variables. And if they don’t, we have to arrange for them to have the same variables. So, every time we have a variable in the term, we know that it’s well-scoped because the type says so. So, it sounds like a small thing. Turns out to be really, really useful. Really, really helpful. 

So, probably the biggest source of errors in the first implementation of Idris was naming errors. So, using the brand indices to represent variables that were just wrong. So, we have to do a little bit of theorem proving to show that if we’re manipulating variables that we’ve put them in the right place, that can be frustrating to get that proof done. But once we’ve done the proof, we know it’s correct. 

Probably the trickiest one is, there’s a point where we have to reorder the variables in a term. So, this is when we’re type-checking a pattern match expression, you don’t necessarily know because you’ve just got the variable names. You don’t know which variables are going to depend on which other variables in advance. So, what we do is we invent just a global name for them and then reorder them when we do know which ones depend on what. So, that involves swapping variables in the context. And so, you have to take the variable with the brand index 0 and swap it with the variable with the brand index 1. When you go under a lambda, those numbers go up. So, good luck getting that right. 

Well, I wrote a function called swap, which takes a term with variables xy the rest and gives back a term with variables yx the rest. And I know that’s correct because the type says so. It took a while to write it, kind of fiddly. But when you write it, you know it’s going to work.

*AL (0:41:46)*: So, the Idris implementation is now really using dependent types?

*EB (0:41:51)*: Yeah, not much. I mean, that is the extent to which it does use dependent types. But just using them there means that they are now everywhere. 

*AL (0:42:00)*: Did you ever end up writing Pacman in Idris?

*EB (0:42:04)*: No. And the reason I haven’t is a very irritating one. They protect their copyright. I can’t remember who holds the copyright, but they are quite aggressive about defending it and I can’t be bothered with that. 

*AL (0:42:24)*: Oh. So, you chose an unfortunate game to make your case.

*EB (0:42:28)*: Well, I didn’t choose it. I learned it from an HCI colleague. And I can’t remember who invented the concept, which is annoying because, you know? Give credit where it’s due.

*WS (0:42:41)*: So, you mentioned that Idris uses well-scoped syntax internally as it’s implemented in Idris itself. But why not write a well-typed syntax? 

*EB (0:42:53)*: Yeah. I mean, that would be the ideal thing to do, wouldn’t it? That would be great. Before arriving at this point of well-scoped syntax, I did experiments in various different directions. And there’s a point where you are fighting with the compiler rather than working with the compiler. So, if you put too much in, then you end up fighting rather than working with it. Now, there’s a question of, why is it a fight? And that might just be a matter of the tools aren’t good enough yet. Maybe our tools need to be better, and then we can move on to having a well-typed internal representation. But right now, it seems that well-scoped is the sweet spot. I’m certainly happy to have at least that.

*AL (0:43:48)*: I must admit to my shame that I haven’t been using Idris in a long, long time. So, what is the prevalent style of proving things in Idris these days? Are you primarily using tactics-based proofs, or are you primarily just construct writing down proof terms directly or – 

*EB (0:44:05)*: Yeah, so writing down proof terms. So, there are no tactics anymore. Idris 1 had tactics because that was something part of the implementation. So, there’s some bits of syntax to help with that. So, there is a rewrite expression. And there are libraries that allow you to write explicit proof steps. So, pre-order reasoning is the library. But usually, I find the proofs I have to do are very small generally. So, it’s kind of – well, the types are indexed by lists of names. So, the proofs we have to do tend to be list associativity proofs. Once you’ve done a couple of them, they’re not that complicated. 

We’ve found that what – a general point actually. So, once your core data type has this extra bit of information – so you’re making certain kinds of illegal states representable. That’s the goal. Once you’ve done that, it does turn up everywhere in your system. So, it’s like, get your core data structures right, and then the rest of the system, you’ll be told what to do essentially when you write programs that work with that representation. 

*WS (0:45:18)*: Now, here’s a thought experiment. Suppose I want to write a Haskell 98 compiler in Idris, what kind of syntax representation should I choose?

*EB (0:45:32)*: So, do you mean in terms of whether to have a well-typed representation of the core? That’s a good question. I think you’d have an easier time of it than if you were to try that for Idris. I don’t know.

*WS (0:45:46)*: Okay.

*EB (0:45:46)*: Somebody should try. Well, the interesting thing would be – because you have type inference, how –

*WS (0:45:55)*: Okay. Haskell 98 with explicit type annotations.

*EB (0:46:00)*: I think it might make sense to have a core representation that is explicitly typed. I don’t think you’d run into the same problems we’d have with Idris. Part of what makes it a fight is because you have to write the evaluator as well. You have to encode the entire type system. So, there’s less you would have to encode. You would have to deal with your big lambda. Of course, that could be interesting. You would probably have to give up on totality checking. I mean, you’d have to make some compromises, I think. So, you wouldn’t be able to consider it a proof that your programs are all well-typed because you’d have to make these compromises in totality checking, but you’d give yourself a lot more confidence that you’ve got it right.

So, in the end, it’s a question of what are you trying to achieve by putting the thing in the type. And I think mostly what I’m trying to achieve by putting things in the type is having the compiler help me get to the right program. It’s not about – usually, it’s not about proofs. It’s about increasing confidence, increasing productivity. It can take a while to work out what the right representation is to achieve those two things. But if it’s a system that you’re going to be working on for several years, then I think it’s worth spending that time upfront.

*WS (0:47:12)*: So, shall we continue from this little intervention, which is maybe not so very little, to our original question, which was, what did you think of dependently typed Haskell?

*EB (0:47:22)*: Ah, yes. Well, I’m glad we had that little interlude because I have a challenge for dependent Haskell programmers. I occasionally go back to it and have a crack at it, see what the latest state is. And I always run into trouble because I always try to do more than is either possible or than that I know how to do. I am curious to know if this well-scoped representation of types is possible in dependent Haskell. It feels like it ought to be, but I don’t know how.

Dependent Haskell is really cool. Got to be explicit on that. I love that it is happening, and I love to see what people are doing with it. I just find it very hard because the types aren’t first-class. I essentially have to learn two different languages. I have to learn a new way of expressing things that’s not taskful itself. Now, maybe that’s the way it’s going, and eventually, it will be more like first-class types. 

But I do think that if you are going to write a dependently typed language, you should probably start by writing a dependently typed language rather than trying to put them into an existing system. On the other hand, there’s a lot of Haskell out there. There’s a lot of Haskell programmers, and a lot of systems could likely benefit from having just a little bit more type safety in certain corners of it. So, it makes sense for dependent Haskell to be a thing that is evolving.

*AL (0:48:56)*: Yeah. I mean, even Haskell is still struggling when you compare it with more mainstream languages in terms of libraries and stuff, right? But Haskell does have very many libraries these days, at least. And so, the flip side of this question might be like, okay, how easy is it to use Haskell and Idris together, and is that a realistic scenario?

*EB (0:49:22)*: So, I don’t think it’s ever really going to make sense to use Haskell libraries from Idris, partly because of the mismatch between type systems, but also because of the mismatch between lazy and strict evaluation. I think it makes more sense to use C or scheme libraries from Idris. But it depends what the libraries are, of course. So, if the library is providing a new data structure, say, well, you should rewrite that in Idris. But if it’s providing, let’s say, operating system services graphics, probably better to go through C because that library is probably written in C. Not necessarily, but probably written in C. 

So, at the minute, Idris compiles to Scheme, which is quite surprising that that works as well as it does, but it works really well. So, we can use Scheme libraries easily. We can use C libraries easily because Scheme can call C. So, there’s foreign function interfaces to other things. You’ve got to write the bindings. Whatever other language you use, you’ll have to write the function bindings. Maybe you can come up with a tool to do that for you. But there’s always going to benefit from some thought put in by the program as to what the proper dependent type interface would be. Maybe it makes more sense to call Idris from Haskell than Haskell from Idris. 

*AL (0:50:43)*: You were briefly mentioning, which is my intuition as well, at least, that it may make more sense to develop a dependently typed language from scratch than to try to put it on top of Haskell simply because Haskell already has history and constraints and so on and so forth. But all that being said, I mean, are there things about the way Idris works, whether with respect to dependent types or just in general, that you think Haskell should really learn from Idris and consider adopting?

*EB (0:51:18)*: Well, it’s hard to say whether there would be something related to the type system just because they’re so different in the fact that you’ve got first-class types and not first-class types. Are there other – I mean, maybe there’s little syntactic things that could be useful. I mean, one of the advantages of writing your own language is that you can do little syntactic things if you want. So, one of my favorites –

*AL (0:51:43)*: All your favorite shortcuts and –

*EB (0:51:45)*: Yeah. Shortcuts that I think should exist. So, one of my favorites in Idris is just a really simple thing, is that pattern matching bindings in do notation. Let’s say you do just x left arrow something. Well, that doesn’t cover. What about the nothing case? 

*AL (0:52:05)*: Yes.

*EB (0:52:06)*: So, in Idris, you can say just x left arrow, function. And then you vertical bar, nothing. So, you kind of the alternative case. So, this was actually inspired by something in Perl, believe it or not. So, in Perl, when you open the file, you say open or die. It’s just that. It’s that idea. And I use that all the time in Idris. Maybe it’s more important in Idris than in Haskell because Idris doesn’t have exceptions. By default, there’s no exceptions in the runtime. That’s partly in this goal for totality. Partly to keep the runtime a bit more lightweight. So, if you’re writing in the IO monad, functions have to return whether they succeeded or not. And that would be really irritating if you had case expressions all the way through. Now what you can do is write an IO with exceptions monad on top of that, which is actually what Idris does. But having this alternative match I’ve found to be really useful. 

Another thing I’ve found to be really – another syntactic innovation, which Haskell programmers seem to hate, is I call it bang notation. So, it allows you to program in a more direct style. So, if you’re programming in a monad, you’ve got a function that does something. All you are going to do is bind it and then pass it to the next function. So, I don’t want to be writing in that style. So, instead, I write a bang.

*AL (0:53:35)*: Yeah. So, it translates that on the fly into some sequence of binds.

*EB (0:53:40)*: I’ve had Haskell programmers tell me that that’s an abomination, and you know what? I don’t care because I like it. They usually say, “Oh, just use this or that operator.” I don’t want to have to think about which operator is the right operator in this context. That’s the compiler’s job. When I introduced that, I got a lot of pushback from Idris programmers, saying, “No, no, no.” Now, of course, they use it all the time. 

*AL (0:54:07)*: Yeah. Perhaps, let’s, towards the end, also look a little bit into the future. I mean, I would like – do you have any specific goals for Idris, or do you ever see yourself getting back to Haskell in any way? Or do you want to do yet something completely different? 

*EB (0:54:22)*: Yeah. It’s unlikely I’ll get back to Haskell except in a playing-around way. I mean, Haskell’s always going to be fun to play with.

*AL (0:54:29)*: Yeah, sure.

*EB (0:54:31)*: So, Idris, I’m currently working on a new core for Idris. I hopefully won’t be doing that too much longer because it gets a bit of a slog at some point when you’re just rewriting a thing that you’ve written before, but slightly better this time. Now, what I – so, one thing I’m interested in is staging. I think that’s something I might – again, that’s just to play around with, to see if 15, 20 years of research has made that something that is now ready for –

*AL (0:55:04)*: That’s certainly something I find quite interesting as well currently.

*EB (0:55:09)*: More excitingly and possibly heresy here. I’m curious to know if I can use the Idris core to make a more imperative type language with dependent types, because I think, much as we love functional programming, it’s not what most people do in their day jobs. And I think people can benefit from what we’ve learned about type systems in more mainstream languages. 

So, chose the Haskell syntax for Idris because I was aiming at Haskell programmers. What if we had more braces and the semicolon C-style syntax? What if we say algebraic effects as a first-class thing in the language? Just in the surface language, not in the core. Could we make something that is a little bit more, let’s say, palatable to people who typically work in C, Java, Rust? I think that might be fun to play with. And having the Idris core – let’s say something about the architecture of Idris. The surface language desugars to something that’s a bit more expressive than the type theory. I call it TTImp. So, it’s type theory with implicits. So, that type theory with implicits is actually the language that’s being elaborated and checked. Well, I could maybe write another desugaring that goes from something more imperative into TTImp, and I just wonder if that would work. And I think it’s actually worth spending a bit of time trying that. It wouldn’t impact on Idris, because I’m still essentially doing it in the Idris implementation, just a different front end. I have no idea if it’s a good idea, but you never know if something’s a good idea till you try it. So, let’s see.

*WS (0:57:02)*: Yeah. So, going from Gofer to Idris to making dependent types mainstream to finally making them really mainstream by adopting an imperative surface language. 

*EB (0:57:15)*: Yeah. We haven’t even talked about linearity and quantities. 

*WS (0:57:19)*: Oh yeah. We’ll have to have you on next time, but –

*EB (0:57:23)*: Well, the reason I mention that here is because linearity is a neat idea for showing how – so, dependent types tell you what you can do, and linear types tell you when you can do them. The reason I think it might be good to go imperative is because the linearity is a bit more natural there. So, you can say, well, I’m working through a protocol. So, if I’m working through a network protocol, I have to do this, then this, and this. The order matters. So, the combination of linear and dependent types could make that work really well. But in the current syntax for Idris, you can do it, but it looks horrible, and it’s horrible to write.

*WS (0:58:00)*: Need further Perl-inspired syntactic innovations, I guess.

*EB (0:58:04)*: Yeah. I mean, I used to do a lot of Perl programming. I’m not too proud to say that I like it.

*WS (0:58:13)*: Okay. Thanks very much for your time, Edwin.

*EB (0:58:15)*: Well, thank you for having me.

*Narrator (0:58:18)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
