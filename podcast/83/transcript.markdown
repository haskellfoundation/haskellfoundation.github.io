*Jessica Foster (0:00:14)*: Welcome to the Haskell Interlude. I’m Jessica Foster, and this is Part 2 of our three-part miniseries on POPL 2026. In this episode, we talk about symbolic execution monads, what a lazy linear core in Haskell might have in common with Rust, hyperfunctions, the hallway track, and how to deal with rejection. 

Okay. So I’m here with Andrew Hirsch, an assistant professor at the University at Buffalo. And we were just talking earlier that it’s the end of the day here. We’ve just had a nice games night with a Jane Street-sponsored games night, played some Codenames. I have anyway. I’m not sure about you, but we were just talking in the hallway over there about some choreographic programming stuff. So you’re the choreographic programming guy.

*Andrew Hirsch (0:01:00)*: I make choreographic programming, right. Yeah.

*JF (0:01:02)*: Yeah, yeah. So you were just telling us you wrote this paper about choreographic programming, and then it got implemented into a Haskell library, which was HasChor. Is that correct?

*AH (0:01:10)*: Yeah, yeah. So, I mean, the paper I wrote was a completely theoretical paper called Pirouette. It’s since been implemented as an OCaml implementation. It’s available online, not really ready for primetime, but it’s there. People can play with it. But excitingly, a group of people at Santa Cruz, well before it got implemented in OCaml, implemented it in Haskell as HasChor. And HasChor has then since grown a life of its own and is off doing its own, evolved in a completely different way that’s really cool, and it’s got really cool stuff going on.

*JF (0:01:39)*: I was talking with Satnam earlier today about, like, there was someone who’s building on HasChor with some cloud stuff, I think. You didn’t go to that today because, instead, you were at PLMW the whole time.

*AH (0:01:47)*: Yeah, that’s right.

*JF (0:01:48)*: So you’re the chair of the PLMW?

*AH (0:01:50)*: Yeah. I was one of the two chairs of PLMW this year, two senior chairs, and then we have a junior chair who was not able to make it today, sadly.

*JF (0:01:58)*: PLMW, so that’s the Programming Languages Mentoring Workshop.

*AH (0:02:01)*: That’s right.

*JF (0:02:01)*: So, what is PLMW like? What is the purpose of it?

*AH (0:02:04)*: Yeah. I mean, PLMW, I think, is one of the really cool innovations of the PL community. So, it is a workshop, as the name implies. It’s run at all four of the major PL conferences, so that’s POPL, PLDI, ICFP, and SPLASH. As a workshop, it offers students a day of getting to meet each other. So these are usually junior students, whether that’s junior PhD students or senior undergraduates.

*JF (0:02:28)*: And some industry people here are really trying to get into it? 

*AH (0:02:29)*: Some industry people.

*JF (0:02:31)*: Yeah.

*AH (0:02:31)*: Some people who are considering switching into PL from a different area.

*JF (0:02:36)*: Right.

*AH (0:02:36)*: We get a good mix of people. Most people are one of the two: junior PhD or senior undergrad. They get to come and not only meet each other, which is super useful, but some of the leading lights of the PL community come and talk to them about things like what do careers look like in programming languages. They give talks on technical aspects of programming languages. So, for instance, today we had Paul Blain Levy give a talk, a very introductory talk that was beautiful on his recent Church Award-winning work on call-by-push-value.

*JF (0:03:06)*: Oh, yes. That was the last talk of the day. I missed it, unfortunately. But yeah, that sounds amazing.

*AH (0:03:10)*: Yeah. Sadly, it wasn’t recorded, but if you can find a version of him giving that talk, it was a really beautiful introduction to the topic. And then we also have a lot of soft skills. So, for instance, how to write a paper. We had a talk today about moving across continents, which is a thing that a lot of people in PL do.

*JF (0:03:25)*: Yes. And how to find a good bagel in New York, was it? Or something in New York?

*AH (0:03:28)*: A good – 

*JF (0:03:29)*: Baguette?

*AH (0:03:29)*: Yeah, a good baguette.

*JF (0:03:30)*: How to find a good baguette in New York?

*AH (0:03:31)*: Good bagels are pretty easy to find in New York.

*JF (0:03:34)*: Yes. I was going to say that. I was like, “That’s, yeah, pretty easy, I think.”

*AH (0:03:35)*: Well, how to find a good bagel in Paris might be a better –

*JF (0:03:38)*: Oh, yes. Good point. 

*AH (0:03:38)*: Yeah.

*JF (0:03:39)*: I again missed that. I was a bit late. 

*AH (0:03:42)*: Yeah. I mean, it was an excellent talk. Alexandre Moine, who was speaking – I did a postdoc abroad for – in my case, it was the other way around. I moved to –

*JF (0:03:50)*: Right, from the US?

*AH (0:03:51)*: From the US to Europe.

*JF (0:03:52)*: Oh. Whereabouts in Europe?

*AH (0:03:53)*: In Germany.

*JF (0:03:54)*: Germany.

*AH (0:03:54)*: In Saarbrücken.

*JF (0:03:55)*: Saarbrücken. Oh, nice.

*AH (0:03:55)*: I did my postdoc at the Max Planck Institute. And yeah, it’s a daunting process, but it is a lot of fun. And having somebody actually talk to people early in their careers about, like, “This is a really common experience. It’s something that scares a lot of people, but it can be really rewarding, and here’s how to get the most out of it,” I think, was a super valuable thing.

*JF (0:04:14)*: Oh, nice. Yeah. And Sprechen Sie Deutsch, or – 

*AH (0:04:18)*: Nur kleiner, nur kleiner. 

*JF (0:04:18)*: Nur kleiner.

*AH (0:04:19)*: Yeah.

*JF (0:04:20)*: I see. Just out of interest, how is it like? You’re in a different country, you speak a bit of the language maybe, but I guess you speaking English, that helps.

*AH (0:04:28)*: Yeah. I mean, the –

*JF (0:04:28)*: Germans are pretty good at English, so –

*AH (0:04:30)*: Being a native English speaker is pretty useful in most places in the world.

*JF (0:04:33)*: Yeah.

*AH (0:04:34)*: And in computer science, in particular, almost every CS group is going to speak English. In particular, at MPI, the rule was that it was an English workplace. So, at work, I was speaking my native language, which helps a lot. But you know, you move to a new place, and yeah, a lot of the Germans, especially younger Germans, speak English. But in Saarbrücken in particular, a lot of the older Germans don’t. They speak French.

*JF (0:04:55)*: French?

*AH (0:04:56)*: Because it’s on the border.

*JF (0:04:57)*: Oh, is it Rhineland?

*AH (0:04:57)*: Saarland, Saarland.

*JF (0:04:59)*: Saarland. Okay.

*AH (0:05:00)*: Yeah. Saarland is right on the border with Alsace-Lorraine. So you get that cross-border. And of course, a lot of the other immigrants to Germany don’t necessarily speak English.

*JF (0:05:08)*: Right. Of course.

*AH (0:05:09)*: And there’s a lot of them. I mean, it’s a really cool multicultural place in a lot of ways, but the common language is German. So not speaking a lot of the language can be a bit of a challenge. I was there during the pandemic, which makes it an especially big challenge.

*JF (0:05:20)*: Oh, boy. Right.

*AH (0:05:22)*: You get to learn a lot about yourself and where you come from and what’s important to you. And you also get to have the benefit, of course, of working with awesome people, who I now collaborate with them still, but I’m living in the US. It’s a six-hour time difference. That is not easy collaboration.

*JF (0:05:37)*: Right.

*AH (0:05:38)*: Getting that collaboration started up in person while I was living in Europe was super useful.

*JF (0:05:42)*: That’s true. If your collaborators are maybe night owls, it may be a little bit easier. I feel like I’m on a US schedule, but in the UK most of the time.

*AH (0:05:52)*: Most of the Germans are pretty strict about 5 p.m., it’s time to go home.

*JF (0:05:56)*: Very regimented. Yeah. It’s a stereotype, but it’s also true. So, yeah, no, interesting. And PLMW as well, part of that is also you’re sponsoring students to come to the conference as well, right?

*AH (0:06:06)*: That’s right. Yeah. So, we offer scholarships to come to the conference, and that pays for attending the conference and the workshop, the hotel, and the flight, which is – or transport. 

*JF (0:06:15)*: Hotels and the flight. Wow, very generous.

*AH (0:06:16)*: Yeah. It’s something that we feel really, really glad to do. One of the things that we’re working on is how we can continue making that be sustainable as we go forward. We want to continue to be generous. We want to continue to do that. I think it’s a really important thing to open that up to people. But it is financially a tough thing to do.

*JF (0:06:33)*: Well, sure. Makes sense. It’s always nice seeing the PLMW people. I usually go along. I mean, I’m still relatively junior. And it’s just nice chatting to people as well. So, yeah, it was a good time. You have an icebreaker in the morning as well. You have a bingo sheet of trying to find who doesn’t like coffee, who can scuba dive, who can do salsa dancing, that kind of stuff. One of them in the bingo today has never programmed before. That seemed like a tough one for people to fill.

*AH (0:06:58)*: Yeah.

*JF (0:06:58)*: Did you know if anyone fulfilled that? 

*AH (0:06:59)*: I don’t think anybody did this year. We have in previous years. Sometimes you get somebody who is a math major who’s interested in PL from homotopy type theory. And so they come, and then somebody fills in that sheet. So it’s worth having it there. But yeah, this year was a tough one.

*JF (0:07:13)*: Ah. So it’s fun to just see if there’s anyone who happened to –

*AH (0:07:17)*: Yeah, yeah.

*JF (0:07:18)*: Yeah. It’s useful to know. It’s useful to know.

*AH (0:07:19)*: Well, I think the useful thing about the bingo sheet, you’re only allowed to have every person fill in one of the squares.

*JF (0:07:24)*: Yes. And there’s a lot of squares, so you got to go talk to loads of different people.

*AH (0:07:27)*: Exactly. Exactly.

*JF (0:07:27)*: It’s very effective. Yeah, yeah. No, it’s a great icebreaker. And lots of icebreakers are not good icebreakers. So I’m quite impressed that you found a good one that’s quite fun to do and – yeah.

*AH (0:07:37)*: Yeah, yeah. I mean, I think most of the PLMWs have used an icebreaker like this, and it’s really useful.

*JF (0:07:41)*: Yeah, especially early in the morning, but not first thing in the morning, which is great, which means that I could come in a little bit late and still be there. Yeah, great. Okay. Is there anything that you’ve seen at the conference so far or things that you are looking forward to in the conference that you want to highlight?

*AH (0:07:54)*: So far, I’ve mostly been focused on PLMW, of course.

*JF (0:07:57)*: Which makes sense. Yeah.

*AH (0:07:58)*: Yeah. But I always look forward to a lot of the sessions on concurrency. I know there’s a paper on atomic update of distributed systems that’s going to be presented tomorrow.

*JF (0:08:09)*: Atomic update of distributed systems?

*AH (0:08:10)*: Mm-hmm.

*JF (0:08:10)*: Oh, interesting. Okay.

*AH (0:08:12)*: Yeah, yeah. I think an automata-theoretic version of it, but –

*JF (0:08:15)*: Atomic automata.

*AH (0:08:16)*: Yeah, yeah. Exactly.

*JF (0:08:17)*: Okay.

*AH (0:08:17)*: I’m looking forward to hearing about that. I hear that’s going to be really good. Yeah, I’m trying to think of what else I’ve heard about, because I – to be honest, I’ve been kind of focused.

*JF (0:08:25)*: Yeah. It’s a tough question to be asked on the spot. Like, I could not answer this question. I ask it because some people can.

*AH (0:08:30)*: Yeah.

*JF (0:08:30)*: And they just happen to have stuff off the top of their head, but no, great. Okay. Well, thank you very much, and enjoy the rest of the conference.

*AH (0:08:36)*: Thank you. Yeah.

*JF (0:09:00)*: Okay. I’m here with Opale Sjöstedt from Imperial College London. You gave a talk a couple of days ago, I think it was. Could you tell us what that was about?

*Opale Sjöstedt (0:09:07)*: Yeah. So on Monday, I gave a talk at TPSA, which is a workshop on static analysis, basically, and I presented Soteria Rust, which is the tool I’ve been working on since the start of my PhD, which was back in February. First, I presented Soteria, which I guess is the thing that’s of the most interest to the most people, which is basically a symbolic execution library we’re working on.

*JF (0:09:28)*: For Rust?

*OS (0:09:29)*: No. So it’s made to be like a generic symbolic execution library that –

*JF (0:09:33)*: Oh, okay.

*OS (0:09:33)*: – if you’re just building some form of symbolic execution in your tool, then you can just import Soteria and use it as is. And basically, it provides you with tools to facilitate the development of the engine.

*JF (0:09:46)*: I see.

*OS (0:09:47)*: So the idea behind that is that mostly these days, when you have symbolic execution tools, like Infer, for instance, they don’t really have a library; rather, it’s more of a framework. So it’s a bit of a heavier mechanism where if you want to support a language, you’ll have to translate your language into some form of intermediate representation. 

So Infer has a language called SIL, for instance, which is like a generic language that has most of the common features you would expect. So you need to build this compiler and then move the output from the compiler, basically, and Infer can run its analysis on this language. The idea behind that is if your language is good enough, then it should be simple. You can reuse your analysis. And if you prove the analysis over this language, you can keep the soundness for all of your target languages.

*JF (0:10:32)*: Okay. 

*OS (0:10:33)*: So that’s the key idea behind stuff like Infer, Gillian, and so on. I’m working with Sacha Ayoun, who worked on Gillian for his PhD. And so Gillian is also a similar framework where you can do symbolic execution over languages like C, JavaScript, and Rust.

Basically, his observation is that actually just writing a compiler to an intermediate language is actually very hard, and it gets in your way a lot because the framework will have a set of values and a set of expressions, and basically you’re restricted to that. So if your source language has a more complex system that you want to represent in it, you’re going to have to face a lot of hurdles, and it’s going to be quite hard to encode, and you might lose precision and so on.

And so instead of providing a framework where you have to compile to, we just have a library. Well, you can use it with whatever value language you have, whatever AST. Like, we don’t provide an interpreter over anything. We just provide constructs. So we have a symbolic execution monad. And so we just provide this monad, basically, then you can just very easily build your interpreter on top.

And actually, building a custom interpreter for a language is relatively straightforward. I mean, I’ve been working on Soteria Rust since February, and we got something that’s relatively complete. I’m really happy about it. I’ve never struggled writing the interpreter. That was never the hard part, basically. Whereas if I had to write a compiler for Rust, that’s an entire skillset that I don’t have. And proving the soundness of a compiler is a whole other task.

*JF (0:11:54)*: Right. I see. So you’re using this framework that Sacha developed originally, is that the idea?

*OS (0:11:59)*: Yeah. So it was originally by Sacha, and then I came on the project, and we worked on it together.

*JF (0:12:03)*: You worked on it together. Yeah. You had a talk at S-REPLS in the UK, the South of England, something, something, something.

*OS (0:12:10)*: Yeah.

*JF (0:12:11)*: Something about PL. You had a sort of anti-LLVM talk, right? Would you say that’s fair, or –

*OS (0:12:15)*: More or less. I mean, LLVM is a great technology, and for the target of compiling to assembly, it makes a lot of sense. Our point is more that if you’re not compiling to assembly, but you’re doing analysis on stuff –

*JF (0:12:27)*: Right.

*OS (0:12:27)*: – you want to have much more precision. And for those use cases, yeah, we go against LLVM's stance of having one IR that you reuse, and instead, you just import whatever IR is more appropriate for the job. So for Rust, I do the analysis on MIR, which is the Rust’s Middle Representation something.

*JF (0:12:47)*: Like, Middle Intermediate Representation if it’s –

*OS (0:12:49)*: Yeah. That sounds right.

*JF (0:12:50)*: Yeah. Okay.

*OS (0:12:50)*: That sounds right. Which comes with Rust basically. And so it necessarily encodes all the information you want. And for C, he does it over the C AST, which is quite limited, so it’s doable.

*JF (0:13:00)*: Right. I see. Great. Yeah, cool. And are there any talks that you’ve been to that you found interesting so far here at POPL?

*OS (0:13:07)*: Yeah. So also at TPSA, well, from someone from our lab, to be fair, there was a talk by Raquel, which was really nice about specialization. Well, I guess David Pichardie also mentioned it in his keynote on Infer, which was Monday morning, if I’m not mistaken, which is basically an idea of how you can reuse specs for code where you cannot calculate what the spec is going to be. So basically, if you take a function that receives a function pointer and that calls that function pointer, you can’t just compositionally analyze that because you don’t know what the function pointer could be.

*JF (0:13:39)*: Okay.

*OS (0:13:40)*: Like, it could really be just any function that is defined in your code. And so their solution to this is they have this thing called specialization, where they will lazily calculate the specification for that function. So instead of going, “Oh, this thing receives a function pointer, I’m going to consider every possible function pointer,” they’re not going to calculate a spec for it, and anytime in any other analysis, they reach this function with a known function pointer, then they’re going to specialize that function to this function pointer, for instance.

*JF (0:14:10)*: Oh, interesting. 

*OS (0:14:11)*: And calculate the specs on demand and detect bugs on demand as the functions are used.

*JF (0:14:17)*: Interesting.

*OS (0:14:17)*: And it’s really neat, and this idea of specialization can be extended to object-oriented languages. For instance, if you have a generic function, you don’t know what type it’s on. And so you might want to just specialize to whatever that function is called to the type it’s called with. And it’s something I’m interested in in particular because I’m adding polymorphic symbolic execution to Soteria Rust, which is the project I’m working on. So in Rust, you have traits.

*JF (0:14:42)*: Yeah, and a trait is similar to a Haskell type class, right, but maybe not one-to-one? I don’t know, but – 

*OS (0:14:47)*: I’m not incredibly familiar with Haskell type classes, but it’s similar.

*JF (0:14:51)*: Roughly, yeah.

*OS (0:14:51)*: Like, you have a type, and you know that it has a set amount of functions with a set signature.

*JF (0:14:56)*: Yeah.

*OS (0:14:56)*: And if you have a function that is parametric on the traits, you don’t really know what to do. And so the solution would be to just specialize those, and you just basically calculate the spec or analyze the function when it’s called with a type that matches it.

*JF (0:15:09)*: Right, yeah. So it’s for an ad-hoc polymorphism type thing? 

*OS (0:15:13)*: Exactly. 

*JF (0:15:14)*: Yeah, right.

*OS (0:15:15)*: Exactly.

*JF (0:15:15)*: That makes sense. Yeah, because then ad hoc in Java, you have overloading based on what type is called, and for type classes, it’s the same deal, and I imagine traits are the same deal. Okay.

*OS (0:15:23)*: Yes, exactly.

*JF (0:15:24)*: Okay, that makes a lot of sense. And so that’s the work you’re working on right now?

*OS (0:15:27)*: So I’m not yet implementing specialization, but it would probably be one of the next steps once we get there. Like, I’m finishing the polymorphic execution bit, and basically right now, we just give up anytime we reach a trait method because we don’t know what to do. And the solution is probably going to be that.

*JF (0:15:43)*: Okay, I see.

*OS (0:15:44)*: So it was nice hearing both David and Raquel talk about it. It’s interesting and gives some insights about solutions to problems I’m currently facing, which is really nice.

*JF (0:15:55)*: Perfect. And is there anything else you’re looking forward to for the rest of the conference?

*OS (0:15:59)*: So tomorrow and Thursday, there’s a talk on relational separation logic for effect handlers, and that’s quite interesting. It’s not something I can directly apply to my work, but just seeing effect handlers gain some more formalization and some sort of definitions, I guess, that can be used for separation logic is really interesting. We use effect handlers a lot. From what I understand so far, even inside OCaml, they’re trying to make effect handlers typed. The initial goal was making them typed, and then they realized it was a very long-term goal, so they just added untyped effect handlers, which is what we have right now. As in, you don’t know from the function signature if it has effects, basically.

*JF (0:16:36)*: Right, I see. So things can have effects, but it’s not tagged in the type level.

*OS (0:16:40)*: Exactly. Exactly. 

*JF (0:16:40)*: Okay, I see.

*OS (0:16:41)*: So it’s very much like exceptions, kind of. And so they’re working on that, and just seeing more theory being done around effect handlers is really nice, especially because we found them to be extremely powerful and very helpful for the stuff we do. There’s just so many problems where we reach them, and we’re like, “Oh, how do we have shared state but without passing it around and without having it be global?” because maybe you want multiple instances of it, or whatever. So, often, the answer is literally just to make an effect, have a wrapper, and it just works, and it’s efficient. More work around that is really cool.

*JF (0:17:13)*: Yeah, great. Okay, well, thank you very much, and I hope you enjoy the rest of the conference.

*OS (0:17:17)*: Thank you very much. 

*JF (0:17:31)*: Okay. So it’s the first day of POPL Proper, and I’m here with Yanning. And I understand you’re the second author on one of the talks here today. Do you want to talk about that a little bit?

*Yanning Chen (0:17:40)*: Yeah. The talk was about extensible data types with ad hoc polymorphism. So this talk was in a collaboration between the first author, Matthew, and me, Yanning Chen, and Ara, and my advisor, Ningning. 

*JF (0:17:54)*: So I was in the talk, and it was a great talk. My understanding of it is you want to do row types. So, stuff with records, you have named record fields, and you want to have some sort of polymorphism over them. So you have some field, and it’s like, “I’ve got a name field, and it has a type String.” But I don’t want to be too specific and say, “It must be this particular type which has this particular set of records.” I want to say, “For anything that has this name field with this String type, I want to be polymorphic over any records that have that field in the record.” So, can you talk a little bit about the general idea of how that works? What’s the idea of the paper?

*YC (0:18:30)*: Yeah, sure. So one thing I want to clarify, this kind of row polymorphic thing is not – we are not the first ones that mentioned this.

*JF (0:18:38)*: No. It’s also part of TypeScript, right, and I think PureScript has some.

*YC (0:18:43)*: Yes. Like, if you check the talk, there’s someone in the Q&A section who mentioned we should mention some related work. The previous work was called Rows, a type system called Rows.

*JF (0:18:52)*: Rows. Okay.

*YC (0:18:53)*: It’s kind of a type system with row constraints. Like, you can generalize over all types, and you can also add row constraints. For example, you can say, “For all A with some kind of label, and this label should be of some type.”

*JF (0:19:07)*: Yeah.

*YC (0:19:08)*: And also, you can add some fancy features, like first-class labels, to it. Then you can generalize over all records with some kind of field or some kind of type. This is a previous work. And we have this very nice feature of type classes. It was done several decades ago, which is also called ad hoc polymorphism. That’s why we have the name in the title.

*JF (0:19:31)*: Right. Yeah.

*YC (0:19:32)*: Yeah. And what we are doing is we are trying to combine these two stuff together. And the fact is, we are also not the first group of people trying to combine them. But we are trying to combine them in a new way.

*JF (0:19:42)*: Okay.

*YC (0:19:43)*: Yeah. That’s generally the story.

*JF (0:19:44)*: An example that was shown in the talk was you wanted to generalize over some orderable instance. You have some records, and you want to have an Ord instance for records in general. Like, in Haskell, if you make a record and you do deriving Ord for this record, it’s going to go through each field of the record in order, you know, do the order rule for the first field of the record. And then, if that’s equal, then you go to the next one, and that’s the tiebreaker. But that’s part of a – I don’t know if it’s fully metaprogramming or if it’s generic programming. But in this case, you’re doing it as part of a type class system.

*YC (0:20:17)*: Yeah. I would say if you think about this deriving approach, it uses a certain degree of metaprogramming.

*JF (0:20:23)*: Yes.

*YC (0:20:23)*: What we want to do is we are making it into the core language with this type class feature. And also for deriving, you need to add this derive blah, blah, blah into every definition of a type, which is cumbersome. The way we want to do this is we can implement Ord whenever a record has fields that have orderable type. So the way we do it is by introducing a new constraint called All.

*JF (0:20:46)*: And that’s all. Like, all of these things are a subtype of this thing. Was that it?

*YC (0:20:51)*: Yeah.

*JF (0:20:51)*: Yeah.

*YC (0:20:51)*: Yeah. You can introduce a new, I mean, row variable. For example, it’s called an α (alpha). In any case, if it satisfies All Ord α, then you can say, “Okay, this Pi α,” Pi means product type or record type, “this Pi α should also satisfy the Ord constraint,” and you can have implementation of the compare function for it. 

*JF (0:21:12)*: Oh, yeah, that was it. It was a type-level constraint, and you’re saying all of the fields in this record have instances of the Ord type class, right?

*YC (0:21:20)*: Yes, yes, yes.

*JF (0:21:20)*: Yeah. Okay. And then with that constraint as the precondition, you can then have the instance for the record with all of those fields. If all of them individually have an Ord instance, then the record of all of them has an Ord instance as well, and you specify what that is. But there was also something else in there, like sometimes you want to have commutativity in your records, right? Like, if you have a name field and then an age field, sometimes you want the order of those things to not matter in your type. But for the Ord type class, it actually does matter, right? Because you’re checking things in order.

*YC (0:21:50)*: Yeah.

*JF (0:21:50)*: So how did you deal with that in the work?

*YC (0:21:52)*: So actually, historically, they have different row systems, and some of these systems, they care about commutativity. Like, for example, if there’s a type with a name field and age field and the other type with an age field and name field, they are the same type. They’re definitionally equivalent. But in some other systems, they consider these two types different. And what we are trying to do is we can unify both approaches in the same system. During the resolution, we can specify whether we want to resolve it in a commutative or non-commutative way.

*JF (0:22:23)*: You can tag that on a type level, right?

*YC (0:22:25)*: Yes.

*JF (0:22:25)*: So it’s like a Pi type, but whether it’s commutative or not is depending on, like, you specify. 

*YC (0:22:29)*: Yes.

*JF (0:22:29)*: Okay. Yeah, that’s really cool. And are there any other talks that you’ve been to so far that you found interesting or want to shout out?

*YC (0:22:37)*: There are multiple talks, I think, that are pretty interesting, like, for example, the hyperfunction talk. Because, to be honest, I’ve never heard of the term “hyperfunction” before. And yeah, indeed, just as covered in the talk, I think it’s a weird type because it’s not strictly positive. Yeah, to be honest, I cannot – just by staring at the type signature, I am just not sure how it would work. I think it’s a really nice talk about a very interesting type. The thing I liked about this talk is that they used one concept, and it kind of generalized, and it kind of covered a lot of the past works.

*JF (0:23:13)*: Yeah. That was a really interesting part, like picking out previous literature and showing they’re having trouble with this particular thing, but actually, all these things are special cases of this hyperfunction thing.

*YC (0:23:24)*: Yeah, I think the general study of programming languages is you just keep digging back in the past literature and then find new stuff and generalize them and get those little pearls out of it.

*JF (0:23:34)*: Yeah, yeah, exactly. Any other talks that you found interesting?

*YC (0:23:37)*: Oh, yeah. This lazy linearity for a core functional language, I think this is pretty interesting because it proposes a new definition of linearity, which is called "lazy linearity" or some kind of "semantic linearity." I personally find this talk interesting because there’s possibly some relation between the definition of the lazy linearity and some concept in Rust.

*JF (0:23:58)*: And that concept is lifetimes, right? We were talking about this a little bit beforehand, but yeah. So the talk was about adding linearity to Haskell’s core language.

*YC (0:24:04)*: Yeah.

*JF (0:24:05)*: We have Linear Haskell, but it’s only on the surface language. In the core language, there’s no linearity as a thing. And so this talk was talking about adding linearity to the core language. And what you’re saying is that there’s maybe some relation with the techniques used there and lifetimes in Rust, right?

*YC (0:24:20)*: Yeah. 

*JF (0:24:20)*: So I’m not too familiar with lifetime, so could you explain how that works?

*YC (0:24:24)*: Yeah. Historically, there have been multiple definitions, like generations of definitions about what a lifetime is, but I’m trying to use the newest one that is getting proposed.

*JF (0:24:32)*: Okay. Hot off the press.

*YC (0:24:33)*: Like the Polonius one, it’s not even in the compiler, but there’s a whole thesis about it. So, the definition of a lifetime is like when you have a borrow, like, if it were reference types, there’s a loan. When you’re trying to borrow something, you are not taking the ownership, you are not going to scrutinize or to eliminate the value, you’re just going to borrow it for a short time, and you will just return the ownership later. Do you want to check how long this kind of borrow lasts? So you need to track the loan back to its original origins. Where do these borrows come from? Which free variable are they borrowing at a certain point in the program? 

And today’s talk about lazy linearity, it’s also trying to track from one certain variable to the origin of part of these components and to see if using this variable implies using another variables. It’s tracking the relationship between variables.

*JF (0:25:27)*: Right. Yeah. So hopefully we’re going to get that interview with Rodrigo later as well. But the idea, as I understood it, is that when you’re, for example, pattern matching on a tuple of variables, like, say, a tuple of X and Y, and the X and the Y are linear variables, then you can pattern match on that, and then that creates some new variables, like an A and a B, for example, if you’re pattern matching on the tuple. And now you have two variables, which are both referring to the same thing, but they’re supposed to be linear. Syntactically, you’ve already used X and Y, right?

*YC (0:25:54)*: Yeah.

*JF (0:25:54)*: Because you used them in your pattern match. But if you returned, like used the A and the B in the body of that case, then everything would be fine syntactically. That’s all linear. But if you use X and Y, even though it’s the same variables, syntactically, the linearity is broken because you’ve used the X and the Y twice.

*YC (0:26:11)*: Yeah.

*JF (0:26:11)*: But the idea of the talk and the paper, as I understand it, is that you’re adding some sort of tracking of, like, “This A has some linear relationship with this Y.” So, yeah, that’s your idea with the lifetimes thing. Like, there’s some sort of tracking there going on of, like, “This variable is almost being borrowed.” I don’t really know exactly. I’m not a big Rust person, so I don’t fully know that kind of stuff, but it seems like there’s something there.

*YC (0:26:33)*: Yeah. I mean, I think this example works as is in Rust. Like, for example, if you have some input like X and Y, you match on X and Y, and the branch says, “Okay, it turns into A and B.” So then you try to construct X and Y again. This program compiles in Rust.

*JF (0:26:50)*: Yeah. Interesting, interesting. Cool. Any other talks that you’ve seen or any talks that you’re looking forward to for the rest of the conference?

*YC (0:26:57)*: Okay, I would say that the next thing I’m going to check is the student research competition.

*JF (0:27:02)*: Yeah, of course. Are you in the competition, or is anyone that you know in the competition?

*YC (0:27:06)*: Yeah, I know there are some, like, people have some posters in the section. And I would say even if the work is not as complete as these main talks, lots of these posters would raise interesting questions or propose interesting ideas. So it’s a nice place to get some inspiration from.

*JF (0:27:22)*: I think some of them are already up. I don’t know if they’re down there talking about them, but maybe I’ll have a look. We’ll see. Okay. Well, thank you for talking to me. And enjoy the rest of the conference.

*YC (0:27:29)*: Thank you.

*JF (0:27:48)*: Cool. Okay. Well, I’m here with Edward Kmett on the first day of POPL proper. But you’ve been here for a few days already, right?

*Edward Kmett (0:27:54)*: Yeah, I think I showed up on the first day of all the associated events.

*JF (0:27:57)*: Right. Exactly. And have you been enjoying it so far?

*EK (0:28:00)*: It’s been great, actually.

*JF (0:28:01)*: Yeah. Any talks in particular that you’ve been going to or more on the hallway track?

*EK (0:28:05)*: There was a Dale Miller talk that was excellent.

*JF (0:28:07)*: What was it about?

*EK (0:28:08)*: What he would reclassify as positive and negative atoms and how that you can read as – and this is hard to articulate thing without a whiteboard.

*JF (0:28:16)*: Right. Yeah. Classic problem of the audio medium for a Haskell podcast.

*EK (0:28:21)*: The short version of it was if you take your LJ- or LK-style sequents, you wind up with a lot of administrative noise, and trying to separate the rules into the ones that are actually making a decision, and then which ones are just pro forma advancing.

*JF (0:28:36)*: And what is this? Sorry, this sequence, LJ, LK?

*EK (0:28:40)*: When you do type theory, you write – all those Greek letters that you see.

*JF (0:28:43)*: Oh, I see. Okay.

*EK (0:28:44)*: Like gamma entails something, right?

*JF (0:28:46)*: Right. Okay. Yes, yes, yes.

*EK (0:28:47)*: And then you draw a bar, then you keep going up the chain.

*JF (0:28:49)*: I see. Yes. Okay.

*EK (0:28:50)*: So Gentzen formalized that way back in the day.

*JF (0:28:52)*: So a lot of noise, a lot of stuff going on there.

*EK (0:28:54)*: And so there was a lot of administrative small rules.

*JF (0:28:56)*: Okay.

*EK (0:28:57)*: And so his observation was that you can split those into two different camps. It was a fun talk.

*JF (0:29:02)*: Okay. Great. Yeah. Nice.

*EK (0:29:04)*: It was an invited keynote, so it was the kind of thing that wasn’t, “Here’s our groundbreaking new research,” but it was more of a, “Here is an earnest appraisal of how we should be doing things from somebody who’s been doing this since the start.”

*JF (0:29:15)*: Yeah. And the keynotes are generally a more accessible sort of thing because you’re doing it to the widest audience possible, right? You’re trying to get a big group of people, and they might not know the particular research area that you’re talking about.

*EK (0:29:25)*: Exactly. The keynotes and the hallway track are the reasons I come to these events.

*JF (0:29:28)*: Right. Yeah, yeah. I struggle personally with the keynotes just because they’re so early in the morning, and that’s not my usual time to be awake. But could you explain the hallway track as well?

*EK (0:29:38)*: There’s conversations that you can have at an event like this that you just can’t have casually online.

*JF (0:29:43)*: Yes. There’s quite a high concentration of people who are like-minded or have similar background knowledge. And you can just talk to them in person and just grab them, and they’re just standing there. Like, Simon Peyton Jones is just there, or Edward Kmett is just here, and you’re like the person who’s made half of the libraries that I’ve used in my time learning Haskell.

*EK (0:30:01)*: I’m feeling really guilty now about not maintaining them so much for the last few years.

*JF (0:30:04)*: Oh, well, I think they all seem to work. I think yours aren’t the problem. I’ve had problem with the other ones.

*EK (0:30:09)*: Fair enough.

*JF (0:30:09)*: I think yours have been okay. Though, speaking of, I think one of your libraries got a shout-out in one of the earlier talks. Did you see that?

*EK (0:30:14)*: I don’t know which.

*JF (0:30:14)*: It was for the hyperfunction thing.

*EK (0:30:18)*: Oh.

*JF (0:30:18)*: Yeah. It was just like – I feel like in classic fashion, someone was like, “Hyperfunctions, here’s this new thing that no one has ever heard of. Oh, and it’s a library, and Edward Kmett did it.” It’s just one of those things. You learn about a concept, and like, “Oh, there it is.”

*EK (0:30:31)*: So the hyperfunctions library was more or less writing down a lot of the stuff that John Launchbury had already done.

*JF (0:30:36)*: Oh, interesting. Okay.

*EK (0:30:37)*: So, it all goes back another generation or two.

*JF (0:30:40)*: Right.

*EK (0:30:41)*: And so the hyperfunctions library basically has everything that John Launchbury said, and then it really was an observation that if you start looking at μ and ν, like least and greatest fixed points for a type, then ν admits sort of a formulation where you exploit some notion of a representable functor –

*JF (0:30:58)*: Okay.

*EK (0:30:58)*: – to defunctionalize it, in a way. Like, to actually take it from being a function and actually looking at a functor that actually has – if you say, like, F of X is isomorphic to E arrow X for some E, then any sort of fixed point that happens to take place over something that contains functions, you can often replace with these representable functors. And so that let us look at hyperfunctions in a different way, as a state monad, or like a state machine that contains a small number of values for a number of states. It made the thing that looked massive quite small.

*JF (0:31:27)*: Yeah, and it seems like the – so the talk itself was looking at some of the previous work going on, and it seemed like these hyperfunctions were coming up around, like, concurrency and continuation-passing style. And so it seemed like some previous work was showing how they could also be represented as hyperfunctions.

*EK (0:31:42)*: Yeah, I believe Launchbury was originally exploring them for fusion, like stream fusion, fusing zip-like operations.

*JF (0:31:48)*: But I think that was the first example that was shown, and then they showed some other concurrent examples. I think the idea was bringing awareness to this idea, which I had never heard of before. I think lots of people in the audience had never heard of it before. But speaking of the hallway track, how’s that been going? 

*EK (0:32:01)*: It’s been delightful, actually. How to put this? I sort of stepped away for the last couple of years to go off and focus on building a company and whatnot, and so getting a chance to come back and just see how many new faces there are and how much interesting stuff has been going on.

*JF (0:32:15)*: Is this your first conference back after that?

*EK (0:32:17)*: I believe I actually made it to POPL last year.

*JF (0:32:20)*: In Denver?

*EK (0:32:21)*: In Denver, yes.

*JF (0:32:21)*: Yeah. Okay. I missed that one.

*EK (0:32:23)*: But I missed ICFP this year, so it’s been a mixed bag for me.

*JF (0:32:27)*: It was a good ICFP, but it was quite a distance to go. And speaking of this company that you’ve been building, and I think it will be the reason that you haven’t been focusing as much on Haskell recently, has been, yeah, this company. So, do you want to say just a little bit about it, or –

*EK (0:32:40)*: Sure. So about, I think it was two and a half years ago, my business partner and I went off and started Positron AI. We make chips that make AI run really fast, or, in particular, in the short term, we were able to get an FPGA-based appliance that can outcompete NVIDIA in terms of performance per dollar and performance per watt, which –

*JF (0:32:57)*: Pretty impressive.

*EK (0:32:58)*: When one thinks about FPGAs, one doesn’t particularly think of them as the high-performance solution, but –

*JF (0:33:03)*: No. Yeah.

*EK (0:33:05)*: – it turns out that with the economics of this niche, it’s possible.

*JF (0:33:08)*: Those NVIDIA chips are getting pretty expensive.

*EK (0:33:11)*: Exactly.

*JF (0:33:12)*: So, that’s probably helping a little bit. Cool. Great. Well, is there anything you’re looking forward to for the rest of the conference?

*EK (0:33:17)*: Mostly just getting a chance to catch up with people.

*JF (0:33:20)*: Yeah, I guess if you’ve been away for a little while and all these people that you know, and then they’re all here suddenly, and –

*EK (0:33:24)*: Mm-hmm.

*JF (0:33:25)*: Yeah. Great. Perfect. Well, thank you very much for your time, and enjoy the rest of the conference.

*EK (0:33:28)*: Thank you. 

*JF (0:33:43)*: Okay, so POPL is over. We are –

*Eddie Jones (0:33:46)*: Indeed, it is.

*JF (0:33:46)*: Yes. Us, Bristolers, we tend to have a tradition at the end of a conference. We all get together, have a nice dinner before we all head home. So I’m here with lots of the Bristol lot. POPL’s done. We’re going to have a nice little retrospective. So I’m here with, first of all, Eddie Jones from Bristol. 

*EJ (0:34:02)*: Hello.

*JF (0:34:03)*: You are a lecturer, I believe.

*EJ (0:34:05)*: I am, indeed.

*JF (0:34:06)*: Is that your official title?

*EJ (0:34:06)*: Yes.

*JF (0:34:06)*: Wow. There you go.

*EJ (0:34:06)*: That’s my official title.

*JF (0:34:08)*: So, first of all, when did you get here? What was the –

*EJ (0:34:10)*: I got here on Tuesday afternoon, so the day of PLMW, which I did not attend. So I just sort of wandered around for a bit.

*JF (0:34:20)*: Ah, I see.

*EJ (0:34:21)*: And then, yeah, Wednesday was my first proper day.

*JF (0:34:23)*: I see. So, basically, you were here for POPL proper.

*EJ (0:34:25)*: Yes, POPL proper. That’s the –

*JF (0:34:26)*: Okay. Proper POPL.

*EJ (0:34:28)*: Yes. PPP.

*JF (0:34:29)*: Proper POPL.

*EJ (0:34:30)*: Proper POPL.

*JF (0:34:30)*: Okay. So any thoughts on that? Anything that you thought was particularly interesting or anything that you want to shout out? Anything that sticks out to you?

*EJ (0:34:38)*: So I guess I did more networking than I normally do.

*JF (0:34:42)*: The hallway track.

*EJ (0:34:43)*: The hallway track, yes. I wouldn’t say I’m normally a big networker, but yeah, this year, I seem to have made some newer connections, which is nice.

*JF (0:34:52)*: Any particular reason you think that might be, or you’re just feeling more social this year?

*EJ (0:34:56)*: Maybe just feeling more social. Yeah, yeah.

*JF (0:34:57)*: Just more social, yeah. Any talks at all that you saw that you thought were particularly interesting? 

*EJ (0:35:01)*: I actually really enjoyed the keynote on the first day by Damien Pous about robustness within proofs. I can’t remember the exact title, but I thought it was a really nice call to the community for the development of, I guess, most specifically, rewriting techniques, matching techniques for creating these robust proofs. But I just thought the motivation was extremely elegant, as a proof is not a static artifact but something which is designed to be iterated on and readable as well as writable and so on.

*JF (0:35:30)*: Interesting. So the motivation being, like, you want it to be something that other people can read, and you can update. And you, in the future, can read it and –

*EJ (0:35:37)*: Yes. Exactly, yeah. A proof is not just there to witness the truth of the given statement but also to give you a guide as to how to prove similar statements going forward.

*JF (0:35:46)*: Interesting. Okay, cool. And any other talks that you want to sort of shout out?

*EJ (0:35:50)*: I really also enjoyed the talk today on algebraic effects theory for concurrency.

*JF (0:35:57)*: Interesting.

*EJ (0:35:58)*: Partially, I’m biased because it was related to a paper that we had, well, related in the sense that it followed a similar structure. It was nice to see the same approach appearing again. It was very well executed.

*JF (0:36:10)*: What was that structure? What was the sort of common structure?

*EJ (0:36:14)*: So the model is about these partially ordered sets, which is kind of standard for concurrency. But I think the real insight was that this can be done algebraically, which is somewhat non-trivial, although it may be – I don’t know. The talk made it seem obvious, but I think it’s non-trivial.

*JF (0:36:28)*: Okay.

*EJ (0:36:30)*: Yeah. So it’s partially ordered sets, pomsets. And then it extends this with holes. It’s a parameterized algebraic theory, which I guess—I don’t know—is something which Sam Staton, who was on the paper, potentially had some influence on. Sam Staton’s work was also an influence on our work, so that was nice to see the similarity in sources.

But yeah, I think it’s determining how to make these algebraic, which is non-trivial.

So this fork construct, rather than you give a process specification and it gives you back a thread ID—fork in this case was copying the call stack. So the result type was effectively a sum type, where you can tell whether you are the copy or not based on the results. So it has the same effects. Like, you can describe a normal fork in this way, but by specifying it in this manner, you get something which is a lot more algebraic. So I thought that was really cool. 

*JF (0:37:16)*: Great. Thanks very much. So we also have Tom Divers with us –

*Tom Divers (0:37:20)*: Yep, that’s me.

*JF (0:37:21)*: – a second-year PhD student at Bristol. Have you been to another conference before?

*TD (0:37:24)*: I’ve not been to another conference before. This is my first serious conference, yes.

*JF (0:37:27)*: How was it as a first conference, your first PL conference?

*TD (0:37:30)*: Very, very good. I really enjoyed that. I’m glad I bothered coming.

*JF (0:37:34)*: Yeah.

*TD (0:37:35)*: I mean, it was sort of too close for me to not bother.

*JF (0:37:38)*: We can take the train. How exciting is that? Love that.

*TD (0:37:41)*: Oh, I love a good train.

*JF (0:37:42)*: Yeah, yeah. Planes, rubbish.

*TD (0:37:44)*: Yeah. That’s about as opinionated as this will get.

*JF (0:37:46)*: Yeah. I mean, there’s like seven, eight of us, nine of us, I think, 10 maybe, who came.

*EJ (0:37:52)*: There was 10 in total.

*JF (0:37:53)*: 10 in total who have been here.

*TD (0:37:55)*: Yeah, yeah.

*JF (0:37:55)*: And yeah, really no excuse. So what did you enjoy most about it?

*TD (0:37:58)*: I think Eddie just mentioned the hallway track being an integral part of these things. And I love watching a good talk, but coming in, I was expecting the talks to be more important than they were. I mean, I hadn’t read any of the papers prior to coming, so I was expecting the talk to give me a really solid idea of which papers I had to go in and devour. It turns out you can’t attend every talk that you care about, so –

*JF (0:38:19)*: No.

*TD (0:38:19)*: – there’s plenty of papers that I really intend to read that I didn’t get to see the talks for. But the hallway track is real. The hallway track is not a lie.

*JF (0:38:26)*: Yes.

*TD (0:38:27)*: It seems like some of the most interesting research there I didn’t see the talks for, but I got to speak to the co-authors of the papers. So that was good. It was a good stress test of my capacity to network, which I enjoyed. It turns out just standing on your own is a good strategy, because people who are better at networking than you are will hone in on you and go, “Hmm, that’s prey. I can talk to this person.”

*JF (0:38:49)*: Right. And networking is like – it sounds very corporate. It sounds like you’re doing something, I don’t know, seedy or something. But really, it’s just talking to people and just like having conversations and having an interesting time and taking a genuine interest in people and their work.

*TD (0:39:04)*: Yeah. I mean, the word “networking” is a terrible name for it because it’s one of these corporate attempts to name something that humans do anyway –

*JF (0:39:12)*: Socializing.

*TD (0:39:13)*: Yeah, interact with each other, get to know each other. This is something we’ve evolved to do as a means of survival. I mean, I can’t speak for everyone, but for me, it was not as hard as I was expecting it to be. To get into a room full of people that are much more experienced and much smarter than me and have meaningful—I mean, hopefully mutually beneficial—conversations that have really, really helped some of the direction for some of the stuff I’m working on now.

*JF (0:39:33)*: Can you elaborate on anything that that might be? Anything that you’ve particularly been inspired by or found helpful?

*TD (0:39:39)*: Yes. I had a poster at the student research competition –

*JF (0:39:41)*: Ah, yes, of course.

*TD (0:39:42)*: – on some work that me and Eddie, who you’ve just heard from, had been working on, where we’re looking at trying to formalize the borrow check of it in a way that will be theoretically satisfying more than it will be useful for actual verification. So I had the poster, didn’t get through to the finals, so I didn’t have to give a talk, which was probably more of a blessing than it was a curse.

*JF (0:40:00)*: Well, there were so many posters as well, and there was only six candidates for the finals. So it was quite tough. 

*TD (0:40:04)*: Yeah, and three –

*JF (0:40:04)*: And three for the PhD students, right? 

*TD (0:40:07)*: Yeah, yeah. But I wasn’t really expecting to get that far anyway. I had some really, really good conversations with a lot of different people there. One of the judges, Ralf Jung, that was a really good talk when he was judging it. He had a lot of very constructive criticism, I think. If we ever try and get this stuff published, it’s almost certainly going to be read by a verification person.

*JF (0:40:23)*: Right.

*TD (0:40:23)*: That was a stress test of how to present to those sorts of people in its current state, and I think the takeaway was that it needs a bit more work on the presentation side and the persuasion side. It was really informative as to how we’re going to need to make that argument. I also had a really, really good conversation with some people at ETH Zurich, which was very productive and very helpful, pointing out some of the other considerations I’ll need to make. Isaac Van Bakel or something. I might be messing up the last name there.

*JF (0:40:49)*: Sure.

*TD (0:40:49)*: But a PhD student at Zurich who had some very useful comments. Another good conversation with Amal Ahmed at Northeastern. She had some really good positive feedback to indicate that this is a good direction to go in and that we haven’t just cooked up a load of nonsense, that this is the right direction to take.

*JF (0:41:05)*: Always nice to have that kind of reassurance, right?

*TD (0:41:07)*: Yeah, yeah. And then just other various conversations with people that I wouldn’t have an opportunity to talk to otherwise, in areas that I didn’t quite realize existed in some cases.

*JF (0:41:16)*: Right. And I believe you also went to PLMW. Is that correct?

*TD (0:41:20)*: Yes, I was at PLMW. I got here on Monday night.

*JF (0:41:22)*: Yeah. Took some convincing to get you there. I think you were planning to just go to POPL itself. And I was like –

*TD (0:41:27)*: No, not that much convincing. 

*JF (0:41:28)*: No, not much convincing? Oh, okay.

*TD (0:41:29)*: No, not as much convincing as you think.

*JF (0:41:31)*: Perhaps I recall differently. But how did you feel about PLMW? Do you think it was a good idea to come?

*TD (0:41:36)*: Yeah. Very positive experience. Very good talks. One talk in particular, Paul Levy’s talk on call-by-push-value. It was a talk that he very explicitly said was designed for a very non-specialist audience—people that might not even have degrees in computer science, or even maths, or anything like that. It was a really good case study on how to take something like call-by-push-value, which is deep in the treacherous waters of proper theoretical PL –

*JF (0:41:58)*: Right.

*TD (0:41:59)*: – and to untangle that in a way that makes sense for someone in a non-specialist audience. I mean, it made sense to me then, and it was good hearing about call-by-push-value from the guy who invented it, but I could imagine that I would have gotten almost as much from that if I had not done a computer science degree, which was good. And then other good talks, Alex Kavvos’s was good.

*JF (0:42:19)*: Also, a Bristol person.

*TD (0:42:20)*: Yes. We’re walking behind one of his PhD students right now, who had a very good talk on domain-theoretic semantics, which was good.

*JF (0:42:29)*: Yeah, that was the first talk of the functional section, right? And functional logic programming, right?

*TD (0:42:33)*: Yes, yeah. Domain-Theoretic Semantics for Functional Logic Programming was the title.

*JF (0:42:36)*: Yes.

*TD (0:42:37)*: The PhD student in question is Samson Main. He had very, very well-done talk. Very, very impressive work. Alex also gave a talk to PLMW about how to write a paper. 

*JF (0:42:47)*: Well, how to deal with rejection of a paper, really.

*TD (0:42:49)*: Also, how to deal with rejection. A lot of very good advice for your mentality in that. I haven’t had to go through that yet. I haven’t had enough to –

*JF (0:42:55)*: The pain of Reviewer 2 yet.

*TD (0:42:57)*: Yeah, yeah. I don’t had to experience that yet, so it’s good to get that in advance of when I’ll need it because we’re planning on submitting some stuff to ICFP soon, and then the feedback for that is going to come in April if we make that deadline. It could be good, but it also could be bad.

*JF (0:43:10)*: Right.

*TD (0:43:10)*: So it’s good to have strategies to mitigate the psychological impact of that, and his strategies seem to make a lot of sense. Simultaneously, putting yourself in a superposition where you’re disconnecting yourself from your work, your work is not you, and also, your work being bad is entirely your fault, and it’s only you that’s going to make it better –

*JF (0:43:28)*: Right.

*TD (0:43:28)*: – which seems like a good combination of perhaps slightly contradictory statements, but –

*JF (0:43:32)*: Well, the point being, you have created it, so it is your responsibility. But at the same time, if it is bad, that doesn’t mean that you are bad or you are incapable. Only that it is up to you to make it better and improve it. But it doesn’t mean that you are a bad researcher. Just because you’ve made some maybe not-so-great work doesn’t mean that you are not so great of a person or researcher.

*TD (0:43:52)*: Exactly, yeah. It was good to hear that from someone who has got lots of papers published.

*JF (0:43:56)*: Yes. And also papers rejected as well.

*TD (0:43:58)*: Yes, yeah.

*JF (0:43:59)*: And that’s just part of the process.

*TD (0:44:00)*: Yep.

*JF (0:44:01)*: Yeah, and as we saw in business meeting, I think 75% of papers are rejected this year, so lots of us have had our experience with that. I myself do as well.

*TD (0:44:10)*: Yeah, yeah, yeah. It’d be odd if you didn’t.

*JF (0:44:12)*: Exactly. Great, thanks very much.

*TD (0:44:14)*: Yeah, more than welcome.

*Narrator (0:44:26)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.

*TD (0:44:42)*: Don’t edit it to give us opinions we do not want.

*JF (0:44:44)*: No, I won’t.

*TD (0:44:45)*: Thank you, Jess. You’re the smartest person ever born. You’re the funniest individual ever known to man. Workers of the world, unite.
