_Niki Vazou_: This is the Haskell Interlude. I'm Niki Vazou, next to Andres Loh and our guest today is Ningning Xie. Ningning first contributed to GHC at her Google summer of code project with a very ambitious goal of implementing the whole dependent Haskell. Also later she fixed several ghc bugs and worked on Koka’s Algebraic effects. Her future hope and advice is to use programming language concepts on real-word problems.

_NV_: Hello everyone, I am Niki Vazou and our guest today is Ningning Xie. I am here with my co-host which is Andres Loh. 

_Andres Loh_: Hello.

_NV_: So, Ningning can you start by telling us how did you got into Haskell?

_Ningning Xie_: Yes, yeah, Sure. So I'm very happy to be here. Thanks for having me. This is a long journey back. So when I was doing my undergrad I was looking for my research interests and I tried many different things and later I realized I'm more interested into things with more principles and logical reasoning and so I started getting into the programming languages and I started actually by learning my first book Learn you a Haskell for Great Good.

_AL_: So can that cannot just backtrack ever so slightly. So I mean so you were studying computer science I guess. Where were you studying computer science?

_NX_: Ah, it was Zhejiang University it's in the southeastern part of China.

_NV_: Do you have any Haskell people there or you just started by yourself?

_NX_: Um, we have no Haskell professors or anything about universities. There's no even like program language professors I'm not sure about now but probably not and around that time my Phd advisor with them I phd advisor was Bruno Oliveira. He just started at the university of Hong Kong and so I got in contact with him saying okay I'm interested in doing programming languages and he said okay, great and then you should read all the books like the Learn you a Haskell for great good and also types and programming languages so I started doing my Haskell like from there. Um, it was a great book. I would highly recommend it to any Haskell beginner. It is a very gentle has a very gentle introduction and a very beginner friendly. And then during my research I used the Haskell to implement my type system prototypes and I also occasionally contribute to the gch compiler for various features and also bug fixes.

_NV_:And so how you learn about the GHC and started contributing? Because I also mostly use the GHC API and especially at the beginning I remember trying to get into it by myself and I found it very chaotic. So how did you solve that.

_NX_: Yeah, yeah, I actually should say that was like with great help from like Richard Eisenberg. That was during my third year of my phd I started so I also had heavy like Haskell user but not really a contributor at that time. And then I started the one to participate in the Summer of Haskell which is also the Google summer of code under the Haskell organization and for that what you needed to do is to write a proposal about what you want to implement and because my expertise is more on the type system part and that around that time also Richard just started doing a dependent Haskell. So I thought I should write the proposal on doing some implementation for dependent Haskell and from that part. I actually started like reading all the source code and trying to come up with a proposal on my own and then that was very difficult because this code base is like a giant beast that you needed to tackle. So I wrote a draft of my proposal. And also around that time I was visiting Tom Schrijvers at the Leuven University and he has the student um that the George. Um I forgot his last name. 

_NV_: Karachalias, the Greeks…

_NX_: Oh yes, that that him, um, he's also still there and so I asked. Oh I think he's a contributor of the patent matching implementation in ghc and I ask okay could you look ah take a look at my proposal to give me any suggestions that you might have and then he actually read my proposal in very detail and he has like a lot of comments that are really helpful and so I revised my proposal according to his suggestion. And I just understand it to the ah Google summer of code I actually also read  email to Richard and as at that time he did not reply and so I was just like waiting with like some hope and then my proposal got accepted. Yeah, and I also got an email from Richard says. Okay, great. We should get started and for that summer I moved to Philadelphia where Richard still was still at Hermon so I stayed at Philadelphia and commute to Hermon. To to work with recard on the implementation. So that's that's I think that's like especially helpful for me to have like a deeper understanding of the ghc because now you have a help from like ah someone who is really an expert in that aspect. So.

_NV_: Can you briefly say what was this proposal about.

_NX_: Right? Um I think that proposal was ah too ambitious like in retrospect that was about like I want to implement the whole dependent Haskell in our summer which is not like realistic at all. And then later I talked to with Richard and Richard says you should. We should like ah start up from our none step. So what I actually did is code coercion quantification. We had a Haskell implementations workshop abstract for that and then the basic idea is. Ah, when Richard was formalized dependent Haskell he realized that he wanted ah all the type constraints to be homogeneous instead of heterogeneous and by homogeneous and not heterogeneous I mean if you have a constraint say a is equivalent to b. You require this a and this b to have the same type so that is homogenousous are consstream and for heterogeneous then it kind can be different a yeah, 

_AL_: You mean and the same kind. Basically even though types and kind are essentially same these days. But yeah, okay, yeah.

_NX_: Exactly yes, exactly? Yeah right. Um, and then Richard had realized doing his formalization that ghc actually requires um, homogeneous for the proof of dependent Haskell to go through and then for doing but you still want heterogeneous constraints because that's useful even in your implementation. When you went to like write some Haskell programs. You want some heterogeneous constraints and so the idea is we can implement heterogeneous constrains using homogeneous constrains and the only thing you need is a can cast so can coercion so h essential should you me? Okay, a is committed to b. Yeah of different kind like k one and k two. But if you know k one and a k two is also equivalent and you have a constraint for that you can use that constrain to cast the kind of like a for it to become k two and now a and b all for the same kinds and to ah mode. So heterogeneous structure using homogeneous function this way we want a thing called the coercion quantification which is essentially a type quantification but instead of quantifying over type variable. You're quantifying over a core ah coercion variable. So now you can have a polymorph them that. Over the coercion variable and then then use it to test the type of None of the constraints and so you can model heterogeneous constraints using homogeneous constraints doest make sense.

_AL_: So okay and and just sort of written in terms of understanding the timeline. So this this summer of code project that was during your PhD or or still before doing.

_NX_: Ah, that was during my phd that was the None d of my PhD the storm of my 30

_AL_: Okay, and and I mean if you don't mind I would like to go a bit back once once more because I mean it all sounded so fast and so quick you said you. During your undergraduate you suddenly discovered you become interested in programming languages and then you emailed with Bruno Olivea and he told you to read all these books and then you did your ph d so I mean that's amazing. but um but I mean sort of did you you just. You specifically reach out to Bruno Olivea because you you found them and you thought like I mean that's exactly where I want to be or did you consider multiple different places or or did you at that time know that you want someone who works in haskell or that you just want someone who works on programming languages and and. Happen to be someone who like told you then also look at haskell many questions at one sorry.

_NX_: I think all that time I was especially interested in programming languages and with his functional programming. So I just like this discovered Bruno at the river of Hong Kong and then I wrote him an email.

_AL_: Um, ah in me. Yeah.

_NX_: And that was the PhD application I submit submitted and there I got it so I didn't look at like multiple places um part of the reason is also I after I contact the Bruno I visited him for one week during the stormer before you submit the ph d applications and I think it. It was a amazing fit I Want to do my Ph D with him. Yeah, and this is how I started and I started um, building Haskell or like learning has school in the beginning and during my PhD. The first two years of PhD I started using Haskell to implement the type systems design I have in my paper and then in my third year I started thinking okay instead of being a pure Haskell user I also wanted to be a Haskell implementer and that's how I started to get involved in the Google sum of coding and I wrote my proposal and contact the Richard and that's all the story.

_NV_: Okay, since now we're still in this summer of Haskell so you said before that I mean you had like this some bishop non-realistic idea of implementing the whole dependent Haskell. So I mean I think like this dependent Haskell is. Like I'm going to say controversial because there is this discussion and is Haskell dependent already or like is it going to to be a dependent type. So can you tell us your take on what is dependent types in Haskell.

_NX_: Right? Um I think first there are like several goals we want to have in that defendant Haskell project. The none is probably different from many dependently typed language is we want to be mostly laid backward compatible. And that means we are going to make many design decisions  that are different from other dependent cat languages like ages or Coq or Agda and the second is we do want to support some form of dependent has skills. The dependent types in Haskell for it to be useful to encode many um, practical like examples. Um like how to um, say how to write a typesafe compiler using Haskell because with depending the types you can essentially enforce the type enforce the type. Of term like um and like with a stronger type system. Um, but like yeah of course like many challenges involved in that implementation because you want to be backward compatible with the existing features that means um, you will have like. These features that are different from other languages like especially because um ghc has already made melodies and delicious and it's like difficult to be compatible with I think None example I particularly liked is how to define a data type  Haskell. Like nowadays what you can do is you can say okay data id is equivalent to id so you use the same token for both the type constructor and the data constructor but you have if you have like 4 dependent types that can become a problem because whenever use id you don't know. Are you meaning the data constructor or are you meaning pet construct. So this is like what more? Yeah, None particular example I like and there are of course many challenges also in terms most like type inference we have depend on the types we have type families.

_NX_: Ah, ah, all the equality coercions. Um, or you will have linear types now so you will have to design to have like a design wise spot that can sort of support all the features you want.

_AL_: So um, so as a.

_NV_:I mean I'm I'm still thinking this idea that is the same type and data constructor because in my mind it's totally in a different namespace I mean I.

_NX_: Right.

_NV_: I mean the the compiler definitely says 2 different things but you're claiming that the user says the same thing and this creates problems right.

_NX_:  Ah, currently today they live in a a different name space. So that's clear that if you use id in a term level the data constructor if you use it in the type level then it's the type constructor. But if once you have flow dependent types this becomes unclear. Ah, so you're saying that the goal is to be able to write totally like types inside the terms al la carte. Um, right if you have 4 dependent types in healthcare.

_AL_: It's with promotion right? So if you I mean if you have a data type you can promote it and with data with the data kinds extension and then everything that is a constructor becomes a type and there you have sort of. Shifted levels right now if you have a constructor and a type that have the same name you have ambiguity and that is currently resolved with these I would say slightly ugly ticks that you have to put in front of the constructors. Um, ah so but I mean you need. Some solution I mean I'm not saying that there necessarily is a better one I mean you can you can of course change the whole Haskell syntax. But but even like yeah but because even in the in this and on the syntactic layer even with the build-in data types. You already have these ambiguities right? because the list syntax is conflicting and the top level syntax is conflicting because they use the same the same syntax for constructors and for types and and there  you get the?

_NX_: So yeah exactly. Yeah, so this is related to the design choice you have to make because of it because it's not like a fully dependent type language.

_NV_: But if you're up like if you enable all these features using a language pragma then you will keep Backward compatibility right.

_AL_: Yeah.

_NX_:I mean we only enable dependent types. Once you have some language pragma right? Um, that's sure and that's a different question right? because if once you have this language pragma. Essentially you have 2 languages. But Haskell and you still need to decide What's inside that dependent or dependent has skill.

_NV_: Okay.

_NX_: And I guess Also you probably don't want the user to rewrite the whole program just because they open the other language programs.

_NV_: Okay, and so this dependent dependent Haskell was the part of your Google summer of code and then you're still actively working on these.

_NX_: Um, not so much nowadays and um, part of the reading is um I started working on like many for the projects and the other is um, actually as one result of that some of has killed. Project I started working on the can of system. Ah which is the ah can inference for data types paper where we this is also with Richard Eisenberg where we try to formalize the can system used into this ghc. And in that formalization. We also include a type in type which is essentially have a form of dependent types in our kind of ah in our type system. Um, and ah for that project is is. It's not so much about implementations anymore. But it's more about the type system formalization. But during this formalization and we did find several bugs in the ah gsa implementation and we fixed some ah features that ah followed our formalization in the type system. Ah, which is a little bit different with dc design.

_NV_: I mean I guess I have to ask lay What kind of bugs and in what what version of did see.

_NX_: Right? Um, that was um, but involving the subtle interaction between what we call defaulting and also cannonical polymorphism. So by defaulting I mean. When you declare a data type  if you don't have any language extension and if the tab variable is not constrained then it will be defaulted to star which is the default kind for every basic types like int and ah Bo. And so in has 98 like the play Haskell. Um, if you have a mutually recursive data type of the collaboration and if you have a tab variable that is not constrained then it will be defaulted to Star. That if you break this mutual recursion if this type if there is ah just a single one- way ah dependency from one declaration to the other and this type variable say if it's used in a later data type dedication. It will not be defaulted but instead it will be solved according to the type cluster and but since works differently once you have polymorphism them because if a type variable is not constrained instead of defaulting it. You will do a generalization of this type variable. It will have a Polymorphic kind and essentially what we discovered as a bug There is whether or not ah you do this kind of Polymorphism it will have a different behavior um on the data type of the collaboration and in certain case the type constrain. Ah, stopping will go Wrong. So This is a rather settle bug and it's in the version of GHC 8.

_NV_: And it was fixed on 9 right? Ah so you you figure out this bug when you were doing the meta theory you didn't turn in there.

_AL_: Okay.

_NX_: Yeah, yeah, it was fixed. Yes.

_NX_: Exactly yeah because when I was doing Meta Theory I was trying all the corner cases that could arrive and there I was having this sneak down hole and I checked it in the GHC and I was like okay this works differently is I What expected. And then I wrote an issue and then Simon said Yes, this is a bug and I went out and fixed. It.

_NV_: That's very cool I mean it's kind of relevant with a question I wanted to ask so with sidetrack from your journey again because it seems we are still in the very beginning you have done many other projects. But I mean something that I Also wonder a lot and I see you have a very nice balance. It's this um like writing research paper and in this case doing Meta theory with actually doing the implementations on Dt and on like real world Software. So this like your this story is an example that these 2 things really interacted. But I don't know if you have any other thoughts on this topic between ah doing the like say like scientific like doing the paper writing and the meta theory and then.

_NX_: As as the interaction between.

_NV_: Ah, spending the time like doing the implementation or like because I mean yeah, fixing a bug  is definitely more time consuming than implementing a toy language.

_NX_: Right? Um I completely agree with that I think that sort of depends on what you feel you more like to do. Um I think I want to say myself as more like a type theory person. Rather than a heavy implementer of Gc or any software. Um, because I'd more like to read about things and to prove things that work correctly and. The bug that got fixed is like a byproduct of this process of formalization and this is actually the purpose of doing all those formalization because now because now I'm sure that the compiler behaves the same way as I expected. And I know like lots of amazing engineers and also Haskell  hackers, they are like more into the implementation side and they wrote like lots of code lots of code like Larry Amazing um so I think um. It will be important actually to have this None group of people work together. So like you will have this I can work on the formalization and if I got any idea I can have people to help implement that in the component.

_AL_: And when you're doing formalization are you doing this all by hand on paper or are you using like tools for this like a cock or something like that.

_NX_: And um, yeah for half of my its like half  so half of my Phd work I just used the paper and the pen and for the other half I read Coq um I think more recently I'm more into the paper and pencil.

_AL_: Um, okay.

_NX_: The one is um I think I have wrote like lots of coq proof already. So I know exactly how those like inductive proof work and I can do very small step proof for a lemma so I am I'm sure like when I prove a lemma. And like 99% sure that this is correct and and the other is the proof engineer efforts involved in writing proofs in a like proof assistant like Coq um, ah like recently I got like more interested in like doing the research it stuff rather than end. Ah, writing all the proofs in a proof assistant.

_AL_: So You think there is still um, too much overhead essentially in in working with the proof Assistant. So despite the like the the idea the naive idea could be that a proof assistant could actually automate a lot of things whereas if you do. Things on paper you have to basically write out all the cases but but do you think we're still far away from the place where where it actually becomes easier to use a an assistant. Great.

_NX_: Right? I think also automation they definitely helped for a proof assistant but you still got lots of work to do, especially if you do type system formalization. You want you to deal with all the substitution lemmas all the scoping. Yeah.

_AL_: Oh yeah, yeah, it's the name handling stuff is always horrible. Um, yeah.

_NX_: Like sometimes the dilemma seems so obvious to you? yeah.

_NV_: Um, yeah.

_NX_: And yeah, that.

_NV_: I have read that Coq has many libraries that help you deal with that. But I haven't I cannot confirm.

_AL_: yeah yeah I mean I it's just interesting to to hear to hear your opinion that you're sad you you have been like using Coq for a while but you have actually been moving away from it again. So I guess it's a little bit sad but i.

_NX_: Yeah, yeah.

_AL_: Can certainly understand it. Um, so when you you basically learned all of this on your own when you when you did your PhD right? because I mean if I understood you correctly you said your your undergraduate um you. Didn't learn a whole lot of programming languages there and and not not a whole lot. Ah certainly about theory and um so you you basically did you? I mean that you sort of actually follow courses or would you say you you basically self-studied almost all of this like in the in the chorus of your. And the course of your P d.

_NX_: Um I think I did both like I ah did self of study like I read lots of books I think for a while. For example I was reading the practical foundation of program languages and the go there was like reading 1 chapter per day. So I spend like two months on that book.

_AL_: Who.

_NX_: Um, and I also watch lots of like lectures online like there is like the Oregon summer school. They have all the materials available online and the older keynote like invited the talks which you can find on Youtube those are like all very helpful I think for a big beginner in like programming languages. And the my advisor said and helped a lot to like when I started working on type systems. He already has like none of knowledges on that and he would point me to the right? ah book or like lecture I should look at or the paper I should read so it's like. The result of all all those efforts.

_AL_: Okay, well, that's fantastic. So None thing I saw on your homepage by accident when I was looking at this today is that you have a link to a chinese version of software foundations. There is that like did you actually translate this yourself or I mean I don't. I don't understand any chinese so I wouldn't be able to to say but is is that something you did.

_NX_: Um I translated for like I think a story of 4 chapters because we have like a whole ah group of people actually are doing this translation. Um I think we first finished as the one volume of the Software Foundation and I'm not sure about the follow-up values.

_AL_: Okay. Um, okay, um.

_NX_: Um, because that was mostly during the beginning of my Ph D and why I was also learning sub foundation by myself and then I was thinking okay semester there is that this community that doing all the translation and think okay now I have understand the Concepts I can actually. Ah, read it down in Chinese so it can be helpful for Chinese students who are not like so good at english.

_AL_: Nice. Okay, so then perhaps let's ah, go back to sort of your your story and progression through time. So we have been basically covering everything up to like the third year of your ph d when you did just Google summer of code project. But um. What happened afterwards what happened like when when you I mean what was your ph d about and and what happened after your PhD.

_NX_: Right? Um, ah so as I mentioned before I started working on the coercion project. Um with right after the Google summer of code and that turns into our POPL paper and um, after that um I contributed less to the compiler and I switched more to the user side. Um, where um because at that time I started working on the concept called algebraic effects and I walked there for like almost more than 1 year with a dead Layhan ah from Microsoft of software research and for for there we basically I started working on the language called Koka which is a functional program language with support focus algebraic effects. I think many of the design in the Koka actually like relate back to Haskell and we also wrote a Haskell library for implementing algebraic effects. So like users can actually use our library to write. Programs with algebra defects. 

_AL_: Can you can you say a bit more about what and I mean what is an algebraic effect and I mean I know that it's ah like a hot topic in the has school community and there are lots of libraries about algebraic effects and extensible effects and whatnot. but um but I mean like since you're an expert perhaps like you can actually explain what what is actually the definition of an algebraic effect and and also what yeah how does a language like Koka look like I mean if if there is any way like that you can describe it to someone who. Hasn't seen it but I mean what what does it mean to to put algebraic effects front and center and a language.

_NX_: And right? um I think Algebraic effects are basically modular and kind of possible computational effects and as the way I like to describe it is um, you can start withsumable exceptions. So in normal programming languages. You can store in perception and this whole program just finished with that exception and with algebraic effects when it stores Andce I can deal with it by sayinging. Okay, you can say if it's the like divided by 0, exception I can say okay resume the original capitation with a default value zero for that exception part and then the programmer can basically continue this ah computation from where the exception is served. And the algebraic effect goes a little bit more than that because it allows you to resume multiple times and you can use that to implement um like useful computational effects like non determinism.

_AL_: So you would say do I understand you correctly that you would say that algebraic effects are somewhat like structured exceptions would that be like giving giving more structure to exceptions so that you can give them different types and have more interesting resumption methods.

_NX_: And yeah I think that that's one way to think about it and there's definitely one use for use case of algebraic effects. Um, but things algebraic effects actually allows you to resume multiple times. It goes a little bit of beyond Just resumable exceptions. Because you can say okay, you can resume by trying if it's a boolean by trying true if the should does not work. You can come back and then try force again with the exactly or the original exact original capitation. 

_NV_: So can you maybe explain these for somebody who is familiar with monads because my understanding is that effects and monads are very equivalent. But now I'm trying to think. If you can actually resume with monads. It's not clear to me.

_NX_: Um, I think there is a paper um at ncp probably 2000 circuit that actually says algebraic effects and monads  they are ah equivalent in the sense you can transfer one to the other. Ah, in the monomorphic setting and it still be the unclear in the polymorphic setting. Ah that if you don't have like polymorphic types then it has been showed that you can transfer one to the other so in that sense they have the same expressive power. Ah, but my understanding is algebraic effects allows you to write the program in a more structured way and ah monnets. Although they have the same express power in the sense. You can always read the same program using different styles.

_NV_: Okay, and you said you implemented algebraic effects in the Haskell library.

_NX_: As a Haskell  library. Yes, you can still find it and use it I have catch.

_NV_:  And have this so what is  and so you use it for exception. Sure you have more fancy effects too.

_NX_: Um, that library essentially comes with all the interface you would want  for algebraic effects. So you can use it to use ah to write like any programs you want and we have examples included in the library for like exceptions as data variables. Um, oh um, I think also the nondeterminism in a sense. You was multiple 4 times and and and you can Also you write it. You need to write that concurrency programs because the algbraic threads can also be used to model concurrency.

_NV_: That's cool.

_AL_: So. What's the what's what's the fundamental difference between say having effects in Haskell and having effects on Koka and should should should haskell like learn something from Koka or are the language is too different from each other that it would never work.

_NX_: Yeah, right? Um I think I there are like many differences between these two languages the first is because since Koka has like a building support for algebraic effects. We can have like more efficient implementation for them because we have all the culture about how the. Program is compiled and executed um, and yeah, also like other things which coca does like ah the previous like the precess reference counting techniques. Um, so essentially Koka used reference counting to do garbage collection and hasca has ah. Ah, chain based garbage collector. Um, and KOka is still small. It is still like under heavy development. There are like not many users. Um and we hope to ah build it to like a more like mature language and to actually use it. You did for like more more practical applications and while Haskell is big. It has all the features and large code based and lots of users and yeah I think if some in the functional program instance they are related but um, they differ in like many design ah was like language feature wise and is underlying like wrong time garbage collection.

_AL_:  But I mean naively speaking I mean there are dependently taught programming languages such as Idris and Agda and then there is dependent Haskell right? And so now there is some like sort of language builds on algebraic effects is there like should. Should Haskell also sort of take take the ideas out of Koka and and sort of like build algebraic effects more directly into the language as well sort of somewhat akin to what what you've been trying to do with others of course in in the context of dependent Haskell or would you say it's it's simply yeah, it's simply too much of a different path and and you can't see a way to do that.

_NX_: Right? Um I think the question ah is more about like is Haskell ready enough for whatever people use Haskell for because we don't need a language feature in a language if. People like don't want to use it or ah people already have like alternative ways to implement the program like in Haskell we have monad and we have monad transformers that can essentially be used to write like same programs but maybe like less modular. There is actually one ghc proposal if I remember correctly about ah supporting building typed continuation. Um, by um Alex King um I'm not sure where where that proposal is um. Probably still under discussion and that's more about like if we have to have building ah continuation support in inside GHC then we can also use that to implement the algebraic effects more directly.

_AL_:So what do you think with something like that proposal one could implement algebraic effects at the same efficiency level as ah as they're implemented in Koka?

_NX_: Um, yeah I think it would be of course more efficient if we do have the continuation support um of the same efficiency and nurture because that also depends on lots of compiler optimizations. Also how you do like garbage collection. But for sure that will support more beauty and like algebraic effects and that to me would be a great direction to go.

_NV_: But can can we use these ideas to optimize the runtime of Monadic computation or is this only effect specific.

_NX_: Um I think for the Koka it's more um algebraic effects its specific because the idea is essentially um to ah capture the handlers and then pass them to where the exception happened and in monads you don't have this separation between handlers and effects. So that idea will not like directly apply to compile monads.

_AL_: Okay I have a slightly different question I mean as a researcher, you've now said that you've been working at least to a significant extent with ghc and like sort of which is as you said a large compiler with many users even though. Of course it's still a small compiler compared to some other languages but nevertheless and then you have been working with Koka which is sort of a like I guess ah also quite complex language implementation but it is small and it doesn't have many users and this under active development. So from a researcher's perspective isn't. Isn't that easier I mean what like I mean what? what What keeps you with Haskell like I mean isn't it actually sort of easier to to write papers for for sort of smaller and experimental languages and work with language implementations that are like easier to change perhaps or is there something that still fascinates you very much about haskell specifically just perhaps that it is used in the real world or something like that.

_NX_: Yeah, definitely! um I think yeah, like generally the directions in the functional program community that you can either contribute to existing languages like Haskell like ocaml or you can build your own language with your specifically designed language features. I sort of like both so because like on the one side I feel and like making like practical changes to the compiler and like for example, I fixed the bug. It's actually a usual facing and then now every compiler like runs on your um laptop has my code in it right? You can see where you probably can see it. But once you like a type that you could down. You see you have different behaviors with different ghc versions and on the other. Yes, with smaller languages you can do more, um, like radical changes  because you have all the control of the whole compiler and as a language and that allow you to try out some like research ideas like more more quickly and it's not like you must choose one of them because once you have like some language design you can actually try to like implementing both of them for example, maybe in the future when I started working on like um, kind the poly with them algebraic system did I for Koka that work. Maybe maybe what we will use the idea from the kind of system for Haskell or maybe whilst we have the continuation support in ghc maybe we can implement algebraic effects motivat efficiently. Um, that's yeah I think I left ah bo directions and I sort of tried  to keep both directions.

_AL_: And okay, yeah, that sounds good so you will explore other languages and ideas and other contexts butalways come back to Haskell and try to make Haskell better as well. That's good. That's good.

_NV_: Other Koka and ghc have you interacted with another compiler or do you want to.

_NX_: A compiler other than GHC.

_NV_: Ah, yeah, other than ghc and the Koka language because you seem to be like very diverse. So yeah, I guess my question is do you want to apply these ideas to maybe Rust or like ah a language that is of totally different style.

_NX_: Yeah I think I would love to um but I think I also need people who wants to like implement that idea from the Haskell side like the expert so that we can work together. Ah, because it costs too much like to like ah start a new language just on your own and from scratch. Yeah I think there is like more collaboration um, needed between ah different language communities.

_AL_: So okay, let's perhaps go back to sort of the um yeah, your life. Essentially I mean like what exactly happened after your Ph D and and what are your main goals or themes of research right now.

_NX_: Yeah, um I think I work on lots of like functional programming and language design. Um, and I will definitely continue working on that  and the other direction I recently feel excited about is about like applying. Ah, functional programming or like program language techniques in general to like other domains. So yeah I recently have ah MLSys paper about like machine learning systems. This is with ah Dimitris at Deep Mind. So he is also he used to be a heavy Haskell designer and implementer and now he's also ah working are more like apply the programming language Technique. Um, so I find that direction particularly exciting because um, we have lots of tools. Actually paradigms and ideas in the program Language Community. Um, but some of them ah got out but many of them. We just keep them inside our own community and but they turned out to be very useful once you try to apply it to. Power levels from the other community and that work is like um, one attempt in that direction. So we essentially took some ideas from the generic programs to try to compile distributed the machine learning systems more efficiently.

_AL_: Yeah, so that sounds very good. So I mean one thing that is sort of remarkable I think and in a positive way is that you look around at researchers. There are some like I used to be when I was still doing research who are only ever doing one topic and writing the one paper about generic programming in Haskell with roughly the same collaborators and then you have some people like you who are doing like new things and really great new things all the time with different collaborators and different places and I mean how do you do that? I mean how do you avoid the temptation of just like um. Yeah I mean basically iterating on what you've already done and how do you find all these people to work with and I mean it seems to like is it something that so just happens to you or is it something that you're actively trying to do right.

_NX_:  Right? Um I think there are one questions the None is like how I choose like research topics and the second is how I find all my collaborators. So um I start with the second. So essentially lots of my collaboration happened either through internship or a research visit. So for example during my phd I did the internship at Microsoft research which then this is how I get started with Koka. And did an internship with Google Summer of Code with Richard and this is how I started work on tap system for ghc and I work out with Dimitris at the deep mind and I started working on programming language for my learning system and why I like work out so many differents instead of just working on a single topic. Um, as. Ah, part of the reason is I I basically start working on project if I found it interesting um, so it's sort of more interesting to me like once you have like a totally a totally different topic. And you work on like very different things and you learn new things and you make that new breakthrough and but of course like um, many people like to push one direction like very hard to its stream I think that's a good style too. Like I can. For example, imagine if you pick up one of my paper and as there are like count of extensions. Ah you can continue working in that direction. Um, but I think the problem but I have is you have so limited time during your Phd like you were needed to choose between different research projects. Um I think for me because I'm like more excited in like working on all like those differences so this is what I did but like maybe for you, you have more more excited about like more specific topic and you really want to push it hard and to see where the limit this limit is I think.

_AL_:  What? yeah no I think I mean you're right I mean I'm not I'm not saying one is better than the other. But I mean it certainly seems to be like more exciting and actually yeah I mean sort of better to have your style I mean because.

_NX_: Both styles are good.

_AL_: I think it's better to like discover all sorts of new things and then like basically create new topics for other people to then incremental work on later these are sort of the the big discoveries so to yourself that that I mean like if you can do that if you can pull that off. That is great I mean I certainly I think that is actually the superior approach I think it's just um, like I yeah I wish I could do that? Um, but um, yeah.

_NV_: Is it all me is it the case that working on different projects actually help you combine knowledge that or even applying all that I don't know for example in your deep mind project. Did you use any effects or any of the fancy data extensions that you had.

_NX_: Um I did not use effects for that project. But what I did in that project is I used the haskell for my prototype. So I'm actually writing haskell at deep mind. Yeah, and then my Haskell code is still in the google code. Yeah so yeah, that's not so much about type system. Ah but I I did insisting on using functional programming for that project as well.

_NV_: And how is it working on deep mind?

_NX_: Um, how is it working at deep mind. Yeah, um, it's pretty cool. Um, so because ah well I was working with Dimitris and deep interest is more like person. So. You know you know you understand each other pretty well. But for that project. We also have 2 like ah more like machine learning ah engineer and then you will start feeding sometimes you are like talking about things like differently that you. Like use terminologists differently and sometimes you can misunderstood each other.. It's kind of also interesting because there you start to learning a little bit about the machine learning side and they start to learn you a little bit about the programming languages sign and in the end you find this project. It is not purely machine learning Programming. Or machine line system. It's not purely program languages but it's like program languages apply the to machine language systems I think this is a very good way to find like new directions with like the the intersection between different research areas. And because of yeah, um, since I'm going to start as a professor somewhere. So I think I'm going to work with my students and that's like a totally different challenging.

_NV_:  And do you know what is next? what is your next collaboration or your next topic.

_NX_: And of course I will try to get my students interested in like topics I have worked on so I'm pretty sure I can give them enough guidance in that particular direction. But I also hope I can be driven by the students. So the students can work on topics that they feel excited about and then I can start working with them. Together on different topics.

_AL_:  Ah, so but you don't know exactly where you're going to start yet or that's something that you cannot yet disclose. 

_NX_:  Um, ah yeah, kind of lost. But yes, um, we were no, we were no soon. 

_NV_: Okay, but if any of our listeners is looking to do a PhD It would contact you right.

_NX_:  Yes, yes, please contact me Yes, it will be happy happening to to receive your applications. Yes.

_NV_: Okay, and do you have any final thoughts on like the future of Haskell or of functional programming whether you want to change.

_NX_:  Right? Um I think generally in the programming languages ah research. Um I think I want to say ah people should start more like looking at problems for like other companies. Um. Because we have all those to us methodologies. Um, we should be starts thinking how we can make that useful ah to to the real world like we can of course keep in developing like ah research languages New languages. But but most of them are not delivered. Like real- world users. Um, So if you want to like more make like more impact like I would actually suggest to um, try to look at problems for other communities and then try to combine our methodology and with different communities and to work more on. Different like research topics like functional programming plastics.

_NV_: Okay, what's really nice.

_AL_:  And and do you think that the like I mean you think that researchers are in a good position to I mean I don't I don't want to make it sound dismissive but I Um, but I mean it's a. It's not self-evident to me that like somebody who's primarily working as a researcher can aim to write a library that is like sort of well-maintained over time and will have the acceptance and the users and will have the industry strength and that is often I think just too much to ask. For somebody who's coming from Academia and um, but I mean but you think basically that is what what people should try to aim for to to write things or to to create things that are actually useful in real life.

_NX_:  Right? I think that would be the per post of like doing research because essentially you want to push the limit of knowledge and that you want to create new things that are useful for the word but of course it takes time to see the impact like.

_AL_:  Um, and my  hope.

_NX_:  Even today we we often seeing the paper we are applying like ideas developed for the like thirty forty years ago and that does not mean like those ideas that they fought for the years ago they are not useful, but it means like they are even more useful now than they were like thirty forty years ago And that means to make your research like more practical and widely adopt. It does take time and especially if we wanted to deliver your research into like industrial or like a real water products. Um I can imagine you are doing probably doing research that will be useful in like five ten twenty years later and that's totally fine. But I think as a goal is you should enforce practical ah projects but not just developing ah like with just like for paper purpose say let's say.

_AL_:  Okay, yeah, that's perhaps um, a nice final message and yeah, thank you very much ning for taking the time to talk to us.

_NX_: Um, yeah, thank you very much I really enjoyed it. Thank you so bye.

_NV_: Thank you.