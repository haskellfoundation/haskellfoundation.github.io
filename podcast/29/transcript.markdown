*Joachim Breitner (0: 00:14)*: Welcome to a special episode of the Haskell Interlude. My name is Joachim Breitner and I just attended ZuriHac 2023. ZuriHac is the biggest Haskell community event held yearly in Zurich, Switzerland. And I want to share the spirit and experience of ZuriHac with you. So I borrowed a recording device—thanks to Jonathan King for that—and talked to organizers, speakers, and attendees. Please excuse the background noise during some of the conversations. It gets better during the podcast. And even the jingle is a genuine ZuriHac sound. On Sunday night at the lakeside, three participants suddenly began jamming brass. Enjoy. 

Right now, I caught Farhad, who is one of the organizers of ZuriHac, and the reason we can actually have this event at this very nice lakeside campus. Has ZuriHac always been the same, or does it change over time? How would you compare it to the first ZuriHac that we had here?

*Farhad Mehta (0:01:11)*: The first one was quite small in comparison. So at that time, I think we had about 200 to 250 people or 170. I don’t really remember. But I do remember that the previous location for ZuriHac couldn’t hold more than a hundred people. So that’s how it came here. And I think it was 250 and then we came to 300 and then south 350, then 400. And then the online was crazy. It was like a thousand people because no one had to come here. And then we basically stayed stable at 400 now. 

*JB (0:01:45)*: Okay. So this year is as well 400?

*FM (0:01:47)*: Yeah, 400. 

*JB (0:01:48)*: Oh, hopefully after this podcast episode, next year there’ll be plenty more because we’ll tell everybody how great it is to have a geeky conference at the lakeside where you can just jump in.

*FM (0:01:57)*: Exactly. Thanks, Joachim.

*JB (0:02:01)*: Oh yeah, thanks for organizing. So it’s getting later. Sun is set. We are still sitting on the lakeside. Tomas has just joined us around. Tomas, how was your ZuriHac day so far?

*Tomáš Janoušek (0:02:18)*: It was good, actually. It was good. I got nerd sniped by this guy working on Haskell Pledge, which is a library for OpenBSD’s pledge system call. So we’ve been doing some type programming, which was-- it was difficult for me because I haven’t done much Haskell lately.

*JB (0:02:36)*: Okay.

*TJ (0:02:39)*: Yeah. I was more proactive than I thought I would be. Last year, I spent most of the time at the lake.

*JB (0:02:45)*: So for those people who haven’t been at ZuriHac, how does this work? You just show up here and suddenly somebody pulls you into their project? Or how did you get to--

*TJ (0:02:55)*: Well, there’s a Discord server, which is kind of like IRC, which is the stuff I know. And people pitch their projects. And then since pitching your projects only gets you a bit of attention, then people try to raise interesting problems. So what happened was there was a discussion in the Haskell Pledge channel about something relating to GHCup and I kind of like couldn’t resist getting into that discussion. And then somehow, it ended up showing us in room 1.2 something, something, and then I got completely nerd-sniped into just working on it for the rest of the day. 

*JB (0:03:35)*: Yeah, that sounds lovely. So it’s Sunday, already Sunday noon. We just had lunch and I caught Christian Georgii sitting in front of the lecture hall, and he’s a first-time ZuriHac visitor. So I’m curious, Christian, what’s your impression of ZuriHac? How do you like it? What did you do? What to take away so far?

*Christian Georgii (0:04:03)*: Yeah, it’s been pretty nice, pretty nice people. The campus here is extremely impressive at the lakeside. Wasn’t expecting that level of nice. Well, yeah, bring your bathing suit. Don’t do it like me. They cost upwards of 30 francs.

*JB (0:04:20)*: Have you considered going in without one?

*CG (0:04:22)*: As a person who lives in Berlin, yes, that has crossed my mind.

*JB (0:04:24)*: Okay. And how did you spend your first half of ZuriHac so far?

*CG (0:04:31)*: Yesterday, I did a little bit of the category theory track, then I switched to hacking on HLS. People there are very helpful and helped me set up the project and actually run HLS against the HLS code base. Now I’m helping out with some low-hanging fruit.

*JB (0:04:48)*: Well, what kind of low-hanging fruit?

*CG (0:04:50)*: Mostly documentation. There is a plugin tutorial that is currently very outdated and I’m trying to follow along, fix the bits that are incorrect, which is most of them. And eventually, I want to reach the end and have a plugin running that works and maybe learn how to write a plugin.

*JB (0:05:11)*: Okay. Sounds like a good project for next ZuriHac when you come back maybe.

*CG (0:05:16)*: Yeah, sounds like it. 

*JB (0:05:17)*: Cool. Talk to you then. 

*CG (0:05:18)*: Yep. 

*JB (0:05:25)*: So now I’m sitting in front of David.

*David Thrane Christiansen (0:05:27)*: Hello. 

*JB (0:05:28)*: Famous for running the Haskell Foundation since about half a year now, or is it--

*DTC (0:05:32)*: A little over a year.

*JB (0:05:33)*: Little-- oh, time flies.

*DTC (0:05:35)*: May 2nd last year was my first day.

*JB (0:05:37)*: Okay. So, okay, then--

*DTC (0:05:39)*: And now it’s what? The 11th of June? Something like that.

*JB (0:05:41)*: Yeah. So it’s 11. 11, okay. 

*DTC (0:05:43)*: About 13 months. 

*JB (0:05:44)*: And he’s still been doing a bunch of stuff everywhere, all over the place, including here in Zurich. So you are actually here since yesterday when ZuriHac started, but you’ve been here for like the whole week. 

*DTC (0:05:56)*: Yeah, yeah. 

*JB (0:05:57)*: So tell me about it. 

*DTC (0:05:57)*: Sure. So the main reason for coming early is that together with the university here, the OST, the Haskell Foundation has been organizing a workshop on contributing to GHC. So people who wanted to get involved in working on the compiler, but maybe didn’t know where to start or didn’t know where to look for documentation, or maybe there wasn’t documentation. I’m not entirely sure. I have never written a line of code in GHC myself. So all of this is sort of hearsay and you shouldn’t trust me at all on it. People wanted to have an easier path into GHC, and so we made an event where core GHC contributors could give presentations about key aspects of the compiler. So we had nine speakers over three days, each giving about a two-hour session. And we ended up with-- I don’t have the number off the top of my head, but around 70 people attending in person. And depending on the day, up to 20 people are participating remotely. We live-streamed everything and we’re going to be releasing a video. Probably by the time this episode comes out, the videos will be released. We’ll see. And yeah, it seemed to be pretty well received. And at the end of the workshop, so on Friday afternoon, there were already 12 merge requests to GHC that had resulted from people attending the workshop and getting going on hacking. So that was really great to see. I hope we’ll get a lot more.

*JB (0:07:19)*: So you’re saying there was nine speakers over three days? 

*DTC (0:07:23)*: Yes. 

*JB (0:07:23)*: Two hours each. 

*DTC (0:07:24)*: That’s right. 

*JB (0:07:25)*: And there was still time for people to actually hack and contribute? Did you not allow them to sleep or something?

*DTC (0:07:32)*: So I said very explicitly, as often as I could, that people should skip sessions on aspects of the compiler they didn’t find interesting and go sit down and do whatever they wanted. 

*JB (0:07:41)*: Okay.

*DTC (0:07:41)*: I don’t think a lot of people did that. I think they--

*JB (0:07:43)*: Yeah, it’s always hard to--

*DTC (0:07:45)*: Yeah. All the talks are being recorded. You’ll have access to the recording of the live stream immediately as a participant and the edited videos as soon as we can get them done. But people wanted to be there live and see what was going on. So I know some people were working in the evenings and not all these MRs are huge. Some of them just update documentation where a speaker would-- somebody would ask a question, the speaker would say, “Oh, actually, the docs are out of date and they just fix it.” 

*JB (0:08:07)*: Oh, great. Yeah.

*DTC (0:08:08)*: Yeah. We had an explicit rule that if somebody got a question answered or found a difficult aspect, they were supposed to leave the code base in a state where the next person wouldn’t need to ask the question. And yeah, we’ll see. I’ll put out a blog post or a post on Discourse pretty soon with a recap and with some more numbers about how many contributions we get as a result of this. But also, we’ve scheduled it together with ZuriHac on the assumption that people could come and learn a lot about GHC internals for three days and then have three days to do further work where all of the speakers were present. They all signed up when they were going to do a presentation. They also signed up that they’d be willing to mentor contributors and answer questions during ZuriHac itself. So we also have a room full of people working on GHC. I’ve stuck my head in a couple of times. A lot of them were at the workshop.

*JB (0:08:57)*: Cool. That sounds like a successful way of gathering--

*DTC (0:09:00)*: I think so. I was spending all of my time focused on trying to get the live stream to work well and pointing the camera at people as they walked around and cutting between the slide view and the camera view. And so I didn’t really understand a single word that was said. But people seem to think that the content was useful.

*JB (0:09:20)*: And do you think we’ll have that again or is it still--

*DTC (0:09:22)*: That’s a good question. Yeah, I want to-- it was a lot of work to plan it. I think a second round would be less work. So now we have an idea of what the interest level is. So we started with a small room and then-- so Farhad, the person I’ve been working with on organizing it, he’s local here. He spent a lot of time sort of bargaining with people to move their classes around so we could get bigger and better rooms, and then again bigger and better rooms. And he was wildly successful. We ended up with a gigantic convenient air-conditioned room. But that took a lot of work. And I think next time we know, just book that room now. I had to learn a lot about live streaming things and now I know how to do it.

On the other hand, we have videos. That’s one of the big products of this, is we now have nine two-hour talks on the way about various aspects of GHC, like how the RTS works or how it interacts with installed libraries on disk and other things that people may not have had easy ways to learn about before. And repeating that doesn’t make a lot of sense in one year or in half a year or in two years. The type checkers structure is not what it was a decade ago. We’d certainly want to repeat it if the last talk about the type checker was a decade old. So I’ve been considering maybe try to plan something about other strategically important core Haskell tooling that needs a little more love. And so I think there are aspects of GHC that I’d like to see, have more people maintaining them and working on them. So have different talks about different aspects would be useful. Also, I think build tools. And we had one session on HLS. I think having more would be useful because HLS is extremely important. We had sessions on the Wasm and JavaScript backends for people who wanted to get involved working on those, but we didn’t have one on the native code back into the LLVM backend. And those also need work sometimes.

*JB (0:11:09)*: Yeah. They’re also kind of relevant next to the--

*DTC (0:11:11)*: Yeah, of course. I mean, the other ones are new and there’s like a big to-do list to get them fully production ready. And so that’s why we chose to focus on those because--

*JB (0:11:21)*: There’s more to contribute there. Yeah, that makes sense.

*DTC (0:11:23)*: And there’s more like low-hanging fruit. One of the tasks that needs to happen is that a lot of the numeric primops in the JavaScript backend are currently implemented using JavaScript BigInt. And that ends up being less efficient than just representing it as a pair of numbers and not constructing a BigInt doing the BigInt operation and then unpacking them, but instead, sort of doing the bit shifting yourself in the JavaScript implementation of the primops, stuff like that. The native code gen has fewer opportunities to make things faster like that just because there’s more work put into it in the past.

*JB (0:12:00)*: Cool. That sounds great. So I tracked you down for this interview. You also tracked me down here for something else. Tell me about why you hunted me here.

*DTC (0:12:10)*: Yeah. I did send you an email warning you about this fact, so you knew I was coming.

*JB (0:12:13)*: Yeah. I’ve fallen into the trap even if it’s very visible.

*DTC (0:12:17)*: So Hackage, the package repository we all know and love, has a nice setup, which is intended to increase the security of users of Hackage to give people some assurances. So Hackage has a design where you can have untrusted mirrors, which is to say, I can set up a mirror of Hackage and if you download packages from my mirror, I don’t have an opportunity to say, not give you upgraded packages or to substitute malicious packages for the ones you want. Similarly, we have some assurance that the keys used for various purposes have been vetted and attested by a trusted set of people. That trusted set of people have been doing it for a long time, and we need new ones. We need more people. So the goal is to recruit you to do this job, Joachim. And so in order to do this, we want to maintain a high level of trust in the system. So we have a Git repository full of GPG-signed messages where key holders use GPG to attest to their ownership of a particular private key or public key. Like a particular key pair that is used for this Hackage signing process. I do not have such a key, but I hope that you soon will. And this means that we need to do the old-school GPG key signing ceremony where we look at each other’s passports and say, “Hey, yes, this key is actually owned by this person.” And actually, Joachim, you are a Debian developer and have been for a long time, and that means that you have an extremely well-attested GPG key. I, on the other hand, do not. I used to use GPG years ago, but I didn’t because, like much of the world, I kind of stopped doing it when I didn’t get any encrypted email or signed email for a long time. But now I need it again to participate in my role in this process. So I will get my key signed, which will be very valuable.

*JB (0:14:10)*: All right. Well--

*DTC (0:14:10)*: I mean, you’ve got to verify my documents first.

*JB (0:14:13)*: Yeah. We’ll make sure that you’re not some imposter who actually is like, I don’t know, part of the OCaml Foundation rather than Haskell Foundation and it’s trying to subvert us.

*DTC (0:14:22)*: For the record, the OCaml development team and the Haskell Foundation have a good working relationship and we actually talk to each other about how to make the world better for functional programming.

*JB (0:14:31)*: Yeah. Cool. Let’s do that and not bore our listeners with reading our GPG fingerprints and yeah, enjoy the rest of ZuriHac. 

*DTC (0:14:39)*: Thanks. You too.

*JB (0:14:45)*: So now I’m sitting in front of Artin and I’m very happy to have Artin here because he’s actually one of the people who keep the Haskell podcast running. He’s our very efficient and swift test listener. So whenever we produce an episode, it first goes to him and he tells us if there are any glitches in the audio that we have to fix. Because as you may imagine, some of our hosts, they don’t like to hear their own voice, and I’m certainly one of them. So we are happy to have somebody else who can check the episodes before we publish them. But that’s actually not what I want to talk about. I want to hear Artin. This is your first time at ZuriHac, right? 

*Artin Ghasivand (0:15:20)*: Yeah. 

*JB (0:15:21)*: Yeah. So what made you come here and how was your experience so far? 

*AG (0:15:26)*: So I’ve always been dreaming of going to some kind of community place where everyone’s a Haskeller and everyone shares my love for Haskell. And ZuriHac is, I think, the best one for that. So we have MuniHac and other hackathons and Haskell meetings, but ZuriHac is the one that I was most interested. So I live in a country where it’s not really easy to come to Switzerland. So I asked Farhad and David if they could help me with the letter for my visa application, and they provided one very easily and helped me. 

*JB (0:16:01)*: Oh, that’s nice. 

*AG (0:16:02)*: Yeah, helped me with my visa application.

*JB (0:16:03)*: Okay. I guess it’s good to highlight that people who think maybe it’s too tricky to come to ZuriHac, they should try.

*AG (0:16:10)*: Yeah, exactly. So--

*JB (0:16:11)*: We can help.

*AG (0:16:12)*: Yeah. People are really nice in the community. So that was very great to experience. When I came here, I was first at the GHC workshop. After that, ZuriHac started and it was very great. So all the conferences, all those things. But one of the biggest highlights of my trip to ZuriHac is getting to know all the heroes that I worshiped so much in the community. For example, Simon and David Christensen and yourself, and Ben Gamari—all those maintainers that put all their effort into GHC and always trying to make it better for us, all of us. So it was very nice to see that people who have done so much in the functional programming community be so easy and open and nice to you like you’re some kind of friend that they knew about, for example, over 10 years.

I got to talk with all of the Well-Typed people, for example, *(0:17:13 unintelligible)*, but I spent most of my conversation talking with Simon and Ben Gamari. They were so nice. I was so comfortable talking about GHC. It was so appealing that we were sharing something, some love for Haskell that we were so passionate to talk about. And I was like, “Simon, how can I get more involved with all of this?” And he was like, “Just start doing the typing rules visible forall if you can.” I was like, “That would be great.” So it’s not some kind of impossible thing to get involved even in the research field of GHC. So if you can do something, contact the maintainers and they’ll answer you as fast as possible. Yeah.

*JB (0:17:53)*: Yeah. But when I found Artin sitting outside on the nice benches in front of the building, he was reading one of the papers and you could see typing rules on the screen. So he’s already-- he’s just started to work on this task. So what exactly is it that your goal now for this project? What is the task that you’re looking at? 

*AG (0:18:14)*: So the Quick Look paper lacks some typing rules, and the visible forall proposal number-- if you search, it’s number O281. So we can just search GHC proposal and go read it. It’s by Vladislav Zavialov. He’s the main person who is working on dependent types right now. So if you love dependent types, just go look at it. Do you want me to explain what visible forall is?

*JB (0:18:42)*: Very briefly. Yeah.

*AG (0:18:43)*: Okay. Visible forall lets you pass types as argument without the add sign at the beginning. So it’s like more neutral to work with them. That’s all it does. Kind of, not-- as a user, that’s what it does. But as being able to implement it in GHC, it lacks some typing rules and it has to work with the Quick Look paper. So the Quick Look paper is describing what bidirectional-- I may be saying wrong things right now, so

*JB (0:19:10)*: No, that’s fine. That’s fine. No worry.

*AG (0:19:12)*: Other people are more fluent than this. I’m just a beginner trying to find out my way. So bidirectional type inference and type checking. That lets you, for example, do so many stuff like instantiating unification variables with poly types instead of monotypes and that would be great. So we can compose functions from, for example, forall A to A, to int, to a function that returns a forall A to A, returns a function from A to A. So now you can do that.

*JB (0:19:44)*: So that almost sounds like you’ve already studied some of these type theory things at university or so, but that is not the case, right?

*AG (0:19:53)*: Yeah. I started programming back in high school in the middle of my 10th grade and I started some Python and did some things, and I figured out what Haskell was and just began exploring all this stuff. So it’s not as high of a bar to enter as some people think. Just type theory and all this stuff come neutrally when you have some functional programming experience. So when I started reading typing rules, they were just so Greek, random Greek letters. But when you just get more passionate about all this stuff, they come so easily. You can learn them so easily.

*JB (0:20:25)*: Cool. That sounds like you’re having a great time at ZuriHac.

*AG (0:20:29)*: Yeah, I’m having the best time of my life.

*JB (0:20:31)*: Well then, don’t let me stop you from the rest of the ZuriHac and maybe see you next year then. 

*AG (0:20:36)*: Thank you very much. Thank you for having me here.

*JB (0:20:45)*: So it’s Monday already, last day of ZuriHac, and I caught Hannes and Michael who were leading maybe the most popular project for contributors here because the room was always full and busy with work. They’re working on the HLS, (the Haskell-language-server). So how did it go for you, the ZuriHac hacking? What’s your opinion of it?

*Hannes Siebenhandl (0:21:03)*: Oh yeah, it was amazing. We have like, I think 12 to 15 people almost all the time in the room, and we have so many issues that the people were working on like documentation improvements. And we are soon going to receive a new cover plugin where you can actually hack on a cover file with completion diagnostics. We have so many more code actions and bug fixes. And I think it was a real pleasant experience. It’s a lot of work and the room is so incredibly hot when it’s like 50 people inside it.

*Michael Peyton Jones (0:21:32)*: Yeah, Tomas quite did a good job of trying to get people going because it’s not the easiest code base in the world to work on. And Hannes, in particular, is great at making sure that everyone has a working setup and gets over the first few hurdles so that they can actually start doing some coding and not just screaming at setup all day.

*JB (0:21:51)*: So, I always wonder when you join these projects as somebody who hasn’t worked on HLS before, maybe you’re even a Haskell beginner, is it still useful and helpful to join this project? Or is it mostly, well, keeping the attendees here busy and happy? But how much do you get out of new contributors during one weekend?

*HS (0:22:09)*: So usually, people do not stay long-time contributors, but there are some notable exceptions like people that actually come here again at every hackathon. I’ve been at the last ZuriHac and the last MuniHac and I’ve met like four to five people that consistently come back to my table, to our table obviously. And so I think we do get a lot out of it. And it just may be the feedback that, okay, what’s bad about our development setup, because admittedly it’s a big project mostly maintained by volunteers. So we do have issues all the time. So beginners usually have a hard time wrapping their head around this huge, huge, huge code base. We still usually often can find some, at least something that they can look at and actually bash their head against so that they can interact with it and see, okay, if I do this, this happens. Maybe they might not always get a pull request out of it, but at least I hope they at least have a nice experience with it, with nice people to work with and socializing a bit, stuff like that. So I think we do get a lot out of it, to be honest.

*MPJ (0:23:15)*: And I think in some ways, we get a bit further in a situation like this because we can have that sort of quick feedback where someone’s a bit stuck and then we can just wander over and give them a hand. And I think that having code base that maybe has a lot of quirks or awkward bits and the LSP spec itself, we had a lot of cases where someone said, “Oh, I think I found a bug because this thing isn’t working.” And I was like, “Ah, no, actually the empty object in the capabilities map actually means it’s enabled.” Things like that, which you could spend a lot of time and be very demoralized on if you were sitting at home by yourself and in a situation like this. You could just ask someone and then make some progress.

*JB (0:23:52)*: All right. That sounds great. So I hope you’ll do this next year again and maybe some of the people listening to the podcast will come to ZuriHac and make HLS even better. 

*HS (0:24:01)*: Yeah, of course. They are always welcome. 

*JB (0:24:02)*: Cool. Thanks. 

It’s Monday. This morning, Ben Lynn gave the final talk of the ZuriHac event. It was very well received. The audience was excited at the end. So Ben, you arrived on Friday already?

*Ben Lynn (0:24:21)*: Yes. Actually, I’ve been in Zurich even longer, just a few days before.

*JB (0:24:24)*: Okay. Right. So what is your impression of ZuriHac? How did you use the time so far? 

*BL (0:24:29)*: Mostly preparing my talk because I’m scrambling to get my slides together and iron out bugs, that sort of thing.

*JB (0:24:35)*: You say slides, it wasn’t really slides. They’re very interactive.

*BL (0:24:40)*: Right. I had a bunch of live demos and I had even more that slipped my mind in the heat of the moment, unfortunately. Yes. So I was trying to get those working and then figure out how to make it look flashy.

*JB (0:24:50)*: Yeah. And I think it did look flashy in the end. The people listening to the episode are probably not those who were here, but they still have the opportunity to see you because all the talks that were at ZuriHac are recorded and going to be online. So what can they expect from your talk?

*BL (0:25:04)*: Well, it’s a spoiler alert, I guess, but I did a series of magic tricks and death-defying stunts, let’s say.

*JB (0:25:12)*: That is true but unhelpful.

*BL (0:25:16)*: Okay. I walked through a classic paper, one of my favorites, Schönfinkel’s 1924 paper on combinators where he introduced combinators and showed how you could write any logic formula in a very strange form. A real simple, strange form using very few symbols.

*JB (0:25:32)*: And I think then you actually wrote a full Haskell compiler based on that. 

*BL (0:25:36)* Based on that, yes. I forgot to mention that. 

*JB (0:25:37)*: And showed that. It was even self-hosting, wasn’t it?

*BL (0:25:40)*: Yes, it is. From using those techniques, I ran up with a self-hosting Haskell compiler. But I should point out, it isn’t the full Haskell. It does have many deficiencies.

*JB (0:25:50)*: Right. And you also had very nice animations showing how evaluation actually happens in that system. 

*BL (0:25:55)*: Yes. I think the crowd enjoyed that more than I expected. It was a little animation of how combinator reduction-- it helps understand combinator reduction, I would say. I wanted to turn it into a game, but I haven’t had the time.

*JB (0:26:07)*: Oh, but what would be the idea for the game?

*BL (0:26:09)*: It would be a sort of puzzle game where maybe you start out with only the B combinator and you have to transform A, B, C, D into AB applies to C. I don’t know how to say these brackets verbally, but different packets--

*JB (0:26:22)*: I guess you could spell it in Polish notation.

*BL (0:26:24)*: That’s right.

*JB (0:26:26)*: I’m not sure if that’s helpful. Yeah, that sounds-- I think that’s a great talk for the final talk of ZuriHac after--

*BL (0:26:35)*: Thank you.

*JB (0:26:36)*: After two days of intense discussions and talks to have something was very entertaining while still enlightening.

*BL (0:26:42)*: Thank you. I’m glad-- yes, it was well received I think, and I was very happy to see that. I didn’t expect it. And yeah, I’m very happy to be here. It’s my first ZuriHac and yeah, I’ve had a great time. 

*JB (0:26:54)*: Cool. Thank you.

*Narrator (0:26:59)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the support of our sponsors, especially the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and Meta.
