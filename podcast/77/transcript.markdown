*Mike Sperber (0:00:14)*: Hi, this is the Haskell interlude. Andres and I sat down with our friend Franz Thoma. Franz is a principal consultant at TNG Technology Consulting and an organizer of MuniHac. Franz sees functional programming and Haskell as a tool for thinking about software, even if the project is not written in Haskell. We had a far-reaching conversation about the differences between functional and object-oriented programming and their languages, software architecture, and Haskell adoption and industry. We got lots of insights into the nature and advantages of Haskell and hope you will too. 

So Franz, how did you get into Haskell?

*Franz Thoma (0:00:51)*: Well, I think the first time I heard about Haskell was somewhere at university. So in addition to physics, I also did a few semesters of computer science, and the functional language at the time was SML that we used. That was in Munich, at LMU in Munich. And it was mentioned that there is another functional language out there that’s a lot more feature-rich and also used more in the industry, maybe at that point in time.

Anyway, I didn’t really look into Haskell back then. And so I think really the first touching point I had with Haskell directly was when David Luposchainsky, aka Quchen, joined TNG, and he was assigned to my project. And he, at the time, already did work, did do a lot in the Haskell ecosystem. That was in 2014, I think. That was around Christmas. And I started reading Learn You a Haskell and started experimenting and playing around with Haskell. And yeah, soon, I think in the same year or the year after in 2015, I did the first — I went to ZuriHac for the first time and then also to Haskell eXchange. So it was kind of a steep learning curve. 

It was also kind of an interesting point in time for Haskell because a lot of changes in the ecosystem happened at the time, like the AMP and FRP, Applicative-Monad Proposal and Foldable-Traversable Proposal were implemented just before that. I think, yeah. And actually, my first year also working with Haskell, I also did my first and so far only contribution to GHC, the warnings for MonadFail, together with David. And yeah, also at that point or shortly before that, Stack was released. So yeah, there was a lot of development in the Haskell ecosystem at that time. 

*MS (0:03:15)*: So was there anything that you particularly did with Haskell?

*FT (0:03:18)*: On my kind of day job, I can’t use Haskell. So yeah, I did a lot of experimentation. I had some personal projects. One, for example, is vgrep, a pager for grep results that I wrote in Haskell, kind of as a toy project. I think there are two or three people that at some point actively used it, but I haven’t maintained it in several years. But yeah, so it was mainly personal projects. And also, I think at my first Haskell eXchange, there was a talk that kind of inspired me. One of the lightning talks, it was using Haskell as a thinking tool. That is something I’ve been doing a lot since then, basically to use Haskell for a first toy implementation or for just writing down the types. When I want to implement something, I start with some functions, some types in Haskell syntax and then translate it to whatever language I’m actually using. So I think Haskell, with its very concise syntax and with this kind of very type-oriented or types-first approach, is really useful as a thinking tool, which can be translated to anything you want after that.

*Andres Löh (0:05:00)*: Okay. So I think you said quite a number of things already, and I would like to investigate a couple of those things in a little bit more detail if possible. So the first thing is that you said your first contact with functional programming was SML at the university. Was that immediately convincing to you? Because I mean, for many students, I think it isn’t.

*FT (0:05:26)*: The concept of functional programming was definitely, that was very much convincing. My very first contact with programming was way before that. I think it was in primary school still. But up until that point, up until I learned of SML, I’d only really used imperative programming and the idea to have programs that are structured like mathematical functions, so you always have a result, you don’t have side effects. For me, that was very, very logical, but I hadn’t heard until then that it exists as a separate, dedicated concept as opposed to imperative programming. So for me, it was an enlightenment to suddenly find something that feels right.

*AL (0:06:28)*: But then I found it curious, and that’s also one of the reasons why I went back to this, is that you then said like one of the ways in which you’re using Haskell now is as a thinking tool when you’re programming in other languages. And that is very far away from my experience of how such languages are typically being taught at universities. So, how did your perception — perhaps I’m wrong, then you can correct me, but otherwise, how did your perception of functional programming and Haskell in particular evolve to get you to a place where you thought, “Yeah, I can use this as a thinking tool for programming in other languages”? So one of the problems that beginning Haskellers often struggle with is kind of the opposite. They say, “I want to write imperative program X, and I have no idea how to even express that in Haskell.”

*FT (0:07:18)*: I think, to me, functional programming really feels very natural. And yes, I agree that for a lot of people, it’s the opposite experience, that they think they find imperative programming kind of feels natural, and functional programming requires some kind of mind-bending or something. So for me, since I’ve learned about functional programming in university, I’ve usually also tried to follow the paradigm even when programming in other languages. So for me, it’s rather the other way around. Haskell is kind of a very concise syntax to follow the train of thought that I have anyway and then translate it to something else.

*MS (0:08:15)*: So you said earlier that you studied physics, right? So I mean, in my experience, the physics people tend to program particularly imperatively, right? I mean, for the longest time, physics was dominated by Fortran. I guess, nowadays, there’s some MATLAB and stuff like that going on. I mean, you must have been surrounded by these people. Do you have any explanation that even with the background and mathematical thinking, why you would be attracted to imperative programming, and what makes you different?

*FT (0:08:47)*: Well, actually, no, I wasn’t surrounded by these people. So I was in theoretical physics. And at the time, well, it was pen and paper, really. So solving integrals on paper, the most — yeah, what we had was Wolfram Alpha, but those simulations and all those Fortran things, that was mostly done in experimental physics. In my area, most people didn’t have any direct contact with programming.

*MS (0:09:30)*: So, what implementation of ML did you use back then?

*FT (0:09:33)*: I think it was SML New Jersey, but I don’t have much recollection of the language.

*AL (0:09:41)*: That’s what I started with as well.

*FT (0:09:44)*: Ah, okay.

*AL (0:09:45)*: Yeah.

*MS (0:09:46)*: So the two of you, didn’t you think that was kind of clunky?

*FT (0:09:49)*: I think I did. I think I did.

*AL (0:09:52)*: Compared to what?

*FT (0:09:53)*: Yeah.

*AL (0:09:55)*: I mean, this is the thing. I mean, like, at that time, I certainly didn’t think it was clunky, because I had nothing seen that was even remotely like it before, and I actually thought it’s wonderful. I think my first reaction to SML/NJ was wonderful. I think it wasn’t until much later that I thought that, for example, if you look at the interactive environment, if you look at the facilities that was given to you by tools such as Hugs originally for me, and later GHCi would go far beyond what you could easily do in the SML/NJ REPL or something like that. But I thought no. I think at the time when I first came into contact with SML/NJ, it was actually nicer than any other programming language environment I had seen at that time. So why do you think it’s clunky? 

*MS (0:10:54)*: Well, for the time, it was just a huge system, right, for the sort of memory that we had available at the time. And it was okay to do something at the REPL and to type little pieces of code in there, but in order to assemble larger programs, I mean, Standard ML has this very powerful module system, right, which is one of the advantages it has over Haskell. But it makes it much more complicated to make a built system. So I think it took the SML community a long time, until the mid-’80s, I think, even though Standard ML is much older, to figure out things like separate compilation for Standard ML.

*AL (0:11:33)*: But I would guess that perhaps if Franz’s and my only experience really with Standard ML was at the university level, that we never really got to the stage where we — 

*FT (0:11:45)*: Yeah.

*AL (0:11:46)*: — worried about build systems.

*FT (0:11:48)*: Yeah, we never got to that point. And to me, SML/NJ, I mean, it felt a bit clunky syntax-wise, if I remember correctly. But I don’t think we’ve really touched even the module system. So it was mainly working in the REPL and maybe writing source code files with 20 or 50 lines in university.

*MS (0:12:15)*: So, I mean, I’m one of the organizers of BOB, so I’ve had the pleasure of listening to a lot of Franz’s talks over the years. And you talk a lot about how you design things in functional languages. How did you acquire the knowledge? It’s always interesting to me, since a lot of knowledge and how to build functional programs is sort of folklore, and you’re one of the great sources of that, at least on video. So where did you get that knowledge yourself?

*FT (0:12:45)*: So as for the general knowledge part, of course, it’s part of my job to think about software architecture in general, to think about different styles or types of software architecture, the object-oriented part, the functional-leaning software architecture. I think that architecture and patterns depend a lot on the problem you want to solve. So people tend to think about the object-oriented versus functional paradigms as you use an object-oriented language or a functional language, but really, I think it depends on the problem. If you want to write a compiler, then you probably want to use a functional paradigm, whether your language is functional or not. In fact, in my very first project at TNG, I actually included writing a compiler, which is kind of a once-in-a-lifetime opportunity in that field. But in that example, we used Java as a programming language, but we used a lot of functional concepts to implement that compiler, because functional programming really helps in that problem domain. 

So yeah, part of my knowledge comes from thinking about architecture and learning architectural paradigms in my job. The other part, of course, is from, well, listening to a lot of talks in my free time, experimenting, following blogs, et cetera, and synthesizing what I know from my experience in the industry and from resources from within the Haskell community.

*MS (0:14:52)*: So you mentioned that writing a compiler, it sort of requires a functional approach of thinking about the project. 

*FT (0:14:58)*: I wouldn’t say it requires, but it’s very useful. 

*MS (0:15:02)*: Okay. So can you contrast a little bit what the differences would be between a functional compiler and an object-oriented compiler? So I think we all take it as a given that we know what functional programming and what object-oriented programming is, but in my experience, different people have very different perceptions of these things that are rarely made explicit. So maybe you could talk a little bit about what that would be specifically, those differences between OOP and FP.

*FT (0:15:27)*: I mean, when you build a compiler, most of the — you have the compiler pipeline, right? You have the parsing, the lexing and parsing step, then you build an abstract syntax tree, you do some transformations on that abstract syntax tree, and then you have the backend where you generate the code. And the biggest part of that compiler that we wrote, and probably of any compiler or of any non-trivial compiler, is the syntax tree transformations. 

And how do you make sure that a transformation is valid in the sense that it has a defined input state and, after the transformation, leaves the syntax tree in a valid state? The object-oriented approach would be, you have a syntax tree that’s a mutable object, and then you start messing around with it. So, you change nodes, you replace one node with another, you modify the mutable state. Whereas a functional compiler would take the abstract syntax tree as an input, do some transformation, and output the new syntax tree. And to do that locally is a lot easier in a functional style, because you know that if this local, this leaf, or this subtree of the syntax tree is valid, and the node is in a place where it’s valid, then the entire tree is valid, if I’ve checked that for every node. Whereas in a mutable tree, you can have references all over the place. So you exchange one reference and change a leaf in that subtree, you might have changed something else somewhere else. So, to reason about the syntax tree is a lot easier when you follow a functional paradigm. And you don’t need a functional language for that. You just need to have an approach where a change, every transformation of the syntax tree, is putting — is handing — sorry?

*AL (0:17:42)*: It’s a function. 

*FT (0:17:43)*: It’s a function. Yes. You’re right. Yeah. You hand a subtree to a function, and it returns something to replace that subtree with. That is a lot easier to reason about than modifying the syntax tree in some non-local way. 

*AL (0:18:01)*: Yeah, because you’re always having these mixed states, I guess, right? Where you have a syntax tree, which is neither the original version nor the final version, and you don’t really know what it is. And if you want to make that precise in any way, it’s actually really difficult, and you end up with probably rather complicated invariants, I would imagine.

*FT (0:18:21)*: And then you want to speed up your compiler, and you want to parallelize things. And if you have mutable objects, then everything breaks. Whereas in a functional language, you can just modify subtrees in parallel, and parallel function calls don’t interfere with each other. So that also makes things a lot easier.

*AL (0:18:43)*: I mean, you said, and I find that easy to believe, right? I mean, personally, that if you want to write a compiler, then a functional language is what you really want. But the way you said it, that sort of architecture depends on the problem, I would obviously be curious, what is the problem where you would not want a functional language? Or do they not exist?

*FT (0:19:11)*: Yeah, yeah. No, no. I have to think about it. So I think database systems, for example, map very well to the object-oriented approach. I mean, they are a storage of mutable data. So if you have a service that mainly is responsible for storing, retrieving data and maybe doing a bit of transformations on that data, but the main thing you’re managing is mutable state, then I think that maps a lot better in the object-oriented domain.

*MS (0:19:50)*: On the other hand, a modern SQL database system is largely a compiler as is.

*FT (0:19:56)*: Yeah.

*MS (0:19:56)*: I mean, almost any software architecture can be turned into a compiler.

*FT (0:19:59)*: Yeah.

*AL (0:20:00)*: That’s my classical argument, right? I mean, when you take a sufficiently liberal viewpoint on what a compiler is, then everything is a compiler. So I mean, basically, slightly provocatively spoken, software is mostly concerned with translating stuff into each other, and that’s essentially what compilers are doing. 

*FT (0:20:24)*: Although you can overdo that approach, and then suddenly you have some kind of stringly-typed domain-specific language that generalizes over something it doesn’t need to generalize over. So I’ve seen that as well. I think that approach kind of also has its risks.

*AL (0:20:45)*: Hmm. Interesting. I mean, I don’t really see how you get from viewing things as a compiler to stringly-typed, but —

*FT (0:20:54)*: No, I’m not saying it’s a logical implication. It’s a realistic outcome. It’s something that people tend to do if they don’t know how to write a compiler properly but think that they need a compiler. That’s what I’m saying.

*MS (0:21:16)*: I agree. I mean, I sometimes teach classes on domain-specific languages, and the people that come and participate in the training are usually people who already have a shitty DSL on their project that’s making trouble for them. That was not done very well. But I want to get back. I mean, now that I’ve got the two of you here, who’ve both contributed to GHC, and you just characterized what a compiler should look like, is GHC, is it really that pure compositional functions that are super easy to parallelize?

*FT (0:21:45)*: I think GHC deals a lot more with mutable state than I would have thought of a functional compiler, if I remember correctly.

*MS (0:21:57)*: Of course, that was a trick question. Of course, that is the case.

*FT (0:22:00)*: Yeah, yeah, yeah.

*MS (0:22:02)*: It’s not even deterministic. But do you have any explanation on why that is? When the pressure was on for the GHC authors, they’re all heavily invested in functional programming. They resort to mutable state anyways. Is there a good explanation for that? I’m not sure it turns GHC into an object-oriented architecture, but certainly it’s not a purely functional one. 

*AL (0:22:23)*: No, I think that would be doing GHC injustice. I think, up to a certain extent, you can be disappointed that GHC is not embracing functional programming even stronger or more strongly than it does, but it also doesn’t do the complete opposite. I mean, my speculation is that for a long time, I think it’s probably fair to say that GHC was the largest Haskell program that existed. So basically, while there may have been other functional language compilers before, most of those functional languages were, let’s say, less pure and more imperative in nature in the first place than Haskell. So basically, everything you could draw inspiration from for architecting compilers at the time, I think, was either compilers that are written in imperative languages or compilers that are perhaps written in functional languages, but functional languages that embrace mutation up to a degree. And perhaps that was just the pragmatic thing to do if you wanted to get things done. 

And I think probably neither of the three of us on this call are actually the right people to speculate about the question about why GHC looks like it does. I’m not so surprised, right? It goes back to this architecture question in a way. It’s very fascinating because, like Franz says, well, if you’re writing a compiler, then functions are obviously the right thing to use. And it is indeed a little bit ironic that if you look at the compilers such as GHC, it is using a lot of mutable states, but it is still classified into phases, and it is still satisfying this idea that you have a clearly defined abstract syntax tree, and you’re doing traversals on that abstract syntax tree, and they’re producing results. And while there is a little bit of state on the side, I think what most people would see in an object-oriented language is probably much more extreme.

*FT (0:24:38)*: I think nowadays we take functional purity and our knowledge about what functional purity is, where it’s useful, where you shouldn’t use it. We kind of take that as a given, but we shouldn’t forget that a lot of that knowledge comes from Haskell because that language exists, because people started experimenting with it, started gathering knowledge. And GHC is, well, it started at the very beginning of Haskell itself. So nowadays, maybe we would write GHC differently if we started from scratch with 25 — no, 35 years of knowledge. But at the time when Haskell was started, that knowledge simply didn’t exist because Haskell didn’t exist yet.

*MS (0:25:36)*: Yeah, I think that’s a very good point. I mean, I mainly wanted to figure out. I mean, you mentioned the pressures or the requirements that might exist in a software project that might push it in one direction or another.

*FT (0:25:49)*: Maybe to come back to the “for what kind of systems is object-oriented programming the right choice,” I think object-oriented programming did prove useful for large monolithic applications. And that kind of was the standard way to go in, well, up until something like 10 years ago, or five to 10 years ago, something like that, because object-oriented programming allows you to structure programs on large scales pretty well. So you can decouple things pretty well. But we’ve nowadays found other ways to have more independent components. So I think nowadays, these kind of large-scale monoliths are also not that relevant anymore, or it’s nowadays rather considered an anti-pattern. And so one of the big reasons for why you should use object-oriented programming in the first place kind of has gone out of fashion.

*MS (0:27:07)*: So you mentioned earlier that the concept of functional programming is independent of the programming language that you use, and that you use Java on that compiler project you mentioned earlier. Yet you’re here on the Haskell podcast, and you still feel that doing things in a functional language is worthwhile. Can you say a little bit about the ability to do functional programming in languages like Java, and maybe the things that don’t work so well there yet, and why do you use Haskell still?

*FT (0:27:36)*: Not sure I understand the question. What are you aiming for?

*MS (0:27:40)*: So let’s split it up a little bit, right?

*FT (0:27:43)*: Okay.

*MS (0:27:46)*: I mean, you could just go and write functional programs in Java, right?

*FT (0:27:50)*: Yeah.

*MS (0:27:50)*: Yet you’re still interested in Haskell. Why would you still be interested in Haskell —

*FT (0:27:55)*: Ah, okay. Yeah.

*MS (0:27:56)*: — even though you can write functional programs in Java as well? Let’s start with that.

*FT (0:27:59)*: I mean, it comes down to expressiveness in the end. How much support does a programming language give you in expressing what you want to express? And that has two components. One is letting me write down the things that I want to write down and not get in the way, and the other thing is giving me the safety to avoid stupid mistakes. And now we can classify different programming languages on these dimensions. So, for example, take a language like JavaScript or Python. Those don’t have compile-time types. So at the point where you write the code, you have a lot of freedom to express yourself, but you also don’t have a lot of safety features. If something goes wrong, it goes wrong during runtime. 

Then you have languages like Java, which do have a static type system. So they prevent you from making stupid mistakes during compile time already. However, the type system is very restrictive. So you’re also missing a lot of freedom to express yourself. For example, you don’t have higher-kinded types. The combination of generics and subtyping gives you variance problems, et cetera. So there’s also kind of a lot of things you know that are correct you could do in the language, but the type system prevents you from doing it. And also, Java comes with mutability, so also there’s still a lot of foot guns, still a lot of ways how you can shoot yourself in the foot, not on the level of type errors, but on the level of state errors. 

And then you have languages like Haskell, which have a very expressive type system. “Expressive” means you have a lot of freedom to express yourself. You can write the programs that you want to write. You also have very good guardrails, so it prevents you from making stupid mistakes, and it’s functionally pure. So it also prevents you from making errors with mutable state. So in that area, Haskell kind of combines the flexibility and expressiveness you want to have with the static type safety. And I think in terms of mainstream languages, there are not many, or let’s say, commonly used languages in the industry. There are not many languages that reach this point in expressiveness versus safety. 

*MS (0:31:04)*: You mentioned the lack of higher-kinded types in Java. Can you briefly explain what that is and why it’s a loss to not have it in Java?

*FT (0:31:13)*: Yeah. I mean, it comes down to what can you abstract over. So, for example, if you have a list, then you want to abstract over the item type, right? So you want to have a list of strings, a list of ints, a list of customers, whatever. And you do that usually by using something that’s either called generics if you come from the object-oriented background or parametric types if you come from the functional background. But they’re the same thing conceptually. But we can move one level higher and also parameterize concepts, like, for example, things you can map over. So you have lists, and you can map over that list to apply a function to every element. You have maybes where you can map over. You have futures that you can map over. So if you want to abstract this concept as well, you would need something kind of like a mappable interface or, well, in Haskell, it’s called a functor. And in order to abstract over that, you basically have to abstract over a parameterized type. And that is something you can easily do in Haskell. The functor type class is a type that takes a type parameter, but you can’t do that in Java. Java doesn’t allow you to define a mappable interface that takes a type parameter, which in turn takes another type parameter.

*MS (0:32:45)*: Yeah. And that’s why in Java, you have multiple classes or interfaces that have map methods in them. 

*FT (0:32:51)*: Exactly. 

*MS (0:32:51)*: But you can’t abstract out that map method.

*FT (0:32:53)*: Yeah. You have you have lists with a map, you have streams, you have futures, and all of them define their own map. Sometimes it’s called transform, sometimes it’s called — I don’t know. Basically, they’re conceptually the same, but you can’t abstract over them. You can’t write utilities that generically use map. And to a certain degree, you have to adapt to a new interface every time you’re using a new mappable type because implementers might have slightly differently implemented it because they follow different naming conventions, et cetera.

*AL (0:33:42)*: I think this is one of them, like, this last point is what I personally always find. One of the most important aspects is you have to then make the investment to always make sure that the things are actually uniform. Of course, you can try to identify the concept nevertheless, right? Even though you cannot explicitly abstract over it. But it costs a lot of effort to actually make sure that everything is named uniformly and behaves uniformly. And more often than not, it doesn’t quite. There are subtle differences. And then something which ought to be easy to understand becomes actually harder to understand —

*FT (0:34:28)*: Yeah.

*AL (0:34:28)*: — which is why it’s surprising me so often that people are opposed to abstraction, right?

*FT (0:34:37)*: When you come from an object-oriented background, then abstraction is a very different beast than in the functional world. So, abstract in the object-oriented sense usually means that you have some kind of supertype that’s usually opaque. And often, that is a bad abstraction, because basically, you want to have common code. You don’t really have an inheritance relationship; you just want to share code between different classes. And yeah, that usually is not a very good abstraction, and it makes programs more complicated, usually. So, people tend to avoid it. Whereas, I think, Andres, you said that, and I kind of got that idea or that expression from your talk at Bob Konf. Parametric types make for good abstractions, and subtyping makes for bad abstractions.

*AL (0:35:34)*: Yeah, I was just —

*FT (0:35:36)*: You are talking about ad hoc polymorphism, right? But yeah.

*AL (0:35:39)*: But in Haskell. But I think, yeah, that’s my point about it, like something in Haskell. But I was just about to ask you whether you think we can make that even more precise across languages. I think, is it — I mean, yeah, I think indeed, I believe that in Haskell, parametric polymorphism is a good abstraction because everything is uniform, right? You see a type signature, you just instantiate it to several different types, and there are no surprises, right? Whereas at its extreme, ad hoc polymorphism says, “Okay, I have different things that potentially look the same on the surface, but they can behave completely differently.” And as long as I’m not additionally trying to establish some kind of discipline, which in the Haskell world is typically done by establishing laws, right, for the type classes that nevertheless relate different instances to each other, then it’s really just some surface similarity that doesn’t help you at all, right? Is that what you would say is the same problem with sort of abstraction, how it’s being used in object-oriented languages? That there are no laws, or that there is nothing that relates to particular instantiations? Is that what’s giving abstraction the bad reputation?

*FT (0:37:03)*: Yeah, I think that’s exactly the point. Yeah. That you mainly use abstraction in order to eliminate shared code or to eliminate code duplication. And you don’t think about whether this abstraction is actually useful, in the sense that you really have common behavior. I mean, let’s take list. A list is generic in the sense that you have a list structure and you have the elements of that list. Those two are completely independent from each other. The list is completely generic and doesn’t care about its elements. So this is a good abstraction. And yeah, same for mapping over things. The map doesn’t care about what it operates on, whether it operates on one element or on multiple elements, whether it operates on a stream that’s infinite or finite, or a list that’s in memory, or a future that hasn’t been evaluated yet. The map itself doesn’t care about it. Whereas, when you have — I mean, my standard example is a car, a generic car that can be an electric car or an internal combustion car. Yes, you can use “car” as a generic abstraction, but you still have to worry about the details. So it does make a difference whether you drive an electric car or a gas-powered car. So the abstraction works for a few things, like does it move or does it have a steering wheel, but then the abstraction breaks down as soon as you want to refuel or charge your car. 

*AL (0:38:51)*: So what you’re now saying makes me wonder whether this has also something to do with open versus closed data types, because I mean, if you take the car example, it sounds almost like you have an abstract concept that you kind of explore by defining instances. You say, like, “Oh, now I suddenly discover an electric car can also be a car, even though 20 years ago I might not have thought so.” Right? But you’re basically really adding something new, and thereby you’re expanding what it even means to be a car. Whereas if you take more of the Haskell world viewpoint, you say upfront, like, “We have these three alternatives, and that’s it. There’s never going to be anything more.” At least that’s our preferred viewpoint. I mean, that’s not always true in reality either. But I mean, that’s what we would like to think. And therefore, we can kind of know the concept. Does that make sense? 

*FT (0:39:49)*: Yeah, yeah. And actually, yes, that is also one point, let’s say, on the code level, where object-oriented programming has its advantages. If you have an open system, an open type, you want to be able to easily add more instances, then object orientation gives you a tool for that with subtyping. Whereas in Haskell, you really would have to find some pattern to implement that to make your data type extensible, to add more constructors to your data type, even if it’s already defined.

*AL (0:40:35)*: I would like to circle back a little bit towards how we started when you said, okay, at your current job, you cannot really, in general, use functional languages, but you can potentially use functional concepts and other programming languages, and you can possibly use Haskell or functional programming as a thinking tool. But in how far is that opinion mainstream or also still exotic? So it’s like, is it uncontroversial among your colleagues and among your clients that implementing things in an imperative language but in a functional style is good? Or is that also still a battle? And if the latter, then why, or how can we spread that message?

*FT (0:41:28)*: I think things shifted a lot over the past 10 years. So when I gave my first talks about Haskell, you had to explain what a lambda is, right? So you had to explain that it’s an anonymous function and how functions even can be values, and what higher-order functions are, and that you can pass a function to another function. That was kind of — you had a lot of explaining to do. And if you wanted to include functional patterns in an existing Java code base, then you had to fight against resistance from all sorts of people that said, “Well, that’s not idiomatic Java.” And I think that has shifted a lot. So nowadays, people are very, very used to what a lambda is. You don’t have to explain that anymore. So that’s my experience with colleagues, with clients. I think that has become kind of mainstream knowledge. And I think one pivoting point was probably Java 8 finally embracing that you maybe want to have something like a lambda, and you maybe want to properly implement optionals and streams, and so on. So Google, with the Guava library, has been kind of spearheading that for some time. And basically, Java got to the point where they couldn’t refuse to embrace that anymore. 

But also, when you look at languages that emerged in the last years or over the last decade, for example, TypeScript, TypeScript is a multi-paradigm language that lets you write object-oriented programs. It kind of has all the classes and subtyping, et cetera, stuff, but also you can completely forgo that, navigate around it, and write completely functional programs in TypeScript. And I think these things have kind of become the catalyst for a lot of people to not take object-oriented programming as the God-given standard way of programming but also to think about what is the paradigm that fits the problem that I have and what is the best solution approach to my problem. 

So when I started using Haskell, I kind of became an advocate for functional programming. And at the time, people said, “Well, yes, that’s some exotic stuff. But I’ll listen to you. But then I’ll do my OOP stuff.” Now, it’s more like I’m still an advocate for functional programming, but nowadays, people say, “Yeah, I know that already. What are you telling me?”

*AL (0:44:24)*: So is the perception, you would say, that this evolution, let’s say, of classical imperative and object-oriented languages to adopt functional features and to allow some sort of hybrid style of programming, that this is at an end, that the current state of affairs is more or less the optimum they want to get to, or is it an ongoing transformation that will at some point make these languages even more functional, or — I don’t know. 

*FT (0:45:01)*: I think it’s still a work in progress. For example, if you look at frameworks like React, React used to have, or I think still has, an object-oriented and a functional API. So you can either define components as objects or as classes, or you can define them as functions. But these days, it is pretty clear that class components are deprecated, at least de facto. I haven’t seen a React project that uses class components for a long time. The standard is definitely nowadays functional components. But yeah, I think that shift is still ongoing, and you also see new frameworks emerging in the TypeScript world that rather embrace an object-oriented pattern or object-oriented approach. Right now, I think the situation is kind of people are aware that both styles, both paradigms, exist. They experiment with both and, yeah, cherry-pick whatever works best for them, sometimes with a strategic approach, like looking at the problem, picking the right paradigm, sometimes also rather with an experimental approach, “Let’s try this. Let’s try this new framework and see how that works out.”

*MS (0:46:31)*: Yeah, with React, I think the funny thing is that the class components that existed were more purely functional than what is today called the functional component. So I think with UI toolkits, I think you’re exactly right. We’ve seen kind of a backlash from the functional ideas that were in early React.

*FT (0:46:48)*: Yeah, I think React is also a good example for people using functional programming almost inadvertently, because in React, technically, you can use global state. It just won’t work, or it would break in weird and mysterious ways. So you kind of are forced to do things the functional way. Even if the language doesn’t force you, the framework kind of de facto forces you. And I think React has done a lot for people accepting the idea of functional purity simply because the framework forces you to do it rather than just encouraging you. They don’t advertise it as a best practice. They just say it won’t work if you do it the wrong way.

*AL (0:47:45)*: I mean, that seems to be like a general problem I see with this. I mean, with this general approach of allowing everything, right? I mean, frameworks can perhaps impose their discipline up to an extent. But many of the things that I personally find truly liberating about using Haskell are coming from the things that you know you can’t do.

*FT (0:48:10)*: Yeah. Yeah.

*AL (0:48:10)*: And if you’re simply creating a language where you say anything goes and pick what you like, you never have that because you always have to be worried. And that’s something which is relatively hard to reproduce incrementally if you’re not adding that to a language from the outset. But it seems like while you’re saying on the one hand, we functional programmers are perhaps more successful than we realize, it also is still basically hopeless to actually — well, “hopeless” is perhaps too strong yet again, but at least extremely difficult to convince larger-scale projects to actually try functional programming.

*FT (0:48:59)*: Yeah.

*AL (0:49:01)*: Or do you see chances that this might change in the future?

*FT (0:49:06)*: Well, when picking programming languages and large-scale projects and large organizations, usually, it’s mostly about management compatibility, right? So language isn’t picked because it’s fun to use or because it has nice features for programmers. It’s mainly being picked because it has a track record, because it has a good ecosystem, because it has good backing from some large institution, and because you don’t have problems hiring engineers. But these are kind of the criteria, the management criteria for picking a programming language. 

And if we, for example, compare TypeScript and Haskell here, TypeScript has the backing from Microsoft. It’s being marketed explicitly as the standard programming language that replaces JavaScript. So management compatibility also says that if you hire a JavaScript programmer, chances are that they can learn TypeScript. Whether or not that’s true or whether or not it’s really that easy, it doesn’t matter. It’s something you can sell. Whereas Haskell kind of still has, unfortunately, this academic track record or the prejudice that Haskell is mostly an academic language, that you don’t find any Haskell programmers. And I think teaching Haskell in first or second year of computer science, but only one course or one or two courses, also contributes to that problem kind of because people perceive it as a language that’s used for teaching and not for implementation or not in the industry. But yeah, I think Haskell markets itself more as a special-purpose language and not so much as a general-purpose language. And in the industry, I think it attracts a certain type of companies, certain type of managers, and not so much the large-scale, multibillion company managers.

*AL (0:51:26)*: Perhaps we should just establish that Haskell is slightly tongue-in-cheek, right? But Haskell is a necessary design tool for object-oriented programming, and everybody has to know Haskell in order to be a productive TypeScript and Java programmer anyway. 

*FT (0:51:44)*: it’s certainly helpful. Yeah.

*AL (0:51:45)*: And then the argument that you cannot hire Haskellers is moot because you already have them, right? Then basically we reach sort of a critical mass all of a sudden, and then we can just take over. No, I don’t know.

*FT (0:52:02)*: Yeah. Yeah.

*MS (0:52:04)*: I think you both underestimate how different the practice of functional programming is to the practice of, I’m not even going to say, object-oriented.

*AL (0:52:12)*: I’m certainly underestimating that, but I doubt that Franz is.

*MS (0:52:20)*: Anyway, I want to shift gears a little bit because — so we’ve been mostly talking about technical stuff, but Franz, you also run MuniHac, right? Can you talk a little bit about how that happened and what it is?

*FT (0:52:32)*: Yeah, we went to ZuriHac and thought, why not do that in Munich as well, right? So when I got into Haskell, I started looking for conferences. We went to Regensburg a few times to the Haskell meetup that Andres organizes. We went to ZuriHac and Haskell eXchange in London. At some point, at one of these conferences, we discussed with Andres why not have a Haskell conference in Munich? And actually, I’m not one of the founding members of MuniHac, even. In the first year, I would have liked to co-organize, but I already had plans for the date. But then for the second installment, I was involved with organizing it. I think that was 2017 or ‘18, something like that. And yeah, it’s been almost a yearly occurrence since then. We have roughly 100 Haskellers every year, give or take.

*AL (0:53:40)*: Yeah, ‘16 the first, ‘18 the second, apparently, if I believe your web page.

*FT (0:53:45)*: Yeah, 2016 was the first one. Yeah. Then 2018 was the second one. Yeah.

*MS (0:53:51)*: Okay. Can you say a little bit more about people who’ve never been to ZuriHac and MuniHac what kind of event it is? 

*FT (0:53:57)*: Yeah. So it’s a Haskell hackathon/conference. So Haskellers of all knowledge levels come together to hack on projects. Whether you bring your own personal toy project, or you’re working on an open-source project, or on the Haskell ecosystem, or you just want to learn Haskell, you can join. We usually have a few talks. We have workshops, a beginner’s workshop, and also advanced workshops. And of course, it’s a good opportunity to network in the Haskell community. So, yeah, we usually have a lot of people who have pivotal roles in the Haskell community. Like, Andres is there every year, and we have keynote speakers who usually play some part in the Haskell ecosystem. So it’s a networking event, a hacking event, and a learning event.

*MS (0:55:04)*: Cool. And it’s usually in the fall, right?

*FT (0:55:07)*: It’s usually in the fall, yeah. We try to have a date somewhere in September or October. We want to bring Haskellers of different knowledge levels together. So we have people who work full-time, but we also have university students. And the ideal point in time is kind of when the summer vacation time is over. The semester has not quite started yet. And of course, in Munich, you also have restrictions that you have to move around Oktoberfest. So usually it’s somewhere in October.

*AL (0:55:47)*: Yeah. So perhaps one should also say, because my experience is that public perception has a little bit shifted since the Haskell world started with the hackathons very early. But these days, a lot of people are associating with hackathons, something that is competitive, and neither MuniHac nor ZuriHac are.

*FT (0:56:07)*: Yeah.

*AL (0:56:07)*: Right? I mean, it’s a purely collaborative event where people come together to learn together, to write together, to exchange knowledge. And it’s also a really good way to either learn Haskell or to become a part of the Haskell community somehow if you’ve been playing with Haskell before. So it always feels hard to believe, given how large, for example, ZuriHac and MuniHac are these days, that there are probably still many, many people who have never been. And I can only encourage people who are perhaps in our audience and have been thinking about it but haven’t really been yet doing it to just try. There’s no need to be a Haskell expert already or even to have written any Haskell programs. You can basically just attend, and it’s fun, and you can learn something. Yeah. And it’s very nice that Franz and the colleagues of Franz at TNG are organizing this year after year. So it’s fantastic.

*MS (0:57:18)*: Yeah, I agree. MuniHac is a lot of fun. All right. So I guess it’s time to wrap up. Yeah. Do we need to say any closing words?

*AL (0:57:25)*: No, I mean, thank you for taking the time to talk to us.

*FT (0:57:29)*: Thank you for having me.

*MS (0:57:30)*: I’m really looking forward to this episode coming out. All right.

*Narrator (0:57:37)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
