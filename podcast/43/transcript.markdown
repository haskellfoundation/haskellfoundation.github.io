*Wouter Swierstra (0:00:13)*: Welcome to the next episode of the Haskell Interlude. I’m Wouter Swierstra, and I’m joined today by Andres Löh.

*Andres Löh (0:00:20)*: Hi.

*WS (0:00:20)*: And Ivan Perez. So, Ivan will share his experience in how doing a PhD in functional reactive programming led to his current job as a senior research scientist at NASA. He’ll tell us a little bit about his work on the Copilot embedded domain-specific language for runtime verification and the obstacles he encounters in getting users to use such a Haskell-based language. 

Okay. Welcome, Ivan. So, the usual question we ask our guests is, how did you get into Haskell?

*Ivan Perez (0:00:52)*: So, I was, I guess, a little bit lucky it turns out in the end because they taught Haskell in my university to everybody. Like everyone had to learn Haskell.

*AL (0:01:04)*: And that was what university?

*IP (0:01:06)*: And that’s the Universidad Politécnica de Madrid. That’s the Technical University of Madrid. So, everybody had to learn Haskell and Ada, which is weird because I’ve had to use both now in my current job.

*AL (0:01:20)*: Nice.

*IP (0:01:21)*: It was an interesting coincidence looking back.

*AL (0:01:24)*: And are you saying these were the only two languages you learned?

*IP (0:01:27)*: These were the first two languages you learned at the university. 

*AL (0:01:32)*: Okay. Interesting choice.

*IP (0:01:33)*: They start with Ada and Haskell. And we had several years of Haskell, actually—Haskell in first year and second year, and the same with Ada. We had Ada for several years. And one of the people teaching Haskell, he was a professor in a declarative programming group, Babel, which is linked to IMDEA, which is where Niki Vazou is working. And he recruited me for his lab to start working with him. And initially, I was working in Java with him. But soon after that, I started also working in Haskell with him. And that was it. I just fell in love with the language. 

So, at the beginning, in my first year, we would write things in Ada and then write the pre-conditions and post-conditions of things. And it was a bit – you had to do some transformation to go from the pre-conditions and post-conditions to the code. But in Haskell, I realized that all you had to do was remove the comment, like prefix of the line, and that was pretty much it. Then just substitute the & for the double&. And that’s when I fell in love with the language. It was like, “Yeah, this is for me.”

*WS (0:02:38)*: So, this was during your undergraduate in Madrid? 

*IP (0:02:41)*: Yes. 

*WS (0:02:41)*: And then you went on to do a PhD, and that was in Nottingham, right?

*IP (0:02:46)*: Yes. I went to do a PhD in Nottingham. I started my PhD in Twente.

*WS (0:02:50)*: Ah, in the Netherlands?

*IP (0:02:51)*: Yeah. With Christiaan Baaij. And six months in, it was my place. I had an offer also to go to Nottingham. And I –

*AL (0:03:02)*: But I mean, when you decided to do a PhD, did you specifically look for something like where you could use Haskell? Was that the guiding principle, or did you look for a particular topic?

*IP (0:03:15)*: I was definitely interested in FRP, but I don’t know that I looked for something specific. I think it was just FRP-related, Haskell was good, but not much more specific than that. I didn’t know exactly what I wanted to do just yet.

*WS (0:03:31)*: So, FRP is functional reactive –

*IP (0:03:33)*: Reactive programming. Yes.

*WS (0:03:35)*: And can you, in one or two sentences, tell us a little bit about what that is?

*IP (0:03:40)*: So, FRP is an abstraction to describe programs as values that change over time. And at its very essence, it’s a temporal abstraction. People think about FRP in terms of reacting and events and so on, but it’s just a way of structuring your program as functions of time, let’s say, and where time is ideally or conceptually continuous. And there’s been a lot of – the term has stretched in many directions, and now people call everything FRP. But I stick to the original definition, where FRP is over continuous time. Everything else I call F, RP. It’s functional, it’s reactive, but it is not functional reactive.

*WS (0:04:23)*: And that was also the topic of your PhD, right?

*IP (0:04:26)*: That was the topic of my PhD, yes. I started with something a little bit different, reactive values, which were just a more operational imperative way of doing interactive programming. And Henrik Nilsson, who was my PhD supervisor, he wanted me to go in that direction so that I would have my own thing. But I looked at Yampa and I looked at the work that he had done, and I’m like, “No, I want to do this.” And very quickly in the PhD, we saw that if we take Yampa and the basic abstraction of Yampa is that it’s a function that, given an input and a time delta between the last sample and the new sample, it gives you the output and a new version of the whole thing. That’s the way that it’s structured. If we take the time away and we put them on it, we become a lot more expressive. And we started pursuing that direction. And that’s the direction that I went to my PhD. And it was a lot of fun and I still use it, including for my current work. I use that abstraction. 

*WS (0:05:23)*: So, you mentioned your current work, and I know that after your PhD, you first founded a company doing game development using Haskell, but now you work somewhere else entirely, which is at NASA.

*IP (0:05:38)*: Yes. I work at NASA. I’m a contractor, yes.

*WS (0:05:42)*: Okay. Well, it’s not exactly rocket science, but maybe you can tell us a little bit about what you do there.

*IP (0:05:49)*: Yeah. So, I was – again, that’s why, looking back, I was very lucky because I was hired to do Haskell at NASA. That was the job.

*AL (0:05:58)*: How did that happen? Can you give a little bit more detail on –

*IP (0:06:02)*: Yes, I can give you a bit more detail. So, I was near the end of my PhD. I think this was about July or so. And I got a message from Graham Hutton, who was my second PhD supervisor, saying, “Hey, NASA is looking for people.” And I always thought, I cannot work at NASA. I always thought my path was going to be towards ESA, the European Space Agency. But they sent it here. They sent it to the UK. They know what they’re doing. So, if they sent it here, that means we can work there somehow. So, I just applied. And at that point, I had been programming Haskell for, I think, 16 years, something like that. So, I had enough experience to justify at least I’m worthy of applying. I’m not going to get this job, but I can apply. And I got it. It was actually not a super complicated interview. I think it was a combination of things. I think I had a reasonably good profile, but at the same time, it was a remote location. It’s not a fancy place to be. It was in Langley. It was in Virginia. So, I struck luck, I guess. And I joined Alwyn Goodloe, who was one of the creators of the Copilot language. And for people who may be unaware, Copilot is a runtime monitoring language. It is a stream programming language. And that’s where it connects to FRP. It connects to other work that I have done, but that’s why Haskell is such a good fit for creating a language like that.

*AL (0:07:29)*: Okay. And they were already using that, and that’s why they were looking for Haskell programmers.

*IP (0:07:35)*: Exactly. They were using that. That’s the language that Lee Pike from Galois and Alwyn Goodloe created together. And at the time, Frank Dedden was working on this language, and I joined them. And then Frank left, and I remained as the technical lead of the project.

*WS (0:07:53)*: Okay. So, what is runtime monitoring? 

*IP (0:07:57)*: So, runtime monitoring is a technique that is used in formal methods or in formal verification, and it’s used a lot in aerospace. The idea is that there are some things that you can formally verify, proof. Everything’s checked. We’ve checked all cases. Great. You can, of course, also test, but then we all know the problems with testing. You are limited only to the cases that you have checked. And if the system that you’re testing is not referentially transparent, then the tests only say so much. So, runtime monitoring is something that you put onboard normally. And the idea is that during the mission, you’re monitoring the system that you’re studying or the system under observation. It could be an aircraft, it could be a spacecraft, and checking for property violations. And if there’s a violation, then you trigger either some fault handling mechanism or the pilot takes over instead of the machine or something like that. Maybe you log it for posterity, and then you study it later.

*WS (0:08:57)*: Yeah. So, what would be the kind of thing that you check?

*IP (0:09:01)*: It could be all kinds of things. It’s very mission-specific, but for example, a property that we checked recently was we check a lot of state machines. The designers have a state machine in their mind, and they have implemented all of this in C code. And we describe the state machine at a higher level, like in a more abstract way without the low-level C implementation details. And then we have the monitors check that the transitions that the machine is doing are correct.

*WS (0:09:28)*: Right. So, that would be something like a state machine, the 101 example is having a thermostat where there’s something measuring temperature, and then when the temperature is high enough, the heating goes off, and when it’s too high, the AC goes on. That kind of behavior. 

*IP (0:09:46)*: Yes. 

*WS (0:09:47)*: And then the runtime monitoring would check that you never have a situation where the temperature is both too high and too low or something like that, right?

*IP (0:09:56)*: Yes. Yes. That would be a classic example. And that’s one of the examples included with Copilot. The example is directory, but I can give you a more realistic one, which is the, we have a drone, and the drone can be in autopilot mode. The drone can be in hold altitude mode. And some of those modes only make sense, for example, if you have certain data. If you have a GPS fix, you can be in autopilot mode, otherwise, you cannot. Our monitors can check for those things. 

*WS (0:10:27)*: Right. Okay. That makes sense.

*AL (0:10:29)*: Is this related in any way to – I mean, if you do property-based testing of stateful systems, you often also build something like an abstract model or a state machine, and then you test your actual program versus your abstracted state machine, but in this case via pre-generated actions, and see whether both are keeping in sync. Is this runtime monitoring similar only that you use the real execution? 

*IP (0:11:01)*: I guess you could say it. I’m not sure, but yeah, one of the main differences is this is running live on the vehicle. You can also use it for testing, and we do. Once we have the monitors, we leverage them for testing purposes. But some of these frameworks, like some of the code that we’re generating, is for NASA’s core Flight System, which is an open-source flight software implementation or a framework and is notoriously bad at running things in an unattended way. We don’t have an easy time running this, for example, in a CI server and replaying flights and things. And our systems are prepared to just run onboard. And so, this language, Copilot, when you compile it, it generates hard real-time C99, like predictable time, predictable memory. And that’s why it’s so suitable to deploy in these systems.

*WS (0:11:52)*: So, I guess the difference with property-based testing would be that to test these kind of things, even if you have this abstract state machine, you still have to write the generator, which issues a bunch of commands that will then actually test the system’s behavior somehow or not. And here you actually are doing the same kind of dynamic check, but the generator is like the real human in the rest of the world, rather than something I cooked up with, right?

*IP (0:12:23)*: So, it’s interesting that you bring that up because now we have – so, Copilot and other tools that we’re building in Haskell at NASA go through – I don’t want to call it certification, but through a process of assurance to be used in different kinds of missions. And this is called the NPR 7150. NASA has procedural requirements for software engineering. So, Copilot, to be able to be used in flights, has to go through that process. And one of the things that we had to do was add tests. So, if you go today to the repo, you’ll find all kinds of tests. And we had to implement those generators for the actions that you were talking about. All in QuickCheck.

*AL (0:13:02)*: So, that’s an interesting topic in itself. I mean, the requirements that such a system has to go through, because I’ve heard sometimes arguments against Haskell in the sense that, “Oh yeah, if we want to use it in this industry, then we have to go through all sorts of certification processes and you’ll never get GHC certified,” or something like that. Was that an issue at all? Is it because Copilot is a domain-specific language, you somehow get around this, or do they not care, or –

*IP (0:13:36)*: So far, I don’t think it’s ever been an issue. And we can actually use some of Haskell’s assets to our advantage or some of the best-selling points of Haskell to our advantage. For example, when it comes to testing, we can claim that because we run certain tests, we have the guarantee from the compiler that if we run the same test cases again, we will get the same result. This is something that you wouldn’t get in another language. So, we have a test plan, and we have all of these things embedded in our documentation. I don’t think it was ever an issue. What we did have to do was Galois built for us the Copilot verifier, which is a tool that establishes a format proof between the C code that comes out of Copilot and the denotational semantics of the language. And that is used for providing evidence of the safety of the code that we generate.

*AL (0:14:30)*: Ah, right. Okay. So, you directly get some sort of – like you don’t just get C code, but you get –

*IP (0:14:36)*: A proof that the C code is correct.

*AL (0:14:38)*: Okay. Yeah, no, that is of course a very strong thing because then in every single instance, you have something about the result, right?

*IP (0:14:47)*: Yes. And you don’t have to trust the Haskell compiler anymore.

*AL (0:14:50)*: Yeah, exactly. No, that sounds rather difficult, actually.

*IP (0:14:57)*: You can have them on and ask him about this. But yeah, it sounds rather difficult. But it’s been – yeah. Sorry, I just realized I can’t get into details about that. But yeah, for legal reasons, I can’t, but it sounds rather difficult.

*AL (0:15:14)*: Yeah. Okay. So, how many years are you now at NASA?

*IP (0:15:19)*: It was six years, like a week ago.

*AL (0:15:21)*: How has your work evolved since you joined, and what other projects have you been taking on? Or have you just been working on Copilot all this time, or – 

*IP (0:15:32)*: So, I’m going in a couple more directions. The first one is apart from Copilot, I built a tool around Copilot called Ogma, and this is also written in Haskell. And what we found is that the distance between Copilot or some of the libraries that Copilot gives you for, say, temporal logic and other languages that people are using, like Lustre or just temporal logic and so on, is so small that we can build a translation tool so that if you already have the spec in the other language, you can go to Copilot very easily. So, I built that tool. It’s called Ogma. And initially, Ogma would only give you the Copilot monitors, but what we found is that if we give people this, it’s not enough of a justification to use that tool. But what we can give is all of the glue code that you need to actually deploy this in the flight software, in the vehicle, and connect it to everything else in your system. 

So, the way that these frameworks work is that you build an application by creating components that communicate with one another, either directly through ports or through a software bus. And what we do with this tool is we generate another application that does monitoring and it hooks to the software bus, and it listens to everything that’s going on, and then reports the property violations. And that becomes a push-button solution for them, for engineers that don’t know anything about Haskell. They don’t want to know anything about Haskell. They just write the property in their preferred language, hit a button, and they get something that is ready to fly.

*WS (0:17:08)*: So, you have these languages like Lustre, which I know almost a thing about, but they’re about stream transformations, where there’s streams of events and things coming in and it’s all clocked and synchronized and safe somehow. But these are used quite a bit in order to describe the state machines or the behavior that they should have. Is that fair?

*IP (0:17:32)*: Yeah. It can be used that way, yes. And it could be Lustre.

*WS (0:17:35)*: And then what Ogma does is it translates this to Copilot, which then basically generates the C code to do the monitoring. 

*IP (0:17:44)*: Yes. 

*WS (0:17:45)*: And then the extra added ingredient is that you also not just generate the C code to do the monitoring, but also manage to generate the wrapper and others, kind of cruft that you need in order to hook this into your project, right?

*IP (0:17:59)*: Yes. And we go not just from Lustre, but from other languages too. We go from constrained natural language directly into Copilot. So, you can write something that looks like English, hit a button, and then get Copilot monitors, which for people who don’t know programming or don’t do a lot of program, it’s very appealing, especially because the mental model of Lustre and the mental model of just stream based languages is so different that unless you cannot get it from the beginning, it’s really hard. I recently built a translator, for example, from – I think it’s the DOT Graphviz format for graphs so that you can just write the state machines that way, hit a button, and get the monitors for that in Copilot. That’s the kind of thing we want to give to the user. And you get, as you said, the glue code or the wrapper so that you can just deploy the application. And we’re targeting NASA’s core Flight System, but also the Robot Operating System, which is used everywhere. NASA uses it, and many, many organizations worldwide use it. And we’re targeting F Prime, which is the flight software that was used in the Mars helicopter. We did not get into that mission. I wish, but we didn’t. But there are more missions coming after that. 

*WS (0:19:14)*: Right.

*AL (0:19:15)*: And these translators, they’re all written in Haskell as well? 

*IP (0:19:19)*: Yes. All of this is written in Haskell.

*AL (0:19:21)*: But this is all closed, right? 

*IP (0:19:24)*: No. It’s all open. 

*AL (0:19:24)*: This is all open. 

*IP (0:19:25)*: Everything I do is open source pretty much.

*AL (0:19:27)*: It’s all open. Okay.

*IP (0:19:28)*: Yeah. So, Ogma is on NASA’s GitHub. Like if you go to github.com/NASA/Ogma and you find it. And Copilot is under its own organization, the Copilot language organization, but that’s also there. And now I’m building more tools. I’m building one called *(0:19:45 unintelligible)* that pulls data from GitHub and Git. We have a version of this in R because the person who did it just had experience in R and had already a framework in R, but I’m rebuilding this tool. And so, going through that process of certification is very time-consuming and expensive, and you can make a lot of mistakes. So, what we want to give people is a tool that is going to check all of that for you. And ideally, you should be able to adapt it to any other project. Say, for example, that in – I don’t know. I think in GHC, for example, you mentioned the issue that you’re dealing with in the commit message. If you want to make sure that you never miss those, so that there’s always an issue for every commit, then you can add that rule in *(0:20:31 unintelligible)* to the PR build, and it will check it for you in the PR. But it also gives us a bit more data. 

So, for example, in Copilot, when we ran this tool, it told us that there were two people that were taking on most of the work. So, it do a graph for us of who was working on what, and it told us there are two people that are working on everything, and the rest of the people are really not doing much, which is fine because there were two people that normally paid for working regularly, and a few people that just assisted. It was expected, but it also means there’s a risk for the project. If I leave, for example, now NASA, Copilot is at risk of dying or being severely affected. And it’s a tool that tells you also that. It’s not just about compliance, but it’s also about the risk that you’re taking on the project. And that’s also Haskell.

*AL (0:21:19)*: Yeah. You’ve half answered another question I wanted to ask, so perhaps I can slightly rephrase it. I mean, at first, I wanted to ask, like, have you stayed more or less the only or one of the few people working on Copilot at NASA, or has that team grown? But I mean, what I’m also interested in is, which you’ve also partially already answered, but perhaps you can say more about this, you are working on the tools, like the general tools and the translators, but are you also writing the programs for these tools? It sounds like this is done by other people, right? Other people are using your tools, but they’re mostly not using Haskell directly then, as it sounds. But they’re using other input languages that they like to think in. 

*IP (0:22:08)*: So, about the first question, the team grew and then it is Frank, we had one person at Langley that was working on this and left a week ago. And we work very regularly with Galois. So, Galois keeps working on Copilot. And we also keep working with Frank Dedden, but he only does it on his free time. But he’s also a regular contributor. And then we have interns that come and go, and we have the occasional contributor from outside. 

And the other question was, who uses the tools? I think it’s pretty hard. Even though we have tried to make the language as easy to work with as possible, it’s still pretty hard to get people to write Copilot. And I don’t know if that’s the case, but my suspicion is there’s a certain aversion to Haskell because of the preconceptions that people have about it. And because this is a DSL embedded in Haskell, you still have to use the Haskell tools. There’s the inner complexity that comes with it, like just figuring out how Cabal works, how GHC works, and all of these things. But then you’re reminded all of the time. And for example, to work in Copilot, you have to write things like import Prelude hiding parenthesis in a bunch of things that we redefine, and a few other things. And then just the fact that you have to do these at these Haskellisms reminds you that you’re not in your own dedicated language, even though we tried really hard to give a smooth experience for the user. So, that’s still pending work. We’re trying to make that easier for people. We’re hoping to convince more people to start using Haskell directly or compile it directly without being aware that they’re using Haskell.

*WS (0:23:56)*: Yeah. And is that something that Haskell could be doing better, do you feel? Is that like you could imagine some kind of custom syntax or macro or something to try to hide some of the implementation stuff about importing certain things that you could just write Hello Copilot and that would somehow get desugared into the crufty code that you mentioned? 

*IP (0:24:21)*: That’s a good question. From the language perspective, once you open the file and you start writing, I’m not sure. I think the only thing that I can think of on the spot is if by default we hide the Prelude, then people would have to import things explicitly. And as annoying as it can be, at least they are not so aware.

*AL (0:24:42)*: But that is possible, right? 

*IP (0:24:44)*: Yeah. It is possible. We don’t do it by default, but it is possible. From the tool perspective, I think yes. And I’ve been quite vocal in the community about my pain with Cabal, for example. And all my love to the people who work on Cabal, this is not an attack, but from the point of view of the person who just wanted to use Haskell as a host for an EDSL, it was easier a few years ago. And the newer versions – in the end, you’re forced to add the – either create a Cabal package or add the dependency somehow listed explicitly. And that is one extra layer for the user who just wants to use Copilot but does not want to write Haskell. 

*WS (0:25:27)*: Yeah. So, I mean, but this isn’t just true of Copilot, right? It’s more widely the case that if you’re – I mean, I see it myself. If I don’t write Haskell code every day, and every now and then I start a project and I want to import some package, which I know is out there, and then I think, “Oh, I have to set up my Cabal file again.” And then I think, “Oh, where do I change what flag?” And then, I mean, if you don’t do this every day, you forget how much implicit technical baggage you’re carrying around sometimes.

*IP (0:26:03)*:. It’s also changed a lot. For a tool that we all use and it’s core to the community, it is changed a few times. We have the V1 without the V, then the V1 with the V. Then the V2, then the new build. And I don’t know the state that it’s at today.

*AL (0:26:21)*: I mean, you’re right. And I mean, certainly, the change of the command names is very confusing, in particular, if you’re not looking at this day by day or even following the whole development. But I mean, basically, yeah, I mean the whole Version 1 interface has been transferred into the Version 2 interface, and that has been done by doing the prefixing of the commands with V1, V2 or old and new. But I mean, it’s done now, right? I mean, now basically, everything is like, the V2 version is the default, and that is the only one that exists, even though I think you have sometimes said that you like the old style better. But I think the main reason this change was made is that we have seen that the new style is in general more declarative, right? And you can argue about pragmatics or the user interface aspect a lot. I think Cabal has never been particularly nice when it comes to its user interface and self-explanatory perhaps. And certainly, the change of the mental model that goes along between these different versions is something that is perhaps difficult to understand. But I do think that the state that we are at with Cabal is actually quite good, and some things could be made simpler.

*IP (0:27:45)*: I think what may be going on is that the kind of user that develops Cabal and is close to the development and follows it every day is quite different from our target user, which is the person that does not know Haskell, does not want to get into Haskell. They don’t want to invest the time. And we did have a case, for example, where a project was delayed for like two weeks because the person who needed to install the tool couldn’t figure it out. And I didn’t have access to their terminal. So, I have to tell them, “Okay, try this.” And then a little bit later, they send me the result. It’s like, “Try this and send the result.” And my position, I guess, is that we need to focus as a community a bit more in those cases or on those cases, on those kinds of users, because those are the kinds of users that are going to pay Haskellers to continue working in Haskell. But I guess that’s just my bias. 

*AL (0:28:41)*: No, I completely agree with you that, as I said, I mean, it would be nice if always the simple use cases are actually simple. And so, for example, what you’re saying about always having to effectively these days in order to do something useful in Cabal or something useful with Cabal, you have to make everything a project. And in order to make something a project, you have to write a Cabal file. And in order to write a Cabal file, you either have to know what goes into the Cabal file or you have to use Cabal in it, and then you have to work through all these things. And it would be nice, I think, perhaps if there was some sort of more minimal format where if all you want is to declare dependencies that you can basically just put these dependencies somewhere without all the rest, without giving a name to the package or whatnot, or selecting a license or all the things that are currently also effectively required. So yeah, perhaps there are some shortcuts that could be implemented. 

But what I think is good about the new model is that rather than previously, you said like, “I want this package,” and then you make a stateful action onto your system, let’s say, “Give me this package,” and this stateful action often led to problems because then what if you already have a conflicting version of something on your system? What do you do then? Now you basically just say, “For this current project, this is what I want.” And you write all that into a file, and then you say, “Give me an environment that gives me exactly these things that I need for my current project.” And it never interferes with other packages or what else is on your system. So, in that sense, it’s declarative and not stateful. But I hear you. I certainly see that. 

*WS (0:30:34)*: I don’t think the objections are to like the underlying model of whether it’s stateful or pure. But the question is more of like, suppose you’re really not interested in learning Haskell or coming to grips with all the tooling surrounding it, what can we do to make that easier, I guess?

*AL (0:30:53)*: Yeah. No, and I agree. I mean, for example, everybody seems to say that Cargo is very easy to use, right? And Cargo is effectively based on the same declarative model. It just has a better user interface, I guess.

*WS (0:31:08)*: Yeah. So, aside from Cabal, what are the other things that you run into with getting people to use Haskell?

*IP (0:31:16)*: Versions of the compiler, like the compiler changes from our perspective far too often. And there’s new releases that introduce breaking changes far too often. So, for us, when that happens, we have to go through a retest of everything. But also, every user has to reinstall the tool on their side. Things could break. Very often they have to recompile, like compiled Ogma or all the other tools they have on their machine. And depending on the operating system, we may not have an easy time freezing versions. With Cabal, for example, I think it used to be the case, I don’t know if it’s still the case that Homebrew just updates the formula but doesn’t provide older versions, which means that even though for GHC, you do have those for Mac, you have older versions for Mac. You don’t have all the versions of Cabal. So, we can’t tell people, “Just stick with 3.6 or whatever. Stay there. Don’t update.” And yeah, that also introduces a bit of pain. 

I was very fond of HVR’s effort to provide a PPA, for example. I still use it in my daily job. I still stick to 8.6 if I can, because there’s a PPA that just makes it easy to install. And something like that would be – for me, was life changing, not having to rely on additional tools to install what already should be provided by my package manager. 

*AL (0:32:54)*: But PPAs are also only working for certain platforms, right? I mean, you were saying you have people working on different operating systems and so on.

*IP (0:33:05)*: Yeah. So, I mean, PPAs are only going to work for Ubuntu and Debian, but that covers a lot of users, I think. I don’t know what the percentage is, but my guess is that it’s going to be a sizable portion of the Haskell community.

*AL (0:33:22)*: And GHCup does not fix your problems?

*IP (0:33:26)*: I try to stay away from GHCup just because, from my perspective, I went through a few iterations of these tools. I’ve been doing Haskell like you guys for decades. And I saw many tools come and go and come and go at some point that you were like, okay, you guys agree. And then I’ll come back. But also, I really like the idea that if you install GHC from the package manager, then it’s installed for the whole machine, not just for your user. You don’t have to manage that locally as a user. The operating system is going to provide the upgrades, and that’s it. And also the operating – APT, for example, keeps track of every file. So, I don’t have to think about where the files went. APT is doing that for me. And I think that’s very clean from a sysadmin perspective. And having the tools in my home is like, yeah.

*AL (0:34:22)*: Yeah. Just, I mean, I need to ask one more of these questions. I mean, what about Nix?

*IP (0:34:27)*: Okay. So, it’s promising. It’s promising. I cannot force my users to use Nix.

*AL (0:34:35)*: Because they then have to not just understand Copilot and Haskell and Cabal, but also Nix?

*IP (0:34:42)*: Yes. That’s a huge ask.

*AL (0:34:43)*: Yeah. Okay. 

*IP (0:34:45)*: So, I can’t force my users to use Nix. I looked into Nix almost nine years ago, when I was in my PhD. And Ambrus Kaposi, he was my officemate, and he was very much into Nix. He showed it to me. And at the time, I thought, that sounds like 90% of the time is going to be great. And then 10% of the time, I’m going to waste weeks figuring out the formulas and whatnot. So, I’m not going to do that. And they had Nix meetings here in the Bay Area. I live in California, I live in San Jose, which is in the Mountain View area. Cupertino is right here, and so on. And they have meetings, Nix meetings every now and then. And I’ve attended a couple just to see where things are nine years later. It looks promising, but I still haven’t switched.

*AL (0:35:39)*: I mean, I see your point there as well. I think it’s – but despite the fact that it introduces yet another layer of complexity, and it may actually, for your use case, be good, because it allows you to keep things stable, right? But yeah, I mean, I also always struggle. And I know that other people are very strongly advocating for it and say, “Yeah, well, just let everybody do things through Nix.” But I agree. I think often it’s asking too much because then people have to do something with another ecosystem that they totally don’t understand, and it’s a vast and complex thing. And sometimes things go wrong there as well, and then you have to debug those situations. 

*IP (0:36:26)*: And I think from the point of view of people who are trying to get tools like Copilot and Ogma to be adopted by others, you only have one chance for people to try your tool. If it’s complicated, they’re not going to do it. But we’re very lucky on the Copilot front because, thanks to Scott Talbert from the Debian Haskell Group, he helped us put Copilot in Debian and Ubuntu. And that means we can tell people, “Just get it with APT. This is the package name, install it, and you got it. And you can run it from anywhere. This is installed in the global database, so you don’t need a sandbox or an environment or anything strange. You can just access it immediately.” And that’s a big difference for us. That makes a big difference for users too, that they don’t have to think about this.

*WS (0:37:21)*: But they still need to learn how to write Haskell code, right? It’s just that the setting up of, and they don’t need to –

*IP (0:37:28)*: But that’s a big deal. That’s a big deal already. They still need to learn to write Haskell. You’re a hundred percent right. But again, Copilot is embedded in Haskell, but I tried to tell people, “You don’t have to learn Haskell; you just have to learn Copilot.” Copilot is a very small language at its core. It’s extensible because it is embedded in Haskell, and you have all the facilities in the language. But if you want to stick to the core that is very small, you can do that. You’re just not going to be able to write as much, but that’s okay. For your use case, it may be fine. 

*AL (0:38:00)*: Fair enough. 

*IP (0:38:01)*: And it gets people running fairly quickly. My hope now is get Ogma also into Debian and Ubuntu, and that way people don’t have to learn the language anymore if you don’t want. But it’s a licensing issue. NASA uses the NOSA license, like NASA open-source license, which is not a free – as in freedom license. And that means you can’t just go into the normal, like the packages, or what are they called? Repositories. You can’t go into the normal repositories, so we’ll need to change the license. 

*AL (0:38:36)*: I see. But I mean, this is interesting also because you say, okay, Copilot is embedded into Haskell, and that comes with a lot of problems, but Ogma basically fixes that to some extent, right? Because it maps from other languages to Copilot. So, in principle, I don’t know, whether you already have something which you would personally consider sort of the ideal source language for Ogma, but you could also use Ogma to create a standalone DSL version of Copilot itself, right? I mean, basically, by removing the full Haskell power and basically have an idealized limited version of Copilot that is a standalone DSL.

*IP (0:39:23)*: We could do that with Ogma. We haven’t really thought about doing that with Ogma. We’ve thought about providing a Copilot proper compiler. Meaning that instead of calling GHC, you just call CopilotC. And then that hides all the complexity of the language. That hides the Prelude by default or the symbols that are redefined by our Prelude, and it already does the imports for you and so on. There’s still a bit of, going back to what are the pain points and so on, error messages of course. The error messages for the user are going to be very cryptic. And there I have homework to do because I’m sure that there are techniques that one could use to translate those error messages into something that makes more sense for the user. And I haven’t looked into those deeply. 

*AL (0:40:10 Yeah. But it is often a problem with DSL error messages if you want to hide them. I mean, I guess if you wanted to do some post-processing, you’re now in a slightly better situation because GHC is moving towards making all these error messages more structured internally. If you want to do some sort of post-processing, you can more easily done by simply string matching, identify, “Oh, it’s this error.” Also, all the errors are getting codes now, so you can identify it’s exactly this kind of error. So, if it’s this, then probably the better error to present to the end user is this one. But yeah, it’s not easy, I guess.* 

*IP (0:40:52)*: But on a more positive note, I can tell you, for example, one of the benefits of using Haskell is that all of Copilot, including the C backend, the libraries, the core representation of the language, the high-level representation of the language, the Copilot theorem library, which is a connection to SMT solvers and to model checkers—all of that is, I think by my last count, without comments and without empty lines, it was 8,200 lines of code, which is nothing when you think about it. It’s just nothing. It’s something you can do in a month if you knew what you were doing. And that’s a huge asset for – I don’t want to speak on behalf of anybody, but my position is that that’s probably a huge, like a big win for NASA. Because they know, like, it doesn’t take a lot to maintain. If you do something like this in any other language, you’re going to be into the tens and tens of thousands for sure. Many more. 

If you look at the repo, for example, we put a lot of energy into reducing, into simplifying the implementation. Most of what I’m doing is cleaning up because the way that these projects work, and this happens also for generally open source, is that people really like to focus on adding new stuff because that’s what’s exciting. And in our work, we have interns coming in, we have people coming in, projects coming in, and they want one new feature, but that adds complexity, technical debt, and so on. There’s never money to pay for cleaning. There’s only money to pay for new features. And that’s what’s fun to do. And a lot of what I do is cleaning up. But compared to other projects that we have, Copilot is very small.

*WS (0:42:35)*: So, you mentioned the curve, you would almost say, of how Haskell’s been adopted within NASA, which is starting with Copilot, and now there’s this Ogma, which is making it even easier to use. What’s the next thing, that suppose you could hire five people to work for you, what would they be doing?

*IP (0:42:59)*: Oh, that’s a good question. What would they be doing? One thing that I really want to do is – so, there are two fronts that I would like to work on. One of them is more connected to Agda or Coq or something like this. And the other is still connected to Haskell. So, on the Haskell side, what we have observed is that when people write these flight applications and robotics applications, the code gets very complex really, really quickly. And giving people the declarative language to write those would go a long way. So, at the end of the day, these are just transformers from input data into output data. It’s almost like a stream kind of thing with some connection to a software bus or to some publish-described mechanism. But you can see the thing as a stream transformer. So, giving people a language to do those that is more powerful than Copilot, that is capable of running the flight applications that we have, I think that would be very, very useful because then you could analyze it, you could formally verify it and all kinds of things. You could ensure also that the connections are correct, and so on.

*WS (0:44:09)*: But isn’t this what Lustre and Esterel and systems like this already do or do –

*IP (0:44:16)*: In part, yes. But I think we could potentially do a better job at providing a language that is easier for people to work with.

*WS (0:44:25)*: Okay.

*IP (0:44:27)*: That’s my position maybe, as I’m overstating my abilities, but I think we can give people a language that is more declarative that focuses just on the point of the transformation. I don’t know where Lustre is like today, for example. And the other work that I’m doing is on formalizing properties of temporal frameworks, be it temporal logic or streaming programs, and so on. And what we see is that we are working with many temporal logics and many variants from metric temporal logic, past time, future time, and all kinds of things. And when I look at the literature, many of the proofs that people have come up with, these are paper proofs. And also, I don’t trust them very much. Not that I don’t trust the people, it’s just, I know how paper things work, and it’s easy to make a mistake, especially for temporal languages, where if there’s a subtle variation on how you define your temporal logic, maybe what you say about your logic doesn’t apply to a different logic that everybody’s calling by the same name. So, I would like to formalize these things in a language like Agda. And that’s what I’ve been doing recently.

*WS (0:45:46)*: And why do you think people haven’t done this before? Is it because you’re reasoning about streams and this is more complicated, just not finite data, which is a lot of proof systems are really good at inductive small things as opposed to reasoning about stuff that goes on forever?

*IP (0:46:03)*: I don’t know why they haven’t done it. I can only guess. My guess is, it’s not fun to do. It’s not new. It’s just picking up somebody else’s work and then spending your time formalizing this to get a result that presumably they already got if they did their job right. It’s like, “Great. What do I do with that? Do I publish? No. I get nothing out of that.” 

*AL (0:46:27)*: It’s a lot of what people are doing these days with formalizing just mathematics, right? I mean –

*IP (0:46:36)*: But are they formalizing known theorems or are they formalizing new theorems?

*AL (0:46:40)*: No, I think mostly known theorems. And I think we – I mean, there is now a point being reached where, I think, there is a sufficiently large fraction of people in mathematics and computer science and logics that are seeing this as worthwhile so that you can get publications with just formalizing known theorems up to an extent. But certainly, there is still sort of then the idea, yeah, perhaps you have to overcome a new kind of obstacle or figure out the right way to do something in such a way that it is worth talking about. Not just like, “Oh yeah, I did the 101st year in exactly the same style as the other 100.” So, yeah. But that’s also what I was thinking. I mean, I don’t exactly know how it’s looking like, but I mean, you could imagine that if the kind of proofs you have to do in these temporal logics, if they are similar enough to each other, that it is perhaps such a limited setting that you could write a dedicated proof assistant just for that kind of stuff, rather than go to a dependently-typed language altogether. But I don’t know enough about this. So, certainly, I think formalizing an Agda is a good first step, in any case. And is that coming along nicely or –

*IP (0:48:08)*: I’m still working through it. But the way that I’m doing these things, and I’m doing this more also with Copilot as I’m reaching out to the community and being more open about what I’m doing because it creates an opportunity first for people to give me advice. I don’t know about this stuff. I’m just beginning to learn about Agda, but also, it creates an opportunity for collaboration. This happened recently also with Copilot, for example, where for this year in Copilot we’re looking into generating certified code and so on. We’re looking into FPA backend, which we already have an FPA backend for the language. And then I have a couple of projects with interns. But somebody mentioned, “Hey, it would be nice to have a Rust backend. And well, we don’t have the bandwidth, we don’t have the money for this, but it’s a great opportunity for people who want to play with Copilot to do something like that as open source.” So, I recently posted on Reddit, “Hey, would anybody want to work on this? It would be really cool to do.” And people started coming forward. I got a lot of emails from people saying, “Hey, yeah, I want to be part of this.”

So, that’s the approach that I’m taking for all of these, like both the Agda thing, the Copilot stuff that cannot be core to my job, is let’s reach out to the community and do it together. Because I think also from the point of view, putting myself in the shoes of a person who doesn’t work at NASA, being able to do something with NASA in collaboration with, or just participating in a project that maybe eventually one day we can use, it would be great. So, it’s a win-win for both. And it doesn’t have to be finished, it doesn’t have to be polished. It can be just a proof of concept, saying, “Yeah, this kind of works.”

*AL (0:49:42)*: Yeah. I’m not sure whether you can talk about this at all, but for me, I mean, you’ve been saying a couple of times, “Oh, but there is no money for this,” or something. I mean, how does it work at NASA? I mean, who decides whether there is money for something or not?

*IP (0:49:57)*: I can’t really get into that. Unfortunately not.

*AL (0:50:01)*: Okay. That’s fair enough.

*IP (0:50:03)*: I don’t know enough, and I could easily shoot myself in the foot here.

*AL (0:50:08)*: But I guess it’s safe to say it’s not you who decides.

*IP (0:50:12)*: I don’t decide what the money is or what it’s put into. But yeah, if I talk too much, you might have me here in two more weeks looking for a new job.*

*AL (0:50:26)*: Look, another question related to this Agda development that I still have is, when you were deciding to do this in Agda, was choosing Agda as a language a conscious choice or just, “Oh yeah, I’ve heard about it,” or I mean, as opposed to, say, Idris, Coq, Lean, whatnot?

*IP (0:50:46)*: I explored a little bit. So, I really like the equational reasoning style that Agda allows me to use. I think the one that comes closest to Agda in that respect, maybe Coq. But this is a land where I’m not an expert by far, so please correct me if I’m wrong. I checked Lean, and it felt like it was overly complicated for my ability maybe. And also, the error messages were a little bit more complicated. I tried Isabelle, and I forgot exactly what happened with Isabelle, but I just couldn’t do it the way that I wanted, and it just switched. And I didn’t try Idris. And I think the reason is, a few years back, Idris supported the equational reasoning better, and I think this feature either went away or is not as well documented. I’m not sure. I could be very wrong about this. If anybody wants to reach out to me and tell me this is how you do it, please let me know.

*AL (0:51:44)*: I’m not really up to speed with Idris myself, I’m afraid. 

*IP (0:51:49)*: Yeah, I tried to do equational reasoning with Idris, and a few years ago it was possible, but I think over time, this was not a popular feature. That was my take. So, in the end, I had to choose between Agda and Coq. And I thought, “Well, there’s a book for Agda, I’m going to start with that and see.”

*WS (0:52:06)*: And the Agda syntax and look and feel is maybe closer to Haskell of all of these, I guess.

*IP (0:52:13)*: Yeah. That helps. And I thought the Unicode thing was going to be more difficult and annoying to use, but it turns out that it’s all right. You can do the escape thing, and it is comfortable.

*WS (0:52:26)*: Yeah. Once you get used to it, it kind of works. Yeah. 

*IP (0:52:31)*: Yeah. Yeah. And I’m having fun. Something very strange that happened in my career was like, I came from a formal methods background and did a – my engineering degree was focused on formal methods and declarative programming, and then I did a master’s in Computational Logic and then the PhD. And then I switched more towards testing and runtime verification. And it’s like, “No, I want to do the formals. I want to do the formal proofs.” So, going back to these things and formally proven, it’s fun. It’s a lot of fun.

*WS (0:53:02)*: So, one really nice thing about working in Agada, like you said, is that you can actually do all these proofs statically, and they’re checked for you by the compiler. 

*IP (0:53:09)*: Yes. 

*WS (0:53:09)*: And on the other end, like you mentioned, you have runtime verification, which is super dynamic, and you have tools like QuickCheck, which is also testing the actual code. So, where do you see these two worlds meeting somehow, or what could one – what can, say, Haskellers learn from runtime verification people?

*IP (0:53:33)*: So where do I see these tools meeting? I don’t know. Perhaps the way that I can answer that in my domain is, where do I see formal – like a tool like Agda being used?

*WS (0:53:45)*: Yeah, yeah, yeah.

*IP (0:53:47)*: We have used PVS. I don’t know if you’re familiar with the language. So, there’s a branch of Langley that uses PVS a lot. And part of the challenge of using a language like Agda, which I very much would like people to use more, including at NASA, is that the complexity of the problems that we are trying to formalize is huge compared to the kinds of problems that you normally do in a textbook or in a paper, and so on. And I think people who work in formal methods need to do the exercise of tackling really, really hard problems, like really big problems, to see how their approaches scale. 

And I was recently having a chat with – last week, I was having a chat with someone who works on the gateway program who is to build a space station around the moon. And that’s a person with a formal methods background. And I asked her like, “Doesn’t it bug you that sometimes you work with people who don’t have a formal methods background and they could do things in a way that is more –” what’s the word? Principled, say. And she said, “No, it doesn’t bug me because I know that the complexity of these problems far surpasses what we have done in the formal methods community. And it would be really hard for these people, for these techniques to be adopted.” So, we still have homework to do.

Many of the problems that we address, for example, or we try to formalize and we use PVS for—and I say we, but it’s not me—is the problems that have to do with real numbers. Being able to work with real numbers and floating point numbers and formalized properties between those well would go a long way towards the adoption of these tools in this environment.

*WS (0:55:41)*: Right. Okay. Awesome. So, thanks very much for joining us, Ivan, and thanks for your time. 

*IP (0:55:49)*: Thank you.

*Narrator (0:55:51)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
