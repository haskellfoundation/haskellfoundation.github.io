*Matthías Páll Gissurarson (0:00:15)*: Welcome to this episode of the Haskell Interlude. Today, we are joined by Kathrin Stark, professor at Heriot-Watt University in Edinburgh. Kathrin works on program verifications with proof assistants, so her focus is not exactly on Haskell but on topics near to Haskellers’ hearts, such as interactive theorem provers, writing correct programs, and the activities needed to produce them. We’ll discuss many aspects of proofs and specifications and the languages involved in the process, as well as verifying and producing provably correct neural networks. Mike, take it away.

*Mike Sperber (0:00:50)*: So, Kathrin, how did you first get in contact with functional programming?

*Kathrin Stark (0:00:54)*: So, I first got into contact with functional programming in my first semester at university. So I used to study at Saarland University, which is quite in the west of Germany, and one thing that is done there is that in the first semester, it’s Standard ML, which is taught. So we basically start with the basics of functional programming, like writing small functions, more recursive functions, polymorphism, currying, et cetera, et cetera. And then it goes until writing a mini OCaml compiler, until doing some easy correctness proof and easy compiler. So this was actually the first programming language I learned.

*MS (0:01:40)*: Okay. This was when, just about?

*KS (0:01:42)*: This was in 2011.

*MS (0:01:45)*: Okay. And then presumably something led you into doing research with functional programming. So, can you trace that path for us a little bit?

*KS (0:01:54)*: So I think I always really liked this first lecture, which I did, and then I started naturally choosing similar lectures from then on. So I actually encountered Haskell then in the second semester, where I did a seminar where, basically based on what was done in the first semester, we looked at laziness and basically continued from there on, going through some research papers and presenting these research papers. And then I was also getting interested in the Rocq proof assistant, which was a lecture which I then also did. And it built basically very naturally up from what was done in this first semester on functional programming, in that now you couldn’t just write functional programming, functional programs, but you could also prove properties about these functional programs. And of course, like inductive proofs, being also some kind of recursion, which we have there.

*MS (0:02:53)*: So proof sounds super boring, but they were interesting to you?

*KS (0:02:59)*: I would say actually proof assistants helped me to find them interesting. So I remember still when I was in high school, I found proofs super complicated. It was this kind of, I don’t know, always like magic. You never knew when they would be true or when this wouldn’t be true. And I remember also the same thing, actually, when I started university and doing math lectures and never being sure whether the proof I do is correct or whether it isn’t correct or whether there’s just like I convinced enough and wrote enough so that it convinces my math tutor. 

So one thing I really liked in the second semester then is that proofs were suddenly something very clear, and it was very – like there were some convincing to do with the proof assistant, but it would also give you a guarantee that in case you have proven something, it would be correct. And then you can do – I think it’s a little bit like with functional programming, right? Even small proofs get very interesting in some parts, and you can do very much with very little definitions. And basically, it’s like a riddle you want to solve, which is also a little bit like how I think of functional programming. You have very similar, very few ingredients. How can you build something you actually want out of this?

*MS (0:04:21)*: Yeah. And how can we make the pieces fit with a type checker?

*KS (0:04:23)*: Yes, exactly. 

*MS (0:04:24)*: It’s a very puzzle-like activity.

*KS (0:04:26)*: Very addictive, I think, to many people.

*MS (0:04:29)*: So you just enjoyed doing proofs for their own sake. Is it fair to say that?

*KS (0:04:34)*: I think it’s a mix of both. I think it’s both. I think it can be fun. And I would lie if I say this wasn’t part of why I started doing this. But of course, it’s also useful to have all these guarantees for the programs you’re writing. I think we are a little bit spoiled, usually with functional programming, that it’s easier to see why certain things are correct. But even there, errors can happen, and even having type safety. And so, having properties about these programs and having them proven correct is useful in itself.

*MS (0:05:20)*: Can you talk a little bit about what kind of properties are sort of useful to prove? I mean, I assume that if you have a big piece of software with a UI and with a database and things like that, proving all of that would be very costly, right, and maybe too much work?

*KS (0:05:37)*: I agree. So it’s about finding the parts which most errors would happen in. So you asked, I think, about the kind of properties. So there’s a whole range of properties, which I mean, of course, some things are, if we’re talking about type-safe languages, just come automatically with type safety. And then you might also have some automatic checking tools, which ensure that certain kind of errors don’t happen. So what I’m most interested in is actually having functional requirements. So basically, saying what happens in certain cases, which is, of course, also most difficult thing to prove, because usually you can’t do this just automatically, but you would have to have some interaction with the tool, like with an interactive theorem prover, to actually be able to prove those.

*MS (0:06:36)*: Okay. I mean, these days you work a lot with the Coq, now called Rocq theorem prover?

*KS (0:06:42)*: Mm-hmm.

*MS (0:06:43)*: Can you describe a little bit the activities that you go through as you create verified code? 

*KS (0:06:49)*: It usually depends on what I would want to prove. But I think most people would start with some kind of outline. So I mean, basically, what we have is we have some kind of document where we can write in functional programs. And then we can, of course, define notations, et cetera, et cetera. But then we can also later define specific, have specifications over these functional programs. And then we can have a – right? That the programs we actually wrote satisfy these specifications, or maybe equivalent to other programs, or whatever we want to basically prove about it. So usually, I would start with whatever I want to prove and whatever is the property I want to have, and then it might be a forth and back. So, ensuring that the specification is actually what I want it to be, going back to the specification, going to what I want to prove. So I think it’s really very interactive going through such a document.

*MS (0:07:53)*: Yeah. I want to interrupt a little bit. I mean, you said specification, right? A lot of the software developers that I talk to think that specification is just a bunch of test cases, right? Is that what you’re talking about? 

*KS (0:08:04)*: It isn’t. It’s actually something more powerful, and that’s actually – so at the moment, I teach a course, which is at university, which is about working with a Rocq proof assistant for people who have most times not even seen how to prove something in university. So they actually come from a very practical background. So if you just have test cases, it’s basically we have certain values we put in, and then for the certain values, basically know what the input and output paper is, but we can basically talk about abstract values, which we have. So we can, for example, prove that the very simply said that, for example, the version of addition, not only two plus three is five, or zero plus seven is seven, but we can also prove that, for example, it’s associative or that it’s commutative or that it behaves in other ways which we want it to behave. So it’s basically like we can state more properties about – like more abstract properties about also what we have there. 

*MS (0:09:12)*: And abstract, I guess, means that typically you would have like a quantifier in there, right? 

*KS (0:09:16)*: Yes. 

*MS (0:09:16)*: Rather than concrete examples?

*KS (0:09:18)*: Exactly. You have quantifiers in there. Yeah.

*MS (0:09:21)*: Okay, so you got a specification, you have a functional program. Then how do you go from there?

*KS (0:09:27)*: So usually it follows very much the structure of the functional programming, what you would want to prove. So in many cases, you would just follow on whatever you would do recursion on, and then you would do an induction, proof by induction. And then you would hope that basically your specification is strong enough to prove, like you can prove that the program follows its specification. So you would, yeah, basically try to follow the progress, like the process of your program, which you have.

*MS (0:10:00)*: I mean, we kind of got into that tangent from your coursework at the university, but how did you get from your second semester to actually doing research on proof assistants?

*KS (0:10:11)*: There was a little way around in that I went abroad for a semester. But after this, I basically came back to where I did my undergraduate and actually started working with exactly the same professor who did this first programming lecture in functional programming. He’s called Gert Smolka, and he used to do the lecture, which I just talked about, about functional programming, and he also did the lecture on the Rocq proof assistant. And that made me interested in basically continuing working on this.

*MPG (0:10:44)*: Right. So I have a bit of a meta question. So what does it mean to do research on a proof assistant? Like, usually just think of it as this thing that can do anything? So, are you extending it with new features, or what does that mean to do research on a proof assistant?

*KS (0:11:01)*: Okay. So I would say different people have different answers on what this means. So you can also often see this kind of very different approaches in the conferences, which center around theorem provers. So, of course, there would be conferences like POPL where many people would use a proof assistant. And in this case these people would mostly use a proof assistant to certify that the things they claim in their paper is actually correct. And this is important because in this case, it’s like we have long technical proofs. So to spare the reviewers from actually having to check all the menu details and also from doing errors ourselves, proof assistant would be used to ensure that actually the properties are shown which are claimed in the paper. So this would be one approach. 

There would be people who would do work in a proof assistant and proving mathematical results in a proof assistant. So usually this would happen at conferences like Interactive Theorem Prover or also like Certified Programs and Proofs. 

And then there’s the third thing, which is working on improving proof assistants, which sometimes goes into hand in hand if you’re talking about how to prove things about a certain programming language, because in certain ways, a theorem prover is also just a programming language, and we might prove properties about the theorem prover. So, for example, if we think of – there’s a project, which is called MetaRocq, which basically proves certain properties about the Rocq proof assistant and the type theory of the Rocq proof assistant in Rocq itself and proves certain guarantees. 

So I’m, I would say, mostly interested in improving how theorem provers work in general. So for me, this means looking at problems, which are very hard to verify in a proof assistant, and ensuring that actually these things get easier to prove. So this is one thing I would be interested in. So, for example, I don’t know how much it makes no sense, but this would be some of the things. But I’m also interested in more programming language-related things, which I think is hand in hand in which problems you basically choose to work on. 

*MS (0:13:27)*: So is it programming language problems that are particularly hard to prove, or, I mean, can you name example for something that’s difficult to prove but that’s worthwhile proving?

*KS (0:13:36)*: I think one thing is that these proofs just get huge. So if you would actually want to have a foolproof, for example, for your shiny new programming language, that, for example, like type safety, safety is satisfied that you might get into many, many, many cases for which some of these might be boring. So in these cases, a theorem prover is particularly useful because it helps you with the handbook, basically the book holding, and it also helps you that you don’t overlook anything in these cases. 

*MS (0:14:13)*: I mean, we should mention that. Before the days of proof assistants, lots of POPL papers had mistakes, right? And occasionally, type system formulations also had mistakes. So it’s not just sort of checking and relieving the reviewers of the burden of checking.

*KS (0:14:29)*: Oh, it’s actually about not having any problems in this paper, right? So, actually, I think one of the very prominent papers, which also influenced quite some of my research, like the POPLmark Challenge, was a challenge which was built exactly around having proofs of programming languages and making them more usable in theorem provers.

*MPG (0:14:55)*: So as a proof assistant, I mean, because you basically have these libraries that are kind of just made to prove certain kinds of problems, right? So that’s kind of what you – I mean, is that what people work on? They make a “Here’s a new library for verifying programming languages,” or is it more like, “I took this library, and I used it for this new programming language”?

*KS (0:15:14)*: I would say both of them. So both are, I think, things people do. But I would say people who do the second would usually not say they work in program proof assistants. They would more say they work in programming languages, and they use a proof assistant to certify some of the goals. But there are certain things which are particularly hard if you’re talking about proofs, which are very much different than if you would do the same proofs on paper.

*MS (0:15:46)*: So I remember when the POPLmark Challenge first came up, one of the issues that came up was sort of proof reuse, right? Is that happening? So when you work on a new project proving something, do you actually rely on a larger body of proof or a growing body of proofs that you can just use, or you always start from scratch?

*KS (0:16:13)*: So ideally you would reuse some of the property, like you would reuse code which you have, but I think in practice it doesn’t happen so often as you would often want it to happen, which is of course even more a shame because doing this proof in a proof assistant, as safe as they are, also takes a lot of time and a lot of effort. So there are different ways in how we can rely on certain proof libraries. So in some cases, like in best case, of course, like for example, if you’re talking about arithmetic, there would be libraries which do this, and then you can basically do some automation, which automatically solves some of the goals for you. But I would still say that many people start again and again from scratch to do a proof or do some copy and paste from previous developments.

*MS (0:17:17)*: Is that because of the design of the underlying languages of the proof assistant, or is that just laziness? 

*KS (0:17:27)*: So in some ways, you’re working with inductive data types. So inductive data types means what you have basically say you’re closed over this inductive data type you’re having, which means on the one side that you can even define something like recursion on it, and then you can do proofs by induction on them, but on the other hand means that it’s very hard to extend those types. Then, if you would want to, for example, define a proof for a very simple language, and then you would want to add one more feature is that you would actually have to write again the same functions extended by this case, and you would have to do proof extended by this one case. And yeah, this is, of course, what is generally known as the expression problem and would also appear in functional programming.

*MS (0:18:25)*: So over in Haskell land, we would say, “Just use this technique that Wouter Swierstra invented called Data Types à la Carte.” Can you do something similar in Rocq?

*KS (0:18:35)*: So the problem with the data types à la carte technique is you have this functor, which you define, and then you have this, like, you basically define the algebra, which you can write or later write sums over it. And then in Haskell, you would close it, but you can’t simply do this in a proof assistant because all the data types, which we have in a proof assistant, are required to have only positive occurrence. You always have a guarantee that something has to be terminating because otherwise you could prove false in your proof assistant, and all your verification would be for nothing. So this is why you can’t use this general definition of functor, because at the definition, basically, at the same time as you define this data type, it’s not clear that this data type is even allowed in a proof assistant.

*MPG (0:19:32)*: What does it mean to be a positive occurrence? 

*KS (0:19:35)*: So this means that if you have a constructor, you aren’t allowed basically to have it on the left side of an implication of an argument. So, for example, it would be allowed to have something if you have – let me think. So if you, for example, have a data type, like define a new data type not, right? So you allow it to have a successor, which takes a not and then returns a not, but you’re not allowed to have an argument, which basically has a not as an argument and then basically goes because then basically you would have had the problem if you do recursion that you could in principle loop.

*MS (0:20:16)*: So, do you have any hope that that will get better so that the languages of the proof assistant will evolve to the point where reuse gets easier? 

*KS (0:20:26)*: So there is some work in this direction, and I think I wouldn’t say it’s a general – I think we use in general like it’s done for this specific project. There have been some papers who tackle this, and the solution is to basically change the definition of the functor. So we don’t allow a general functor anymore, as would be in the data types à la carte approach. But there, for example, you could restrict the functor which is allowed. So there has been some papers around 2013 at ICFP and POPL, which basically had a definition of what this functor basically looks like. And then we could basically use it exactly. We can also – and this is something we did. So we could also basically parameterize over, like, basically at the moment define the functor, like basically have this parameterization over this type X, as would also be in the data types à la carte paper, but then only instantiated at the point where you actually need it and so not have the problem of termination anymore. And there’s also some more new approach. I think there has been some papers in the last one or two years by Nada Amin and others, which work on the definition using family polymorphism. 

*MS (0:22:01)*: So, zooming out a little bit, you’ve proved your program. Can you talk a little bit about sort of the path along which that program then gets to run in production? I mean, I remember sort of the most well-known example of a verified program I know is seL4, right? And the way that they do it is they kind of manually translate – I mean, they manually write a bunch of Haskell code, verify that, translate it manually into C, and then do equivalence proofs. It seems kind of tedious, right? Is that getting better?

*KS (0:22:34)*: Yeah. So I would say proof assistants, which are based on, for example, the work proof assistant that usually allows some extraction algorithm, which automatically allows to extract to, in this case, OCaml. But there are also – this has, of course, a problem that this extraction mechanism itself might not be verified. So we might not know whether the extracted program, that actually satisfies the problems or the properties we proved in the first place. So one thing which is done in this direction is that there are pipelines, like for example, the CertiCoq project which allowed to compile Gallina down to C and then also proved some properties about this compilation which we have. It actually does connect to the CompCert C compiler, which is, I think, one of the biggest projects in this area, which is a verified C compiler. So it basically connects to the semantics we have there.

*MS (0:23:46)*: Yeah. I find it kind of ironic that Xavier Leroy, who headed the CompCert program, he verified a C compiler but, of course, never verified the OCaml compiler, as far as I’m concerned, as far as I know, right? And that would be the next problem with certification with provably correct extracted code, is that your code might be correct, but your compiler that compiles it might not be. Is that the reason why – I mean, you’re involved in this project, right, to generate C code from Galiano. Can you explain what that is?

*KS (0:24:19)*: Gallina. Oh, so sorry. Gallina is basically the language, like the functional programming language of the Rocq proof assistant. So this would be known as this. I’ve been mostly when I started – so I was involved in a project which was adjacent to this and which uses the CertiCoq compiler. So I wasn’t involved in the CertiCoq project in itself, just to clarify this.

*MS (0:24:49)*: So, CertiCoq, the idea is then instead of extracting to OCaml, which was what was done with CompCert, is to directly generate C code?

*KS (0:24:59)*: Sorry, sorry, sorry. What did you say? What CompCert? Sorry, this was?

*MS (0:25:03)*: So, CompCert, I mean, the way that CompCert works, it’s written and verified in Rocq or Coq, right? And then extract it to OCaml code, and the running code is OCaml code, right? And you’re saying what you’re doing or what the CertiCoq project is doing is to instead generate C code instead of OCaml and then feed that to CompCert.

*KS (0:25:25)*: yeah. Okay. So what it does is it generates C code. That’s correct. And then it connects to the semantics of the CompCert compiler, yes. Even if you are going basically down to do C language, how do we know that basically they’re – like we still have to connect it to something so that we know that this has an end-to-end soundness correctness.

*MS (0:25:49)*: Okay. It seems very strange to generate C code, though, right? Which has this really intricate semantics, and it’s got this low-level execution model. Do you know what the motivation for that is?

*KS (0:26:03)*: I think the connection was to actually have an end-to-end soundness theorem, which exists for the CompCert compiler and tends for C, but doesn’t desolate for something else. There are by now also other backends of CertiCoq. For example, they were recently paper on Wasm, I think, and I think also in OCaml backend, but don’t guess. So I think there are other backends. It’s just like that this – because the original motivation wasn’t end-to-end soundness theorem, this was a reason why it started with also having it to see.

*MPG (0:26:41)*: Oh, yeah. So Mike, I have a question about the scale of the programs. Could I write an entire social network in Gallina, and it would just work? Or how hard is it to write these million-line programs? How big are the programs that people are generally writing in Gallina? 

*KS (0:26:59)*: I think the programs, like, the question is what you want to verify, right? And what would be even the property for a full social network to verify? What would be even the correctness proof property, which is now, of course, with the whole new topics also, like what does it even mean, for example, for a neural network to be correct, right? So what would be the correctness property I would have for this? So this is not something which would be usually beneficial, also because even if we thought about this, what would be the parts we have there? So the question is about which parts we think are most prone to errors and use these to prove properties about. So there might be some parts which are verified and some parts which might not be verified.

*MPG (0:27:52)*: Okay. So you both write the implementation and the specification kind of at the same time, or do you just write the specification and the code just comes for free? Or how do those interact?

*KS (0:28:04)*: I think it depends again on how you do it, right? I guess you’re referring to, if you’re – like in most cases, you would probably want to separate the two, but you could of course also, like, if you think of programs as – like, you might also want to have something where you directly basically define the program and the proof at the same time. So for example, if you’re – yeah.

*MS (0:28:36)*: I mean, that’s how you need to kind of need to do it in Haskell, right? Because the only means you have there of directly verified code, if you’re not doing something like Liquid Haskell, is to do dependent types, and these can’t easily be separated from the program that you’re writing.

*KS (0:28:50)*: And I mean, of course, you can also write dependent types in the proof assistant, but then you might not – sometimes you might – it depends on what you want to do, whether this makes sense over there. Actually, it’s harder to develop both at the same time, right? And I think there are different philosophies on how much people want to do one thing or the other.

*MS (0:29:10)*: Do you have a preference?

*KS (0:29:14)*: This is a very political question, but no, I would say in most, it depends. I think sometimes it’s useful to have certain guarantees together with it, but I think sometimes it’s also a help. I find most times helpful also to separate some of these together, simply because then I can think in separate iterations over the things. And sometimes otherwise, it gets basically too much to hold at the same time.

*MS (0:29:44)*: I mean, I remember Xavier, while he was in the middle of CompCert, gave a talk at some meeting or other that was like dependent types, new hotness or passing fad, but I can never remember what side he came out on. So I think he came out with a preference, but I don’t remember what it was. And he was also using Rocq. So Rocq gives you both options, is my understanding, right?

*KS (0:30:11)*: Yes, yes. I would say people – it depends also on really which proof assistant people use, which preference they have. I would say, like, because dependent types are a little bit more clumsy in, for example, the Rocq proof assistant people, they usually like more separate the proofs, while if they’re working in Agda, where pattern matching is honestly nicer and depend – like if it’s easier a little bit to work with the dependent types, there are people that usually prefer having something, like developing both at the same time and use this a little bit more, I guess. 

*MS (0:30:50)*: Well, I guess with dependent types, you can’t easily define your own tactics, right? I think that was also what Phil Wadler said the other day when we recorded his episode, which is up now, if you want to listen to it. So, I mean, he rewrote the Software Foundation book by Benjamin Pierce in Agda, and that’s basically what he said, is that he doesn’t get into the tactics business, but he also doesn’t need to get into the tactics business to do what he wants to do.

*KS (0:31:22)*: Yeah. So this is, of course, also different. Like, I think Agda is taking it as a program, writing it as a program more seriously, while I think people in Rocq way more use their tactic language and the automation, which comes with that, and then, of course, even more extreme on the other side, I think.

*MS (0:31:41)*: So, among your papers, I saw that you had one that mentioned C FFI, which is very strange in connection with verified software. Can you explain what that work is about?

*KS (0:31:54)*: So this is a project called FFI, which I’ve worked on during my postdoc together with Joomy Korkut and Andrew Appel. And this is a project which is adjacent to CertiCoq, which we just talked about. So the general idea is we talked about what people work on in proof assistants. And I think one thing I’m interested in is to make proving with the proof assistant in general easier to do. So, usually functional programs are the things I would usually want to verify because it’s way easier to verify a functional program than, for example, a C program. So there have been, of course, tools have been developed to basically prove properties also about C programs in a proof assistant. So, for example, there are certain separation logics, which allow you to reason on the C program and on the pointers we have and the data which we have. And the idea of this VeriFFI project was to allow it to take a program, which mostly consists of functional programming parts but may have some small parts of an imperative program. Basically, where we would need these imperative parts, for example, because we might be interested, for example, for efficiency reasons, or because we might need input/output or something, which basically the language which we have and which you want to prove things about doesn’t necessarily support, and then still do a proof, still do have a verified proof about this combined program with functional parts and imperative parts, and still have all these guarantees, but do most of the correctness proofs on the functional program, which is easier to do.

*MS (0:34:09)*: So I’m not sure I’m getting this right. So your work is on verifying the combination of the functional and the C program or the properties of the FFI itself?

*KS (0:34:20)*: Uh-huh. So the idea is to basically have something like an FFI. The idea of a foreign function interface is, of course, a very old idea, and this also exists for Haskell or exists for OCaml and has been around for a long time because programs are rarely written just in one language. But the idea is to not only talk about the operational level but also have basically a foreign function interface for proofs, where I’m allowed to do proofs both about the functional parts of the programs, and I’m allowed to do proofs about the operational part of the programs. And then in the end, I can connect both of these proofs together and hopefully get a proof about my whole program and still have something which connects to something, which is basically completely correct, and have some kind of end-to-end sound correctness theorem about this. 

*MS (0:35:28)*: Was this targeted at a specific environment like OCaml or Haskell or Rocq for that matter?

*KS (0:35:37)*: So it is about using the Rocq proof assistant. So the functional programming language which we have in this case would be Gallina in this case. And then the imperative programming language with this would be intertwined. So you could have a program which both combines, like basically has parts in Gallina and then has C parts would be C. And then on the reasoning level of this would be the verified software toolchain, which would be a separation logic, which was previously developed by Andrew Appel and others to reason on the C parts of the program.

*MS (0:36:16)*: Okay. I guess that makes then targeting C actually attractive, not just for the verification purposes, but because you can then link C code that was written by other means to it. Is that –

*KS (0:36:29)*: Yes. So this was a reason why this project was done, because usually it’s very hard to connect reasoning of these two very different kinds of languages, even to have a semantics basically of both these parts. And the reason why VeriFFI was possible at all is that both of these are compiled down to the C programming language and basically connect at the CompCert level of this. But the CertiCoq project or CertiRocq project pre-existed before this VeriFFI project.

*MS (0:37:11)*: Are there any specific applications that you have in mind in the same way that, I don’t know, seL4 targets operating system and embedded devices? And I think CompCert targets maybe the airline industry.

*KS (0:37:22)*: So far, it has mostly been on smaller programs and toy programs because it’s still very hard to verify these kinds of connections. So, so far, there is no bigger application which we have so far.

*MS (0:37:34)*: But do you sometimes sort of go through your day and say – well, I mean, we run into more and more pieces of software in daily life, and you kind of go, “I wish somebody had applied or would someday apply the techniques that I’m working on to this piece of software.”

*KS (0:37:49)*: I don’t have anything specific in mind now. Sorry.

*MPG (0:37:52)*: Yeah, but it’s very interesting, I think, because I know that when you’re writing Haskell FFIs, it’s just a black box, and then you send some pointer somewhere, and you usually get a segmentation fault. But in this thing you can actually – you know that whatever you send from Rocq is going to be handled correctly by the C.

*KS (0:38:14)*: Yeah. So you prove later that basically it connects properly, and you basically prove that your overall program, which you have in the end, behaves correctly. And you do so again on the side of wheezing on the verified software toolchain, that basically what you have is correct.

*MPG (0:38:31)*: Right. Oh, very cool. Yeah. So we went over where you started, how you got into research, but now you’re in Scotland, correct? 

*KS (0:38:42)*: That’s correct. Yes.

*MPG (0:38:43)*: Yeah. And you’ve been involved in this SPLV. So I know Mike doesn’t know what that is. Could you explain SPLV to us?

*KS (0:38:51)*: Yes, sure. So in general, there is a consortium of basically – okay. So all of this is basically under the Scottish Programming Language Institute. So informally, Scottish universities have worked a lot together on the programming language side of things. So there’s, of course, Edinburgh University. There’s Heriot-Watt University, where I’m at the moment. There’s Glasgow University and Strathclyde University and Stirling and St. Andrews, and others, right? And all of them have quite some focus on programming languages. And so the Scottish Programming Language Institute basically has a goal to bring these together also, for example, both in research and also for PhD students. And SPLV, which you just mentioned, there’s usually a summer school in summer organized together by this university. There’s also each three or four months, there is a Scottish Programming Language Seminar, where basically people meet up and discuss programming languages.

*MPG (0:40:02)*: Yeah, no, I think it’s a perfect focus of programming language. And I think you have some different focuses per year, or is that – it moves around, right? And then it’s different kind of –

*KS (0:40:16)*: So usually it’s tried to change the place where it’s done so that it’s done once in Edinburgh, once in Glasgow, and then somewhere else, so that everybody has a chance to come at some point. Yeah.

*MPG (0:40:32)*: Yeah, no, it’s a very fun program for PhD students. I encourage everyone listening to apply, because I think – and Scotland is very – I say it’s very nice because I’m used to the weather, but I think I think most – like in the summer, it’s quite nice. Yeah.

*KS (0:40:48)*: I think it’s a very nice place, both for research and also to live. Yeah. If somebody’s interested, on the website, there’s also a list of all the people who are working in the area and who is looking for PhD students, if anybody should listen to this. 

*MPG (0:41:07)*: Yeah. So you mentioned verifying deep neural networks. Could you just tell us – I mean, it’s a complicated topic, but could you just tell us what you’ve been doing in that area?

*KS (0:41:18)*: Yeah. So it’s different to – it’s difficult to verify a neural network in general, right, because what does it even mean to do a specification? So far, there have been mostly approaches from the automated verification community. So, for example, the group of Guy Katz has, for example, defined basically the way to ensure that certain safety properties hold on these neural networks, for example. You could think of these, basically, that, for example, if you have a car, it doesn’t go basically over the border, right? So this kind of properties would be something you might want to find, might to verify, but of course, this isn’t the complete definition, which we don’t even know what the complete specification would be one. So one project one co-supervised PhD student did is, for example, ensure that such a proof checker actually returns a correct result in this case.

*MS (0:42:35)*: I’m curious. Okay, so you have a partial specification, or you have a specification of some properties over your neural network, and it fails? What do you do? Do you retrain it and hope that it’s going to do better next time or –

*KS (0:42:47)*: Oh, that’s actually something you do. So this is actually some other work. So one approach from the neural network community is to use something which is called differentiable logics. Differentiable logics means that you basically take a property and you compile it down into a loss function. So a loss function is what a neural network is trained with, and you would try to use this neural network, like this property together with the loss function, so that if this property isn’t satisfied, it basically gives a punishment to the loss function. And one way to do so is to compile it down to something called differentiable logics. And they would be called like that because, to be used in a neural network, they would have to be differentiable. And there have been several differentiable logics being proposed before. For example, fuzzy logics, which are very, very old, have been used, but then also some more have been used, for example, by machine language communities. Of course, one of the questions is, what is such a good differentiable logic, which properties should it satisfy?

*MS (0:44:06)*: So there’s hope after all that we’ll get something, that we’ll actually get some truth from neural networks after all?

*KS (0:44:12)*: I don’t want to comment on this, but I think there are people working on how to – Katya Komendantskaya is one person who’s working very much on what would be good properties in this case. Yeah.

*MPG (0:44:27)*: Yeah. Okay. So there’s a state-of-the-art there. It’s just something that returns something. I think it’s very funny we were very early in that area. Yeah.

*KS (0:44:38)*: Yeah. We were very early in this area. Also, there is a Vehicle project, which I’m not personally involved in, but it’s actually written in Haskell and has the goal to give programming language support for this kind of – to basically bring together different tools that are working on verification of neural networks.

*MPG (0:45:11)*: Yeah. No, it’s an interesting problem for sure, especially if it’s so early that we don’t even know what we’re talking about. I’m sure people will listen to this in 10 years and be like, “Oh, if only they’d known.”

*MS (0:45:25)*: Yeah. But I think, I mean, generally, program verification is something that just a lot of people in software development just don’t know about, right? They don’t know that it exists, right? So, I mean, I mentioned earlier that most people think a bunch of examples or a bunch of test cases constitute a specification. And if you’re at that point, you can’t even see what verification might be other than running your program against the test cases, right? So I think this is very worthwhile work, not just in the sense of providing tools, but also in the sense of providing knowledge to the community eventually. So I’m hoping – I mean, we’re looking at a long list of breakthroughs and great tools and program verification over the years. Many systems have – I mean, things like CompCert and Rocq itself, of course, over the years, but they are just known to only very few people. 

*KS (0:46:24)*: and it’s a young field in some sense, right? So it’s a young field in that mathematics has existed for way longer. So of course, we have to find the right tools to work with it and the right ways to speak about it.

*MS (0:46:37)*: But they have existed for a number of years, right? I mean, even Rocq’s predecessors, things like ACL2, have existed –

*KS (0:46:44)*: Yeah, no, of course.

*MS (0:46:45)*: – much longer. And of course, Standard ML originally that you mentioned in the beginning, that you took in your first semester, was originally the tactics language of a proof assistant, right? In the ‘70s, I think. So kids, if you’re listening, learn about proof assistants.

*MPG (0:47:04)*: Yeah. Do you think it’s constrained by the fact that proofs were mostly done by mathematician? It’s weird to say this, right? But you know, proofs are written by people who think like mathematicians, right? And then do programmers have to start thinking more like mathematicians or should mathematicians try to start thinking more like programmers to make it more accessible to people? Like you said, we can’t even speak about these things, right? So, is there some work on the language of program language verification, I guess?

*KS (0:47:43)*: I don’t know. I mean, of course, people try to make proof assistants in some way more accessible. So I think one thing that has been done is that, for example, Isabelle uses Isar, which is a language, which is more reasoning. Like it would be done on paper, like more forward reasoning style and using a little bit more of natural, like neutral language. And there was a proof assistant, like Naproche, which is completely – like basically allow you to basically write almost text like and then has a proof assistant back end. But the problem is just that it’s just like, you have to be very precise in some way in doing proofs in a proof assistant, because the point is the exact details on how you write your program matter so much, and having clutter there might complicate your proof very much. So yeah, in some ways, I think it’s a very tough problem. 

*MS (0:48:52)*: Well, also how you write your specification, right? It’s sensitive to that.

*KS (0:48:56)*: This all matters very much. Yes.

*MS (0:48:58)*: I mean, there’s definitely an economic dimension to that, right? So if you want to apply program verification, then first of all, you need to supply a specification. And that is harder than the documentation that usually comes out of software projects and, I guess, needs more qualification as well, and somebody has to pay for that. I think it’s especially difficult right now because everybody thinks programs are basically going to be written by AI anyway. So fewer people are willing to pay for that kind of stuff. So I think what needs to happen is that we run into more situation where erroneous software causes bigger problems before we get more applied verification.

*MPG (0:49:42)*: I think we’re about to reach an hour, so the question we ask at the end usually is, where do you see the future of functional programming, or where do you see the future of proof assistants going?

*KS (0:49:55)*: Oh, that’s a hard question too. I would say that there has to be more work on how to make proof assistants more efficient and how to make it also more applicable to people who are not – like don’t have a PhD in basically working with a proof assistant. So I would say this is definitely something which this field has to work on.

*MPG (0:50:21)*: Do you think that’s where we’re going?

*KS (0:50:23)*: I would hope so. I think also where it’s very useful is actually in teaching. I see that with students, that it helps students to basically see what even reasoning about or even what a specification is about and how to even state something which doesn’t have all these small box in it, but then actually trying to think about how you would prove it and then noticing that these details matter, helps also. 

*MPG (0:50:52)*: Yeah. I think we’ve about covered it all. Yeah. Thank you so much for coming on.

*MS (0:50:58)*: Yeah. Thank you, Kathrin.

*KS (0:50:59)*: Thank you very much.

*Narrator (0:51:02)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
