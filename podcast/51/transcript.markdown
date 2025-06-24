*Niki Vazou (0:00:15)*: Welcome to the Haskell Interlude. I am Niki Vazou.

*Joachim Breitner (0:00:18)*: And I’m Joachim Breitner.

*NV (0:00:19)*: And our guest today is Victor Miraldo. Victor fell in love with Haskell when foldr clicked, and later with Agda, when Haskell’s type system was not expressive enough. He introduced Agda to Oracle Labs, generically diff data structure for his PhD, and tested smart contracts until they made him use Rust. Today, he will tell us why the Haskell community is too smart, why there should be a safePerformIO, and that he hopes that software engineering could be less like alchemy. 

Hello, Victor. Great to have you at the show.

*Victor Cacciari Miraldo (0:00:58)*: Hey Nikki, glad to be here.

*NV (0:01:00)*: Do you want to tell us how did you get into functional programming?

*VCM (0:01:03)*: Yeah, that’s a great question. At first, I didn’t. I started programming rather early. So, when I started university, I was already writing some C, and my university in Portugal teaches Haskell as a first programming language, which was very interesting. It was a big shock. But they did a really good job, and they doubled down on it because they also teach Haskell as your second programming language and as your third programming language. Eventually, I just fell in love with it and I felt that this was definitely the right way of doing things. And then from there, I decided to do my master, following programming languages, and then my PhD in Utrecht, programming languages, and that’s how it went.

*JB (0:01:43)*: Was there a particular moment that you remembered where Haskell made click, and you noticed that this makes sense after all?

*VCM (0:01:50)*: I think so, and it was when I finally understood foldr. This was the magic little bit for me.

*NV (0:01:57)*: So, what did you understand about foldr?

*VCM (0:02:00)*: Well, once you first understand that different data types are also going to have their own variations of fold and it’s basically nothing special about lists, then it unlocks this expressive power that you say, “Oh, wait a second, why don’t we have this in every other programming language as well?”

*JB (0:02:17)*: I guess it makes you wonder whether it’s from a didactical point of view useful that list has this special status in the syntax, but not more than the syntax. So, it feels very built-in and special to the first-time student, but then you have to make the step and realize, “Oh, list is just one possible data structure, and they’re all similar.” 

*VCM (0:02:36)*: Yeah, it is rather magical in the beginning. What helps perhaps is to really teach something that, now, looking back, I appreciate very much was that they taught me Haskell, but in parallel, also an introductory to formal math where they actually taught us induction and a little bit of set theory. So, by doing these two courses in parallel was very enlightening to the students. You drew the parallels, and that definitely helped.

*NV (0:03:00)*: So, it was two different courses?

*VCM (0:03:02)*: Well, we had a bunch of Haskell courses. It’s a big focus, but yet I think having these two courses together definitely helped conquer this understanding sooner rather than later, and then not really being antagonized by the more magical concepts around Haskell. 

*JB (0:03:16)*: Did they teach it in a way that initially it was already clear that this is not just a nice teaching tool that tells you something about algorithms and formal methods, but it’s also actually a real programming language that you can use to solve real problems? Or is it something that you had to discover on your own besides the course? 

*VCM (0:03:34)*: I think I started discovering that a little bit after the course. In the beginning, especially having some preconceptions coming from a more imperative world, I was like, “Yeah, okay, this is all fun and games, but can you really use this?” And then after a few more courses, I guess I was fully convinced.

*JB (0:03:50)*: Yeah, it’s surprising that this is often just not part of what they teach you when they teach you Haskell at university.

*VCM (0:03:57)*: Yeah. And when they do, it’s really focused on compiler construction somehow. All the courses I’ve either taught or followed or saw, it really focused on languages. And it’s funny because it’s just a generally applicable language. We should perhaps find other problems to motivate students with.

*NV (0:04:16)*: But I mean, you cannot teach everything, right?

*VCM (0:04:18)*: No.

*NV (0:04:18)*: You cannot use the same thing to also do formal math and compiler construction and also like Yesod or other real-world problem-solving. 

*JB (0:04:29)*: So, you got interested in Haskell because university was having a really nice curriculum for that. And you actually went into programming languages for then your master’s you said, right? 

*VCM (0:04:40)*: Yeah. 

*JB (0:04:41)*: Any particular focus you did there?

*VCM (0:04:43)*: I focused on formal methods in cryptography, and this is perhaps the reason why I eventually went to Utrecht because my formal methods interest drove me to Utrecht to start learning some Agda. And I eventually finished my master thesis here. And then at that point, I was already fully happy with functional programming. I was actually rather unhappy with Haskell, I think, out of what we can do in practices, probably one of the better ones. But I still wish I had dependent types a little bit more at hand, for example, and this really drove me to Agda for my master. And I worked on proofs by rewriting in Agda. So, a lot of basically the version of Template Haskell, but for Agda. Then after that point, it stuck with me. I worked through my PhD in structural differencing, which is actually a rather interesting problem. Why is it that we can’t have better merging algorithms for all the languages? If you refactor a function and I change the name of a variable from weaving that function, why can’t my merging tool just understand that that function was refactored somewhere else and transport that change to the other side?

*NV (0:05:48)*: So, this is a theoretical problem or a –

*VCM (0:05:51)*: Oh, it certainly is because we need the definition of what does it mean to transport a change, what is a change, and all of those. All of this language should be pinned down. And the Unix diff is a great tool for line-based things. And we have this idea of add a line, remove a line, but that’s rather insufficient for programming languages.

*JB (0:06:08)*: Okay. So, I think we’ve just jumped into a bunch of interesting topics that we can probably look into closer. So, let me see this. You came to Utrecht and you wanted to do formal methods, and you did that with Agda.

*VCM (0:06:21)*: Yeah.

*JB (0:06:21)*: How much was that choice driven by comparing all the different ways of doing formal methods and making a deliberate choice to use Agda? Or was it just that that’s what’s being done in Utrecht and was good enough? 

*VCM (0:06:31)*: Yeah, it was more like it. That’s what’s being done in Utrecht. That’s what my supervisor knows and what the team knows. So, it was a reasonable choice to get started on.

*JB (0:06:41)*: And there’s crypto theory in Agda?

*VCM (0:06:45)*: Not much, unfortunately. Not to my knowledge. I think it’s quite rather difficult to beat something like EasyCrypt and to write the crypto algorithms that require – I mean, either if you want to reason about crypto, you need a lot of real numbers and probably distributions and all of these things. So, you don’t have built-in support for those in Agda, and that’s very difficult to do.

*NV (0:07:06)*: And EasyCrypt is a Coq library, no?

*VCM (0:07:11)*: I’m not fully sure exactly how it’s set up, but it is very much like Coq. I don’t know if it’s a library or if it’s actually built on top of it, but it’s closely related for sure.

*NV (0:07:21)*: That has all these math properties that cryptography requires, and they’re very difficult in Agda.

*VCM (0:07:28)*: Yeah, it’s very difficult to write down a probability distribution and to specify and say, “Oh, this is my cryptographic algorithm.” And the probability of an attacker breaking this game that we built is going to be specified by this expression. But this expression is often a real number expression, right? It’s specified in traditional math using real numbers, and therefore you would need to have pretty good support for those in Agda as well. And this is something that I’ve – at least once I was still using Agda was rather challenging, but a little bit of the Agda scene I haven’t followed much. So yeah. 

*NV (0:08:06)*: So, your master’s started with cryptography and Agda, but then the cryptography parts fell apart, or you’re still working on that?

*VCM (0:08:17)*: No, it has been a long time since I did any cryptography really. I think the closest work I’ve ever done with crypto was during my PhD. I did an internship at Oracle, and surprisingly, I actually wrote Agda for Oracle, which is something that surprises a lot of people.

*JB (0:08:33)*: Yeah, it does surprise me. 

*NV (0:08:34)*: Yeah, that is very interesting. 

*VCM (0:08:36)*: Yeah, I had a great team. We worked as a small team in Oracle Labs. One of the tasks was changing and formalizing consensus algorithms and authenticated data structures. And this is where really my Agda knowledge came in handy and my cryptography knowledge also came in handy.

*JB (0:08:55)*: Do you know why and how Oracle chose Agda for this task?

*VCM (0:09:00)*: That’s a great question. I’m afraid of putting my previous supervisor in trouble, but I don’t quite think they chose Agda consciously. It was just the tool that we had the knowledge in the house for because I was there.

*JB (0:09:11)*: Okay, same reason.

*NV (0:09:13)*: So, it was because of you. It’s not that the team were already using the –

*VCM (0:09:16)*: No, I think I was the first one using Agda there, and yeah, use it for a smaller thing, and then eventually people jumped into the Agda boat as well.

*JB (0:09:25)*: Okay. So, it’s a good strategy of getting industry to use a tool, just be the first in the field.

*VCM (0:09:32)*: Yeah.

*NV (0:09:34)*: But how was the experience of having Oracle programmers using Agda? You had to teach them, I assume.

*VCM (0:09:41)*: Yeah, but they already knew Haskell quite well. So, it’s not that far off a jump. If you’re pretty familiar with Haskell, it does give you the extra edge you need to really be able to confidently state your theorems and write your properties down and really make sure that, especially if you’re writing a consensus algorithm or a modification to a consensus algorithm, you really want to make sure that you’re not breaking any guarantee. So, you have to somehow encode those.

*JB (0:10:09)*: Did you connect your formalization to some kind of production implementation or was it just freestanding?

*VCM (0:10:17)*: No, unfortunately, it was only freestanding. Whenever it got to the point of fully connecting it, we were looking into many options. Back then, we tried something like Liquid Haskell as well, which would have been a great option. I think had any of us had a little bit more knowledge there could have been an excellent alternative. There’s this tool now called Agda2hs, I believe, which I would have loved to try back then, and it was not available. So, it was unfortunately only a playground for our theorems. 

*NV (0:10:45)*: And was this theorem proved? Because I think these kind of properties are very difficult now.

*VCM (0:10:50)*: Yeah, we proved quite a few theorems. We were particularly interested in authenticated data structures. So, those are data structures that you can prove to an external party that something belongs in this data structure. You say, “Hey look, I’m going to prove to you that a certain transaction happens without having to give the whole data structure to that third party.”

*JB (0:11:14)*: I guess Merkle trees are a popular example that people may have heard about.

*VCM (0:11:18)*: Yeah, precisely. And there’s all sorts of variations on Merkleized data structures that you’re going to do for that. And we were very interested in checkpointing ones because if you need to catch a note up to speed and you need to do some checkpointing, you don’t want to download the history of the world, but you still need to be able to provide proofs of membership or negative membership. So, when something is not there, before, you actually download gigabytes of data. One of the perhaps most complicated proofs we’ve done, we even published a paper on CPP, I believe it was 2020 or 2021, about the formalization of an authenticated skiplist that we looked at the literature. We found that there was already a data structure that was amenable to the operations we needed. So, we proceeded to formalize the whole data structure in Agda, and we were actually able to prove the theorems from the original paper, which was really cool. It was a lot of work, but it was nice to see the module finally type check.

*JB (0:12:15)*: Very nice. Yes.

*NV (0:12:17)*: Yeah, sounds difficult.

*JB (0:12:19)*: When you formalize a data structure that probably uses hashes all over the place in Agda, how do you model a hash function?

*VCM (0:12:26)*: Yeah, that’s a good question, isn’t it? Well, you have a couple of options. You can model it as you can just assume it’s perfect, and then you might be fooling yourself and others by just saying this hash function is just a unique identifier. So, you call it an arbitrary set and you say any element of the set and there’s a function from whatever you want to hash into the set. And you just postulate that, well, if the arguments are different, then the results are different as well. It’s like you postulate the reverse of injectivity. And that’s going to get you pretty far if you don’t care about your hash function having any collisions. And this was the case for us. We did not care very much about our hash function having collisions. We felt that if that was the case, we would already be in serious trouble.

*JB (0:13:11)*: When you do this kind of modeling, why even bother and not just use the identity function? 

*VCM (0:13:16)*: That’s a good question.

*JB (0:13:17)*: Is there anything more about a function that goes objectively into some unspecified set than the identity?

*VCM (0:13:24)*: I guess it helps you separate concerns because if you just go to an arbitrary set, all you can do is at best compare things. But if you use the identity function, then your type is also perhaps more structured. So, you might be tempted to look into that structure for a little bit more. So, there’s a clear notion of when some information passes through the hash function, you basically lose almost everything about that information, and then you can’t get it back.

*JB (0:13:51)*: Okay. But if you use this model, then you can’t go to concretely byte strings of length 32 bytes or something, I assume, because then you quickly get an inconsistent logic if you also claim it’s injective.

*VCM (0:14:07)*: Yes. You would not be able to claim it’s – Agda would not let you.

*JB (0:14:10)*: Okay. That’s good.

*NV (0:14:13)*: And you said this is one way to model hash structures. What are other ways?

*VCM (0:14:18)*: I think you could eventually model them as mapping to a list of bits and then deal with the fact that every equality now is going to be modular probability. But then perhaps we’re going to go back to the problems we just spoke about formalizing cryptographic algorithms in Agda. Now you’re reasoning about probabilities, and all of a sudden, you might be in trouble, or you might not, because you might just want to check if there is a collision, that whatever it is that you are currently modeling actually handles that collision elegantly. So, it’s just going to force you to do an extra case match on pretty much every single proof and say, “Oh, if those byte strings are equal,” or “If it happens to have a collision.”

*JB (0:14:57)*: But I assume most of the properties you care about for verified data structure – authenticated data structures wouldn’t hold in the presence of conditions. 

*VCM (0:15:06)*: Yeah, no, precisely, which is one of the reasons why most people just pretend hash functions are perfect.

*JB (0:15:12)*: Yeah, that makes sense. But I guess it also means you can’t extend your formalization to, let’s say, the binary encoding of the message because there you do need to have some finite-sized things and you can only stay abstract up to a point.

*VCM (0:15:26)*: Yeah. I think if you’re formalizing something like this, you’re probably not even talking about the message level, right? You’re like, “All right, there’s some data structure somewhere that represents this.” And, yeah.

*JB (0:15:37)*: Cool. Thanks.

*VCM (0:15:38)*: Cheers.

*NV (0:15:39)*: And this was your internship. How long did it last?

*VCM (0:15:43)*: Many years because we started with an internship, and then I was working as a part-time member of the team after my internship. So, I think I worked there for about three years.

*JB (0:15:52)*: Was it also in Utrecht working remotely or –

*VCM (0:15:55)*: No, it was remote. One of us was in New Zealand, the other in the US, and I was in the Netherlands.

*JB (0:16:01)*: Ah. So, they made sure that round the clock somebody’s working on it.

*VCM (0:16:05)*: Pretty much we could have a 24/7 team. Meeting was really difficult.

*JB (0:16:10)*: Yes. I can imagine.

*NV (0:16:12)*: And this group is still using Agda, do you know?

*VCM (0:16:15)*: I don’t know. I don’t know. I hope they are. I’d love to hear if they actually are. I should reach out.

*JB (0:16:22)*: And then I guess the next step was you’re working, you’re doing your PhD on diffing data structures?

*VCM (0:16:29)*: Yeah. So, this was mostly in parallel because I did the internship as part of just in the middle of my PhD and then started working part-time for Oracle and doing my PhD part-time. But yeah, my PhD had nothing to do with cryptography or anything, although my experience with Merkleized data structures was really useful to writing efficient diffing algorithms because it turns out, if you want to check – if a tree is a sub-tree of another tree, well, if you have a hash and you have a hash map, then life is easier. 

*JB (0:16:57)*: So, tell us more about the diffing trees. What was the problem that you were trying to solve there?

*VCM (0:17:03)*: So, I guess the problem would be, do we still need to be solving these conflicts that we constantly find or when we’re developing a team on a line-based resolution model, right? Oh, somebody changed this line, and you changed that other line. Can’t we have like, you give me a parser and I give you a custom merging algorithm that is proven to do the right thing and a custom diffing algorithm that’s proven to work for this merging algorithm so that we can do much better? If you change a function and you move this function somewhere, or if you add some information, I know exactly how to shift other changes to basically minimize human interaction in conflict solving. Yeah.

*JB (0:17:46)*: And is that then tied to a specific programming language or data structure, or how general did you aim to solve the problem?

*VCM (0:17:55)*: We’ve done exactly that. We’ve done a generic diffing and merging setup. So, you give me an AST, and I give you the diffing and the merging algorithm. So, it’s programming language agnostic. And it was actually rather successful. I think we were able to solve about 30% of the conflicts with mine from GitHub. So, I went to GitHub, and I got a bunch of conflicts from Java, from Python, from JavaScript repositories. Think around 30,000, 40,000, I don’t remember the numbers. And I got the four important files. So, the original file, the two conflicting ones, and whatever the engineers that solved the conflict committed. And in 30% of the cases, we actually produced the file as well. And out of those 30%, like 80% of the times, it was the same as the engineer that actually manually solved the conflict. So, that was actually pretty surprising to me.

*NV (0:18:46)*: So, you could give back wrong answers, right?

*VCM (0:18:50)*: Because sometimes people don’t just solve a conflict. They solve a conflict and rename a variable. They solve a conflict and do something else in that patch. And there’s also a huge threat to validity, which as sad as it is, I don’t think I quite believe in structural diffing at this point because, on the AST level, we lost information about white spacing. We lost information about comments. And if you actually parse all of that, then how much are you actually going to be able to merge even with the fanciest possible algorithm? I don’t quite know, but I reckon it’s going to be a lot less.

*JB (0:19:22)*: So, that means when you evaluated the tool, you were differing and merging on the level of ASTs?

*VCM (0:19:28)*: Yeah. 

*JB (0:19:28)*: And you were comparing that against a parse of the real update? 

*VCM (0:19:32)*: Correct. 

*JB (0:19:33)*: But you did not address the problem of how to write it out in to the pretty printed form that is what the user would want to write. 

*VCM (0:19:41)*: Oh, you can always put the AST through a pretty printer and –

*JB (0:19:44)*: Right. But you didn’t try to make that white space preserving or –

*VCM (0:19:47)*: No. The argument there would be, I want to choose off-the-shelf parser so I could actually deal with real-world data. And these parsers didn’t take into account formatting or white space information or comments or any of that. And modifying those parsers for a real programming language was too difficult.

*JB (0:20:01)*: Right. Yeah, that’s already a hard problem. Just passing and changing and pretty printing.

*VCM (0:20:05)*: Yeah.

*NV (0:20:06)*: Oh, but you were ignoring comments too.

*VCM (0:20:09)*: Yeah, which is a shame.

*NV (0:20:10)*: Yeah. Comments are important.

*VCM (0:20:12)*: They are. But for humans, now it brings the question, maybe this type of algorithm can be really useful for developing things like CRDTs and things where you don’t really have humans generating and reading the code but machines. When you don’t have comments where the code comes pre-formatted, for example, then it seems this information is indeed irrelevant. And then you could have quite a gain there, I believe.

*JB (0:20:35)*: What was the implementation language for your tool? 

*VCM (0:20:38)*: Haskell. 

*JB (0:20:39)*: Okay. And you found Haskell parsers for all the languages you cared about?

*VCM (0:20:44)*: I found Haskell parsers, and then I decided I cared about those languages.

*JB (0:20:49)*: Very good.

*NV (0:20:52)*: Nice.

*JB (0:20:52)*: Did you ever get in touch with GitHub about this because they were using or are using Haskell in their semantic something team where they analyze code?

*VCM (0:21:02)*: Yeah, I had some contact with someone from GitHub, I believe Rob Ricks was his name. And we exchanged a bunch of emails and a bunch of insights about some different ideas around this problem.

*JB (0:21:14)*: Well, I guess without solving the problem of writing it back out, white space, and common preserving, it’s just not practically yet for this use case, at least.

*VCM (0:21:23)*: Pretty much. Yeah, I think so.

*JB (0:21:25)*: Or contextual representation. So, this got you a PhD. 

*VCM (0:21:30)*: Correct.

*JB (0:21:31)*: And what happened then?

*VCM (0:21:34)*: Yeah. Then after my PhD, I did a big shift. I think my Oracle experience with blockchains and this kind of thing led me to Dfinity where, when I joined, was still a Haskell shop, but very briefly. And then it became a Rust shop. And I was never too fond of Rust myself. I went back to the crypto domain and to cryptography domain and to work on blockchains. At Dfinity, I was part of the testing team. So, we were responsible with figuring out ways to test our consensus protocol there. And how do you inject failures? We had to build a whole testing harness to be able to inject the right failure to reproduce the right environments.

*NV (0:22:17)*: So, what year was that? I am asking mostly because I’m curious when the shift from Haskell to Rust happened.

*VCM (0:22:25)*: I think it was – well, basically my PhD plus one, and especially post-pandemic, I lost track of time. I’m going to go on a whim here and say 2018 plus minus one.

*JB (0:22:36)*: Might have been –

*NV (0:22:37)*: Before pandemic?

*VCM (0:22:38)*: Yeah.

*JB (0:22:39)*: I think the big shift to Rust was even earlier, 2016 or ‘17. But the testing team, if I remember correctly, was using Hasker for a bit longer?

*VCM (0:22:50)*: Yeah. When I joined, it was already 50/50. So, the testing team had a couple of tools, legacy tools that were still in Haskell, but everything new was going to Rust. 

*JB (0:23:00)*: Yeah, that makes sense.

*NV (0:23:01)*: So, the testing libraries of Rust are good enough. Because in my mind, Haskell is a very good tool because of QuickCheck and everything. Haskell is very strong language for testing and the strong typing and everything. So, what is the status of Rust for test?

*VCM (0:23:21)*: I think it’s also equally good. The tooling in the Rust ecosystem is truly phenomenal. I think it’s definitely something we in the Haskell ecosystem could learn from, have a more unified tooling.

*JB (0:23:31)*: Can you make this more concrete just to encourage some of our listeners who have too much time at the hands to just go out and fix?

*VCM (0:23:37)*: Yeah. So, for example, Niki mentioned QuickCheck. I love QuickCheck, but nowadays, there are all sorts of other little libraries that are improving on top of QuickCheck, and they’re doing things even better. And there’s also dangers with something like QuickCheck, right? Because if your generator is not very good, then you’re fooling yourself because you think you have a very good test, but in fact, it’s actually terrible. And this can be quite hidden. So, how you generate your data is rather important. I think a more unified tooling. So, like whenever you run cargo, it’s rather easy to run your tests, to compile your project, to do all sorts of things. And Cabal is always a little difficult. There’s different test harnesses. You have to decide which one of them you want. And then every time I need to pass command line options to my testing code, I need to go to Google again and remember, “Oh yeah, this is double dash, this is not double dash, I need to escape this part. I don’t need to escape that part.” So, I think this is what I meant with the overall tooling feels more polished over there. But I don’t know what to encourage the listeners to work on tooling. Tooling is always a good thing to work on.

*NV (0:24:44)*: Yeah, I think the Haskell people know that tooling, it’s not the best part, the lack.

*JB (0:24:49)*: Yeah. It’s one thing to know that we’re lacking. It’s another thing of knowing actually where to go, because that we have more than one library for something just means that it’s unclear what is the best way of doing it. 

*VCM (0:25:00)*: Yeah. 

*JB (0:25:01)*: And that’s often a hard question.

*VCM (0:25:03)*: Sometimes also, when you have a big company or some big commercial force that drives one way of doing things in a language, there’s disadvantages because, well, there might be other ways, right? But the advantage is that that way gets really polished and gets really comfortable to use.

*JB (0:25:20)*: I wonder if there’s an example for a community-driven ecosystem like Haskell’s that has solved this problem better than we have.

*VCM (0:25:29)*: I don’t think so, because I would still say that all in all, Haskell is rather good. It feels pretty good working in Haskell. I don’t think I would work on anything else. 

*JB (0:25:39)*: Which, I guess, brings us to the point that the company you were working at switched to Rust and you switched to a different company then?

*VCM (0:25:46)*: That is pretty much what happened. Yeah. And then after Dfinity, I switched to Tweag. At Tweag, I had a rather interesting challenge because I was leading the form of verification group or high assurance group, and we had to find different ways of auditing smart contracts. So, I was still in the blockchain space, but it was also closely related to testing because a lot of the stuff that essentially how do you test smart contracts is just a program, and an audit is just – there’s a bunch of properties that you don’t have. So, what could we do? And one of the things I wanted to do was to be able to deliver this test suite to our clients. So, I ended up developing more testing harnesses and testing frameworks for these things at Tweag.

*NV (0:26:30)*: So, this is like you represented smart contracts as a DSL or how did you test these things?

*VCM (0:26:37)*: Well, yeah, they are a DSL, and then there is an environment, which is the blockchain, which is this stateful seven-headed Hydra monster out there. And you have this virtualized execution engine that lets you say, “Hey, here’s this program, and this is a bunch of buttons you can press on this program which appear through transactions in the chain.” And you can write properties about the behavior of this program within – this is a little bit like trace semantics. Yeah. 

One of the things that was quite interesting that we’ve done is that we applied some model logic to actually be able to write more traces with less Haskell. So, I would like to say, for example, hey, let’s interact with the smart contract by saying Alice deposits 10, Bob deposits 10, and – I don’t know, somebody else presses the green button and the contract does something. But I would like to apply a modification to one of these traces. So, I would like to say, that’s a trace. And now I want to actually run the contract on a different trace, which is somewhere in this original trace, change the value by one. And this would actually yield two different traces. One where Alice deposits nine and Bob deposits 10, one where Alice deposits 10 and Bob deposits nine. And then I could actually run the property on both of these traces and check that the result was what I would expect. And surprisingly, we actually found quite a few vulnerabilities with strategies like this because we could just write the expected interaction with the contract, the expected behavior. And then it was rather easy to modify that behavior into all sorts of weird branches using something aching to model logic. I wish I could have nailed down the semantics of that, but that never happened.

*NV (0:28:12)*: But how did you enforce all this with Haskell, with Coq, with Agda? 

*VCM (0:28:18)*: So, we were working on Cardano, and everything in Cardano is already in Haskell. So, that was super helpful because then it was – the smart contract is essentially a Haskell program. It’s written in Plutus, but it’s also a Haskell program you can actually run. And the execution environment was also provided by them, was also in Haskell. So, we were essentially testing a function of type I2S to S2O. It’s a stateful function from I2O, and the state is the state of the chain.

*JB (0:28:48)*: That’s why the company is called IO?

*VCM (0:28:50)*: Good question. I have no idea. That could very well be.

*NV (0:28:53)*: Input Output, no?

*JB (0:28:54)*: Yes, yes. I think that’s just it. 

*VCM (0:28:56)*: But the thing like the bird’s eye view is essentially we’re just testing a stateful function. It’s just that the state’s transitions are rather complicated because they have to beat these transactions and they have to, of course, be valid transactions for the chain to accept them, so and so forth.

*NV (0:29:10)*: That’s cool. And you found what kind of vulnerabilities?

*VCM (0:29:14)*: We found all sorts of them from seemingly harmless ones where somebody could just bring the contract to a halt in which, oh, it brings it to a state that nobody expected and there’s no further transitions possible to being able to drain the funds of a contract.

*NV (0:29:30)*: And how do you restrict these vulnerabilities? So, you found them, and then what do you do? You change your language?

*VCM (0:29:36)*: Oh, as auditors, the best we can do is tell our clients, give them a report, and say, “Hey look, we found this really concerning thing.” They give us the code, we take a look at it, but it’s not up to us to change much, right?

*NV (0:29:49)*: And this is before the code gets published, right? Because after, there’s nothing you can do.

*VCM (0:29:55)*: Well, it all depends. You could engineer it in such a way that there is something you can do. A lot of smart contracts out there have something that people call a master key. So, there is one private key that could actually be used to upload a new contract and then change something on the state of the first one to write to the new one. So, you can have this sort of revision mechanism. But that can also be a vulnerability because, well, if you lose that key, then you’re in trouble. So, it’s open-ended. Everybody deals with it a little bit differently.

*NV (0:30:22)*: That’s very cool.

*VCM (0:30:23)*: But it was funny that I stayed in the realm of testing and not in the realm of verification. I think we lacked the time to put in the effort to really get form of verification going. It takes a surprising amount of effort to verify anything that’s close to production code.

*JB (0:30:39)*: And then after Tweag, you went to your current company, right? 

*VCM (0:30:45)*: Yeah. After Tweag, I moved to Channable, which is where I currently work. We have our headquarters here in Utrecht, in the Netherlands. So, I’m not doing any remote work anymore. And it’s very nice to be in an office with colleagues and see them and know them. And now I write microservices in Haskell for a software-as-a-service company.

*NV (0:31:03)*: So, do you want to start by telling us what is Channable?

*VCM (0:31:07)*: Channable is a tool that empowers marketers to be able to be in charge of their own digital strategy. This means that if you want to sell something on the internet, if you want to run campaigns on the internet, you probably want to have your HQ centralized in a single place that monitors your advertisements on – I don’t know the kind of channels. On Amazon, on MediaMarkt, or like whatever. And you want to manage just in a single place. You want to be able to sell your products on multiple marketplaces from a single place. Like if something runs out of stock in some web store, you would hope that the orders from another web store also get blocked, for example. So, Channable is a tool that will enable you to do pretty much that. We have a bunch of microservices in Haskell running in the background. By my last count, it was 12 out of our 15 services and brings us to about 150,000 lines of Haskell in production without tests. So, it’s a rather sizable backend that we have. It’s rather fun to run Haskell in this scale.

*NV (0:32:12)*: And this started with Haskell. It’s not that you went there and you introduced it?

*VCM (0:32:18)*: No, I don’t think so. The company has been going for 10 years now, and there was a change to Haskell, but they didn’t start in Haskell.

*JB (0:32:25)*: But you weren’t there when the change happened?

*VCM (0:32:28)*: No, no, I was not.

*JB (0:32:29)*: It would be interesting to hear how that happened.

*VCM (0:32:34)*: Yeah. Actually, there will be a – maybe we even have that in a blog post. I should check. And if not, we should write one.

*JB (0:32:40)*: And what is your tech stack in terms of libraries and databases? Like something, I think, some listeners are curious about?

*VCM (0:32:47)*: Yeah. We run a lot of Servant. Pretty much each one of our web servers is running Servant and Postgres. We are very much divided on which SQL library to actually use. Some projects use some older stuff, like Hasql. Some projects are using some newer stuff like Esqueleto and Persistent. And there’s a couple of others, like Beam, that I would love to try. So, it’s quite varied there. That’s the majority of it. A lot of the stuff we have is also handwritten because we just found weird quirks in production and eventually had to write around. Like for example, our process library is handwritten. We don’t use the system.process from base. It has to do with namespace and C groups and all sorts of different things.

*JB (0:33:32)*: Do you also use Nix by any chance?

*VCM (0:33:34)*: We do. We do. We have a huge Nix setup. 

*JB (0:33:37)*: I think this is a change. It’s not the first interview where we talk about how Haskell is used in production, and then I ask about it and, “Yes, of course, we use Nix.” And I think not so long ago, this would’ve been like one of the first things you mentioned. Like, “We’re already using Nix because it’s like this crazy thing that nobody else uses.” And these days, it just seems to be not even worth the mention that you’re using Nix when you use Haskell in production.

*VCM (0:34:02)*: It’s the right solution to the problem. It solves it. We have no problems with it. I mean, sure, it’s rather complicated once you’re doing anything big, but anything big is complicated anyway in whatever you do. 

*JB (0:34:14)*: Right. So, it seems like Servant plus some library plus SQL plus Nix actually has become rather standard, at least from the perspective of us running this podcast and interviewing people who run Haskell in production. But it is coming up repeatedly. I think there’s a probably good time. It means there’s some consolidation happening that these tools are reliable.

*VCM (0:34:34)*: Yeah, I think so too. And these are really powerful tools. It’s always a joy to work with. And then we get things like open API generation for free. Well, not really for free, right? Because somebody had to pay a lot of time to actually get that going. But it’s already paid for. So, all of these nice things that we are able to just benefit from. And I think it’s definitely – Haskell as a language really enables us to run a very large code surface and to maintain that code surface with relatively few people in comparison to other language. And indeed, I think that the stack that you just mentioned, Postgres, Servant Nix, it definitely helps a lot. I think it’s one of the right choices there.

*JB (0:35:15)*: One of the other common topics and themes in various when you talk about Haskell in production is, of course, hiring. Like how can you get good people? Do you hire on the job, or do you only hire people that already know Haskell very well? Do you have any insight into that corner of the business that you can share?

*VCM (0:35:32)*: I’m not really involved in Channable’s hiring process too much, but I’m aware that it’s difficult.

*JB (0:35:38)*: Okay.

*NV (0:35:39)*: That’s good for the listeners.

*VCM (0:35:40)*: That’s true. Actually, I don’t know if we’re hiring. I should have checked. But send us an email anyway. But it is definitely difficult. I think it’s still a niche programming language. There’s still quite a lot of stigma. People say, “Oh, wow, you really used that stuff? Does it really work?” I hear that quite a lot within the Haskell circles. Nobody doubts it, but outside people are very surprised.

*JB (0:36:01)*: And you’ve already been at one shop that starts with Haskell and eventually decided to switch to Rust partly because of hiring, not only. So, are you afraid this will happen again, or is it just completely everybody’s happy with Haskell? There’s no constant nagging from Haskell doubters in the company to use something else?

*VCM (0:36:21)*: No, we don’t have nagging, and we also don’t have Haskell doubters in the company. It’s quite stable for us. We are now writing our first Rust service.

*NV (0:36:32)*: It’s happening.

*JB (0:36:34)*: I guess Haskell is like old iron. It attracts rust.

*VCM (0:36:39)*: Maybe, right? But it’s something that really requires some real-time analysis and performance and memory control. And this is just something we cannot – we have Haskell programs that run with 256 gigs of a heap and the runtime system sometimes doesn’t like that very much. And then GC pauses can be catastrophic. So, some things have to be run in a language that doesn’t have GC.

*JB (0:37:07)*: Do you face the space leaks just to tick off the boxes of questions that always come? Do you struggle with controlling the memory usage of Haskell, or is it –

*VCM (0:37:17)*: Sure, we have space leaks. They always happen. There’s no way. But we often find them and fix them. But still controlling the memory usage, in particular, controlling – the GC pauses is a big problem because the Stop the World and then Do Something works rather well when this Do Something doesn’t take too long. But if you have a high availability service that’s running on 256 gigs of heap, the Stop the World lasts for 10 minutes, and your high availability is gone.

*JB (0:37:46)*: But GHC has learned to do this incremental GC recently, right? Or relatively recently. Could you already use that in production?

*VCM (0:37:55)*: That’s a good question. I’m not fully aware whether we could use or whether that would have made the biggest difference for us.

*NV (0:38:01)*: So, this is an optimization, it’s not on by default? 

*JB (0:38:05)*: I think you have to turn it on, that it is a different garbage collection strategies that I think Ben Gamari worked on mostly. And it means there, you still stop the world for the minor collections, I think. Well, it might be. I’m actually not sure whether it’s the minor or the major, but it makes things more predictable.

*NV (0:38:24)*: No, I’m just wondering why it’s not on by default, but maybe in the future.

*JB (0:38:29)*: I think it has tradeoffs. I think it’s slightly slower in terms of throughput, but you don’t get catastrophic pauses.

*VCM (0:38:35)*: Yeah. One of the things some colleagues tried, I don’t think it quite landed on GHC, but we tried syncing compact regions to memory-mapped files. So, we could actually not have the GC go look into those, and we could actually reuse them in other processes as well. But I don’t think it was quite finished. We started at last ZuriHac. Let’s see, maybe this ZuriHac, we actually finish it.

*JB (0:38:56)*: Yeah, this is a side note, but the lean compiler uses that trick of just serializing a bunch of state into a compact region. And when you start the process again, it just memory maps it. And it means you can load several gigabytes of data instantaneously in your process, and it’s really neat when it works.

*VCM (0:39:16)*: Nice. What is it written?

*JB (0:39:17)*: In lean.

*VCM (0:39:19)*: In lean. Perfect. That’s a reasonable choice, I guess.

*JB (0:39:22)*: So, it sounds you’re mostly quite happy with Haskell as the production language. Oh, but you said you wish Haskell would’ve more dependent types. Is this something that you just wish for, like out of personal interest, or do you, in your daily production work, encounter cases where you think you really would’ve liked dependent types?

*VCM (0:39:44)*: I mean, maybe dependent types is not really what I would like. I would like for us in general to focus more on semantics and less on syntaxes. Dependent types is a way to keep us honest, right? Because then you can’t just provide me an inhabitant of an instance. You have to prove that it satisfies the right laws, and so on and so forth. So, it is more of a means to an end. It keeps us honest as programmers. We have to say what we mean, and we can’t cheat. The compiler is going to tell us if we’re cheating. 

*JB (0:40:15)*: Well, I thought my understanding is the dependent types for Haskell push that is ongoing slowly but steadily. It’s actually not going to give you that because it’s still going to be a generally recursive language, and you don’t get the kind of – you can use it for theorem proving aspect of it.

*VCM (0:40:35)*: Yeah, I don’t think so either.

*JB (0:40:36)*: But that’s the one that you would be most interested in as a user?

*VCM (0:40:39)*: Definitely. I think for me, the perfect thing would be if I could compile Agda to efficient Haskell and then write everything in Agda. But then first, we would need to port all the useful libraries because there’s that the ecosystem of a language rather makes the language.

*JB (0:40:55)*: Or write foreign function interface steps so that you can import them somehow and use them from Agda. But I guess the interesting part is then not just like calling the function but also having properties about them and theories that tell you something.

*VCM (0:41:09)*: Yeah, indeed.

*JB (0:41:11)*: Did somebody try writing something like Servant for Agda already?

*VCM (0:41:14)*: I have no idea.

*JB (0:41:16)*: Okay. Research ideas for our listeners in case you’re like somebody looking for master thesis.

*NV (0:41:21)*: But the Agda to Haskell project is active, right?

*VCM (0:41:25)*: I think so. And it does quite well last I spoke with people that used it. I never used it myself.

*JB (0:41:31)*: Have you tried using Agda at your current company somewhere in some corner?

*VCM (0:41:35)*: Yeah. I write my specifications in Agda. 

*JB (0:41:38)*: Okay. 

*VCM (0:41:38)*: I always try to sneak in some Agda everywhere that I can. And at least for specifications, I rather use Agda so I can’t be dishonest.

*NV (0:41:47)*: But by specifications, you mean you write a prototype in Agda and then pass?

*VCM (0:41:53)*: No, I write a specification. We can write what we are doing, we can use some structure. Sure, you’re going to have to use some abstractions, and you’re going to have to use some postulates because you’re not going to write the whole stack. You’re not going to run it, you just want to type check it. But it’s a spec. So, for example, we have something akin to a document store which documents have names, and then these names can be associated to values, and you can fetch them a little bit like Google Cloud services. But you have something internal, and the specification just models that as just a function over time. A document is a function of time to byte string and it changes over time. And this is how you actually – so, it’s nothing to do with a prototype, it’s just, what is it that it represents?

*JB (0:42:38)*: In a denotational sense, so to say.

*VCM (0:42:40)*: Exactly. Yeah.

*NV (0:42:42)*: And can you use this to generate tests, maybe?

*VCM (0:42:45)*: To generate automatically, no, but I definitely use it as inspiration to write my own property tests. And then I say – because it helps me understand exactly what are the meaningful properties. But arguably, there’s only one meaningful property, which is correctness. If it’s correct, then you get everything else. But that’s easier said than done. So, you eventually get to thread into other important things to say, “Oh, what I want is for this function to be monotonous.” There’s always some abstract property specified in terms of mathematical terms that turns out to be rather meaningful for the problem at hand. And having these specifications in Agda helps me realize these things.

*JB (0:43:21)*: Are you also using the specification to then communicate with your colleagues, like generate documentation from it or just using it directly as something that you can use for documentation?

*VCM (0:43:32)*: Yeah, it’s very useful also for establishing vocabulary, right? Because when you have a team of a bunch of people, it’s not helpful if you refer to that weird computation or that shenanigan over there. Can you give names to the things that we are doing and consistent names, and can we have a collective understanding of what they are? And so, the specification is really helpful there to communicate. Some specifications are written in a Haskell-like syntax and then just a markdown file, but then we type check them in Haskell. But whenever I can, I try to make them in Agda.

*JB (0:44:05)*: So, what is it that you wish, besides dependent types, that Haskell would have? As an experienced practitioner, what are the plausible and maybe also the implausible items on your wishlist?

*VCM (0:44:16)*: Items on my wish that the Haskell would have? As a language or as an ecosystem?

*JB (0:44:20)*: Both. Either. All of it. 

*VCM (0:44:22)*: Both. Yeah. I wish we would be less smart as a community in the language and in the ecosystem. I wish things like the length of a tuple would be a type error, and it’s not. We have a very complex Prelude, which is still up to this day, still bites me every now and again because it turns out I forgot an unzip somewhere, and I’m actually doing the length of a tuple of lists, not the length of the list of tuples. So, all of this is rather complex. But what I really wish we had, I guess, at the top of my wishlist is a good story on IO instead of just saying, throw everything in the IO monad in our sin bin because we don’t know what any of that means, whether we had a good way of actually dealing with IO, a good understanding of when unsafePerformIO is really unsafe, or whether, should we just call it safePerformIO instead because it’s actually rather safe in most of the times. So, this is something that I constantly face in Haskell. It’s like, “Oh, I need to call a process to do some image processing.” Well, if I had time and patience, I could write this image-processing code entirely in Haskell, and that will be a pure function. Why do I have to put IO for my entire code base for that?

*JB (0:45:31)*: Well, but then you can use unsafePerformIO.

*VCM (0:45:34)*: Exactly.

*JB (0:45:35)*: So, what’s missing? What does the cultural shift to say this is okay, we’re embracing the idea?

*VCM (0:45:42)*: Perhaps it is a cultural shift. It’s something that I try to really avoid spreading IO across. I am definitely a fan of unsafePerformIO. But yeah, I wish I would see that more often, like more libraries that don’t just require monad IO as a constraint. Because in general, the ecosystem has this idea of like, “Nah, just put monad IO and we’re going to pretend it’s not there.” It comes, I guess, with my wish for more denotational arguments and for more semantics out there. We just don’t know what IO really means. So, if you put IO in your programs, then you can’t really reason about them any longer. 

*JB (0:46:17)*: I’m surprised you didn’t mention, or maybe that’s what you meant also to have different monads for different parts of IO so you can reason better about what kind of resources some things are doing, or is that not the direction you want to head?

*VCM (0:46:30)*: Maybe. But then we got to ask the question, are those things really monads, right? Can we even define a quality for them and even state the theorems? That’s the really hard question there. So, maybe some built-in support from the compiler, I don’t know, some Erlang-style pubsub for certain events of the operating system. I have no idea. I think that there’s definitely a lot of interesting research. If I had to do another PhD, I think this is probably what I would spend my time thinking about.

*NV (0:47:01)*: But it looks a little bit contradictory. Like the one more dependent types and a better IO, right? It’s contradictory. It’s like you want everything.

*VCM (0:47:11)*: Yeah, we should want everything, right? 

*NV (0:47:12)*: Yeah, yeah, yeah,

*JB (0:47:13)*: It was a wishlist. I think that’s reasonable. 

*NV (0:47:15)*: Yeah.

*VCM (0:47:17)*: Joachim asked for the unreasonable ones as well.

*JB (0:47:18)*: Right.

*VCM (0:47:19)*: I wish we had a better story there so we could actually write better software in general, right? We could treat software engineering a little bit more like engineering, a little bit less like alchemy.

*JB (0:47:29)*: That’s nice.

*VCM (0:47:31)*: I guess that’s the spirit of the wishlist at least.

*JB (0:47:34)*: Okay. Then, I guess, maybe we can wind down on the dual question. Since you’re using Haskell productively, you’ll get to encounter people, and they’re like, “Oh, I’m surprised you’re using Haskell.” And then you get to tell them all the great things about Haskell. What do you tell them?

*VCM (0:47:49)*: Yeah. So, one of the things that I just love about Haskell is to have a strong and expressive type system. It lets you refactor code with confidence. It lets you get very close to the business logic of what we’re actually doing. And this really helps the code be much, much clearer. I think the expressive power of different design patterns, like we started the podcast talking about how foldr was really the click for me. And up to this day, I’m still writing folds for my own data types and then writing my little functions in terms of their catamorphisms. And this expressive power really lets me be a lot more productive. Using Haskell, I can output a lot more software than using other languages. I think it’s a combination of those things, also maintain a lot more software. So, if something goes wrong, you need to refactor something, the type system really helps you.

*JB (0:48:42)*: Yeah, which I guess also explains where you’re leaning towards wanting more expressive type systems so you can get more of that.

*VCM (0:48:51)*: Exactly. More of that. I want my refactor to be just, erase something from the code and then let the type checker tell me where I missed something. 

*NV (0:48:59)*: But don’t you think that this will slow down productivity?

*VCM (0:49:03)*: Well, it depends because you can output something really quickly that you have to keep on maintaining forever or you can output something a little bit slower that doesn’t need to be touched any longer. It’s like, what is real productivity? I guess it’s more of the question.

*JB (0:49:17)*: Well, I think that’s a good conclusion for the podcast. Thanks for being on the show. 

*NV (0:49:22)*: Thank you.

*VCM (0:49:23)*: Hey, thank you for having me.

*Narrator (0:49:26)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
