*Andres Löh (0:00:19)*: This is the Haskell Interlude. I’m Andres Löh. My co-host is Niki Vazou. Today’s guest is Jeremy Gibbons, professor at Oxford, and we are going to talk about his journey from Orwell to Haskell, how to teach Haskell and specification languages to undergraduates, as well as professional programmers, how programming languages should keep simple things simple, and how paper writing can or even should be like poetry. 

Today with us is Jeremy Gibbons. Hello, Jeremy.

*Jeremy Gibbons (0:00:50)*: Hi, Andres. Hi, Nikki. 

*Niki Vazou (0:00:51)*: Hello.

*AL (0:00:52)*: So let’s just start, Jeremy. How did you first get into contact with Haskell?

*JG (0:00:58)*: That’s interesting. I first got into contact with Orwell, which was Oxford’s homegrown lazy functional language, when I started my DPhil, which is the Oxford name for PhD, in 1987. I came down and that was the language that was being used. That was the language for the first course. Well, actually, for the master’s degree. I think there wasn’t yet an undergraduate degree in computer science. And we had some-- there was some maths and computation that was taught using Abelson and Sussman books, so taught using Scheme. But Orwell was the thing--

*AL (0:01:34)*: Just to clarify the context a bit, the historical context, if I understand correctly, I wasn’t really around at the time. There was this phase where functional programming had some status and Standard ML was around and then people got interested into laziness, and then all sorts of different lazy functional languages popped up everywhere, and you’re saying that Orwell was one of those, right?

*JG (0:01:56)*: Yes. So David Turner’s Miranda language was-- I think David Turner was very influential in the language as a way of expressing nice algorithmic ideas, and he took great care with Miranda to make it elegant and clear and not noisy. So a lot of Haskell’s syntactic conventions came from David Turner and Miranda. But it was a commercial product at the time and, well, Oxford didn’t or wouldn’t pay the fees for it and implemented its own version instead. And I think that was partly Phil Wadler, but mostly a local guy called Martin Raskovsky, who was a bit before my time, but his fingerprints were all over it when I arrived. And then this and Orwell was something that we weren’t allowed to distribute, but maybe tapes of the Orwell source code went missing. We did have some Sun workstations. I’m not entirely sure what machines this was on, but it required considerable resources. And then a year or two after I started, Mark Jones started his DPhil in Oxford, and he preferred to work at home rather than in the lab. And he had a PC, but it was a PC with only 640k memory, so he wanted to do-- and when he was doing his doctorate on qualified types and wanted to experiment, but couldn’t get Orwell to run on his tiny little pc and didn’t want to go into the lab. So he invented Gofer as a simple cut-down version of Orwell.

*AL (0:03:35)*: And Gofer is what became Hugs, right?

*JG (0:03:38)*: So Gofer is what became Hugs, yeah. So Gofer is G-O-F-E-R *(Good For Equational Reasoning)* was one. I don’t know if that’s a rational reconstruction of the name, but yeah, a Gofer was widely distributed, I believe. And then, well, what’s the Haskell timeline about 1990? So as you say, Andres, there are a bunch of lazy languages at the time. So there was Miranda, Orwell, and Gofer. David Turner had started his doctorate at Oxford, although didn’t finish it there. So those are-- all have some Oxford heritage, but there’s Lazy ML also in Sweden and Hope in Edinburgh, and Clean I think was also a thing. Well, I was never involved in bringing these together, but my understanding is that the general feeling was that it’s great that we’ve got all these languages. But it’s really annoying that person A implements feature X in their fancy language, and person B implements feature Y in their different fancy language, and then person C wants features X and Y and is stuck. So rather than us all building edifices on our own little islands, we should make one big island build the edifice there so that we can all benefit from each other’s advances. And that’s what became Haskell, but--

*AL (0:04:57)*: Are you involved in the original standardization process?

*JG (0:05:01)*: I was not involved in the original standardization process. And actually, I came to it a bit later than it started too, because I finished my doctorate in ‘91, left, went to New Zealand, eventually found myself teaching functional programming at the University of Auckland. And I think we used Hugs to start with. So Hugs is the Haskell User’s Gofer System, which was minor changes to Gofer to match Haskell syntax. So there were some oddities in Gofer, where Haskell has guarded equations, Gofer and Orwell that followed Miranda and having a right-hand side and a comma and a condition. So all those were taken out and-- well, I mean, Haskell took them out. So Hugs matched Haskell’s syntax but with Gofer’s implementation.

*NV (0:05:53)*: And Haskell started at ‘87, right?

*JG (0:05:57)*: I started in-- my doctor is in ‘87. Yeah.

*NV (0:06:00)*: And this is the year that Haskell also started, right?

*JG (0:06:04)*: Yeah. I don’t know. Isn’t the first Haskell report 1990?

*AL (0:06:10)*: Yeah, I think that was the-- I’ve always thought that the committee was formed about a year earlier, but probably there have been some conversations even before that.

*JG (0:06:19)*: So I presumably-- and again, I’m rationally reconstructing this. I think it grew out of IFIP Working Group 2.8, which is the functional programming group. And I think that was around in the ‘80s. But I wasn’t involved in it.

*NV (0:06:32)*: And what was your PhD in?

*JG (0:06:34)*: Algebras for tree algorithms. So it was about-- so we have left and right scans on lists in Haskell, and it was about upwards and downwards scans on trees. An upwards scan is something that labels-- so like a right to left scan on a list labels every element of the list or every position of the list with the fold of the sublist that starts there, rooted there. And an upward scan is similar. It labels every node of a tree with the fold of the tree that is rooted there. And that was quite straightforward. But downwards accumulation is not so obvious because you want to label everything with the fold of the ancestors of a node in a tree, which is not a tree; it’s a path. It’s kind of a wiggly line. So I came up with some data types of wiggly lines.

*AL (0:07:22)*: Revealing myself as a student of Doaitse Swierstra now, but it all sounds very similar to attribute grammar. 

*JG (0:07:30)*: So when I was writing up, I visited the Netherlands for a-- I mean, I went and gave a couple of seminars and I talked about upwards and downwards accumulations to Doaitse. And not surprisingly, he said, “Well, it all sounds like attribute grammars to me.” And I thought about that a bit, and it did turn into a chapter in my thesis that you could devaluate attribute grammars as attribute upwards and downwards things. So upwards, you label every subtree with the function. It is from inherited attributes to synthesized attributes. And when you’ve got that upwards all the way through the tree that’s compositional, then you just need the inherited attributes at the roots, and the whole thing sort of source itself out. But for Doaitse’s Festschrift in 2012 or so, I went back and revisited that and I had better ideas about upwards and downwards accumulations then. So I wrote a paper called Accumulating Attributes for Doaitse as a nod to his-- it all sounds like attributes to me. Comment 20 years earlier. 

*AL (0:08:29)*: So when you started your DPhil, you were already interested in these sorts of things and it was already clear that you would want to use functional programming, or did that happen when you came--

*JG (0:08:42)*: That’s an excellent question. It wasn’t clear at all. So I did my undergraduate degree elsewhere at Edinburgh and wasn’t sure what to do. I was applying for jobs. I even was interviewed and got job offers as a software developer. But David May from Inmos came and gave a talk, a seminar in Edinburgh, and they-- so Inmos were building the transputer, which was this chip designed for concurrent computation. You could plug them together and they would communicate. They had small amounts of local memory, and they were doing a new version with a floating point unit and wanting to verify the correctness of the floating point unit. So David gave a talk about the project to verify the floating point unit of the T800 transputer, and I thought, “That sounds interesting.” So it was a joint project between Inmos and Oxford. And so I applied to do a PhD at Oxford to work on this and they let me in. But when I arrived, the project had finished and there was nothing for me to do. 

I got fortuitous. I was interviewed by Richard Bird. So not that he had anything to do with this particular project, I think just the applicants were farmed out among random faculty members and Richard turned out to be the one who interviewed me. And he was scribbling something on the whiteboard about some small programming exercise. There was this series of columns in science and computer programming called Small Programming Exercises by Martin Rem, which were just interesting puzzles, and how would you use your programming method to address them. And of course, Richard was doing it with functional programming. And so we talked something about that. I don’t really remember what. And then I went away and they gave me an offer. And I came and I started and never met the supervisor I was supposed to be working with on this Inmos project. And anyway, it had all finished and there wasn’t anything for me to do. But Richard was running an informal discussion seminar called the Problem Solving Club, which was kind of modeled on-- the Dutch Dijkstra had this Tuesday Afternoon Club. So they just-- a bunch of interested people would turn up. Somebody would say, “Well, here’s what I’m stuck on this week,” and you’d argue in front of the whiteboard about it. It’s not something you came with a prepared presentation or anything like that. But Richard sent a message around the laboratory as it was called then, and said, “Anybody who’s interested is welcome to come.” I was rattling around and had nothing to do, so I went and we talked about sorts of fun bits of programming.

I had been exposed to functional programming in Edinburgh through Standard ML. We had a course based on John Reynolds book, The Craft of Programming, about proving things about array programs correct. And somehow, in a way that I can no longer reconstruct, we had some practicals in Standard ML as well, and it bounced off. I mean, I could do them, I could write the programs. It was programming and I like programming, but I didn’t see the point of this funny programming language and I went back to doing my stuff in Pascal and things like that. But then my lucky interactions with Richard, he was just kind of influential and enthusiastic about, “Well, obviously, this is the right way of thinking about things and this is the right way of presenting it.” And I don’t even remember discovering lazy functional programming because ML wasn’t. Somehow, it was just never a thing. Just picked it up.

*AL (0:12:06)*: Okay. Oh, well, I mean, that’s a perfectly valid story, I guess. So I mean--

*JG (0:12:12)*: I think it’s also-- I mean, it’s an illustrative story and it’s not like it’s a difficult thing. It was completely natural.

*AL (0:12:21)*: Yeah. But I mean, also it shows that lots of these stories always have these coincidences and--

*JG (0:12:26)*: Sure. Absolutely. Yes.

*AL (0:12:29)*: You’re at the right place at the right time and things just happen.

*JG (0:12:34)*: Yes.

*AL (0:12:35)*: I guess also if I understand you correctly, between the lines, when you started studying, you were not necessarily planning to go into research because you had considerations such as, well, SML sounds like a funny language that is not really useful, which is not so much of a researcher’s perspective, perhaps.

*JG (0:12:54)*: Yeah. I wasn’t so worried about whether it was useful or not, but it didn’t seem like a funny language. But you’re right, I was not in any way committed to an academic career at that point. I applied for developers, developer jobs at, I mean, such tech companies as there were in the UK at the time. And I mean, I could well have had a happy career there, but a coincidence with this seminar from David May encouraged me to stay on and do a doctorate. And then four years later, I had three years of funding and it took me four years to complete my DPhil. I was then casting around again and I thought, “Well, I’ll go and get the job now.” So I applied for more jobs and got some interviews and got an offer, but I had to do some teaching to pay the rent in my fourth year. One of the Oxford faculty was on sabbatical, so he had tutorials to cover. So I had his students for a year and they had me with no experience in giving tutorials or anything. So we modeled along and made it work. But I found that I enjoyed it and wasn’t expecting too. It was just better than flipping burgers.

*NV (0:14:00)*: And what was the class that you thought?

*JG (0:14:03)*: Well, the Oxford system is-- the students are distributed around colleges and there’s one or two tutors in your subject in your college. And that tutor teaches everything to that group of students in that college. So there’s a bit of horse-trading where it’s just completely insane to try and give tutorials on the entire curriculum. So if you take my students in databases and I’ll take your students in compilers, then I don’t have to learn databases and you don’t have to learn compilers. So I maybe had students from two colleges and I didn’t have to cover-- I only had to cover half the curriculum rather than all the curriculum. So it is small groups of two, three or four students. However, many students there are in that year, in that degree, in that college and they have a weekly problem sheet in each of the two courses they’re doing at any one time and you meet to go through the problems. So what was I doing? I can’t remember, but it was-- I mean, it was fairly core stuff. I mean, there would’ve been some algorithms, some data structures, some programming. I mean, we didn’t have anything, any fancy applications stuff, so I didn’t have to learn anything complicated.

*AL (0:15:14)*: So what you’re saying, if I understand correctly, it was primarily that you discovered that you somehow surprisingly like teaching, that that somehow influenced you to pursue an academic career?

*JG (0:15:26)*: That was the spark that said, “Oh, well maybe I could apply for lectureships as well as programming jobs,” and I did. And, well, more serendipity, I spent a year applying for lectureships. I didn’t dare apply anywhere that wasn’t English speaking because I couldn’t speak any other languages. I had prejudices against applying to the US so I didn’t apply anywhere in the US, but I applied to everything in the UK. I saw, which was one position. And I got an interview there but didn’t get the post. I would’ve applied to Canada if I’d seen anything in Canada, but I didn’t see anything in Canada. I applied for six jobs in Australia and three jobs in New Zealand, got an offer in each, and went to New Zealand.

*AL (0:16:09)*: So that’s how you ended up in New Zealand really.

*JG (0:16:11)*: Yeah. Completely random. I mean--

*AL (0:16:15)*: Okay.

*JG (0:16:16)*: I’ve never been there as it happens--

*AL (0:16:18)*: And so the filter for applying was like lectureships in the area of functional programming?

*JG (0:16:24)*: No, no, just computer science. I mean--

*AL (0:16:26)*: Just computer science. Okay. 

*JG (0:16:27: Yeah.*

*AL (0:16:28)*: That was also-- like the New Zealand position was also not one that was predisposed to be in that area that--

*JG (0:16:35)*: No, not at all. There was no functional programming there. There was one person teaching logic programming, or actually with research interest in logic programming, I think. And after a few years, he and I got together and said, “Well, let’s have a course on this.” So we had a course on declarative programming, and he taught half about logic programming, and I taught half about functional programming. But it took several years to make that happen. It wasn’t-- it certainly wasn’t going into a hotbed of functional programming.

*AL (0:17:00)*: That was my own first introduction to declarative programming, was just such a mixed course. 

*JG (0:17:06)*: Yes. And the rest of the department looked kind of sideways at it and said, “Well, this is funny academic stuff rather than real programming, but let them have their corner and they can do their things.” And I discovered that one of the co-authors of the Haskell report was from New Zealand. Brian Boutel was at Victoria University of Wellington and I met him while I was there. But I don’t really know how he got involved because I never heard anything else about what he did, apart from having met him in Wellington and seen his name on the report So I arrived, rocked up in Auckland in November ‘91, and the academic years of the calendar years in New Zealand. So terms started in February and I was covering for somebody else’s sabbatical there. They’re gone on a sabbatical and I got their courses to cover. So there was a course on algorithm design, which was fine. And then I got to choose a course on my own. So I did a course on program verification, but I was replacing Professor Gibbons. There was-- Peter Gibbons was on sabbatical, so the student--

*AL (0:18:06)*: They didn’t have to learn a new name.

*JG (0:18:07)*: The students were a bit confused about how Professor Gibbons was replacing Professor Gibbons. Well, I wasn’t a professor, but Dr. Gibbons.

*NV (0:18:15)*: But you were doing the research there too, right?

*JG (0:18:17)*: I was doing research there as well. So that worked. I still had connections in Oxford. So I was still talking with Gary Jones, who was also in the Problem Solving Club in Oxford. Whereas we now might have discussions on Twitter or Facebook, they were on comp.lang.functional Newsgroup at the time. So I paid regular attention to that. And every now and then, people would post things and I’d post comments and sometimes a discussion would happen. And I wrote a paper with-- so there’s a guy from Canada, David Skillicorn, who was into parallel computing, had visited Oxford on sabbatical just as I was leaving. So I met him there. And then he went home and I went to New Zealand, and we ended up talking more about tree accumulations in parallel. So my thesis work. And we wrote a paper about that entirely remotely with a third co-author who I never met until 10 years later. And that was an interesting experience for me because, of course, this was pre-Zoom or Skype or anything like that. The interaction was all by email. But it was-- I was plowing my own furrow. It was a bit hard work, but it was a low-pressure environment. It’s not like anybody was leaning on me and saying you must have so many papers for a year and so on.

*AL (0:19:29)*: So how did you eventually get back to Oxford then?

*JG (0:19:33)*: I met and married a New Zealander, a lawyer. So she’d done an undergraduate degree, a joint undergraduate degree in Law and English, and then started work as a corporate lawyer and had always planned to go overseas and do a master’s and had planned to go to one of the US Ivy League places. But having married upon, it was much easier for her to come to the UK and do a master’s degree there. So she applied to Oxford to do what’s formally called the BCL (Bachelor of Civil Law). It was actually a master’s degree in Law in Oxford, a two-year master’s. So we came back to the UK in ‘96, to Oxford. I got a job at Oxford Brookes University, which is the technical university here in Oxford. And I fully expected that we’d be here for two years and then go back to New Zealand again. But then my wife finished her master’s degree and decided, “That was fun, I’ll do a doctorate now,” so stayed on to do DPhil herself. And so we were there for another four years and we’re still here. We came for two years in 1996 and we’re still here. 

So in ‘96 when I was applying, I wrote to Tony Hall’s head of department and said, “Look, I’d like to come back. Is there a job for me?” And he said no. That was a bit of a long shot. But I got the job at Brookes and they treated me very well. I was very happy there. It was very convenient, just a nice cycle ride. But there was an advert for another lectureship on-- so expanding this part-time professional master’s program that we have in Oxford, Jim Davies and Jim Woodcock with the two people running it, and it was expanding to four. So there were two more positions. And I knew Jim Davies because he was my office mate as a DPhil student. So we’d been chatting anyway just because I was back in Oxford, and he said, “Well, why don’t you apply?” And so I applied and I got that job. 

So again, serendipity in that I’m back in the town where I know people through my wife’s choice of place to study, and I happened to know somebody who’s recruiting. And I think it was a fair appointment. Myself and Andrew Martin were hired and I think we were the best applicants for those two positions. So that was the right-- they made the right decision. There wasn’t any favoritism or anything. But yeah, we looked like we were staying in Oxford for longer. So it was worth putting in the effort to moving jobs rather than expecting to go straight back to New Zealand. And it’s great fun teaching on this part-time professional master’s program now. So my students are professional software engineers. To first approximation, they’re all in employment, they’re all in the software industry. They might not be developers; they might be managers, testers, customers, and all sorts of things.

*AL (0:22:05)*: And you started doing that in the end of the ‘90s?

*JG (0:22:09)*: Yeah, 1999. 

*AL (0:22:11)*: All right. And even at that time, you were then trying to teach them Haskell?

*JG (0:22:16)*: Yes. So the program started, the software engineering program, as it was called, then started. In the early ‘90s, Oxford had a research collaboration with IBM Hursley Labs. So we had this specification language called Z, so set theoretical specification language called Z, and Hursley liked it and they used it to specify for the purposes of re-engineering CICS, which is their big transaction processing system. And that was very successful. But they needed to train all their engineers in Z. So people from Oxford started going down and giving courses in Hursley, which is just an hour’s drive south, about Z. And then the IBM people said, “We enjoyed that, can you teach us something else as well?” So that kind of grew. And then we decided to open it up to people other than IBM and it became an Oxford degree. 

So it was already various people from Oxford going down and teaching various Oxford things. They were teaching Z, teaching CSP. Joseph Cogan was at Oxford at the time. And so there was a requirements engineering group. So there was some requirements for teaching being done. But there was already a functional programming course before I arrived. So, Richard never taught it, but other people in Oxford who were associated with functional programming or been teaching the undergraduates functional programming were going down and teaching one-week courses in functional programming to IBM Hursley. 

So I got a trial by being roped in to teach this course before I was interviewed for the job. So they gave me the course to teach for a week and went down with me and watched what I did. So I inherited the course rather than initiated it. But it was-- I mean, it’s a very interesting program in the sense that it’s very definitely professional software developers. And the things we teach, when I teach functional programming to professional software developers, it’s not the same course I would teach to undergraduates. It has a different slant. But it’s still taught by Oxford and people come because they want the kinds of things that Oxford does. So we were kind of unapologetic about teaching research-driven topics. I mean, this program started by teaching Z and CSP because that was part of the core Oxford undergraduate curriculum at the time. In the years since it’s been ditched from the Oxford undergraduate curriculum and all the stuff about refinement calculus has been ditched from the undergraduate curriculum, we do still teach functional programming to first years, in the first-year undergraduates, but all the other stuff like Z and CSP, the only way to get it from Oxford now is to be a professional software engineer and come on the professional software engineering master’s degree. 

*NV (0:24:48)*: I think it’s like, what do you say that it’s like you teach Haskell to professional software developers and to first-year undergrads, it should be very different. So can you expand a little bit on that? Like specifically how do you teach a programmer to unlearn all these memory manipulation and program like a function?

*JG (0:25:11)*: Well, it is unlearning. And I mean, the same with the Z course actually. It’s eye-opening. And I mean, I do teach the course and I do say I don’t expect all these people to become Haskell programmers on Monday when they get back to the office. It’s a functional programming course to make you a better Java programmer or whatever your day job was. I’m going to infiltrate your organization rather than storm it. But people go away with their eyes open. They never thought of programming this way. And the same when they study set-based specification languages, so precise mathematical specifications of what a software system could do. If you’ve never seen any of that before, then you go away with your mind blown about, “Ooh, it’s maths after all. Didn’t realize that. I thought I was just knocking stuff together.” So it’s really trying to change the way they think about what they do rather than-- there’s only so much you can do in one intensive week, 16 hours of lectures or so in 12 hours of practicals Monday to Friday, bang, you’re done. You can’t retrain anybody in that, but you can plant a seed about a new perspective.

*AL (0:26:16)*: I mean, certainly, Haskell in my perception has vastly changed since the end of the ‘90s and now. I mean, perhaps not so much as like the core language, but sort of the what’s possible in practice in terms of libraries being available and the whole ecosystem. And you’ve been teaching Haskell all this time. Has your perception of Haskell changed during this time? Has your way of teaching Haskell changed during this time?

*JG (0:26:44)*: Those are good questions. Yes and no. So, I fully agree that Haskell has changed and I mean, it’s got a lot more useful as a tool for doing all sorts of things because there’s so much more you can build on rather than having to do everything yourself, which is obviously good software engineering practice. That’s the way we should do things. That’s the only way we make progress. But it hasn’t actually changed very much about the way I teach it. I do teach a bit about QuickCheck. So there is an import in my Haskell slides, my functional programming slides. So QuickCheck’s a very nice example of language design and how type classes and monads and so on, which you thought were very specific, turned out to be very general and useful for all sorts of things that you couldn’t foresee. And so I do show the use of a big chunk of well-engineered code that I don’t have to write myself. But that’s about it really. And everything else is just a Standard Prelude and a few odd things that I think should be in the Standard Prelude and aren’t like inits and tails and data.function.on and things like that.

*AL (0:27:47)*: Okay. Yeah.

*JG (0:27:48)*: So the course has changed and has been revised and smoothed over and so on, but it’s not actually fundamentally different from the course I was teaching 20 years ago. The ideas of functional programming haven’t changed.

*AL (0:28:01)*: But the Prelude, I mean the Prelude in Haskell is independently of design decisions such as having partial functions and so on. But it is very list-oriented, right? I mean--

*JG (0:28:11)*: Yes, yes. 

*AL (0:28:12)*: These are still sort of the dominant data structure. And I would say from my industrial perspective, that is perhaps not that great. That lists are so privileged in Haskell. And by the way, they’re still quite useful for plenty of use cases, but not for all that many. And there are interesting other data structures and so on. Are you teaching anything in that direction or is it like sort of all--

*JG (0:28:41)*: I don’t have the luxury really of-- I could teach all sorts of fancy tree data structures and so on, but--

*AL (0:28:47)*: You said you started out with doing your default on trees. So it’s not on lists.

*JG (0:28:53)*: Yeah. It’ll only be very tempting to go down there. I mean, I can talk for a week on that without any difficulty, but I’d have already talked for a week on all the basics of functional programming first. So if I were teaching a 30-lecture course, I would do it differently. But this is only 16 hours of lectures, so it has to be quite fast. So I do teach algebraic data types and I do teach maps and filters and folds and things, but I only hint that there are maps and folds on trees. And the only time we stumble into Traversals and Foldables is when I’m doing some live coding on the exercises and somebody asks what’s the type of something, and I say, “Well, it’s not what you thought it was.” 

So I’m not against that. And if it were an undergraduate course, then I’d teach more about how these things fit into the other courses you were doing. And if I had longer, I’d say more about it. And we have a separate course on algorithmics, which covers some fancy data structures. So if I had to teach that in this course as well, then I’d pay more attention to the higher abstractions like Foldables and Traversals and Functors and so on. But I don’t mention Functor at all in my course.

*NV (0:30:06)*: So in Prelude, everything has moved from list to Foldable too, right? Even like all the folds and the length.

*JG (0:30:15)*: Yeah, I try not to know that stuff.

*NV (0:30:19)*: No, I was actually learning. I remember when the type of length changed from a list to a Foldable.

*JG (0:30:25)*: So the type of sum, for example, S-U-M, is not list a to a, not for Num a anymore.

*NV (0:30:31)*: Yeah, I guess this makes teaching more difficult. 

*JG (0:30:34)*: Yeah, I think it will be nice to have-- I’m really envious of the racket people with their language levels. I think they’ve got that right. And I wish in Haskell world, we had something like that. So there are different constituencies and they have different needs and we’re trying to meet them all with one language. And I think that’s stretching things. And it will be nice to have something, even something where you just didn’t have type classes to start with. Of course, that makes us a bunch of things awkward, but it means a bunch of error messages just won’t trouble you, and a bunch of ways you might get confused and not there. 

*NV (0:31:08)*: I mean, the first class is always very difficult, but you have to do a class and you see the Num instance and--

*JG (0:31:15)*: Well, that’s why-- yeah. I don’t-- I lie in the first class. `(+)` has type `Int -> Int -> Int`.

*AL (0:31:21)*: Yeah, that’s one of the things that I’m a little bit struggling with as well when I’m teaching. So I think it’s not inherently difficult that a particular function such as Sum has an overloaded type signature. But what is a little bit difficult about Haskell is that there are all these concepts and they’re all sort of mutually dependent on each other, and they’re all there from the very beginning. Like even the simplest of functions is already using type classes and parametric polymorphism and this and that and that. And you cannot just start explaining things one by one because you always have--

*JG (0:31:58)*: You can, but you have to lie.

*AL (0:31:59)*: But you have to either lie or you have to make forward references or you have to basically start with this huge mutual block and say like I’m explaining all these things that are somehow connected. And I think, yeah, this dependency is what makes it difficult. And that’s certainly something where language levels could help a lot because you could zoom in on certain aspects while not yet discussing others. 

*JG (0:32:24)*: I have a pet theory about that. There’s a slogan, “ontogeny recapitulates phylogeny” from biology, which is the idea that the development stages of a fetus goes through mimics the evolutionary stages that the organism went through. And it’s discredited in biology. It’s just an accident. Coincidence is my understanding, not being an expert in biology. But I often think we ought to teach computing that way, programming that way in particular. So rather than teaching new students the state-of-the-art ways of doing things with, I don’t know, OO programming or functional programming or microservices or whatever, you’d start them at the beginning with machines and machine language. And after they’ve bashed their heads for six weeks off machine language, you show them assembly language and they go, “Wow, this is brilliant. So much easier.” Of course, you need to have a captive audience for that. So you need to sort of chain them in a room for three years so that they don’t escape after the first six weeks and say, “This is terrible.”

*AL (0:33:24)*: Yeah. I think there is some truth to that. I mean, certainly, it’s sometimes good to understand why a particular abstraction makes sense. If you take monads for example, I always think that it’s very difficult to explain monads in Haskell and what they give you as an abstraction mechanism if you haven’t first in a way suffered from the fact of not having them available. If you’ve seen how you write chained case blocks on a Maybe data structure where you branch off on nothing in every branch and have all this noise, and then you tell, “Well, you can get rid of all this,” then there is a real benefit. Whereas if you tell them upfront, then it’s not so obvious, right? 

*JG (0:34:07)*: Yes, absolutely. And it’s the same with OO as well. I mean, there are some good ideas in object-oriented programming, but if you start with them, it’s not clear what bad ideas they’re replacing.

*AL (0:34:16)*: But at the same time then, to contrast this, I always think like when I had my first course, which I think was very good, but I mean, my first course on functional programming, I think it was a month that we spent talking about `foldr` at the time. That was sort of the culmination of the whole chorus to talk about fold. Now that we’ve seen all these different functions on lists, we can also introduce `foldr` and it’s this really difficult function that generalizes all of them. And just the mere fact that it was sort of the culmination of the course and it was presented as being this incredibly difficult abstraction that somehow made it difficult at the time, I feel like. And these days, I mean, I’m introducing-- when I’m teaching Haskell, I’m introducing `foldr` on day one, essentially. And I don’t think most people find it incredibly difficult. And so there’s certainly also the aspect of, yeah, I mean, learning from experience and seeing that certain detours are not necessary and thereby making things easier without taking the whole historical context into account and the whole evolution of ideas. 

*JG (0:35:29)*: Yes, yes. But I think, I mean, absolutely with monads, you need to have written or at least see the chained case analysis on Maybes and the chaineded threading of state through account or through something or some other kind of state and see the computations.

*NV (0:35:47)*: But *(0:35:47 unintelligible)* too, right? You have to first write, I don’t know, 20 functions very clearly and explicitly, and when you understand, okay, if I use fold, it’s much easier.

*JG (0:35:59)*: Yes. So I teach `foldr` on, well, day three, even of five. So it’s halfway through the course. And on day two, I’m really bashing them over the head with sum and product and minimum and max and all these things. And I hope to get them really frustrated with writing the same pattern over and over again. And that’s the point where you say, “Well, you don’t have to do that.” You do have to be confident that they’re not going to leave the room at the point where they’re frustrated. And so that was frustrating.

*AL (0:36:28)*: Yeah. I mean, I sometimes warn students of this. I mean, I basically say that like, “Look, we are doing this now because there is going to be a better way later on.”

*JG (0:36:41)*:* It’s good for you. Trust me.

*AL (0:36:43)*: But I mean, I want to show you first what would be the first principles way with just the mechanisms that we learned so far. And every once in a while, I mean, it doesn’t happen very often. A student actually comes up with-- I mean, not necessarily with monadic binds, but with some way of abstracting such a, say a chain case analysis of Maybes themselves that’s so like, “Can we not just abstract here?” And that’s good. That’s great, right? Because then they’re halfway there.

*JG (0:37:11)*: You’ve passed. Yeah.

*AL (0:37:15)*: I’m going like-- I usually don’t do this, but I know yet in the advance email exchange we had, you said like, “I also have some ideas on why Haskell might not yet be the perfect language.” And since I don’t find a nice way to transition to this, I want to give you the chance before our time’s up to actually talk about this, because you indicated before that you might have some things to complain about. 

*JG (0:37:41)*: Yes, something I complain about. So what was I thinking when I said that? So one thing is on the way to dependent types. So I’m old enough that I did some nested data types with polymorphic recursion to capture fancy shaping variants like balanced trees and square matrices and so on.

*AL (0:37:57)*: Yeah. I know that was like-- when I learned Haskell, that was one of the most fun things.

*JG (0:38:02)*: So it was fun, but it was really awkward. There’s only certain things you could do with it, and it was a hack. And I was very proud of the things I managed to do that way, but it’s not the right way of doing it. It’s so much better to be able to say length index vectors and the lengths of things. But then we were still hacking it and it’s not the right way to do it in Haskell by having all the data types at the value level being replicated at the type level and then having to reinvent everything, you know, at the value level, at the type level like addition and associativity and all this kind of stuff. So hence, all the interest in Idris and Agda, which is obviously a righter way of doing it. But still, I’m not persuaded yet to jump ship completely and go to Idris or Agda because it’s just, then you have to worry about associative edition and so on. So you’re pushing a theorem prover in a sense. It’s like pushing a piece of string and pushing doesn’t always work. And you have to figure out the right way to get it, to pull the string so that things move appropriately. 

*AL (0:39:10)*: But that disadvantage also applies to Haskell right now, right?

*JG (0:39:14)*: It applies more to Haskell than-- so my colleague Mike Spivey made a very funny joke about this, which I’m going to mangle, but he was referring to Algol 68, which was the Algol 68 report was written in a very weird style. So one of the reasons Algol 68 never flew is that nobody could understand the language specification because it was in a sense a simple imperative programming language. But the specification, it was a higher-level thing that was written with metaprogramming. So these things called two-level grammars where you don’t have a grammar for the language, you have a grammar to generate the grammar for the language, which was Van Wijngaarden’s thing. Very clever, but very difficult to understand. 

So Mike was observing that Haskell’s like that. We have this kind of simple direct value language underneath that we all understand, and then this obscure type-level programming language on top of it that we can’t really manipulate and we’re having to nudge and hint and why can’t it just be straightforward? And I feel that about type class hackery, and I’m guilty of it as much as anybody, I also feel that we haven’t got the right levers for dependently typed programming yet. It shouldn’t be this difficult. And that’s not to say I know any way of making it any easier and cleverer people than me are working hard on it. I admire and love Conor McBride’s work on this, and he’s very much working towards finding the ways of presenting things and specifying things, and defining things so that the natural constructions are the ones that you want. And I think he’s got absolutely the right idea. We shouldn’t be encoding stuff so that if you are clever and work hard enough, you can make it work. We should be finding the right tools so that it’s just natural and simple things are simple.

*NV (0:40:58)*: So to be the devil’s advocates, isn’t this like what type classes is? I mean, the fact that we understand them doesn’t make them simpler in the sense that most people complain, like most non-Haskell people complain about type classes and monads and all this. And once we understand, then everything makes sense.

*JG (0:41:17)*: I think it’s different, but maybe that’s just revealing where I am on the scale of learning these things. But there’s a certain obstacle to learning type classes. But then once you know what type classes are, it’s not difficult to define your own type classes and use type classes in the right kind of first-order way. And it’s true that they are powerful and you can do all sorts of crazy things like, well, like Oleg Kiselyov was famous for, although he doesn’t seem to do so much of that these days. Surprising things you didn’t think you could do with type classes turns out you can do, we shouldn’t have those surprises. I mean, that’s bad for programming language. But surprises and sort of abusing the type class mechanism apart, the standard expected uses of type classes are standard and expected and straightforward and not difficult. And then for anybody who’s learned this tool, it’s not difficult to do and it’s not painful to do. And it feels to me that dependently typed programming is not like that yet. There may be surprising uses of dependently typed programming, but they’re off the scale. But the standard uses of dependently typed programming, even the dependently typed programming experts say, “Well, it’s just annoying that you have to go and explain all these obvious things to the type checker.”

*NV (0:42:25)*: Like you mean the vector example? 

*JG (0:42:27)*: Well, yeah. So I mean, if you concatenate your vectors in the wrong way, then their sizes, their lengths are summed in the wrong order. And then you need to explain why this X plus Y plus Z is equal to X plus Y plus Z the other way, parenthesize the other way, or X plus Y is equal to Y plus X and things like that. Different kinds of equality. 

*AL (0:42:46)*: That’s why you want to use refinement types, right?

*JG (0:42:51)*: Well, rather than getting a type, misusing a type checker as a theorem prover, why don’t we have a theorem prover to do the theorem proving? So I’m arguing for in that sense refinement types are the right tool for the right job.

*NV (0:43:02)*: Yeah. Unless you care about equality. Equality is so difficult. 

*JG (0:43:08)*: Yeah, yeah.

*AL (0:43:08)*: But do you think Haskell will ever become a dependently typed programming language?

*JG (0:43:15)*: I don’t think Haskell will become a dependently typed programming language, but we won’t live with Haskell forever. We’ll move away from it and we’ll-- Idris will be the next big thing in 10 years’ time, or I mean, whatever it is, or some language we haven’t seen before. Oh, Haskell has had a surprisingly long life for programming language. People are not enthused about Java as much now as they were in 1994. It’s not the language du jour, and Haskell is older than Java.

*AL (0:43:41)*: Oh, I mean, yeah. Haskell has for a long time been only a research language. I mean, now it is sort of an industry programming language, but it is still among the more exotic ones clearly. But that’s certainly, I think prolonged its life in a good way. And I think it’s also-- I mean, in many ways, I’m sort of objecting to the idea that Haskell is on the decline. 

*JG (0:44:06)*: I don’t think it’s on the decline. I don’t think it’s on the decline. But I don’t think we should expect to be programming--

*AL (0:44:12)*: No. From a research perspective, I would also say that perhaps, it’s not as fundamental anymore, right? I mean, I know that in the early days when I was starting with Haskell, everything was a real achievement and just understanding how certain things can be done. And I think this is-- you’re right, that we’re in that scenario where more with dependent types now still, with actual dependently typed programming languages, where we like, oh, sure, we can do all the things in kind of the same way as Haskell. In that sense, these languages have an advantage, but how can we express the extra things that we can get in such a way that we don’t have to redo all the work every single time, and that we don’t have to go to unnecessary efforts for proofing simple things. 

*JG (0:45:00)*: Simple things should be simple.

*AL (0:45:02)*: Yeah, that would be nice.

*JG (0:45:04)*: That would be nice. Yes.

*AL (0:45:06)*: So is this also what informs your research these days? Is that sort of what your-- what are your goals for your academic--

*JG (0:45:15)*: That’s also an interesting question. I’m not sure I didn’t get into this because there’s some big social problem that I want to fix. Some people do embark on a research career because they have a particular passion to solve a particular problem, and it’s their life’s work to add a few bricks in that wall. And I greatly admire them for that. But for me, it’s more individual curiosities and sort of picking up shiny stones on the beach and giving them a polish. So I have sympathies for poets more than I do for engineers and medics perhaps. So I like finding recurring patterns. So these two programs that look completely separate and they’re doing different things and you find actually algebraically under the hood, they’re the same somehow. And finding that similarity and finding a way of expressing it and then using the properties of the algebraic properties to show that this thing is the same as that thing or this transformation that you already knew you could do on program X, you can also do on program Y and never thought about that. So sort of carrying ideas across. So unification in that sense of disparate ideas.

*AL (0:46:23)*: Yeah. And new ways of abstraction perhaps.

*JG (0:46:25)*: Yes. Yeah.

*NV (0:46:27)*: So you see your papers as poems?

*JG (0:46:31)*: Well, I aspire to that, let’s say, and I don’t always achieve it, of course. But I mean, not poems. I mean, sometimes poems are bad in the sense that they’re obscure and they’re not clear, and you write it so the reader has to work to understand what’s going on. And that’s great for poetry, but I mean, that’s not what we should be doing for writing scientific papers. So that’s--

*NV (0:46:52)*: It happens quite--

*JG (0:46:53)*: No, it happens certainly. And there are-- we have colleagues who write like that, and you have to sort of, what on earth did they mean by that? And then you could have sort of a critical debate about what was the author’s intention and whether the author’s intention matters or whether it’s just the text that’s the thing. And that’s not what I mean, but I mean, in the functional pearl sense, I mean, Richard Bird’s sense of taking an idea and polishing it so that your presentation of it is as natural as it could be. And well, again, simple things should be simple. If there’s a simple idea and you haven’t yet found a way of simply expressing it simply, then you haven’t polished it enough and it needs more work. And that is not bad per se. Things always need more work. We should allow the unpolished things to be out there so that other people can help polishing them. But I get the most satisfaction from taking something and saying, “Well, that’s the best I can do. I can’t see how to improve that any further.”

*AL (0:47:51)*: Yeah, that’s an interesting point. I mean, because also for me, when I originally came from mathematics to computer science actually, but to this particular field of computer science, functional programming, one of the most appealing things was that the community attaches value to good explanations, which is, I wouldn’t say not the case on mathematics, but much less the case in mathematics, and perhaps also much less the case on other fields of computer science. I don’t know. But this idea of a functional pearl, that is also originally due to Richard, right? I mean, he--

*JG (0:48:23)*: Well, the functional pearl, yes, but Richard was inspired by Jon Bentley’s Programming Pearls column in Communications of the ACM in the-- well, certainly in the 1980s, maybe earlier than that. I don’t remember. So John Bentley was-- he had this short column. He wrote some, he invited others to write, to contribute them. So guest authors. So it was Jon Bentley, you had the pearl metaphor of things that irritate you. And so you work on them and cover them until they’re smooth and shiny and polished. And then they don’t irritate you anymore, then they’re nice to look at.

*AL (0:48:59)*: Yeah.

*NV (0:48:59)*: So do you want to say what is a pearl? Because I’m asking because maybe somebody could listen that doesn’t know--

*AL (0:49:11)*: It’s good to hear your explanation definitely because I mean, even thinking back to my few times on ICFP program committee, I think there is not a universal agreement.

*JG (0:49:20)*: I think that’s absolutely true. I mean, different communities now have picked this up. Journal of Function Programming started in 1990, and it was some combination of Phil Wadler and Simon Peyton Jones and Paul Hudak, and somebody else I think were the four people who initiated it, but invited Richard to write a column. So Richard created that and set the agenda for that. But then it’s been picked up and ICFP has functional pearls, POPL has pearls, and I see the idea coming up in other bits of the programming languages-ish kind of community as well. But they do indeed read them in different ways. 

So Richard’s idea, which I ascribe to too, because everything I know I learned from him, they present a neat idea in an elegant way. The idea is worth maybe re-presenting. So it didn’t be a new idea, but maybe it’s an idea that deserves to be better known or has been buried under some other work that is also important but obscures the idea or just a sort of presentation that you think could be improved. They should be compelling so that you should read it and say, yes, that’s the right way of doing it. They should be short. And so he likened them to short stories, which often start as sort of literary short stories. They don’t have the long prologue. They sort of dump you straight in the action and maybe leave you at the end on a bit of a cliffhanger and leave it working out what happened there. There should be a surprise at the end, perhaps. So don’t worry with the standard academic paraphernalia of abstracts and introductions and related work and conclusions and future work and blah, blah, blah, blah, blah, just short, crisp.

And so he as editor of the Functional Pearls column in JFP, Richard sent the papers out to reviewers. And so he told reviewers to stop reading at the point where it gets too complicated or they get lost or they get bored and the paper is not ready yet. That doesn’t mean instant reject, but it just means it needs to go back in the oyster and have some more polishing. So I think Richard’s things about compelling idea very elegantly presented needn’t be a novel contribution. It’s identifying this thing and retelling the story and making it more accessible, more transmittable that way to be short and fun to read.

*AL (0:51:53)*: Yeah. Difficult to write, fun to read. 

*JG (0:51:55)*: Difficult to write, perhaps. Yeah. So that’s something. You have many more readers than you do writers, so it’s worth the writer putting in the effort to make it easier for the reader.

*NV (0:52:04)*: Do you have an example of a pearl that has all these criteria? 

*AL (0:52:09)*: Yeah, sort of the ideal pearl.

*JG (0:52:11)*: Yeah, ideal pearl. Gosh. I wish you’d given me more time to think about that. I really like Wouter Swierstra’s Data Types à la Carte. I think that’s very, very compelling. And I don’t remember if that fulfills all the criteria I’ve talked about. I don’t remember if it’s as short as it could be or whether it covers more stuff. The Idioms paper, Applicative Programming of Conor McBride and Ross Paterson is commendably short and has a great idea in it that we’ve now picked up and done all sorts of things with. And they just sort of scatter sparks left, right, and center of you could do this and you could do that. And look, it’s lax monoidal, a strong lax monoidal functor, and there’s this traverse thing and a whole bunch of other stuff that you can unpack from the paper. And they didn’t go laboriously unpacking it. 

You were saying earlier about maths papers. So I think the mathematicians sneer at us in a way by saying, why do you have to be so explicit about stuff? Yes, you could give a proof for this, but I mean, the one-line proof hint is all you need. And the reader should do the work, and they’re not going to fully get the proof unless they go and work it all out themselves. So the proof can just say by calculation, and then we might laboriously go through the calculation. In some sense, I admire that, expecting the reader to put in the work. As a writer, I’m not very good at encouraging it. I’m inclined to be explicit and sort of spell out the joke and then destroy the joke in the process. So somehow, having the touch of being able to-- the light touch of being able to leave things unsaid and have the courage that the authors are going to be able to fill it in, that’s kind of the poetry. 

And again, getting back to the poetry, I mean, that is nice and it respects the reader and says, “Look, you’ve got to work too, but I know you can do it. Go on. What goes in here?” But it’s also a bit obstructive because not everybody is a sophisticated reader and not everybody, it’s their first language, and not everybody will get that. And so they can’t benefit. So although I aspire to poetry, I maybe write pros or prosaic stuff and spell out the details. And so I do really admire it when somebody can write and just give you the key points. And correctly, at least for me, the ones that work for me, that size gap is one that I can fill in. So thank you. I can do that. And that makes me feel good because I filled in something.

*AL (0:54:38)*: I think that’s the key point, right? I mean, you can leave out things that are obvious to the reader, and sort of depending on how high you build the abstraction tower and how advanced you assume your audience to be, you can leave out quite a lot of things if you still mention sort of the right few key points. But not everybody is at that level.

*JG (0:55:01)*: No, no, no. So you write for the reader and you need to know who the reader is. And if you’re wanting to write for a broad audience, then you have to be a bit more generous with lower aspirations for what the reader can bring.

*AL (0:55:12)*: Yeah, but I also think, I mean, in general, computer scientists or at least programming languages researcher, they tend to fill in more of the gaps, but it is also easier to skip something that you can easily understand than to reconstruct something that is just not there.

*JG (0:55:29)*: And since we don’t commit everything to paper these days, there’s no cost in doing so. If you know it, then you should-- you’re trying to engage in a dialogue with the reader, but you’re doing it asynchronously because they’re reading it a year later. So you need to be able to answer their questions if they have them. But maybe they didn’t ask that question. In which case, they should be able to skip proof of theorem 5.

*AL (0:55:51)*:* All right. I feel like we’ve only scratched the surface really. There are lots of topics that we could still be discussing, but more than an hour has passed and we should probably come to an end. Thank you, Jeremy, so much for taking the time to talk with us.

*JG (0:56:02)*: Well, thank you. It’s been a pleasure.

*NV (0:56:04)*: Thank you very much.

*Narrator* *(0:56:10)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the support of our sponsors, especially the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and Meta.
