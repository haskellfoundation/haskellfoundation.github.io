*Andres Löh (0:00:11)*: This is the Haskell Interlude. I’m Andres Löh, and my co-host today is Niki Vazou. Today’s guest is Alejandro Russo. Alejandro is a professor at Chalmers University in Gothenburg, Sweden. He’s an enthusiastic functional programmer as well as a researcher in the fields of security and privacy. We’ll talk with him about the unique strengths Haskell has in these areas and how to move research ideas into industry. 

Today we have Alejandro Russo with us. Welcome.

*Alejandro Russo (0:00:41)*: Hi. Hi, everyone. Happy to be here.

*AL (0:00:42)*: As usual, as the first question, we’d like to ask, how did you get into Haskell?

*AR (0:00:48)*: So that was back in the days when I was still in Argentina. I think it was on the third year of a five-year career where we got into functional programming. So there we got to see Haskell for the first time, and I completely fell in love with that.

*AL (0:01:03)*: So you actually used Haskell for that functional programming--

*AR (0:01:07)*: Yeah. So we were using not GHC, we were using Haxe. We wrote in the beta version, the early version of that in the ‘90s. And I remember that what blew my mind was polymorphism. I think that’s what ignite my passion, was when we saw how to do a stack, a queue for any type. And that blew my mind. I remember that. That was super impressive. And the second thing that blew my mind, it was when we wrote many recursive functions and then we could rewrite all of them with fault R or fault L. I think they were the two things that completely blew my mind and put my heart on functional programming.

*AL (0:01:46)*: What other languages did you know at that time?

*AR (0:01:50)*: At that time was C, C++. So I was proficient on that, Pascal. I’m revealing my age with this, mentioning these languages.

*AL (0:02:00)*: Yeah, that sounds familiar, but I mean, these are really languages which make you appreciate something like parametric polymorphism, because they’re these sort of classically, statically typed languages where doing something that is generic over multiple times has always been a little bit tricky.

*AR (0:02:19)*: Or imagine writing a list, doing a list in C was a pain and you get it wrong. And then here, it was built in. But this is more data structure. But I mean the power of how the functions and the polymorphism blow my mind.

*AL (0:02:31)*: So you didn’t have this sort of reaction that many others in those days had that this is just a toy language and it may have nice ideas, but it cannot possibly be used for anything real?

*AR (0:02:42)*: At that time, I didn’t care. So at that time, I was in Argentina where I study. So to give a little bit of context, we were being taught by mathematicians mainly. And 80% of the education was based on mathematics. So it’s all about the mathematics, the beauty, how to express complex ideas in simple terms to get insights about what you’re doing. And that’s what actually-- that’s what I carry at that time. So there was none of these questions about what industry is using and so on. No. My mind was on mathematics. I know, I think I should add. When I saw that we could do proofs or calculate programs, that as well blew my mind. And I felt that I had all the tools for exploiting this. 

*Niki Vazou (0:03:24)*: But you had this proof *(0:03:24 unintelligible)* in the Haskell class too.

*AR (0:03:28)*: Yeah. So we were like-- the classic example like proof that reverse of reverse of `xs` is equal to `xs` with a strong education in mathematics. So induction for us was supernatural. So yeah, we could reason all about that. So we could do this kind of proofs.

*NV (0:03:35)*: But not mechanized?

*AR (0:03:37)*: Not mechanized. No, no, no, no, no, no. In the last year of my education, we saw-- I went to a course called Formal Methods, something like this. By then, I had some misconceptions about formal methods like, “Oh, this doesn’t scale. This can’t be used by anything.” But that was two years after I found Haskell where I didn’t care about that. But in the last year, I care about that. But then I went into the class and I was a professor in Nora Szasz, I did the PhD at Chalmers. And the first class was about Curry-Howard Isomorphism. And then after I was in that class, very skeptic, I was convinced I will take this course. And then I went with all mechanized proofs in the last year of my studies.

*AL (0:04:22)*: That was sort of in the nineties, I guess, if you said you were using--

*AR (0:04:25)*: Yeah. I finished-- it took me a little bit to finish because I was teaching as well, and with that teaching, I was supporting myself. So it took me like eight years to finish, but the education is five and usually people finish it in six. It’s like the German diploma address. So it’s kind of bachelor plus master, if you wish. But it’s only called-- it’s only one title. 

*AL (0:04:45)*: Okay. So at what point did you then decide to continue in this direction?

*AR (0:04:50)*: Really, I think in the last year of my studies. Again, to give a little bit of context, we didn’t have any FP researchers at the university. In Argentina, there were very few, less than five. I think there were like two, and there were not in my city, right? So then what we did with some classmates, just we read papers, we read papers, we read papers. And then someone called Simon Peyton Jones, someone called John Hughes, and we read papers and we got super inspired. And then that’s how I decide. After reading all these papers, I said, “I love this. I love this way to program. It’s completely new.” Yeah, I’ve been promising since I was 10, but this was a completely different way of thinking, and I love it. So then after I got the functional programming course at my university from the 3rd to the 5th year, I think I was pretty clear that I wanted to continue doing functional programming.

*AL (0:05:43)*): But then you wrote a thesis in this direction, I guess, still in Argentina, and at some point, you somehow decided to go to Chalmers, or it happened in some other way. So how--

*AR (0:05:55)*: Yeah, yeah. So what I did is, I had hand down one of these researchers, Pablo Martinez Lopez, known as Fidel as a nickname. And he was like in a different city than mine. So then I was traveling every week. I was traveling to do the thesis. And my thesis was an extension of his PhD thesis that he was doing at Chalmers with John Hughes. So my thesis was about Type Specialization, doing partial evaluation at the type level for simplicity. And I did an extension of that, and I do some implementation. And then I wrote that in 2004. I finished it up. And then I start looking for PhD positions, of course, outside Argentina, because as I said before, Argentina was not very strong in functional programming. 

*AL (0:06:47)*: But then you naturally had a contact to Chalmers and found a way already. So, okay. 

*AR (0:06:52)*: Yeah. I got a contact with Chalmers, but I sent on the papers and so on, and then I didn’t get selected. So the first time I applied, I didn’t get selected. That was a bummer. But I was competing with the super smart people and then I knew who they were, super smart people here at Chalmers. So then I went to the US because I had an offer there, but as well, I have a scholarship in Argentina with some other people. So then, “Okay, I’ll go to the US.” But after six months, I realized this is not what I want to do. It was quite stressful because you know--

*AL (0:07:23)*: It was also on a PhD position or--

*AR (0:07:26)*: PhD Position, but it was more on pi-calculus line of things.

*AL (0:07:32)*: Okay.

*AR (0:07:32)*: But it was-- I didn’t feel it. So then after six months, I resigned. I was going to go back to Argentina to do some stochastic model with some people that I know, that I got along very well with that. In that period, I came across Andrei Sabelfeld, one of the professors here on Chalmers, on security, not on functional programming. It turns out this is destiny, right? So it’s like, it turns out that he hired a PhD student that in the end decided not to come. He knew me from a summer school that we did in Uruguay in 2003. And then he told me like, “Well, I’m looking for a PhD student. If you say yes, in two months, you can be here.” That’s how I got into--

*NV (0:08:11)*: That was destiny. 

*AR (0:08:12)*: Yeah, totally.

*AL (0:08:14)*: There’s always the coincidences. Yeah. It’s amazing how this always happened.

*NV (0:08:19)*: But it was very brave that you just quit within six months.

*AR (0:08:23)*: Yeah, it was quite stressful. When I was thinking about quitting and so on, I didn’t have anyone around except a guy that I just met in one summer school, Marco Gaboardi, who is now a collaborator of mine. And then in that critical decision moment, he was there to support me. Yeah, it was not hard because you’re thinking like, okay, this person will be my advisor, he is going to do retaliation activities against me. You should think that, yeah, it was the first time I was traveling abroad that I was meeting international people. It was super stressful. But in the end, I say, “Okay, it’s my life.” And I decided I will quit the US. I’m going to go back to Argentina. But in between, this chance just happens and then I took it.

*AL (0:09:05)*: And after this experience, which wasn’t so great and made you cancel, were you then worried of accepting the Chalmers position under these circumstances, or did you just say “Hooray,” like everything is going to be fine after all?

*AR (0:09:21)*: No, no, I accepted right away. I thought about it, but I said, “Okay, let’s go. This is where I always wanted to go.” I’m not going to work with John Hughes, but I’m going to be a Chalmers, right? And then it turns out that my advisor, after I arrived, it was great. Andrei was great, and really the topic-- I really caught on the topic quite quickly, and I enjoy it. But of course, I came to Chalmers. But I guess every PhD student is faced with this dilemma, like you get accepted and then you see your PhD mates and then you say, “I’m at a level. Can I deliver?” Then all the oppression comes, not the one to get in, but to show that they did the right decision. And of course, I got this feeling. But then I think after two months or three months, I start publishing in top security conferences. The first one was in Computer Security Foundation after three months I was Chalmers. So that means-- and that kind of relieved me. I said, “Okay, I did the right decision.” And then everything was smooth.

*NV (0:10:26)*: So this is what made you maybe merge Haskell with security and privacy, right?

*AR (0:10:32)*: I always wanted to do that, but I was hired here by European Brussels, so we need to deliver certain stuff. So I was focused on security. And so for two years and a half, I was not doing any Haskell and security. I was just doing security, more operational semantics, imperative languages, and so on and so forth. But then in the last part of my PhD, I finally got the chance to work with John Hughes and Koen Claessen. So I got all the security knowledge already in a different setting. And then we work on translating it into Haskell. We were not the first ones. The first one was Peng Li and Steve Zdancewic. They wrote how to do security using arrows. And that was a very motivating paper that they wrote. And then when I wrote that and given what I knew from security then, I realized that we could do the same thing in Haskell using monad in a more accessible way.

*NV (0:11:24)*: Oh, is it the LIO?

*AR (0:11:26)*: No, that was the SecLib. It’s called SecLib. It was the work that captured the tension of the people at Stanford that then we collaborate in creating LIO. That was not the LIO; it was SecLib from 2008, Haskell Symposium 2008. But that was the seminal paper that some other people around the world got the idea. And then we developed LIO inspired by this paper. 

*NV (0:11:48)*: So do you maybe want to describe what is LIO?

*AR (0:11:53)*: Yeah. So as described, my researches on information is-- the research I’ve been doing in functional programming is information flow control. Information flow control is about essentially seeing how data moves in your program and try to detect what some insecurities might arise. And the demonstrational example is like you have a secret in your program and you do not want that that secret is being leaked by the code, right? And then you do some tracking. You track how data moves within the program. And if you see that the secret or any information derived from the secret reaches some public sync, then you raise an alarm. And there are different ways to do this. You can do this tracking mechanism using a type system, so in a static way. And that’s what the SecLib paper was in the Haskell 2008. But then you can do it as well in a dynamic way. The dynamic way, rather than using the type system when you execute the program, the semantic that you give to the execution of the program also includes this tracking of how secrets move along the computation. And then you need to remember a runtime, you need to do checks all the time to see that information is flowing in the right places. And that’s LIO.

*AL (0:13:03)*: So basically, if I understand correctly, tracking it dynamically also means that you would get a violation error only at runtime. So you would trigger an exception that your code then somehow has to handle, but it’s probably similar to other situations that you can do more?

*AR (0:13:20)*: Yeah. At the time, some years before LIO, it was not clear what was the advantage of-- well, people were arguing that doing statical is better because you don’t fail on runtime. Because when you fail at runtime, you are giving away information, right? So it was this concern that by failing at runtime, you might be leaking more information than in a static way. But then we prove. I didn’t prove it, but some people here at Chalmers prove that when you have a type system, you can stick leak at run time because you don’t capture termination. It’s super hard to capture termination. And then it means like, even though you do type check, the problem might loop and you might be leaking some information by looping. And all that has a correspondence to failing in runtime because of security error. So there’s a result that says essentially they’re both, the static and dynamic one, they’re both leaking in a similar way. So given that, the community felt really more secure, more robust that, okay, dynamic mechanisms can also be deployed. The leakage doesn’t go to the sky. And by being dynamic, you can be more permissive. You can cut some slack to the programmer. It doesn’t need to fight with the type system all the time to make the security types correct. So as you say, Andres, if you’re dynamic, you have more flexibility for the people and it is more easy to use the system. And LIO is one such system. 

*AL (0:14:41)*: So would you say from today’s perspective, LIO is sort of still the library that people should be using if you’re interested in tracking this stuff, or are there better approaches now?

*AR (0:14:53)*: No, I think if you want to build information, practical information flow systems, LIO is a good starting point. But I came across people that prefer static systems. If you have like one or two security levels, the way that information flow control works, as I said before, it’s like you have different degrees of sensitivity on data. So data is sensitive, and so data is public, right? So if you got these two distinctions, you can use a static one while dynamic one is kind of the same. But you start having different degrees of security, like I have information that is sensitive to Alejandro, information that is sensitive to Niki, information that is sensitive to Andres. There are three different levels, right? What happens when we combine information from the three? What is the level of that information? How we track that? If we are in that situation where we need to consider different principles with different concerns about their data, for that, the LIO is a way to work.

*AL (0:15:46)*: And so now on a technical level, I’m assuming that LIO is essentially just a replacement or extension or a wrapper around IO somehow in the Haskell context?

*AR (0:15:57)*: Yeah. 

*AL (0:15:58)*: But how does it interact with sort of monad transformers or effects or these kinds of things? Is that unproblematic or that’s a big trouble?

*AR (0:16:09)*: I’d say like for effects, and this is something that happens across most of the security libraries, you need to cook in the effects within the security monad. So in LIO, you have the LIO monad, and then if you want references, you need to lift the original operation of references into the monads, and then you need to get the security checks that you need to do right. But we have done that, so we know how to deal with references, with exceptions, even with concurrency. But yeah, information flow control is a very tricky area, which makes it very interesting because any new feature that you add to the language, regardless how innocent it might look like, it might be a potential source for leaking information in an unintended way. So you add the feature because you want more expressiveness and you think, oh, the security systems are okay. But then it turns out that they’re not because there are some subtle interactions with some of the features that opens a leakage channel. 

*NV (0:17:00)*: So is it actually implemented as a monad or as a monad transformer? Because if you just put it at the top level and make sure that all the operations just make the proper text, then it sounds that you don’t care what you lay below it.

*AR (0:17:15)*: In the beginning, we were using monad transformers and so on and so forth, and I think in the name of performance, at some point, we collapsed everything. So now it’s a state monad that has the IO underneath. That’s what I recall from the last time I looked at the code. But in the beginning, we were doing different layers, but then we realized, oh, we need to reason, like can we-- it should be always on top or it should be always the one at the bottom, right?

*NV (0:17:39)*: It’s not obvious, the answer to it.

*AR (0:17:40)*: Right, it’s not obvious. I have a paper on DCC, it’s Dependency Core Calculus. It was kind of the first idea that shows how monads could be used for security for pure computations by Martin Abadi and others. In some other paper that I have, we push that super far to see how can we stack effects on top of something pure, right? When I say pure, sorry, it’s like effect-free. Effect-free like we cannot add references, we know how to do that. Printing effect, we know how to do that. But what about reading a file? And then you hit some limits. And then you need to kind of change the approach. I have a paper, and then so many people have done more work on that direction to have the security monad at the bottom and then just build all the things on top of that.

*NV (0:18:24)*: But the intuition is very clean that like monads-- I mean, it seems like that monads are kind of designed to track security.

*AR (0:18:32)*: Right. So the way I like to think, I mean, if the monad is in the way, for security, the key point is like once you get in the monads, you kind of get out essentially.

*NV (0:18:42)*: Yeah. And it’s what you said, like the polymorphism. 

*AR (0:18:45)*: Yeah.

*AL (0:18:46)*: If you use polymorphism M level, then just everything works out.

*AR (0:18:50)*: Yeah. So it is very nice abstraction for encapsulating computations and controlling because the monad encapsulates-- if you think of monads, it has two com-- if you say on monadic computation, abstractly, two things can happen:effects and then some pure computation, right? So in the bind, you put let X equal 1 plus 2, whatever, right? We know that the effect-free parts will remain within the monad because no information is going out, only to the result, but then the effects might escape. And then you control that by the monadic interface. So in that sense, the abstraction of monads is great for security. And that’s what Martin Abadi and others realized back in the ‘90s in the Dependency Core Calculus.

*AL (0:19:29)*: So just briefly going back to your history, if I understood you correctly, before then, LIO stuff already came after your PhD? 

*AR (0:19:39)*: LIO came after-- yeah.

*AL (0:19:40)*: Well, at some point, you somehow got the opportunity to stay at Chalmers after your PhD or--

*AR (0:19:46)*: Yeah, the story is like this. The PhD is five years, right? And I finish in three. And I think three and two weeks or something like this.

*NV (0:19:55)*: You recovered the year, the next three years at least undergrad?

*AR (0:19:59)*: Exactly, yeah. And then there was some fun in life and then I didn’t-- by then, again, I was not strategic. I didn’t think, oh, I should do a postdoc somewhere. I was more like happy-go-lucky. I said then things that I don’t say to my students today because today, my student wants to follow in academia. It’s so competitive. It’s a very good advice to be strategic. But I was not strategic. I was just enjoying myself. So I think I’ll postdoc for a year at Chalmers. I signed with Chalmers as an Assistant Professor. There was-- again, it was destiny. There was a position for Assistant Professor. I was not going to apply. And then I came across on the corridor Koen Claessen. He told me, “Do you apply, Alejandro?” It was the day before the deadline, right? “No, I’m not that functional programming because most of the work has been on security, on imperative things. No, no, no.” And then Koen convinced me. So then from-- I think it was from four in the afternoon, till 10 in the morning, till the next day, I was cracking the application. You need to do everything. So I did that, no sleep. And I applied. Yeah, it was very good. I mean, very strong people. It was like Dimitrios Vytiniotis, Ulf Norell, like super, super. And then I said like, “Okay, I’m not going to get this. It’s like, it’s impossible.” And I didn’t get it. Demetrios was first, but then he didn’t accept. And I was second. So again, it was never easy.

*AL (0:21:29)*: But then Demetrios went to MSR.

*NV (0:21:33)*: I was surprised because I knew Demetrios was at MSR and he was actually my first internship.

*AR (0:21:40)*: All right. Yeah, no, great guy. We got to collaborate on a paper later on, on security. No, I really liked him. But yeah, it was destiny. And then I signed with Chalmers. And I think two or three weeks later, I got a phone call from David Mazières, a professor at Stanford that read the Haskell 2008 paper. He’s a system guy writing C, C++. And then he called me and said, “I’m a professor from Stanford. I wrote big functional programs.” So I got it and it’s all, “A big chunk is based on your idea, so you want to come to work with us.” And that was the process that gave birth to LIO.

*AL (0:22:16)*: Okay. And then it was a successful story because you’re still at Chalmers now, so it must have been very good.

*AR (0:22:27)*: Yes. But I mean, it’s life, right? So yea, that’s what it is.

*AL (0:22:32)*: But given that Chalmers is this place, which is not just very strong on functional programming and Haskell, but also is the sort of the home of Agda and has a very strong type theory group. And given that your research on security is certainly also like-- I mean, we’ve been talking about dynamic versus static, but it’s also very, let’s say, connected to learning more and proving more about your programs. Have you not been tempted to switch over to do everything independently type languages?

*AR (0:23:02)*: Yeah. So, in the beginning, when I came to Chalmers, I wanted to do type theory, right? Haskell and type theory because of this course on Formal Methods that I got in Argentina. What I’m doing right now is doing mechanized proof a lot or calculus or character models or system designs or languages. So now I’m more concerned on making impact, where impact means like perhaps going beyond allocations, like convince people to adopt our technology. And for that, I think it could be a high barrier entry to go dependent types. It’s not because I don’t like it and so on, but we are cheating a little bit because we are doing a lot of dependent type like programming in Haskell to some degree, a light version of that. So we are doing a lot of that. So that’s the way that I do this with myself, not changing on dependent types, but it’s great. 

*AL (0:23:54)*: Yeah, I mean, basically, you’re thinking Haskell is still the sweet spot when it comes to also being usable and practical.

*AR (0:24:01)*: That’s right. I can convince people like, okay, I should jump into this. 

*AL (0:24:05)*: So perhaps we can briefly talk about, since you just mentioned making an impact and something like being pragmatic up to an extent, one language feature that has recently been in discussion again that is also around in Haskell is Safe Haskell, and that is to some extent, I guess related to striving for security, security guarantees. Do you have an opinion on that?

*AR (0:24:31)*: Yeah. So actually, I was part of the initial discussion of Safe Haskell. And if you check the paper in 2008 for Haskell Symposium, it says like, okay, the security guarantees that we provide with the library, holes provided that. You can trust your types that when you say what type, it’s actually that type, or that module abstraction is not broken, right? And then we realized that by that time, Haskell had many extensions that kind of break these two and there was no clear way to put a boundary when you can use these extensions because you know what you’re doing and when you don’t. Not because you’re not doing, because maybe it’s code from someone else that you don’t trust, right? And then Safe Haskell came out as a solution for that. It turns out that for all my research and to give guarantees and so on, it really helps to keep this boundary where we can say, “Here, we can trust about the types and we can trust about module abstractions,” because in information flow control, you usually run code of someone else. You run code of someone else with your own data, which is sensitive. So you want to be sure that that code is following your types, it’s following your abstractions, and it’s not breaking that out. And Safe Haskell was one way to ensure that, but it could be some other ones. But then yeah, that was--

*NV (0:25:47)*: Can you give a more concrete example of some extension that breaks?

*AR (0:25:52)*: Right. For example, unsafePerformIO, unsafeCoerce, then overlapping instances as well. Like you have one-- in one module, you have your instance, which is polymorphic and so on, and then you have an overlapping instance in the attackers. Someone else write the code that is more specific than yours and it changed the behavior of your primitives, right? So I remember this attention that caused problems from--

*NV (0:26:17)*: When you use this kind of extension, the compiler gives you a lot of warnings, right? 

*AR (0:26:21)*: Right. Yeah, yeah. What you do in Safe Haskell, it’s like, you say like, “Compile this module without any one way-- the module is safe, compile everything that doesn’t break the types of abstraction.” Then you have some other modules that you say, “Here I can do whatever I want.” These modules might export things that break like safety, but these modules should not be imported by the safe modules.” And then there is another module which is like the interface. It’s safe to use. I know that the interface doesn’t break anything, but what I used to build that interface can be whatever I want. So yeah, but it was like 2011, I think. More than 10 years ago that we developed this concept. I was in the initial discussion, but then there was some other people that followed on that. So that’s what I remember from this. It’s the only language I’ve seen around Haskell that passed this boundary of we like types, we like abstraction, but then we also know which part of the language respect that and which part of the language do not respect that, usually because of performance reason, which is fine. But then we have a boundary that separates a responsible use of that versus an irresponsible use of that. And I think that’s great. That’s what makes all my research and security work.

*AL (0:27:39)*: But given that Haskell is a language that gains new extensions all the time, I can imagine it’s quite tricky to actually be reasonably certain that you’ve covered all holes, right?

*AR (0:27:51)*: That’s right. Yeah. That’s one word that needs to be done. And we love extension that we love new-- you play with the language. That’s what’s this community is great, doing things like that. And it’s awesome because it pushed primary languages to academic stage. But yeah, I mean, a new extension needs to be thought. From a security perspective, it will break it or not. But this is kind of-- it’s not different from adding a new package in a big repository.

*AL (0:28:13)*: No, no, no. I’m not saying it. I’m just saying it’s difficult and somehow, I don’t know. I mean, it feels to me like back when I saw Safe Haskell appearing, I kind of remember this. I thought it would be a really big thing and there was quite a bit of buzz, but somehow, then very quickly it turned out that nobody really seems to have started using it on a large scale. And perhaps that is contributing now to sort of the discussions about whether the maintenance costs of it is worth it. And I think there’ve always been some perceived problems with the practicality of it, or perhaps it was perceived as too difficult to use or too difficult to use safely. But if I understand you correctly, you’re a firm believer that we need something like this and we should rather aim to fix it than to just drop it. 

*AR (0:29:01)*: Yeah, totally. But as I said before-- you say, well, put in a boundary. We put a boundary at the module level. Maybe it should be at the package level. Not at the module level, at the package level, for example. That could be one of the revisions. If you had a new extension, maybe it’s unsafe by default, but then Safe Haskell allows you to automatic-- Safe Haskell comes with a certain classification, what is safe or it’s not safe. But you can change that in your own instance, right? The question is like, how difficult is that for the users? How much do you understand? What can we do to improve that understanding? Right?

*AL (0:29:33)*: So you’re saying rather than just having one notion of safe, that you can define your own policy? That you’re saying like, I consider this language extension inherently unsafe even though others believe it to be safe and I want to be--

*AR (0:29:47)*: Yeah, it’s your responsibility, right? So if your company says, “No, unsafePerformIO. I don’t care how people use it.” “Okay, sure, that’s your call.”

*NV (0:29:54)*: If everyone thinks of safety in a different way, then what would Safe Haskell mean, right?

*AR (0:29:59)*: Yes. Safe Haskell, I think that Safe Haskell put this boundary and then I think the boundary now is put by some community. But what I’m saying is like, we should be able to move that boundary in an easy way. The important thing is the mechanism that is in place to say, we trust on this, we don’t trust on that. And then how flexible that is to be changed. I don’t have a clear answer for that. The important thing is this, how you label the modules in an automatic way and the flexibility to change it so that people understand. “Oh, it’s failing because of Safe Haskell,” and then you do it like this. You took two lines and then it’s done. But then I’m taking responsibility for this, right? So if something wrong happen in a company, you can see in the company, “Oh, someone changed this.” Okay, yeah, sure. Okay, you have accountability. So I think that’s a great thing from the security perspective, and thinking about more and more regulations on data, how you handle data, and so on is coming up. And sometimes you need to be certified and sometimes people need to look at your code. And I think if you have a system, things like types and Safe Haskell, I think it could be a plus. Of course, not everyone might use that, but I’m just saying there are some use cases where this really pays off.

*AL (0:31:05)*: Yeah. I mean, in terms of making it more general somehow, I mean, there’s certainly lots of companies that are to a much smaller extent, but they’re tracking code quality properties throughout their code or that are not directly security related, or other people are tracking licenses or something like that. So I think all these things are, to some extent, connected or certain mechanisms could be possibly shared among all those whereas like-- and there are probably still some specific requirements for anything like hard security guarantees. But yeah, it’s certainly an interesting area and I also would like to see that this somehow continues existing though. Let’s hope the discussion goes in that direction rather than to drop it. But one thing that is also coming along with this habit of GHC of gaining new features all the time is that it’s accumulating more and more features and then there are some pressure to, at some point, drop features that are perceived to not be used very frequently because they all continue to have a maintenance cost. That’s perhaps a sort of a general disadvantage because not always the popularity of a feature is a statement of its quality.

*AR (0:32:21)*: But what I’m saying here is that perhaps there is a different, more lightweight to do this. I think that idea is right. The setting is right because all the security libraries, they work because we are in a pure language. So we control effects by the type. And I haven’t seen all the languages having these kind of features. Now how it’s implemented, I’m up for discussion for that.

*NV (0:32:40)*): Maybe it could happen automatically. Based on your code, I don’t know, the compiler can decide if this is Safe Haskell or not.

*AR (0:32:48)*: Right. But then you need to know which extensions are dangerous and then we come back. You come back. How you label-- I don’t know, it could be like different ways to label extensions and then one for super security-related companies, one for not so much security interest, and then you just have a flag that say X Safe Haskell super secure, another one that say Safe Haskell relaxed, and then that’s it. But that’s from the user perspective, from the developer. I don’t know the maintenance cost because I’m not very familiar with how that is maintained, what it takes to maintain this, what are the problems. I’m not very familiar with that, but we are happy to discuss about that.

*AL (0:33:28)*: Okay. Let’s talk about more recent times perhaps. So you’ve been recently doing a lot of things on differential privacy and you’ve even set up your own company, so perhaps you want to tell us a little bit more about that.

*AR (0:33:43)*: Right. Yeah, yeah. So 2020, we published a paper in security and privacy, one of the flagship conferences on security, where we show how to develop a system that uses differential privacy. Differential privacy helps to release data. So you have some data that you want to keep it secret, but you want to release some information about that data, some analytics on that data. For example, you have salaries. Like in the US, you have salaries and you want to release the average of the salary, right? By doing so, you don’t want the people observing the result of the analytics can infer who is in the dataset. Okay? This is not like-- information flow control is about confined information to be in a place, stuck in a place. This is about releasing information in a way that you preserve the privacy of the people in the dataset. And differential privacy is one of such techniques, come from academia as well, has strong security guarantees when you can reason mathematically, like in crypto. What are the guarantees that you get when you release information using differential privacy? 

So what we did in this paper in 2020, we have some innovation on differential privacy land, but what we did was Haskell implementation that described a system where you can-- essentially, it’s like a simplified version of a query language, as a SQL query language. And then we use types to make sure that certain parameters that differential privacy needs when releasing data are taken in the right way. Differential privacy is quite complex and it requires to get many variables right. And then we use a lot of type information to make sure that those variables are taken into account in the right way.

So we released that paper. And after we released that paper, we were approached by two companies to release the code. And then I talked with one of my co-authors, which was Marco Gaboardi. You know that person that was with me when I took this life-changing decision, he came back. And then we decided to create the company because we believe in pushing research results out there. And my experience is like, the best one that can do that is yourself. So if you think that you can do research and someone that will take on and so on, yes, that might happen, but you’re in a much better position because you developed the technology.

*AL (0:36:00)*: So basically, that decision came about because you were directly approached by companies and it was very visible that there would be a willingness by companies to pay for this. 

*AR (0:36:10)*: Right. And because we have the vision that-- I mean, my whole life I’m okay for security and privacy and I see that there is a lot of digitalization going on, and I would like a future where the privacy is respected as in the physical world and the digital one. And I see that society is going there, right? All about data, all about digitalizations, and a lot of regulation on how you handle data are popping up. In Europe, there are many initiatives, GDPR, Data Governance Act. There are many, many. So now it’s the right time to show that our research actually can help other companies and solve some real problems.

*AL (0:36:49)*: So does Chalmers make it easy or even support or encourage setting up your own company as a researcher?

*AR (0:36:56)*: Yeah. So Chalmers has a very good support for the first steps, right? When you say, “Oh, I have this idea. Is there a market for this?” Because you always need to have-- we are academics, but you need to have a market, you need to show the potential, and so on. And for that, they have support. And then we got in one of the-- all departments at Chalmers is a double department. It’s Chalmers and Gothenburg University. So I’m a professor actually in two places. Even though I have one position, I’m a professor in two places. So then we got into the incubator of Gothenburg University and they really helped us out pushing this forward, how you set up the company, all the legal aspects that are important as a company. If someone thinks about this, it’s like, this is one advice and I remember that was super useful for me. Some of the persons there told me like, “Alejandro, you like to code, right?” “Yes.” “And you like to code to be beautiful, right?” “Yes.” “Okay.” In a company, all the rest, meaning the accounting, the contracts, and everything, needs to be as beautiful as the code. So because this is what the business people we look at, and the more beautiful you have it, the better it is to convince them that your company is serious and can do some real changes.

*NV (0:38:09)*: And so in the end, did your company end up collaborating with the other two companies that approached you?

*AR (0:38:14)*: No.

*NV (0:38:15)*: So what they wanted to do, you did it like yourself.

*AR (0:38:18)*: Yes, we did. Yeah.

*NV (0:38:20)*: Did you get approached by these companies because of S&P or do you think that the security conferences have more visibility than programming languages ones?

*AR (0:38:29)*: Yes, I believe so. So I was lucky enough to publish in CCS, for example, with Haskell papers. Security and privacy with Haskell papers. It’s not only Haskell; it has something about the area and on testing. But you see, for example, CCS, it has like 800 submissions, right? S&P, I don’t remember right now, but it’s like they’re much bigger communities, right? So more people are aware of those conferences and I’m trying, so yeah.

*NV (0:38:57)*: And it’s closer to industry.

*AR (0:38:59)*: Yeah, it’s much easier to see how to do the *(0:39:01 unintelligible)*. I’m not saying that there is no peer research. I love peer research. I’m a peer researcher, but it’s a different thing to present. This has crypto system, this is and that, that’s showing calculus studies. I love those kind of things. But for someone from industry to appreciate the contribution, it takes much more effort from a PL paper than from a general security conference.

*AL (0:39:23)*: I mean, to some extent, I think it’s a natural thing, right? I mean, if you’re interested in security say, then you’re interested in that topic and not primarily in what language it is implemented in. So I mean, it kind of reminds me a bit, like back when I was still at Utrecht, we had the situation at Utrecht University where everybody was saying at the university, “Oh, functional programming at Utrecht is going strong.” And I was always saying, “Well, yes, but look, if you look at the courses, if you just look at the courses, it’s still very much split. Like if you’re doing data structures, you are using an imperative programming language. If you are doing security, you are using an imperative programming language. If you’re doing databases, you’re using an imperative programming language. And the only courses on functional programming languages are courses on functional programming languages.” So in a way, the real benchmark for mainstream adoption has to be to have functional programming papers in other fields, right, and other kind of conferences.

*AR (0:40:27)*: In my experience, they’re receptive. If they have good reception, it means like, okay. It has a different set of a skill in explaining for these communities and the peer communities because the focus is on different things. That’s natural. But they’re quite receptive about using functional languages, right? We got a paper accepted in one testing conference, ICST, CCS, Security and Privacy. These are kind of outside functional programming scope, if you wish, and there are not many papers, but I mean, if you show that you have an innovation, something new, and the language really makes a difference and so on, and then you show some vertical studies and so on, they’re quite open.

*NV (0:41:09)*: No, and this is a big success of the internals of functional programming, right? If you can get the ideas adopted by external.

*AL (0:41:17)*: So even though you did not end up working together with these two original companies that expressed interest, the company is up and running and going strong?

*AR (0:41:27)*: Yeah. So we were great in 2020, but things really-- that was Corona time, right? So it was not-- nobody wants to hear about innovation.

*NV (0:41:38)*: I like your past tense.

*AR (0:41:40)*: Right. So it was really, really sad. But things started happening in 2021, to be honest. So we got that collaboration with Ericsson. Now we are discussing going forward with them. Yeah, we have two full-time employees, now looking to raise some more money and make the team grow. 

*AL (0:41:58)*: How do you manage to juggle your time between-- I mean, setting up a startup can easily be a full-time or more than a full-time job. So doing that next to your university job sounds like a challenge.

*AR (0:42:11)*: It’s challenging, but in the beginning was just one more piece of student, right? In the terms of how much time it takes. So it was not that much. Now it’s a little bit more. But here at Chalmers, they were quite understanding. But then, it’s time to relieve my duties. And the way that you do that is hiring some people that can do what needs to be done. And I just focus on the only things that really can bring different value into the company. But sometimes we’ve been lucky.

*AL (0:42:38)*: So the software you’re developing for DPella is also written in Haskell, right? 

*AR (0:42:41)*: Yes. 

*AL (0:42:43)*: And did that change your perspective on Haskell as a language? So for the first time, not being sort of just a researcher using Haskell as a research vehicle, but really having to develop?

*AR (0:42:55)*: Right. So I love it. I think it’s the right choice. We use Safe Haskell.

*AL (0:43:00)*: Good.

*AR (0:43:01)*: So we use advanced type systems features because in-- and I can tell a little bit what the reason behind that. The reason behind that is there come many regulations in Europe. You might need to show that your code works. And orbit is like showing a code that has a lot of information and in variance at the type level. It can be easier to appreciate. The people can realize that you are doing things in the right way, that you put a lot of effort in doing things in the right way, that’s doing otherwise. I might be wrong. This is a leap of faith that we are taking when it comes to showing code to regulators, right? But as well for making sure that we’re doing things in the right way without going towards heavyweight methods, right? So using the Haskell type system is a lightweight system, if you wish. We’re doing codes, how much we can get the correctness of our code, right? And for that has shown to be magnificent. Yeah, I wouldn’t change it. I wouldn’t change it.

*AL (0:43:59)*: Okay. So there are no big features that you have on your wishlist or libraries that are lacking that you wish somebody had written or--

*AR (0:44:10)*: No. So far as what we have, I think we’re super happy with. I’m not missing any others so far. Yeah, so far, it’s fine.

*AL (0:44:16)*: Right. I guess also, I mean, like being at Chalmers, you never have to worry about finding people who could potentially work--

*AR (0:44:21)*: No, that’s him. Unfortunately, I had some people that wanted to work with us and we didn’t have the funds to support them. So having the opposite problem, which is, I’m going to say it’s nice to have because some of those people I would love to hire, but it’s kind of flattering that people want to come to work with you because we are doing cool stuff. And then when I got into the company, all the things that we are doing could be papers. So far, we are in this stage where it’s about product introduction. So it’s about differentiation in technology. So we are doing super cool stuff. All of these things could be papers and super smart people working there. We are not that many. So yeah, it’s a company that I would love to work at. 

*NV (0:45:06)*: So important. So you don’t have anything you wish to change in the future in the Haskell world?

*AR (0:45:11)*: Yeah. So I know this might sound-- it’s not related, sorry. It’s not related with the languages and so on. It’s more about on regulations and so on. I’m thinking from the company perspective, right? So you have a certain ISO, I think it’s 27001, that requires to have an automatic way to detect vulnerability in your software, right? Or a database of CVEs or the platform that you use. I think that we are missing that a little bit. I don’t know if you hear about this, Andres. You work with companies and--

*AL (0:45:42)*: No, I mean, it’s certainly an area in which Haskell could strive to be better. Like Haskell as a community is still a very community-driven effort, right? I mean, there are quite a few companies using Haskell now, but there are actually not all that many companies. I mean, I’m very grateful for the few that are, but not all that many companies who are really financially supporting the Haskell infrastructure. These kinds of efforts, they really cost because it’s not something that can easily be done in a reliable way by volunteers only. You need to somehow have paid people that ensure that this gets done properly. 

*AR (0:46:21)*: Yeah, I promise you that when we have some revenue, I will dedicate that--

*AL (0:46:26)*: I’m sure that the Haskell Foundation will be more than happy to also coordinate efforts in this direction if there was a willingness to support them. But I think, yeah. I think it’s one of these things that actually needs significant financial support to work. I mean, probably paired with some enthusiastic people who are also willing to do the initial effort. But yeah, that’s a good point.

*AR (0:46:50)*: Yeah, I think my conclusion is like some things about tooling rather than language. I think that-- we are PL researchers, right? So we focus on the language, right? I think on the tooling, maybe some things need to be further--

*AL (0:47:01)*: I think in general, the tooling has certainly been identified as the area in which there are lots of things that can be improved. I mean, we should also not forget, I think though, that there already are massive improvements being made all the time. I mean, like HLS becoming the de facto standard for development and things like that, and also improvements to Cabal and stack and installer and all this stuff. There are certainly lots of things that are happening, but there’s so much more, and that’s true. And the security-related issues are certainly one aspect of it.

*AR (0:47:39)*: I think Haskell has a unique chance to shine in security-related art by taking language-based approaches, right? Some primary language approach. I think it has a unique chance and it seems to be appreciated by different communities, in my opinion. But of course, I’m biased because I--

*AL (0:47:55)*: Okay, I think we should probably just end it here. Thank you very much. Good luck with your continued research and your company, and thank you very much for taking the time to talk to us.

*AR (0:48:06)*: All right, thanks a lot, Andres and Niki. It was a pleasure to talk with you and thanks for the invitation and having this wonderful chat on Haskell and related things.

s 5 *(0:48:17)*: The Haskell Interlude podcast is a project of the Haskell Foundation and is made possible by the support of our sponsors, especially the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and Meta.
