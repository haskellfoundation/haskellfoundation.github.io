*Jessica Foster (0:00:16)*: Welcome to the Haskell Interlude. This is the first part of a mini-series on this year’s Symposium on Principles of Programming Languages, aka POPL 2026. 

Hi, I’m Jessica Foster, and I’m one of the editors of this podcast. But back in January, I took a couple of microphones to go to POPL 2026 in Rennes, France, and thought I’d give this whole interviewing thing a go. I got a little bit carried away and ended up interviewing 14 different people for a total of almost three hours of raw audio, hence why this is only part one. 

Now, I must warn you, the amount of actual Haskell discussed in each interview varies quite a lot. In my interview with Well-Typed’s Rodrigo Mesquita, which will be in a future episode, it’s wall-to-wall Haskell. In this episode, it gets only a handful of mentions, and that’s pretty representative of POPL itself. 

With this series, I want to give you a snapshot of POPL from many different perspectives, from academics to people in industry, professors to undergrads, organizers to attendees. You’ll hear from a wide variety of people with a wide range of interests who come from all over the world to get together, share their knowledge, and enjoy each other’s company, or at least the ones who enjoyed my company enough to not run a mile at the phrase, “Would you like to be on my podcast?” 

In this episode, we talk about undergrad funding and participation, the behind-the-scenes of AV, choreographic programming, quantum languages, conference catering, and the joy of theory. And at one point, you’ll even hear us get kicked out of the venue mid-interview. Enjoy. 

Okay. So it is Monday here at POPL in Rennes. I’m here with Nicola Assolini. Say hello.

*Nicola Assolini (0:02:11)*: Hi, everyone.

*JF (0:02:12)*: He is currently working at Quantinuum. And I’m also here with One An. Say hello.

*One An (0:02:17)*: Hello.

*JF (0:02:17)*: One An is a undergraduate student at University of Pennsylvania. But starting with you, Nicola, so what are you here for today?

*NA (0:02:25)*: I’m here as a AV chair of this conference. Me with other people, we care about the AV part of the conference, audio video, meaning that we record and stream all the various talks.

*JF (0:02:36)*: And quite an important part of the conference as well, right? Considering afterwards, what is the evidence of any of the stuff that we’ve done here today? It lives in our memories, but it also lives online, on SIGPLAN, on YouTube. Go check it out. Yeah, what kind of stuff do you do for AV? Like, what goes into this? Because lots of people don’t see what happens behind the scenes. Like, what’s the work that you have to put in to make any of this work?

*NA (0:02:57)*: That’s quite a good question. I mean, first of all, it’s very important because, as you said, it’s important not only to save papers but also to record and save the presentation of the people, because sometimes it can be more useful, the presentation, than the paper itself.

Yeah, basically, what we did, it actually started quite before the conference when we basically worked with the general chair of the conference, helping them to organize, to review the contract with the venue, and all this kind of stuff. And then when the actual conference starts, we work with the venue team in setting up the room, because we have some other equipment that must interface with the venue equipment. So we make sure that everything is set properly and everything is connected together for work properly. And during the conference, we check if the recording and the streaming is going well.

*JF (0:03:47)*: How has it gone so far? Is there any difficulties or relatively smooth?

*NA (0:03:51)*: Yeah, it’s already smooth, I say.

*JF (0:03:52)*: Okay, good.

*NA (0:03:52)*: I’m quite happy so far. And also, the venue was pretty supportive. So yeah, I’m happy.

*JF (0:03:57)*: Okay, that’s good. They are kicking you out at seven today, though, so you’ve got to be speedy. But how many of you are there, the AV chairs?

*NA (0:04:05)*: For this conference, we are four.

*JF (0:04:07)*: Four. Okay.

*NA (0:04:07)*: Yes.

*JF (0:04:08)*: So, it’s quite a stripped-down team there. How many workshops do we have in parallel at once?

*NA (0:04:13)*: We have in parallel at most five workshop –

*JF (0:04:16)*: Okay.

*NA (0:04:16)*: – but we are covering up to three due to the reduced number of the AV staff. But we can rely on volunteers, too.

*JF (0:04:24)*: Well, there you go, folks. If you’re out there, if you’re a person who’s handy at AV, then get involved. You get a free trip around the world. You get to help out the programming languages community. Get involved. Get help with the staffing. So, moving on to the conference itself, you’re sort of attending. You’re doing the AV, but you also get the benefit of actually going to these workshops and going to the talks and things like that. So what have you seen today? What were you here for?

*NA (0:04:48)*: I mean, I work in quantum computing, so I also follow a bit of some talks of the quantum workshop at POPL that’s called PLanQC.

*JF (0:04:56)*: Any good ones?

*NA (0:04:58)*: Yeah, I think the keynote was good.

*JF (0:04:59)*: What was the keynote about? What did you want us to know?

*NA (0:05:01)*: Yeah, it was about like using path-sum representation to do verification in quantum. That is this different way to represent quantum state to try to limitate the exponential blowup of the quantum state, because when you are representing a quantum state in number, in metrics, let’s say, you have an exponential blowup. So there are some techniques that try to compress this representation.

*JF (0:05:23)*: Great. And what kind of stuff are you looking forward to? Is there anything in the coming days that looks interesting to you?

*NA (0:05:28)*: Okay. Yeah, I’m definitely interested to the two quantum track at POPL.

*JF (0:05:32)*: So there’s quantum at POPL as well. Okay, nice.

*NA (0:05:33)*: Yeah, there are two tracks. So it is, yeah. 

*JF (0:05:35)*: Oh, two track.

*NA (0:05:35)*: Yeah.

*JF (0:05:36)*: Wow.

*NA (0:05:36)*: Yeah. Quantum is growing at POPL, yeah.

*JF (0:05:38)*: Only one functional programming track, but, okay, nice. Yeah. Any particular talks that – 

*NA (0:05:42)*: I mean, I haven’t looked specific at the paper. I’m curious about one work that is about using tree automata in verification of quantum computing again. That is, again, another techniques to represent quantum state, or set of quantum state, in the most efficient way. I know some previous work from the same group, so I’m curious about the follow-up.

*JF (0:06:00)*: Okay, great. Cool, thank you. Okay, so One An, you are here as a undergraduate student.

*OA (0:06:05)*: Mm-hmm.

*JF (0:06:05)*: That’s exciting. What made you sort of interested in programming languages in the first place? 

*OA (0:06:10)*: So, I liked logic a lot in high school. I liked math and logic. And then I chose my school that I go to University of Pennsylvania, because it’s actually one of the only two schools in the United States that offer a bachelor’s degree for logic. So I did not know any programming at all. My first language was OCaml because of this. Okay, technically, my first language was actually –

*JF (0:06:29)*: On the Haskell podcast.

*OA (0:06:30)*: Oh, I’m sorry.

*JF (0:06:32)*: Shame, shame.

*OA (0:06:33)*: Okay, I –

*JF (0:06:33)*: No, we love OCaml too.

*OA (0:06:35)*: I correct that. My first programming language was actually Lean because I tried Lean in high school. But I guess I wasn’t using it to program any – well, programs are proofs, but – okay, I was using it to program proofs.

*JF (0:06:47)*: Oh.

*OA (0:06:47)*: So I went to Penn because of how good the logic aspect of the math department is, and Penn is kind of the only place in the US, period, that even has a proof theorist.

*JF (0:07:00)*: Big claim. Here at the Haskell Interlude, we’re not sure if that’s true or not.

*OA (0:07:03)*: I think it might be true.

*JF (0:07:05)*: Okay.

*OA (0:07:05)*: He said it himself.

*JF (0:07:05)*: Maybe it’s true. Hey, well, this –

*OA (0:07:06)*: Yeah, he said that himself. 

*JF (0:07:08)*: If it’s not, he’s in trouble.

*OA (0:07:09)*: Okay. I think the correct statement is that he’s the only ordinal analysis person –

*JF (0:07:14)*: Okay.

*OA (0:07:14)*: – in the United States.

*JF (0:07:15)*: That sounds constrained enough. That’s probably true. Yeah.

*OA (0:07:17)*: Yes. I’m sure that there are other people who work on proof theory in the US, but I know that there’s just far more in Europe. And US traditionally is a lot more on model theory, computability because the tradition is that Tarski was the first one who introduced logic to US, and he was obviously – he’s like a semantics guy. So, okay, but getting back on track. 

*JF (0:07:40)*: Yeah, anyway. You wanted to come to POPL. What made you want to come to POPL?

*OA (0:07:43)*: Oh, I wanted to meet people so I can get into grad school.

*JF (0:07:47)*: That’s a great reason.

*OA (0:07:48)*: Yeah.

*JF (0:07:48)*: That’s a perfect reason. And so you were telling me earlier that you applied to PLMW.

*OA (0:07:53)*: Oh.

*JF (0:07:53)*: You’ve applied a few times.

*OA (0:07:54)*: Yes.

*JF (0:07:54)*: But this is your first time getting accepted. So, what does that mean to get accepted to PLMW?

*OA (0:07:58)*: Yeah. PLMW is the Programming Languages Mentoring Workshop, which I think is for maybe undergrads who are interested in PL, maybe early grad students, and also, I think, for industry people who might want to maybe get back into grad school.

*JF (0:08:12)*: People who aren’t already embedded in the PL community or are early in their careers in some way. Yeah.

*OA (0:08:18)*: Yeah. I guess because I haven’t been in the workshop yet, I don’t know what it’s going to be like.

*JF (0:08:23)*: That’s true. The workshop is tomorrow, so that’ll be exciting.

*OA (0:08:25)*: Yeah. Hopefully, they teach me how I can be a successful researcher in the PL community.

*JF (0:08:31)*: That is the goal. But do they pay for some stuff? Like, what is the –

*OA (0:08:34)*: Yes. They are basically covering this entire trip, which I’m really grateful for as –

*JF (0:08:39)*: Okay. So registration fees?

*OA (0:08:41)*: Yup.

*JF (0:08:42)*: Flights?

*OA (0:08:43)*: Yup.

*JF (0:08:43)*: Hotel?

*OA (0:08:44)*: Yup.

*JF (0:08:44)*: What a deal. If you’re out there, apply for PLMW. It’s a good deal. Okay, nice. So, how long have you been here? Have you been here just today, or were you here yesterday?

*OA (0:08:53)*: I was here actually from Saturday because I’m also a volunteer, and I had to attend the volunteer training.

*JF (0:09:00)*: Ah, okay. There you go. So volunteer as well, nice, along with Nicola. And you’re an AV volunteer as well, right? Nicola over there is an AV chair, so you’re sort of like, you have to do all the organizing beforehand and working with the venue and staying after and setting up and blah, blah, blah, blah. But then you, what is your role as a AV volunteer?

*OA (0:09:18)*: So, my role mostly is, I think, controlling the microphone so that there’s not maybe feedback issues with it, that it’s being recorded well. So, the AV chair directs everything, and we’re kind of the hand that actually clicks the things.

*JF (0:09:34)*: What have you seen so far, then? You’ve been here a little while already. Any interesting talks or anything like that? 

*OA (0:09:38)*: Yeah. Yesterday I was at LAFI, Languages for Inference. I think that’s what the conference is called. I was there for volunteering mostly. Today, I went to Certified Proofs and Programs, which is one of the aspects, I think, of POPL that I was really excited for. Keynote was really good, which was mostly talking about how AI and machine learning techniques have been really useful in mathematics, specifically autoformalization. That was quite interesting. But other things that I’ve seen that I liked, there was one about constructive proof of Hilbert’s basis theorem, which is like a really, maybe one of the easier theorems in undergraduate-level algebra. It’s the one that everyone learns. So I learned it relatively recently, and then I get dropped with this bombshell that this is actually a very, very classical result. Even showing that Z, the integer, is Noetherian actually implies a law of excluded middle.

*JF (0:10:33)*: Oh, oh, classical in the logical sense.

*OA (0:10:35)*: Yes.

*JF (0:10:35)*: Right. Yeah, yeah, yeah.

*OA (0:10:35)*: Sorry, “classical” in the logical sense.

*JF (0:10:37)*: Wow, okay.

*OA (0:10:37)*: Not in the quantum –

*JF (0:10:38)*: Interesting.

*OA (0:10:39)*: Yes. So –

*JF (0:10:40)*: Not as in, like, constructive.

*OA (0:10:41)*: Yeah, exactly. So it’s –

*JF (0:10:41)*: It’s a classical law of excluded middle. Yes, okay.

*OA (0:10:43)*: It was trying to build some notion of Noetherian, which is, Noetherian is some class of rings that are nicely behaved in a sense. But it was trying to build this notion of Noetherian rings that is actually constructive, and it turns out you can actually use bar induction for this, which is also kind of neat. Not that I know too much about bar induction, but –

*JF (0:11:03)*: Yeah. Well, people can always go and watch the talk on the livestream VOD or once it gets released as a individual video. But, yeah, great. Is there anything you’re looking forward to in the future days?

*OA (0:11:13)*: There’s one paper that I’m excited to see out of Carnegie Mellon that’s essentially using substructural logic to model effect. I’m also looking towards, I guess, PLMW because that’s how I’m getting invited, but also I’m really excited for RocqPL.

*JF (0:11:28)*: Okay, great. Well, thank you both very much, and enjoy the rest of the conference. 

Okay. I’m here on Monday of POPL, and I’m here with some of the AV team. I’m here with Chris Lam. Say hello.

*Chris Lam (0:11:58)*: Hi. Hi.

*JF (0:11:59)*: And Chris, you are also a graduate student, or what do you do outside of AV here?

*CL (0:12:05)*: Yes. I am currently a graduate student in programming languages under Talia Ringer at University of Illinois. I’m doing work on a couple of different areas. Mostly, the projects with Talia, I’m doing some kind of compiler verification, a kind of proof compilation. So we want to take proofs at source-level programs and turning them into proofs at target-level programs and transforming them alongside the compiled code as we go, and then arriving at nice target-level proofs of programs from just having the source-level proof with no verified compiler in the middle. And so, that’s a fun time.

*JF (0:12:29)*: Neat. Okay. And also, I should say, it is currently quarter to seven. We’re getting kicked out at seven o’clock.

*CL (0:12:36)*: Yes.

*JF (0:12:36)*: But why are we here, Chris? Why are you still here? The conference is over. It finished at 5:30.

*CL (0:12:41)*: So really what we do, or what’s going on, is that after the end of every day, for each conference day, what we do is we have to, first of all, shut off all of the AV equipment that we have. And also, because you can’t really train the volunteers who are helping us run the rooms during the conference itself, because they need to be working it, we need to stay afterwards and train each of the volunteers that will be going on the subsequent days.

Additionally, we have to set up the rooms that will be used on the next days because, once again, you can’t do that during the conference because it has to be in use. So, in order for each room to be up and ready to be recorded and streamed at the beginning of each day, we have to do it either sometime the day before or prior to that setup. We’re lucky today because tomorrow we’re using many of the same rooms, so we didn’t have to do that much of it today, but tomorrow is going to be a little bit rough because the set of rooms that the main tracks are on are disjoint from the set of rooms that the workshops have been in. It’s a set of three new rooms during the day because POPL is a little bit unique in organization this year, because we are getting kicked out at seven, whereas, usually, during many other conferences that are held in hotels instead of proper conference venues, we can pull all-nighters and set things up overnight, which is maybe not the healthiest.

*JF (0:13:39)*: Very unhealthy, the scene here. But you’ve been getting better, is what I understand. I hear that in Singapore, you had a curfew. Is that correct?

*CL (0:13:46)*: I believe so. Yeah. That was, on one hand, much healthier, but on the other hand, the nature of having two conferences in one place at the same time was very much a higher strain on people.

*JF (0:13:54)*: Yes. That was an absurd feat, which is very impressive that it got pulled off at all. 

*CL (0:13:58)*: Yeah. And – yeah.

*JF (0:13:59)*: Yeah. So I’ve heard it’s a bit more chill this time?

*CL (0:14:02)*: Yes. It’s been a bit more chill this time. We’re very thankful to Sandrine and the venue staff here because they’ve been very, very helpful in getting things wired up and helping us with these things. But tomorrow is probably going to be the real test of what’s going on because of the more complicated nature of the main track rooms. There’s a lot of more advanced equipment in those rooms that we have not had to deal with yet. And so we’re going to have to be doing that setup during the day while also running the rest of the rooms, because once again, we are getting kicked out of the venue at seven, so we can’t pull all-nighters and fix stuff. 

*JF (0:14:27)*: Right. And so, more advanced, like what kind of stuff’s going on there? Like sound system, or –

*CL (0:14:30)*: Sound systems, basically, we don’t know yet, which is the problem.

*JF (0:14:34)*: Fantastic. Yeah.

*CL (0:14:35)*: We just know that this venue has a bunch of very much more fancy recording equipment of their own as well. We do not know how well that interfaces with our recording equipment and streaming setup. And also, they have an in-house virtual network, which they’re hoping to use to simulcast the keynote events to the other rooms in POPL because we’re worried about overflow.

*JF (0:14:54)*: Oh, I see.

*CL (0:14:55)*: But also, that might require us to do some signal splitting to get that streamed on the YouTube channel for remote and archival stuff.

*JF (0:15:02)*: And that never goes wrong.

*CL (0:15:04)*: Of course. Yeah. Networking is easily a solved problem, of course.

*JF (0:15:07)*: Just add more stuff to it, add more nodes, and I’m sure nothing will break down. Everything will work perfectly.

*CL (0:15:12)*: Yeah.

*JF (0:15:13)*: Okay. Fantastic. It seems like you’ve been slowly building the resilience of the AV team. I’ve heard that you’ve got new microphones that you got at Singapore?

*CL (0:15:23)*: Yes.

*JF (0:15:23)*: Which is great because – so I was also one of the AV chairs in one of the past conferences, and yeah, sound is a big headache.

*CL (0:15:33)*: Yes.

*JF (0:15:33)*: So, how has that helped at all, having extra microphones? Oh, we’re getting kicked out.

*CL (0:15:37)*: Oh, yeah. We’re probably going to get kicked out.

*JF (0:15:37)*: Here we go. It’s live. It’s happening live.

*Unknown Speaker (0:15:39)*: Closing for 10 minutes.

*JF (0:15:40)*: Sounds good. Okay. Cheers.

*CL (0:15:41)*: Okay. Yes. We’ll be out of here soon.

*JF (0:15:42)*: Okay. We’re getting kicked out.

*CL (0:15:44)*: Yeah.

*JF (0:15:44)*: This is it. We’re up to the wire, people.

*CL (0:15:46)*: Yeah.

*JF (0:15:46)*: Yeah. So, have the microphones helped?

*CL (0:15:48)*: Oh, the microphones have helped a lot. Oftentimes, one of the big headaches on the run-up to the conference, before the conference actually starts, is negotiating contracts for AV equipment, also negotiating for contracts for AV equipment when neither you nor the people involved speak a shared language –

*JF (0:16:02)*: Great. Yes.

*CL (0:16:04)*: – which has been sometimes an interesting experience. But now that we have more in-house equipment, this simplifies this a lot and also saves a decent amount of money, because oftentimes, because people don’t want to just buy microphones for one event and then throw them away, venues can charge an arm and a leg. But because we run more than one conference and have persistent equipment, it is oftentimes cheaper for us to buy microphones and then reuse them for multiple conferences in a row. And we managed to do this for – or we managed to buy some in-house microphone sets at SPLASH and ICFP, and we’ve been using those since then.

*JF (0:16:32)*: Consistent equipment and a continuity of people as well, right? I mean, you’ve been at many of these conferences now. It felt like multiple years since I’ve seen you doing the AV.

*CL (0:16:40)*: Yeah. I think this is my third POPL that I’ve helped run.

*JF (0:16:42)*: Yeah.

*CL (0:16:42)*: Also, this venue –

*JF (0:16:43)*: The sound is going to be changing rapidly as we go through this building.

*CL (0:16:47)*: Yes. And –

*JF (0:16:48)*: The resonance will be changing.

*CL (0:16:50)*: The venue itself is a little bit of a maze. I’ve been very sore the past couple of days, just because of running up and down stairs and all over the place, because it’s just a lot of area to cover. And when you have to fix many different setups, then you end up getting a lot of steps in.

*JF (0:17:04)*: I can imagine.

*CL (0:17:05)*: Yeah.

*JF (0:17:05)*: So, how many people on the team have done this before? 

*CL (0:17:08)*: This time I believe three of us are repeats. For one of us, Nicola, I believe, it is actually his last conference, or not his last conference ever, but his last conference running AV, because he has recently graduated and is doing a real-time job as a productive member of society, unlike the rest of us.

*JF (0:17:23)*: Yeah. I was just talking to him. Well, you guys are important too. You’re here. You’re doing research. This is your job too. I think we’re – oh, we should get coats, shouldn’t we? 

*CL (0:17:31)*: Yes. We should get coats. I also have to stop off at the AV room and grab my backpack.

*JF (0:17:35)*: Okay, great. Well, thank you very much, Chris. That was a very interesting insight behind the scenes of AV here at POPL.

*CL (0:17:41)*: No worries. Thank you for having me.

*JF (0:17:42)*: Thanks.

Cool, yes. I’m here with Satnam. You just got here today or yesterday? 

*Satnam Singh (0:18:00)*: Yeah, I got here on Monday evening, so I sadly missed the first day. I’m looking forward to some talks at VMCAI. So it was a very interesting talk on translating VHDL hardware descriptions to Rocq. But I tracked down one of the authors today and talked to them. But yeah, I’ve been here for the morning and lots of interesting talks and people.

*JF (0:18:17)*: What have you seen? What have been the interesting talks?

*SS (0:18:19)*: Well, there was a talk on choreographic programming, right? 

*JF (0:18:22)*: Oh, yeah. I’ve heard a little bit about that.

*SS (0:18:23)*: So, that builds on Haskell.

*JF (0:18:25)*: Yeah.

*SS (0:18:25)*: The work done by Lindsey Kuper and co.

*JF (0:18:29)*: Yeah.

*SS (0:18:29)*: They’ve got like a cloud version of that. And that involves doing lots of interesting trickery with the Haskell type system, the independent types –

*JF (0:18:36)*: Yeah, yeah.

*SS (0:18:36)*: – which is something I’m a big fan of. 

*JF (0:18:39)*: Yeah, yeah. So explain that. So, choreographic programming, what is that? What’s the idea of that? 

*SS (0:18:42)*: I don’t understand it deeply, but what I like about it is that it turns distributed systems programming back into something which looks like normal programming to me, right? Rather than having these broken-up bits of code which have send and receives between them, all stitched together in some incredible way. It gives you back your main.c, right? So, I like that perspective.

*JF (0:19:01)*: Yeah, I think I spoke to some people at ICFP, the last ICFP, and they were saying that you can write things in a sequential-looking way, but then you attach them somehow so that they end up working in a concurrent thing. Yeah, it seems like a cool idea. 

*SS (0:19:14)*: People have tried to do similar things with client-server code, where they try to write logically with something which looks like one program. And then the tooling splits up into stuff that runs on a server and stuff that runs on a client and tries to make that as transparent as possible.

*JF (0:19:26)*: Yeah.

*SS (0:19:26)*: But yeah, it always has its limits, you know?

*JF (0:19:29)*: Of course.

*SS (0:19:29)*: Dealing with failure and so on, that all typically breaks lots of abstractions.

*JF (0:19:34)*: Yeah. And this talk that you were going to, what was the – so it was building on Haskell, you said it was?

*SS (0:19:38)*: Yeah. So it’s a team from Gothenburg.

*JF (0:19:41)*: Okay.

*SS (0:19:42)*: So they’ve built a library on top of, I guess, Haskell. I think that’s what Lindsey Kuper’s stuff is called. 

*JF (0:19:46)*: Like Haskell Choreography, I think, yeah.

*SS (0:19:47)*: Yeah, yeah. I think there’s – what was it called again? CloudChor, something name of the version of cloud.

*JF (0:19:52)*: Right.

*SS (0:19:52)*: And they built something on top of that as a library.

*JF (0:19:54)*: Oh, cool. 

*SS (0:19:54)*: You can talk in a civilized way about where a value lives, how it’s communicated, how it’s broadcast, et cetera. And that’s a part in the type. The types all look very nice. What I suspect is, off the top of a screen, is that there’s many lines of Haskell extensions.

*JF (0:20:11)*: I can imagine.

*SS (0:20:11)*: Possibly one or two plug-ins, knownnat solvers that we didn’t get to see.

*JF (0:20:16)*: Well, it could just be like GHC 2025 or 20 – I’m not sure what we’re at the moment. Also, we’re sitting here in the lunch hall. We’ve just had lunch. What do you think about the lunch? You’re a food person.

*SS (0:20:25)*: I’m one of the people that has a dietary restriction.

*JF (0:20:27)*: Yeah.

*SS (0:20:27)*: I’m celiac, so I can’t have gluten. And we have these tables here, which say “vegetarians” and “allergies.”

*JF (0:20:32)*: And allergies. Just all of them.

*SS (0:20:35)*: I think what’s happened here is very common, is that they’ve computed the lowest common denominator of everyone’s eating restrictions –

*JF (0:20:42)*: Yes.

*SS (0:20:43)*: – unioned with bread.

*JF (0:20:45)*: So there was still bread here?

*SS (0:20:46)*: Yeah. 

*JF (0:20:47)*: Oh, wow.

*SS (0:20:47)*: So I had to get someone to move the bread away from my position because obviously I’m really 20 parts per million sensitivity.

*JF (0:20:52)*: Take it away from me. Yeah. Oh, my goodness.

*SS (0:20:54)*: And there were still crumbs kind of on the table.

*JF (0:20:55)*: Oh, no.

*SS (0:20:55)*: So I think the food was really tasty, but yeah, I’m not a vegetarian. I don’t want to be forced to eat –

*JF (0:21:02)*: Right. I see. You’re just like, well, you’re not in those normal categories, so you just get that. Yeah.

*SS (0:21:07)*: Lunch was on the light side, but yeah, it was fine. I’m going out to nice restaurants every night, so maybe I could save my appetite for dinner.

*JF (0:21:16)*: Nice. Yeah, yeah. Good. So are you looking forward to anything later in the conference?

*SS (0:21:19)*: I haven’t looked at the agenda in detail because I’ve been sent here by my company to recruit. So my job is to –

*JF (0:21:27)*: Ah, yes. Recruitment.

*SS (0:21:28)*: – hire people to come and work at Harmonic.

*JF (0:21:30)*: At Harmonic? Okay. What is Harmonic?

*SS (0:21:32)*: So, Harmonic – so we sponsor the conference. It’s a very small startup in California. The key technology it has is a tool based on machine learning. You give it a Lean theorem.

*JF (0:21:42)*: Okay.

*SS (0:21:42)*: And instead of proving the theorem, you write “sorry.”

*JF (0:21:44)*: Yeah.

*SS (0:21:44)*: And you send that by API request to our servers. And it hopefully gives you back your theorem with the sorry filled in. So it tries to –

*JF (0:21:53)*: Oh, okay.

*SS (0:21:53)*: It uses machine learning to prove theorems. Again, it’s a totally new take on theorems for free.

*JF (0:21:59)*: Ah. Are you sure you take theorems for – give it to us, and we’ll give it back to you for free. Yeah. 

*SS (0:22:04)*: It’s incredible what it can do. It won –

*JF (0:22:06)*: Yeah.

*SS (0:22:07)*: So there’s a famous math competition, the International Math Olympiad. And in 2025, last year, it got a gold-level performance. So it did incredibly well. So did a submission from DeepMind, from OpenAI, and I think from ByteDance as well. But those are big companies with lots of people working there. This is, I think, at the time, a 14-person company or whatever that did this. So I think this is quite a superpower. And I think this year, 2026, is a year we’re going to see phenomenal advances at the intersection of machine learning, mathematics, and proving theorems, especially. But so far, the focus has been proving theorems for mathematicians, but I think we’re going to pivot now to proving theorems for hardware, for circuits, as well as for software, too. And so I think that’s quite – I’m very excited by that.

*JF (0:22:52)*: That sounds cool. And so you say “machine learning.” Is that like LLMs? Is that like something else? 

*SS (0:22:55)*: Yeah, based on LLMs. And even here, I think we see the effect of it. So I think Ilya Sergey here has – actually, I’m looking forward to some of his talk –

*JF (0:23:03)*: Oh, yeah.

*SS (0:23:03)*: – because he uses our company’s tools to do his proofs for his papers, right?

*JF (0:23:06)*: Right. Okay.

*SS (0:23:07)*: So he writes a lemma, then submits API request, and we give him a proof back, and he puts the proof in his POPL paper, right?

*JF (0:23:13)*: You check the service. Oh, I see. Yeah, yeah.

*SS (0:23:14)*: So I think he’s maybe the first example of someone in this community who has written a paper that has a proof that’s been generated by AI, and that’s part of an accepted paper. So I think we’re going to see more and more of that, right? Whereas it’s routine to have proofs in these papers at POPL and other conferences, but proofs that are written by humans before. More and more of them are going to be written by LLMs in future, right? 

*JF (0:23:36)*: So I’m quite an anti-LLM person, but this is one of the areas where I think it’s a more reasonable take, right? Because you can verify it. That’s the whole point.

*SS (0:23:44)*: That is one of the main strengths of our company, Harmonic, is that our system doesn’t hallucinate, right? So you put it into Lean, and it checks whether it actually is a inhabitant of the type or not, right? So I think that’s what makes it, I think, to me, particularly compelling. It’s an LLM that you know is not lying to you.

*JF (0:24:00)*: Yeah. And I think that seems to be the most reasonable application of LLMs. I mean, I don’t know how much you think that’s worth in terms of whether it adds up to this trillion-dollar industry, but I think that’s quite a useful use. So, yeah, that’s very interesting. Any other things that have been sort of – or if you want to talk about the role a bit more, like what are you recruiting for?

*SS (0:24:19)*: Well, I mean, I’m looking for people that have got experience in programming languages, program language semantics, and theorem proving people who have used Rocq or Lean or Agda, people who have the same level of excitement and interest about if you’ve got this big hammer that could crank out proofs for you, what can you do with that, right? So you don’t need to be a machine learning – I mean, I’m not a machine learning person. I’m not here to hire machine learning people. I’m interested in people that know about theorem proving, programming languages, semantics, because we want to connect this engine to the wider world to solve problems beyond just mathematics.

*JF (0:24:50)*: Right. Yeah.

*SS (0:24:51)*: So, whatever these problems are, somehow we have to map them to Lean to work with our engine.

*JF (0:24:56)*: Which is the thing that, as a PL community, we’ve had to be doing like this whole time anyway.

*SS (0:25:00)*: Yeah, yeah.

*JF (0:25:01)*: So this is the perfect place to find those people. So yeah, if that’s you, then get in contact with Satnam.

*SS (0:25:05)*: Yes, we’ve got some postcards down at the registration desk. You can look at our website, and actually, it’s free to access our service. You just sign up, you get your API key, you get a client, you run it on your machine, and you can upload a Lean file with a sorry in it, and hopefully it will come back with the sorry.

*JF (0:25:23)*: Do you want to plug the website? What’s the website?

*SS (0:25:25)*: Harmonic Fun, or just Google “Harmonic.”

*JF (0:25:27)*: Google Harmonic.

*SS (0:25:27)*: But the URL is harmonic.fun.

*JF (0:25:30)*: Harmonic.fun. Perfect, there you go. Harmonic.fun, check it out. Great. Well, thank you very much, and enjoy the rest of the conference.

*SS (0:25:35)*: Thank you.

*JF (0:25:42)*: Cool. So, I’m here with Kim Worrall. You are a PhD student at the University of Edinburgh. So, what kind of stuff do you work on?

*Kim Worrall (0:25:57)*: So, I work on quantum programming languages and their compilers, a little bit between trying to understand the denotational semantics as well as understanding how we get algorithms better represented in them so that we can adapt them to other algorithms, as well as then trying to understand, once we’ve written these programs, how do we compile them so that we can exploit the kind of parallelism that’s available in a quantum computer but is less obvious when we write the programs themselves?

*JF (0:26:21)*: Yeah. And so we were talking a little bit before this as well, talking about the representations of quantum computers, and I’ve done a little bit of quantum stuff, but I’ve learned a lot from our conversation before. But you’re talking about the structure of a quantum computer and how some of our conceptual models of what that is is maybe not as accurate to the hardware in certain ways. I don’t know. If you give a high-level overview of a quantum computer, what does it actually look like?

*KW (0:26:46)*: So, this is one of those things where, because quantum computers have only really been commercially available for the last five years, that it’s not really been able to reach the limelight, particularly in theory, which has been developing for the last 20. But a quantum computer these days may need to be understood via its control system. The qubits themselves are sort of usually physically static or in some kind of hardware modalities, like ion traps. They might move, but it’s where they’re controlled that the computation is happening. These are, at the moment, usually parallel sets of FPGAs, where a group of maybe four or six qubits are each controlled by a handful of FPGAs. So, one might do the readout, one might do modulating phases, and these can be synchronized so that you can achieve multi-qubit gates. Obviously, in some modalities, maybe one chip will do a multi-qubit gate. But it’s in these chips where you see the classical computer science instructions that’s happening –

*JF (0:27:41)*: Right.

*KW (0:27:42)*: – and the programming. Typically, at the moment, we have separate chips that are used for actually generating the kind of instructions sent to these control chips. Although this is less so the case in modalities that aren’t superconducting, because the clock cycles are much longer for these.

*JF (0:27:59)*: And longer, like, what kind of order of magnitude are we talking here?

*KW (0:28:02)*: Well, so for superconducting, we’re talking nanoseconds. And for things like ion traps, this can be going up to microseconds, so an order of magnitude. But those ones then you can actually do some of your compilation or choosing where you place your qubits on the fly. Whereas if you’re making those decisions for a superconducting computer, they happen so much faster that frequently the instructions are compiled the whole way out and then streamed to these FPGAs. But the main thing is that you have essentially many small classical chips, each of which may have some of its own compute power, and these may only kind of interact with their neighbors.

*JF (0:28:38)*: Okay, great. And you’re trying to bring out the parallelism that programmers might not be able to identify themselves. Can you give us an idea of any techniques for doing that? Like, how can a programmer write something and then find like, “Oh, there’s actually some more parallelism here than I thought there might be”?

*KW (0:28:51)*: So, there’s kind of two ways in which this is appearing in the literature at the moment. So, the first one is the obvious one, which is that if you’re writing quantum circuits, which is the predominant way these are written, you can view this as building a DAG, a directed acyclic graph, where you start at one end and you have some kind of time direction, and it shows you the connection of which qubits are being used at any time step, and then trying to greedily fill as many qubits at any given point, because you can think as a qubit doing nothing like a core idling on a GPU. And so in that case, it’d be ideal to use as many of them as possible at any given time, particularly if you want to just make sure your usage of the computer is maximized. And then there’s the other one, which is saying, “Within this mathematical representation of my algorithm, I can parallelize the implementation more.” So, that means kind of restructuring it. So, one circuit may contain more parallels and then another, and therefore be shorter in some way.

*JF (0:29:51)*: Right. Okay, makes sense.

*KW (0:29:53)*: And trying to find representations that have this more innately or allow us to extract implementations that do this is becoming more popular, as well as looking for abstractions that use our qubits in a more structured manner so that we’re using as many of them as possible at any one time.

*JF (0:30:10)*: Very cool. And so you were at PLanQC yesterday, I assume?

*KW (0:30:13)*: Yes. 

*JF (0:30:14)*: How did you find that? Was there sort of any interesting talks that took your fancy?

*KW (0:30:18)*: I mean, I enjoyed pretty much all of them that I went to.

*JF (0:30:20)*: Okay. Okay. Great. Anyone to shout out? Or you can think of anything.

*KW (0:30:23)*: Is it too biased to shout out the ones from my research group?

*JF (0:30:27)*: No, absolutely not. You should absolutely shout out your research group. Yeah. What ones were –

*KW (0:30:31)*: Everyone should obviously check in on all the work we’re doing in Edinburgh. We’re very cool. We also have some talks.

*JF (0:30:36)*: Yeah. Which ones off the top of your head? Like, what were they?

*KW (0:30:39)*: So there were two yesterday. We had Louis talking about one rig to rule them all. If you’re interested in some category theory and completeness, that’s about modeling quantum control but structurally, by which we mean using one mathematical structure to reason about it. And – oh, wait, there weren’t two yesterday. There was – oh, well, Robert was also – so, the last talk of the day was another category thing. 

*JF (0:31:00)*: Was that Robert Rand?

*KW (0:31:01)*: No, Robert Booth.

*JF (0:31:02)*: Robert Booth. Okay.

*KW (0:31:02)*: But he wasn’t talking. It was actually Cole.

*JF (0:31:05)*: Oh, I see. Okay.

*KW (0:31:06)*: In my head, it was two.

*JF (0:31:07)*: Okay. 

*KW (0:31:07)*: There’s actually – I think that we’ve got three talks in the main conference.

*JF (0:31:11)*: Nice.

*KW (0:31:12)*: And so –

*JF (0:31:13)*: And POPL proper.

*KW (0:31:14)*: Yeah.

*JF (0:31:14)*: Oh, wow. Okay, great.

*KW (0:31:15)*: I forgot everyone’s here because of this.

*JF (0:31:18)*: Right. Yeah. No, no. 

*KW (0:31:19)*: We’ve been busy.

*JF (0:31:20)*: So, was that the one with something about symmetric monoidal categories, or was that a different one I’m thinking of? Maybe a different one.

*KW (0:31:25)*: There were at least two that said –

*JF (0:31:27)*: Okay.

*KW (0:31:27)*: – symmetric monoidal categories.

*JF (0:31:28)*: Yeah, yeah. Well, it’s something I’m interested in as well in the – I’ve been doing some like arrows-related stuff, and there’s a –

*KW (0:31:35)*: Oh, okay. That makes sense.

*JF (0:31:36)*: There’s something there with a symmetric monoidal category thing, and part of what I’m thinking of is how to sell that and like –

*KW (0:31:41)*: Our group had some work. So Chris and Robin – so Chris is my supervisor. They had some work on using arrows to add measurement and discarding.

*JF (0:31:50)*: Interesting. Was that at this conference or at a previous –

*KW (0:31:54)*: A couple of POPLs ago, I think.

*JF (0:31:55)*: Okay. Interesting. I should maybe look into that one.

*KW (0:31:58)*: And then the other thing we do a lot of is rig categories.

*JF (0:32:00)*: Yes, yeah, the rig categories.

*KW (0:32:01)*: So that was what Louis was talking about.

*JF (0:32:03)*: Could you give a high-level idea of what a rig category is?

*KW (0:32:06)*: Yeah. Sorry, Louis forgot to do that yesterday.

*JF (0:32:08)*: Oh, okay. So one rig to rule them all, but what is a rig?

*KW (0:32:11)*: So a rig category is a category with two monoidal products that distribute over each other in a well-behaved way.

*JF (0:32:19)*: Okay.

*KW (0:32:19)*: You can think of them as the categorification of a ring without negation. And that means you’ve got a monoidal product, which is a plus, and it has a unit, which is zero, and you have a monoidal product, which is times, and it has a unit, which is one.

*JF (0:32:34)*: Right. Okay.

*KW (0:32:35)*: And these distribute over each other in the way that you would expect a plus and a times to.

*JF (0:32:39)*: Okay.

*KW (0:32:40)*: And the zero annihilates in the way you would expect, and the one disappears with respect to the times in the way you would expect. And we look at rig groupoids because we want to have local inverses that allows you to have things like a Hadamard morphism.

*JF (0:32:54)*: Okay. I just got it. It’s a ring without the negation, so it’s a ring without the n –

*KW (0:32:59)*: Yes.

*JF (0:32:59)*: – so it’s a rig. Nice. Very clever. Okay. Fun fact. 

*KW (0:33:03)*: And we look at the categorification of this. So your morphisms aren’t necessarily natural numbers, and they happen to be useful for modeling quantum things. They were first studied for modeling reversible computing.

*JF (0:33:15)*: Right.

*KW (0:33:17)*: So you can say that 1 + 1 represents a Boolean. The object 1 + 1 has two possible states. So one of them is true, and one of them is false.

*JF (0:33:27)*: Oh, so we’re thinking in terms of like a sum type, almost like it’s like an either. It’s like a – yeah.

*KW (0:33:32)*: Yes.

*JF (0:33:33)*: This thing or this thing. Okay. Understood.

*KW (0:33:35)*: And then you can swap them, and this can be considered as the NOT operation, and that’s invertible. 

*JF (0:33:42)*: Right. Yes.

*KW (0:33:43)*: And then you can have pairs of Booleans using the times operation.

*JF (0:33:48)*: Right. Okay.

*KW (0:33:49)*: And then my group has done some work on adapting this to quantum computing. They add some square roots of the NOT operation and of the identity, and this is sufficient for universal unitary programming.

*JF (0:34:02)*: Oh, really? Wow. Okay. Neat. So I can see you were talking earlier off-mic about the inductive way of defining a unitary transformation. So is that part of it? Because I can see there’s some sum types –

*KW (0:34:15)*: Yeah. 

*JF (0:34:15)*: – and product types there, and –

*KW (0:34:16)*: That’s the work I’ve been doing –

*JF (0:34:17)*: Okay.

*KW (0:34:18)*: – is looking at ways to define these inductively. So these formalisms start with very simple sets of equations, but those aren’t so fun to actually write programs with.

*JF (0:34:27)*: Right. Yeah.

*KW (0:34:28)*: So you just tend to look for what is the sensible way to compose these. We found that it’s not just kind of post-composing as you would normally do in classical programming, but trying to take advantage of the kind of symmetries you get from things like conjugation of unitaries and even looking at steps between iterations and inserting things there, particularly as those are the ones that tend to cancel when you then compose one recursively defined unitary with another. 

*JF (0:34:55)*: Okay. Great. Thanks very much. And is there anything that you’re looking forward to in the coming days at the conference?

*KW (0:35:00)*: I hadn’t thought about this one.

*JF (0:35:02)*: Obviously, your own group has a couple of things coming up there.

*KW (0:35:04)*: Yeah. Everyone should come see those.

*JF (0:35:06)*: Did you say you have three of them there?

*KW (0:35:09)*: Yeah.

*JF (0:35:09)*: Wow. There you go. So yeah, check out the University of Edinburgh POPL talks. 

*KW (0:35:14)*: Well, the University of Edinburgh Quantum POPL talk, specifically.

*JF (0:35:16)*: Oh, specifically. Yeah. The other ones, don’t bother.

*KW (0:35:18)*: Yeah.

*JF (0:35:18)*: But the quantum ones, it’s the ones to see.

*KW (0:35:20)*: Actually, no, that’s not true because Cristina and Ohad did something cool, and Wenhao did something cool as well. Everyone did cool stuff. 

*JF (0:35:27)*: Yeah. It seems like everyone is doing cool stuff over there, so yeah. Okay, great. Well, thank you very much.

*KW (0:35:31)*: Yeah.

*JF (0:35:31)*: And enjoy the rest of the conference.

Okay. So I’m here with Roger Burtonpatel and Francille Zhuang. It is Tuesday here in Rennes. Francille, you were saying that you have been on the Type Theory Forall podcast. So, for context, Francille, you’re an undergraduate student at Purdue University, and you were on the Type Theory Forall podcast. So, what’s going on? How did you swing that gig?

*Francille Zhuang (0:36:03)*: Yeah. Well, okay. So, first of all, the way I knew Pedro, who’s the host of Type Theory Forall, was that he was my TA for one of my classes in the very beginning.

*JF (0:36:12)*: Oh.

*FZ (0:36:12)*: It was like discrete math or something like that. And then so I was like, “Okay.” And then he gave me this chalkboard, like talk about PL.

*JF (0:36:19)*: Nice.

*FZ (0:36:19)*: I was like, “Hmm, this is really interesting.” And then he left and did his own thing, and then he came back a couple of months ago to visit his friends here. And then I found him at a Halloween party, and I was like, “Hey, I have a proposal for you. I have a business proposal. So I’m applying for PhDs. Can I put an ad on your podcast?” Just advertising myself, trying to find a PhD advisor. He’s just like, “Okay. Do you just want to be on a podcast episode?” And he also invited one of our other friends, Raghav Malik, who just defended, but he is also in PL. And he interviewed both of us in this three-hour session.

*JF (0:36:58)*: Three hours?

*FZ (0:36:59)*: Yeah. 

*JF (0:37:00)*: Oh my goodness. That’s quite an interview. That’s quite an advertisement. That’s good.

*FZ (0:37:03)*: Yeah. 

*JF (0:37:03)*: Well, you can get another shorter advertisement. What’s your pitch? Like, why should a supervisor take on a Francille Zhuang?

*FZ (0:37:11)*: Okay. So right now, I’ve been doing research with property-based testing. So it’s kind of looking at things related with program synthesis, specifically with input generators when it comes to property-based testing. I think it’s really cool. There’s a lot of really cool professors, like Harrison Goldstein at Buffalo. I’m also maybe interested in other research topics as well, because I’ve done this for a year now. I know how this works. But coming here at POPL, there’s so much more interesting stuff.

*JF (0:37:38)*: Great. Yeah. Do you want to just rattle off some topics that you’re interested in, just to put some feelers out there? Anything?

*FZ (0:37:43)*: Yeah.

*JF (0:37:43)*: Yeah. What kind of stuff?

*FZ (0:37:44)*: I don’t know. Like, all those type theory stuff and logics are really cool to me. I feel like I only know much about it.

*JF (0:37:51)*: Yeah.

*FZ (0:37:51)*: But I’ve been hankering for something more abstract because property-based testing is obviously very applied.

*JF (0:37:57)*: I see.

*FZ (0:37:58)*: Yeah.

*JF (0:37:59)*: Okay. Yeah. Great, perfect. Roger, you’re a creative person. You’re a PL person, you’re a creative person. You were at FARM at ICFP recently doing the rock and roll performance, which I will get around to editing in – maybe not by the time this podcast is out, but at some point. 

*Roger Burtonpatel (0:38:15)*: The fans are waiting.

*JF (0:38:16)*: The fans are waiting. The fans are waiting. It was a great performance. I’m looking forward to editing it and getting it out into the world.

*RB (0:38:20)*: No, you’re so fine. Thank you for recording it, and we really look forward to the edited version.

*JF (0:38:23)*: Yeah, yeah. I hope it will be good. But how have you enjoyed POPL so far? Also, maybe give some context. You’re a PhD student or –

*RB (0:38:30)*: That’s right. I just started my PhD. I work with Steve Zdancewic, and I really am enjoying POPL so far. It’s very different. I’ve been to a few other PL conferences. It’s really different from, I mean, even certainly just the last ICFP/SPLASH in terms of size, in terms of vibe. I think this really feels quite intimate and really focused on – of course, I think everyone knows this about POPL, but the love of theory here is tangible, right? You can feel that this is just what people want to talk about at lunch. I was just talking with Yves Bertot at lunch about this inductive representation of rational numbers with three data constructors that he sort of came up with in his bed one morning and then wrote a bunch of papers about some years ago. But it just sort of lit up his eyes and then lit up my eyes because I thought it was so cool, and you get this great proof that the square root of two is irrational. And it just is sort of like back to the roots, but in a really focused and exciting way.

*JF (0:39:24)*: How does that work? There are three constructors for these rationals? What’s the deal?

*RB (0:39:27)*: Sure. So it’s based on – I’m not an expert in this, but he explained it to me while writing it down. So we can do unary numbers with zero and the successor of a unary natural number.

*JF (0:39:37)*: Right. Yeah.

*RB (0:39:38)*: And we can do these where one of the constructors is one. One of the constructors you can call N, which is just one plus. So it’s one plus this representation, right? And then you can take D, which is one over one plus one over X, right, where X is one of these numbers. And the way that the math works out is that N and D are inverses basically –

*JF (0:39:58)*: Okay.

*RB (0:39:58)*: – because you’re sort of putting one on the top or putting one on the bottom of this representation that goes through Euclid’s algorithm. So when you’re computing GCD, basically the way that you do this iteratively is you’re manipulating ones on the top and bottom of a fraction until you get these relative prime numbers. And doing this, you can find the unique representation. And actually, every rational number has a unique word in this language, which is very cool because you can do equivalence, right? The problem with doing equivalence between rational numbers that you just represent as p over q is that two over four and three over six are not syntactically equal.

*JF (0:40:31)*: Right. I see.

*RB (0:40:32)*: Right? So you have to do computation, and things become complicated.

*JF (0:40:34)*: Oh, interesting.

*RB (0:40:34)*: But when you have unique words, then you get syntactic equivalence.

*JF (0:40:38)*: That’s really cool.

*RB (0:40:38)*: Yeah.

*JF (0:40:39)*: Yeah.

*RB (0:40:39)*: He’s a genius, and he plays trumpet, which I find extremely cool as just science and music.

*JF (0:40:44)*: Hell yeah. Hell yeah. 

*RB (0:40:44)*: It always is something I’m looking for.

*JF (0:40:46)*: When’s his FARM performance? When are we going to see it?

*RB (0:40:47)*: That’s what I’m asking.

*JF (0:40:48)*: Yeah.

*RB (0:40:48)*: He’s carrying his trumpet everywhere, and I –

*JF (0:40:50)*: He’s carrying his trumpet everywhere?

*RB (0:40:51)*: I asked him, you know –

*JF (0:40:52)*: Get him down to FARM. We have to have him there.

*RB (0:40:54)*: – why, and he said, “Well, I might play.” So I hope he does.

*JF (0:40:57)*: I hope he does too. Fantastic. So, is there anything you’re looking forward to in the rest of the conference?

*RB (0:41:02)*: Yeah. I have a lot of talks starred. These days, I’ve been really interested in step-indexed logical relations and co-induction. So basically anything that has those words in it, I put a star next to.

*JF (0:41:11)*: Okay. Right. Yeah.

*RB (0:41:11)*: I’m still very new in the field. I have a lot that I need to learn, a lot of papers that I need to read or am in the process of reading. And it’s a real privilege to be around the authors of those papers. I got to ask Paul Levy about call-by-push value, just direct questions that I had highlighted in the paper.

*JF (0:41:26)*: Right. They’re just people, and they’re just there.

*RB (0:41:28)*: Yeah.

*JF (0:41:28)*: And you can just go talk to them.

*RB (0:41:28)*: And in this community, they’re very approachable.

*JF (0:41:30)*: Yeah. Exactly. Yeah, yeah. No, nice. And we’ll turn back over to Francille. Is there anything that you’re looking forward to in the rest of the conference?

*FZ (0:41:37)*: So there’s been a lot of really good quantum talks.

*JF (0:41:41)*: There has. I’ve been talking to a lot of people about quantum on this podcast as well, actually. But yeah.

*FZ (0:41:45)*: Yeah.

*JF (0:41:45)*: Yeah. What talks?

*FZ (0:41:45)*: But it’s more about POPL, I think. So I want to look into that more. I just think quantum is so interesting because it’s like the same kind of problems that we already solved in classical CS. We’re trying to do them again. It’s never how it has been working. You got to come up with a lot of new abstractions for it. So that’s kind of the reason it piques my interest.

*JF (0:42:05)*: Yeah. Abstractions for quantum is quite a difficult thing, and it’s a very unsolved problem.

*FZ (0:42:09)*: Yeah.

*JF (0:42:09)*: People are struggling, and yeah, it’s an interesting challenge.

*FZ (0:42:13)*: Yeah.

*JF (0:42:13)*: Okay, great. Thank you very much, both of you, Francille and Roger. And supervisors out there, Francille is looking to do a PhD. Well, is there any way they should contact you? 

*FZ (0:42:24)*: You can email me at fzhuang@purdue.edu.

*JF (0:42:30)*: Okay. Perfect. Thank you both very much, and enjoy the rest of the conference.

*RB (0:42:33)*: Thank you.

*Narrator (0:42:38)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.

*FZ (0:42:54)*: That was fun.
