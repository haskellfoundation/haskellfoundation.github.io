*Andres Loh (0:00:15)*: This is the Haskell interlude. I’m Andres Loh, and my co-host is Sam Frohlich. 

*Sam Frohlich (0:00:20)*: Hello. 

*AL (0:00:21)*: Our guest today is Pepe Iborra. We’re going to talk about his journey from academia via banking to now Meta. We focus on his involvement in the evolution of the Haskell ecosystem, in particular, the ongoing journey to improve the developer experience via work on debuggers, build systems, and IDEs.

So our guest today is Pepe. Welcome. 

*Pepe Iborra (0:00:43)*: Thank you. Happy to be here.

*AL (0:00:44)*: Our first question usually is, how did you first get into contact with Haskell? 

*PI (0:00:50)*: So, as a student, I was wrapping up my Telecommunications degree, and I started looking for like a master’s project. So, this was in Spain, in Valencia. And I guess I ended up doing Telecommunications degree by mistake. I should always have done Computer Science, but for a number of reasons, I ended up there.

*SF (0:01:09)*: How does it differ from Computer Science?

*PI (0:01:12)*: Telecommunications is a made-up engineering degree in Spain that involves lots of physics, microwaves, electronics, transistors, some maths, some low-level programming like assembly, and also VHDL and Verilog. I guess, I don’t know if it exists outside of Spain. But anyways, I ended up studying this degree and I wanted to get more of the Computer Science side, so I went and picked a master’s project on the Computer Science Faculty. And I also got a little lab assistant job, which involved working with a research group, helping implement some tooling for the research projects that they were working on. So, this was a research group that was doing object-oriented and formal methods. Basically, I was just writing Eclipse plugins in Java, so nothing too interesting, nothing too FP. But the PhD student that was driving the project, he was using functional programming. So, he was using F#, and he was using Maude. Maude is a logical framework. It’s not a programming language, but it’s FP-ish. So, I got interested. I go home, and then I learn more about these things, like what is F#, what is Maude. Why are we not allowed to test these things and to learn about it? Because there was a clear separation between the PhD students and the lab assistants, like the students that we’re implementing.

So, in my spare time, I found out about Haskell. That piqued my curiosity. There were so many, I don’t know, idiosyncrasies about it, like laziness and all these higher-order types and cool idioms. So, I eventually subscribed to the mailing list and the IRC channel, started playing with it, joined the conversation. Then time went on, I finished my master’s project. I was looking at the job market, like should I go and get a job, should I do a PhD? And then out of nowhere, a full professor from the Computer Science Faculty sent me an email and said, “Hey, I’m looking for a PhD student, and I’ve seen that you’re using Haskell and you’re posting. So Haskell made a list that you should be you should be working with us, right?” So, I just – he showed me the Haskell tools that they were working on. They were doing term rewriting, and they had some termination provers in Haskell that they were using to enter into competitions and so on. So, eventually, this research group offered me a PhD scholarship, working on term rewriting, and I accepted it. I had already made my mind that I wanted to do a PhD anyway. And, I mean, the topic of the PhD, term rewriting, it didn’t involve functional programming directly. There was some Haskell programming on the side, as I said, but that wasn’t the main topic.

*AL (0:04:02)*: Where was this? 

*PI (0:04:03)*: This was in Valencia. 

*AL (0:04:05)*: And I’m sorry for interrupting, but I mean, one thing that came a little bit quick to me was this. Like you said, the first language that you were exposed to, or the first languages were F# and Maude. But why then Haskell?

*PI (0:04:19)*: I think the first languages I was exposed to were Basic, then C, then Java, Pascal. Eventually, I arrived at F#.

*AL (0:04:29)*: Oh, sorry. I meant functional languages. 

*PI (0:04:31)*: Oh, yeah. Okay. Okay. 

*AL (0:04:32)*: The first functional languages.

*PI (0:04:33)*: How did I go from F# and Maude to Haskell? I don’t know. It was just like curiosity. I remember seeing a paper where they said Maude versus Haskell. That was a very weird comparison, right? Because Maude isn’t a programming language. But I don’t know. I just got run into it.

*AL (0:04:49)*: Okay. 

*PI (0:04:50)*: And like I said, it was the idiosyncrasies of Haskell, but piques my curiosity more than others, right?

*AL (0:04:56)*: Right. Okay.

*PI (0:04:56)*: During the PhD, I found that there wasn’t that much Haskell-related. There wasn’t that much Haskell action. And I wanted to do more. And I was looking for like, what can I do? How can I convince my advisor that? Me to do more Haskell? So, I mean, I wasn’t successful at convincing my advisor, but the Google Summer of Code came out. The Haskell Google Summer of Code. And there was a bunch of proposals there. And one of them was contributing a debugger for GHCi. So, David Himmelstrup had put together a small demo of how, using unstated bytecodes from bytecode could be used to interrupt the world, stop the GC completely, and then inspect the heap. So, that was like the primitive bread point. So, he and Simon Marlow made a Summer of Code proposal. I thought this is great. As a Haskell newbie, I really wanted to have an easy-to-use, always-available debugger. I had tried to use HAT and Freya and similar algorithmic debuggers at the time, but they were very, very hard to set up. They would only support a subset of the language. There was no package manager at the time, so there was no intonation with anything whatsoever. So, I was never successful at using them. 

*AL (0:06:21)*: That’s exactly the, I mean, experience I had with the early debuggers as well. Like when I was a PhD student or when I learned Haskell, there were all these interesting Haskell debugging projects, but they were always sort of academic quality. So, like, “Oh, let’s pick a subset of the language,” or “Let’s assume this and this and this.” And it was never realistic to use any of those on a real-life Haskell program, unfortunately.

*PI (0:06:52)*: Yep. So, I was very motivated to get a debugger, a utility debugger going. I applied for the proposal, and shockingly, I got it. I never expected it. But I mean, looking back, the community back then was much smaller than it is today. So, that’s how I got into working with Simon Marlow and David Himmelstrup on this project. So, the goal was to take lemmihs, so David Himmelstrup’s primitive, and build instrumentation of decoding GHCi. There will be a break command. It will allow to insert breakpoints about any expression, basically. And then what will happen behind the covers is that the generated core, or desugar core, desugar would insert these primitive breakpoint codes around the expressions. But then the question was how to actually inspect the heap once you interrupt the execution. So, this is how the print command was born. So, we need something that can print values from the heap without forcing them. And, oh my god, I have to say Simon Marlow was incredibly patient with me because of my rudimentary understanding of how GHC compiled Haskell and what’s a thunk and what’s the layout of the heap and how will the file works. Basically, I was completely unprepared to work on this. And there were very long email threads with Simon where he basically explained, like a five years old, to me how these things work.

*AL (0:08:27)*: Are these calls recorded?

*PI (0:08:30)*: There were no calls. It was all by email. 

*AL (0:08:32)*: Oh, okay. Sorry. The emails are – you should publish them as a book so that other people can understand. 

08:41 

*PI (0:08:40)*: So then the next hurdle was, okay, we can print these things, but we cannot type them because types are erased. So, how are people going to do, or how are users going to play with this heap of values and, I don’t know, test properties about them and do other things? So we have to figure out a way to reconstruct the types. GHCi has the source code. Obviously, that’s not enough, because when you are looking at a thunk, you don’t know where it comes from. You don’t know what expression has produced it. So then we started doing runtime type reconstruction. So, the print command was augmented to look at the constructor or the closure. So, these things, they have an IDE, they can be traced back to the datatype. So, from the heap frames, you can go back to the Haskell datatype that produced this constructor. But you don’t know how is the constructor instantiated, like if it has type variables as well, type variables are instantiated, and so on. 

So, the print command had to do some reconstruction of unifying different posture instructors, and so on. There was a huge one with new types because new type constructors do not exist in the heap at all. So then the print command had to do guessing like, what are the new types that exist in this universe and which ones could apply here? And it was a big mess. We ended up publishing a paper at the Haskell Workshop about this. I could never explain how new types are sold. So, it all worked most of the time. 

There were a lot of times we’ve tried to translate these types for the user because GHC has lots of different kinds of type parts. I don’t remember the kinds of type part, the names anymore, but we had to get Simon Peyton Jones to explain this to us and to suggest some translations because some of these type parts could not be shown to the user, could not be shown to GHCi. So, basically GHCi would not understand these kinds of type parts.

*SF (0:10:42)*: How long did that take you in the end? Was that a summer and an autumn? Sounds like a lot of work.

*PI (0:10:50)*: Well, no, it was just the summer. 

*SF (0:10:52)*: Oh, wow. 

*PI (0:10:52)*: I guess, I was working mostly full-time on it. It was very intense.

*SF (0:10:55)*: That’s impressive.

*PI (0:10:57)*: The other side of this is that I get much more involved in the community. So, there was a Haskell hackathon shortly after this Summer of Code in Oxford. I think it was the first Haskell hackathon ever. So, there was people like Don Stewart and Duncan Coutts, and others working on getting the first version of Hackage going. And then a bunch of us doing other Summer of Code-related projects and things like that. So, it was really cool that not only I got to work with Simon Marlow and David on the GHCi debugger, but I also got to meet lots of people who join hackathons and get much more involved in the community.

*SF (0:11:34)*: So, did this convince your supervisor that Haskell was worth it in the end?

*PI (0:11:40)*: It’s not that they thought that it wasn’t worth it. It’s just that term rewriting didn’t need Haskell. There was no motivation to spend any more time working on Haskell stuff during the PhD. So, basically, what happened after this is I went back to my PhD full-time. And I have focused on it for two more years to wrap it up and even do much more Haskell for a period of time.

*AL (0:12:02)*: But you then decided, like after your PhD, that you want to not continue in academia, but look specifically for a Haskell job, or how did that happen?

*PI (0:12:14)*: Exactly. That’s what happened. So, after my PhD, I had postdoc offers. I went and looked at what they would involve, and I realized I wasn’t so interested in doing pure research, or at least pure research on term rewriting. I was more motivated by the implementation side, and I wanted to use Haskell in the industry. I remember some professors laughing at me when I said I wanted to get a full-time Haskell job in industry because they said, “No, that doesn’t exist. Good luck with that.” I mean, I wasn’t entirely successful. I didn’t get a Haskell job. I joined – so my first year out of the PhD was in Credit Suisse. And Credit Suisse was employing Haskellers, and they were using Haskellers. But that ended before I joined something.

*AL (0:13:02)*: That was the time when Lennart was at Credit Suisse, right? I mean, that was when they started using Haskell, I think. But he left before you joined, or –

*PI (0:13:11)*: That’s right. Yeah, Lennart had already left. So, Lennart, Neil Mitchell, Ganesh were working for Credit Suisse. They built a Haskell compiler that would output Excel spreadsheets. And that project was very successful, but for various reasons, it was abandoned. I guess it was really too successful. It was producing spreadsheets that were monstrous and impossible to understand on debug because of the compositionality. So, all of a sudden, all these traders and plants could compose spreadsheets.

*AL (0:13:45)*: This was Paradise. right?

*PI (0:13:48)*: It was called Paradise. Yes.

*AL (0:13:49)*: Yeah. Okay.

*PI (0:13:50)*: And it removed the limits of working with Excel because you were no longer using Excel to create Excel spreadsheets. You were using a library of combinators that allow reuse and compositionality. So, there will be these massive spreadsheets created completely in Excel. So, the team or the technology group at the bank decided to refine the approach by instead of using functional programming to create spreadsheets, using functional programming to create .NET applications that work like spreadsheets that share trades with the spreadsheets, because I guess the traders and the main users of these applications in the bank were traders who were used to the Excel parallel programming and the spreadsheet programming. So, that’s what we’re doing. We’re doing functional programming. We’re using F# to write spreadsheet-like applications. It was very interesting. It was very cool, but it was not possible.

*SF (0:14:49)*: You missed it then.

*PI (0:14:51)*: No, I was very happy. I was very content. I mean, it was still functional programming. It was a very good team. We were doing cool things. And this F# had a thing that Haskell didn’t. F# was very successful with non-F # people or with non-FP people because F# was very well integrated within the .NET framework. So, it was very easy to translate your experience with C sharp to F#. The core library is the same. Basically, solutions to your problems are similar.

*AL (0:15:25)*: That’s interesting, but I mean, not entirely obvious to me, because if you’re already in the .NET ecosystem and you have C# and you’re happy with it, then there’s still not immediately a reason to use F#. So, is it really just the curiosity that, okay, there is this other language, so let’s look at it, and then it’s very easy to use? Or was there some other aspect of F# that made it particularly successful with non-functional programmers?

*PI (0:15:49)*: Oh, well, that made it successful with non-functional programmers. The IDE, the Visual Studio 2010 had full support for F#. There was a debugger, there were profilers. You could reuse all these tools from the .NET world. What made it successful versus C#? I guess, I mean, I’m not the best person to answer that question because I was not involved in the adoption of F# at Credit Suisse. So, you can compare the two languages and say, well, F# is expression-oriented, which is a big deal for me. F# is much more concise. But yeah, it’s not that much different from C# at the end of the day. I think that you do have a point.

*AL (0:16:30)*: Yeah. Okay. That certainly helps. And I certainly agree that, like just having a working toolchain and an editing environment, an IDE, and a debugger. And so, that is a very strong point.

*PI (0:16:43)*: So, this is something that has come with me over all these years, witnessing the ease of adoption of F# in the quantitative tools or quantitative strategies team in Credit Suisse. Absolutely everyone was using F#. There were no complaints about it.

*AL (0:16:59)*: What does absolutely everyone mean in numbers?

*PI (0:17:02)*: Well, I guess there were around, I don’t know, 50 to 100 members of that team.

*AL (0:17:08)*: Okay.

*PI (0:17:09)*: And the alternative to F# was C++ because there was a lot of C++ as well. So, all the low-level algos were implemented in C++. And then there was this COM, Microsoft COM, later to interface between F# and C++ and also with Excel. So, all this FFI was done through COM, which again was way easier to do from F# than from Haskell. 

*SF (0:17:31)*: So, did F#’s ecosystem inspire the work that you’ve done on the Haskell ecosystem?

*PI (0:17:36)*: Yeah, I think it has guided my choices or my motivations. I think that’s a big reason that I ended up working on HLS because I had seen the benefits of an IDE that is always available, that is easy to use, that doesn’t require any, I don’t know, special setup. After Credit Suisse, I managed to get a Haskell job finally, and I joined Barcal to work on a Haskell risk engine. This was a new team, a new project, a new codebase, and the team was led by Neil Mitchell. 

*SF (0:18:11)*: Could you tell us more about what the project was that you were working on?

*PI (0:18:16)*: Sure. So, Neil Mitchell had left Strats at Standard Chartered to join Barcal to set up a new team, working on a new risk engine. So, Barcal was working on a new quant library from scratch, completely new. I think it was called Omega. And they wanted to have a really new risk engine using this quant library. And they managed to convince Neil to go and do that and create it. So, Neil was assembling a new team of Haskellers to do this project in Haskell. And the main architectural item of this risk engine was that it had to process billions or tens of millions of trades in a huge parallel way, but in constant memory. Or that was what Neil wanted. So let’s write a streaming risk engine that will use one of these new Haskell build systems like Shake or Haskell streaming libraries like Conduit, or one of those to do this in a constant way. So, that was very cool. We were just saying we didn’t end up using any of the mainstream streaming libraries. We were using repa-flow. Ben Lippmeier have published a paper about this because it was the only streaming library that was designed with parallel streaming in mind, right from the quantum. And then we built an arrow layer on top of it because the streaming library itself was quite difficult to use. It was using polarities. So, you have to – the times involved, and they have the invariants involved, were quite hard to maintain when using the API directly. So, we built another instance for it that would restrict the kind of streaming, simple streaming networks that you could run with it, just at a time level.

*AL (0:20:07)*: So, for some reason, I didn’t catch the name of the streaming library you were –

*PI (0:20:12)*: Sorry, that’s repa-flow. So, Repa was this array framework that Ben Lippmeier created a few years ago. And then on the back of that, when he started looking at streaming and streaming libraries, he named his streaming library repa-flow.

*AL (0:20:29)*: Okay. I see. Okay. And then you built an arrow interface on top of that. And you said you had a team that was relatively junior. So, how did that go?

*PI (0:20:41)*: Yes. So, there was three of us that were experienced Haskellers, and then the rest of the team was junior. I guess it was important that the junior members of the team were able to be proactive. And so, we were looking for ways to make this. So, we wanted a fast, snappy build system so that they would get like instant feedback loop. We have invested in good profiling setup. I don’t remember if we were using Make or we were using like a custom Haskell script, but it was like prompt commands to do both time and space profiling to catch space leaks properly and quickly. We wanted to have a working idea as well. So, we settled on using Intero because the build system was using stack to build the application. Intero was great. It worked very well. The only downside is that it was only available for Emacs. I don’t remember if it was also available for Vi. I think not.

*AL (0:21:43)*: I think, I don’t know exactly either, but I do know that I think I was already a Vi user at that time, and I have never really looked at Intero, so that might be why.

*PI (0:21:56)*: Yes. So Intero was maintained by Chrisdone, and he was very opinionated about the things he wanted to support and didn’t. I don’t find it that surprising now that it didn’t support Vi. We also had Intero code formatter, so we had automatic code formatting, the building in this script build system. It was all very best practices, best engineering practices design. Neil came up with this tool to eliminate dependencies at that time. I don’t remember what it’s called. Weeder. It’s called Weeder. So, Neil came up with Weeder at this time to keep our codebase clean. We, of course, had HLint rules that could prevent the use of unsafePerformIO and other nasty things. He also came up with Hexml at the time to be able to do fast external parsing because that was the end of the data language that the quant library was using. 

*AL (0:22:56)*: Was that project successful?

*PI (0:22:59)*: No, unfortunately, it was killed before it could be put in production. So, the situation of Barcal was highly political. We have a sponsor. And the sponsor left or was pushed out a year after the project started. And then the person that replaced him to lead this quantum group wanted to do a mainstream language. I don’t remember if it was Python or Java, or they came from another bank, and whatever the other bank was using, they wanted to use here as well. So, when the project was canceled, Neil left, and basically the entire team disbanded and left instead of converting the risk engine to use whatever the language was. So, Neil went and joined Digital Asset. And then a few of us went and joined Strats in Standard Chartered, which was a shame because the project was going very well. You have been a huge success for Barcal and also for the Haskell community. But this is the way things go at big companies and banks sometimes, right?

*AL (0:24:09)*: Yeah. I don’t think it’s specific to banks, right? I mean, it’s unfortunate that sometimes projects are failing for reasons that are entirely non-technical, but perhaps Haskell is still in a particularly vulnerable position in the sense that it is exposed to this scenario that you also described that a new person comes in and says, “Just out of principle, I want to do it in a different language.” I’ve seen this happen in other companies as well, unfortunately. It’s always sad because, I mean, if it happens to an otherwise good project, it still can be potentially used as an argument against using Haskell, even if Haskell wasn’t actually to blame for anything. 

Okay. So, you switched to Standard Chartered, which, of course, I guess was obvious because it was another bank and also using Haskell. But I mean, between Credit Suisse and Barcal and Standard Chartered, did you ever make a conscious decision that the banking space is actually what you want to do, or was it just like jumping from one to the next out of sudden opportunity?

*PI (0:25:20)*: Well, at the time, the finance industry was one of the few places where functional programming was being actively used. There were many financial entities using FP. It wasn’t easy to find an FPO outside of finance. And also, once you are inside the finance employment loop, it’s very easy to get another employment, another offer. But at this time, blockchain was starting to appear, I think HKIO. So, I got headhunters calling me about a new blockchain company that was being set up, and they wanted to use Haskell, and this was HKIO. I was intrigued, but I heard from some people that I don’t want to mention that HKIO wasn’t going to be successful, that they were very, I don’t know, very messy, that it was – that it didn’t look good, basically. So, I never actually returned the calls on this recruiter and instead decided to go with Standard Chartered with the Strats because, on the other hand, I heard very, very good things about it. That it was a great place to work, that the team was fantastic, that they were using Haskell in a large-scale way. And I’m glad that I did because it was a great experience to be part of Strats.

*AL (0:26:48)*: So, for what it’s worth, I think that the people, whoever told you that IOHK would not be successful, I guess, have been proven wrong. So –

*PI (0:26:56)*: Yes, completely.

Andrees: *(0:26:58)*: I think they are still quite successful, and that’s good to see. What did you end up doing at Standard Chartered?

*PI (0:27:05)*: So, I found myself very quickly leaving the one thing at Standard Chartered that was using GHC Haskell for developing trading applications. As most people know, Standard Chartered Strats, so Strats is a team in Standard Chartered. They famously have their own Haskell-like language called Mu. They have their own compiler. Mu is a strict variant of Haskell, which runs in a C++ VM, basically. And they do all sorts of cool, interesting things with it. But there was a team that was not using Mu, but using plain Haskell for developing trading applications. In particular, it was a pricing service that had to offer real-time quotes. And for latency reasons, I guess, they have decided to use GHC Haskell instead of Mu. So, I inherited this team and this project from Roman Leshchinsky. He had left to join Facebook before I joined. And I found myself leading the team, which means managing the team. So, I made a conscious decision of trying to focus myself on developer productivity rather than writing application code, and instead leave it down to the other members of the team. The setup of this codebase, this Haskell codebase, was a bit special because Roman had built a completely custom build system. So, he wasn’t using cabal or stack at all. It was just doing all the GHC invocations, the linking, everything manually using Shake. Shake was a build system that Neil had created during his time at Strats. And it had a number of rough edges. Roman had left, probably before finishing his build system. So, we had problems with build times. We had problems with upgrading the GHC toolchain. So, at the time, we were using an incredibly old version of GHC. I think it was 7.8.

*AL (0:29:18)*: Well, that certainly sounds old to me now, but I don’t actually have the picture. 

*PI (0:29:23)*: This was 2018. I think the world was on 8.6, I think, at the time, or 8.4. 7.8 was very, very old. There was no Stackage at the time. So, it was difficult to upgrade packages, dependencies that we had because they were no longer built with 7.8. It was difficult to make tooling work with 7.8. We wanted to update it, but it was made very difficult by the build system. It was made very difficult by the interaction with the quant library. So, the quant library, Strats is built using Haskell. It has a Haskell runtime, and it was basically possible to upgrade the Haskell version of the quant library. 

So, for technical reasons, we decided to update the version of GHC that we used to build our codebase while not upgrading the version of GHC used to build the quant library. So, that was a big challenge because we ended up with applications that had two Haskell heaps and two garbage collectors at runtime. But it worked. We managed to do it. 

The next hurdle was to improve the build system because the build times were getting out of hand as the codebase was growing. Even though it was using Shake, it wasn’t doing any caching across machines. So, we were the first adopters of Cloud Shake. We’re looking at what other companies and other teams were doing with Bazel, where you can have a CI build farm that will ensure that for every recent version of the codebase, building in e-developer machines, it’s instant because it all comes from the shared cache.

So, Neil had started adding this feature to Shake, but no one was using it, I think. So, we were basically the first adopters. This was all my doing because, like I said, I was focusing on developer productivity, as that’s what I thought was important for the team. So, we were sending fixes and contributions to Shake, buying Neil beer to get that merged and released promptly. It was really challenging to make this work properly because you need a completely hermetic with completely explicit dependencies set of build rules to accomplish cloud cache. And Shake wasn’t making this particularly easy. But once we managed to get working, the productivity improvement was amazing. So, you could build a codebase in seconds, maybe a few minutes compared to the several tens of minutes that you stick previously to this one. And this was one of team complaints of new team members. How difficult it was for them to be productive, how long it took to build a codebase, how long it took them to switch from one branch to another, and so on.

So, after our cloud build system was up and working, my next goal was to get an IDE for it. And remember, I said previously we were using Intero backup. But I think in 2019, Chrisdone stopped maintaining Intero, plus Intero had never been converted to any other build system other than Stack. So, it would have been an option for us here. So, I was looking around, trying to find something that worked. I mean, internally, we were using GHCi or GHCid as a poor man's feedback loop. But I mean, our focus was getting more and more sophisticated. The types were getting more complex, and I could feel the need for an IDE, especially for the more junior team members. So, looking around, I found GHCide, which was a new prototypical very early-stage IDE that had come out of Digital Asset, where Neil was working. 

*AL (0:33:24)*: Again, invented by Neil, I guess. 

*PI (0:33:27)*: Well, they had a legitimate reason for doing it because they had this Double, which was a Haskell-like language. They were using GHC as a frontend to parse this blockchain language, and they wanted to have an IDE for it. So, they built GHCide. But GHCide was, like I said, very prototypical. I tried it out on our codebase, and it couldn’t handle it. It was running out of memory.

*AL (0:33:52)*: It was based on Shake, right? Or was it not at that time? 

*PI (0:33:56)*: Well, yes, yes. So, internally, it was designed as a build system. So, it had build rules for parsing a file, for typesetting a file. And then all these build rules would produce artifacts but also diagnostics. The architecture was very interesting, and I think that’s what got me interested because I saw potential in this. It couldn’t handle a lot of codebase, but I could see that with a bit more work, this was the best paradigm for an IDE. But there were a number of problems. There were resolutions because it was using GHC, the GHC API, to do all the work. And the GHC API is any of the stateful. It is not designed to be used, in an extremely concurrent setting like this build system because it was parsing, type checking, and analyzing all the files in your codebase in parallel as much as a dependency graph would allow it. So, I have to say, they have done most of the hard work in parsing GHC, working around problems with the state, and there were still one or two resolutions left. I remember my first contribution was to fix a particularly nasty one. But the heavy lifting was done. It was, I would say, very ready for contributions. 

The other interesting thing is that it wasn’t sharing any code with the other LSP. So, GHC IDE was an LSP server. LSP is a Microsoft standard for communicating an IDE with language-specific support. And there was already one such LSP server for Haskell. It was called HIE or something like this, led by Alan Zimmerman. That was significantly more mature, but it wasn’t so easy to set up, I would say, and it wasn’t so robust. I wasn’t producing, like I said, the same quality of diagnostics and the same quality of experience. But on the other hand, it had a lot more features, like it had auto completions, it had hovers, documentation support, quick fixes, and so on. And GHCide didn’t have any of this. It had the basic diagnostics. 

So, one particular avenue of contributions to GHCide was to take HIE modules and port them to GHCide. So, I think Alejandro Serrano contributed completions for GHCide using this approach. So, it was kind of – GHCide was quickly growing. And I found myself doing a lot of contributions as well. And I was particularly interested in improving the memory usage because that was the bottleneck for using it at Strats. So, the main reason GHCide was using so much memory is that it wasn’t leveraging separate compilation at all. So, GHC, when it parses and type checks a file, it produces a so-called interface file with all the details about this module, which can be then reused to compile other modules instead of loading all the dependencies, passing all the dependencies every time. So, GHCide was not yet able to use interface files, and for this reason, it had to load your entire codebase in memory, and it was keeping a lot of state for every module in memory, and it just simply didn’t scale. So, if we wanted to scale GHCide, we had to teach it to use interface files. And I started working on this. I grabbed the ticket. And then at the time, there was a hackathon in Bristol.

*SF (0:37:25)*: I was there.

*PI (0:37:28)*: So, there was a hackathon in Bristol, and both Allan Zimmerman and Neil Mitchell, who were both working for Facebook, they got together to find a way to unify these two LSP servers. And there was also Matt Pickering there, who was a big GHC hacker. So, I was there, asking Matt lots of questions about what’s the best way to use interface files. How does this work? Where do interface files get stored in the GHC API? How can we reduce memory usage? So, we managed to get a first prototype of GHCide using interface files and then working. It worked really well, as expected. It solved the memory usage bottleneck for the Strats. I mean, yes, you were still using a lot of memory, but it was scaling much better.

*SF (0:38:19)*: Was it enough for you to use it back at Standard Chartered?

*PI (0:38:22)*: Yes.

*SF (0:38:23)*: Yay.

*PI (0:38:23)*: So, after a few more contributions, GHCide was stable and it was scaling well, and we started using it at Standard Chartered Strats. Just in my team, I guess, because the other teams were doing – they were using their own IDE. So, this was great. I continued contributing a lot to GHCide, hover supports, quick fix supports. Really, I was basically working on GHCide in my spare time, full-time. I was completely addicted to it. The GHCide was getting adopted very quickly as well, so that helped. We had lots of other contributions, tickets, feedback from the community. Also, what helped is that there was a very strong set of contributors who were coming from HIE and who were helping a lot with the admin and the release side of things. So, I was enjoying the fact that I could focus on the coding and challenging problems. And they were taking care of the heavy lifting as well.

*AL (0:39:23)*: Perhaps we should also mention at some point for viewers who are not that familiar with the history that GHCide is the same thing as HLS, right? I mean, it got renamed at some point.

*PI (0:39:34)*: Yeah. So, GHCide is at the core of HLS. So, HLS is the plugin model that came from HIE, because GHCide didn’t really have a good planning model at the time. And then the engine from GHCide is this build system. It was based on Shake originally, and then I replaced it as part of my work in Meta. So, I guess we can move on to the next chapter.

*AL (0:40:04)*: We should get to like what you’re doing these days before we have to end. Yeah, perhaps. I don’t know if it’s not a too intrusive question. Why leave? Why change?

*PI (0:40:19)*: Oh, there was a reorg internally. It split the Strats team, the Strats family in two. Most of the folks working on Mu joined the core quant team that was led by Morten Egan from Singapore. Those of us who were not doing Mu, we had to rejoin the – we stayed with the IT organization. But we lost our ties to the rest of Strats. And for instance, I used to report to Andy Adams-Moran. He was a great person to have as a manager. And then after the reorg, I started reporting to someone else. He was based in Singapore and didn’t really understand what we were doing. 

*AL (0:41:04)*: It just felt like a good moment. Yeah. Okay. And many others have been moving in that direction at a similar time, right? I mean, there was a certain flow of people moving from Standard Chartered to Meta, at least at that point in time.

*PI (0:41:19)*: This is true. 

*AL (0:41:21)*: Yeah. So, yeah. I mean, then after working for various banks using functional languages for quite some time, how different was it to get to a company that does something completely different?

*PI (0:41:35)*: I think the main difference is that in a tech company, there’s a lot of stuff going on for me. So, personally, what I’ve noticed is that when I was working for finance, my team had a very, very clear goal, very clear responsibility, and it interacted with a small set of stakeholders, and that’s about it. So, life was – it was very easy to stay focused, and there were fewer distractions. I guess in a tech company, a large tech company, there’s just an insane amount of stuff going on. There’s lots of initiatives and lots of teams who want you to use their stuff or who want to use your stuff. So, there is a sensory overload of stimulus. There’s just so much going on. And that means that you can get involved in lots of things and you can be really successful in taking advantage of all these opportunities, but it’s also much more energy- and time-consuming. I think that’s why you see that when people are getting one of these big companies, they can seem like they disappear. Partially, I think for me, this is part of the reason. But I was very lucky because when I joined Meta, my first job was to scale GHCide out to Sigma, which is a continuation of what I had been doing in my prior job at Strats.

*AL (0:42:57)*: So, again, that was just like – justice is perhaps the wrong word, but it was like a performance or a scalability problem. That was not like that it just completely did not work. It was merely that it was too slow or too memory-hungry, or –

*PI (0:43:13)*: Both. So, there was an order or two orders of magnitude difference between the size of the codebase in Sigma compared to what we had at Strats and probably the rest of the world, really. So, the size of the Sigma codebase was humongous, I cannot remember the exact figures, I don’t want to say, but very, very, very, very hard. So, even if you have enough memory to load the codebase in GHCide, which you – I mean, dev servers at Meta routinely have 256 gigabytes of RAM. So, everyone has one of these, basically.

*AL (0:43:54)*: Yeah, that’s good. Seems like a good number. 

*PI (0:43:59)*: Memory is not an issue. Although you can still run out of memory, given enough memory lakes. But even if you manage to load the codebase, just pressing a key, like the keystroke, could take minutes to get processed by GHCide. So, it’s completely unusable. The reason for this is that internally, like I said, GHCide was using Shake to create a build graph. I have built rules to do things like parsing, type checking, analyzing, and so on. And the size of this build graph will be proportional to the number of modules in your codebase. And then the degree of this build graph, so the number of edges, could be proportional to the number of imports. And you can imagine a large codebase. It’s a large code base with no packages because that’s another feature of the Sigma codebase. It’s just one huge package. 

*AL (0:44:57)*: I see. Okay.

Pep: *(0:44:59)*: It’s going to have a very interconnected import graph.

*AL (0:45:02)*: Like, I mean, this is one of the features where I still feel like HLS is a bit lacking compared to, for example, Lean, where if I’m using multiple packages, I can just jump between packages more or less seamlessly and go to definition for everything. So, in a way, with HLS, it always feels like you’re actually losing something by splitting things up into multiple packages.

*PI (0:45:24)*: Yes, absolutely.

*AL (0:45:25)*: So if Sigma is all in one package, in principle, it has the opportunity to be a very nice experience if it just works. 

*PI (0:45:32)*: So, the fact that it was only one big package was a feature in my eyes. But it also was a problem because there was no package boundaries. So, every module could, in principle, import any other module. So, people were very loose with their practices. And like I said, the import graph is humongous. So, the problem was that Shake, the build system, used internally by GHCide, have no support to track changes. So, it was designed as a batch process. When you tell Shake to go and rebuild, it takes a look at the entire graph. And then it figures out what has changed by using timestamps or using checksums or using both timestamps and checksums. But it has to visit all the nodes and traverse all the edges. Whereas modern build systems, they use something like a file watcher to track changes to the file system. And then on the rebuild, on the next rebuild, they know what has changed in the file system. They already have a list. They don’t have to go and visit everything. And they do this by tracking inverse dependencies in the build graph. 

So, we have to add this to Shake in order to make it scale to the Sigma codebase, notwithstanding memory usage. To reduce the memory usage, we took some build rules and disabled them, build rules that were checking for module cycles, or build rules that were using too much memory so we can try to streamline them. Like for instance, Sigma codebase doesn’t use Template Haskell. That means that you don’t need the build rules that deal with that. And maybe you need to store less information in build rules because you’re not going to do Template Haskell. 

*AL (0:47:10)*: Sorry, just to understand, does that mean that Sigma is or was using its own fork?

*PI (0:47:17)*: No, no, no, no. So, it was using GHCide as a library. So, GHCide is – technically, it is a library for building LSP servers for Haskell. So, it was using GHCide as a library. I added some hooks in GHCide that allowed to replace existing build rules. Like, you don’t want to throw away all the build rules and write new ones. You just want to replace the specific ones to make them, like I said, linear, use a bit less memory, or make other changes. So, I added this facility to GHCide core. But Sigma was using Sigma IDE, which is an IDE built on top of GHCide. And it was also using some HLS plugins as well because that was another facility that we had. We could pull one of the code formatter plugins. I think we were using Ormolu. So we could pull the Ormolu plugin and add it to Sigma IDE. And instead of having four code formatters like HLS has, in Sigma IDE, there’s only one code formatted. That’s the one that you use for this codebase, and it removes the choice and removes the complexity from users. 

We developed our own plugins as well. So, we had a plugin to try to encourage people to import fewer things. So, it was a code that’s showing like for every import, what’s the cost of this import, or we are applying that you minimize imports. So, it would show up a code lens that would say, “Unnecessary import, you can merge these two imports,” or “You can import this smaller module because you’re importing a module that is re-exporting a lot of stuff.” But you don’t need that import. You can just refine it and have this small import. So, we have a number of plugins specifically developed for Sigma. 

And so, I think we released the more, like generally useful ones. Like this Refine Import plugin is now available in HLS.

*SF (0:49:08)*: And did it increase productivity? What was the general reception?

*PI (0:49:12)*: It was a very good reception. People were very, very keen on having an IDE for Sigma. This was the number one complaint of Sigma developers, that there wasn’t a working IDE. Unfortunately, at the time, Sigma was declassified as non-strategic anymore because there were new tools, new frameworks, new rule engines that have been developed more recently and that had become like the strategical engine, and they were designed to, at some point someday, overtake and replace Sigma. So, the investment in Sigma tooling and in SIGMA developer experience and quality of life was reduced. So, the Sigma IDE project initially dwindled and stopped getting funding.

*AL (0:49:57)*: Yeah. So, I guess we should actually come to an end in the not-too-distant future, but I’m also realizing that we haven’t talked about like what you’re working on these days, which I think is Glean.

*PI (0:50:09)*: So, Glean is open source. Everyone, I think, knows about Glean. I mean, Simon has been a number of talks in different Haskell events. It’s a system for collecting, deriving, and querying facts about source code. But I think what most people don’t know is the ways that we use it internally at Meta. So, there are literally dozens of applications of Glean internally. It’s very, very successful. The main thing is, obviously, code navigation. When you have a massive codebase, doing code navigation in the IDE is not necessarily the best way of doing it. And that’s Glean’s number one application. But then it’s used for a huge number of other things, like static analysis. So, static analysis for privacy, static analysis for test coverage, static analysis for code complexity and selection, optimizing build rules, and – I don’t know. It’s very hard to summarize. I think at some point we should publish a clean blog post describing all the ways that we use it internally. 

One thing I’ve been particularly like working myself is having code navigation available at this time, at code review time. I think GitHub started offering this for some languages a few years ago for Python. So, now internally at Meta, we use Glean to enable code navigation for code review for pretty much any language that we have a Glean indexer for, like C++, JavaScript, PHP, Haskell as well, Rust, Thrift, a long list.

*AL (0:51:46)*: And given that we’ve been talking so much about IDE experience and Haskell, is there some story waiting to be told about integration of Glean and GHCide HLS, or are you seeing these as mostly separate tools?

*PI (0:52:01)*: So, GHCide already has a code indexer built in, but it already indexes all your code and it stores it in a SQLite database locally in your local cache so that all the code navigation data is available at startup time immediately, even before your codebase has been loaded. And we use this facility for Sigma IDE to pre-warn that database of code navigation facts before, so that before an engineer, a Sigma engineer, starts an IDE, it’s already pre-indexed and available. In fact, our Glean Haskell indexer is reusing this HIE, H-I-E database to extract facts about your Haskell code and then add them to Glean. So, I don’t see a need to integrate Glean into HLS. I think you could use Glean to replace Hoogle. That would be a more realistic application of Glean. So, you could use Glean to collect facts about the entirety of packets periodically, and then use it as a simple search server or type search service. Someone could contribute that if they were interested in modernizing Hoogle.

*SF (0:53:19)*: So, it sounds like over your career, you’ve done a lot of improvements to the Haskell ecosystem. Is there anything that you think is missing? What’s next?

*PI (0:53:29)*: Oh, someone should integrate GHC and GHCi debugger in an MSP or in a VS Code extension. I think there’s something out there that already does this, but it’s not part of HLS, which means that most people are not aware of it or not trying to use it.

*AL (0:53:48)*: All right. Any other goals, or I think I mean, this continued quest for making GHCide more efficient or more scalable is probably never really done, I guess, or do you see that the point has been reached where you feel like everything that is achievable has been achieved?

*PI (0:54:10)*: So, I think the point at which most people can use it has been raised. We are using it internally, not in the Sigma codebase only, but also in the non-Sigma Haskell codebase, like the Glean codebase as well. And it works perfectly fine for us, I mean, in terms of scale. I understand that there might be large codebases out there with lots of Template Haskell, where HLS is still a bit of a challenge, but I think that for 90%, 95% of use cases, it’s already there. So, I’m very happy about that.

*AL (0:54:43)*: I personally agree, but I mean, if you talk to one of the people who are in the 5%, then of course, they have a different perspective on things. 

*PI (0:54:55)*: But that’s a problem for the 5%. So, they should do what Meta did and then invest in improving the technology themselves.

One thing that is still lacking is the support for multi-component. So, for multiple packages, like you said, we work around that problem by not using multiple components. So, internally, what we do is we create a single component with all the relevant packages merged into a single fake component. And that’s what we feed to GHCide. We sidestepped that problem completely because otherwise, like you said, you lose a lot of the features, you lose the ability to navigate code or to see changes that have been made to another component. So, that doesn’t always work, ideally. 

It’s a challenging limitation to lift. I know that with the support for multiple components in GHC, that’s going to hopefully get better in the near future. And I’m very much looking to the work that Well-Typed and the rest of the HLS contributors are doing on that regard.

*AL (0:55:56)*: Okay. Thank you so much, Pepe, for sharing all your experiences with us. Best of luck for the future.

*Narrator (0:56:05)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
