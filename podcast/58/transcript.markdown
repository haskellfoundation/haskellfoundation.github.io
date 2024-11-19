*Matthías Páll Gissurarson (0:00:15)*: Hi, my name is Matti, and I’m here with my co-host, Sam. 

*Samantha Frohlich (0:00:19)*: Hi.

*MPG (0:00:20)*: This episode is a bit special. We went to ICFP 2024, the International Conference on Functional Programming, in Milan, Italy. We ran around recording snippets with various participants, including keynote speakers, Haskell legends, and organizers.

On day zero of ICFP, there are a lot of happenings, including PLMW (the Programming Languages Mentoring Workshop), the Erlang Workshop, HOPE (the Higher-Order Programming with Effects) Workshop, and FARM (the Functional Art, Music, Modeling, and Design) Workshop.

*SF (0:01:16)*: That’s where the music you just heard came from.

*MPG (0:01:19)*: While Sam gave her presentation on getting the most out of ICFP, I interviewed Niek Mulleners from Utrecht on his PhD work there.

All right, I’m here with Niek Mulleners from Utrecht University. So tell us, what are you working on these days?

*Niek Mulleners (0:01:32)*: Hi. Thank you for having me. These days I’m working on the realizability of programs in terms of their types, input/output examples, and sketches. So programs containing holes. And I’m interested in trying to figure out, like, when exactly is a program possible? Like, usually nowadays you see with these big AI, like large language models, it’s all about generating programs from some specification, but we’d never really ask, like, is this actually possible? Can we even have such a program? So this is one way that I think it’s interesting to have more formal methods to reason about these questions of does a program exist? What can you do with it? This is what I’m really interested in. And I have a paper about it on ICFP, but I’m already thinking about lots of future work on including more types, more kinds of programs that can be supported.

*MPG (0:02:20)*: All right. Thank you.

*SF (0:02:33)*: On the first day of ICFP proper, I joined Matti to get you the best of the action. We caught keynote speaker Andy Gordon from Cogna, Pedro Abreu from Type Theory Forall podcast, Cyrus Omar of the Hazel Project at the University of Michigan, Haskell legend Simon Peyton Jones of Epic Games, and PLMW attendees Samuel and Angmo.

*MPG (0:02:58)*: All right. I’m standing here with Andrew Gordon, who just gave a great keynote. But he has a long history in Haskell. So how did you get into Haskell?

*Andrew Gordon (0:03:07)*: Hi. I was at Edinburgh in the ‘80s as an undergrad. And I learned ML programming back then and realized I really loved functional programming. And so I went to Cambridge in the late ‘80s to do a PhD. And someone who was there was on the Haskell committee—a guy, Jon Fairbairn. And he snuck me onto the mailing list about Haskell as it was being invented in about ‘87, ‘88, and so on. And so I was looking for a topic and wondered how to do input/output in purely functional languages. And so I did a big literature survey of everything that was known at the time. And I had this Edinburgh background. So I figured out a formal semantics for different kinds of I/O. In fact, when I was at FPCA in ‘93, first time I was here, if you like, I had a paper on the different kinds of I/O that you could do in lazy functional languages, including proofs that you could map between them, which is fun. And part of the PhD, I worked on monadic I/O, came up for the symbol for the monad bind. And after my PhD, Phil and Simon were very kind and said, “Andy, you should join the committee. Help us standardize monadic I/O.” So I did work with Kevin Hammond on that. And so that symbol made it into Haskell, which was great, which I feel good about. So, that was sort of me at Haskell. 

*MPG (0:04:33)*: All right. Thank you for that.

*SF (0:04:47)*: All right. It’s day one of ICFP proper. Matti and I are here with Pedro from Type Theory Forall. How are you enjoying ICFP?

*Pedro Abreu (0:04:55)*: Hello. Actually, this is my first time being here in ICFP, and I’m also really excited. My first time also in Europe. I’m having a really good time. This is like end of summer. The weather here is extremely good. Everything is so nice. I went to the Duomo with my girlfriend yesterday. Oh my God. Everything here is so, so huge. 

*SF (0:05:17)*: Are there any talks you’ve particularly enjoyed so far?

*PA (0:05:20)*: The first talk, the keynote with Andrew Gordon talking about AI. And I thought it was so interesting when he was speaking about this vision of Grace Hopper of bringing English into programming, right? Because if you go back into the days of programming, everything was machine-coded, and she had this intuition that we should make it easier. And him bringing this back to this next step, this next revolution where we will actually be talking to the machine—I think that is really, really exciting.

*SF (0:05:51)*: We’re still early on ICFP, still day one. Is there anything you’re looking forward to in particular?

*PA (0:05:57)*: Oh, yes, absolutely. So I came here because I just finished my master’s degree at Purdue University, and now I am going to — well, I’m looking for positions both in industry and talking to some people in academia. I plan to take a one year to work more full time in my podcast, Type Theory Forall. Take a look at it. It’s the biggest podcast in type theory because it’s the only one basically. So, I’m currently talking with a bunch of companies, hopefully trying to find some sponsoring, some kind of synchronicity that I can have with those people in the industry. 

I see a lot of possibility to grow our audience and to make things a little bit more popular in this field that I feel like type theory, functional programming is so much in the ivory tower of academia. We are always like these horrible inference rules. Everything is so nasty, so hairy. We can make it a little more accessible, right? I see that there is a lot of people getting into functional programming for the first time and seeing this beautiful new world in front of their eyes. 

And the next natural step is dabbling a little bit with some type theory because, like first time you go there and you see some Haskell, you see the type classes, you start working with some monads, you see how much more there is to programming instead of like the good old design patterns that you’ll see in Java, right? There is so much more that people sometimes don’t even dream about. And we’re starting to see that gaining more and more traction in the mainstream with big languages like TypeScript or C#, developing link in a very functional style, or Java, since Java 8, adding streams over there. And it’s becoming a little more mainstream—this functional idea.

So my dream, my hope, is to make the next step for the functional programming, which is getting more into type theory, more into these ideas that we can only see in these big conferences, right? This is an ivory tower. This is for PhD students. This is for academics. My hope—and I’m really happy to be here; I’m really happy to be talking with you guys—is to make it as much accessible as possible.

*SF (0:08:20)*: Amazing. We’re glad you’re having a good time. Enjoy the rest of the conference.

*PA (0:08:23)*: You too. Thank you so much.

*MPG (0:08:31)*: All right. We’re here at ICP with Cyrus Omar. So Cyrus, tell us, what are you working on these days?

*Cyrus Omar (0:08:37)*: I am working on the Hazel programming environment, lots of different projects there. So we’re really trying to develop live programming, programming with holes, doing a lot of work on AI plus holes. We have a paper coming out at OOPSLA this fall on how to use typed holes to contextualize language model-based generation. I just gave a talk yesterday at the HOPE Workshop on a side project related to reasoning about effects or techniques for reasoning about effects to constrain AI agents. So that’s another AI-related topic that we’re thinking about. And we’re doing a lot of thinking about computational science and environmental science and how live functional programming could help people doing that important work. So yeah, many different interesting things that are going on, all in this setting of building the next generation of programming languages and tools.

*MPG (0:09:32)*: All right. Very cool. And so how are you liking ICFP so far?

*CO (0:09:36)*: I am really enjoying it. Yeah, it’s really great to be in what I think of as my home community. Just like people that really value thinking carefully about programming and language design. And it’s been a really lively set of talks so far. Really enjoyed this last session I was just at in focusing on type systems. There was a lot of focus on graduality plus dependent types. You saw the standard example of length-indexed vectors in, I think, three out of the five talks. So that’s always a good sign. Yeah, it’s still early. Looking forward to a lot of the talks that are coming up as well.

*MPG (0:10:10)*: All right. Thank you so much.

*SF (0:10:18)*: All right. We’re here now with Simon. How are you enjoying the conference? 

*Simon Peyton Jones (0:10:21)*: Oh, it’s great. It’s lovely being at ICFP. I feel a lot of old friends who I haven’t seen for a while. I thought PLMW yesterday was great. It was a really good group of people. It was in a room that was small enough that it was small enough that you could actually have a dialogue. We talked quite a bit about how to read a research paper. And it was a really good conversation, I thought. There were a lot of different voices in the room. And you gave a great talk, too.

*SF (0:10:44)*: Thank you. Is there anything you’re looking forward to in the conference? 

*SPJ (0:10:47)*: Mainly the networking part that you described, right? Meeting a lot of old friends. I’m looking forward to the next session, which has quite several interesting papers. One, Paul Downen’s about to give a talk about Call-By-Push-Value. I had the honor of having dinner with him last night. And so my head is full of Call-By-Push-Value and computation types and value types, and I’m still trying to keep them straight in my head. But Paul’s got a very interesting balance of he’s a very deep theoretician. He understands about polarization and duality, but he’s also very interested in how many registered transfers it takes. So I’m looking forward to his talk, among others.

We’re also doing a — this year, we’ve lost three members of the functional programming community—David Turner, Arvind, and Alan Jeffrey. So it’s been a sad year in some ways, but this evening we’re just going to do a little memorial for Arvind and for David Turner. Alan’s coming tomorrow. And so, I don’t know. I’m not exactly looking forward to it, but it’s high in my mind at the moment. I’m thinking about Arvind and remembering him and how we can do that together.

*SF (0:11:51)*: Nice. Could you let us know what you’re working on at the moment, a little insight? 

*SPJ (0:11:55)*: Oh, what am I doing at the moment? So, two main chunks of stuff. One is Haskell and functional programming. And here, I feel a bit embarrassed. I used to write four papers a year. And I haven’t written a Haskell paper for a whole year, somehow. Because what’s happening? I’m doing a lot of programming in GHC. I feel as if we had quite a big series of changes in GHC, particularly adding visible type applications and visible type abstractions and quite a lot of features inspired by dependent types. And just settling all that down and consolidating it is taking quite a long time and a lot of my cycles. So I spend quite a lot of time reviewing code that other people are writing. 

Oh, and then people write GHC proposals, and then they build implementations of those proposals. And then I end up reviewing code for that. So that’s quite a big chunk. It feels as if it’s not that glamorous at the moment, but it’s quite worthwhile because I really want Haskell to be a language where we have filled out the corners and where things just work. They don’t embarrassingly not work. I’m quite pleased about it. 

And then on the Verse side, there, that’s more research, as it turns out. Verse, although it’s been built by our company, Epic Games, is a big research project, really. We’re trying to take functional logic programming and make it mainstream. 

But the particular thing we’ve been working on at the moment is verification. So inverse verification is the name we give to type checking, because inverse, a type, is just a function, a completely first class function. You can write an arbitrary function that can be a Verse type. And that means that the verifier, which is meant to check that well-typed programs, that is, verified programs, don’t go wrong—the verifier has to reason about all of this. And that’s quite a challenge because Verse is itself a complicated language. So how do you get the verifier to reason about all of that? 

So we got quite, what I think maybe, a fairly new approach to taking the rewrite system that we built to describe Verse. That was in our last year’s ICFP paper. Add some new language constructs and some new rewrite rules, and then that rewrite system becomes a verifier. And yet, somehow, in the process of doing the rewriting, it squeezes out to the side some proof obligations that are written in a much smaller language that we can then feed to Z3 for things like, if we know that x is bigger than 3, then we know that x is bigger than 2. I don’t want to have to reinvent that wheel.

So that’s quite exciting because I think it’s a genuine research project, but it’s also one based in reality. We’re really trying to build a programming language that people can use. So it’s frustratingly slow in some ways because it’s a research project. And with research projects, that doesn’t usually matter so much, but because this one is linked to a language that’s actually being delivered, I’m feeling the pressure. Mainly internally generated.

*SF (0:14:27)*: Nice. And you’re giving the GHC update at the Haskell Symposium, right? Any headlines you can give to us?

*SPJ (0:14:33)*: Oh, GHC is like a — it’s hard to give a headline because it’s like there’s 20 or 30 people in the room all beavering away doing interesting things. And my job is just to summarize very quickly what they’re all doing. 

There isn’t at the moment one big thing that is dominating the news as it were. But I do think that a big headline change of culture is that we’re much, much more careful about breaking people’s code. So that’s previously been a complaint about Haskell—that upgrading to a new version of the compiler is really hard. But actually, there’s no reason in principle why GHC 9.10 should not be able to compile every program that GHC 9.8 does in the same way because it doesn’t use the new extensions. The new compiler should be able to do everything the old compiler did. It sounds easy. In the past, we have not really thought about that very much. Now we’re thinking about it a lot. 

It is actually surprisingly tricky. Now, particularly when you get to things like Template Haskell and changes in the Prelude, for example, right? If you just add a function to the Prelude, suddenly, if you export foldl-prime, then people who define foldl-prime locally, suddenly that breaks their code. That’s in turn led to a GHC proposal that says you shouldn’t complain about imports if there’s a local binding that overrides it. Currently, that’s a complaint. It’s an error, in fact. 

So how to say this? It doesn’t sound very romantic or dramatic or researchy, but I think there’s a lot going on in GHC land that’s consolidating the beast into something—a tool that you can really depend on, as a lot of companies now do. 

*SF (0:16:07)*: Amazing. Thank you very much. Enjoy the rest —

*SPJ (0:16:10)*: Also, one other thing. I’m interested in people listening to this. I think, for the Haskell ecosystem, we’re gradually moving from this sort of Wild West scenario to a situation in which we’re trying to make Haskell and Cabal and Stack and Hackage and HLS into tools that you can really rely on. But where I feel as if we’re increasingly vulnerable to the tragedy of the commons, that is that everybody wants to use these things and wants to be able to rely on them, but they’ve all become too big and too demanding for individual volunteers to manage. And so people get burnt out very easily, or at least discouraged. They don’t feel like contributing. And yet we haven’t got to the scale, like Linux, say, where you can’t not belong to the Linux foundation if you’re a big company that uses Linux. So we’re in that awkward intermediate phase. 

And so I’m really looking around for people and companies and institutions and ideas for how to make the Haskell ecosystem, which—and I’m very proud of it—is a gift economy in which people bring the gifts that they have to share the gifts that other people have bought. I would love to enable that to scale up without burning everybody out, right? I want to find a way to make it more sustainable. I don’t quite know how to do that, but I suspect that together we can make that happen. 

*SF (0:17:25)*: Sounds good. Is there anything else? 

*SPJ (0:17:26)*: No, I think that’s it. Yeah. 

*SF (0:17:27)*: No? Enjoy the rest of the conference.

Right. We’re here with some PLMW students to find out how they’re finding. Is it your first conference, guys?

*Student 1 (0:17:40)*: Yes. This is my first conference.

*SF (0:17:41)*: Nice.

*Student 2 (0:17:42)*: Yeah. Mine as well. I’m for the first time on a academic conference.

*SF (0:17:46)*: Amazing. So how are you finding it?

*Student 1 (0:17:47)*: It’s really good. People are very open to discuss topics and also to exchange contacts. 

*Student 2 (0:17:54)*: It’s actually better than expected, and I expected it to be good. The lectures are fine and are mostly on a level that I’m comfortable with, but is a bit above my level. So I’m learning lots of stuff. And I think I’m pretty satisfied with it. 

*MPG (0:18:11)*: All right. So what’s been your favorite talk so far?

*Student 1 (0:18:15)*: Okay. My favorite talk was the keynote today by Andrew Gordon. And yeah, it was really good because he was explaining all about how large language models can be used in everyday business applications, especially Excel. And I was also quite excited to learn about the Cogna startup that he’s working on.

*Student 2 (0:18:36)*: Yeah. Well, the one that caught my eye was one that talked about model logic and incorporating it into dependent type systems. And I know this is a Haskell podcast and Haskell doesn’t have dependent types, but I know that lots of Haskell programmers are hoping for dependent types. And this system was looking really promising because the way it was structured looked very applicable to more normal programming languages as opposed to things like Agda, where you have to think actively about the dependent type system.

*MPG (0:19:13)*: All right, great. So is there anything you’re looking forward to at the rest of the conference? 

*Student 1 (0:19:17)*: Indeed, I’m looking forward for tutorials at the end of the conference, and especially I’m looking forward for the Scheme one and also maybe OCaml because I don’t have experience with that. But for Scheme, I’m really excited because I teach higher-order programming in Scheme, and I want to see if there’s anything I can gain and maybe this year have like a bonus exercise for my students, or maybe just a fun exercise for them.

*Student 2 (0:19:45)*: Yeah. Well, I’m here for mainly the paper talks, and I’ll see what that has in store. I bet there will be great papers to come.

*MPG (0:19:55)*: All right. Thank you so much.

On the second day of ICFP, and also my birthday —

*SF (0:20:06)*: Happy birthday.

*MPG (0:20:07)*: We caught a few more attendees. We spoke to Sara Juhosova. The runner-up in the Student Research Competition, Yaron Minsky from Jane Street, not just the T-shirt company, Marco Gaboardi from Boston University and one of the organizers, PLMW speaker Harry Goldstein, who’s recently graduated from UPenn and is now a postdoc at Maryland, and finally David Binder from the University of Tübingen. 

*SF (0:20:32)*: All right. It’s now day two at ICFP and we’re here with Sara, one of the ICFP Student Research Competition finalists. How are you finding the competition?

*Sara Juhosova (0:20:42)*: Well, I actually really enjoyed the poster session yesterday. So many people came to talk to me. There were — well, actually, the competition or the poster presentations only started at 6:30, but the posters were up since earlier. And I think I was literally talking to people for three hours straight, and everybody had questions. And it was really nice to see people so interested in what I was doing.

*SF (0:21:03)*: Well, what is your project? Could you give us your spiel?

*SJ (0:21:06)*: Yeah, of course. So I actually recently started a PhD on the usability of interactive theorem provers and not really sure where to start. I decided to start at the beginning because, as you know, they tend to have quite a steep learning curve, and I wanted to see what it is that forms those obstacles that stop novices from continuing to learn. So I actually interviewed or I did a survey where students from a bachelor course where they learned to use Haskell and their Agda just had to list the obstacles they encountered. And I did some analysis on that and figured out five main obstacles that people actually face. 

*SF (0:21:46)*: What are they? 

*SJ (0:21:46)*: So there are some obstacles on the theory level. Of course, it’s very unfamiliar. Working in Agda is quite a paradigm shift, I would say. And not only that, but the theory that underlies Agda and other interactive theorem provers is very complex. So it’s unfamiliar and it is difficult. So that’s pertains to the theory. But then you also have some obstacles on the implementation level, one of which is “weird design.” So the students were like, “Why do we have Unicodes?” Well, of course, from a mathematical perspective, that makes sense, but to someone coming from other programming languages, that’s a very strange concept. And there’s other things like error messages, having to put spaces in correct places, et cetera. And there’s also the problem of an inadequate ecosystem, as I called it, which is really tools that they’re really well intended. You see it a lot. You have some options to install things automatically, but they are not quite pulled through and they don’t work the way they’re supposed to, which is very sad because you see these people have had these ideas of what to improve, but there is never the time to actually make it work properly.

And I think finally, there is an obstacle on the point of view of applicability in the real world, which is that the students find it really hard to understand how Agda is relevant, right? They come from a course about computer science where they learn that software is something you make for users. You create something, you show them something, you interact. And software, as you see it, as they see it, does not match with how we think of software in Agda. So I think that’s something that adds quite a lot to the frustrations. 

*SF (0:23:24)*: Nice. There’s actually quite a lot of work coming out recently about the usability of programming languages. Could you comment on that more in general and how you find it important?

*SJ (0:23:33)*: I have read some great work where people are thinking about this. There is a really nice paper about Liquid Java where actually they start by saying, “Okay, this paper, it’s about the design of this tool. And we’re going to ask users what they find acceptable and what they would want. And we’re going to design that tool based on what they want.” And I think that’s really nice because, as we’ve talked before, right now, Agda, Coq, they very much are born in the math, then comes the tool, and then comes the users. And I find it really nice that there are people who are trying to approach it from the opposite direction. So first come the users, then comes the tool, and then comes the math, which I think is really nice.

*SF (0:24:12)*: That’s all really great stuff. What else are you enjoying about the conference here at ICFP?

*SJ (0:24:16)*: Well, I must say on the first day that I was here, I found it very difficult to know how to approach people, who to talk with. The poster session yesterday helped a lot because now people know who I am, what I work on. And I found it so nice that this morning people actually came up to me and were like, “Oh, we talked yesterday about your poster,” or “Oh, I saw your poster. It’s nice to see you.” And it’s really nice to see how naturally it comes, the connection, once you present some of your work. So yeah, I’m enjoying that change quite a lot.

*SF (0:24:50)*: Nice. I’m glad to hear that. Enjoy the rest of the conference. Thank you. 

*MPG (0:25:03)*: All right. We’re here with Yaron Minsky from Jane Street, one of the sponsors of the conference. So how do you like the conference so far? 

*Yaron Minsky (0:25:10)*: It’s been great. 

*MPG (0:25:11)*: So why does Jane Street always sponsor ICFP?

*YM (0:25:16)*: So, we started getting involved in ICFP a long time ago. I think I came to the first Commercial Users of Functional Programming Workshop at James Street in 2006. And someone from James Street has been here every year since then. James Street is a place that really cares about tools and programming languages in particular. And we’ve been using OCaml since that time. And OCaml obviously is a language that grew out of this academic community. And so we’ve both learned a lot from the community and, over time, have had the opportunity to contribute our own ideas and extensions to the language over time. And so, I don’t know. In general, there’s been a lot of connection between the work at James Street and the work with the broader ICFP community, and this is a great place to meet people and connect on all of that. 

*MPG (0:25:59)*: Yeah. So what have you been most excited about this conference?

*YM (0:26:03)*: Oh, so I was really excited to hear Martin Odersky’s talk about a bunch of the work that they’re doing in Scala, which parallels actually a lot of the work that we’re doing in OCaml around capabilities and control of effects and how that fits into things like data race freedom and various other things that we’re thinking about adding to OCaml as well. So it was nice seeing parallel evolution of some of the ideas that we’re thinking about and that other people in the community are thinking about as well.

*MPG (0:26:27)*: So I got to ask one last question. Jane Street, we all wear the Jane Street T-shirts all the time. Could you tell us, like, how did that get started?

*YM (0:26:35)*: So, I mean, I think we started making T-shirts internally on a lark. Stephen Weeks, who’s one of the early serious developers at Jane Street and actually also famously the author of MLton, which is a really excellent SML compiler, at some point early on made this great T-shirt called “Enter the Monad.” And that was one of our early functional programming T-shirts. And just since then, we’ve created a lot of other variants on them. We just thought it’s a fun thing to do. And now that Jane Street is massively bigger and we have people on staff who think about making swag and stuff like that, it’s just like a fun thing that we do every year, and not just for this conference, but for lots of different places that we go.

*MPG (0:27:15)*: Yeah. All right. Thank you so much. 

*YM (0:27:16)*: My pleasure.

*SF (0:27:26)*: Okay. We’re here now with the general chair, Marco. How are you finding being an organizer? 

*Marco Gaboardi (0:27:31)*: It’s great to organize ICFP, although it poses several challenges. But for me, giving something to the community is great. And that’s why I organize it. 

*SF (0:27:43)*: Have you gotten a chance to actually enjoy the conference when you’ve just been running around?

*MG (0:27:49)*: I would not just say enjoying, but there is always something to run around for. But I’m happy with the result, although I know it’s not perfect. But overall, I think it’s a good ICFP.

*SF (0:28:06)*: Nice. Is there anything you’ve particularly enjoyed or you’re looking forward to this conference? 

*MG (0:28:11)*: I’m really enjoying the keynotes talk. I think we had two great keynotes talks, and we will have one more. I also enjoy the fact that we can attend most of the talk because we have a single track, although I know that it makes the program pretty packed. And so we have a lot of things going on.

*SF (0:28:32)*: Nice. Well, thanks for speaking to us, and thank you so much for being general chair.

*MG (0:28:36)*: Thank you for doing this.

*SF (0:28:47)*: All right. We’re here with Harry now. How have you been enjoying the conference?

*Harry Goldstein (0:28:50)*: It’s been awesome so far.

*SF (0:28:51)*: I really loved your PLMW talk. Could you tell us a little bit more about it?

*HG (0:28:55)*: Yeah, absolutely. The talk was on my PhD compass, the different directions that I think new PhD students should think about going in. And it was super fun. It was a really good time.

*SF (0:29:08)*: Is there anything you’ve particularly enjoyed or you’re particularly looking forward to?

*HG (0:29:11)*: Well, the keynotes were really good. I’ve been going to some really great sessions. There was a talk by Cameron Moy on — it was a nice pearl talk on some cool parsing stuff, which I really loved. And then there’s a paper on the tool called Mica by a master student Ernest Ng, who I worked with, and that’s going to be at the OCaml Workshop. So I’m excited for folks to hear about that. 

*SF (0:29:36)*: Lovey. Can’t wait. Thanks for speaking to us.

*HG (0:29:38)*: Thank you.

*MPG (0:29:52)*: All right. We’re here with David. Tell us, David, what have you been most excited about this conference? 

*David Binder (0:29:58)*: I mean, I’m mostly interested in meeting all the people that when I’ve read their papers and then you can ask the questions. And I also met some collaborators that I’ve wrote papers with in the past. So I’m meeting them here for the first time, which is really exciting when you only met via Zoom in the past. So yes, meeting and talking to people is what mostly brings me here.

*MPG (0:30:20)*: That’s cool. So is there anything you’ve been specifically excited about this conference?

*DB (0:30:24)*: Yeah. So yesterday we had a great session about intermediate representations and various advancements on how to reason about intermediate representations, CPS style calculi, and how we can combine high-level languages and compile them to efficient code.

*MPG (0:30:42)*: Yeah. Cool. Is there anything you’re looking forward to? 

*DB (0:30:44)*: Yeah. Today there’s going to be a great talk about doing complexity analysis in call-by-need languages. So I’m looking forward to see how we can reason compositionally about lazy functional programs.

*MPG (0:30:58)*: All right. That’s cool. Thank you so much for being on.

*DB (0:31:00)*: Thanks.

*SF (0:31:12)*: On the last day of ICFP, we grabbed our very own Niki Vazou after her keynote. All right, we’re here now with Niki, one of our keynote speakers. How are you enjoying the conference so far? 

*Niki Vazou (0:31:22)*: Oh, I really like the conference. So I am happy now that I finished my keynote. Yes, I think it went well. I did the standard Liquid Haskell demo. And then what I think people actually enjoyed is that in the keynote I described all the history of refinement types. Like refinement types were first introduced at 1991. And then I explained the history and the most important steps on how they led to Liquid Haskell. That started actually 10 years ago. And I think the most important step was people told me that they didn’t know that. It was a paper by Flanagan that is called hybrid types. And I think everybody should read this paper for many reasons.

*SF (0:32:09)*: Well, I certainly enjoyed the talk and all the history. Are there any talks you’ve particularly enjoyed or you’re looking forward to?

*NV (0:32:15)*: I actually look forward to the last talk of this section that Jose — it’s Jose, and he talks about their experience using Haskell for standard charters. And it’s an experience report, and I am very curious about it because I have heard that they use their Haskell applications to move around much money. So I am looking forward for this talk. Yes.

*SF (0:32:41)*: Nice. I better be there too. Thank you for your time. 

*NV (0:32:43)*: Thank you.

*MPG (0:32:52)*: All right. That was all.

*SF (0:32:54)*: A special thank you to Dmitri Tymoczko, Lucia Ang, Maria Ang, Tae Hong Park, Alex McLean, Yoni Maltsman, Cecilia Suhr, Stefano Panelli, and Luca Carillo for allowing us to use the music that you heard in this episode.

*MPG (0:33:13)*: Thank you so much for listening and hope you enjoyed this episode.

*Narrator (0:33:19)*: The Haskell Interlude Podcast is a project of the Haskell Foundation. It’s made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
