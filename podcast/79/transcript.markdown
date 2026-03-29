*Mike Sperber (0:00:15)*: So Matti and I sat down with Peter Thiemann. Peter is a professor at the University of Freiburg, and he was doing functional programming right when Haskell got started in the ‘90s. So naturally, we asked him about the early days of Haskell and how, from the start, Peter pushed the envelope on what you could do with Haskell’s type system, and specifically with the type classes, from early web programming to program generation to session types. Come with us on a trip down memory lane.

So Peter, how did you first get in contact with Haskell?

*Peter Thiemann (0:00:46)*: Oh, you got me scratching my head. So that was a long time ago. While we were kind of doing the pre-talk, I noticed that there is some history of the Haskell Workshop, and I believe I was in one of the first ones in 1995. So I guess by that time, I was already fluent in Haskell. And I still remember the first versions of the Glorious Haskell compiler, as it was called back then, where Simon and his team of two people—essentially, two extra people—which was Simon PJ and Simon Marlow, and then there was some guy who I never met in person, Will Partain, and he was doing all the dirty stuff. And so I was kind of using their bleeding-edge implementation. And so we were exposed to various things, like front ends written in Perl, and Simon Marlow being upset about that. And finally, he got around to rewriting it. So that must have been pretty much before 1995. 

I think by that time, also Gofer was around. So Gofer was Mark Jones’ playground for implementing his type class stuff before his way got implemented in Haskell. And so I guess at that point, many people switched to using Gofer and calling it Haskell and kind of secretly turning off the features before he got less adventurous, not to say tired, with maintaining the stuff and turning it into Hugs and kind of freezing it to do other things.

Back then, we saw the first versions of the Haskell standard floating around, and being annoyed because some guys were sitting together and changing Haskell—I don’t remember—from 1.something to 1.1 or something like that. At which point, we still had monad comprehensions, in case anybody on the net remembers that. So instead of do-notation, there was a point where there were monad comprehensions, which I think were proposed by Phil Wadler. And so they were just a comprehension notation with pretty much the same semantics that we have now in the do-notation.

So this was for some time. I think it was 1.3, but it beats me. In any case, this version of the language was pretty annoying. I think everybody was annoyed with it because everybody was using list comprehensions back then. And when you were teaching it to beginners, you would show off list comprehension and show the one-line implementation of Quicksort and say, “Ah, isn’t that cool?” And then when the students started to play with it and wrote it by themselves, they got these ugly monad comprehension errors because the overloading couldn’t be resolved. I mean, essentially, if you had a couple of programs, back then, there wasn’t a huge code base. But anyway, with each change of the language, you would have to port all your stuff. Well, I’m not sure if that ended, but anyway, the recycles got much more, maybe not modest but less intrusive as they were back then.

*MS (0:04:34)*: I mean, you mentioned Gofer, but I remember that back then, in the early days of Haskell, there were actually more Haskell implementations than just GHC that we played around with.

*PT (0:04:45)*: Yeah. I mean, before that, there was Lazy ML, which was the system developed by Lennart Augustsson and Thomas Johnsson. Yeah, and that also had a Haskell front-end, essentially. Essentially, when you were using – what was it called? Chalmers Haskell, right? That was the name?

*Matthías Páll Gissurarson (0:05:07)*: Yeah.

*PT (0:05:08)*: Yeah. So when you’re using that, you had – I think it was even a C program that would translate the Haskell syntax into Lazy ML, and then you would run the Lazy ML compiler, and you would have your code. So yeah, that was around. There was also Paul Hudak’s system, and I have to admit, shamefully, that I never played with that system. I guess mostly because the back-end was some Scheme or Lisp dialect. I think it was T, right? T?

*MS (0:05:41)*: Yeah. I think it was basically a continuation of Yale’s T project, which had been a Scheme compiler, but I think the actual Yale Haskell then ran on top of Common Lisp. But I remember everything was kind of annoying to install, right? Except for Gofer, which is why a lot of people used Gofer.

*PT (0:06:01)*: Yeah. I mean, the thing with Gofer was that it would actually fit on a PC, right? I mean, on an IBM PC. Try that with GHC. Okay. No way. Absolutely no way.

*MPG (0:06:16)*: Right. But then I have to ask, how did people learn about Haskell in ‘95? Did you bump into someone at a conference, or was there a newsletter? Like, how did it work?

*PT (0:06:28)*: On the internet, of course. No, I mean, there was something. Well, the Usenet, right? So there were newsgroups like comp.lang.functional, and you would be subscribed to various email lists. And that’s the way that you would get information. I mean, back then, our university was kind of barely connected to the internet.

*MS (0:06:53)*: Yeah. We had a 64k line for the entire computer science department.

*PT (0:06:57)*: Yeah. And I think, I don’t know if Mike was still around, but at some point—this was probably a few years earlier—we had to move into a new building. And as Mike was saying, this building was connected to the main computer science – well, actually, to the main sciences building, where the computing center maintained some sort of hub by a 64k-bit line, which nobody can understand today anymore. So basically we had to rely on emails and Usenet. So, I mean, big downloads? No way. It was absolutely not possible.

And when we moved into that building, the building didn’t have any networking. So we were actually crawling around and installing Ethernet cables by ourselves. So it’s that long. I think that was before Mike’s time, as far as I remember.

*MS (0:07:56)*: Well, I mean, I was definitely there for the 64k uplink.

*PT (0:08:00)*: Yeah, yeah. That was there for quite a while.

*MS (0:08:02)*: I certainly laid some cable as well.

*PT (0:08:03)*: You would get your information, right? But you couldn’t just click a PDF. I mean, there was no PDF at that point, right? So you had some people – I mean, some oldish people still have DVI files on their web pages, which were maybe an issue back then because, I mean, they were small. But the downside, of course, of DVI files is that it’s not portable. So maybe if you got it, they had used fonts that you’d never heard of. And so you had to kind of get your fonts. And I mean, there was FTP, in case you still know about FTP.

*MS (0:08:39)*: I mean, for the Generation Z among the listeners, right? This was before the web, as Matti implied. So they were mailing this as Usenet. And usually, when you would have a download, you wouldn’t click on a link, but instead, you would go to some FTP server and type arcane commands to download your stuff. Or you would go on Usenet, where things were posted in parts and chunks that you had to then reassemble. 

*PT (0:09:07)*: Today, a good approximation would be Reddit. Only that Reddit is centralized, but essentially, it’s a discussion forum where you can bring up new topics and so on. But it’s all offline. Overnight, the system would download a slew of new messages, and you could configure which messages would actually be downloaded. So you would kind of subscribe to a bunch of newsgroups, because otherwise, it would just be too much. And then at night, there was some scheduled connection where everything would be downloaded. Your responses would be uploaded. That wasn’t synchronous either. So everything you typed over the day, some time at night it would be sent, and it wouldn’t even be sent directly to the main hub, but it would be sent around in several hubs. So you had to do the routing. I mean, as the administrator of this, and I had to be the administrator because nobody else was there to do it, and the computing center couldn’t be bothered about it. Maybe they didn’t even want the data volume there. I don’t know. I didn’t have to ask, right? That’s the positive side. 

Today, immediately, someone would stand on your feet and say, “Oh, security, you’re not allowed to kind of suck so much data over the net.” Nobody cared about that. I mean, 64k was a natural limit anyway, but you had a lot of degrees of freedom, like speaking to any sort of web service with Telnet, I mean, manually, which is absolutely impossible by now, right? I mean, every SMTP server would just say, “Goodbye, I don’t know you.” But back then, you could do all those things, and you could just create your own server, connect it, and you would be in business for anything—for email, for news, for whatever you wanted.

But we’re not talking about Haskell, right?

*MPG (0:11:07)*: We’re setting the scene. You didn’t just go on Twitter, and some people said, “Use Haskell.” You had to really get the information yourself, right?

*PT (0:11:16)*: Yeah. Well, I mean, as Mike was saying, in my own study, I was exposed to this language called Hope, which is an offspring from Imperial College. And the nice thing back then was that this was actually an implementation of a lazy functional language, and it was a short C program written by – oh, it beats me. What’s the guy’s name? Ross Paterson, I think. He’s written even papers with Conor, in case –

*MS (0:11:50)*: I seem to remember it was Rod Burstall and –

*PT (0:11:54)*: So they designed the language. That’s Burstall and MacQueen. They designed Hope. 

*MS (0:11:58)*: Yeah.

*PT (0:11:58)*: But I’m not sure. I haven’t seen any other implementation than the one by Ross Paterson, who hacked it as a C program. 

*MS (0:12:06)*: Oh, okay.

*PT (0:12:06)*: The nice stuff was – well, it was a C program. I mean, different from today, you had to download the source, and you had to get it to compile on your own machine. And back then, we didn’t even have all PCs and all x86s, which didn’t exist. Well, I think it existed. I think we had like 386 machines, but we also had a weird machine, I would say, that my former boss had got as a gift or something like that from the company who sold it because he was writing a compiler for this machine. So he got this. So it was a Unix box. It was as large as a stack of washers. And for today’s ideas, it had limited capacity. You could run ML on that. But that was the outcome of a diploma thesis. I mean, today it would be a master’s thesis that actually a friend of mine had written as his final thesis project. 

So that was essentially the state of things. So we had an ML implementation that ran on this machine, and we had this – well, you could download the C program for this Hope, and that was it, essentially. And then on the newsgroups, you thought, “Oh yeah, there’s people, there’s this stuff, Gofer by Mark. There is the Glorious Haskell compiler.” And then of course, you start to investigate. Somehow, at some point, you get the sources because back then that was the only way. I mean, they compiled to C, so you had to download the whole stuff, no binaries. And then you had to try your luck and compile the C, do the bootstrapping, and then carry on. So you had to do the whole stuff all the time.

*MPG (0:14:05)*: Mm-hmm. Because people complain today about how hard it is to build Haskell programs. I think it’s a lot easier than it was back in the day, right?

*PT (0:14:15)*: Yeah, but it’s – well, I mean, now we have a lot of infrastructure on top, right? Now you have package managers. I think fighting with cabal is no easier than fighting with the C compiler and running autoconfigure for the 50th time until everything is configured.

*MPG (0:14:34)*: Right.

*PT (0:14:35)*: I don’t think it’s gotten easier.

*MS (0:14:37)*: Yeah. And so, of course, back then, we weren’t really looking at Haskell as a language for building commercial products or anything like that, right? So, I mean, that was the charm of Hope. Not just of Hope, which was just written in C, but also of Gofer. So getting a bunch of C files to compile that was doable, and then you would get an interactive system. It wasn’t particularly fast, but it was workable for things like teaching. 

*PT (0:15:05)*: You had something that was lazy, right? So you had a full lazy functional programming language where you had all these fancy things of type classes, and in Mark’s system, you had these multi-parameter type classes that were essentially experimental back then. So it was a huge place to experiment with cool ideas. And it was all in flux, as I was saying. So the Glasgow people were always hacking things and changing things, but there was some committee. I’m not sure if it already called themselves the Haskell committee, but there was a committee, but it was like the same experts that did the initial design, and they were there for a couple of iterations until, I think, much later. I don’t know the history. I don’t remember when exactly, when this Haskell – what is it? Consortium or whatever it’s called now?

*MPG (0:15:59)*: Foundation. Yeah.

*PT (0:16:00)*: Yeah. When that was installed. And now you have this kind of structure in place that rules over the language, and people have to follow up.

*MPG (0:16:11)*: Right. But, you know, once you got Haskell working, what were you doing with it?

*PT (0:16:17)*: Well, that’s why I looked at the Haskell Workshop paper. So back then, I was actually experimenting with these imperative extensions that later became this encapsulated state monad. So there’s this famous paper by Launchbury and Peyton Jones where they proposed this rank-2 type in order to encapsulate local state in the state monad. So this was kind of the cool thing back then. So everybody was playing with that. And so that’s the kind of thing that I was interested in back then.

And somewhat later, when monads were mainstream, I don’t remember if that was written with monads already. I remember my first Haskell programs, I had to use a different style of IO.

*MS (0:17:12)*: It was stream-based, right? In the early days?

*PT (0:17:14)*: There was stream-based IO, and there was continuation-based IO, which could all be subsumed by the monadic IO. But I think I still – yeah, I still wrote programs before monadic IO and then later on ported it because it was just a pain in the neck to use this stream-based IO. Yeah, I’m not sure. Is that still common knowledge, how that worked, or is that something that you want to discuss?

*MPG (0:17:44)*: Yeah. Like the legend lives on. People say, “Oh, we used lists before, but now it’s all monads.” But at this point, it’s like 30 years ago.

*PT (0:17:52)*: Even longer. I don’t remember. There was some paper where somebody investigated how to do IO in a lazy language without breaking purity and stuff. And so the idea was essentially that your operating system was accepting a stream of requests and would answer with a stream of responses. So that’s a nice idea. And the devious thing is that the two have to be kept in sync. And so if you use that in your programming, then you have to be super careful to stay in sync, and you also have to be super careful not to inadvertently pattern match on your response before you even send the request, because then you would be deadlocked immediately. So it was really, really fragile to program with that interface.

*MS (0:18:44)*: And it was very limited, right? Because essentially, your program had only standard in and standard out. And then to extend that to files was difficult. And from then on, it all tended to be a bunch of hacks, right?

*PT (0:18:56)*: Well, I mean, you could do files. I mean, you just had an algebraic data type that contains all the requests, and then you would just push the request for reading a file. You would push that on this list that goes to the operating system, and you would get back a response on which you had to pattern match, and then you get your file contents. I mean, nobody would speak about reading single characters or writing them. That was a no-go because –

*MS (0:19:24)*: Yeah. I mean, it was okay as long as it was mostly about the contents of the file, right? 

*PT (0:19:29)*: Yeah.

*MS (0:19:30)*: But as your programs get larger, it’s not just about the contents of individual files. It’s about sort of the structure of your IO. 

*PT (0:19:39)*: I mean, the structure would be very rotten because you would always have to handle this pair of request and response streams. And wherever you wanted to do IO, you would have to somehow supply these two lists, right? 

*MS (0:19:53)*: Yeah. And so I think everybody who was using Haskell was conscious of the fact that IO remains sort of an unsolved problem. And so when the monads came out, and then the idea for monadic IO came out, I distinctly remember, Peter, that we were sitting in an office, and we were, I think, looking at Phil Wadler’s paper. And I think we very quickly realized this is going to do the job, and this is going to be big. But until then, things were unsolved, right? And there was this distinct epochal change, I guess, in that things were sort of stream-based before, and people were doing stream-based UI toolkits also. I think the Fudgets toolkit still lives on, right? Which also deals well with sort of simple input-output relationships but deals less well with your IO composition changes. And so the monads kind of did away with – I mean, we thought it would do away with all the problems, but it took a long time to then realize what the problems were that they brought in. But back in the day, we were just in heaven that we could finally do these things in lazy functional languages, and it opened the door to thinking about maybe doing more real-world projects in Haskell.

*PT (0:21:12)*: Yeah. And that paper, that was ‘94, I think, right? So that’s the Imperative Functional Programming by Simon PJ and Phil Wadler.

*MS (0:21:19)*: Yeah. Yeah.

*PT (0:21:20)*: I mean, it was truly a revelation, right? And then everybody was reading the other papers by Phil about monads, and everybody was saying, “Oh, the M thing.”

*MS (0:21:32)*: Yeah. There was this really cursed phase when everybody was, “Don’t say the M word,” because it’s going to put off people from getting into Haskell because they don’t like the monad word. Of course, that –

*PT (0:21:43)*: I mean, don’t say that it’s from category theory. So that was really, really bad. But I think this has changed a lot. Now we know that category theory is a useful source of abstractions that we can use in programming.

*MS (0:21:58)*: I mean, looking back, it seems that it took us a long time to then figure out how to use monads properly. But back then, we thought, “Oh, problem solved.”

*PT (0:22:06)*: I guess you don’t want to discuss effects now, right?

*MS (0:22:09)*: Of course, we can always discuss effects, right? I mean, it was – I mean, the monads came out, right? There was this obvious issue of modularity, right? I remember Mark Jones’s paper on monad transformers came out. Then we kind of thought that (a) it’s pretty complicated, but (b) we thought it would solve the problem of modularity. And it, again, took a long time to realize that maybe it’s not the best solution to the problem.

*MPG (0:22:38)*: Haskell is a – we have a lot of these phases, you know? Something new comes along, and we’re like, “Ah, now we’ve solved programming,” right? And then we’re like, “Oh, wait, this is not – there’s stuff to do.” Yeah.

*MS (0:22:52)*: So, I mean, you mentioned teaching, of course, but then you also got into trying to do practical things with Haskell, right? So I remember you got into web – I mean, we should mention that Peter was actually the person who installed the first web server for the Department of Computer Science at the University of Tübingen, coming out of that story that you told earlier, right? And so it was only natural you would try to get into web programming with Haskell. What was that like in the beginning?

*PT (0:23:19)*: Back then, web programming would mean so-called CGI scripts. So you would have some executable stuff that you would put in a certain directory, and then this executable stuff would somehow magically obtain the input from POST requests that were sent to the web server, and you would have to produce the output in exactly the right format. So, I mean, you would output some web pages from your program. And my God, that was crappy to do it. I mean, not to speak of people who do it with PHP. I mean, that was around the time when PHP was also kind of – this is even crappier. I mean, nothing can be crappier than PHP. But anyway, I mean, PHP uses the same pattern, right? So it’s just kind of shrink-wrapped into the language.

And so, how did I get to web programming, to have web programming in Haskell? That’s also a bit funny, because I don’t remember where. So I was on this workshop or seminar, and on the day I arrived – I mean, when you travel somewhere, you’re always, like, hungry when you arrive. So I went out to some sort of pizza place, and while I was ordering, John Hughes entered in the same mood, like, “Oh, I’m hungry. Let’s get some food,” and so on. And so when we were eating, he told me about his latest invention, and that was arrows. And he was completely enthusiastic about it, and he told me, “Ah, with arrows – so I invented arrows because there’s this problem when you want to do web programming in Haskell, and it doesn’t work because –” I don’t remember what exactly his argument was. And it felt like this was the right thing. Later on, he showed that there were also other super fancy uses for arrows. But one of the motivating examples was actually web programming. And he said, “Ah, you can’t really do that with a monad.” But I forget what his argument was.

I found that cool, but he didn’t have an implementation around. I think he had one on his own computer, but I should maybe check when that was. It must have been around 2002. And back then, there were no artifacts, so you couldn’t just download and play with it. So I was kind of sitting down and trying it on myself. And after a while, I realized, “Oh, I can get by with monads, right?” So I can get by with monads. And so I was sitting down and designing this kind of tricky monad that would allow you to – well, before I can describe that, I have to start a little bit earlier in this CGI world. So the trouble of this CGI world is that the protocol you’re using, or you were using back then on the web, HTTP, is really stateless, which means you just have one-off messages. You send a GET or a POST request, and you receive a response. And then for the web server, you more or less died. And if you connect again, everything starts from scratch. 

So if you were talking PHP or other languages like Perl or something, where people were implementing this kind of thing with, they would kind of create tokens and would store a state for a particular session token on their local computer. So this is not a design that you would want for a Haskell program because, well, everything should be nice and functional. And moreover, you don’t want other people’s state stored on your computer because, well, that would be a nice denial-of-service attack if you were kind of dumping stuff on somebody else’s computer.

So my idea was, why don’t I keep that single-shot and purely functional and just store the whole history of the interaction in my response? So on the first request, it would recognize, “Oh, this is a first-time person.” So this thing, it was called WASH. Actually, in the response, it would store the sequence of interactions that had already been processed up to there. So that when you get the next request from the same sender, it would send the history plus the next request. And then the Haskell program would kind of interpret the history again, get in your application to the exact place where you sent off the request, and then it would process the next input. And then it would kind of produce the web page, and in a hidden field of the web page, it would store the kind of extended history. And this is stuff you can easily fit into a monad because, well, it’s just a state monad with some extra cleverness. And so that’s essentially the idea behind this system.

So once I had that, I used it for various things. At some point, we had a submission system for lectures where the students would submit their exercises with that script. Of course, you run into the bad concurrency demon because, at that point, I mean, PDF submissions, you didn’t really want to store in this history anymore. So you had to have some way of storing stuff on your local file system. And at one or two occasions, I even used it as a submission system for workshops. 

Basically, it was okay up to the moment where some person decided they would dump a PDF into a text field. I don’t know. I mean, I had proper support for uploading, for upload buttons, but somebody decided, “Well, I need to paste my whole PDF file into this text field.” So basically that worked, but what broke was my implementation of reading that file, because what I was basically doing – so the response was read into some record type in Haskell, and then I would just show the record and store it on a file. Because then, when I read it back, well, you just read it, and you have your record back. Cool, nice. I don’t have to worry about parsing. I mean, this was before the times of JSON. Today, you would probably do it like that. 

Everything was neat up to that point, because the string encoding of this PDF file was so big that read would crash. Because back then, the read implementation was kind of lazy, and it was non-deterministic in particular. And after a certain point, you had stack overflow, and it would just crash. So that was pretty annoying because every submission afterward for it would have to read this stuff in, and it would crash. So no further submissions were accepted just because this one nice person had dumped the PDF into the text field. I think now this has been fixed, I mean, for a long time, because Koen Claessen had come up at some point later, unfortunately later than my experience, with a better version of the read parser, which doesn’t have this stack space issue anymore. Well, at that point, I was pretty much, I guess, implementing everything, my day-to-day stuff, in Haskell, and I actually had the necessity to write web applications on a regular basis. 

*MS (0:32:06)*: So, speaking of all that web stuff, you also had a few papers on sort of doing type-safe HTML and XML. How did that work? Do you still remember?

*PT (0:32:16)*: Oh yeah, that’s also part – oh, that’s also an interesting story about that. So that’s also part of this WASH system. I mean, there’s nothing really special about it. I mean, at least speaking from today, essentially, you have an untyped interface. Well, some untyped representation for HTML with text nodes and tree nodes and attribute nodes and whatnot. And on top of that, you had some multi-parameter type-class magic that was using phantom types in order to enforce the content model. And back then, I didn’t really follow the evolution of HTML after that so much. But back then, some content models, for example, for tables, they were like little finite machines. So essentially, in the type system, if you wanted to only generate correct tables or generally correct HTML, you would have to run this finite state machine in your type checker. But all that is nice. 

And I wrote a little compiler that would read the DTD. So this is the Document Type Description for HTML. And it would output a huge file with lots of instance declarations for my type classes and for the data types that are involved. So for each tag, you would have to have a data type that is just there to encode the tag, and so on. So I had a huge list of single-element data types for each HTML tag. And then each of them were instance of something, and you would have another multi-parameter type class that encoded the transition function of the state machine. And at some point, I realized that the compile time of this file, with these hundreds of instances in it, was exceedingly slow. So every other file would just run very quickly, but on this file, GHC would sit for minutes. I think tens of minutes, even. And I’m not sure how it went, but at some point, somebody of the GHC crew noticed that, well, there is this issue of this file with lots of instances. And it turned out that they had a quadratic algorithm to search the instances and to insert the instances into their compiler data structure. I’m not sure if they fixed that for me, but essentially, it was fixed at some point, because in later editions, it would just run through fairly quickly.

*MS (0:35:12)*: So this essentially used the type class resolution algorithm, or the type classes as a programming language, right?

*PT (0:35:19)*: Yes. Yeah. Only as a state machine, right?

*MS (0:35:21)*: Well, I think we take that for granted now, but we should remember that in the early days, type classes were intended just as an overloading mechanism, right? And so the culture of using type classes has changed radically since then, right? In the early days, people were just using, like, the same function name for sort of related functions on different types. And papers were full of that, of just introducing type classes for that purpose. This idea that you could use it as a programming language, I think you were one of the first to have it and then to put that into motion.

*PT (0:35:57)*: I mean, one instance was also the paper with Matthias, the one, I think it was called Session Type with Class. That was also fun because there we also used multi-parameter type classes in order to encode session types, which is, I mean, you’re describing essentially bidirectional sequential protocols. And our showcase was essentially that we had modeled a small subset of SMTP. I mean, we thought it was pretty fun back then, but it turned out to be more than that because it’s a paper that, for some reason, pretty much everybody who implements session types also references that paper, even though it was more or less just a journal and just a workshop paper, if I recall correctly. 

And now, okay, since we’re now talking about publications, this web system WASH that we were just discussing previously, I think that was also published at a workshop because ICFP didn’t want that. So they didn’t want to publish that. And the workshop paper that’s around is pretty much the same that was submitted to ICFP before, and there’s also a journal paper about it. So I don’t know what that says about me or about ICFP, but anyway.

*MPG (0:37:40)*: Right. But I think at the Haskell Workshop, there’s been a lot of very good papers at the Haskell Workshop. I feel like it’s more than just a workshop in this community, at least, right? 

*PT (0:37:59)*: Hmm. I would say it has changed over time.

*MPG (0:38:04)*: Yeah.

*PT (0:38:05)*: So initially, people were kind of talking about crazy ideas there. And some people, like Mark Jones, would use the Haskell Workshop as a sounding board, and they would present some really cool stuff. And then a year later, it would appear in POPL, for example, or at ICFP. Did it exist then? Yeah, ‘95. Yeah. And then, I mean, it expanded, and it became two days, and it became Haskell Symposium, and so on. But what can I say? So the last few times that I attended the Haskell Symposium, I wasn’t that pleased, I have to say. I mean, this is just my personal impression. Maybe my own focus has changed. It just didn’t feel so adventurous and interesting to me than it was in the beginning.

*MPG (0:39:12)*: Right. And I think, I mean, this has been discussed before, but it’s also just that Haskell has changed as a platform, right? It used to be very adventurous, and then people started doing more concrete things with it. As a language grows older, people move on with their crazy ideas to other languages, right? Because now we have like Agda, and we have Idris, and we have all these kinds of languages that were built on the ideas that kind of Haskell molded in its time. And that’s why the Symposium is now kind of, you know? It’s not the same Symposium as it was, because people are just focusing on other things, right? They’re not like, “Oh, let me show you how I can do this crazy session types and type classes,” right? Yeah.

*MS (0:40:08)*: I think there’s still plenty of craziness left, but I want to continue a little bit with that theme of using the type classes for programming, right? So, I seem to remember this was not your first paper that was called Hahaha with Class. So, in your bibliography, I see one on Program Generation with Class as well, right? I don’t know if you remember that one. 

*PT (0:40:31)*: Yeah. I mean, that comes from a time where Mike and I were interested in partial evaluation. We were looking at this particular flavor of partial evaluation, which was called offline. I guess nobody cares about that today anymore. But essentially, the idea was that before you run your program, you would know that some parts of the inputs are available early, like at compile time, and others are available late. And this knowledge you would propagate throughout your program in a program analysis, and then annotate everything as either available at compile time or available only at runtime. And then the idea is that you would run this program at compile time on the available data and just get a specialized program that you can then later on run again. 

And the tricky thing where the type class modeling comes into it, maybe I’m confusing things now, but one issue was that you wanted this binding-time decoration to be polymorphic. So you would want to be able to use certain parts of your program at compile time and also at runtime. I mean, as you would want it for polymorphism. And then it gets a bit difficult to model that because for such a binding-time analysis or binding-time annotation to be sound, you need to ensure that generated code does not contain bits that should be executed at compile time. So you can only go one direction, but not the other direction. And that was kind of encoded again using type classes and various things so that you could just run the program, and you would be able to run some parts at compile time and also generate code for that later on. But all that fits neatly into this type class framework. 

So I have to admit, I think to finally get this Program Generation with Class to work, I think I had to recruit Martin Sulzmann for that. So I mean, he’s also a type class and multi-parameter type class expert, and he helped me in various ways to get that going.

*MS (0:43:13)*: I mean, subsequently, there was Mark Jones’s work on introducing functional dependencies into the type class system, which was also basically, I think, the beginnings of this idea of having a programmable type class resolution. You ran with that as well, right? Do you remember that?

*PT (0:43:32)*: Yeah, I remember that. You were part of that. So you know that.

*MS (0:43:35)*: We got you to talk about it. 

*PT (0:43:38)*: Yeah. So we were playing with ideas which are similar to what you have now in type families, like type families in Haskell. So essentially, we wanted to have functions at the type level, and we wanted to have means of programming them and indexing data types with that. I mean, all that is now available in some form in these dependently typed extensions and type families, and so on. And we were playing with an early version of that. Unfortunately, our approach didn’t win, although we put an awful lot of work into that. But we didn’t implement it in GHC, so that was the killer. And also, other people were implementing associated classes and all that, which is admittedly a more general way of doing things than we did. But we had a different semantics, if I recall that correctly. 

*MS (0:44:40)*: Well, I mean, the type class resolution is essentially a logic programming language.

*PT (0:44:46)*: Well, a functional logic language, if you have functions.

*MS (0:44:47)*: Yeah. And so our idea was to then – since, of course, as functional programmers, you want to use functional programming to program not just your program but also the type system. We also wanted to introduce functional programming there. But of course, generally type inference and type checking and the unification that’s part of it and all of that, these are all facets of logic programming, right? And so that’s why you had this idea of, “Well, why don’t we just use a known paradigm for fusing functional logic programming at the type level?” And I still think that was a cool idea. I still sometimes think that this idea of having functional programming there for type families but then have logic programming for the type class resolution kind of didn’t quite fit in Haskell.

*PT (0:45:41)*: Apparently, this idea is en vogue. Again, if you think of the Verse language there, it’s also a mixture of functions and some logic bits and some functional logic bits. Yeah. And it’s also using residuation or something like that, which was kind of the same mechanism. So residuation is a strategy to evaluate functional languages with logical components or functional logic languages. So, either you do residuation, which means if you have a logical variable, then you just wait until it gets instantiated by unification. So you just hang there. 

And the other way that people have done is called narrowing, where essentially, if you get stuck on a variable, then you try to instantiate it in ways so you can reduce. So you look at your reduction rules, and you try to unify your reduction rules with a logical variable. And then you just try all possible outcomes. And of course, that gives you non-deterministic semantics because you may have to backtrack, as you have in logic programs. Whereas we found back then that this was not appropriate on the type level. And so we thought residuation is preferable because you don’t need backtracking. So if you don’t know what it is, well, then your type-level function just gets stuck until you can instantiate the variable. And then you know what it has to be, and then you can continue reducing on the type level.

*MPG (0:47:23)*: I think because GHC now has this whole type checker plugin system, right? Where it’s just running the constraint solver, which is just running your logic program, right? And then you can kind of dive in at some point and solve your own constraints. But I think people really want to be able to customize how the type checker works because they want to do more interesting stuff than what’s currently acceptable, let’s say, to be in mainline GHC.

*PT (0:47:58)*: Yeah, I mean, we were always concerned, like, “Oh, if you have a type checker and type inference, then it all has to be decidable.” But I mean, this has been more or less abandoned, right? I mean, unless you use GHC with completely restrictive settings. But I think nobody in practice is using that now. Every recently written program starts with this line of options, where you turn on everything. And essentially, for most programs, the type checking and type inference is probably undecidable. But I mean, for those programs, it just works, right? And it still guarantees soundness. So that seems to be the thing that people are – well, people want stuff to be as expressive as possible. And if it guarantees soundness, then that’s good enough. It doesn’t have to be complete. 

I mean, back in the days, that was kind of the thing about ML type inference. It sounds okay, but it’s also complete, right? So whatever is typable, you can also find with your algorithm. And that doesn’t seem to be so important anymore now because apparently, people are much more willing today to write intricate type signatures. And back in the early days of ML, the point of inference was, well, you wanted to infer it, right? So people were not really willing to write type declarations so much. Now, this seems to have been reversed, at least among the people that I usually talk to. I see Mike smiling, and he’s thinking of –

*MS (0:49:37)*: Well, I mean, lots of the old papers, right? It’s conspicuous in that the papers don’t list the type signatures of the functions that are in the papers, right? Because everybody thought, “Well, there’s type inference. Why would you write it down?” The compiler can figure it out.

*PT (0:49:51)*: Our students would fail their courses if they don’t write type signatures, right? Yeah. And even in Haskell, I think it’s considered good style to write type signatures for your top-level functions, right? If you also write Agda code, for example, then it’s imperative that you write type signatures because otherwise it just won’t work. 

So I still remember when I met Phil Wadler at some seminar, and that must have been in the ’90s as well. And I was trying to explain him some idea, maybe even the WASH idea. And I tried to explain it in a similar style than I explained to you guys a few minutes back, but he wouldn’t listen. He would say, “Come on, tell me the types. Tell me the types that are there.” And I said, “Come on, I can tell you how it works, but I would have to find out what the types are.” But he was kind of – even then, he was already adamant, saying, “Well, you have to kind of think about the types first, right?” even though they were much less expressive than they would be in Agda.

*MPG (0:51:11)*: That’s because now people talk about this System FC and whatever. It’s really like System FGHC. It’s like whatever extensions you have enabled at that point. And I think the theory is people like to have it simple in the papers, right? And then if your main goal is to write a paper, that’s important, right? But if you want to make something work, then you just say, GHC suggests, “Did you perhaps intend to enable blah, blah?” and you just say “Yes,” and then your type goes, and you don’t know why, right? You should look into it, but people just accept the suggestion. 

*MS (0:51:47)*: Someday.

*MPG (0:51:49)*: They've been web coding with GHC extensions for years, you know? Yeah.

*PT (0:51:56)*: Yeah. In a way. Yes. Yeah.

*MS (0:51:58)*: So, looking through your bibliography, it’s kind of shocking that at some point JavaScript shows up, right?

*PT (0:52:03)*: Uh-huh. Why is that shocking?

*MS (0:52:07)*: Well, given all that statically typed work that you did earlier.

*PT (0:52:10)*: But the first paper on JavaScript that I wrote proposed a type system for JavaScript.

*MS (0:52:15)*: Aha. Okay.

*PT (0:52:17)*: And then I don’t think I’ve done any untyped JavaScript paper. So the first paper proposed the type system. And it was really the first paper on a type system for JavaScript. So that was kind of nice for me. And it also paved the way for a collaboration with Anders Møller, who is not so much interested in type systems, but he was interested in static analysis. And his idea was to kind of use the structure of the type system to define abstract domains for an abstract-interpretation-based system, where you could analyze arbitrary JavaScript code. And that kept the two of us busy for like two or three years, but he has kind of pushed it much, much further. And so that’s a system that’s called TAJS, T-A-J-S, which he’s still maintaining, and it’s still available on the net. So unfortunately, it’s written in Java. So it’s a bit of a – well, it’s Java, right? So I think the design is really good, but I don’t like writing Java programs anymore. So let’s put it –

*MPG (0:53:39)*: Right. It’s either Haskell or JavaScript. There’s nothing in between. 

*PT (0:53:43)*: Well, I’m not sure if I wrote so much JavaScript code. So recently, I mean, I still have a project where we’re trying to tease some typing information out of JavaScript. But that’s pretty – how should I say that? I mean, the nice thing about Haskell by now is that it’s reasonably stable. And if you write tools, you have the GHC API, where you can just run the parser, run the type checker, and do whatnot. And when we were starting on this JavaScript business, the JavaScript language was evolving in a very fast-paced way. So the tool that you wrote this year wouldn’t work in the next year because this year you did it for ES4, then you had ES5, you had ES6. Suddenly there were classes, suddenly there was blah, blah, blah, and strict mode. And there’s so many very, very intricate things, and they have changed stuff. So you didn’t – at some point, I felt like I didn’t really want to follow this slew of version changes and maintain this kind of complicated analysis infrastructure over time. 

Yeah, well, I mean, Anders was more adventurous, and he somehow secured the financing to actually do it and to keep up with it. But I felt it was like a never-ending race. So we were trying to extract type information in different ways just by observing the execution of JavaScript programs. But even that is annoying because, I mean, observing the execution also requires tooling, and you have to instrument the program, and that’s again brittle. And the best-known tool for that is also now a bit rotten because it is also only applicable to, I think, ES5. Nobody’s using that anymore. So even this kind of approach is doomed. So nobody is maintaining this kind of JavaScript tooling anymore. 

Yeah. So I haven’t written – I did write some JavaScript code, but I think I wouldn’t be willing to write larger pieces of code in JavaScript. I’ve tried to write some TypeScript code. I mean, TypeScript has a decent type language with lots of cool features, Turing-complete, so you can write your machines and whatever in the TypeScript type language. Maybe I shouldn’t say that out loud, but I do not enjoy writing TypeScript code. I’m fine with reading and writing TypeScript types, but writing the code, I never got the hang of that.

*MS (0:56:45)*: Well, you don’t have soundness, right? As expressive as the type system is.

*PT (0:56:49)*: You don’t have soundness. No, of course not. That was never the goal of TypeScript, of the system.

*MS (0:56:54)*: It’s kind of irritating, right? Coming from statically typed languages that you would write. I mean, one of the things that I find annoying about TypeScript is that your mind kind of makes the assumption that once it type checks, it’s going to run without runtime type errors, and that’s just not true.

*PT (0:57:08)*: Yeah. So the systems that we were interested in for JavaScript, they were sound, but they wouldn’t type-check some things that people would want to be type-checked, right?

*MPG (0:57:20)*: Yeah. People care more about being able to turn it on when it says yes or no and then what the actual "yes" means, right?

*PT (0:57:30)*: Yeah, exactly. Yeah. So for most programming things, I’m still doing Haskell, although most of the time now I’m writing stuff in Agda, so I don’t even get to program in Haskell. But every second year, I pull out my Haskell hat for teaching, because then I’m regularly teaching a course on Haskell. Well, then I need to remind myself of Haskell programs. And in the end, we usually design some sort of project for the students. And then somebody has to implement it before to check that it works. And that’s another round of Haskell. Although this also – I mean, designing exercises and exam questions is nowadays also a thing where you have lots of assistants, right? From LLMs, for example.

*MS (0:58:28)*: Yeah. I was going to ask you about what has changed about teaching Haskell since. I mean, you’ve been doing it for 30 years, it seems, right? How does – I mean, okay, there’s LLMs, but does the course now differ in other fundamental ways from the course in the ‘90s?

*PT (0:58:44)*: Well, I mean, in the ‘90s we didn’t have monads.

*MS (0:58:46)*: Right. Okay.

*PT (0:58:47)*: We didn’t have IO in this form. I’m now putting monads much earlier, and I’m still – maybe I call them monads, but first you use them just as vehicles for IO. And then later on, you reveal, well, there’s more to it, and there’s monad transformers and all that. And nowadays, you don’t have to implement any of that. So the only time that you ask for the implementation of the operations of the state monad is in the exercise and maybe in the exam. But you never do it yourself. I mean, in a real program, you would use the stuff that’s in the library and just instantiate it. Well, I mean, I would say, in order to instantiate it, you need to understand what’s going on. 

But I talked to people from the Haskell Committee a couple of years back, and that’s because there are some weirdnesses, as usual. But he just said – well, I’m not naming him because probably he was here on your podcast before. And he just said, “Okay, no, that’s not an issue, right? So everybody can...” I mean, there are a few weird things that still bite beginners in the design, and to the point that some people – yeah, I mean, my favorite gripe is that at some point somebody put applicatives between functor and monad. I would say that applicatives is a more complicated structure than monads. So I would like to be able to talk about monads first and to define monad instances first in the lecture. But in order to do so, I have to implement my own version of the standard library, which kind of omits applicatives. It only holds for, like, two weeks, because then I teach applicatives anyway. But this first step is a bit annoying, right?

*MS (1:00:56)*: Well, the way that I do it is I just define a dummy instance, right? You can just say instance applicative, whatever, where, and just leave it blank and say, “Well, we’ll get to that later.” 

*PT (1:01:08)*: Does it run if you have –

*MS (1:01:08)*: Yeah, because the monad – I mean, one of the annoying aspects of that is that the monad syntax only generates the monad function, the monad methods, and none of the applicative – unless you’re using applicative ApplicativeDo, it doesn’t generate any of the methods there. So yeah, I feel the same gripe. 

*PT (1:01:30)*: Yeah. I mean, fortunately – so I talked about this to Dominic Orchard at some point, and he was saying, “Oh, but I have my own version of the library that omits the applicative and some other stuff.”

*MS (1:01:45)*: Yeah. I mean, we should maybe make that explicit historical note there, is that of all the algebraic abstractions that we’re now used to having as type classes in Haskell, monad really was the first. So definitely before applicative, even before functor, before monoid and semigroup and all these things, right? Monad was the first of those. And so when applicative and functor came out, in order to turn them into type class hierarchy things, people had to make incompatible changes that – I mean, it’s not just a teaching issue, right? It breaks your code.

*PT (1:02:22)*: Yeah, but I mean, functor is fine, right? I mean, functor understanding functor is not so much of an issue, I would say. Yes, it’s just generalizing map. But applicatives is a thing. So you need at least a full lecture to talk about it. And what was the other gripe? 

*MS (1:02:44)*: Well, now, I mean, you complained about monad comprehensions back in the day, right? And the problem with that was that you would get these overgeneral types that you couldn’t explain to beginners, right? So you want to use the programming language feature in the beginning of the class, but you couldn’t explain the types.

*PT (1:03:01)*: Ah, but now it has returned in a bad way. One way is there. And the other way that’s also annoying to beginners is if you talk about lists, then you want to introduce foldr. 

*MS (1:03:14)*: Yes, yes.

*PT (1:03:14)*: And foldr has this very nice and simple type. But if you type it into Haskell, :t foldr, you get something with the trans – what’s the trans? Traversable type class, right? Okay, but in lecture 3, I didn’t talk about type classes yet, and I don’t really want to talk about the traversable type class at this point, right? So that’s one more reason why it’s good to have your own Prelude, at least for teaching at that point. Yeah, I mean, later on, once you have talked about type classes, which is probably like in week 6 or 7, then you can do it. But in the beginning, it’s just mind-boggling. Yeah. And even with very simple stuff, you get problems with the default resolution of overloading, which works different in the interactive REPL and in the file. So that’s always a bit iffy in the beginning.

*MS (1:04:21)*: So we can spin that into an answer to Matti’s fair question, right? You want to ask him?

*MPG (1:04:25)*: Yeah. The classic question is always, what would you change about Haskell in the future if you want to go back?

*PT (1:04:32)*: I mean, the gripes that I have, they just mean that I personally wouldn’t use Haskell as a first language for teaching programming, at least not with all the bells and whistles turned on. And now you could say, “Well, it’s not meant to do that,” which is fine. But then probably people would like to have some lazy functional language that they can actually use for teaching, because it is an easier path to entry. So if you now have Haskell with everything turned on, then it’s pretty difficult to get an easy entry to that.

*MS (1:05:16)*: Even for a second language, you want sort of a linear path that is explainable into the language, right?

*PT (1:05:23)*: That would be much nicer rather than being exposed to everything at once in a big block.

*MPG (1:05:30)*: Yeah. I mean, that’s fair.

*PT (1:05:32)*: Yeah. I mean, apart from that, I’ve grown used now to dependently typed programming in Agda. So obviously, if I were to write a Haskell program now, I would feel utterly restricted, because I would – well, at least when I looked at it the last time, you would still have to have some sort of singleton patterns to have stuff also on the value level. I think things have changed a lot now. So that would be kind of the limitations that I would now feel.

*MPG (1:06:02)*: I think that’s a good pathway to the future. Thank you for coming on. I think this has been a great overview of the history of Haskell and the pain points and the lovely points that we all enjoy. So thank you so much for coming on.

*PT (1:06:16)*: Yep, thank you too. 

*MS (1:06:17)*: Thanks, Peter.

*Narrator (1:06:20)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
