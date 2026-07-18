*Farhad Mehta (0:00:03)*: Hello and welcome to this episode of the Haskell Interlude. This is a special joint podcast episode between the Type Theory Forall podcast, which was recorded in front of a live audience at ZuriHac 2025. It is co-hosted by me, Farhad Mehta, and Pedro Abreu from the Type Theory Forall podcast.

Today, we have the great honor to talk with Lennart Augustsson, a real pioneer in the world of programming languages. We’ll discuss language design, compiler implementation, and about his time at a top-secret research facility.

*Pedro Abreu (0:00:40)*: The place where I thought about starting is why Haskell? What drew you into it? Because you were the first person to do a Haskell compiler, and you were still doing Haskell compilers. You’re still around doing this kind of stuff. What about Haskell?

*Lennart Augustsson (0:00:56)*: Well, I didn’t start with Haskell. I started with functional programming when I took a course on denotational semantics, and the guy who held the course, Sören Holmström, he had gotten an implementation of SASL, which was David Turner’s first language, St Andrews Static Language. Static, meaning it had static typing and not dynamic typing, because he was sick of dynamic typing. He’d done Lisp. 

*PA (0:01:24)*: And David is the guy of Miranda? 

*LA (0:01:26)*: Yes. And so we used this to do simple little things in the denotational semantics course, because a lot in denotational semantics is like functional programming. And then someone pointed me to this paper by David Turner from 1978, the one that describes how to implement a functional language using combinators. So our SASL implementation was not done with combinators. And I read that paper, and I thought, “Wow, this is fascinating.” I mean, before that, I was thinking, “Yeah, functional programming, it’s a bit interesting.” And I decided, “No, I need to implement this.” So I did that on my hobby computer, which was something I’d built, a Texas Instruments 16-bit processor. So it had 64k of memory. So it was only a small language that I could do, of course. And then, yeah, I thought, “Functional programming, it’s interesting. It’s weird, programming without assignment.” I mean, when I first heard of programming without assignment, I thought I must have misunderstood something. There’s no way you could program without assignment. Come on. It’s the most basic thing there is. And, of course, underneath, functional programming, or with lazy evaluation at least, they do more assignments than anything else, because you need to update things all the time on the heap or wherever you store your stuff. 

Anyway, so then I was doing my PhD at that point. So I and my colleague, Thomas Johnsson, we decided we should do a different implementation, one that is faster than this. So we wrote an implementation of a language that has no name. We mostly threw it away fairly quickly. But let’s call the programming language F, because the compiler was called FC. The compiler had a name, not the language. So then we thought, “Yeah, this is cool.” But it was a lot like SASL, so it was dynamically typed. 

And then someone brought back a tape from Edinburgh that had ML on it, that ran in Lisp. And I remember typing the map function into this system, and it told me what type it had. And I was like, “Whoa, how could it figure out what type this function has? That’s magic.” So we thought, “Yeah, we need to do a different programming language, one that is typed.” But we liked lazy evaluation because that’s what came from SASL. So we decided, “Okay, we need to do a version of ML, but lazy.” So that’s how we decided to do Lazy ML.

So the first compiler for Lazy ML was written in this other unnamed language, F. And then once we had that running, then we threw away the old stuff because that was written in C. And then we sort of rewrote the Lazy ML compiler in itself, so it could bootstrap. So this has nothing to do directly with the functional programming, but I can mention a small anecdote about this. So this was before you had source code control systems and all these fancy things. There was a source code, and that was the source code. And then you compile that to a binary, and that was the binary. And so I made some change to the compiler and compiled that, and you got a new binary. It didn’t have the old binary. I mean, disk space is expensive. No, the new binary doesn’t quite work. And it’s the only one that can compile this compiler, and it doesn’t work. Well, you use the binary debugger, the low-level debugger on the assembly code, and you step through it and find, “Oh, there’s something wrong here. If I patch the machine code a little bit, I can make this compiler work.” 

So after that, every time we replaced the compiler binary, we did a three-step process. The compiler can recompile itself, and the recompiled compiler can compile itself. And those two last ones are equal. So we got a little more careful. So we were doing some lazy function programming, Lazy ML. People at Yale were doing another one called ALFL. And there were sort of different efforts around the world, and at some point, people said, “It’s a pity we have so many different ones.” So we should agree on some sort of – pick the subset of these languages that everyone agrees on. And so at the FPCA conference in Portland in 19 –

*PA (0:06:34)*: This conference doesn’t exist anymore, does it? What is FPCA?

*LA (0:06:38)*: So there were two conferences, one called FPCA (Functional Programming Computer Architecture) and another one called Lisp and Functional Programming. And they ran every other year, these two. And so people said, “This is silly. We should make one conference.” And that became ICFP. 

*PA (0:06:55)*: ICFP. Okay, gotcha.

*LA* So at this conference, we got together in a room and said, “Okay, let’s make a language that everyone can use so we have the same notation, make it easier for people to read each other’s programs, and we can exchange programs.” And so that’s how the Haskell committee was formed. We didn’t have a language name at that point. I mean, we didn’t have a language either. So both Thomas Johnsson, my colleague from Chalmers, and I were there. And so we said, “Okay, we’ll flip a coin on who’s going to be on the Haskell committee.” And we flipped the coin, and he lost, so he had to be on the committee. I joined it like five years later or something like that. I mean, I went to some of the meetings. And so, I mean, I can’t tell exactly how much of the design happened because I wasn’t on the committee early on. And then there were many – 

*PA (0:08:00)*: Your friend was John Hughes, maybe? 

*LA (0:08:02)*: Thomas Johnsson. Yeah. So he’s the guy who invented lambda lifting. 

*PA (0:08:08)*: Uh-huh.

*LA (0:08:11)*: I’m just sort of doing a little more Haskell history. So they wanted to have a name for the language. And I thought it would be Curry because there are so many wonderful puns you can make with Curry. But I decided we can’t have people making puns about the language, so let’s do Haskell. And since it was then named after Haskell Brooks Curry, Paul Hudak, who was sort of the informal head of the Haskell committee, he decided he will go and talk to Haskell Curry’s widow to see what she thought about naming a language after her husband. And so he talked to her, and she said, “Oh, yes, yes, I think he would have been thrilled if he’d known that.” And then, as Paul was leaving, she said, “But he never really liked his name.” 

And so why am I still doing Haskell? I don’t know. I mean, I’m old. I can only do things I already know. So I keep doing Haskell. I think it’s a pretty nice language, and it grows and grows. I can’t even pretend to know all the corners of Haskell anymore because it just gets new stuff. I mean, I can understand each new thing, but how to use them all in sort of together? I don’t know. I write in the Haskell dialect from 15 years ago. I said that my MicroHs compiler can be compiled with Hugs, which sort of is 20-year-old Haskell. That’s where I stick to on purpose. 

*PA (0:10:05)*: Nice, nice. 

*LA (0:10:07)*: Yeah. 

*FH (0:10:09)*: Do you still have a running copy of Hugs on your system? 

*LA (0:10:12)*: I have a patched version of Hugs that runs enough, but I’m going to resurrect Hugs. 

*FH (0:10:18)*: Oh, super.

*LA (0:10:19)*: So the only thing I use that Hugs doesn’t have is pattern guards. So I thought I’d add pattern guards. I talked to Mark Jones if he could do it, and he said, “Oh yeah, well, it might be interesting, but I’m head of department now, so I don’t have time for these things.” 

*PA (0:10:35)*: One thing that I noticed is that, as you said, all of you guys were working on laziness back then, like doing this functional programming, and you’re very curious and very interested of things that laziness could do. But it seems to me that nowadays it’s like wore out of fashion to do functional, not even functional programming, like programming in general, and laziness. And a lot of people even argue that laziness is not really a good idea. What are your thoughts back then? Were you excited about laziness? Do you have questions? And what are your thoughts nowadays?

*LA (0:11:14)*: Well, so back then it was sort of more of a religious belief. Of course, you have to do laziness. It’s the only way where you know you’re not going to do any unnecessary work. On the other hand, you have to do a lot of extra work to not do any unnecessary work. So it felt like the natural thing to do. And then once you get going, you have to stick to your guns. I don’t think there would have been monads in programming languages if Haskell hadn’t decided, “Okay, we need to be –” well, first you say we need to be lazy, and then you have to be pure because if you’re not pure, you get insane if you want to have some effects at the same time as you’re lazy. Okay, so we have to be pure. And then how do we do things like IO? So Haskell had a very – well, actually two different ways of doing IO early on that were not very nice. And then eventually it got monads. I can tell you about that too. 

*FH (0:12:21)*: Yeah, please.

*LA (0:12:24)*: So there is this working group on functional programming, IFIP Working Group 2.8. We meet once a year or so, and we were meeting in France, maybe. And Eugenio Moggi gave a talk about this weird thing called monads that he had used for denotational semantics, and everyone walked away sort of, “What are these things? I didn’t understand a word he said,” except Phil Wadler, who came back a little bit later. “I think this monad thing could work for Haskell if we do it right.” And so he convinced us that monad was the way, that was the way to do IO. The syntax was very clunky. And then Mark Jones invented the do notation that he had in his precursor to Hugs called Gofer. And yeah, that sort of, yes, this is a nicer way. I mean, the IO before that was terrible. I can tell you about it. So the basic one was that a program is a function from responses to requests. And the weird thing is that the program, say, these are both lazy lists, lazy lists of responses coming in and requests going out. So if you want to read a file in the output, you produce a request to read the file. And then an answer will appear in the input stream with the file contents. This is horrible. You need to keep these two synchronized. You can’t look at the response before you’ve issued the request. So it’s very easy to make mistakes. So we did it like this. So monad was like, “Oh, yes, this is the way you can do it.” I don’t know what the original question was. 

*PA (0:14:29)*: Did your thoughts on laziness –?

*LA (0:14:31)*: Oh, yes. Has it changed? Yeah. I mean, I’m not that religious anymore. 

*PA (0:14:40)*: I’m atheist.

*LA (0:14:41)*: But I mean, I think laziness gives you the nicest algebraic properties. You want to sort of reason about programs and manipulate programs because they behave in a more mathematical way. But it’s also awkward in many ways. I mean, you can’t get stack traces in any easy way. You have to bend over backwards to get stack traces, for instance. And it’s harder to control resource usage, especially memory. 

So I haven’t seen a perfect answer. I like laziness for some things. I like strictness for some things. And so some people say, “Well, you could have a strict language, and then you put laziness where you need it.” And that’s fine. But you can’t write in the style of Haskell anymore, where, say, the OR function in Haskell that takes a list of Boolean values and ORs together. That’s written as a foldr with a binary OR operator over the list. And if you do that in a strict language, it will go down the whole list before saying if it was true or false. Whereas if you’re lazy, it will go until it finds the first true, and then you’ll get the result back. 

So if you want to write in this sort of combinator style, then you really need to have lazy evaluation, and you need it on all the functions. I mean, if foldr wasn’t lazy, then the whole thing wouldn’t be lazy. So if you want to have sort of strict and then have annotations for laziness, then you’ll need two versions of foldr, one that is strict and another one that’s lazy. So one of the biggest proponents for strict evaluation and Haskell haters, dislikers, Bob Harper, even he admitted that if you want to write in this style, yeah, you can’t do that in ML. It doesn’t really work.

*PA (0:16:51)*: I wasn’t going to drop names, but I had that in my head. I’ve noticed that there are –

*LA (0:16:57)*: Oh, he’s a good friend of mine. So I don’t mind this.

*PA (0:17:00)*: He usually does that out of a joke, right? He is very funny. 

*LA (0:17:03)*: Yes. 

*PA (0:17:05)*: I’ve noticed that there are like two kinds of people, the ones who see programming languages as like a tool to a means to achieve your goals. And there are people who see them as these beautiful mathematical properties that are goals in themselves. What category do you think you kind of fit, if any?

*LA (0:17:24)*: I dunno if I can pick a category. I certainly use programming languages to achieve goals, but I mostly like write compilers. So, I mean, does that mean that I – am I achieving a goal, or am I just achieving the goal of building the beautiful mathematical thing? I don’t know. But I think there’s something to say about beauty in programming languages and other things. If it looks nice, it’s often nice.

*PA (0:18:01)*: Yeah. What if it doesn’t look very bad, like your obfuscated C competition codes that you’ve got? Where does that come in?

*LA (0:18:11)*: Well, I mean, if you want to be able to appreciate beauty, you have to be able to understand ugly.

*PA (0:18:23)*: There’s a beauty in ugly too, huh?

*LA (0:18:25)*: Yeah. So I participated three times in the Obfuscated C Code Contest, and all three times I almost cheated because I used functional programming. 

*PA (0:18:41)*: So that’s your secret?

*LA (0:18:43)*: So the first one, I think it’s an old algorithm, I think by David Turner again, that computes e, the transcendental number. It just keeps spitting out digits, and you do it by a base conversion. So you change base for each digit, and you just do regular base conversion. And so I took that, and I rewrote it in C and sent it in. I mean, it’s hard to understand in Haskell, and it’s impossible to understand written in C, and then you format it in a really ugly way. I love it. 

So early on, they had a limit. You could only have 512 bytes. So the second entry I sent was one that computed prime numbers. Again, using a lazy sieve, the way you would do it in a functional language, and then transcribed into C. And I remember my program was 513 bytes. And I mean, I’m sure there would have been ways to fix that, but I decided, “Oh, if I print in base 2 instead of base 10, I can save one digit.” So it printed primes in base 2. It’s the only time I’ve had a recursive main function. 

*PA (0:20:25)*: That’s hilarious.

*LA (0:20:26)*: And the third one, that wasn’t really a functional problem. I wrote a small Haskell. No, sorry, a small C compiler, a subset of C. I called it Obfuscated C. So it’s a tiny subset of C that was enough that the compiler could compile itself. And now, luckily, you were allowed 1,536 significant bytes and 3,817 bytes in total, I think. But those extra bytes, they had to be tab, space, new line, left curly, right curly, or semicolon so you could use it for formatting. And so this compiler worked by – I wrote an interpreter for this tiny little language with bytecodes. And then I wrote the compiler in this tiny little language. And then I compiled that, and I got a bunch of bytecodes. And I took those bytecodes, and I stuck them in a comment at the beginning of the interpreter, which means if you have the interpreter, you also have the compiler, because the bytecode for the compiler is in the comment in the beginning. And then there’s a special reader that sort of saw, “Ah, yes, it starts with these three characters. That means that there’s bytecode here.” So to run the compiler, you compiled the program you got, and then you fed the source of it to itself. And it’s all, “Ah, yes, here’s the bytecode. Now I can compile.” And then you feed it to the actual program you want to compile. 

So that year, I won the grand prize. But, I mean, I’ve been eclipsed in this by far later on by Francois Bellard, who wrote the Tiny C Compiler, because he wrote the C compiler to machine code that he won the Obfuscated C Code Contest with a few years later. But I mean, I spent a lot of time on this C compiler thing. It was stupid. I wrote the peephole optimizer for the bytecode that was written in Haskell, of course.

*PA (0:22:52)*: It seems like you really get fun out of doing these things, huh?

*LA (0:22:56)*: Oh, yes. I mean, and it’s a challenge. You have these many bytes. Oh, I forgot to say, you’re also allowed a command line to compile your program that can be maybe 128 bytes. I can’t remember. So you can put a lot of your program in -d flags to have define, extra defines for it. So, I mean, maybe 10% of the code was actually under FMA.

*PA (0:23:26)*: That’s a huge command. Wow. That’s really cool. That’s very interesting. So you also have a very – you’ve been around in the industry. You’ve been a professor. You’ve been around in industry. You’ve worked for banks. You’ve worked on a bunch of stuff. How do you see – I mean, a lot of times, especially in the industry, you have to make compromises, right? Like you have your manager, you have people above you wanting things in a certain way or wanting things to be finished earlier than you’re able to finish things. So there is this tension, right, between getting things done, being practical, and making good software, beautiful software, or even theoretically pleasant stuff. How does that come up in your career?

*LA (0:24:23)*: So, I don’t know, maybe it’s just me. Often I don’t feel pressure to get things done the way they want. I do it the way I’d like to do it. If they’re not happy with that, they can fire me. I can get a different job. I mean, of course, sometimes you feel the pressure to get things done. But a lot of the time, I want to do it my way. But I mean, I’m willing to compromise on the beauty. I think to get things usable for people, you need to make it easier to use. You can’t be in the ivory tower and just use the nicest theoretical thing.

*PA (0:25:10)*: I see a lot of people arguing that when you have a nice theoretical thing, then it’s usually more modular, more understandable, more readable. So often it all goes hand in hand. 

*LA (0:25:22)*: Yea, I think that’s probably true. But I don’t know. I don’t think I have a good answer. I’ve frequently done things the way I’d like to do them. So, for instance, at Standard Chartered Bank, where there is this language Mu, which is Haskell but strict, there was no one saying, “You should do this.” Instead, there was another weird little scripting language called Lambda that was used inside Excel. That’s why Mu is named Mu, by the way. It’s the letter after Lambda. And so, at some point, people wanted more and more features of this, more overloading. They wanted modules. So, we said, there was mostly me, maybe someone more, “We could just make a small subset of Haskell instead of reinventing this.” And so, I just started doing that. It was a week when my boss was away. And then, yeah, he was kind of a functional programming convert already, my boss. So he was sort of, “Yeah, yeah, yeah, that’s good, that’s good. We’re going to use that.” And so, that became one of the largest Haskell code bases in the world. Now, I think it’s – I don’t know. Google is here. How many million lines of code? 

*PA (0:27:15)*: Wow.

*LA (0:27:19)*: And so, some people say, “Oh, it’s not Haskell. It’s strict.” That’s true. It’s not Haskell. It’s strict. But if you don’t know that it’s not Haskell and you just look at it, it sure looks like Haskell. 

*PA (0:27:37)*: What about programming for hardware? What is the story behind the design of Bluespec?

*LA (0:27:44)*: So, there was this MIT professor, Arvind. He and his student had come up with a way of doing, specifying hardware by using term rewriting systems. And his student had made some kind of prototype implementation for this. This was around 1999, where everything was booming. Everyone started companies. So, all of Arvind’s colleagues at MIT, they all had started companies. And now Arvind said, “Yeah, I need to start a company too. We’re going to do this language.” And so, he asked me, “Will you come and work on doing a language for hardware design?” 

*PA (0:28:28)*: How did you guys know each other? 

*LA (0:28:29)*: Sorry? 

*PA (0:28:30)*: How did you guys meet? 

*LA (0:28:31)*: Oh, Arvind was part of this IFIP Working Group thing that I’m also a member of. Also, I met him first time in 1981, I think. I mean, we knew each other forever. So, he was into functional programming, but he came from the hardware side. He did dataflow machines and realized you can only really program dataflow machines in sort of some pure functional way. You have to give up on the sort of traditional way of doing it. And dataflow machines are kind of dead, but the principles of them are in every processor these days. They are reorder buffer. You have that sort of stores incoming values that come from memory, come from registers, and then you operate on them when they have arrived. That’s exactly how dataflow machines are. You sort of have nodes that do operations, and tokens come in. And when all the tokens are there, you compute, and you send out the new token to somewhere else. So, those ideas are still around.

Yes, so Arvind wanted to do a company and asked if I wanted to work on that, and I thought, “Yeah, I can do that. But the only language I know is Haskell, so I’ll make this hardware design language look like Haskell.” So it’s pretty much full Haskell, but only at compile time. So the Haskell-y bit is really metaprogramming, and the thing that it targets is these rewrite systems, where you have rules that say, if these conditions are fulfilled, you will atomically transition from this thing to that thing, which is very stateful. But that fits very well with synchronous hardware, where on every clock tick you update the state. So that’s a transition. 

The thing that makes this work well in hardware is that these transition rules you have, they’re supposed to be atomic. Otherwise, you can’t reason about them. But if you only did one of these transitions on every clock tick, it would be extremely slow. But you look at the rules, and you see, “Oh, these rules are completely independent of each other.” So you can do them both at the same clock tick, and you find as many as possible to do at the same time. So that’s sort of a scheduling phase that the compiler does. 

So that has nothing to do with functional programming. The functional programming bit is the thing that describes how do you get from the old state to the new state. So it’s sort of a combination of very pure and also stateful. But it has to be pure, the thing that goes from one state to the next, because it’s hardware. You only have combinational circuitry between the two clock cycles. So that has to be functional. And then you do update your state, and you do the next step.

*PA (0:31:44)*: And you were working with it. Did you feel like it should – how can I phrase this? Because designing hardware and doing stuff for hardware is very different from doing regular compilers and regular things. Did you feel that difference? Did you feel it harder, better?

*LA (0:32:00)*: It’s very different. 

*PA (0:32:01)*: Yeah.

*LA (0:32:02)*: It’s very different. And this dream that some people have that, “Oh, we can make a language, high-level language like C, and we’ll compile it to hardware,” it doesn’t work. I mean, if you’re going to make good hardware, you have to know exactly what you’re doing down on the tiniest levels. I think BlueSpec hits a nice spot there because you can write whatever crazy things you want, and it tells you how to transition from one state to the next. But you are responsible for taking care of the state transitions. You can hide all that in nice modules and things like that, but you’re responsible for the actual microarchitecture. And you can make reusable components and so on, but I think you have to know exactly what you’re doing. And I mean, we hired a lot of hardware engineers out of the BlueSpec company. And they are extremely conservative people in that they want to have absolute control and know what’s going to happen.

*PA (0:33:10)*: Yeah, yeah.

*LA (0:33:10)*: And I mean, I understand that because, well, this was like 25 years ago or 20. You make a mistake, and it doesn’t work. You have to respend the chip. That’s at least $10 million.

*PA (0:33:28)*: Yeah.

*LA (0:33:29)*: I mean, these days, it’s probably at least $10 million if you made a mistake. So I think having that level of control is necessary if you want to make good hardware. You can make crap hardware from these high-level languages, that I could compile it from C to hardware, but I don’t think you can make good hardware. But then again, now with large language models, who knows what they can? 

*PA (0:34:04)*: Yeah. It reminds me when you’re talking in the ‘90s, the end of the ‘90s, everyone was opening their own company. It feels similar today, right, but AI. 

*LA (0:34:14)*: Now it’s AI, yes.

*PA (0:34:15)*: So it’s like lonely, and everyone’s crazy, “I have to do the next AI big thing.”

*LA (0:34:19)*: Yeah, it’s a bubble, and it might burst. In those days, everything was Internet, and you could do this and that. And there were crazy things like, oh, you could buy live lobsters on the Internet and have them delivered in a box to your home. 

*PA (0:34:38)*: Yeah.

*LA (0:34:39)*: Okay. I thought it was a crazy idea then. 

*PA (0:34:43)*: People do that in the US. Yeah, yeah, yeah. Do you want to bring something up, Farhad?

*FH (0:34:49)*: Yeah. So I was just wondering. So you have a number of, I don’t know, strong opinions about language design and things like that. So is there something underlying that? So you said you think that someone from Haskell would not go into the Obfuscated C Competition, but at the same time, there are things in the sort of the functional programming world, for example, metaprogramming, where you also – would it be right to say a bit of an aversion to? I don’t know. Template –

*LA (0:35:11)*: Oh, no, I don’t have an aversion to metaprogramming. Not at all. I have an aversion to Template Haskell.

*FH (0:35:18)*: Ah, okay.

*LA (0:35:20)*: Because I think it’s ugly. No, I’d like to have some nice metaprogramming facilities in Haskell, but I don’t know how to do it, and yeah. So I mean, I use Template Haskell when I must, but I don’t like it. I think it doesn’t look nice. It looks nice in Lisp and Scheme because everything is just – you can’t tell if it’s a macro or if it’s a regular function. I think that looks nice. 

*FH (0:35:53)*: Yeah.

*LA (0:35:54)*: And say, well, in Bluespec, the Haskell code was basically metaprogramming. You execute all that Haskell code at compile time, and it generates the low-level rewrite rules. So that was sort of all metaprogramming. 

*FH (0:36:12)*: Yeah, yeah. Yeah, that’s true.

*LA (0:36:16)*: I just want it to look nice. 

*FH (0:36:19)*: Cool. Another thing that struck me about you is that many people, when they think about programming language people, they typically think of someone in academia, someone there and not really doing stuff in the real world. You seem to be quite the opposite, right? You are a PL person. You’ve written compilers all your life, but you’ve always been in different places and very applied places. How did that even come about? I mean, I’ve seen that you were in two banks. I mean, were you a programmer? I mean, your LinkedIn page says director. I don’t know. Was that?

*LA (0:36:59)*: Well, I can say how it came about. So I was at Credit Suisse first, and there were two guys at Credit Suisse. They were looking for something about Excel, I think, because they were making Excel users. So they found some talk by Simon Peyton Jones, and they listened to that. And then they found something else, the other talks of him, and they thought, “Oh, there’s functional programming.” And then one of the guys had actually taken a course from David Turner with Miranda. So he knew a little bit. And they thought, “Yeah, okay.” And banks were doing very well. And this was sort of 2005, ‘06. So the bank said, “Oh, yeah, okay. You can hire a couple of people for a year to see if there is something with functional programming.” So they asked Simon, I guess, and Simon said, “Yeah, I can send out a message on the functional programming mailing list and see if anyone picks that up.” And I saw that. Oh, a bank. That sounds crazy. I’m not going to do that, but I can talk to them because I was in the US. And so I went to New York, and I talked to them. And I thought, “Oh, yeah, they’re paying well.” So I and Gabby Keller worked for them for a year, and she went back to academia, and I thought, “Yeah, I’ll stick around a bit.” And so I continued writing Haskell. So I wrote some plugins for Excel so that you could write. If you wanted to program your Excel, you could do it in Haskell. You could write Haskell functions and then call them from Excel. 

*FH (0:39:02)*: Oh, wow. Okay. Is this available, or is this – 

*LA (0:39:04)*: No, I’m afraid not. I wish it were, but it was really nice. And you could mark an area on your Excel sheet and say, “Send that to Haskell.” And if it was a sort of just a row, it became a Haskell list that you can process. 

*PA (0:39:19)*: So Haskell really is the ultimate functional programming language. Not Haskell, Excel. 

*LA (0:39:24)*: Okay, yeah, Excel. I mean, I’d like to call Excel a zero-order functional programming language because there are no functions. I mean, you can’t make functions. 

*PA (0:39:36)*: Yeah.

*FH (0:39:36)*: Yeah. 

*LA (0:39:38)*: Except that was the thing that they did. They wanted to make functions. They already had lots of sort of these add-ins. Excel makes it fairly easy to write extensions, and they wanted to be able to write functions so that they could write something more complicated, operate it on maybe an array or something like that. So that was about the first thing I did for them to write something where – so it looks – the function you want to define, you put that in a string, and then you call this add-in function. They’re called add-ins, these extra plugins for Excel. And that converts it into a function. What does that even mean? Because Excel has strings, it has numbers, it has Booleans, and it has error values. So those are the four things you can have in a cell. So, how do you have a function or anything else for that matter? And it turns out all banks have these add-ins with more complicated values than these that, I mean, maybe you want, I don’t know, a table of exchange rates over the years or something. So they do different things. 

So at Credit Suisse, they use numbers less than 30,000 to represent these other things. And then you use that to index into a table. And I think it was Deutsche Bank, they just took the address of the thing and turned that into a floating point value, and you store that in the cell. And when you convert that back, if you’re lucky, you’ll get the same address back. Then at Standard Chartered, you use a string instead, but with some extra curly braces around it. So you have to do it in one of these ways. Well, I mean, Excel finally got functions a few years ago, but it was too late. I mean, the banks had been doing these things since mid-’90s, probably.

*PA (0:41:52)*: Right.

*LA (0:41:54)*: So it was too late. Yes. So then I was working at Credit Suisse, and they brought in a new guy, Marten Agren, who happened to be Swedish. And he had decided that all the programming should be done in some different language than people were using right now because it was not right. And he had been working at Goldman Sachs, and they have their own programming language called Slang, which is kind of functional, I guess. I haven’t really seen it, but it also has unrestricted side effects. And he had felt the pain of these side effects. So he had decided you need to rein in the side effects somehow. And so I talked to him a number of times in Swedish, and I convinced him that Haskell and the IO monad and so on, that was the way to go. And he turned into one of these – you might have seen them. You might have been one of these people. The new converts to functional programming. They have glowing eyes. And so he was happy with the stuff we’re doing. And then after a while he quit to work for Standard Chartered Bank. And then a little later, enough later that it was not illegal, he asked me if I wanted to join Standard Chartered instead. And so I did. 

*FH (0:43:32)*: Okay. Okay. Oh, wow. Interesting.

*LA (0:43:36)*: And then I mean, I can just go on then. 

*FH (0:43:38)*: Sure. 

*LA (0:43:39)*: I mean, it was well paid in banks, but banks were on the downhill. So after a while, I decided, no, there’s no money in banks anymore. I’ll work for Facebook.

*PA (0:43:47)*: So now you’re on blockchains, I assume. I’m kidding.

*LA (0:43:52)*: Aren’t blockchains over? I thought that was – it’s LLMs.

*FH (0:43:55)*: LLMs, man. Yeah.

*PA (0:43:56)*: Right. LLMs with blockchains, maybe. 

*FH (0:43:58)*: Yeah.

*PA (0:44:01)*: You got a –

*FH (0:44:01)*: Yeah, yeah, yeah. So I was just wondering. So you’ve worked in a number of places, a number of different countries, also you are Swedish. Do you notice there’s some different direction in programming languages or the way people think about programming languages in these places? I mean, Sweden is quite prominent as well, right? I mean, you also have Per Martin-Löf, for example.

*LA (0:44:21)*: Yes. Yes, indeed. Yeah, he was very influential when I started my PhD. 

*FH (0:44:27)*: Okay. 

*LA (0:44:28)*: There was several people at the department who did Martin-Löf-type theory stuff.

*PA (0:44:33)*: You did your PhD at Chalmers?

*LA (0:44:34)*: Yeah. 

*PA (0:44:35)*: Okay. 

*LA (0:44:36)*: And so, I mean, I did some of that too, of course. I made a proof assistant for kind of Martin-Löf-type theory stuff.

*PA (0:44:44)*: Was it Cayenne?

*LA (0:44:45)*: No, no, this was long before. This was called ALF.

*FH (0:44:51)*: Of course, I know. That was you. My God.

*LA (0:44:52)*: I had an early version of ALF, then there was ALF two. 

*FH (0:44:56)*: Yeah. All right. Oh wow. Wow. Okay.

*LA (0:45:00)*: Yeah. So, this was early ‘90s, maybe, and there was this TV series called ALF with a weird little alien. And so, I had that weird little alien as the logo for this thing, and Per Martin-Löf was not happy. It was not serious. Is there a difference? I don’t know. I don’t think I’ve noticed really a difference in different countries. I think it’s more – it’s the people that you find there. I mean, maybe American companies are a little more focused on quarterly results than some, but I think that’s sadly spread to the rest of the world too.

*FH (0:45:53)*: Sorry, I was also wondering in this respect with quarterly results and your personal opinion on things that I do things that I like. And yesterday we had a panel here at ZuriHac, and we talked about, okay, what about industry acceptance of Haskell? And people said, “Oh, we should do this. We should do that.” I don’t know if your approach – I mean, you’ve basically had your whole career doing things that you like. Would a nice approach to do this be if enough people just said, “I only do what I like”?

*LA (0:46:26)*: Yeah. I mean, you can do what you like, but you also have to succeed. You have to deliver something that people want to use. So you will probably do what you like but also make some compromises to make it usable and work on maybe converting some people into glowy eyes, or do things to make it more ergonomic to use, or whatever. So I think just doing whatever you like, it’s not enough.

*PA (0:47:03)*: Got it. On this note, if you’ll allow me to ask a little more personal question, but you finished your PhD, and then you became a professor at Chalmers, correct?

*LA (0:47:12)*: Well, at that point, the professor was something extremely rare at Chalmers. There was only one professor at the computer –

*PA (0:47:21)*: Oh, it’s another type. 

*LA (0:47:22)*: Yeah. It’s called a lecture. I mean, in the UK, I think it would be called a reader or something. Now all these people are called professors. Yes.

*PA (0:47:30)*: So my question is, after that, you decided to go to industry, and it seems like you never went really back to academia.

*LA (0:47:38)*: That’s basically true. I was back for maybe half a year in like 2005 or something.

*PA (0:47:49)*: So my question is, if you allow me to be a little more personal, what was behind your decision process? Is it just money? Were there other things?

*LA (0:47:59)*: I discovered that once you had your PhD, you’re supposed to become part of the people who get money to the department. You’re no longer the one spending them. So you need to write grant proposals and do this and that, and I really hated that. 

*PA (0:48:20)*: Okay. 

*LA (0:48:20)*: So I decided, “Nah, I’ll go somewhere else that I don’t have to write grant proposals. I can write code instead.”

*PA (0:48:31)*: It really strikes me. It reminds me a little bit of when I was talking with Conal Elliott. I feel that you guys have this thing in common where you’re not really in academia, even though you participate a lot, and you two said similar thing about pursuing your own taste, right? Like not giving in for your management style, doing stuff. You really believe on what you’re building, and I really appreciate that. I think that is really cool. But, okay, going back for a little bit, when you were talking about ALF, and later you also beat Cayenne, what is your thoughts about dependently typed languages?

*LA (0:49:13)*: I think they’re extremely cool, but I think they are even more niche than functional programming. I don’t think they will become widespread. I think they will be used in certain situations since you can make proofs in them, and you can have more assurances, you can use even more type system features to sort of enforce things. But I mean, look at Haskell. It’s not really anything in the world of programming languages. It’s just a small blip. And if you want to do the interesting things with dependently typed programming languages, then it’s even more sort of difficult to get it right than it is in Haskell. So I don’t really see it having a great future. I really hope it will, but I’m not sure. I’m very happy that there are people trying. And so, I mean, something that seems to have gained a lot of traction lately is Lean, which is really made for making proofs, but you can apparently program in it. You do programming in it, too. I haven’t tried it.

*PA (0:50:33)*: It’s a beautiful piece of C software initially, C, C++ software. Like Leo is a real hacker in C++, and they really invested in making it a fast programming language. It’s incredible. And now people are picking up with – so Terence Tao, the biggest mathematician, is writing his book.

*LA (0:50:55)*: It’s good that the mathematicians are picking it up because I think they need it, but it has to be at the level where they don’t have to do the tedious stuff anymore. 

*PA (0:51:06)*: Right. And it seems like Lean is doing a really good job with that, right? So that’s pretty cool. Yeah. I’m going to start heading towards the end. Well, is there anything interesting you could talk about Google or Facebook?

*LA (0:51:31)*: Yeah, I mean, I can – yes, I can. I didn’t really do much at Facebook because I quit almost immediately after being hired there. And then I had three months’ notice. I quit because I started working at X, which is the Google’s secret research lab, because they approached me and said, “Yeah, we’re using Haskell and Bluespec to design a chip,” and I thought, “Wow, okay. And here I am at Facebook doing OCaml. Let me out.” But I did do something at Facebook that made me depressed. So they have a lot of code in which it used to be PHP, but now they have their own dialect, Hack, that has a type system. And I mean, they’ve done a really good job. And I decided that I wanted to see how the dependencies were between. They have these modules in Hack, but you don’t have to say import to use a module. You can just use an identifier, and it just comes into scope magically. And to do this conversion from old PHP to Hack, to make that strict, you have to sort of start at the bottom, convert those to Hack, and then work your way up. So I wanted to know how was this module hierarchy. So I wrote a little program that sucked in all the modules and discovered the dependencies. And I was about half a million modules, so half a million files. And then I thought, “Okay, I will run a strongly connected components algorithm list to get sort of blobs of things.” And I discovered that about 250,000 of these modules was in one strongly connected component, which means that if you want to convert, you have to convert all those at the same time to get to the next level. So I sort of – yeah, I quit. 

Yes. So then I worked at this secret company X for a while, which is a really cool place to work. It’s not really a computer sciency place. They say they do things with atoms, not bits. 

*PA (0:54:03)*: Wow. 

*LA (054:04)*: And we were designing a chip. And so there’s all kinds of people there with PhDs in physics and chemistry and biology and what have you. And it’s fine to fail. Most projects fail. 

*PA (0:54:20)*: It’s more of a research about it.

*LA (0:54:22)*: Yes, but with the aim to actually produce something. 

*PA (0:54:25)*: Right.

*LA (0:54:25)*: So then you have a proposal. Here’s a crazy idea, like having, I don’t know, internet with balloons, Project Loon. I can talk about that because it became public. So we send up a lot of balloons, and they talk to each other with lasers, and then they have radios at the balloons, and you can cover things with internet. If you have enough balloons and Dan Piponi worked on figuring out if it would actually work, you have a lot of balloons, and if you have enough of them, they sort of just drift around in the wind, and yes, it would all work. But I mean, it never came to anything. They just decided in the end to not do it. But they did use it for a few sort of emergencies. I think there was one in Peru. They’ve lost sort of all communications. And so they sent up a balloon in Arizona or something, and it drifted around for a week. And then it was over Peru, and they could get some Wi-Fi connections. It was fun to watch these balloons that you can watch them when they had them. You’d watch them on Flightradar24 because they had a transponder. You could see. But someone had figured out that if we send it up here, it will probably eventually get to over there.

*PA (0:55:57)*: They have that in the routes of airplane? 

*LA (0:55:59)*: No, they’re higher up. 

*PA (0:56:01)*: Higher. Okay. Gotcha. Huh.

*LA (0:56:03)*: Yeah. So we worked on this chip. And then this thing that happens at X is once your project is good enough, you will sort of graduate. I mean, either it fails or you graduate, which means it turns into a separate company like Waymo, the self-driving cars. And then Google didn’t want to turn our project. It was called Positron. They didn’t want to turn that into a company. They said, “No, it’s too good. We’re keeping it for ourselves.” So we moved over to Google proper instead. And I mean, we had a chip, and the chip worked. Software was, of course, behind. And then the pandemic hit, and Google said, “Okay, we need to save money, so we’re canceling your project.” So they canceled us right when we were on the verge of being able to run some real things on it. Then, of course, it turned out that was the best year for Google ever. 

*FH (0:57:16)*: So what does this chip do? 

*LA (0:57:19)*: Matrix multiplication. 

*FH (0:57:21)*: Oh, okay. 

*LA (0:57:24)*: Yeah. That’s all you need to do. The tricky thing is to design it so that you have memories that can feed the matrix multiplication the whole time with very short latency. So it had sort of – it was a very regular architecture with lots of multipliers spread out, and they all had memories, and then you could program it in bizarre ways. It was very weird. 

The thing that made it unique compared to normal computers is that was completely synchronous. There were no sort of five force or uncertainties anywhere. You know exactly what it was going to do on every clock cycle. So you didn’t have to run your program to figure out how long it was going to take. The compiler knew exactly how many clock cycles it was going to take.

*FH (0:58:16)*: That’s what I’m going to say. Oh, wow.

*LA (0:58:17)*: That reminded me of when I was doing the Lazy ML compiler for the Cray computer, when the Cray computer was the fastest thing in the world. They had a time command, like in Unix. You say time, and it told you how many seconds, but it also told you how many clock cycles it took to execute the program. And every time you ran it, it took exactly the same number of clock cycles to run it because Seymour Cray didn’t believe in caches. He said that it’s sort of too uncertain what’s going to happen. So the machine was very sort of deterministic. Of course, it was time-shared, so you could be interrupted somewhere in the middle while running something else. But your program took the same number of clock cycles every time, which I thought was really cool. 

*FH (0:59:10)*: Something that I feel that we haven’t really covered in depth is that you have currently a very broad view of programming and compilation, low-level, high-level, dependently, all of this stuff. What was your first exposure to functional programming, or at that time, maybe a systematic view of programming, and what made you decide to go into this and not sort of come back out? 

*LA (0:59:35)*: Well, I told you my first exposure was the SASL thing in the denotational semantics course. I can tell you what my first exposure to programming was at all. The school I went to, they got a computer PDP-8, and I thought, “Yeah, I want to know more about programming.” So I went to the library, and I found a book called FORTRAN for Those Who Know ALGOL. And I mean, I didn’t know ALGOL, but it was the only programming book that they had at the moment. So I borrowed that book and sort of, “I don’t understand a word of this. This makes no sense to me whatsoever.” So when I went back to the library, they had a book about BASIC, and I thought, “Oh, I borrow that one. Yes, I can understand this.” And the computer that they had was also done in BASIC. So then I started programming, and then I realized this programming stuff, it’s really cool. I mean, you’re a God. You control it completely. 

*PA (1:00:37):*: How old you were? 

*LA (1:00:39)*: I was probably 17. 

*PA (1:00:42)*: Okay. 

*FH (1:00:43)*: Okay. And what led you from that to your first – I forgot the name of the language that you used.

*PA (1:00:52)*: SASL?

*FH (1:00:53)*: SASL. Yeah, exactly. 

*LA (1:00:54)*: Well, I used to have – I mean, I started my PhD to do some kind of parallel programming. That’s what I thought I would do. But then I just got fascinated by functional programming. I can’t really tell why. It resonated with me. And then I did my PhD on that, and then I just kept going. I’m sorry.

*PA (1:01:27)*: I think there’s nothing to be sorry. I think it’s beautiful because sometimes you don’t really have an aim, just follow your passions, your fun, right? And that led you nowadays to Verse. 

*FH (1:01:42)*: Yeah. 

*PA (1:01:43)*: And I wanted to talk a little bit about that because as we were talking before this started, I was watching Tim Sweeney’s interview at Lex Fridman, and I was very surprised by how much a CEO of such a big company, such a hacker, such a nerd, right? 

*LA (1:02:00)*: He is a total programming language nerd. 

*PA (1:02:03)*: Let’s talk about that a little bit, because I really see, after watching that interview, I see a lot of power in making functional programming very mainstream with Verse, because it’s going to be the next generation of gaming software that’s going to be written in functional programming with that, right? With Unreal 6, I believe. So tell us the story, how you got there, how things are going, how is developing things there, working with these people?

*LA (1:02:37)*: So as I said, they canceled our project at Google. So I didn’t know what I was supposed to do. I just sort of picked up my salary and did some fun things. And then Dan Piponi messaged me saying, “I’m going to start working for Epic. Maybe you should talk to Tim Sweeney. He’s an interesting guy.” And so I had a long Zoom call with Tim, and Tim knew about Cayenne, and we talked about dependent types, and we also didn’t do it.

*FH (1:03:17)*: This is crazy.

*LA (1:03:20)*: So Tim was following me on Twitter. And he was a very interesting guy to talk to, very smart, very knowledgeable. And I thought, “Yeah, I’m not doing anything sensible at Google. I’ll start working for Epic.” And Tim owns 51% of the company, so he can decide what to do. And if he thought this new programming language was a good idea, then – well, it doesn’t mean it’s a good idea, but it means it’s going to get done. And so he had been thinking about doing programming in some different ways in, I mean, the last 20, 25 years. He gave a talk, an invited keynote at POPL in like 2007 or ‘08 or something like that, where he – 

*PA (1:04:24)*: So it was a while ago. 

*LA (1:04:25)*: Yeah. It’s where he had sort of some early ideas and said, “Oh, functional programming was a cool thing, but you also need dependent types. Why do you need dependent types for arrays?” You need to sort of – you need to pass in, say, the length of the array as one argument and then array of that length. So that means you have a dependent type. The type of the array depends on the first argument. So that was his sort of idea of why you need dependent types. And then he also got interested in. You could use it for proofs and so on. And so we’d been tinkering with this for a long time. So he wrote an implementation or early implementation of Verse in Haskell, for instance. So it’s not like he doesn’t know Haskell. Oh, actually, I’ve seen his Haskell code. He doesn’t know Haskell.

*FH (1:05:22)*: Did he also cut that out of the podcast? 

*LA (1:05:28)*: No, no. I shouldn’t say he doesn’t know Haskell. He doesn’t know the Haskell libraries. I think he knows the language well enough, but he had sort of redone a lot of things that you can find in libraries. Yeah. So, Verse is not a pure functional language. It’s a functional logic language. 

*PA (1:05:50)*: What does that mean? 

*LA (1:05:52)*: Well, it’s like some of these other functional logic languages like Curry. So you have these existential variables. So variables that are – you sort of solve for what their values are rather than computing it. So it’s like prologue that you can – if you’re lucky, you can run your functions backwards. You can give it the output, and they will produce the input. So he wants to be able to do that if you want to, but he also wants to have all the functional stuff available.

*PA (1:06:34)*: Never seen both of those together. 

*LA (1:06:37)*: Yeah. So when I’d seen them, I’ve always dismissed it as being, you shouldn’t mix these pure logic languages. They’re beautiful. They’re sort of logic, and you do it that way or pure functions, that’s beautiful. You combine them, you get something weird. And I still think it’s a bit weird, but Verse is a very nice design. And I mean, I told Tim early on, when I worked at it, I said, “I’m not that enthusiastic about this. I’m not sure that this is the right thing.” And Tim said, “That’s okay. I have enough enthusiasm for everyone.” 

*PA (1:07:24)*: Wow. 

*LA (1:07:27)*: Yes. So the thing is that this Verse exists. This perfect verse exists in Tim’s head. He’s not the best person at explaining things. So we have been extracting things from his head and nailing down exactly what the semantics should be. And we’re still working on that. So the base is functions and logics. You have logical variables, and you have all the functional stuff, but then he has an interesting idea on how you do types. So it’s like independent types. You don’t distinguish between the level of types and the level of terms, but even less so in Verse. So types are perfectly ordinary functions. Well, they have to have certain properties. So Verse has this concept of failure. So a function can either produce a result or fail. So it’s like they’re all in the maybe mode. 

*PA (1:08:32)*: Right.

*LA (1:08:33)*: So that’s sort of built in. And what is a type? It’s something that either returns its argument or fails. So the int type, if you give it an int, it will return the int. If it’s not an int, it will fail, which means you can write new things that are types. You can write something that says, “Yeah, it’s the type of numbers between two and seven.” I mean, you just write the function that returns that or fails if it’s not between two and seven. So that means your types can be anything, which means that type checking is absolutely undecidable. I mean, that’s okay if it works in practice. We don’t know how well it works in practice. So the implementation of Verse that is sort of already in the UEFN, the Unreal Engine for Fortnite, that uses MLsub as the type checker. So that’s sort of just a subset of what you can actually do. So the thing that people can use is not the full language. We’re still working on the full language. 

*PA (1:09:52)*: And you want to nail down the exact semantics. 

*LA (1:09:54)*: You want to nail down the semantics, and then we want to have a type checker, but it’s not called the type checker. It’s called the verifier because it does more than verifying types. We want to have one that is good enough that it works in practice. I mean, it can never be perfect because then you would have to solve the whole thing problem.

*PA (1:10:16)*: Of course. Are we going to see this in POPL at some point?

*LA (1:10:20)*: Yes. I mean, there’s been one ICFP paper about a rewrite semantics for it. We’re doing denotational semantics, a very weird one. We hope to publish that when we’re done with that, and hopefully, something about the verifier. So Tim is very keen on us publishing papers. 

*PA (1:10:45)*: Yeah.

*LA (1:10:46)*: Yeah, yeah. He absolutely wants us to publish papers. 

*PA (1:10:52)*: I mean, he likes to put – 

*LA (1:10:55)*: He has gotten all his knowledge from reading papers. So I guess he’s sort of, “Yeah, that’s the way you disseminate things if you want people to understand what you’ve done.” He’s a really cool guy. I like him.

*PA (1:11:10)*: And how far away is it from becoming usable? You guys are working on it for a while, right? He has this idea since 2006. You’ve been hired since 2021.

*LA (1:11:23)*: Well, so there is this thing that you can already use that is a subset of the language. So the language has a lot of other features. I mean, you have assignments and things like that, and you have an effect system that tracks what kind of effects you’ve been using. There are objects that are a bit different from usual objects and modules, and there are all kinds of things. And a lot of that exists and can be used by people. I mean, it’s an extremely different programming experience because you write some Verse code, and you say, “I want to deploy this.” And you start your game, and you’re dropped into this world, and you can run up to the console in this world, and you can see the output of your program. But it’s used by a lot of people. People can use this and all the other assets. 

I mean, programming is only a small point of making a game. It’s also about assembling all kinds of assets, making it look pretty, and so on. People can make these things called islands that are sort of an extension to Fortnite. So you have Fortnite, the regular Fortnite that Epic makes, and then these little islands that people make. And you can jump to those and play whatever game they have made there. And I don’t know how many there are of these. 10,000, 100,000, there’s many, many. And Epic does revenue sharing. So you get paid depending on how much people are using your game. And so I think Epic has paid out $800 million to people making these islands so far. And for the first time ever, it was one of these islands was more popular than the actual Fortnite games. There were more players on one of these islands. And I hope that doesn’t happen too much because someone has to pay my salary. So if you’re playing Fortnite, thank you. Thank you. 

*PA (1:13:31)*: We are starting to run out of time. I don’t want to be a trouble for the next speaker, but I wanted to wrap up with some piece of wisdom for the next generation of programmers, functional programmers, researchers, Haskellers that you’ve gained throughout your careers that you would like to disseminate.

*LA (1:13:52)*: Do what you think is fun. I mean, you have to be a bit lucky to get a job where you can do what’s fun. But that’s my biggest piece always. You only live once. Make sure you have fun.

*PA (1:14:07)*: I love it. I love it. Any other final –

*FH (1:14:10)*: No, that was a great way to end this. 

*PA (1:14:14)*: So let’s thank Lennart. As we promised, I think we have five minutes left. We can do one or two questions, maybe real quick. Does anyone want to use this chance? 

*LA (1:14:35)*: No. Ah, we got one.

*FH (1:14:38)*: We got two. One sec. Wait, wait, wait.

*Audience 1 (1:14:41)*: So what happens if a Verse-type function returns not the original value? 

*LA (1:14:50)*: Then it’s not the type.

*A1 (1:14:53)*: But that’s not verified?

*LA (1:14:55)*: What?

*A1 (1:14:56)*: Is that verified that it’s –

*LA (1:15:00)*: Yes, if you have – there is a type of types, which is the function that takes things that claim to be functions and checks if they are. This can, of course, not be done at runtime, but the verifier will either say yes or it might say no. And most likely it will say, “I have no idea.”

*A1 (1:15:24)*: Okay. I was wondering if maybe it was acceptable if type function performed some kind of canonicalization of the values. 

*LA (1:15:37)*: Yes. So we haven’t quite decided what they should be called, but you could say something like abs. So they’re idempotent. You convert into something, and then if you apply the function again, you stay at the same spot, like abs would do. Or you say you convert from string to a number, and then if you try to do it again, you’re already a number. So you’re still a number. 

*Audience 2 (1:16:10)*: I’ve got two questions. One is that in Verse, in your example of the int type, which is just something that would return the number if it’s a number and return and fail otherwise, what is the type of dysfunction that you just described?

*LA (1:16:25)*: It has type type. I mean, everything has many types. There’s no uniqueness of types here, or just a type of one. Well, it’s one, the set that only – if we talk about sets, it’s a set that only contains one, but also the set that contains one and two. Or it’s the set of all natural numbers or all integers. I mean, so every – there’s no uniqueness of type.

*A2 (1:16:54)*: So like Lambda can be a constructor of type?

*LA (1:16:58)*: Yeah.

*A2 (1:16:59)*: And my other question was going to be, what is the logic programming part of Verse supposed to get you? Like, why is there such a strong emphasis? Why is everything starting from the idea of –

*LA (1:17:13)*: Ask Tim. 

*FH (1:17:13)*: Let’s get him next year. Yeah.

*PA (1:17:20)*: What strikes me is that then you can do unification, right? Like watch –

*LA (1:17:24)*: Like watch, oh yeah. 

*PA (1:17:24)*: It’s all auth unification. So you do.

*LA (1:17:26)*: So the design is very nice with what functions are. So in Haskell, the function definition typically looks like you have a function name, then you have a pattern, and then you have an expression. In Verse, you have a function name, and you have an expression, and then you have another expression. So there are no patterns, they’re expressions. 

*PA (1:17:51)*: It’s interesting, actually.

*LA (1:17:52)*: It works really nicely.

*PA (1:17:55)*: This might solve data types, actually, because data types are wonky. That’s why you translate things to combinators, right?

*LA (1:18:03)*: Well, I did that because it was cool.

*A2 (1:18:09)*: Like same idea that would benefit –

*LA (1:18:16)*: This is a language that Tim wants. Do the people who are making games want this? They have no choice. 

*PA (1:18:27)*: They will want it once it –

*LA (1:18:28)*: They will build it, and they’ll come.

*Audience 3 (1:18:32)*: Yeah. Hey, so you did a rewrite system, like an operational semantics for Verse, and now you just said you want to do denotational semantics. One of my favorite episodes in the podcast is the one with Conal Elliott, where he talks about denotational semantics obviously being the way to go operational semantics are these clunky things. I’m wondering if you have some thoughts there.

*LA (1:19:00)*: So the denotational semantics we’re making is for an ideal version of the language. There’s absolutely no way to sort of execute this denotational semantics. It’s purely mathematical. So it might be beautiful, but it also doesn’t tell you anything about how to run programs. So I think you need an operational semantics too, unless you happen to be lucky enough that the denotational semantics tells you how to run things, which usually happens with Conal things, but it doesn’t for us. So we have this thing that there are sort of three things. We have denotational semantics and operational semantics and the verifier. And the thing that we would need to prove at some point is that if the verifier says the program is okay, then the denotational and the operational semantics agree on what the value should be produced. If the verifier can’t verify it, well, we have no opinion on it. So there is a trivial verifier, the verifier that always says no to all your programs, but we would want one that is better than that.

*PA (1:20:15)*: All right. We are out of time. Do you want to keep going? 

*FH (1:20:20)*: No, that’s good. But I thought there was one person who wanted to ask a question from the beginning, but that’s good. It’s done. 

*PA (1:20:25)*: All right. So let’s thank the guest again.

*Narrator (1:20:37)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
