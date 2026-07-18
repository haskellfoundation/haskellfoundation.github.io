*Mike Sperber (0:00:15)*: Welcome to the Haskell interlude. I’m Mike Sperber, and my co-host is Sam Frohlich.

*Sam Frohlich (0:00:19)*: Hello.

*MS (0:00:20)*: And I sat down with Stefan Wehr, who’s a professor at the Offenburg University of Applied Sciences. Before becoming a professor, Stefan worked in industry on a large Haskell codebase, specifically one that’s not a compiler and not a blockchain. So of course, we talked about using Haskell in large projects, software architecture modularity, type classes and data modeling, and the suppression of sums outside of functional programming, and also about teaching Haskell at his current job. Stefan has lots of practical insights from his many years of experience. We learned a lot. Enjoy.

*SF (0:00:53)*: Welcome to the podcast. So how did you get into Haskell?

*Stefan Wehr (0:00:57)*: Well, I think it was 2002 or 2003. I don’t know exactly anymore because it’s been quite a long time. Well, I was studying computer science back then, and I think in the first semester we learned Scheme, then we learned Java. And at some point, I thought, “Well, this Haskell keeps popping up again and again. It seems to be some hot topic.” And I think I was also already reading some scientific papers. And I think this was a time where really some type system hackery was going on, and I have to learn it. And yeah, at the beginning I had a hard time, I would say. It wasn’t too easy to get it going. I mean, back then, documentation wasn’t too good, and there weren’t too many books. I think nowadays it’s much better. In the end, it turned out to be a good idea to learn Haskell.

*SF (0:01:58)*: And where was this that you did your undergrad?

*SW (0:02:00)*: I did my undergrad studies in Freiburg in Germany, and Peter Thiemann was teaching there. He still is a professor there. And he does a lot about functional programming languages, Haskell, and that definitely inspired me to give it a try and stick with it.

*MS (0:02:23)*: So did you do any thesis work that had to do with Haskell as well?

*SW (0:02:26)*: Yes. I mean, well, first of all, implementing stuff in Haskell with programming languages, compilers, parsers, type systems, it’s really – I think it’s one of the best languages for doing this kind of implementation work. And actually, for my diploma thesis, I did some kind of comparison between the type class system of Haskell and ML modules. Well, that’s, yeah, but it was for my diploma. 

And then I started a PhD in 2005, and there also Haskell was quite a big part of the PhD thesis because I thought about what needs to be done when you want to have the features provided by Haskell type classes, when you want to bring this feature into an object-oriented language such as Java. So, because, well, type classes, I mean, you can implement a type class without editing the data type that implements the type class. And if you have in Java a class and you want to implement an interface, then you always have to change the class that implements the interface. And it’s quite attractive to, well, let a class implement an interface without changing the class. And that’s exactly what you do with type classes. Well, that was my PhD, bringing kind of type classes or integrating type classes into Java classes and interfaces.

*MS (0:03:58)*: If I can backtrack a little bit to your diploma thesis, it sounds a little bit strange, right? I mean, Haskell has a module system. Why didn’t you compare Haskell modules with ML modules?

*SW (0:04:08)*: Oh, okay. I mean, if you look at the model system in ML, it’s much more powerful than the module system in Haskell, especially because you can have these functors, which lets you basically abstract over modules.

*MS (0:04:22)*: So a functor is not the same thing as a Haskell functor, right?

*SW (0:04:26)*: No, no. That’s a very good point. A functor in the ML module system is basically a function from a module to another module, and it’s a compile-time thing, whereas a functor in Haskell, well, it’s the same name, but it’s a really different thing. Well, models in ML are much more powerful than models in Haskell. It seems somewhat unrelated, these two things, but the people in ML did a lot of research on their model system. So there are these functors. And then you can also have first-class modules where you can pass around module values at runtime, and you can have recursive modules. And if you look a bit closer at these things, well, then you see some kind of relation to type classes.

*SF (0:05:16)*: What were kind of the headline similarities or differences that you highlighted in your thesis?

*SW (0:05:23)*: Oh, that’s a tough question because it’s 20 years ago since I wrote the thesis. Well, what I did was basically I encoded parts of Haskell type classes with ML modules and parts of ML modules with Haskell type classes. I mean, it’s not a proper one-to-one mapping because the things are just too different. But some parts of Haskell type classes you can encode with ML modules, and some parts of ML modules you can encode with type classes. But if you want to know more details, then I really would have to look it up in the thesis again because, yeah, that’s just too long time ago.

*SF (0:06:05)*: That’s right.

*MS (0:06:08)*: Obviously, your PhD also had to do with type classes, right? And from the sound of it, there’s also a modularity issue here. Can you elaborate a little bit on the implications of that for modularity? And I guess we’re going to get into software architecture because we’ll want to talk about your industrial experience as well.

*SW (0:06:30)*: Well, I think the starting point for research in my PhD was really just this modularity question because if you have some class in Java in this way or in another object-oriented language and you have an interface, the class doesn’t implement the interface, then in some sense you’re screwed up because you can’t bring together the class and the interface. All right, what do you do then in object-oriented languages? Either you find the source code of the class, edit the code, and well, then you’re good, and just let the class implement the interface, okay? Then the class is a subtype of the interface, and you can use object of the class wherever you need a value of the interface. That’s the easiest solution. But often you cannot just modify the source code because it could be from an external library or whatever, and you really want to keep the class and the interface in some sense apart.

And then object-oriented programmers, what they do then, they do something. I think it’s called the adapter pattern. So you write a wrapper class that implements the interface and, under the hood, delegates all method calls to the original class. I mean, this approach somewhat works, but it’s kind of a lot of work when writing all this wrapper code. And also you get then problems because in object-oriented languages, you often have to be careful with object identities, which usually doesn’t play that much of a role in Haskell. But in object-oriented languages, the identity of an object is really important. And well, if you have a wrapper, then it’s just a different object. So there are all kinds of problems occurring with this approach. And that’s why I, together with Peter Thiemann, had the idea, well, why not let a class implement an interface? We called it retroactively. So after the class has been written. 

So in some way, it solves the modularity problem. Well, you could also say it shifts the modularity problem to runtime because at least in our implementation, what we did was, basically, what a programmer did was this wrapper we did then in our implementation at runtime. But at least it was hidden from the programmer, and it was, or it is more convenient to implement an interface retroactively instead of through wrappers and other stuff. 

*MS (0:09:02)*: I want to return to this whole modularity issue in the context of the real-world work that you’ve done, right? So you didn’t stay in academia after you finished your PhD. You want to tell us a little bit about that?

*SW (0:09:14)*: Yeah, sure, sure. Yeah. I finished my PhD at the end of 2009, I guess. I got an interesting-sounding offer from a small startup company in Freiburg. And it wasn’t interesting because it was in Freiburg, in the same city. It was interesting because they planned to implement a new system somewhat from scratch, and they planned to use Haskell, which sounds very attractive. So I mean, when working in industry, you don’t have the opportunity too often to implement a system basically from scratch. Usually, you work with existing systems, but for this new product idea, we really started from scratch. And I mean, there were, I think, three other people in the company. We had the opportunity of choosing whichever language we wanted. And well, we thought maybe it’s a good idea to use Haskell. 

This then got me into this topic of using Haskell in industry, which kept me, I think, for 10 years. I worked for this company, and I think it was about 300, 250,000 lines of Haskell code. When I left the company, some – well, we did really a lot of work with Haskell. So in the beginning, it was difficult. Tooling wasn’t as good as it is now. So with all these packages, I remember we always had really a lot of problems with resolving package dependencies. Stackage wasn’t existing back then. So we used only the Hackage database and Cabal. And back then, there was really, really serious problems of resolving dependencies. So our build, I think it broke every second day or so because of that. And then we started having our own Hackage server and things like that. At least from the start of the project, these were the problems I remember the most.

*MS (0:11:18)*: It sounds as though it was a terrible idea to use Haskell. Is that true?

*SW (0:11:23)*: Yes, from this – I think from – well, hmm, was it true? I mean, if I think nowadays, if I use Java and I have to use either Gradle or, I don’t know how is this other build tool called Maven, I guess, I think, okay, it’s also a bad idea of using this build system because maybe I’m too stupid to understand what’s going on with Gradle there, or nobody understands what it’s doing. 

So I think back then, for us, I mean, it was as it was. I mean, well, we just tried to work around these issues. And well, was it a bad idea or not? Probably not, because I think, let’s put it like that. We and still the company doesn’t invest too much time in a proper software architecture. Mike, you also know the system. The architecture isn’t too good, but given the time the people invest in the architecture, I think it’s still reasonably good, and maybe Haskell prevented the worst things happening, so to say, right? It’s still reasonably modular. I mean, if you read the type signatures of the function, it’s still reasonably okay to understand. 

So I think the product is not a very good example of a really good software architecture, but given, I mean, in a startup, what always counts more than a good software architecture is features, features, features, and making the customer happy. So I think from a management point of view, maybe it was also okay to have the emphasis on features and features and features and not on a very clean software architecture. But still, in the end, I think the system is in good shape. It still works. It also works with really large datasets. It performs well. So I think in the end, it was a good idea of using Haskell, I guess.

*SF (0:13:31)*: Given all you’ve learned, if someone was going to start a project from scratch using Haskell, how would you recommend that they structure it?

*SW (0:13:41)*: I think I cannot say because you’re using Haskell, you have to use this and that architecture.

*SF (0:13:47)*: Are there any tips that you –

*SW (0:13:49)*: It depends on the problem you want to solve. So I think that the programming language, it has some influence on the architecture, but I think the influence is not too big. I mean, with Haskell, when I say using Haskell prevented bad things happening, what I mean is, for example, you usually don’t have global mutable state in Haskell programs. And that’s one problem in software architecture. Too much global state binds things together very tightly. You can’t reuse things. It’s very hard to understand. And for example, these kinds of mistakes we didn’t make because it’s not a Haskell way of doing things, having global mutable state.

*MS (0:14:41)*: Yeah. I think the impact of that can be. It’s difficult to overestimate the impact of that in particular. 

*SW (0:14:48)*: True. 

*MS (0:14:49)*: So one, if I can get a little technical?

*SW (0:14:51)*: Yeah, yeah. 

*MS (0:14:52)*: So recently we had a chance to kind of compare that to how software architecture or certain elements of architecture work in Java, right? And one of the things is, you said earlier, Haskell is pretty good for data modeling. And a lot of the things that are modeled as data in Haskell are modeled by a state in Java, for example. And it’s kind of hard to wrap your head around that. But one thing that really struck me is that when you have kind of a react – I mean, your system is a reactive system in many ways, right? Changes come in, does things. And there’s a paper on that that we’ll link to in the show notes. And one of the things that happens is you kind of need to describe what happens in response to an event coming in. And in this particular system, that response is represented by a data object, right? And in Java, it would typically be a callback with return type void that is supposed to somehow magically have access to all the state that it needs in order to do its business. 

*SW (0:15:52)*: No, that’s true. You have to really experience. It makes it so easier if you look at a function and you know all that’s coming into the function is described by the parameters of the function. And all that’s going out from the function is described by the return type. There is no hidden state. There are no, I don’t know, hidden side effects that the function performs. I mean, it’s easy to describe with words, but how powerful this is, you really have to do it and program this way to understand why this is such a good thing.

*MS (0:16:24)*: Yeah. And it’s also a great guide for people new to the system, right? Because they have a data type that describes what they’re able to do or what they’re supposed to do. Whereas when the Java interface says void, you’re kind of on your own.

*SW (0:16:37)*: Yes, that’s true. 

*MS (0:16:37)*: But nevertheless, you said earlier that the architecture maybe is not that great because you were doing things very fast in the beginning. Of course, that’s a challenge with any large project, not just in Haskell. You’re moving fast, and maybe the architecture is not your primary concern. Can you describe a little bit what – is there anything typical about the architecture deficiencies of the system? Can you describe that a little bit? What do you mean by the architecture is not great?

*SW (0:17:07)*: Okay. One thing that could be clearly improved is the kind of dependency tree between the modules. Well, there are many dependencies which shouldn’t be there. So, for example, some utility module depending on some module that implements business logic is just not right. And there are a lot of examples where dependencies are just not as they should be. There are some rules which are also enforced by a checker. So, the rule says, “Well, this module is only allowed these and these sub-modules, whatever.” But there are a lot of exceptions from this rule, and they are there because we never had the time to change all the modules so that they really follow the guidelines and the rules.

*MS (0:18:06)*: So, I mean, what you describe is kind of all the rage in the Java community right now, is that you would have unit tests on your module dependency graph, right? Is that kind of the tool that you described? Is that a way to talk about it?

*SW (0:18:21)*: I don’t understand what it has to do with unit tests.

*MS (0:18:23)*: Well, I mean, presumably these rules that you have, I mean, your architecture might follow whatever the layer pattern, right? 

*SW (0:18:31)*: Yeah, yeah.

*MS (0:18:31)*: And so, you’ve got whatever, three or four layers in your software architecture, and you want to assign each module to one of those layers, and then you only want things to depend on the layer below and not on the layer two below. And so, those things could be codified by just writing a piece of a function that operates on the module dependency tree. Is that what the tool does that you just described?

*SW (0:18:55)*: Well, the tool basically, yeah, in some sense, it’s how the tools, what the tools are supposed to do, and it enforces these rules by basically just looking at the module names. 

*MS (0:19:08)*: Ah, okay. I understand. Okay. So, this is not like a publicly available tool, but this is something that was written as part of the project?

*SW (0:19:14)*: No, it’s not a publicly available tool. One of our developers implemented it as part of our build system, which is also written in Haskell. It’s written using the Shake library, and, yeah, part of this build system was this module checker, which says, “Well, a module with this and that name is only allowed to import modules whose names start with whatever prefix.” And then you get this layering.

*MS (0:19:43)*: Okay. So, I mean, the reason these tools exist in the Java world is that it’s very easy to create module dependency graphs that are messy, right? And is it fair to say that Haskell, even though it’s a functional language, does not magically prevent that kind of mess?

*SW (0:19:59)*: No. Why should it? I mean, it’s the same. Well, maybe what’s a bit better in Java, it’s a pain to have recursive or circular module dependencies. You can have it in Haskell, but then you need to have these boot files. At least back then, it was like this. But I still think it’s the way to do. So, you have to work hard in Haskell to get a circular module dependency graph. But besides that, I think you can do the same mess as in Java or C# or I don’t know.

*MS (0:20:33)*: Well, maybe circularity. I mean, we should say Stefan and I are part of an organization that thinks about software architecture, right? And at least a part of that organization thinks that circular dependencies are a major problem. So, if you can’t do them, maybe at least it solves that.

*SW (0:20:49)*: Okay. At least the project doesn’t have circular dependencies. That’s true. 

*MS (0:20:54)*: There we go.

*SW (0:20:54)*: We got rid of them all.

*MS (0:20:56)*: On the other hand, I mean, these tools that do look at the module dependency graphs are very useful in Java because modularity in Java does not happen in typical Java projects, does not happen through the module system. I mean, hardly anybody ever uses the Java module system, but through the objects. And so, if we can get a little bit more technical, maybe thinking back on both your diploma thesis and your PhD thesis. So, what you did is you applied type classes in Java to exactly the thing that does modularity there, right? And then you compare type classes to ML modules. Does that mean that if the module system in Haskell doesn’t prevent the worst atrocities, maybe we should do modularity like the Java people with type classes instead of the module system? 

*SW (0:21:46)*: That’s an interesting question. 

*MS (0:21:47)*: A far-fetched thought, but I thought I’d pitch it to you.

*SF (0:21:51)*: Or should we learn from ML?

*MS (0:21:53)*: Or should we learn from ML? Yeah.

*SW (0:21:54)*: Yeah. I think I would lean more towards learning from ML. So, that’s what, in some situations, I really miss in Haskell that you can’t have a module that depends on the signature of another module, and then you can later specify, “Well, I want to have this and that module for fulfilling this signature.” I mean, type classes are great for many things. I mean, monad, functor, also equality, or show. It’s perfect, and it works very good. But for modularity, well, using it instead of a module, whoa, I don’t think it’s such a good idea.

*MS (0:22:38)*: I mean, because there’s certainly things missing. I mean, it’s not just the fact that you don’t really have explicit separate interfaces in Haskell, but also the fact that your module namespace is flat. I mean, it looks hierarchical, but really, from any module, you can import any other module, especially, right?

*SW (0:22:54)*: Yeah, that’s true. 

*MS (0:22:54)*: You can’t kind of nest things or say, “Here’s this subsystem, and the subsystem can only have internal dependencies,” which is all things that you can do with the ML module system. Here’s a plea to the Haskell gods. If you want to support software architecture better, maybe one point to attack would be the module system, right? 

*SW (0:23:16)*: Yeah, I think that’s true.

*MS (0:23:19)*: I mean, conspicuously, you just mentioned what type classes are great for, and you all sort of mentioned things that are from the standard library, right? I remember when I got into Haskell in the early years, every paper on Haskell would go on the most trivial things that were overloaded, would define its own type class, right? Is that the way to do it in a commercial project? Does that have a lot of type classes that are kind of domain-specific?

*SW (0:23:47)*: Well, there are some type classes. I mean, I’m not just speaking about this commercial project. There are some type classes, but I think there’s a difference between writing an academic paper where you have basically everything what you want to say upfront available, and you can really think carefully about what kind of abstractions you need and things like that, whereas in a project that goes on and on over time, things change very fast, especially for a startup. And yeah, I think that’s – maybe we didn’t invest enough time to think about how to use type classes properly, but in the end, we didn’t use too many type classes. What we did instead often was just using higher-order functions for abstracting over things, maybe packing them inside a data type, which then acts in some sense like an object. So a data type with many functions. In some sense, it’s a bit like methods of an object. And that was one way to abstract, to have an interface. Well, that’s the function types in the data type. That’s the interface, and the implementation is then just a value of this data type.

*MS (0:25:06)*: And that’s what I tell students when I teach them Haskell and industrial classes, is usually to avoid defining your own type classes. And I think you just described why that is the case, because they need much more careful deliberation. And so they tend to be things that are not in your application but that somebody thought for long enough to put it in some standard library, at least to do type classes. So I think that’s generally lacking a little bit in Haskell as sort of prescriptive advice on how to use all the great features that are in the language.

*SW (0:25:36)*: Maybe, yes, that’s a missing thing. Yeah.

*MS (0:25:40)*: In that company, how did recruitment work? How did you find those other Haskell programmers that presumably were there working on the project?

*SW (0:25:48)*: Well, actually, often you hear that using a non-mainstream language is a disadvantage, because there aren’t many developers available on the market. But for us, I think it was more of an advantage because, especially 2015 or so, it was still not very common to use Haskell in industry. So I think we were attractive for people who wanted to program in Haskell. And usually, these people were very good developers. They were very smart and good programmers. They have a sense for what is a good abstraction and what is maybe not so good abstraction. Well, maybe the tendency is to use more abstractions than strictly necessary. Okay. That’s maybe one point to consider. But I think for recruiting, it was good. It was an advantage, definitely.

*MS (0:26:50)*: Okay. 

*SW (0:26:50)*: I mean, I think if you need a lot of developers, I mean, if it’s a project where you need, I don’t know, hundreds of developers, then maybe it’s not too easy to find enough developers. But if it’s a startup and you only have five, six developers, then from my experience, it wasn’t really a problem of finding good people.

*MS (0:27:11)*: Okay. So you were able to hire people who already knew Haskell rather than having to train them on the job?

*SW (0:27:17)*: Yes. I think I don’t remember that we – I mean, I have to say, in this project, there’s not only Haskell code. We have also quite a lot of TypeScript code for client-side programming. But I don’t remember hiring anyone and training him or her on the job in order to program in Haskell. I think at some point we hired some non-Haskell programmers, but they worked on the TypeScript side.

*MS (0:27:45)*: Well, maybe now that you’ve opened the door to TypeScript, can you compare a little bit how TypeScript feels for a Haskell programmer?

*SW (0:27:54)*: How TypeScript feels for a Haskell programmer? Okay. I mean, the first thing you notice, and you don’t notice it immediately, only after some time, is that in some situations, the program just crashes, although it’s type-safe. I mean, if you know TypeScript, it uses this gradual typing approach where you basically combine a statically typed world with dynamically typed parts of the program, and there is this type any, which basically anything can be of type any, and you also can use a value of type any at any other type you want. And basically any is the crossing point between the statically typed world and the dynamically typed world. And well, obviously it isn’t type sound, so it doesn’t happen too often, at least from my experience, but from time to time it happens that your program just crashes. And at least at the point where you get the location of the error, there isn’t anything wrong. Now, you see, okay, there is a variable. It has type int, whatever, and I do something with it. What I can do with an int, why should it crash here? But then it turned out this int is not an int but, I don’t know, a string or so, which comes out from the dynamically typed part of the program. I think that’s the biggest thing you have to get used to when you program in TypeScript. 

Otherwise, the type system is also pretty powerful. I hadn’t that much of a problem, actually, using TypeScript. So it was okay for me. But what you have to know is we wrote all the TypeScript code from scratch, so it was all TypeScript code written by people who also know how to program in Haskell. And I think that probably makes a difference if you work with TypeScript code that was written by programmers who also know how to use Haskell, compared to TypeScript code written by programmers that comes maybe with a web development background and only know JavaScript and maybe, I don’t know, some other object-oriented language. I would expect these two kinds of TypeScript programs to be very different.

*MS (0:30:15)*: Okay, so that means you’re able to program in TypeScript in a functional or mostly functional way?

*SW (0:30:21)*: So what do you mean by functional way?

*MS (0:30:24)*: I guess purely functional, without side effects? 

*SW (0:30:28)*: Yeah, I would say yes. Maybe not without side effects, but only with local side effects. So, I mean, if you are inside a function and you have a local variable and you update this, that’s not a problematic side effect. You can just do it, and it’s a way once the function ends. So that’s good. Yeah, without global side effects or without global mutable state. And also what I really like about TypeScript is that you can describe data, or you can give types describing the shape of your data, I think, in a quite sensible way. So you can write down types that describe the shape of data in a very exact way.

*MS (0:31:10)*: I mean, what always massively bothers me in TypeScript is the absence of algebraic data types, right? Doesn’t that bother you? 

*SW (0:31:20)*: Okay, but I mean, you have these record types, so these interfaces or object types, and you have this union. The only thing you don’t have is tagging the alternatives of a union. So you have to do it by hand, have one field which you can call kind, and then this field has a string value. And now you have to be careful that this kind field is of type string, but there are only, well, as many different strings as there are alternatives. And the type system is able to decide in which alternative you currently are based on the value of this kind field.

*MS (0:31:59)*: So you kind of rely on convention to encode algebraic data types, right?

*SW (0:32:03)*: Yeah, it’s a convention, but the convention is supported by the type system. So the type system also knows if you covered all alternatives and so on. So yes, it’s not as convenient as in Haskell, for example, but it works okay, I would say. I mean, if you compare it with Java, for example, you really can’t encode algebraic data types in a meaningful way.

*MS (0:32:29)*: Well, I would disagree, at least with the latest versions of Java, which have sealed interfaces and records and pattern matching, pretty much. So you can program pretty much in the same way as in Java.

*SW (0:32:39)*: Yes, it’s just sealed interfaces and records and pattern matching. I don’t know the – I think half a year ago, I tried the latest version of Java, and there still were problems. For example, the type checker couldn’t find out that a pattern match covers all cases, if I remember correct.

*MS (0:33:02)*: Oh, it does not. It does not. 

*SW (0:33:03)*: It doesn’t know? Okay. 

*MS (0:33:05)*: Yeah, it doesn’t. It doesn’t know it covers all cases. I think the pragmatics are very similar now. I mean, they did that in a lot of little steps, right?

*SW (0:33:13)*: Yes, yes.

*MS (0:33:13)*: The introduction of pattern matching. But I wonder sometimes. I mean, the thing about algebraic data types is that it gives you this very convenient pattern of looking at your domain through the data types, right? And it kind of pushes you in that direction of thinking about the data in your domain in terms of sums and products. 

*SW (0:33:36)*: Yeah.

*MS (0:33:37)*: And so, I mean, you said earlier that algebraic data types are great for writing compilers and writing research papers and things like that. Does this advantage of algebraic data types also materialize in the industrial project that you worked on?

*SW (0:33:49)*: Oh, definitely. Haskell is, I don’t know any language which is better suited for data modeling. I mean, for example, we never use some kind of graphical representation of our data model because you just write Haskell code, and it’s, I mean, just the data types.

*MS (0:34:05)*: Right. Yeah.

*SW (0:34:06)*: And I think it’s not even really code. It’s just type definitions. And it really captures quite nicely the shape of data you’re dealing with. And it’s really very convenient. It’s very fast. It’s very readable. I mean, once you get used to your algebraic data types, I think everyone can read the sum of product description. It’s either this or that or that. And in the first alternative, you have fields A, B, and C, and so on. As I said, I don’t know any language better for data modeling than Haskell.

*MS (0:34:37)*: Yeah. I mean, if you know these algebraic data types, then you might immediately jump to that encoding and TypeScript of algebraic data types, right? But if you don’t, I mean, that’s maybe the difference between what you described earlier. You’re coming to TypeScript from Haskell, so that’s what you do. But if you’re coming from somewhere else, then you might not have that background.

*SW (0:34:54)*: Yeah, definitely. You need to know where you want to go to and then it’s quite obvious how to do it in TypeScript. But if you don’t know where you want to go to or you must somehow encode the sum of product approach, then you’re maybe lost in TypeScript.

*MS (0:35:12)*: Yeah. I mean, speaking of sums and products, Stefan and I are a part of this group that does this curriculum on basic software architecture. We recently introduced a new learning goal on the difference between sums and products. And we were quite surprised to find out that many people just didn’t know that and had never heard about it. And I hear from a lot, actually, a couple of organizations associated with that, that they’re all, “Oh, sums and products.” It seems very difficult, I think, from the standpoint of a Haskell programmer to imagine a world where you wouldn’t use that all the time.

*SW (0:35:44)*: Yeah. Most people, they know products, and then they use products also to encode sums. That’s what happens quite a lot. That leads to really messy code if you don’t have alternatives in your code, which are not really expressed in the types. You never know in which alternative you are, and you never know which values are available in which of these alternatives. And that’s much better if you have also sums and can say, “Well, either that or that or another alternative.”

*MS (0:36:17)*: Yeah. So I can confirm that from the projects that we look at that are not coming from functional programming is that they tend to not use sums, which is, I always find that mind-boggling. How would you think of data in terms of, it’s this, that, it is this, and this, and this, and this, and you kind of forget about or. And there’s a great resistance, even though the concept one would think is easier to understand, right?

*SW (0:36:39)*: Yeah. But maybe it’s also because, I mean, in the object-oriented world, there is one slogan that you always have to be open for change, and your data types have to be open. And the sum is, I would say by definition, not very open because you have to say from the beginning, “I have these three alternatives, and that’s it. There is no room for a fourth alternative.” I think in some sense, it’s also an anti-pattern in the object-oriented world to commit to just these three alternatives, and then you’re done. What do you do in an object-oriented program? You write your interface, and you can have as many implementations as you would like to. Even though you only have two or so, it doesn’t matter.

*MS (0:37:22)*: Well, I mean, this is the famous expression problem, right? In the sense that you have sort of dual trade-offs. Well, yeah, you can always extend the data types implementing an interface in Java, but you can’t extend the interface itself after the fact, right? You have to get in those curly brackets. 

*SW (0:37:39)*: Yeah.

*MS (0:37:40)*: And so, I mean, when people ask me about this, there’s always this question, right? Is it often the case that you need to extend an algebraic data type? Is that a good trade-off to make the one that we make in Haskell as compared to the one in Java, for example?

*SW (0:37:55)*: It depends on. Most of the time, not.

*MS (0:37:59)*: Right. Yeah. I think that we program that way, right? It’s not something that just happens to be the case, but that we program in a way that often makes that not necessary.

*SW (0:38:11)*: Maybe, yes. Okay. 

*MS (0:38:12)*: Does that make sense?

*SW (0:38:16)*: I’m just trying to think about an example where to not come into the situation where you have to extend your algebraic data type. Do you have an example in mind or –

*MS (0:38:24)*: I mean, there’s lots of examples that you can immediately think of, right? But I think the way that we do often in functional programming is we tend to look for combinator libraries, right?

*SW (0:38:34)*: Oh, okay.

*MS (0:38:35)*: And this is something that’s completely unheard of outside of functional programming. 

*SW (0:38:41)*: That’s true.

*MS (0:38:42)*: Right. And so, this means that we have this pattern that avoids having to extend data type all the time. But if you don’t have that pattern, of course, you would think the trade-offs are really bad of having algebraic data types be closed.

*SW (0:38:55)*: Yeah, it makes sense. So, from my experience, if you need to extend an algebraic data type in Haskell, then just do it. And the compiler tells you where you need to fix the code. Whereas, if you do it the object-oriented way via interfaces, if you do it really well, then it’s possible to just write a new implementation of the interface. But often, you also have the situation that the interface doesn’t capture all characteristics of the thing that you are modeling. And there are still parts of the code which somewhat implicitly rely on the assumption that there are only a couple of classes implementing the interfaces. So, relying on a characteristic not captured by the interface. And then you still have to change existing code, although you just write a new implementation of the interface. So, in some sense, the algebraic data type here is more honest, because you really have to change all pattern matches that matches on the algebraic data types. 

*MS (0:40:02)*: I mean, we’re all spoiled in that we’re mostly dealing with Haskell source code. 

*SW (0:40:05)*: Yeah, sure. Definitely.

*MS (0:40:07)*: So, if we were more commercially successful, then there would be libraries that we could not change, right? So, maybe then the trade-offs would shift a little bit.

*SW (0:40:15)*: Yeah, that’s true.

*MS (0:40:17)*: Yeah. So eventually you left industry to go back to academia, right? Can you tell us a little bit about that?

*SW (0:40:25)*: Yeah, yeah. I think it was in 2019 or so where I saw this job offer from the University of Offenburg, or I have to better say University of Applied Sciences, which is actually, I don’t know what sorts of university they have in other countries. But in Germany, it’s like this. So, in a university, you mainly do research, and you stay there for your whole career. So, you do your undergrad studies, then your PhD, and then postdoc, and then you become a professor. But this University of Applied Sciences in Germany, they have the requirement that you have worked for at least three years, I guess, outside of academia. So, if you want to become a professor there, you need to have professional experience in your job outside of academia for at least three years. And that’s interesting because, well, it brings together people that are well experienced in industry, but they also have a very good academic background. 

Well, I saw this job offer, and I thought, well, maybe give it a try. And it worked out well. I got the position, and I’m now a professor there for programming, programming languages, and also teaching lectures in algorithms and data structures. But my main focus there is programming languages.

*MS (0:42:07)*: So, are you still doing stuff with Haskell there?

*SW (0:42:10)*: Yeah, I sneaked in Haskell in one lecture, which is called advanced programming. I thought, well, okay, let’s get really advanced and bring the students out of their comfort zone by using Haskell.

*SF (0:42:27)*: What’s the student’s current experience at this point?

*SW (0:42:31)*: Okay. So, the lecture is, I think, in the last semester. And the students, they already know Java pretty well. They know C and C++. That’s what they know from the courses at university. And usually, they also know – because they already did some internship, they know maybe Python or C# or JavaScript or TypeScript. Sometimes they also know Rust. But I think maybe one or two students had some prior experience with Haskell. But most students, they don’t know any Haskell, and they don’t know any functional programming.

*SF (0:43:13)*: How many students is this?

*SW (0:43:15)*: Well, it’s usually between 20 and 30.

*SF (0:43:18)*: All right. So quite a small class?

*SW (0:43:20)*: It’s small, yeah. It depends on the perspective. Yeah, it’s not too big. And we also do very practical things. So, that’s one of the requirements. They have to do a lot of programming exercises. And in the beginning, there are always some, “Why learn another language?” It’s so different. It’s not easy at the beginning if you haven’t any prior experience with functional programming. But most students, if I tell them, “Okay, trust me, just give it a try,” they’re willing, and they really give it a try, and they make good progress. And I think in the end, everyone agrees, or maybe not everyone, but most of the students, they agree, “Okay, probably I will not use Haskell in my job, but I learned some things which are really relevant for programming in the general sense.”

*SF (0:44:16)*: So how long do you spend on the Haskell? Because you said it wasn’t the whole course.

*SW (0:44:21)*: Yeah, that’s a bit of a problem because the course is divided into a lecture part and a practical part. And not for all students, the practical part is mandatory. So, that’s why I shifted to Haskell, or that’s why I use Haskell only in this practical part.

*SF (0:44:45)*: Okay. So there’s no lectures about Haskell?

*SW (0:44:48)*: Yeah. I start with a little bit of Haskell at the beginning of the lecture, but then the lecture talks about basically using functional programming techniques, but not in Haskell and not in a functional language, but in Java. That’s basically the lecture about. But the practical part is all about Haskell and, well, training the students to actually use Haskell in practice.

*SF (0:45:15)*: So you’re approaching it from what they already know, sort of features that have come to Java, and using that as a sort of gateway?

*SW (0:45:22)*: Yes. I think this wouldn’t really work because, I mean, what they already know, you can have mutable state. Okay. No, sorry. It’s not possible in Haskell. What they usually don’t know is how to use algebraic data types and pattern matching. That comes always to my surprise that pattern matching is really a problem for the students. They don’t get it at the beginning. And recursion is also one of the things. There are many students which try to avoid recursion, and it works quite well in Java, and it works quite well in C, but it doesn’t work really well in Haskell. So, in Haskell, they’re really forced to use recursion, which I think is a good idea. Yeah. 

*SF (0:46:03)*: So I’m really curious about this sort of compressed teaching because I teach a long sort of 12-week whole semester course in Haskell. How did you decide what features you teach them, and what is it you get them to build? So you’ve mentioned pattern matching, recursion. What else?

*SW (0:46:20)*: Okay. Maybe I model this lecture from the end. There is a final project where they program Huffman encoding, so a compression algorithm. And basically, I teach them everything that’s needed to do the Huffman encoding. That’s basically algebraic data types and pattern matching and lists. And then we also have to deal a bit with text and byte strings so that they know the libraries, how to read a file, and how to basically then compress or decompress the content of a file. We don’t go too much into detail about – I mean, I mention or I teach them monads. There’s also one part about monads, but we don’t go too much into detail about functors and applicative and about this more. Let’s not call it theoretical stuff, but more on this type level stuff. I basically ignore it. I mean, monads, I need to teach them because, well, you need it if you do IO. And I think there’s also somewhere a reader monad, but the emphasis is not on these parts of Haskell, more on this basic stuff. We have 14 weeks, and we read every second week for three hours, so it’s not too much time.

*SF (0:47:39)*: Yeah. Yeah. How do they find that sort of thrown into all these new things and new language in such a short space?

*SW (0:47:47)*: Yeah. At the beginning, as I said, they’re questioning, “Why do we need to learn this stuff?” But when I tell them, “Okay, I’ve worked 10 years in industry, I have an academic background,” then they usually trust me, “Okay, probably he knows what he’s doing and why he’s teaching us Haskell.” And well, I think in the end, it always turns out good. So the students, they usually manage to finish their final project. And what’s more important, I think they get the idea why it’s good to at least try out Haskell and understand what ideas are in this language. 

There are always some people who want to learn Rust. And I think if you want to learn – because they do low-level programming, and they saw, “Okay, maybe C is not the only way to go, let’s try out this new thing called Rust.” And especially for these people, it’s really good because they can apply many things. There are also algebraic data types in Rust, there’s pattern matching in Rust, but it’s the same way as in Haskell. There is these traits, which are very similar to type classes. So for these people, the benefit is really immediate.

*SF (0:49:02)*: Are there any other benefits?

*SW (0:49:05)*: Well, I think the main benefit is to learn it’s possible to write a program without global mutable state. You don’t believe it before you do it. So you have to do it.

*MS (0:49:17)*: Right on.

*SW (0:49:18)*: Yeah. 

*MS (0:49:23)*: So that seems like a good note to close on. Many thanks, Stefan. 

*SW (0:49:27)*: Yes, many thanks to you. 

*MS (0:49:29)*: I’ll see you soon, I guess, doing more Haskell.

*SF (0:49:32)*: Thank you so much for joining us.

*Narrator (0:49:35)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
