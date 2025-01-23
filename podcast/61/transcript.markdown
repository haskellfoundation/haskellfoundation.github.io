*Matthías Páll Gissurarson (0:00:15)*: Hi, I’m Matti and I’m here with Andres.

*Andres Löh (0:00:19)*: Hi.

*MPG (0:00:19)*: With us today is Sam Lindley, a Reader in Programming Languages Design and Implementation at Edinburgh. He tells us about how difficult naming is, different kinds of effect systems and handlers, languages much purer than Haskell, and modal logic. So, Sam, how did you get into Haskell?

*Sam Lindley (0:00:39)*: When I was an undergrad at Oxford, I think this was my first introduction to functional programming. In fact, the very first course I started was on functional programming, and it was taught by Oege de Moor, and we were using Gofer.

*AL (0:00:56)*: Oh. What year was that?

*SL (0:00:58)*: It was 1995.

*AL (0:01:00)*: Okay.

*SL (0:01:01)*: Yeah. And it was a revelation. I’d not really seen that kind of code before. I’d just done a lot of C programming. I’d used basic assembly language. And this was my first introduction to functional programming. And I remember being very taken by how directly we could express the models we needed to do equationally. 

So, one example I remember, because Gofer was actually used in several different courses, was in a hardware course where we were set this task of specifying a model of a CPU, and because it was lazy and there was no fixed evaluation order, you just wrote down a load of equations, and it was very beautiful.

*MPG (0:01:46)*: So, what was your path after that? Because you went further and further into types and functional programming.

*SL (0:01:54)*: Well, I guess after that, I didn’t do much with Gofer or Haskell or functional programming. Yes, it was part of the degree, but then I guess it went in other directions. I actually got a job in industry. I was working for a web agency, and I became a professional C++ programmer. And it wasn’t really till I came back and did a PhD that I got properly into functional programming, and that was actually in Edinburgh. I was working with ML at that time. And then somehow, I don’t know, I ended up doing later work with Haskell. It was more convenient for doing certain kinds of prototyping than ML was and a much richer type system. So, when I was using ML, that was standard ML. And yeah, I just had a lot of fun trying different things out. So, I remember we had this paper on Unembedding Domain-Specific Languages where we were translating between different encodings of binders using higher-order abstract syntax and De Bruijn representations, and Haskell was just expressive enough to be able to write that, and it also allows you to cheat.

*AL (0:03:12)*: I mean, since you’re mentioning all this now, I think we’ll have to go a little bit more into the details here. So, can you perhaps, sort of in general terms, explain what the whole problem is?

*SL (0:03:24)*: Yes. So, names. Names are a funny thing. Naively, they seem really simple, and it seems like it shouldn’t be a big research problem to work out how to encode names. But as soon as you start trying to do metaprogramming or embed one programming language in another, you have to be really careful about how you do your names. And there are so many different papers on how to do this in various different proof assistants and so forth. But it’s also useful to be able to embed little domain-specific languages in Haskell or real programming languages. And we were exploring two different approaches. One of them is the so-called De Bruijn representation, where you don’t actually have names as such. You’re just referring to variables by counting back to the position in the term where it was bound. So the nearest one, you would give the number zero. And then if you go to the next binder, it would have the number one and so forth. And that’s appealing because you don’t actually have to pick an arbitrary string. It’s completely deterministic. 

*AL (0:04:34)*: You no longer have to rename?

*SL (0:04:36)*: Well –

*AL (0:04:37)*: Well, I mean, not in the same way. Like, you no longer have to do sort of the standard alpha conversion. There is a sort of canonical representation of every –

*SL (0:04:46)*: Right. But the catch is that you actually do have to rename. All the time, you have to shift all of your numbers. Whenever you say you introduce another binder, then you have to add one to all of the other ones.

*AL (0:04:58)*: Right.

*SL (0:04:59)*: And also, you’re programming with numbers instead of names, and humans are designed to do that. So, Conor McBride and Bob Atkey like to refer to De Bruijn syntax as a Cylon detector. If you are comfortable programming with De Bruijn indexes, then you’re –

*AL (0:05:20)*: That’s suspicious.

*SL (0:05:22)*: You’re probably not human. There are lots of other ways of encoding names, and another one that’s particularly convenient for embedding in a language like Haskell is higher-order abstract syntax. And this is very much in the spirit of shallow embeddings of domain-specific languages where you try to make use of as much as possible of your host language in your embedded language. So here you’re actually making use of the binding facilities of the host language.

*AL (0:05:50)*: So the idea of higher-order abstract syntax is to just use functions of the host language?

*SL (0:05:55)*: Yeah. I mean, technically, it isn’t. It comes from a more theoretical place, but in the context of using it for DSLs in practice, that’s what you want to do. So, yeah, you might say, “Well, why not just use HOAS?” And the problem with that is you’re actually using the binders in your language. How do you analyze them? Supposing I want to write a program that optimizes my embedded DSL, and it’s represented as HOAS –

*AL (0:06:21)*: Or even just chose, right? Like even just render.

*SL (0:06:25)*: Even just rendering it. Yeah. Then how do I do that? Because what am I representing my lambda as I represent it in my object language? I represent it as a function. All I can do is run that function. And there are ways of dealing with that. What do we call it? Parameterized HOAS is what this is sometimes called, where you get to abstract over a concrete expression constructor of a higher kind. And then by instantiating that, you can essentially implement a fold over the syntax. But still, that’s a little bit inconvenient for doing certain kinds of intentional optimization. So, the idea we had with our paper was we would define a translation from the HOAS representation into the De Bruijn representation, which is more convenient for doing these intentional transformations, and then hopefully get the best of both worlds. 

*MPG (0:07:22)*: Right. Did it work?

*SL (0:07:24)*: Yeah. I think it worked up to a point, and it’s a reasonable thing to do. So, Bob Atkey, who was a collaborator on that work, he did some other work where he proved that this correspondence is correct, but you actually need parametricity in order to prove that, which is not something that the type checker in Haskell has access to itself. It’s a property of the system. So, that means you actually end up having to use unsafeperformIO, unsafeCoerce, or something unsafe anyway. 

*MPG (0:07:57)*: Oh.

*AL (0:07:58)*: interesting.

*SL (0:07:59)*: But it’s correct. It won’t go wrong. 

*AL (0:08:01)*: Yeah, it’s interesting that sometimes you have these properties in Haskell which only holds because of external arguments. I always forget this, but there is something about the functor laws that you only have to prove one of them and the other one follows from parametricity or something like that.

*SL (0:08:19)*: Another example would be runST. You can provide a correct implementation of, but you can’t easily do that inside Haskell itself.

*AL (0:08:28)*: So, perhaps backtracking a little bit or going back to sort of the wider picture. So, you said after being exposed to functional programming or to Gofer for the first time, you first did something else for a while, and then later you returned to it. And you also worked in industry, but sort of the whole industry versus academia thing, like was there something specific that drew you in one direction or the other, and then how did you end up sort of staying in academia for good?

*SL (0:09:03)*: So, I guess, actually, I’ve been doing work for this company, Red Snapper, a web agency, while in my vacations, while I was an undergraduate. I fancied a break from the intense academic study I’d had. So it was kind of natural to do that full-time for a while. But then I sort of felt, ‘Ah, I’d really like to be able to do my own thing, do my own research. I want a bit more freedom.’ So, I thought, ‘Oh, I’ll apply to do a PhD.’ Yeah, that was where I moved on to next. I did realize it’s interesting how the culture around you affects your perception of programming languages, for instance. In the company I was working in, there was no opportunity to use functional programming languages. It just wasn’t the thing.

*AL (0:09:57)*: So, what programming languages were used there just out of curiosity?

*SL (0:10:00)*: C, C++ primarily. There were lots of little domain-specific languages we had to build.

*AL (0:10:08)*: Oh, okay.

*SL (0:10:09)*: So I don’t think they were called content management systems, but we built a content management system, one of the first ones. And it was only used sort of internally by this company. But actually, that was a lot of fun. And I can see my later work when I went back to academia and was doing research and working with Haskell. The same themes kind of crop up of, well, if you build any large system, you end up wanting to build some kind of domain-specific language at some point, and we had a whole load. It gets much nicer when you have the right tools to build them. Doing it in C++ is – there’s a lot more effort or certainly was a lot more effort then than doing it in Haskell.

*AL (0:10:49)*: So, at the time, did you already understand that that is the case and did you actually try to convince anyone, or was that whole insight only coming later in your life?

*SL (0:11:01)*: It didn’t even really cross my mind. There was no question at that point.

*AL (0:11:07)*: Yeah.

*SL (0:11:07)*: It was more like I’d been exposed to Gofer and there’s this – yeah, there’s this thing that’s a really pretty way of writing things. I’m not sure if it translates into practice. I’ve not seen it in practice in industry. I don’t know at what point other companies really started using Haskell and other functional languages in earnest.

*AL (0:11:29)*: Yeah. I mean, probably came somewhat later. I mean, Galois, I think was one of the first.

*SL (0:11:37)*: So, I kind of had this feeling that it was a bit of an esoteric thing, an academic thing that even if I wanted to, I wouldn’t be able to persuade my company to use it. 

*AL (0:11:52)*: Okay. So then you started doing a PhD. Where was that?

*SL (0:11:58)*: That was in Edinburgh.

*AL (0:12:00)*: And what was your topic?

*SL (0:12:01)*: My topic was normalization by evaluation in the compilation of typed functional programming languages. And yeah, I was primarily working with ML at that stage. And then the culture changed completely and everyone around me thought, ‘Well, yeah, of course, you do functional programming. Why would you do anything else?’ 

*MPG (0:12:25)*: Yes. Could you just briefly explain normalization by evaluation? I think I’ve seen this definition many times on many slides, but –

*SL (0:12:33)*: Yes. So, there are various different perspectives to it, but I think the way I came at it anyway, I’d been taught about things like lambda calculus, idealized versions of functional programming languages, and it’s normally presented in terms of rewrite rules. So, you have the beta rule, which just says that you can inline functions. If you have a, for instance, simply typed lambda calculus term, then we have a result that says that if you just repeatedly rewrite, then eventually you’ll stop and you’ll have no more. Redex is there are no more functions to inline. And that process is called normalization. 

What normalization by evaluation does is instead of applying rewriting, you define a denotational semantics for your term, or equivalently, you can view it as just an interpreter, but you define a special kind of semantics or interpreter that has just enough syntactic material in it that it’s actually possible to invert the interpreter. So, to map semantic values you get by running the interpreter back to terms. And then your normalization procedure is just, well, I run this program or this term, and then I run my reify function that reifies a value as a term. And that term will be a normal form. In general, it doesn’t have to be the same normal form you would get by doing the rewriting. But necessarily, if your algorithm is correct, it must at least be a canonical representative of the equivalence class of terms that all behave in the same way.

*MPG (0:14:30)*: Right. And you want to do this for equivalence checks, basically?

*SL (0:14:36)*: So, no, the idea we had for what I was going to do, which as it turned out didn’t really work for the particular case I was looking at, or it wasn’t really the right approach, was that because normalization by evaluation is reduction-free, well, maybe it’s going to be more efficient than just rewriting your term in the normal way. So, I was investigating how we could implement optimizations in the back end of a compiler using this technique. The problem I ran into is that the particular kind of optimizations I was looking at were very intentional. And normalization by evaluation works really well when your semantics is very compositional. And these very intentional optimizations don’t really make as much sense when written that way. 

Oh, I should say, yeah, coming back to Haskell, I did have a more recent Haskell paper with Nachi Valliappan and Alejandro Russo, where we used NBE, and this connects with the earlier paper we were talking about. We used NBE as a framework for embedding domain-specific languages. So, there are connections between all of the different things we’ve been talking about here. 

*AL (0:16:04)*: So, you’ve been talking a lot about domain-specific languages in various different aspects. So, that was a theme in your discussion of normalization by evaluation. That was also a theme in your discussion of the different ways of representing names and binders. Would you say that that is sort of the theme of your overall research or –

*SL (0:16:27)*: I would say it is a theme.

*AL (0:16:29)*: Okay.

*SL (0:16:30)*: But yes, I have a number of other themes, and yeah, I guess the thing I’m most known for nowadays is effect handlers. Although again, we could make connections between effect handlers and DSLs as well. In a sense, they give you a way of a fancy form of DSL for extending your system.

*AL (0:16:53)*: Yeah, but effects is an interesting area. I mean, it’s certainly very fashionable, and I think many people have very different angles of how and why they get interested in it. And perhaps you can tell us a little bit more about what made you interested in it and how you think it, in your opinion, connects specifically to Haskell.

*SL (0:17:16)*: Right. No. Okay. Maybe I’ll go back and tell you my story of how I particularly got into effects as such. So, this predates anything to do with effect handlers. It predates effect handlers being a thing, or at least being a named thing. So actually, another project which came after my PhD that I still work on intermittently was this programming language called Links, which Phil Wadler initiated, and this is a web programming language. Although that’s not really the most important aspect from my point of view or from our point of view. The point really was just to have a new research language that we could play around with and try out all kinds of new ideas with.

The key selling point of Links initially anyway was that you write your program in this one functional language, and then it runs on the server, the client, and the database, and it’s all the same language, and you avoid impedance mismatches where you have to convert between representations because it can run anywhere. 

*AL (0:18:21)*: And you then annotate what runs where or the runtime somehow figures that out on its own?

*SL (0:18:28)*: You annotate the functions. You can say they run on the server or the client, or you can leave them unannotated and then they’ll just run wherever –

*AL (0:18:35)*: Somewhere.

*SL (0:18:37)*: So, if you’re in a server function and you call a function that’s unannotated, then it will run on the server, and it would compile it twice for each. And then there’s a way of indicating that you want to query, but the query you write is just written using comprehensions similar to Haskell comprehensions. I’m very much inspired by that. And then there’s a type system there, which actually – so particularly focusing on the database. That was, I think – no, there were two effects we added. So here, like I said, we’re not talking about effect handlers or general user-defined effects, just some built-in effects. And what’s the purpose of this, the effect-type system? It’s to track whether a particular computation is pure or whether it performs some effect. And we started off with just one effect, which was called wild. A wild effect says that this code can only run in the programming language. It can’t run in a database. So, if you had general recursion or IO or printing something out or something that just makes no sense in a database, then it has the wild effect. But if you used something like map or pure higher-order functions that can be translated into a query, then that does not have the wild effect. That’s tame.

*AL (0:19:59)*: Okay.

*SL (0:20:00)*: We had this other restriction that says, “Well, if you have a query, then the overall query has flat relation type, and it can’t have any effects.” And then we guarantee that if you write your code in this way, again going back to normalization, you can normalize that bit of the program, and it will generate exactly one SQL query at runtime. But yeah, the effect type was a crucial part of this story.

*AL (0:20:30)*: And how did the distinction exactly work? Because I mean, like in Haskell, for example, everything is kind of pure, unless you specifically introduce IO. But if you’re saying general recursion is already too much, then –

*SL (0:20:44)*: Yeah, this is much purer than Haskell.

*AL (0:20:46)*: Yeah. You have to be more restrictive. So, you have to specifically enter the tame fragment and stay within it, or is it sort of wild by default or –

*SL (0:20:58)*: We marked various built-in functions like map and concat as being – when you define map, you normally define it using general recursion. You can define it with a fold or something, but we just mark some of those built-in functions and say, “Yeah, these are tame,” meaning that we know how to compile them to the database. And then apart from that, yeah, all you’re allowed to use is non-recursive functions. And you could also use nested data. So you could have lists of lists, and so forth, which are not things that a database could do. But because the final return type was flat, then it would guarantee that they would all get flattened and normalized away. 

Anyway, that was my starting point. And I realized, even though this was a very simple effect-type system, it only had one effect. It still has most of the complexities of a general one, because you really want to be polymorphic in your effects. And then it makes sense to think, ‘Well, we could add some more effects.’ And we did at the time. We also had an actor system, a bit like Erlang, but typed. And there was an effect where you could keep track of the current mailbox type of the current thread or process. I guess in doing that work, we did try out ideas and prototype things in Haskell as well at times. And we were asking questions like, “Well, is this construct a monad?” for instance. “Is it some other kind of computational notion like an arrow or an applicative functor?” And that was always a useful guide to these things. But I guess I don’t know if you want to move on to the effect handlers story now. 

*AL (0:22:50)*: No, I mean –

*SL (0:22:51)*: That’s a number of years later. But again, that came out of – no, actually, the original work I was doing on effect handlers was in Haskell. But that also moved back to Links at some point. So, how did this happen? So Matija Pretnar did his PhD thesis on effect handlers in Edinburgh, and I knew a little bit about it then but didn’t really properly get involved. But what happened, we had me, Ohad Kammar, who had worked with Gordon Plotkin, who also worked with effect handlers, and Nicolas Oury, who was my office mate. And Nicolas would get really enthusiastic about lots of different programming languages and programming languages features. At some point, he was like, “Oh yeah, this is really cool, effect handlers. We can do so much with this.” So, we started. We implemented various different libraries in different languages. And the Haskell one was the main one that kind of worked because it was rich enough to have the features we needed. 

*AL (0:24:02)*: So, how would you explain the fundamental idea then? I mean, is it just like adding more fine-grained effects, or is it more than that?

*SL (0:24:10)*: Well, there are lots of different directions to come from, but I’ll start by mentioning where Matija and Gordon introduced them from. So Gordon Plotkin and John Power for many years had been looking at this idea of algebraic effects. And they’d identified that many effects were used to – I mean, I guess in Haskell and other programming languages, the way people did effects was with monads if you wanted to be able to define your own new effects. But they wanted to come at it from a different angle. So, there’s still a connection between algebraic effects and monads, but they were focusing on the interface to your effect. So, say you have state. You might have a couple of operations, one for a get operation and a put operation, for reading and writing a state sum. And with algebraic effects, you specify the signature of those operations, and then you specify the equations that they should satisfy. So, things like, if I do two gets, then the second get will return the same value I read. So I only need to do one get, and I just do a substitution. Or if I do two puts, then I can ignore the first one, because the second one won’t override it. So that’s very pretty, I think. But it didn’t say anything about how you use this in practice or how you implement it. 

And actually, they sort of accidentally invented effect handlers because they realized that there were certain effects where they wanted to express some equations, which didn’t fit their theoretical framework. And the example they had was catch as in exception handling. And that was where they came up with the notion of an effect handler and realized, “Well, yeah, it doesn’t fit our framework of algebraic effects, but we can view this as a kind of implementation of the effect. It says how to catch an exception in that case.”

*AL (0:25:59)*: So then raising the exception is still sort of an effect?

*SL (0:26:03)*: Raise is their algebraic effect, and catch would be the handler for that effect. But in order to be able to define other effects that are not just exception handling, they needed to generalize somewhat. So, if you think of my state example, you can’t just throw away where you are. If I get, then I have to return a value to the point I was in the code. So, what you do is you have just a generalization of an exception handler that takes the continuation, the delimited continuation, as an argument. So then if you wanted to implement state, you just ran that continuation by passing the value back. But you can also do much more powerful things, which is where handlers really shine, like in particular, implementing concurrency. Once you’ve got that continuation, you could store it in some queue or something and then schedule to run it later, or you can run it more than once. 

So, yeah, you might ask, “Well, isn’t this the kind of thing we can already do with monads?” And the answer is absolutely. But the key difference from a programmer’s point of view is in the perspective. With a monad, you start off by defining a new effect by giving the implementation upfront. And then get and put are just sort of afterthoughts. Whereas when you’re programming with effect handlers, you start with the interface, and you can program to the interface, and you can actually then give several different implementations. But again, this might sound familiar if like – and we’ve known about this kind of thing for many years, actually. The MTL for monad transformers, if you actually look at the interface for that, that allows you to abstract over the interface in exactly this way.

*AL (0:28:02)*: Yeah, you have these MonadReader, MonadState, whatever classes, right?

*SL (0:28:06)*: In a certain sense, effect handlers aren’t really giving you anything different to what we already had there.

*AL (0:28:13)*: But the emphasis is different.

*SL (0:28:14)*: Right. There’s also a sort of deeper reason why you could argue they’re sort of more primitive. In order to implement that kind of interface with the MTL, you’re relying on having type classes, and you’re relying on – under the hood, you’re doing a sort of double negation transformation. You’re having to abstract over the implementations of all these things explicitly. With effect handlers, it’s all very kind of first order. And I’d argue it’s more convenient if you have something like effect handlers built in and an effect-type system built in. It would be nice if Haskell was able to do that just a little bit more cleanly than we have at the moment. Because yeah, I mean, when we did it – when was this? 2011 or so. Haskell was considerably more impoverished than it is now, but it was still pretty expressive. But lots of little annoyances in the way we did it. We built up type level lists because, yeah, the effect type is just keeping track of all of these operations and their signatures. I’d still say it’s not as ergonomic as it could be. I think what people have done more recently is much more usable than what we did at the time.

*AL (0:29:32)*: Yeah. I mean, there’s certainly been a lot of evolution in the effects libraries, and there are many different ones around these days with different degrees of ambition and different ways of how they represent things on the type level. But it’s good to sort of hear the original ideas, I guess, and the original motivation.

*SL (0:30:00)*: One cool thing that we did take advantage of, which also made our library a little bit less expressive than you might want, was that we encoded the effect types directly using type class constraints. We for free got a very efficient implementation because the rewriting that Haskell does is very aggressive. So, we got a whole load of fusion for free. And there was a subsequent paper that Nic Wu and Tom Schrijvers wrote that kind of explains what we were doing. 

*AL (0:30:37)*: Right. So, there’s this fused-effects library, I think, which probably is the culmination of that particular line of work. 

*SL (0:30:45)*: Yeah, that library also, though, is much richer. It deals with so-called scoped effects as well.

*AL (0:30:53)*: What is a scoped effect?

*SL (0:30:55)*: So, our library and all of the implementations do more or less deal with what scoped effects are. What they amount to is when you have one of these signatures, if it’s higher order, meaning that your operation itself takes a computation, which itself may perform effects. So for instance, if we’re doing concurrency, we might want to have a fork operation that takes the computation that is the new thread. Then that’s what they mean by a scoped effect. You get a new scope for this thread. And why is it problematic? The original theoretical study of effect handlers assumes that you’re simply not allowed to do that. And handlers are always actually – they amount to just folds over the computation tree. But if you’ve got more computation inside the nodes of your tree, then you need a more sophisticated form of fold.

*AL (0:31:54)*: Right.

*SL (0:31:55)*: And Nic Wu and others have done a whole load of work on these more generalized versions of folds, and that’s what scoped effects are based on. And I guess the nice thing about phrasing things that way is you then are able to guarantee that your handler uniformly handles all of the effects, even inside these higher-order operations. Whereas with our naive library and the naive ways of implementing this, if you wanted to recurse inside one of these operations, you have to recursively invoke your handler.

*AL (0:32:31)*: Would you say this is kind of the same problem that arises in Haskell with this – I actually forget the name, MonadCatchIO or MonadUnliftIO or whatever things were, where you –

*SL (0:32:45)*: Yes. It’s exactly the same problem.

*AL (0:32:47)*: Okay. Yeah. Which causes a lot of headaches, right? So, what is that? The theory has a clean solution for this, essentially?

*SL (0:33:00)*: The theory has a number of different solutions. I don’t know whether – would we say any of them are clean? I don’t know. A lot of them or some of them at least superficially seem very unclean because – so one way of dealing with it, which was one of the initial ones that I think they sketched, is you can actually – so again, imagine – what a handler is really doing is it’s a fold over this computation tree. So you’ve got your program that has these operations, which currently have no meaning. Essentially, it handles them all and that’s doing a fold. 

Now, if you imagine your tree is no longer just a flat tree, but it has sort of a hyper tree, it has trees inside itself, one idea you can use for just translating that into a regular handler is you sort of insert brackets, and then you essentially flatten this nested structure. So, yeah, I found that kind of ugly when I first saw it, although we actually had a paper very recently at ESOP where we put that on a more formal footing by characterizing those things as what are called parameterized algebraic theories, which is a generalization of algebraic theories. But yeah, there are other models as well, which I think are probably a bit cleaner. But I think this is a classic problem we have when we’re trying to transfer rich theoretical results into practice. Can you do it in such a way that it doesn’t make the programmer get lost or throw up or want to run away? The more complicated your system, the harder that is. I would say, I mean, Haskell to some extent suffers from this, or certainly the way some people like to use it when we’re having fun. 

*AL (0:34:57)*: So, if we step beyond Haskell for a bit, I mean, as you said, you’ve been doing research on effect handlers for a while and you’ve been using many different languages, but what is the language to try if one wants to see effects done beautifully?

*SL (0:35:12)*: That’s a really good question because I still don’t think we have a very good answer to that because it depends. If what you’re wanting to do is to implement high-performance, real-world concurrency, then probably use OCaml because it has a really efficient implementation. But it doesn’t have an effect-type system. And in fact, the way that it’s primarily used nowadays, the effect handlers in OCaml, is that you implement some feature using a library. And then the programmer doesn’t have to engage with the raw effects or handlers themselves. They just use the abstraction you’ve built. So, you implement lightweight threads or something, and then the programmer just uses lightweight threads, and it all behaves nicely. But if you want to do what I’d probably call more hardcore effect handler-oriented programming, then you really, really want an effect-type system because if you start composing handlers together, it gets really hard to track what’s going on if it doesn’t appear in the type system. And then there are various research languages that – I mean, Haskell is not a bad option, actually. Using one of the Haskell libraries is reasonable, but I think there are still ergonomic issues that mean it’s not quite –

*AL (0:36:30)*: Yeah, I mean, I get the tension between practicality and research. So, I mean, I was specifically asking about research languages, if people want to see sort of like the theory play out nicely. 

*SL (0:36:44)*: Koka is probably quite a good one to look at in that it’s reasonably well-engineered and robust, although it does have lots of little bugs in the type system. But it also has a relatively rich type system. There’s another one called Effekt, which Jonathan Brachthäuser does, which is very – that’s also very researchy. Links we have. I’m not sure I’d recommend it because I think there are some other flaws in the fundamentals of the way we built the effect-type system. 

The one in some ways I’m most fond of is this language, Frank, that I did with Conor McBride. It has a very quirky syntax and is basically not maintained and isn’t really usable. But the type system, I think, is very ergonomic. You don’t have to write – more or less, you almost never have to write effect variables, because this is one of the issues, is once you start composing your programs together, you need some sort of polymorphism over your effects. But it turns out, and if you just think about it, if I have a higher-order function, for instance, like map, I might have – you expect the function that you’re running and the result of running map to have the same effects. So you’d have an effect variable there that’s the same on both of those. But if you think about it, almost all of those kind of higher-order functions, it’s always going to be the same effects, because what do you do if you’re parsing a function and you run it? Which means that its effects must be compatible with your effects. So you can actually avoid writing most of those effects. And what Frank does is, under the hood, it does have effect polymorphism, but you don’t have to write it much of the time. So, that does actually have some disadvantages, which we’ve been working on fixing very recently. The disadvantages are it’s very syntactic, so it’s very fragile. The type system is not stable under substitution. And how does that manifest? It means that you get some weird error messages where suddenly effect variables appear that you didn’t write. 

But the right way to do this, which we haven’t implemented in a real language yet, I think, is based on a modal effect-type system, which is based on the same ideas that Frank has, but it’s done in a more semantic way. And then we’ve actually identified a small effect handler calculus that is simply typed but still has this very expressive way of composing effectful things together. It’s more or less the same expressive power as if you had effect polymorphism, but there’s not an implementation of that yet. So yeah, I don’t think I had a good answer for what’s the right language for you. 

*AL (0:39:42)*: Well, I mean, you’re trying to be fair. That’s fine. Like mentioning a couple of different ones. 

*SL (0:39:47)*: I’d say Haskell, Koka, and OCaml would probably be the – 

*AL (0:39:51)*: Is there some specific interaction between lazy evaluation and effects, or is it just – I mean, I noticed that most of these other languages that you mentioned from what I know about them are like assuming eager evaluation. But that like most languages in general are assuming eager evaluation. So I’m not sure whether this is like – 

*SL (0:40:12)*: No, there is a very relevant interaction. So, the problem Haskell has being lazy is if you’re going to do effects, you absolutely need a way of explicitly sequencing things because you don’t have an evaluation order, which is why we have do notation, why we have monads. So you need some additional noise in the form of do notation. And that’s a perfectly reasonable compromise if you’re going to start with a language with lazy evaluation. But if you have a language that has a fixed evaluation order, even being strict is not enough because –

*AL (0:40:50)*: You need strict about like left to right or something like that.

*SL (0:40:54)*: Well, OCaml initially said it was unspecified what order it was evaluated in. It would be strict, but you didn’t know whether it was left to right or right to left because they wanted a different implementation for the bytecode interpreter and the compiler. Now their implementations are aligned, but again, the official spec says it’s not fixed.

But anyway, if you have a fixed evaluation order, then you don’t need any special syntax at all. You essentially are just overloading the meaning of semicolon or left binding. So, that’s nice sort of ergonomically speaking if you have an effect-type system or some sort of type system to keep control of it. And in fact, Dan Lyons and other people had a piece of work a while ago where they were doing monads as in Haskell but in an ML-like language, exactly taking advantage of this ability to write in direct style without a different syntax. So, yeah, I think I would say that’s exactly the relationship between having effects and being lazy, but there’s no reason why you – if you’ve got a lazy language, of course, you can do all of these effectual things. You just need to make sure you have some syntax to make the distinction. 

There is another answer to your question, which I don’t think was what you were alluding to, which is that one couldn’t try expressing laziness itself as an effect.

*AL (0:42:14)*: Yeah, it wasn’t my primary motivation for asking the question, but I must admit I had already been asking myself that question as well during our conversation. So if you have something to say about this, that’s also appreciated.

*SL (0:42:28)*: So you can do that, but then you’re going to end up with some sort of explicit version of laziness, not like what you have in Haskell. The sort of –

*AL (0:42:36)*: Kind of like how you do this in some other languages anyway, I guess. 

*SL (0:42:41)*: Yeah, absolutely. But what’s cool about Haskell and also a big pain is the fact that laziness is completely implicit. So, it’s great because it means you don’t have to write all this boilerplate, and for free, you get these really nice, concise specifications, but it’s horrible when you’re trying to chase down resource leaks and so forth. And then you have to add strictness annotations all over the place. So, this is trade-off.

*MPG (0:43:07)*: Yeah, because I mean, there’s a lot of these effect systems out there. I mean, we mentioned a few, and it seems like we’re getting close to a good one, I want to say.

*SL (0:43:17)*: Yeah, I feel like that. I’m currently looking at, with my PhD student, Wenhao, the modal effect-type system I mentioned, and also this is in collaboration with people at Jane Street, Leo White and Stephen Dolan. I think that looks like a promising direction to me. But we’re never going to reach the end of the road because there are other things like scoped effects, and then you might also want richer forms of effects where you’re dependently typed effects.

*AL (0:43:50)*: So, you want to say something more about modal effects or modal types?

*SL (0:43:56)*: I could say a little bit more. So, I mean, I should also mention this comes out of this work that Leo and Stephen did, which we had a paper at ICFP on Oxidizing OCaml. The idea was – well, the observation was that you can actually control a whole load of additional aspects of your computation by adding modal types. And in that initial work, we were specifically – well, we had several modalities. There was one for locality, which tracks whether values escape. Why would you want to do that? It’s so that if you know that they don’t escape, you can allocate them on the stack. And that was something that was very important for Jane Street.

*AL (0:44:44)*: I’m sorry. Perhaps we should very briefly – I’m always a little bit unsure, but I mean, modal logic may be much less widely known to people, even like using type systems on a day-to-day basis and sort of ordinary logic. 

*SL (0:44:59)*: What is a mode and what is a modality? So, I don’t really know what the right answer to that is, because there are particular kinds of modal logics. So there are extensions to logics, but they also, through the propositions of types correspondence, map onto type theories. On one level, we can just view them as type constructors, but they might have a bit more structure than that. But that’s more or less what we’re saying is, “Oh, we add new type constructors, which you’re going to keep track of additional information about the terms.” Well, it might sound like, “Well, effects fall into that kind of category.” So, in this setting, we’re saying, given any value, we can give it a mode, as well as its type. And then we might have ways of boxing values to stick them inside one of these modes. And a modality is you can think of as a transformation between two different modes.

Anyway, in that original work, we did locality. We also did uniqueness typing and linearity, but I won’t say much more about that. So, Leo had observed that the same kind of infrastructure looked like it could be used for effects as well. So, with the modal effect typing, what we have is we have these two modalities, and they look very much like the syntax of Frank, which I admit I have not described yet. So, one of them is written inside a box, which also, if you’re familiar at all with modal logic, you have boxes and diamonds. There is some kind of connection, but it isn’t the same thing. But the ones we write inside square brackets or a box, you write something that looks like an effect type. And we call this one the absolute modality. And that ranges over the whole of the type inside that box. So, in particular, if you had a function, then that function would be allowed to perform those effects. If you had a function type, a value of that type would be allowed to perform those. But you can also actually apply it to other type constructors. So you could actually apply it to a pair, and that would say, “Both of the things in the pair are allowed to do those effects.” I mean, I’m not sure how far –

*AL (0:47:25)*: No, no, no, that’s fine. Yeah, as an introduction, we have to keep it introductory. 

*SL (0:47:30)*: But the absolute modality kind of – we have a notion of ambient effects, which is again a concept that comes from Conor and from Frank. That’s kind of the effects we can currently do. And with the absolute modality, you just completely throw away those effects. 

We have another kind of modality, which we call the relative modality, and we write that one in angle brackets. And that specifies the change to your effects. And that’s one that is important for defining effect handlers, because what is an effect handler from the point of view of types? It transforms a computation that can perform some effects into a different computation that can perform different effects. And, I mean, often it might be that it transforms it into a pure computation. So, what you really want to specify for a handler is the delta between those effects, and that’s what the relative modality does. 

But an important difference anyway with those modalities as compared with traditional effect-type systems—a traditional effect-type system, you write your effects just either on the function arrow or on the right-hand side of the arrow. They’re attached to arrows. They’re attached to doing. Here, in our system, it’s not like that. They just kind of propagate all the way through anything that’s inside that box, which is much closer to this idea I was trying to get across, that, well, if I’m defining any function, any higher-order function, where I would normally need effect polymorphism, well, what am I going to do with it? I’m going to apply it. So, it propagates the same effects all the way through. And yeah, I think it’s hard for me to just describe it abstractly like this and you to really appreciate how it pans out in practice. You need to see some examples. We have a draft on archive that you can look at.

*AL (0:49:27)*: Yeah. Perhaps we should come to an end, perhaps as a final question. What are your plans for the future? Do you have any particular research goals you want to reach, or do you have any languages you want to invent or – 

*SL (0:49:45)*: I have many goals. If I was to try and describe all of them, then it would take another hour. But I have many, even within the field of effect handlers. One thing I haven’t mentioned, I guess it’s not quite as much interest to the Haskell side of things, but another offshoot of this effect handler research is that we’ve been adding effect handlers to WebAssembly.

*AL (0:50:09)*: Oh, okay.

*SL (0:50:11)*: It’s quite a different use case. We’re really treating them as a target for source languages. So, lots of source languages have all kinds of control features. And the idea is we implement once and for all an efficient version of effect handles. You can just translate your async/await or your generators or whatever into effect handlers.

*AL (0:50:33)*: So, doesn’t WebAssembly have the stack typing system?

*SL (0:50:36)*: Yes, and we take advantage of the stack typing system in the design. So, I mean, we’re in the process of standardizing this. There are four phases we get that you go through, and we’re currently on phase two, but we should be going to phase three soon.

*AL (0:50:54)*: But this will actually get into WebAssembly?

*SL (0:50:56)*: This will get into WebAssembly, and it will be running on basically every device you have in your web browser.

*AL (0:51:02)*: Nice. Okay. 

*SL (0:51:03)*: And I think it’s a big deal. So, that’s pretty cool. But you don’t have effect-type systems and so forth at that very level. It’s a very weak type system. We’ll see what actually happens in the future. I mean, as these systems grow, gradually people want to add more and more fancy features. I’m not saying that Wasm is going to turn into Haskell, but maybe it will add some kind of features. At the other end of the spectrum in the effect handler space, I definitely would like to get to a stage where, when you ask me the question, “Well, what language should I play with,” we have one that I –

*AL (0:51:45)*: You can sort of like immediately, promptly mention.

*SL (0:51:49)*: Yes. But I imagine the most likely way we get there is that OCaml or Haskell has the missing features we need in order to make this more ergonomic. 

*MPG (0:52:04)*: Right. I guess that follows up to our classic last question. What changes would you like to see in Haskell?

*SL (0:52:11)*: Well, related to that, that’s something I have wanted for a long time, but I don’t know what the real answer is. I chaired a panel at ICFP 2013. I think it was on Haskell and effects. And we had people like Oleg and Simon Peyton Jones. Can’t remember who else was on the panel. And even then, I think people were agreeing, “Oh, it would be cool to have something that makes it easier to have nice effect-type systems.” So, this was something like row typing, but it’s unclear to me what exactly the right primitive is for Haskell. I mean, maybe more generally, what I really want, and I’ve wanted this for, I don’t know, 10, 20 years, is a nicer way of encoding unordered things at the level of types.

*AL (0:53:07)*: I was just going to suggest, actually, whether type level sets are just enough. 

*SL (0:53:13)*: Yeah, I mean, this also relates to deeper questions about, like, you sort of want something like quotient types ultimately, and I don’t think anyone in any system has really done those nicely in a way that people actually use. I mean, I think a lot of our systems, cross-functional programming are, they work really well for lists and trees and anything ordered. But as soon as you want anything unordered, then you have to make compromises.

*MPG (0:53:45)*: Yeah, you’re represented as something that’s ordered. 

*AL (0:53:49)*: Yeah, I guess like isn’t the underlying problem somehow that it’s sort of the reason why quotients are appealing also in mathematics in particular is because they abstract a lot of stuff, but the computational aspect of what you’re abstracting away is often very even deliberately ill defined, I mean. And the moment you have to reason about performance or scalability of something you’re writing, it becomes very difficult.

*SL (0:54:19)*: Right, but to some degree, that’s already in the spirit of Haskell.

*AL (0:54:23)*: Yeah. No, I’m not saying that makes it impossible, but it perhaps does give an explanation for why it’s hard and why it hasn’t been successful so far.

*SL (0:54:32)*: I mean, something like row type systems do work and they’re fine, but pretty much every row type system I see always seems a bit ad hoc. I don’t know. And there always seems to be something missing from it. It does the thing it’s designed for, but will it do the thing the more general thing I want to do tomorrow when I realize it’s not quite the right abstraction? That’s why ideally I’d like – yeah, I think you want something more fundamental.

*AL (0:55:02)*: But I often think also a little bit more ad hocness, for example, for these like type level features is perhaps call for, right? So, for example, built-in type level sets or something does not sound so strange to me, even though it’s a special case. But okay, people are complaining about all the lists, syntactic sugar, and Haskell as well, and that it takes away a lot of nice syntax, but would Haskell have been successful without it? I mean, I don’t know, right? I mean, you need a little bit of magic in order to start with, in order to appeal to people.

*SL (0:55:37)*: I haven’t said this yet, but my take on programming languages in general, my axiom of programming languages is that they’re all broken and they always will be, which might sound very depressing. But what I mean by that is not that – I mean, we can do really cool things with our programming languages, but there will always be things that we discover that we want to do and think, ‘Oh, it would’ve been better if it was designed that way.’ And it’s an evolutionary process, and I think that’s actually fine. And I agree with you that one aspect of that is probably it’s okay to add an ad hoc, a slightly ad hoc feature at some point because you have to experiment with it to see why it’s broken and how you would fix it.

*AL (0:56:26)*: Yeah. And also, it’s always a mix between sort of like theoretical elegance and pragmatic needs, and you have to sort of find the sweet spot. And in many ways, the successful systems are pragmatic sweet spots, even if you just look at Hindley-Milner type system or something like that, which was very successful.

*SL (0:56:46)*: Yeah, true. 

*AL (0:56:49)*: In your definition, broken, but nevertheless cool for what it does. And I think there are many examples of this.

*SL (0:56:58)*: Right. But additionally, I would say because of this, our languages get more and more and more and more bloated with additional things. And at some point, we have to start again, and we should do that every so often.

*AL (0:57:15)*: Yeah. Thank you very much for taking the time. 

*SL (0:57:18)*: Thanks. 

*MPG (0:57:19)*: Yeah. Thank you.

*Narrator (0:57:22)*: The Haskell Interlude Podcast is a project of the Haskell Foundation. It is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
