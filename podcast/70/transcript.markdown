*Mike Sperber (0:00:15)*: Hi, we’re the Haskell Interlude. I’m Mike Sperber, and Andres Löh and I sat down with Phil Wadler, one of the most influential folks in the Haskell community in functional programming and in programming languages, responsible for type classes, monads, and much more. We take a stroll down memory lane, starting from Haskell’s inception. We talk about the difference between research and Phil’s work on impactful industrial projects and standards, specifically XML and the design of generics in Java, as well as Phil’s teaching at the University of Edinburgh using Agda. Phil is a fountain of great ideas and stories, and this conversation could have gone on for hours. As it is, we hope you enjoy the hour that we had as much as we did.

So hi, Phil. Usually, we ask our guests what their first point of contact with Haskell was, but of course, you were there upon Haskell’s creation. So I guess we want to ask you what led up to Haskell, and how did you get involved in the whole effort?

*Phil Wadler (0:01:12)*: So before there was Haskell, we had Miranda, which we were all excited by, but Miranda was a commercial product, so not all of us could afford it. And that unfortunately didn’t make it a good basis for doing research. So Chalmers and Yale and at Oxford, I came up with something called Orwell, which was really quite similar to Miranda. There were quite a few different things. 

And then when I was on my way to ICFP in 1987, which I think was in Portland, if my memory is correct, somewhere on the West Coast, I stopped at the way at Paul Hudak to visit Paul Hudak. He mentioned that he had this idea that maybe we could all standardize together on a functional language, and Simon had already been through—Simon Peyton Jones—and he chatted with Simon about it. And so at the Portland meeting, we had a meeting of people who might be interested in doing this standardization, and there were many more there than we expected. And we went forward from there. We formed a mailing group. We discussed a lot in the mailing group. And then we had a first meeting. I think the first meeting was in New Haven, and the second was at Glasgow. Pretty sure I’ve got that right. You can look it up in the paper on the history of Haskell. I should have reread that before this meeting so I would get the details right. 

And early on in starting, we wrote to David Turner, and we said, “We’d really rather use Miranda. Would you be okay if we just tried adding features to Miranda?” And he said no. So we proceeded. And that was maybe fortunate because otherwise, I think we might never have come up with type classes, or it might have been a long time before those came around, and similarly for using monads for doing IO.

*Andres Löh (0:03:24)*: So was there anything that you specifically set out to do differently from Miranda then from the very beginning of this committee process that where you said, like, “This is one thing that we’re going to”?

*PW (0:03:36)*: Oh, that’s a very good question. No. So I think one thing that was on our minds is that we didn’t want to adhere – Miranda was a really great design, but we didn’t want to adhere to it too slavishly because potentially we would then get accused of plagiarism. So we saw ourselves as starting from the same place Miranda was, which is KRC is a very nice design. KRC was based on earlier things like ISWIM. So KRC was David Turner, ISWIM was Peter Landin, right? We’ve got that. That’s a given. We’ve got the type system of ML, which was relatively recent then, Robin Milner’s type system. We took that as a given. We want these two things. How do we combine them? And David had already found a very nice way of combining them. I don’t think we thought – well, we will pick a different solution than he picked, but we thought we’re not – we don’t want to pick something just because he picked it, because that wouldn’t be fair.

*MS (0:04:39)*: So I want to get into type classes a little bit more. So that was – I mean, do you remember at all what kind of drove you to do this major innovation over Miranda if the goal was mainly to sort of standardize something that could replace Miranda for research? 

*PW (0:04:57)*: So the key thing that we were aware of is most languages have both integers and floating-point numbers, and you need multiplication on both of these. So the current state of the art for Miranda was it didn’t have both integers and floating-point numbers. It just had a single type called ‘num.’ So all the numerical operations were on num, and you didn’t – it fell into the type system that SML already supported. For SML, they had integers and floating-point numbers as separate types, and they had separate operations on them. 

*AL (0:05:33)*: Yes. I remember that. 

*PW (0:05:35)*: Oh, sorry. I’m trying to remember this now. No, they had overloading, but even though there was a formal spec, the overloading was not in the formal spec. 

*MS (0:05:47)*: Okay.

*PW (0:05:48)*: It didn’t say in the formal spec how you should resolve the overloading. And there was this key issue, which is, say I define square of X is X times X, then I’d like to get square on both integers and floating points, and SML did not support that. And there seemed to be a real problem here, because what if I had something that took in three numbers and returned three squares? All of a sudden, instead of having the two versions of square, one for ints, one for floating point, I’m taking in three numbers and returning three squares, I’ve got eight versions. So, that was sort of the context of what we would like to do. As well, there were problems with equality and problems with printing things out. So there were multiple places where you wanted to have overloading.

*MS (0:06:49)*: So it seems the uses of type classes have gone way beyond sort of arithmetic overloading. Did you foresee that at all?

*PW (0:06:58)*: That’s true. But at the time, what was motivating us was arithmetic overloading doesn’t seem quite right. And I was talking to Joe Fasel one day, and Joe said something about, “Why don’t we just abstract over the necessary operation?” All of a sudden, I went, “Ah.” And the idea of type classes just sort of sprang into my head. 

What was really key to that was I was just learning at the time about propositions as types, which we all called Curry-Howard back then. And I suddenly realized that you could read these things either as sort of a logical statement or as a program in just the same way that Curry-Howard worked. So you could say, for every type that supports arithmetic, you can take a value of that type and return another value of that type, and that would be the square function. Or you could view it as something that actually takes the operation, takes the type A, parameterized over A, but then you take a dictionary saying, giving you all the operations over A.

*AL (0:08:14)*: So you’re saying the idea of using this dictionary passing as an implementation technique was also there from the very moment of inception, essentially? 

*PW (0:08:27)*: Yes. I think that was sort of the key insight was aha, this has both a declarative reading and an actual implementation reading, and they’re both useful, and they’re both very close to each other. So that was the key insight that brought it into being. And I had a student. Steve Blot was a PhD student, and we worked together, and he did all of the metatheory. Of course, back then we were just – it was just all typeset and LaTeX, right? There were no proof of assistance to check this out in. Even from the original paper, I had noticed that the type class gave you something that you could put properties of these operators into. So that was very important to me, that if you had a type class for numbers, which operations times and plus, you could put into your documentation that plus was supposed to be associative and commutative and distribute over times and so on. This actually gave you a way to proceed because it said, “Okay, this is in the documentation. Every time I write an instance, I should check that this is true.” So it gave you a methodology for working with these things, and that was quite important to me as part of the definition, I think.

*AL (0:09:43)*: Now that you’re bringing this up yourself, I mean, like, the sort of design of the numeric classes in Haskell is definitely a matter of some controversy. And given that you’re saying that actually, well, the realization that you could potentially put properties into the classes and talk about the lawfulness of classes from the very beginning, why then was the decision being made to just use a single num class to throw together all sorts of operations already rather than taking a more mathematical approach, perhaps, and actually, I don’t know, splitting the additive and the multiplicative structure into different class?

*PW (0:10:28)*: Right. So I was surprised. Right. I thought you were – when you said it’s controversial that you’re going to say you made it too complicated, and instead you’re saying you made it too simple. You should have broken it into even more parts. But that’s not fair because, of course, breaking it into more parts might have been simpler.

*AL (0:10:45)*: Yeah. Yeah. I mean, it’s always the viewpoint you’re taking. Some people would argue that by choosing a single type class, you’re actually making it more complicated.

*PW (0:10:56)*: So it became clear pretty early on that one of the defects of type classes is that you could make bigger ones later on, you could clump things together, but you couldn’t pull apart something that you had. You couldn’t retroactively factor something. And that was obviously a shortcoming. And I never could figure out a way of dealing with that. I think you have many much more flexible successors now. And if I think about how it’s done in Agda, for instance, I don’t think it’s easy to retroactively do the factoring there. Well, it’s more flexible. So you could introduce a factored one and then maybe prove its relationship to the unfactored one. But no, I’m not even sure that the modern designs do well at this retroactive factoring. What is true is that nowadays we understand, oh, you might want plus separately or times separately or whatnot. So if you look at something like Lean, there’s one type class for each of these. In fact, the type class is very syntactic. Despite Lean being all about mathematics, the type class for times is just this is the thing for which you use the symbol times. And for pluses, this is the thing for which you use the symbol plus. And then they layer many, many other things on top of that. But the basic thing is just purely syntactic. 

*MS (0:12:25)*: Well, I thought that the two of you were going to say something different about the design of the type classes, right? So I was involved in the design of the Scheme programming languages, which has a numeric tower, which kind of works in ways that are similar to the Haskell type classes. And I would say the problem with the numbers is that there’s instances of the num type class that don’t obey the laws that you’re interested in, right? The floating-point arithmetic doesn’t have associativity or things like that, right? So unfortunately, the type of the numbers influences the semantics of the operations. I think that’s a fundamental mistake.

*AL (0:12:59)*: Well, that’s related to our point because I mean, the more operations you put into a class in the first place, the harder it becomes to find any instance that actually observes all the desired properties, right? And I think floating-point numbers are indeed an interesting additional item, right? Because they’re weird in many ways. And you can argue that they don’t actually have all the properties that you would associate if you look at the class like from a mathematical view.

*MS (0:13:33)*: So, I mean, it’s kind of unusual to put a new design into a programming language standard like right from the beginning, right? Usually, a lot of programming languages kind of favor an approach where you first experiment and gain experience with a new feature for a long time before you put it in the standard. But there it was there from the very beginning. Were you very confident that it would work out the way it ended up working out?

*PW (0:13:59)*: I think we were confident that the existing solutions all had shortcomings. And so we wanted to try out this new solution, which seemed like a good idea. You’re getting very close to what you’re saying, quoting Tony Hoare’s paper, Hints on Programming Language Design, where he says exactly that. He says you should first design features and then assemble a good collection of features into a programming language. But indeed, we violated that here because we didn’t know of a good solution that we could just take off the shelf.

*MS (0:14:37)*: Okay. So eventually, I don’t know what your journey was like from there to the – I mean, monads were not there in the beginning in Haskell, right? That was clearly something that was needed.

*PW (0:14:47)*: So monads is a separate thing. Before we finish with type classes, I think there’s some important things to stress. So my original design was way too simple. And I’m saying that to pat myself on the back rather than to criticize myself. I think that it was really important to the success of type classes that the original design was way too simple because it meant that other people could absorb it and work with it. And the most important thing I did with type classes was inspire Mark Jones. And then Mark Jones figured out. So I thought type classes would just be abstracting over types, but Mark Jones figured out how to make this abstract over type constructors. I figured that’s impossible because to do that, you would have to unify higher-order constructors, and you had to prove that was undecidable. But Mark Jones showed how, despite this being an undecidable problem, you could do something really useful. So Mark made an incredibly important contribution by figuring out how to make these things higher order, and he also generalized them to talking about not type classes but just sort of arbitrary evidence that you passed in for these things, generalizing the whole Curry-Howard idea that underlined it. 

*AL (0:16:10)*: Can you remind me, just like were the higher kinds, were they in Haskell from the very beginning, or were they introduced at the same time when the constructor classes –

*PW (0:16:22)*: Oh, no, no, no, no.

*AL (0:16:23)*: Okay. 

*PW (0:16:23)*: No. If you look at the first one, it was just – and the very first one, type classes were over one type, not over multiple types. If you look at the paper, it says you could do it over multiple types, but we’re not going to. And again, that was part of making it too simple, but I think that was really important for getting started. And then Mark Jones separately did three different innovations. He did this generalization to arbitrary evidence, which was his PhD thesis. And then after that, I think it was after his PhD, he came up with the idea of type classes over constructors. And then after that, he came up with the idea of the type dependencies, which he stole from work on databases. And all three of those were important innovations.

*AL (0:17:15)*: But even the parametric polymorphism over constructors was only introduced for the type classes. So you couldn’t abstract over something of kind star to star prior.

*PW (0:17:27)*: Oh, right. So now in Haskell, of course, you can.

*AL (0:17:30)*: Oh yeah. That was my question, whether that was sort of motivated by the constructor classes and done at the same time, or whether that already existed. 

*PW (0:17:40)*: Ooh. I don’t remember. I would have to go back and look. It might have been that the constructor classes were what then motivated us to have as the basis, as it were, F-omega rather than F. But this time I was so ignorant. I wasn’t familiar with F or with F-omega. But fortunately, Jan Fairbairn educated me about these things, and we eventually realized that, oh, we can build the compiler around F-omega as the core language. The main contribution I made to the Haskell compiler was all Simon Peyton Jones’ work. I was the one who said, “Let’s use F-omega as the core language.” It might have been I start by saying F, and then later, because of the constructor classes, we went to F-omega. I don’t remember that bit of the history. I was very proud of saying that. And that’s survived to this day in the core language for GHC.

*AL (0:18:38)*: Yeah, absolutely. Yeah.

*MS (0:18:40)*: Two notes here, maybe, right, is that Mark Jones created his own sort of variant of Haskell back in the day called Gofer, which not everybody might remember –

*PW (0:18:49)*: Right.

*MS (0:18:50)*: – which had these constructor classes and for a long time was sort of the funky version of Haskell that you could play with for more experimental and speculative ideas. I also vaguely remember that Gofer would parse Miranda programs so that you could still take those old programs and have them interoperate. 

The other one is that I think the simplicity, the point was simplicity, is well taken, right? When multi-parameter type classes were added, the actual design for type inference with them turned out to be much more thorny than it would intuitively seem. And I remember for the longest time, there was no – I think I really didn’t have much contact with GHC back in the day. But I noticed at some point that the actual behavior of GHC did not correspond with any of the papers and was undocumented at the time. And this was definitely after 2000, after the year 2000. 

But ultimately, you would need constructor classes to do monads. Maybe this is the point where we segue to monads, but maybe there’s still more stuff in between, Phil.

*PW (0:19:57)*: Well, I think I’m trying to remember now whether we already had type classes generalized over type constructors at the time that I started playing with monads. If not, it came in fairly quickly, and it was really important because it meant you could use many different monads at the time, which was an important thing to be able to do. So certainly, that innovation of Mark was very important to the success of monads as an idea.

So at the time, the important thing that monads were first used for was doing input/output, doing side effects. And we saw the side effects in general, but the important one was input/output. And the approach at that time was you would output a stream of requests and input a stream of responses to those requests.

*AL (0:20:57)*: Yeah, basically, I think what a function interact is still offering in the Prelude these days, right, where you have like a string-to-string type, and you get standard in, in, and you get standard out, out, and you can lazily consume the input and produce output. And I think that was the original approach prior to monadic IO, right?

*PW (0:21:19)*: Eugenio published this paper, and I thought, “Oh, that’s kind of interesting.” I remember going across from Glasgow to Edinburgh to talk to Eugenio and then coming back and going, “Okay, that’s quite useful,” and writing it up. So the idea was just he was using it as a way of factoring denotational semantics. And I just went, “Oh, we could use it as a way of factoring arbitrary programs.” But in fact, the first example I used was factoring an interpreter, which is very, very close indeed to factoring a denotational semantics. And we quickly found it very useful in the compiler. So each pass had its own monad. And one of the early papers on monads, the one I wrote as a tutorial for POPL, described that towards the end of it. The tutorial was very funny. I had submitted that to POPL as a paper, and they rejected it. They said, “There’s not enough original here,” because I actually published other papers on monads before. But then they invited me to give a talk, and I said, “Oh, can I publish this paper to accompany the talk?” And they said, “Okay.”

*AL (0:22:33)*: Yeah.

*PW (0:22:34)*: So that sort of became the first monad tutorial, right? I don’t know if you recall at the time, but there was sort of a – for a while, there was this sort of cottage industry of generating monad tutorials. On the one hand, I thought, “This is fantastic. Lots of people find this useful, and they’re trying to explain to other people.” On the other hand, I thought, “I wish some of these tutorials would be better than the original.” I thought almost all of them were not. Some of them were, but almost all of them were not. And they tended to go abstract too quickly. And I’ve always thought the best way to explain something is with examples. And this paper that I did for POPL was just a bunch of examples. You might want an interpreter that – I wrote various interpreters. Here’s a straightforward interpreter. Here’s a straight interpreter that also counts the number of times you apply the divide operation. Here’s an interpreter that gives you an error if you divide by zero. So the one of counting the number of divide operations, it did that with state. I mean, there are other ways of doing it, but it did that with state. 

Oh, and here’s one of the places where you can print out a trace of what you’ve done. So it was output, state, and errors were the three examples I used. And the order of errors came first, state came second, and output came third. So I said, “Here are three different interpreters.” And they’re all very easy to do, but you have to rewrite your code every time. I said, “Okay, if we factor this as a monad, now you can leave the code the same or maybe change one line, but change the definition of the monad.” That was the key point of that early paper.

*MS (0:24:16)*: I remember I shared the office with Peter Thiemann at the time, and when that paper came in, that was life-changing. There’s very few papers that come in. You read them when you immediate – I mean, we immediately both thought, “This is big. This is going to make a big difference in the way that we program.” And that certainly turned out to be true. Yeah.

*AL (0:24:38)*: Yeah. For me, it was also one of the first papers I read about Haskell. But I nevertheless wonder, like at the time, with the language, with a big committee behind it, like such a drastic change. I think it happened between 1.2 and 1.3, right? Haskell 1.3 introduced both constructor classes on monadic IO.

*PW (0:25:06)*: Something like that. 

*AL (0:25:07)*: Was that controversial at all, or was everybody saying, “Hooray, this is solving our problem; we are perfectly happy with it”?

*PW (0:25:14)*: I don’t remember a lot of controversy at the time. So I guess it was more the latter.

*AL (0:25:19)*: Yeah. Okay. That’s great. 

*MS (0:25:22)*: I mean, that was certainly something that there was no existing solution tool, right, is how to do IO in a lazy language. 

*AL (0:25:29)*: Yeah, yeah. I mean, the previous solution was certainly quite unsatisfactory, and I can imagine that. But it’s nevertheless, I mean, that, yeah, it’s a massive rewrite of everything in a way. But yeah, no, I think it’s good. 

*MS (0:25:42)*: So yeah, arguably Haskell still is that way, right? That it keeps changing. They keep changing it, and the committee –

*AL (0:25:49)*: Well –

*MS (0:25:50)*: – just says whatever.

*PW (0:25:53)*: Well, the other lot that changes are sort of just Simon, the two Simons, and whoever else they’re working with. They will just plug ahead very quickly. There is a Haskell committee, but that’s sort of lagging along behind, standardizing some of the features that they put in, but not all of them.

*AL (0:26:11)*: What about the syntax of the bind operator? The greater greater equals? Who invented that?

*PW (0:26:18)*: Oh. So that was –

*MS (0:26:21)*: That was Andy Gordon, right? 

*PW (0:26:22)*: – Andy Gordon.

*AL (0:26:23)*: Oh, okay.

*MS (0:26:24)*: Andy Gordon said –

*AL (0:26:25)*: Okay, okay.

*MS (0:26:25)*: – claimed it was his invention. Yeah. 

*PW (0:26:28)*: So several people hit independently on the idea of using monads. So there was Eugenio’s paper, and then I took it from there. Mike Spivey wrote a paper on using monads for error handling. I don’t think he generalized it beyond that. And I can’t recall whether he got that from Eugenio or did it independently. And then Andy Pitts at Cambridge said, “Oh, these monads are a good idea.” I don’t think he got it from me. I think he got it from Eugenio directly. And Andy Gordon was his student. So they were actually using this for IO that would, I think, drive a microscope where they were programmed, doing stuff in the real world. And that was all independently of what I’d done. It was actually Andy Gordon who’d introduced the greater than greater than equal for the monad. I’d been using just a star symbol –

*AL (0:27:34)*: Yeah.

*PW (0:27:35)*: – which didn’t work well in ASCII. 

*AL (0:27:37)*: I do remember that from the papers. 

*PW (0:27:39)*: So nowadays that would be fine because we knew everything in Unicode. But back then, we were doing everything in ASCII. So star was a poor choice. And when we saw it, Andy went, “Oh, yeah, that’s great. Let’s use that.”

*MS (0:27:53)*: So that was monads. So eventually, you kind of moved out of the Haskell community. Was that after monads, or do you have more stuff going on after that?

*PW (0:28:05)*: I never moved out of the Haskell community. But I was at Glasgow from ‘87 to ‘96. And then at ‘96, I moved to working with Bell Labs in the US. So I went from academia to industry and from Scotland to New Jersey. And so I started doing other things around then. Richard was writing the second edition of Bird and Wadler, and I contributed a pretty printer to that, which then ended up in the Bird Festschrift as the paper Prettier Printer, which lots of people adopted. So I was very pleased with that. 

And I started working with XML because that seemed something useful to Bell Labs. So I was involved with XML. And then I got involved with the Java community, where we ended up designing Featherweight Java, and then the work on adding generics to Java, which I did with Martin Odersky, and which was an early version of Scala, basically.

*AL (0:29:24)*: Right, right. I think there was a succession of languages, right? If I remember this correctly, the first was Pizza, actually. Is that right? And then generic Java, and then was the actual addition of generics into Java. And Pizza was, if I remember correctly from those days, actually much more ambitious, even, and had all sorts of functional programming features that in the end didn’t make it into Java. Do I remember correctly, or am I just hallucinating? 

*PW (0:29:54)*: So actually, I should probably go back further.

*MS (0:29:57)*: Yeah, yeah.

*PW (0:29:58)*: And say how I start collaborating with Martin.

*MS (0:30:01)*: I was going to ask about that. Yeah.

*PW (0:30:03)*: So I was just visiting in Karlsruhe, and I’ve been trying to think about how do you formally model small-step call-by-need. So John Launchbury had written a paper on here’s how you model big-step call-by-need. And I was thinking, “Well, how do you do it small-step?” And I was describing informally the problem about, well, you need to just be changing one thing in the context. I’m not quite sure how you do this. And Martin had written on his – I can’t remember whether it was a whiteboard or blackboard, but he had written on his board the solution to the problem. He’d been working on it with his student, John Maraist. So I joined with them, and then we wrote a paper on call-by-need. And at the same time, Matthias Felleisen and Zena Ariola had written a paper with exactly the same idea. So we submitted these two to POPL, and they said, “Oh, these are both the same paper.” So instead of accepting the two papers separately and publishing them side by side, which is what they should have done, they made us publish one paper with all five names on it and trying to collaborate to get that to happen. 

As you can imagine, if you put me and Matthias in the same room, it didn’t always work very well. But I think we came out of that with – well, I came out of it with huge respect for Matthias, and we got along much better after that. And one thing that I always really respected him for is after we had the paper done and we’d agreed on the rules that were in it, and I would describe everything and so on, we then had to decide who’s going to present it at POPL. And even though we’d had these huge fights, Matthias said, “Right. John is the youngest one. He should do it.” And I thought that was incredibly noble of him and very principled. So I came out of that process with a lot of respect for Matthias. But I still wish that the POPL committee had just let us publish two papers side by side. I think that would have been a better way of dealing with it. 

*MS (0:32:24)*: Same title. So was it still difficult to see how – how did you then go from there to the work with Martin on sort of Java, Featherweight Java, Pizza, that whole group of things?

*PW (0:32:39)*: Right. So Java was quite new then, and it was pretty clear that it was going to become a really big deal. I mean, one way of describing just how big a deal it became was – so around this time, the movie Independence Day came out. I don’t know if either of you are familiar with that movie? 

*AL (0:33:03)*: Yes. 

*MS (0:33:03)*: It’s German director, Classic German movie. Of course. 

*PW (0:33:08)*: So there’s a scene in that where the aliens come and they destroy the entire Empire State. And this was fantasy back then, right? This was ‘96 or ‘97, I think. So this was before the World Trade Center. So we just thought, “Oh, destroy all the big buildings in New York. That’s a lot of fun.” And the way that the aliens were defeated was exactly like in War of the Worlds, where the Martians were defeated. The Martians were defeated by catching a virus. And in this, the aliens were defeated when they were given a computer virus. 

So there’s one scene, I did a little screen grab of it, where Jeff Goldblum is typing the computer virus into the machine. So apparently the alien machines know ASCII, and even more than this, it was a language written with open and closed curly braces. And the way I described this is I said, “Well, this was obviously C.” And I was very pleased because working at Bell Labs. So here was something that a guy down the hall for me had done, and it was on a screen in a big science fiction movie. And how did I know it was C and not Java? Well, this was ‘96. This was before Java had spread throughout the known universe. But very quickly, right, Java just became enormously popular. 

Up to them, we thought, right, functional programming is going to win because that’s all these great ideas like garbage collection. All of a sudden, Java comes along, and it’s like, “Oh, maybe we’re not going to win. Maybe it’s going to be Java that win,” which is basically true. But we were thinking, “We know stuff on top of this. What can we contribute to this?” 

So Martin I would go and stay with friends over New Year’s in California, but we would all rent a house in a place called Pajaro Dunes, and Martin happened to be there. So I invited him. And we were walking along the beach at Pajaro Dunes, and we said, “What do we do next?” And we came up with, we said, “Okay, well, you could have Java, but you could also have some of product data types, and you could also have parametric polymorphism.” And so that’s what Pizza was. 

And then Guy Steele and Corky Cartwright had this idea for adding generics into Java. We had a somewhat different way of doing it in Pizza. And so we discussed it together. And the important thing there was to have backward compatibility. Together we came up with a design that supported backward compatibility by doing this via erasure, by not passing around any runtime type information. So that was a very important choice, but it enabled this backward compatibility. So it was a lot of fun working on that. 

And then around that time, because Java was becoming so popular, I was having a chat with Benjamin Pierce, where I said, “There are all these different models of object-oriented systems, but they don’t look like the way Java does it. Could we do a model that does it the way Java does it?” And then Benjamin came up with this great idea of saying, “Actually, you don’t need to model assignment in Java at all. You could just model objects and method calls.” And so that turned into Featherweight Java. And then he brought in his student, Atsushi Igarashi, to help with the modeling. So that became my most cited paper. 

And at the time, there are a lot of people trying to do very complete formal models of Java. So we were going against the trend, and we wanted to do the least complete model possible, the simplest model possible. Both of those turned out to be important. But if you look at the citations, there are more citations for our paper than for any of the more complete models. And I think that just shows the value of simplicity because it gave a very simple model that people could build on top of. When they added a feature to Java, they would show how to model it in Featherweight Java. And then indeed, that’s what we did. The generics were new at the time. So we showed how to model the generics in Featherweight Java. 

And then somebody came back much, much later, and, right, some bugs were discovered in the Java design. And so they said, “Look, you didn’t find those bugs because they had to do with arrays, and you weren’t modeling arrays.” So it’s very important to be complete. And yeah, that is one of the advantages of being complete, is that you’ll catch more, you have the opportunity to catch errors in the design that otherwise you might not catch because they don’t appear in your simplified model. So I would never ever say that there’s no value in the more complete models. But some people really seem to think, “Oh, we just want the more complete models.” And I think that’s not true. I think you definitely want the simpler models as well, that they each have their place.

*MS (0:38:11)*: So I wonder, I mean, to this day, I guess, arguably Java is, compared to Haskell, kind of the lesser language, right? It’s still catching up in a lot of areas. And so not only did you spend a lot of time on the lesser language, but also, I mean, you took your ideas all the way into production of Java, right? Did that come out of a desire to have a stronger impact than with Haskell, or wasn’t that tedious at all?

*PW (0:38:39)*: It came out of a desire to have impact. The work I did on XML was – which involved a formal standardization group in the W3C, that was just way more tedious than anything that I did with Java, but they both came out of a desire to have some real-world impact. Because it was a standard, XML was quite complicated. So I definitely had the impact on the standard, but whether the standard was a good thing for the world or a bad thing for the world, I’m not sure, right? Obviously, things like JSON that cover similar stuff have been much more successful than XML because they were simpler.

Yeah, I failed. And that’s an argument in favor of simplicity. I wasn’t simple enough there. I should have aimed to be too simple, and I didn’t succeed at being too simple. JSON did, and it won.

*AL (0:39:31)*: Also not clear whether people would have seen the value of JSON in the same way as they did if XML hadn’t come before. Sometimes you have to suffer from something that is complicated to really appreciate the simplicity afterwards.

*PW (0:39:49)*: That’s possible. While we’re talking about object-oriented programming, I should probably go back to type classes, but of course, one – we didn’t touch on the fact that I called them type classes deliberately as a provocation, saying this is an alternative to the way that the object-oriented people work.

*AL (0:40:09)*: I see.

*PW (0:40:09)*: So right, they had what was called subtyping polymorphism.

*AL (0:40:13)*: Uh-huh.

*PW (0:40:14)*: And this was basically saying, “No, don’t do it with subtyping polymorphism, do it with parametric polymorphism.” And in particular, in the object-oriented community, there’s a lot of worry about what was called the binary methods problem. So objects give you an easy form of, as it were, overloading, as you can use the same method name with many different objects that would have different meanings. So it would be very easy to have a method square that did one thing on integers and did something else on floating-point numbers. But if you had something that wanted to take in two numbers and combine them, they would both have to be of the same type. 

So there was this problem in the object-oriented community. It’s very easy to write plus that would do four different things, but not so easy to write a plus that would say, “I’m fine if you give me two integers, I’m fine if you give me two floats, but I don’t want an integer to float.” So that was called the binary methods problem, and there were many different potential solutions to it going around. And that just didn’t arise with type classes. So that was one of the things I thought was significant about type classes, was that they let you do a lot of the things that you were doing with object-oriented programming, but using parametric polymorphism rather than subtyping polymorphism. And the big win in parametric polymorphism is you didn’t get this binary methods problem.

*AL (0:41:41)*: So if type classes was the provocative name, did you originally have like work on this or think about this with a different name, and then you specifically switched to provoke or –

*PW (0:41:53)*: Ooh. No, I think that the analogies were always there, and we always use the word “dictionary,” which clearly set up the analogy to what was going on in object-oriented programming.

*AL (0:42:07)*: Yeah. So I guess in more recent years, you’ve been doing quite a bit of stuff with Agda. How did that language catch your interest, and why Agda and not any of the other independently typed languages?

*MS (0:42:28)*: Of the many other development language?

*AL (0:42:30)*: Well, I mean, there are a few. I mean –

*MS (0:42:33)*: Yeah. 

*PW (0:42:35)*: So at Edinburgh for many years, we had a class called Types and Semantics of Programming Languages, and other colleagues taught that for many years. And then I started teaching it. And at the time, it was taught from Benjamin Pierce’s books, Types and Programming Languages, TAPL. And at some point, Benjamin came up with this idea. He has a lovely talk at ICFP called Lambda, the Ultimate TA, a name based on the names Guy Steele had used earlier for Lambda: The Ultimate and a series of papers he’d written. And the idea was, well, if we get people to do this in a proof assistant, then they will get immediate feedback on what is a theorem and what is not a theorem, which is something that students always have difficulty understanding, and understanding exactly how induction works, and so on. He pointed out that this is actually a huge amount of work. And he wrote the first edition of Software Foundations on the fly as he was teaching the class, and he would talk about how sometimes he didn’t complete the code until two minutes before the class was to begin. He wasn’t quite sure if he’d be able to teach the class that day or not. So I found this compelling. 

So I switched to using Software Foundations, and I taught from that for a few years. And one of the nice things about being at Edinburgh is you’re surrounded by lots of clever people. So both James McKinna and Conor McBride had come through Edinburgh, and they were part of the community. And so Conor came over and gave this lecture about Agda, and I thought, “Oh, that is so beautiful.” I started thinking, “Oh, wouldn’t it be so much nicer doing this in Agda than in what was then called Coq?” 

And there were many things that struck me. One of the very nice things was the way in which it used mixfix notation. So Haskell had good support for infix, but not for mixfix. But Agda had excellent support for mixfix notation. That was partly because Aarne Ranta was at Chalmers when they came up with it. And he had designed this very nice general-purpose parser implemented in Haskell, among other things. So they just adopted that so that they could parse arbitrary grammars, and so they could support adding arbitrary mixfix constructs. And then they had this beautiful way of naming them, which is you would just put an underbar where the argument was. So in Haskell, following an idea of Richard Bird, we wrote open parenthesis plus close parenthesis with a plus operation on its own. Whereas in Agda, you wrote underbar plus underbar, which would then generalize to prefix or postfix or mixfix or what have you. I just thought that was so beautiful. 

So on the one hand, there were the dependent types, which were far more expressive. On the other hand, the actual syntax itself was much nicer. So I worked around telling my students that Agda is what Haskell wanted to be when it grew up. 

*AL (0:45:49)*: Yeah, yeah. In many ways, it’s taken quite a few things from Haskell and made them better, I would agree.

*PW (0:46:00)*: So what is your favorite thing that Agda made better?

*AL (0:46:03)*: I mean, actually, I think the syntactic aspects I really like as well. I mean, I think that this is just a very clean generalization of it. But I’m also really fond of the module system, for example, in Agda. It’s really sort of – it’s not going completely overboard, but you have like parameterized modules and the sort of abstraction over modules and can instantiate them. And I think that’s also rather nice. 

*PW (0:46:34)*: That’s true. So I’ve been teaching from Benjamin’s book, and my first idea was that I would just take all the Coq text that was in Software Foundations and just do a version of Software Foundations where the Coq was replaced with Agda. And so around that time, I did an experiment. So Agda doesn’t have tacticals, and I had no idea if this could work or not. I thought maybe all the proofs would just get way too complicated. So I took what I thought was the key proof, which was preservation and progress for simply typed lambda calculus, and I sat down and redid that in Agda. I was just learning Agda, so it took me a couple of days, and I was very fortunate. I could go to Conor or to James when I had questions. I had Wen Kokke was my student, and she knew Agda, so she helped me out a lot. I had all these people. I had no idea how Agda worked. I had all these people around me who could educate me. 

So it took me a fair time to transcribe this very simple proof. But when it was done, I discovered – I went back to the book, and there’s one point at which the development gets complicated because of the way that induction works in Coq. And in order to make the induction work, you had to formulate it in this particular way. I formulated it in another way that was more natural, and it was fine because I wasn’t using an induction tactic. I was just writing it out. 

So I discovered that it worked out actually much more easily in Agda than in Coq, and it was about the same length. And the thing is, if you try to read the proof written with tacticals in Agda, the only way to do that is to execute it interactively in Coq, whereas if it’s written in Agda, you can just read the actual code. So I thought pedagogically, this is far superior because you could just look at it, and the students could read it. 

And at that point, I thought, okay, I’ll start. So I began. So then I looked at the first chapter. I thought, “Okay, how would I translate this?” I quickly realized, “I don’t think this is the right approach.” I realized I didn’t really like Software Foundations for the way in which it approached the material. So it just begins by saying, “Here are some various data types like days of the week and so on.” And I thought that this is quite ad hoc. It’d be nice to begin with something important like the natural numbers. 

So I very quickly realized – so by the way, I think Benjamin is an amazing writer. TAPL is a very well-written book. I told you the story about how he had to write software foundations on the fly. Of course, they went back and published it later, but I think it still shows some of that being written on the fly. I don’t think it’s nearly Software Foundations as a bit of literature. I don’t think it’s nearly as good as TAPL. 

*AL (0:49:50)*: Yeah. I mean, my take on this particular point, like the weekday examples and so on, I don’t know whether that is right at all, but my feeling was always that this is probably coming from the fact that the context of having Roc as a language is that it’s much less seen as a programming language, but basically by taking sort of a real-world example and not a mathematical example like weekdays or something like that, you show more like, oh, despite this being a proof assistant first and foremost, it is actually a language where you can use normal data types and write normal programs. I think that is perhaps a case that you don’t need to make for Agda, which always positioned itself as a programming language in which you can also do proofs, right? Perhaps it’s just a difference due to the technology.

*PW (0:50:53)*: Possibly. Certainly, I think one thing that helped me is that in the first-year course at Edinburgh, we taught them Haskell. Agda looks a lot like Haskell, so this was a fourth-year course, but the fact that I could depend on them knowing Haskell, I mean, a lot of them would have forgotten it in the interim. Nothing was presented as if this is the same feature as Haskell. It was all presented from first principles, but I knew it would look familiar to a lot of them. And I think that gave me a basis that I could build upon. That helped me as well.

And then this was in – I decided I’ll do this in 2017. In 2017, I convinced myself, “Okay, I can do this proof of progress and preservation, so I probably can do the book.” And somewhere in there, I started to translate the first chapter of Software Foundations and went, “No, I don’t want to do this. It would be much better to start with natural numbers.” 

And that year – so a few years before, I separated from my previous wife. I had been on my own for quite a few years at that point, and I met the woman who’s now my wife, Wanda, who had been visiting in Edinburgh from Rio de Janeiro. And we just instantly clicked. And so that completely changed my life around. And the first year, we could just see each other occasionally because she was working as a schoolteacher in Rio. I was working as a professor in Edinburgh.

And then finally, January 2018 came along. I didn’t need to teach for six months. So I just arranged to go to Yale for six months. And my school was very supportive about this. They said, “Yeah, you don’t need to be here to teach. Fine. You can go.” And my head of department came back the next day and said, “Actually, that might look bad. You’ve earned up enough time for six months of sabbatical, so we’ll give you your sabbatical early.” So I had a sabbatical. And that was very helpful because I didn’t feel I had to focus on everything that was back in Edinburgh. 

And so I managed to just – I was deliriously happy because Wanda and I were in the same place together. I was visiting her in Rio. And I just sat at the dining room table with my laptop and managed to write the book in six months. I remember the big technical thing, which was in Software Foundations, they use a tactic to do lambda reduction. You could actually type a lambda term, which would show you the steps it would take in reducing. But that used tacticals, and I didn’t have tactics available. 

There’s another system called the K system, where you would just give a bunch of reduction rules that would do the reduction for you. So it was a system for writing out reduction rules, and I was familiar with it because Grigore Rosu, the developer of that system, was consulting for IOHK, which I was also consulting for. So I got exposed to that. 

So I liked this idea that you could just write the reduction rules and execute them, but I said I had KNV, and there was also systems like REDUCE for Racket that would let you do the same thing. So I thought, “How can I keep up with all these different systems? What am I going to do?” And it was months and months before I realized it was completely obvious that if you have a constructive proof of preservation and progress, that actually tells you how to reduce the term. That’s why preservation and progress is so interesting, is because they give you a constructive way of reducing the term, but I didn’t see that for months and months. 

And indeed, after I saw it, I went to the literature and tried to find evidence that other people had seen it. And people did know it. Like Bob Harper knew this, but it’s not in his textbook. And I asked him, “This is really nice.” He has a nice, even way of describing it. He describes it as a pas de deux between preservation and progress, where they each – right, because how do you do this? You use progress to work out that you can do a reduction step, and then you use preservation to work out that you’ve reduced a term of the same type, which means you’ve got type terms. You can go back to progress again. 

And so Bob has this wonderful way of describing it, but it’s not in his textbook. I went looking. I couldn’t find it. And I finally said, “Why isn’t this in your textbook?” And he wrote back to me, “Would you put two plus two equals four in your textbook?”

*MS (0:55:59)*: That sounds like Bob Harper. Yeah.

*PW (0:56:05)*: And of course, in fact, I do put two plus two equals four in my textbook. That’s the main example. They do the same in Principia Mathematica. It’s actually one plus one equals two. And I’ve never been able to find this quote again, but when they do that example in Principia Mathematica, at that point they say, “You might think it’s a negative point of our approach that we don’t get around to doing this until page 520 or whatever.” It’s expressed much more elegantly than that, of course. So I’d like to recover that quotation, but I’ve never found it again. Maybe somebody listening to this podcast will know exactly on which page of Principia Mathematica you can find that quotation and will let me know. 

*AL (0:56:50)*: Yeah. So we should probably come to an end, but there is one thing that is completely unrelated to everything else but that I still also wanted to use the opportunity to ask, and that is, if you’re willing to share, what is the origin story of Lambdaman? Like, when did you have that idea for the first time, and how did it evolve into this thing that you basically do every single time?

*PW (0:57:18)*: It’s Bob Tennent’s fault. So there was a meeting of MFPS in Oxford, Mathematical Foundations of Program Semantics, and I had given a talk about linear logic. And at the time, I enjoyed – they had these little pens that would give you a thin stream of plastic, and you could use it to draw pictures on shirts or sweatshirts. So I had a sweatshirt that had the diagram for a Cartesian closed category on the front and the inference rules for simply typed lambda calculus on the back. And I worked on that very carefully. I was very proud of it. And then eventually, I did another T-shirt that had the rules for a monoidal closed category. Actually, no, it was the rules for Cling as a comonad in linear logic on the front. 

So I’d start my talk by wearing the category theory shirt, and I’d say, “We’re going to factor this to get linear logic.” I’d pull it off and show that underneath I had the linear logic shirt. I used this in various ways. So at the time, the categorical model of linear logic that everybody used was due to Robert Seely. And so one time, rather than me wearing this T-shirt, I got him to wear the T-shirt, and I said, “We have a Seely model.” And Seely walked on stage as if he were on a catwalk and did a little twirl and went off. He did a brilliant job with it, and everybody really enjoyed that. 

So I was into doing these various things. So at this time, I had been wearing a sweatshirt on top, and I pulled it off at some point to show the T-shirt underneath. I always had to be careful when I did that. I did this several times. And at least one time, right, the T-shirt came off with me and ended up with my hairy chest showing, which was – I think somebody said, “Oh, it’s very hairy.” 

But anyhow, after having done this, we were sitting outside having a beer at a pub, and Bob Tennent said, “Oh, when you did that, it was almost like when Clark Kent pulls off his T-shirt.” And I said, “Oh, there is an idea.” And I had a shirt that was just snaps, so it’d be very easy to just go, “Oh.” And so I made a – I had a colleague at Edinburgh at the time, Matija, and he and his wife, I got them to design. I said, “I want something that looks like the Superman sigil but is a lambda.” And we went back and forth through this several times. They were kind enough to do this and were paid a tiny amount of money for this work. But that’s where the symbol comes from. Actually, it was my idea, and they did the design, and that got printed up at a local place. And this has turned out to be immensely popular.

*AL (1:00:29)*: Yeah.

*MS (1:00:30)*: I’ve got one as well.

*PW (1:00:34)*: It’s just a T-shirt. And then eventually I had a whole Superman costume where I pasted the new logo over it.

*AL (1:00:42)*: Nice, okay. 

*MS (1:00:44)*: Excellent. 

*AL (1:00:45)*: Yeah.

*PW (1:00:45)*: It’s been a lot of fun. And then when I was six years old, they did a festschrift for me. And my colleague, Hugh Leather, got his wife, Janne, to draw a whole Lambdaman comic, which is actually printed in the festschrift.

*MS (1:01:04)*: Ah, okay. 

*PW (1:01:06)*: That was a lot of fun. And it’s been nice. It’s something that audiences really react to. So it’s been wonderful for me as a communication tool, and it’s nice that it’s turned into a communication tool for other people as well. There’s somebody else who’s now Lambda Spider-Man, and so on. He got a Lambda Spider-Man tattoo, which is farther than I would go.

*MS (1:01:28)*: Yeah. So that certainly resonates. Thank you so much, Phil. This was a lot of fun. 

*AL (1:01:35)*: Yeah. Yeah. Thank you. 

*PW (1:01:37)*: Oh, thank you.

*Narrator (1:01:39)*: The Haskell Include Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, JustPay, and Mercury.
