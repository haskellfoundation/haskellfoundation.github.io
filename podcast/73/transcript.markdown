*Samantha Frohlich (0:00:14)*: Hi, and welcome to this episode of the Haskell Interlude. My name is Sam.

*Farhad Mehta (0:00:20)*: And I’m Farhad.

*SF (0:00:22)*: Today, we’re joined by Jean-Philippe Bernardy, a senior lecturer at the University of Gothenburg and Chalmers University of Technology. We discuss letting types being your guide, getting into AI to feed yourself, and never testing your programs.

Hello, and welcome to the podcast. So, how did you get into Haskell?

*Jean-Philipe Bernardy (0:00:50)*: Well, actually, I was working at a company who was focused on compilers and let’s say what we would call today domain-specific languages, and we were using in-house tools. And what I was looking for is, well, a better language to replace some of these in-house tools. And well, this is how it started. So, in fact, what I did is to review a whole bunch of emerging languages, I would say. So this was back in 2002, I think, something like that. Well, it seemed that Haskell was the most promising option, and this is really how I got into learning it and eventually doing research with Haskell.

*SF (0:01:32)*: Nice. So, what company was that, and what were you looking for in particular? What qualities and what drew you towards Haskell specifically?

*JPB (0:01:40)*: Well, the company is, it used to be called Raincode. I don’t know if it still exists. I think it does. So it was, let’s say, a startup oriented around this idea of, well, providing services around programming languages. So, making compilers, but also just analyzing already existing codebases and producing useful reports, useful insights that our clients might need. And so what I was looking for, I would phrase it today as good generic programming facilities. So being able to manipulate syntax trees in generic ways. And this was the thing that was most important to me, and also a language that seemed to be built on solid foundations. Haskell seemed to fit the bill. And also, I was also looking for a language that seemed, well, alive. And it seemed that – well, at the time, Haskell was a bit – well, how to say? I would say a lot more academic than today, but I think what I saw is that it was promising.

*SF (0:02:49)*: Nice. It’s interesting that you learned it while you were sort of on the job in industry, sort of like the normal track, certainly nowadays, as people first encounter it in a university course. I was wondering what your experience was like learning Haskell, not in a course, but just on the job.

*JPB (0:03:07)*: This is very difficult to remember somehow.

*SF (0:03:11)*: You just picked it up.

*JPB (0:03:13)*: Yeah, more or less. I mean, it was by osmosis. I was reading – I think, yeah. I think I was reading sort of the tutorials that existed at the time. This Gentle Introduction to Haskell that maybe you have heard of. And from there, just trying my hand at some problems that we might have in this company, or maybe some things that seemed particularly difficult to do in Haskell, to see the limits. 

One of the first things I did was actually implementing a graph auto – well, a graph isomorphism algorithm. So you take a graph and – well, you take two graphs, then you want to check if they are isomorphic. And I think it’s the MacKay algorithm. So what I wanted to check is you could represent graphs and you could manipulate graphs in Haskell. And it went okay. So recently, I think someone else picked up this project. So it’s somehow the long-lived project.

*SF (0:04:16)*: What was it called?

*JPB (0:04:17)*: I think it’s just like Haskell automorphism graph library. I was going for descriptive. Let’s put it this way. 

*FM (0:04:23)*: So you mentioned that this was your first experience with Haskell, but in your university or before that, did you have any exposure to functional languages in general?

*JPB (0:04:32)*: No, I think the most that I was exposed to was principles, certain principles of Lisp. And that’s basically it. So no sort of experience, no hands-on experience.

*FM (0:04:47)*: Wow. Okay. Okay. And what was this company using before you decided to think, “Oh, would there be a better solution?”

*JPB (0:04:53)*: Well, they had their own built-in suite of tools. So at the heart, they had actually implemented their own object-oriented language. And that seemed maybe like a ridiculous idea, but it comes from a very long – well, it was made a very long time ago. Like we’re talking before Java was popular and things like that. So it was a sort of more static version of Java. Because they had made it themselves, then they could connect this to parser generators and things like this. So you would have a whole pipeline or parser generator, and then classes that could manipulate directly the output of the parser generator. Or maybe put differently, the parser generator was directly using classes that fit the syntax.

*SF (0:05:51)*: So, what happened next? Because you’re a researcher now. How did you go from this industry job where you discovered Haskell to there? Tell us about that path.

*JPB (0:06:00)*: So what actually happened is I was into learning Haskell, and I was reading, I had to – at the time, well, you had these tutorials, and then you start to read papers. For instance, these papers about generic programming in Haskell. And from there, well, I knew that this interested me more and more. And eventually, I applied for a PhD program at Chalmers, actually. So I was quite impressed by the output of John Hughes, for instance. And then I saw he was working there, and I thought, “Okay, I have the opportunity. I take it.”

*FM (0:06:40)*: Oh, very cool.

*SF (0:06:41)*: And you’ve done some – so John is quite known for working on QuickCheck and doing property-based testing in Haskell, but I saw that you also did some work in that area. Would you like to tell us about that?

*JPB (0:06:53)*: Ah, yes. So QuickCheck, the idea is it generates examples on which you’re going to test your properties. So if you work with Haskell, one of the things that is quite important is polymorphism. And why you do this is because you have fewer possible programs. So if you write your types correctly, then you have a higher chance of writing correct code. At the time, or I think you’d say, I’m not entirely sure what the situation is currently in QuickCheck, but when I looked at this, there was a mismatch. So if you start doing polymorphic programming, then what happens is QuickCheck is a bit stuck. It doesn’t know what to do. You don’t know how to generate a term of an abstract type that you have quantified over. What you can do is have it generate integers, for instance. This was the praxis at the time. 

So then all these benefits that you got from using polymorphism, well, you still have it in the form that I mentioned, that you have fewer programs, but QuickCheck doesn’t understand this. It just generates things that don’t make a whole lot of sense. And so what I thought is, okay, let’s try to take advantage of polymorphism in the term generation as well. And so it turns out that you can if you, in certain situations at least, generate just the things that you should generate to make sure that the polymorphic function works. So this has something to do with finding the initial algebra or the final algebra, depending on how you look at it, of the generators that the function can access to. So this is one very hand-wavy way to phrase this, but this is the general idea.

*SF (0:08:40)*: And what was that paper called? So people can go look at it.

*JPB (0:08:43)*: I think it’s just Testing Polymorphic Functions. I can double-check that.

*SF (0:08:47)*: I think it is.

*JPB (0:08:48)*: All right, thank you.

*SF (0:08:49)*: I did my homework this time. 

*JPB (0:08:51)*: You did. All right. Yeah. Well, great. So this is a rhetorical question.

*SF (0:08:57)*: Did that form part of your PhD?

*JPB (0:09:00)*: Yes. Yes, it did. Yes. That’s right.

*SF (0:09:03)*: Was there anything else that you did during your PhD at Chalmers?

*JPB (0:09:06)*: Yeah. So sort of the first building block, it got me into thinking more about the correctness of polymorphic functions in general. And so the standard, the good way to do it, is via something that’s called parametricity nowadays. When you have a polymorphic function, you know that there are only certain programs that are valid. And what you do is you capture this by, well, finding the logical relations that are associated with the type. And then from that, you get what’s called a free theorem. 

And so this is a Phil Wadler idea, or Phil Wadler made it popular, rather. The name “free theorem” comes from Phil Wadler. The idea doesn’t come from him. So these free theorems, it’s called “free” because you don’t have to look at the definition of the function. It only comes from the type. And so I started looking into this. And then what I did with my supervisor and Ross Patterson was to extend this idea of logical relations and the parametricity to a broader class of types. So, in particular, dependent types. So this was the main other part of my PhD, I would say.

*SF (0:10:28)*: Could you give us an example of what you mean by a function having limited definitions, like maybe a small function?

*JPB (0:10:36)*: Yeah. The smallest thing we can think of, and probably the only thing we can communicate orally – well, in fact, I can say some more. But imagine you have a function which is from type variable alpha to other – well, to same type variable alpha. So the input and the output is the same, and it’s quantified over. So it’s for arbitrary alpha, alpha to alpha. 

Well, the only thing that you can possibly do in Haskell is to have the identity function there. So this is the simplest kind of example. We can go on a little bit like this, saying, if you have forward alpha, pair of alpha to alpha, then well, you can either take the first component of the input or the second component of the input. And you can go on like this. And you may know that there is such a thing as Church encodings of data types. And when using these sort of free theorems, you can show that Church encodings do what they are supposed to do in general.

*SF (0:11:40)*: Nice. Thank you. That was a very nice description.

*FM (0:11:42)*: Question. So, the things that you did during your PhD thesis, are they available in the current version of QuickCheck, or do I need to use something else to get access to them?

*JPB (0:11:52)*: It’s a very good question. I sort of lost track with QuickCheck nowadays. So if you’re looking for hot takes, you know, what I say now is I never need to test my programs because it’s going to be either of two things. Either I know that I can make a mistake, and then what I’m going to do is I’m not going to test. I’m going to use types that are sufficiently polymorphic or sufficiently, how to say, precise so that I cannot make the mistakes. The other case is I’m confident in my abilities, and then I’m fine. I don’t need to test. 

So it requires, of course, it depends on me knowing where I can go wrong. But now I’m old enough that I think I know that. I don’t think it’s being arrogant on my part. It’s more like being realistic about my own ability. So it’s very rare. It does happen, I think, but very rarely, that I need to, that the testing by random enumeration is the right tool. 

The good thing about having more precise types is that, well, I’m completely sure about the correctness. If I go the testing route, then it’s much more complicated. I have to make sure that the enumeration is – well, the random sampling of examples is – how to say? Well, it’s a good distribution, and that’s sometimes more complicated than just other methods. 

I think testing is mostly useful when you really don’t know what you’re doing. And so you can start by writing some ideas, some tests, and then you can see, oh, it fails or it’s correct. And then you can build knowledge using tests. But I rarely do, I rarely work like this nowadays. I know clearly what I need to do. So I think testing in an industrial environment is good because, well, you are – this is typically the situation that you don’t really know what you have to do. You have to communicate with a lot of people, a lot of – well, you have to figure out what current code does, and random testing is good for that. But for me, I think, yeah, I just lost a bit of contact with that.

*FM (0:14:07)*: Okay. Got it. So you mentioned that nowadays, if you really are a little bit uncertain about your code, you make the types precise enough so that it just doesn’t type check. Are you talking about this in the context of Haskell or a language with more expressive type system, like Agda, for example?

*JPB (0:14:26)*: Well, I mean, Agda I use for proving and for method theory, but I really mean in the case of Haskell, really, this is where I do the bulk of my programming and the bulk of programming that I supervise.

*FM (0:14:43)*: And so the type system in Haskell is precise enough to do this for the applications that you have?

*JPB (0:14:49)*: Oh, yeah. Absolutely. Yes. 

*FM (0:14:51)*: Okay. Okay. 

*JPB (0:14:52)*: Maybe you want an example. 

*FM (0:14:54)*: Yeah.

*JPB (0:14:56)*: So, for instance, an example that I think that is clear is if you do matrix multiplication. Okay. So I’m sure you can do matrix multiplication. The standard one, you can do this with hands tied behind your back, so to speak. But for a certain application, I had to do a multiplication of sparse matrices. And then I know that if I implement that, I can make mistakes. I can – you know, so the sparse matrix is represented as a tree, and I can make a mistake, take the left subtree instead of taking the right subtree. And because there are a lot of cases, then I know I can make mistakes. But if I represent the dimension of the matrix statically using GADT, then essentially, there is no way I am going to make a mistake. I could forget the case, but I know I’m not going to forget the case because I see that I’m using all my inputs. So that’s fine.

*SF (0:15:53)*: So, would you say that you depend on dependent types? 

*JPB (0:15:56)*: That’s very cute. I never thought of it this way, but you know, I think so. Yeah. I think the direction we should think of going into as a community, a programming language community, because it’s really – so it is a formal method, but it’s a pay-as-you-go thing. So you can have a little property, maybe just using quantification, like I was talking about earlier, polymorphism. And then if you need a bit more properties, then you can, I don’t know, use GADT. And then if you see that you have a very complicated property that you want to be absolutely sure about, then you can bring out the heavy machinery and check in more detail. So I like that sort of approach.

*FM (0:16:51)*: Can I back up a little bit to your last answer? You said that your types in Haskell were sufficient for everything that you wanted to do till now. So this is a question I also had. So, what is the delta that you cannot do in the current type system with Haskell that you could do with a full dependently typed programming language?

*JPB (0:17:09)*: I mean, I don’t think that it’s necessarily, how to say, impossible, but it becomes a matter of convenience, I would say. It’s a little bit like – again, to tie in with the things we were talking about, you don’t really need data types. You can work with Church encodings, but after a while, it gets old. I think it’s of this sort of level.

*FM (0:17:32)*: Got it. Oh, okay. Okay. Oh, wow. Okay, that’s new information for me at least. Okay.

*SF (0:17:38)*: Speaking of letting the types guide us, I see you’ve done a lot of work on Linear Haskell. Could you tell us about that?

*JPB (0:17:44)*: Sure. Yes. If I have to be completely truthful, I wouldn’t be 100% sure what got me interested in linear types to begin with. But I can tell you what I think nowadays. So from a practical perspective, there is a lot of things in programming that are linear resources. That’s the thing that fits with linear types. 

And so maybe I should say, a linear type, what it guarantees is that what you get in is consumed exactly once. If we compare this with what I said earlier, if you have a function that says alpha to alpha, there is not really a difference between linear and regular. But if it’s a pair of alpha to alpha, well, I told you earlier that there are two possibilities non-linearly. But linearly, there is zero possibility because you cannot, from two alphas, get to one. I mean, there is one that is unaccounted for. So this is a perfect language to talk about programs that manipulate resources. 

And so, for instance, we can use this to control garbage collection. There is another property, which is, in functional languages, if you want to optimize them, or if you optimize programs, then typically you will use something like fusion. So fusion, it means getting rid of intermediate data structures. So let’s say you compose two functions, and then you have this thing in the middle. And you’re thinking, maybe naively, if I’m going to compose the functions, I shouldn’t build this intermediate data structure. I should directly feed the output of the first function to the input of the second, so we don’t need this thing in the middle. So there is something to say about laziness here, but I’m going to skip that for now. 

So this naive view, it works when you have linear types, because the thing that you produce, you’re going to use it exactly once in the second function. And so that’s fine. But in general, you may use it, well, zero times or an arbitrary number of times. And if you use it, let’s say a million times, then it would mean that you would have to essentially execute your first function a million times. 

So under fusion, in general, the runtime behavior of programs changes, and sometimes drastically. So one of the things that are difficult when programming in Haskell is to reason about the runtime, let’s say, behavior in general, but consumption of resources, including the CPU itself. So, well, my claim is linear types are very useful when you care about performance in general, not just resources that you may think of at first, like files or things like that, but also memory and CPU time. 

So this is why I think nowadays that linear types are important. And maybe there is a bit of a philosophical, theoretical reason, which is by default, the world is linear. You cannot copy things in the physical world. And so one of the advantages of computers is, well, you can copy information, but in reality, this doesn’t exist. This is the thing that consumes energy in the computer. It’s the copying of the data. And so if you want to have really efficient programs, then linear types, well, theoretically, is a very important tool.

*FM (0:21:22)*: Could you maybe tell us why these types are called linear types? What’s linear about not copying? Silly question, maybe.

*JPB (0:21:29)*: There is a notion of proportionality between what you get in and what you put out. This is why I would say it’s called linear.

*FM (0:21:35)*: So, are you saying that if I could have some sort of a linear type system in my functional programming language, that I could do without garbage collection?

*JPB (0:21:45)*: Well, yes. So by default, there is no memory allocation if you just have linear types. So one way to organize, at least theoretically, a programming language is to have, well, linear functions, let’s say. But if you just have that, then there is no way to really have data. Because sometimes when you do this composition I was talking about, then you really want to use the output with the intermediate value several times. And so what you introduce is something that historically and still is called an exponential. It’s called exponential for historical reasons, I would say, or well, for theoretical reasons that I don’t think we want to go into. But anyway, you introduce a special type construction which is specially made to allow saving arbitrary intermediate results. And I forgot where I was going with that. So, can you repeat the question?

*FM (0:22:40)*: Yeah. Do I need garbage collection?

*JPB (0:22:42)*: Oh, yeah. Right. So by default, you don’t. And then you have these exponentials. Garbage collection would be limited to those places where you have this use of exponentials. But you don’t have to use garbage collection. You could also say that this particular exponential, I would like to deal with it using reference counting. There is no problem with that. Or you can only just have reference counting. But reference counting is maybe not much better than garbage collection. So it depends on the program, maybe. But you can also have explicit reallocation.

*SF (0:23:20)*: So we now have linear Haskell. Is this something you are particularly excited about?

*JPB (0:23:25)*: Yeah. I mean, for the reasons I mentioned. So nowadays we have this type system extension. And what it allows is, well, to characterize resource properties of programs. So that’s very good. And I think in the future, maybe it allows Haskell to grow, maybe away from, let’s say, well, just the style which is used now, which is heavily reliant on garbage collection and things like that, to areas where efficiency or resource consumption is more critical.

*SF (0:24:01)*: Have you done any cool projects you’d like to tell us about using Linear Haskell, or do you have any ideas of something you want to do now that we have Linear Haskell?

*JPB (0:24:10)*: Yeah. Well, I mean, so what I did recently is a little bit on the – how to say? The application is mathematical. So it’s a bit of – how to say? On the fringe of programming. But it brings us to domain-specific languages. You may be aware of something called tensors, and that’s, in computer science, you think of a tensor mostly as a generalization of a matrix, I would say. So if an array is one-dimensional and the matrix is two-dimensional, then a tensor is arbitrary dimensional. Mathematically, what it is is a generalization of linear maps, and this type of structure is very heavily used in physics. For instance, well, any modern physics really is using this kind of language. But in particular, general relativity, this is where it became obviously important, I would say. 

There is a property of these linear maps that they must be combined linearly exactly in the sense that I was talking about. So you cannot take the output of a linear map and just duplicate it without – well, in general, you cannot do this. And so linear types, they are very natural underlying language, host language, to represent this kind of, let’s say, physically relevant descriptions. So yeah, I mean, I worked on making all that precise recently.

*SF (0:25:50)*: Another area that strikes me that linear types might be helpful is quantum, because in quantum, you can’t really be copying things or dropping things. Do you do any work in that area?

*JPB (0:26:02)*: So I mean, I think what should be said is the language of quantum theory, let me put it this way, relies on these tensor computations, right? So to put it simply, whenever you have a quantum gate, it is represented by a tensor. In theory, any quantum program is only going to be the combination of these gates. And so the meaning, the physical, theoretical meaning, is to do the composition of these tensors, and you can do that using the language of linear types. So you would represent – one way to do it is to represent a quantum gate as a linear function, and then by linear types, then the linearity property of tensors are enforced at the type system level. So yeah, definitely, it’s one of the applications.

*FM (0:26:54)*: You’ve done a lot of work on dependent types and on linear types. I mean, do you see any combination, or is this something that’s fundamentally not possible?

*JPB (0:27:03)*: No, it’s most definitely possible. Yeah. I mean, I would say that maybe 10 years ago, it was a bit, how to say, unclear how to combine the two, maybe 10, 15 years ago. But nowadays it’s becoming clear how both aspects can be combined. Computation is a bit like interaction or, well, let’s say, the program and the environment. And so that is naturally linear. The thing that’s a bit tricky is when you go to the level of types, then you don’t really have interaction. You more have hypothetical computations. At the level of programs, you have – I mean, it’s very natural to have linear types. And then you have to do a sort of temporary ignoring linearity when you go to the level of types corresponding to these hypothetical computations that may be going on. But the types are not one. I would say this is an overview of the situation.

*FM (0:28:05)*: Thanks.

*SF (0:28:05)*: So we’ve spoken a bit about your work on DSLs. Are there any other DSLs that you wanted to talk about?

*JPB (0:28:11)*: When you mentioned this topic in the lead, I think it’s more like the general idea, because essentially I’m making DSLs all the time. So whenever there is a problem that I want to approach, I think the mistake is to do, well, how am I going to solve this problem using my favorite programming language? What I’m trying to do instead is, what is the best language to express the things that I’m going to do to solve this problem? And then implement this domain-specific language using, for instance, Haskell. And it can be sometimes very lightweight, the gap. You’re just going to define an API. So an API can be a domain-specific language, and sometimes it can be something more heavyweight where you need to have, let’s say, a whole compiler. But because this has become so much part of my way of thinking, then it’s really difficult to point to any specific thing. Again, maybe trying to tie back to what we said earlier, this problem about matrix multiplications and similar operations, I’m thinking, well, I need a domain-specific language to represent these matrices. 

*FM (0:29:26)*: Taking a look at what you’ve done in the past, I was a bit surprised to see that you’ve also written vi clone or a vi-type editor in Haskell called Yi, right? A student of mine came up to me with this. Of course, I didn’t know that I was going to do a podcast with you, which she said, “Ah, she’s looking at how this can be done algebraically, so the grammar of vi can be modeled algebraically. And then she came up with this.” I was thinking, “Whoa, this is the same person.” So would you like to tell us a little bit about that, about your Yi editor?

*JPB (0:29:57)*: So I didn’t start this project. I think it was started by Don Stewart, maybe, or even his supervisor. Yeah, at some point, I tried to look at this. So again, it was one of these things that I took sort of as a way for assessing Haskell, because an editor is, at first glance, seem to be necessarily stateful. And so it doesn’t fit the functional programming paradigm very naturally. And so I thought, “Okay, let’s look into this and see what we can do.” I think I stopped working on it around, I don’t know, maybe 2010. But people rediscover or go back to it from time to time. 

So, the algebraic structure, I don’t know what I can tell you. So I think it has evolved quite a bit since. One of the ideas of the first implementation by Don Stewart, it was that the input sequence was going to be a parser that turns keystrokes into commands. This made it kind of difficult to configure because a parser is not necessarily obviously compositional. And so the thing that I was thinking of at the time was, how do I make this sort of thing compositional and useful in practice? And it was a bit hard work, I must say. But maybe your contact knows better than I do at the time.

*FM (0:31:25)*: Thanks, thanks. I also see that you did some work on Emacs support for Haskell. Is that correct? Dante?

*JPB (0:31:32)*: Yes. Right. This is cool, yes. I was kind of dissatisfied with the things that existed at the time. I thought there were too many moving parts. And so I wanted to make the simplest possible thing to connect to GHCi. And this was sort of a three-day project, and it’s still alive somehow.

At the time, this Haskell language server, it didn’t exist. And nowadays, I still don’t use the Haskell language server, because this little thing I made still works perfectly. I’m a little bit intimidated by making a whole instance of the Haskell language server, because the way I work is I supervise a number of projects, and then I have to go quickly between project to project. And yeah, it seemed to me that the language server is a big thing that has to be set up, and you stay into it. But maybe I’m wrong. 

*FM (0:32:31)*: So what type of projects do you supervise? Are they student projects or research projects? What’s your current work like?

*JPB (0:32:36)*: Yeah, I mean, nowadays I supervise student projects. I don’t supervise any research which involves Haskell anyway. One thing that I am pursuing via student contributions is – well, one way to state it is it’s a compiler for a minimal language with linear types. Another way to state it is it’s an intermediate language for functional programming languages, which uses linear types as its guiding principle. 

*FM (0:33:07)*: Oh, very interesting. Okay.

*JPB (0:33:08)*: So it’s linear types first. And then if you need these copy things, then you have to use the exponentials explicitly. 

*FM (0:33:15)*: Oh, okay. Nice. I also see that you have some things in the area of artificial intelligence. This surprised me a little bit because a lot of the people in at least our community are – the whole, at least the computer science is going crazy after this. Our community, not so much so, right? But there are still a few people who sort of do work in this area, and you’re one of them. So, do you want to tell us how you got into that, or is it something that you see as a connection between these two fields?

*JPB (0:33:43)*: I mean, how I got into it is kind of, you know, how life goes. You have to feed yourself, let’s say. So the connection that I have been trying to pursue with the collaborators is to think of these models a little bit in a more principled way. So recently, we had a paper on trying to imbue models with algebraic properties. So certain algebraic properties are built into the model so that they don’t have to learn it. These large language models, what they do is they process the input in an unstructured way. So they have to learn the power thing, so to speak. And one of the things that I was looking into is, can they actually do this in general? And my conclusion was no. 

One of the properties of context-free grammar is, well, by definition, that you have this recursion principle. In practice, people don’t write arbitrary levels. Maybe you stop it, I don’t know, at five levels or whatever. And maybe what seems to be the case, or in the experiments that I conducted with students, they couldn’t go to arbitrary depths. And maybe that’s what’s going on. So they appear to be working because in practice, in the wild, you’re not seeing arbitrarily nested structures. 

In this more recent work, well, what we do is we force the model to support this kind of structure. So the basis of these models, all the models that are linguistically oriented nowadays, they have the transformer as the basis. And by default, the transformer doesn’t know about any structure in the input. So all the tokens are equivalent. And when you think about it, it doesn’t make any sense, perhaps in your experience, because, well, the tokens come in the right order. So the thing is, what they do is they actually impose an external structure, an external sequential structure, on these tokens. The point is, if you’re going to impose an external structure, well, you might just as well impose a tree structure instead of just a sequential structure. And so this is what this recent paper did. 

*SF (0:35:54)*: I’m curious, was it sort of a speech-to-text kind of thing, or was it smaller things? If we’re imposing structure, I wonder what would happen if someone gave an ill-formed term. So you can really imagine if someone’s speaking that they might just speak colloquially. So I’m wondering what the domain was for this paper.

*JPB (0:36:11)*: Yeah. So the application is already well-formed terms in a formal language. So it was actually Agda types. So then there is not this problem. So what is actually happening is the parsing proceeds as normal. The resolution of identifiers proceeds as normal. And then all this structure is externally imposed into the input of the monad. It doesn’t work for speech. And also for natural languages, I think it’s not going to be a very fruitful application.

*SF (0:36:43)*: So just before you go, is there anything you would change about Haskell or anything that you would add?

*JPB (0:36:48)*: We discussed linear types before, and I already mentioned that something could be done with respect to runtime behavior there. The thing that I think is very quirky in Haskell is the class system. It’s both extremely useful because it allows you to not write a bunch of things. But at the same time, it really is a bit like a world that has gone out of proportion. So I think if I were to do it from scratch, so to speak, I think some sort of way to control the instance resolution in a more principled way would be useful. And I think maybe this is the thing that I would like to mention. There are all sorts of, how to call them, dark corners in GHC. But I think most people can live without awareness of those things. And so it’s better not to mention them.

*SF (0:37:45)*: All right. Thank you so much for joining us.

*JPB (0:37:47)*: Thanks for having me. It was a pleasure. 

*FM (0:37:49)*: Yeah, thank you.

*Narrator (0:37:55)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
