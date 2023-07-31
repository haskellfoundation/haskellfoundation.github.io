*Wouter Swierstra (0:00:19)*: Welcome to the Haskell Interlude. I’m Wouter Swierstra and joining me today are Andres Löh and Bartosz Milewski. Bartosz will tell us a little bit about his thoughts on the fringe topics in programming, from C++ templates to category theory in Haskell, how he considers monads to be like fingers sticking out of the water. And he’ll talk a little bit about his upcoming book and his thoughts on linear types.

*Andres Löh (0:00:50)*: With us today is Bartosz Milewski. Welcome.

*Bartosz Milewski (0:00:53)*: Hello.

*AL (0:00:54)*: So yeah, our usual first question is always like, how did you get into Haskell? But I think in your case, that’s actually a very long story, right?

*BM (0:01:04)*: Yes, it is a very long story.

*AL (0:01:07)*: Well, nevertheless, try to tell it. 

*BM (0:01:09)*: Okay. So actually, I don’t consider myself a Haskell programmer. I do Haskell just to test some ideas in category theory. I never was actually hired by any company to do Haskell professionally. But in my life, I went full circle. I started as a mathematician, sort of. I went to a special high school for mathematicians where we were taught by people from the university, and it was pretty advanced mathematics. And then I studied physics. I did a PhD in Physics. I had some postdocs as a physicist, and I published a bunch of papers. It was about supersymmetry, which was a very hot topic back then. Supersymmetry, strengths, supergravity, stuff like this. And then I immigrated to the United States and worked as a physicist there for some time, and finally decided. I was like, my free time, I was spending with my computer programming and I decided I should do something about it.

*AL (0:02:37)*: So had you been programming all that time, or since you were a kid or –

*BM (0:02:43)*: No, no. I bought a computer when I was already a physicist, but I didn’t do any work as a physicist with computers. So that was just in my free time.

*AL (0:02:57)*: But you did write programs, so you did do –

*BM (0:03:00)*: I started writing programs. I started, yeah. First in basic.

*AL (0:03:04)*: In basic. Okay.

*BM (0:03:06)*: Then I learned a little bit of assembly language. And then I sort of assimilated a little bit of C. And at that point, I applied to Microsoft. I thought, okay, let’s see how I can – I was a very fresh programmer back then, self-taught not much, but Microsoft was hiring. I mean, they had an idea to hire physicists because they thought a physicist can actually learn programming very quickly and be productive. 

*AL (0:03:46)*: When was this?

*BM (0:03:47)*: That was in the ‘90s. End of ‘80s, beginning of ‘90s. And when I worked at Microsoft, I worked on several projects. I was just jumping from one project to another because they kept canceling projects. There was a crazy period at Microsoft where they would try different things, then they figure out, “No, actually, nobody’s going to buy this, so let’s do something else.” And eventually, the thing that I actually am proud of doing at Microsoft was I introduced C++. I started programming in C++. And I had a group of people who learned C++ with me. And we implemented a content index for Windows, which is active till today. If you’re on Windows and you do file search, you are using my content index.

*AL (0:04:56)*: So you worked on large teams there, or did you end up –

*BM (0:05:00)*: No, it’s like maybe, I don’t know, half a dozen people.

*AL (0:05:06)*: And C++ is something that basically you started studying while you were at Microsoft, and then you also put it into production.

*BM (0:05:15)*: Yeah. I was so into object-oriented programming, you wouldn’t believe. Actually, I wrote a book about C++. C++ In Action.

*AL (0:05:29)*: But C++ was also the first object-oriented programming language that you were confronted with?

*BM (0:05:36)*: Yes.

*AL (0:05:36)*: Or did you look at other object-oriented languages before? 

*BM (0:05:40)*: No, I didn’t. No, no. 

*WS (0:05:42)*: And what was the appeal? 

*AL (0:05:43)*: Well, I was always interested in how to write programs from the correctness point of view. Like, how can I make a program that I could test or prove that it’s correct? I mean, not like a formal proof, but the problem with C was always you allocate memory, you forget to free it, or you free it and then reuse it, and so on. There is memory leaks, all kind of stuff. And in C++, you could figure out this nice strategy when you use safe pointers and guaranteed deletion at the end of the scope and so on. Scoped pointers. So resource management, that was my big thing. And now I’m kind of coming back to this because I’m very interested in linear types in Haskell, which is again about resource management. So, full circle.

*AL (0:06:51)*: Perhaps we can talk about linear types more later. But what I find interesting about the C++ introduction story is always that you know how one can introduce new programming languages at big companies, apparently. So, lots of people are trying to introduce languages like Haskell. So, are there good arguments? How did it go at the time with C++? Was that an easy sell or was everyone immediately convinced, or what did you do in order to convince people?

*BM (0:07:26)*: No, it was not a very easy sell. And I was working in the Windows operating system group, right? So I was trying to sell this to the whole NT team at that point. And the NT team was not really into it. They wanted to program in C, which was already a progress because, in the beginning, they were programming in assembly language. There was this OS/2 operating system that was written in assembly, but NT was written in C.

*AL (0:08:01)*: But in a way, somehow you must have succeeded. So what was the trick that worked in the end?

*BM (0:08:07)*: Well, the trick was that I guess we were more productive, not only in the sense that we wrote more code quicker, but also higher quality. I think that was mostly the quality. We didn’t have a lot of bugs.

*AL (0:08:27)*: But it means that they have given you the chance to just try with something small. And then you were able to demonstrate that it actually leads to better results, or –

*BM (0:08:38)*: Well, yeah. They gave us a choice. Now, I mean, I insisted on using C++ and there was pushback against it like, “Why? Why should we?” And it’s like, “Content index, what are the objects in content index? This is not an object thing.” It’s like, “Oh, this is sort of more like a database,” and so on. But then we started designing it and it’s like, “Oh, hey, here’s an object, here’s another object, here’s that object,” and so on. And it turned out it’s like a lot of interesting objects. Some of them had reasonable names like index, for instance, right? And others were sort of like what people do nowadays in Java, something factory, something factory, and so on. Yeah, this object paradigm does not really fit everything.

*AL (0:09:37)*: And the book that you mentioned that you wrote about C++, was that during your time at Microsoft or no?

*BM (0:09:43)*: No, that was after Microsoft. After Microsoft, I started my own little company. We wrote a distributed version control system. That was actually the first distributed version control system in existence.

*AL (0:10:01)*: Are you willing to say why you left? Or, I mean, what happened that you moved on?

*BM (0:10:07)*: Yeah. Well, politics. There was so much politics going on. There were teams that were vying for supremacy at Microsoft, and they wanted to cancel my project, and I said, “No, after my dead body.” So, they didn’t cancel it.

*AL (0:10:35)*: And then you set up your own company and worked on a distributed version control system.

*BM (0:10:39)*: Yeah. It was not a successful company, but it was a lot of fun with a bunch of friends. We were just coding in C++ and we just were implementing stuff in C++ and rewriting it. Whenever we thought that we can write it better, we would just rewrite code. In a serious company, you can’t really do that. It’s just, if it’s working, don’t touch it.

*AL (0:11:13)*: How did this system compare to, I don’t know, something which we’re using today? 

*BM (0:11:19)*: There was one really, really crazy thing because we had a distributed team, and we didn’t have a central server or anything. So we came up with a system that worked through email. So whenever you did the check-in of your code, it would automatically send emails to all the other members of the project and they will be automatically accepted and checked in so the changes were merged immediately.

*AL (0:11:51)*: So everybody was running some sort of service on their machines, which would monitor their inboxes or –

*BM (0:11:57)*: Well, the emails was the server, sort of like. It’s like everybody was sending and receiving emails.

*AL (0:12:05)*: But I mean, you still have to actively read the email and do something, or was there like –

*BM (0:12:12)*: No, it was automatic. There is an interface for email that the software interface –

*AL (0:12:18)*: Very nice. Does it still work or is it that –

*BM (0:12:24)*: No, it’s not abandoned. It’s on GitHub. It’s freely available. But C++ has evolved since then. It’s almost unrecognizable.

*AL (0:12:38)*: So that was the time. During that time, you ended up writing your book, or was it even later?

*BM (0:12:44)*: It was sort of the experience of running this. It was a large project. So, managing a large project in C++ was an interesting experience, and I decided to write a book about it. So the best practices of how to write object-oriented code in C++.

*AL (0:13:07)*: And was the book writing a positive experience?

*BM (0:13:09)*: Oh, yeah. It was a lot of fun. I’m still writing books. I definitely like it.

*WS (0:13:20)*: And looking back at what you know now about Haskell and category theory, do you still stand behind the same advice, or would you write a different book if you’re writing for C++ programs nowadays?

*BM (0:13:34)*: Yeah. Well, C++, I was sort of very much into C++ back then. Now I look at C++ and I’m just like, what kind of language it has become.

*AL (0:13:52)*: So you think it’s the language that changed and not you.

*BM (0:13:57)*: Both. I mean, I’m much more critical now about the design of languages, right? C++ has become and started as a kitchen sink and has become even more of a kitchen sink full of dirty dishes.

*AL (0:14:15)*: Yeah. Okay. So let’s perhaps explore a little bit like what happened after the company, or how did you get from there to eventually Haskell?

*BM (0:14:24)*: Well, I decided to finally get some education in computer science. So I went to the University of Washington in Seattle and took some grad courses there, just as a free student, sort of non-matriculated student.

*AL (0:14:41)*: With a particular focus on programming languages or –

*BM (0:14:45)*: Yes, I did some electrical engineering on the side, and then more into compiler writing and language and stuff. And this course was – one of the courses was given in ML, so I had to learn ML. And that was a totally weird experience to me because I never had an experience with functional programming. Well, okay, I did sort of in C++ because I was interested in like, what is the hardest thing in C++ that you can do? Well, of course, template metaprogramming, right? So I started reading these books about template metaprogramming, and they were really crazy ways of doing programming at compile time, right? And at compile time, you have no mutation, right? So you automatically are into functional programming. And I thought, okay, functional program is really, really hard. The syntax of C++ templates is horrible, right? And then I learned ML and it turns out, well, you can do functional programming using very nice syntax. And then I switched from ML to Haskell and I never looked back.

*AL (0:16:12)*: But that’s still a step, right? I mean, why not stick with ML? Did you specifically look for other functional programming languages, or was somebody mentioning Haskell to you? Or how did that –

*BM (0:16:24)*: I don’t really know. Somehow, Haskell seemed nicer to me than ML. I don’t know what I liked about it, but it seemed more natural to me. And also because people who were doing template metaprogramming, they were sort of more into translating stuff from Haskell. So I actually sort of found my niche by writing some stuff in Haskell and then translating it into templates, C++, I started writing a blog about it. It’s like really crazy complicated template stuff, which is very simple in Haskell.

*AL (0:17:07)*: All right. So you wrote blog posts along the lines, “Look, here is the simple one-line Haskell program, which I can translate into a hundred lines of template.”

*BM (0:17:18)*: Yeah.

*AL (0:17:19)*: And was that well received by the C++ audience or –

*BM (0:17:25)*: Not initially, but they grew into it a little bit. Well, I mean, I went to C++ conferences and I was giving talks and I would give a talk about monads. And monad in C++ is a dirty word. You’re not supposed to talk about this. But there were some young people who were enthusiastic about this stuff. And so I had my audience.

*WS (0:17:53)*: But even then, you went from C++, which many Haskell people consider like you’d write this if you’re interested in writing a game engine or something super efficient. And then if you look at the Haskell side, once you got into Haskell, you kind of transitioned into category theory, which even Haskellers would consider to be the more abstract direction of the language you could go, right?

*BM (0:18:18)*: Yes. I usually look at things that are on the fringe. The template metaprogram is a fringe activity in C++, and then category theory is a kind of fringe activity in Haskell.

*WS (0:18:35)*: Yeah. Okay, fair.

*AL (0:18:36)*: That makes sense. So yeah. I mean, just normal Haskell programs don’t cut it. You have to continue writing blog posts about things that shock people.

*BM (0:18:52)*: Well, I’m always curious about stuff that I don’t understand. If for the first time, somebody mentioned monad, I was like, “Well, what is that? What’s a functor?” Okay, I have to start learning category theory because I don’t know what they are talking about.

*AL (0:19:11)*: Okay. So your interest for category theory started by trying to explain these kinds of concepts like functors and monads to, effectively, a template metaprogramming, C++ audience?

*BM (0:19:27)*: Right, right.

*AL (0:19:28)*: Okay. That’s interesting.

*BM (0:19:30)*: And then I started going to some Haskell conferences. I went to a Haskell conference and I met Edward Kmett and I knew him from his work. But he recognized me and he said, “I read your blog post about C++ templates and so on.” I was so happy and we started talking about category theory. 

*WS (0:19:58)*: So what’s the appeal of category theory to you? Like, why did you get drawn into this?

*BM (0:20:03)*: Well, what brings people to mathematics part? Why is it that some people, they say, “I always hated math in high school, blah, blah, blah”? And there are other people who just find it so fascinating and interesting. I think there is some kind of brain activity that is triggered when you have the aha moment. I think what’s happening is that when you are studying something and you get it, then you actually get some kind of endorphin rush in your brain, right? And you get addicted to it. So I think this is an addiction. There are some addicts who have to get high on mathematics. And that’s the only explanation I can see, because I mean, there’s a lot of hard work. When I read a paper on category theory written by mathematicians, it’s like, I don’t understand anything in the beginning. It’s just like every sentence is code. You have to decode it, you have to find your decoding ring, and you manipulate stuff. You draw pictures. I mean, it’s a lot of pictorial stuff. They don’t put pictures in many publications. And so you have to do it on the side. Diagrams, commuting diagrams, that’s all.

*AL (0:21:42)*: So is this really like how you learned? You read these mathematical papers and you found them very difficult to understand, so you thought about them and read even more, and then you finally got it? Or was there particular sources as you did –

*BM (0:21:56)*: I bought Saunders Mac Lane’s Categories for the Working Mathematician. And I started the first paragraph and I said, “I don’t understand anything.” In the beginning, it was really hard work and I had to – Wikipedia is helpful, nLab is also very helpful, but it’s a very steep learning curve. Much, much later, I started understanding actually what people were saying in nLab. Still hard, but it’s getting easier. 

*WS (0:22:37)*: So I think one of the things which I always find is, if you look at a definition in category theory, by itself, the definition of a category or a functor or something, you can say, “Okay, I can see the definition, but I don’t understand what it’s generalizing yet.” And then if you look at Mac Lane, they’ll give examples which are maybe trivial for mathematicians, some finite dimension, vector space or something, which is –

*BM (0:23:04)*: Or a group or a unique group or something like this. Yeah.

*WS (0:23:09)*: But as a non-mathematician, you’re suddenly confused because the examples aren’t generalizing something that you’re familiar with.

*BM (0:23:15)*: So this is exactly what I did. I found my niche. I started explaining category theory to programmers, giving programming examples. So you don’t really have to study or graduate mathematics before you can get into category theory. It’s enough that you’re a programmer. So that’s a very nice field where you can find lots of interesting examples.

*WS (0:23:46)*: Yeah. I always find it helpful if, even if it’s just in the category of Haskell functions and types, that you can suddenly see these ideas come to life and you can run them. And that helps it make it concrete again. And then, of course, it’s always imperfect because it’s easy to get tied down into living in just this category. But as a first intuition, I can find it really helpful.

*BM (0:24:16)*: Right. But things like product, co-product, functor, or natural transformation, all the stuff can be implemented and you see it, you can touch it with your hands. But one thing that I would like to say to everybody who’s trying to learn category theory is not to give up because it is hard. And it’s not that there’s some people who just opened Saunders Mac Lane first time and they just read through chapter after chapter and they understand everything. No, no, it doesn’t work like this. So it’s very normal to just look at it and say, “I don’t understand anything, what this guy is talking about.” And then you come back to it a day later, a week later, a month later, and every time you understand a little bit more. And in time, you get stuff. And then you get this aha moment and say, “Wow, this was so trivial. Why was it so hard to me?” I mean, it happens a lot in category theory. You read something, it seems very, very difficult. And once you understand it, it seems trivial. It’s like, what was the problem there? 

*WS (0:25:45)*: Yeah. Something like the Yoneda lemma is a classic example, which is the first time you see this, it’s impossible. It’s magical and there’s something weird going on. And then at some point, once it clicks, you realize, oh, it’s just functions and identities and how hard can it be?

*BM (0:26:07)*: Well, I don’t think I’m there yet. I mean, I understand Yoneda lemma, every word of it, but like, what is really happening there? Why is it happening? I’m still not sure.

*AL (0:26:31)*: Yeah. I think the other thing that is in a way good is that category theory for Haskell programmers is sort of not on the critical path really. It is kind of optional, right? So you don’t have to put yourself under immense pressure to understand anything. You can just let time work for itself. And when you finally do, it helps because you can recognize that certain things actually are connected that otherwise don’t necessarily appear connected or that certain things generalize in nice and perhaps unexpected ways. But it’s not necessary. You don’t have to be feeling bad about not making the progress that you might want to make

*BM (0:27:14)*: There is one area in which knowing something about category theory actually changes the way you program in Haskell. I think that’s once you learn about algebras and coalgebras, because that gives you this level of abstraction in which you stop doing things using recursion. The first big problem when people learn Haskell or other functional language is recursion, right? Especially when you come from C++ or traditional languages, right? You always write loops, right? And you think in terms of loops, I have to iterate, iterate, right? How do I iterate in Haskell? Well, you do recursion, but recursion is kind of like a weird way of thinking when you have to sort of assume that you already solved a problem and then you have to do one more step to finish it. And it’s not natural. In iteration, you just do one step at a time, and then next step, and then next step, and then step. In recursion, you have to assume that you’ve done it already, right? I haven’t done it yet, but let’s assume that I’ve done it and now I need one more final step, right? So this is hard. 

But then when you learn about algebras and things like catamorphisms, anamorphisms, all this stuff, you suddenly think, “Oh, I don’t have to think recursively. I can think holistically.” It’s a data structure. I’m looking at this whole data structure and I’m applying a transformation to this whole data structure all at once. And this is so powerful. I like that there’s the advent of code once a year, right? I look at these problems and solve some of them in Haskell. And I’m always looking for like, how can I solve a problem using a hylomorphism? I just love hylomorphism.

*WS (0:29:29)*: So one thing I’ve always struggled with when it comes to learning category theory is, and I have to articulate this a little bit, when I’m learning a new programming language, I learn the syntax and then I write Hello World or Fizzbuzz or some little programming exercise and I do something a little bit larger, and at some point, I kind of come to grips with the libraries and the syntax and so forth, and I can build it up from there, right? But category theory, I always struggle to find exercises which will improve my understanding, which are not a full PhD thesis and not just unfolding the definitions and completely trivial, right? So it’s like, how do you get more proficient? Like what’s the middle ground there somehow?

*BM (0:30:20)*: Well, it depends on what you want to do with category theory, right? I mean, do you want to apply it to programming or do you want to prove a theorem? I mean, eventually, I started doing a little bit of my own research in category theory, right? Lenses, optics, this kind of stuff. So that’s a different activity, right? I mean, it’s really doing mathematics.

*WS (0:30:47)*: Yeah. So I think what I have, though, is when you find a new problem and you’re in some unfamiliar domain, and then usually one of the first questions I ask myself is, okay, what are the types and how do I structure and how do I model things a little bit? And I know people who are really good with category theory who start immediately asking, what are the objects? What are the arrows? What are the functions? What are the natural transformations? For me, I never got to the point that that was the natural question to ask somehow, maybe because I need to work harder at this, but I don’t know. It’s just an observation that despite knowing what all these things are, it’s not the first tool that I reach for when I try to solve a problem.

*BM (0:31:34)*: I think the problem is that there aren’t that many intuitions. When you are studying category theory, people don’t talk about like, what are the intuitions behind this? So you kind of have to work it out by yourself. I mean, I try to put as much of my – when I understand something, I get some intuition. I try to put it in my book or in blog posts or however I can, or give a talk about this. And there aren’t that many intuitions in category theory because it is so abstract. When you are trying to explain what a monad is to a Haskell programmer, how do you explain? It’s like, well, there is the Maybe Monad. Well, okay. And there’s the List Monad. Okay. And there’s the Continuation Monad. It’s like your fingers sticking out of water, right? Each finger is separate. Where is the hand?

So, the way that I finally tried to explain monad is that it’s in composition. You are trying to compose things and there is this new way of composing things that is different. It’s sort of like composing functions, right? But these are not simple functions. These are functions that return some funny stuff, right? And how do you compose functions that return funny stuff? They accept normal stuff, but they return something that’s weird.

*WS (0:33:20)*: So you explain Kleisli composition or –

*BM (0:33:23)*: Exactly. Yeah. Going through Kleisli is much, much easier.

*WS (0:33:28)*: Okay. That’s interesting. So I do exactly what you said. I give all of these examples and I say, “Okay, what’s the common theme behind catching nothings and handling failure or threading state through a bunch of sub-computation?” At some point you realize, “Oh, okay, there’s this one combinator.” But then even then, it feels a little bit like a rabbit out of a hat.

*BM (0:33:54)*: There is something miraculous that happens with monads. The question is like, how come that all these weird effects that you can think of, they have all the explanations in terms of functions returning some functor? Why is it so? Whether it’s IO or maybe or list. I mean, there’s this guy Moggi, right, who came up with this stuff. And he says, “Here are the effects that cannot be described by regular function, but we can describe them by functions returning some stuff, and here’s the stuff.” And it’s like, I don’t know, five monads that are useful. And they were all described in Moggi’s paper.

*AL (0:34:51)*: Okay. So perhaps going a little bit back to the history stuff. I mean, you became interested in Haskell, you became interested in category theory within Haskell. You wrote these blog posts and then it was sort of natural to also write a book about it, or was there some extra decision involved there? At what point did you decide that this is something you want to be doing?

*BM (0:35:13)*: Well, I decided to write the book when I decided to spend a year in Italy. I went with my family to Italy and just spent a year in Tuscany. And I thought I have to have something to do, right? Not just be lazy, right? So I need a project. And I was thinking, what kind of project? Well, maybe I could write a book about template metaprogramming in C++, because that was something I knew already, right? But then I thought, well, it’s not really that challenging. It’s like, okay. So I already know this stuff. Well, I could easily do this. And was it an interesting project? Not really. So I thought, okay, I have to do something more ambitious. And I knew a little bit of category theory already, right? And I knew a little bit of Haskell and I thought I’m just going to learn category theory while explaining it. So I wrote a plan, sort of chapters of the book, and I thought, okay, I’m going to start writing it as a series of blog posts. So I had a plan and I was just following it. I had my Saunders Mac Lane with me and access to the internet, and I started doing this.

*AL (0:36:52)*: Was there a particular goal you wanted to reach? Like, I want to get to this topic, or did you just say like, “Whatever I’m going to achieve in this year, that’s it,” or did you –

*BM (0:37:07)*: Well, I had Saunders Mac Lane, right? So I saw the chapters, all of that with the idea that I want to take all the possible examples from programming rather than – I mean, Saunders Mac Lane explained stuff using these mathematical constructs and group theory and geometry. I wanted to use something that’s easily accessible to programmers.

*AL (0:37:41)*: But did you manage to basically get it done within this year in Italy, or did you need longer?

*BM (0:37:47)*: Pretty much so, yeah.

*AL (0:37:49)*: Okay. That’s impressive.

*BM (0:37:51)*: And I thought I was done. It’s like, oh, okay. So I wrote all these blog posts. It’s done then. But then there were people, volunteers who decided, “Oh, we’ll turn it into a book.” So there was a bunch of volunteers who turned my blog posts into PDFs and put it on the website so that people can access it as a PDF and they can print it if there is a printing service.

*WS (0:38:22)*: And you’re working on a second book, I hear?

*BM (0:38:25)*: Yes. It’s not enough to write one book.

*WS (0:38:31)*: Or a third book, actually? 

*BM (0:38:32)*: Save the third. Yes. This is called The Dao of Functional Programming. Why is this title? I mean, the Dao is the Eastern philosophy. And I find a lot of ideas in category theory that are very philosophical, right? There is this holistic approach. If you want to describe what is category theory about, okay, so now I’m trying to do this for you guys. So what is category theory about? In every other aspect, either mathematics or physics or programming, we always look at the structure of things, right? In order to understand something, we want to decompose it and find what’s inside, right? It’s like you get a watch and you want to see like, how does it work? Why is it ticking, right? So you open it, you find the little parts, and then you decompose it into tiny little bits. Maybe you decompose it into atoms and then quartz, depending on how far you want to get to understand it. And category theory is very different from this. In category theory, you say I want to learn about this object, but I’m not going to look inside of this object at all. This object is black box. It’s a point. It has no structure. The structure of this object is given by how it interacts with other similar objects. So you always have a whole category of things. You want to talk about groups? Okay, what’s a category of groups? And in the category of groups, you don’t talk about what a group is like, what’s inside the group. No, you say, how is this group related to other groups, right?

*WS (0:40:33)*: So what’s the message that you want to get across with this new book? Is that this kind of holistic view on studying problems, being able to say – or in a way, like what you mentioned with recursion, right? Rather than thinking about defining a recursive structure in one go, you want to think in terms of, I have some initial algebra. I want to compute something from it using a fold. So I need to come up with the same algebraic structure so that I can pass it as an argument to my fold and compute out the result without thinking about it operationally. Do I go down to the left subtree first, or the right subtree first, or this kind of thing, right? So it’s more this kind of idea of maybe philosophy of programming holistically. Is that the message that you’re aiming for?

*BM (0:41:28)*: It’s not really a book about programming per se. It’s more about understanding structure. I mean, it’s an amazing thing what category theory does, that it says, “Here’s a structure, it’s just objects and arrows. That’s it.” There’s nothing else. There’s just objects and arrows. And then you can study it and you can discover that these arrows can move in weird ways and combine in such crazy ways. And if you want to describe objects using just arrows, because arrows tell you how they interact with other objects, right? So there is a completely new way of talking about structure by saying how the arrows arrange themselves, right? And there is this stuff, for instance, called universal construction. Most of the things in category theory are defined using universal construction. A universal construction says, in order to understand this object, you have to tell me how it interacts with the whole universe, with every other object, not just a few objects, okay? No, with every object. That’s the universality of it, right? So this is so philosophical. You can’t be more philosophical than that, right? Make me whole with the universe, right? 

So when I was writing the first book, I was fascinated by individual things that I discovered in category theory, like how do you define product? How do you define sum? How do you define a function? What’s a coend? Stuff like this. What’s a limit? But after going through all of this, I started seeing patterns among patterns, right? What the actual category theorists have in their mind when they are doing category theory, right? So now I have hopefully a deeper understanding of this stuff. And so I’m trying to talk about that.

*AL (0:43:53)*: So will people have to understand the first category theory book you’ve written in order to understand it?

*BM (0:43:58)*: No, no. It’s an independent book. I mean, it starts from nothing. I mean, it sort of starts from the void.

*WS (0:44:11)*: From the initial object. 

*BM (0:44:13)*: The initial object. Exactly. Right.

*AL (0:44:16)*: But it still uses Haskell as sort of a language to give examples. 

*BM (0:44:25)*: Yeah, I was considering using maybe a different language, but then the audience for this book would be much narrower, right? I mean, I like Idris for instance. I mean, dependent types in general are very interesting. Maybe they are not very practical, but they are definitely interesting.

*AL (0:44:48)*: Yeah, that was one of the things that I was going to ask sooner or later as well, that, I mean, you made this huge transition at some point from C++ to Haskell and then in a way to category theory within Haskell. Is this the endpoint or is there the obvious next language? Or you’re in the end coming full circle and saying, “Let’s go to assembly, let’s go all the way back to assembly language”?

*BM (0:45:17)*: No, it’s a spiral rather than a circle. Well, definitely, I’m seeing the shortcomings of Haskell to express all these ideas.

*AL (0:45:29)*: So you would say the shortcomings of Haskell are that it’s not expressive enough for categorical ideas. It’s not like the typical things that the error messages are bad or the tooling is not good, or the compile times are too long. But you would say it’s just not expressive.

*BM (0:45:47)*: There are analogous problems in Haskell that I found in C++. In C++, there was template metaprogramming. The syntax was awful and the error messages were terrible and so on. In Haskell, well, the fact that you don’t have dependent types is very limiting.

*AL (0:46:10)*: And the language you’ve been experimenting most with in that direction as Idris, you said, or –

*BM (0:46:16)*: Yeah, I did a little bit of Idris, not enough. But Idris is not a very developed language. There is no tooling for it. I mean, there is Idris 1.0 that has some tooling, but Idris 2.0 doesn’t.

*WS (0:46:36)*: Yeah, this is always tricky with these research languages, right? That you want to explore some ideas, but you don’t have a whole team of programmers to write a package manager or a standard library, or it kind of hinges on volunteers.

*AL (0:46:50)*: This is difficult even for Haskell, which is the order of magnitude is larger or probably possibly even more than that. So this is a bit disconnected, but you also mentioned linear types earlier and that you’re interested in them. Does that also somehow tie into your second book, or is that sort of an independent area of interest?

*BM (0:47:16)*: Yes, I would like to include something about linear types in the book. Right now, I didn’t because I’m reading papers that try to model linear types in category theory, but they are extremely complex.

*WS (0:47:39)*: Yeah, I can imagine, because the appeal of category theory is this holistic view where you hide how a function is implemented or something like this. Whereas with linear types, you want to track these pieces –

*BM (0:47:53)*: I’m reading these papers and I’m trying to figure out where are the linear types in it really. I don’t recognize them. I don’t recognize how do I implement counted vector. Like what? There is a Grothendieck vibration, okay? That’s the starting point.

*WS (0:48:15)*: Oh no.

*AL (0:48:18)*: So both Idris and Haskell now have linear types, right? Is that something you’ve been experimenting with?

*BM (0:48:24)*: Yeah, I’m experimenting with Haskell linear types. Unfortunately, again, tooling is not very good. I don’t have a development environment that would include linear types and especially linear libraries. I mean, there is online Haskell playground, that’s very good. I like it. And it has linear types, but it still doesn’t include the library, so I can’t really write any useful program using linear types.

*WS (0:48:55)*: And what would you like to use these types for? Is there any kind of particular domain or experiment or fancy typing that you’re interested in?

*BM (0:49:05)*: I think linear types solve a lot of problems. I mean, Rust is getting very popular, right? Rust has ownership types. So the comparison between ownership types in Rust and linear types in Haskell is very interesting. But it definitely could improve. I mean, one of the big problems of Haskell is memory management and programs run slow because they consume memory and there’s garbage collection. If you could manage resources better using linear types in Haskell, then you would have the best of both worlds.

*WS (0:49:47)*: And how do you feel about laziness versus strictness?

*BM (0:49:49)*: Well, I love laziness because it’s so expressive. I mean, I can have infinite data types, right? Oh, man. And then you can operate on these infinite data types. You don’t have to worry about how much memory an infinite data type takes, right? Only if you access it, right?

*AL (0:50:15)*: I can certainly tell you from personal experience that you do very much have to worry about this, but I still see your point. I’m also still a fan of laziness personally.

*BM (0:50:27)*: And it definitely fits better with category theory. Because in category theory, you constantly work with infinities. You work with infinities, you work with things that are so infinite that they are not even set.

*AL (0:50:44)*: By the way, for the second book, are you copying the approach of the first one, that you’re writing individual blog posts until you are done? Or is it sort of more monolithic that you –

*BM (0:50:56)*: No, it’s more monolithic. It is available on GitHub. I’m writing it using LaTeX, so with figures that are actually using TikZ and so on. Very painful. 

*WS (0:51:16)*: You have some of these “what you see is what you get” editors nowadays for commutative diagram, which seem useful to me, but then –

*BM (0:51:26)*: Yeah, the diagrams are – I’m not that worried about diagrams. Diagrams are still, but if you want to do a TikZ picture with blobs, that’s much harder. So maybe at some point, I will just start drawing little piggies like in my first book, illustrating with piggies.

*AL (0:51:50)*: Yeah, I think that was a huge success, right?

*BM (0:51:55)*: Yeah. There are kids who are learning –

*AL (0:51:58)*: And even then, you can probably just find volunteers who will put it all into actual diagrams for you if you really don’t want to just keep the pictures. So yeah, okay, I guess we slowly come towards an end, perhaps. I mean, do you have, apart from the second book, further plans? I think you’re also doing some teaching. Is there more of that that you’re planning to do or other projects?

*BM (0:52:28)*: Well, I still talk to mathematicians and give seminars, and ZuriHac in the next –

*AL (0:52:40)*: That’s soon, right?

*BM (0:52:42)*: It’s soon. Yeah.

*AL (0:52:43)*: So you will be at ZuriHac teaching category theory, right? 

*BM (0:52:47)*: Yes. 

*WS (0:52:49)*: But any goals on the horizon that you still want to achieve before you’d kind of definitely retire and give up on programming and mathematics?

*BM (0:53:01)*: There are always new things coming up. Every time you feel you are done, there’s something new. I started working on these optics, right? I mean, started, which is like, my original idea was, hey, there is this van Laarhoven lens, right? It’s so weird because it’s polymorphic in functors. And I had this feeling that this has to do something with the Yoneda lemma, right? But I couldn’t put my finger on it. And I was thinking about it, I don’t know, for a year or so, and to finally dawned on me. It’s like, okay, now I know how to do van Laarhoven lens. What’s next? Prism. Okay, how do you do prism? Oh my God, prism doesn’t have a van Laarhoven implementation, just profunctors. I had to learn everything about profunctors and coends, all this stuff. And eventually, I figured out, it was like, “Ah, great, now I understand.” And then traversals. Okay, what the heck are traversals? Do they have profunctor implementation? Yeah, they do. But how does it fit in with the Yoneda lemma and so on? And eventually, “Oh yeah, okay.” And it’s like every year or so, there is some new optic that comes up that does not fit this general picture. The latest thing was polynomial lens, polynomial functors and transformations between polynomial functors, natural transformation between polynomial functors. They didn’t fit. So I had to go into by categories in order to describe them.

*WS (0:55:04)*: Yeah, I have to think about that. Yeah, it’s not immediately obvious, I guess. To me at least.

*AL (0:55:12)*: All right. Yeah. Thank you so much for taking the time to talk to us.

*BM (0:55:17)*: All right. Thank you.

*WS (0:55:18)*: And yeah, it was great.

*AL (0:55:20)*: All the best for your projects.

*Narrator (0:55:28)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the support of our sponsors, especially the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and Meta.
