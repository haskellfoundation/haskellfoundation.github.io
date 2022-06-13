_Joachim Breitner:_ Welcome to this Haskell Interlude episode, today Nikki Vazu and I interview Ryan Trickle, Ryan has co-founded Obsidian Systems a company that not just uses Haskell as the secret button but even more exotic tech that as functional reactive programming and Nix. Ryan ???? lodge had ??? some light on the business side of Haskell and we get to hear that hiring for haskell is actually excellent. Stay tuned, especially if you want to hear this story of the supersitious garbage collector that doesn't like number 13. Hi Ryan, good to have you on the podcast.

_Ryan Trickle_: Hi Joachim, I'm very glad to be here with you and Nikki. It's a great opportunity. Thank you.

_Nikki Vazu_: Hello everyone.

_JB:_ Yeah, I must say I'm particularly excited about this particular episode because when I was relatively new to Haskell and I started this impression that has this academic language only for teaching, only for language teachers, I was always very excited when I heard that somebody's actually building a company on top of Haskell and solving real world problems for people that probably don't care about Haskell and when I heard about Obsidian Systems that you co-founded back then using Haskell and even more interesting tech that we'll get into. I was was following this with with great interest. So I'm very curious Ryan, how did it all started? What came first? Did you want to build the company? Did you want to use Haskell? We're just in the need of money? Can you tell us the story?

_RT_: Sure, so I've been working with my business partner Ali Abrar for about 15 years now, we really started when we met in law school and we actually tried to start another company using Haskell right after we finished law school making iPhone games and we were, you know, we were not successful in that company but we did end up contributing a whole lot of ARM and mobile stuff back to GHC which was a really nice result, and then, you know, we worked in a lot of different startups, both during law school and also after iPhone Studios which was the company that was doing iPhone games. And what we saw repeatedly as we worked in lots of different startups was the same sort of mistakes we get made over and over and it's understandable, I mean, people start a company, they may not have experience building a product or whatever else and they had have to bring it the first time a lot of the time, the founders are not highly technical, and so if you're not a highly technical person, how do you even know whether the engineers you hire are doing the job or not. It's just really difficult to understand. So we decided that we thought that having been around the block a few times we could do considerably better than that. And we wanted to turn that into a consultancy that could reliably deliver results for our clients. And so the key with that was really that we wanted to break out of this paradigm of just trying to pick the most popular technologies with the most sort of justification, we were just, it was just the 2 of us and so we could make decisions that were a little bit more bold. Obsidian Systems doesn't have investors so Ali and I just have sort of a lot of latitude in doing what we think is right and in a lot of technical cases that means choosing a technology that isn't highly popular like Haskell, like Nix and NixOS which we also use, but a lot of the time it does mean choosing something popular like Postgres, for example, with a database I'm not looking for a ton of features or anything fancy, I just want something that's going to hold on to my data and never lose it and be a reliable source of something for my application. So we tried to really dig into things and and make the right decision. Obviously a lot of our clients have not heard of Haskell before they start talking to us, especially the ones who maybe just they've gotten some sort of funding and they want to build something and they hear about us through usually word of mouth. For a long yime we didn't even really have a marketing site, it was just sort of our phone number on a web page, what was actually kind of embarrassing, ummm, but it didn't really matter because when people are deciding who to hire for, you know, really staking the life of their startup on it. They usually are not looking for a fancy website, they're usually looking for a friend or somebody trusted who can vouch for us.

_JB_: So when you say clients, what kind of field are we talking about, what kind of clients or products did you were you cating or catering for?

_RT_: Early on um, the vast majority of our clients were startups and they were there were folks who had really nothing to do with Haskell or even necessarily high tech, we did one that was a logistics startup. It was just managing trucking. We we did another one that was trying to streamline some things in the finance industry with mortgage applications and things like that. Really, these are not companies that are trying to achieve some spectacular engineering or technical goal. They're just trying to build a reliable useful application where the business value is in something else, right? It's like oh we want to make it really easy for people to get a mortgage or or to refinance their student loans or something like that. Um, so they didn't care that we were using Haskell. Sometimes they would be a little skeptical like I've never heard of this. Why don't you use Python or whatever. But then once they saw us starting to deliver results then they would usually be very quickly won over. So yeah.

_NV_: And now that Haskell is getting more popular does it affect your clients, I mean you said they didn't care, now do you even like get clients because of Haskell?

_RT_: Yeah, yeah. I think that's happened a little bit all along, but it has definitely happened more recently. So we've had some some clients that, for example, we're known for expertise in functional reactive programming (FRP), that a couple of clients who say you know we're doing Haskell, we want to use FRP, maybe you can help us with that.

_NV_: So can you tell us a little bit what is a FRP?

_RT_: Yeah, absolutely. Functional reactive programming (FRP) is a way of describing interactive systems using only pure functional semantics. So in most programming including in Haskell, but especially outside of Haskell when you want to describe an interactive system which is a system that gets some sort of input and then produces output and then gets more input and produces more output, like a user interface or really frankly most applications. When you want to build something like that usually the way it's done is with imperative style coding you, will say sort of a list of things that need to happen in a certain order and we do that in the IO monad in Haskell but you know, we also do it in C and it really the C and the Haskell look pretty similar when you're writing that kind of code. And the reason that we write things like that even in Haskell is that we need some way of specifying like when the data is coming in when it's going out. And traditional pure functional programming doesn't really give us a vocabulary for that, it will sort of take all of its data as input at the beginning like maybe a compiler right? You give it a bunch of source files and then it does a whole lot of computational work and then it spits out and executable or something like that, of course real compilers need to worry about memory management and stuff. But the basic idea is that's a very clear pure function, you take a bunch of stuff and you produce an output and what happens in between is sort of side effect fee, but a graphical user interface is quite the opposite of that, almost every interesting thing a user interface does is like okay the user clicked a button now we need to refresh the screen and we need to pull up some data and maybe take some sort of action and then we wait for the user to do something else. And maybe we wait for data to come in so that we can put it on the screen and the user sees it updating live. So the problem is writing these things in imperative style even within Haskell loses a lot of the benefit of pure functional programming because you get back into this mode of I've got mutable variables, I've got often sort of like poorly scoped state things that are a little bit too like global variables or even just variables living in a very large area in your program and that makes it very difficult to reason about what your code is going to do, and it gets you far away from the whole, like if it compiles it works thing which is I mean never strictly true, but it is surprisingly often true in Haskell I think most Haskell developers have had this feeling that it really compile, if it compiles the works way more often than it feels like a shit, so functional reactive programming gives us a totally pure vocabulary for describing these interactive things, like buttons on a user interface, a button for example might produce an event and an event is a pure value, but it represents a potentially endless stream of clicks on the button.

_NV_: So when you say pure value, you say a monadic computation, no?

_RT_: No, I really mean a pure value here.

_NV_: The button is a pure value?

_RT_: The event is semantically pure and what I mean by that is you cannot affect anything by just holding on to this event. So I don't know if there is academic theory that backs me up here, but this is the sort of mental model I've arrived at. Basically the fundamental thing that makes let's say a pure integer easier to deal with than say an IO graph is that when an I ref is being used in many places in your software. They can all sort of have arbitrary impacts on it and you get into this situation where you can't know what the IO does unless you read through the whole codebase. And even if you do read it you probably won't be able to understand it all. It's just too big for the human brain to hold. But if you've got an integer, well you pass it into all kinds of places and who cares what they do with it because it's not going to come back and change the value of the integer or anything like that. And event in FRP works the same way even though it represents something that's changing through time. The people who you send it to the functions that you give it as an argument to can't have any impact at all on what it happens so you can kind of think of the event as though it's an infinite timeline stretching into the past and the future and you can only observe it at the current time so you can't necessarily. You definitely can't see the future of the event but you also can't affect the future of the event. So, basically this has sort of brought me around to the idea that mutability and purity are actually separate properties of a programming semantics.

_JB:_ So maybe another way of looking at this if I compare it with maybe more traditional way of doing UI, so you have handlers on events then you can compose these handlers and, but often what we see I guess in most of these libraries is that they bubble down and up some kind of chain of event handlers and you can disable the surrounding event handlers by returning falses or depending or calling some disabled default and suddenly you have this kind of action at a distance whereas with the pure event from a button. You're still handling an event in a way if you want to think about it morerationally which maybe I am still doing too much here. But at least I know that nothing else can interfere with how I'm handling this particular handlers, that...

 ah ah is that a good way of putting it.

_RT_: Yeah, absolutely, and if you sort of look at the standard for how these things are done in most of the industry which of course has been making improvements with things like react, but you know when you've got a bunch of callbacks, you've first of all callbacks have a type signature that's something like A to IO unit. So by definition they're pretty much just doing side effects. So we we sort of in the Haskell community know that can get you into trouble. It's very difficult to reason about, but even more so, you know, if you have a single event source and you add on several different callbacks to it. Those callbacks can easily interfere with each other and the order is actually important at least sometimes and at the same time you don't usually have very good control over what the order of execution is so he just kind of toss them into a bucket and hope for the best and then this gets even worse when you have chains of callbacks like if you have 1 callback from a certain source of data and then you use that to update another source of data and then that triggers another callback that goes somewhere else. Ah, it sort of very quickly becomes impossible to understand what the system's really going to do.

_NV_: .... y're using a monod basically to encapsulate this side effect that you're talking about, right?

_RT_: No, um, we do use a monad in reflex for certain things but not for the the sort of basic stuff. For example, merging 2 events together, that's completely pure, there's no monad involved.

_NV_: But when you say event, the event is not a monad itself?

_RT_: No, it's not, it actually can't be because you can't write return, but at a sort of so, okay, so there's the technical level where it can't be a monad because it's impossible to write return, because that would be an event that's always firing and that actually turns out to sort of break everything in FRP, but you could write bind for it but it's not doesn't wind up being very useful, so it could be some a semi-monad, if you really wanted it to be, but it's better to think of an event as essentially a container like an infinite list, except that with a list you have a bunch of items that are all existing at the same time but in different places in memory, with an event you have a bunch of different items that are all existing at the same place but at different times.

_JB:_ So it's like applying transpose to a ah list and then excellently getting the dimensions wrong and turning into time rather than space.

_RT_: Exactly, exactly. So so the semantics are just like any other pure container you can f-map over it. You can't traverse it because if you, it would take an infinite amount of time for your traverse to return. But you could sort of like you can scan over it, you can fold over it, you can do those sorts of things and they all just sort of perfectly make sense. The only place that a monad is actually necessary in reflex, which is the FRP system that I built, is when you need to know what the current time is. For example, when you want to create state in an FRP system, you need to..., let's say you had an event and you wanted to count how many times the event actually occurred, like a button click. Well you need to know when you're starting from, because as I said before the event logically speaking stretches infinitely into the past and infinitely into the future. So despite that you sort of get the event at a certain time, right? So you can't look infinitely into the past, don't retain history for any of this stuff because it would be a memory leak, so logically speaking we do have a monad that says like okay if I'm going to start counting when do I start counting? And semantically it's just a reader monad, operationally it's extremely different from a reader monad, but it's a way of sort of saying this is when we're starting. But other than that nothing else uses monads, well, internally, but the overall semantics is pure with the exception of that.

_JB:_ You... The FRP you're using is use it only for the UI of your application, so does it actually like permeyate to the backend then you can program everything and across a stack and one single programming model.

_RT_: Well, I would love for that to be the case. But right now we do primarily use it for the user interface side of things. We also have a terminal library that lets you build like curses style user interfaces using FRP and reflex itself has no opinion about what you're using it for, it doesn't it doesn't know anything about user interfaces, we have a Reflex DOM library which allows you to do a DOM manipulation in the browser, and then other people have built libraries for this for like native iPhone and I think Android and various things like that. So it can be used for a bunch of things people have also built like web servers that use reflex as their sort of basic model, the only problem with that at the moment is that Reflex implementation like the operational core is all single-threaded, which means that you can instantiate it multiple times so you can run multiple threads but those different threads can't talk to each other in FRP, you have to have them communicate via traditional imperative techniques. So each FRP domain is just sort of its own single-threaded thing, so that's not ideal, we've kept our backends a little bit more traditional for the time being, but I would certainly look forward to at some point having, you know, FRP be the way that we do backends as well.

_JB:_ So, you the us you're building our ??? iPhone, Android and terminal applications?

_RT_: Yeah, we have not built any terminal applications for clients. That has not been a big request, but we've built internal tools that way. Our clients, yeah, we build web, mobile and and also desktop apps for some clients and they all build with the same, you know, semantics the same Reflex DOM based core.

_NV_: And how are you generating your backend, are you are you using JIT?

_RT_: Yeah, the backends that we build are typically built with snap or WAI sometimes and all GHC-based, you know, we certainly appreciate the high degree of parallelism and everything else that do you see provides, I mean it's a wonderful backend language, I don't think that we're doing anything that special I think a lot of Haskell companies get a great benefit out of using Haskell on their backend.

_JB:_ So if you're so heavily invested into to, like GHC and Haskell, how..., when you look at the current evolution of Haskell, like what's happening at the moment with language extensions with Haskell Foundation of course on the governance level, also technically, what do you think, is it going in a good direction, is it going in a bad direction, is it and going no direction and that's good or bad or?

_RT_: I think it is going in a good direction and you know I'm really excited about what Hf??? is doing, so I was asked to be part of the initial creation of the hf??? and now I'm on its board and I'm the treasurer and I think that the board has been assembled from a really excellent, very representative group of people, I've learned a lot from speaking with the members of the board and also members of some of the task forces, like the technical task force and I think it is really going to be very helpful to Haskell going forward I think it's already accomplished a good amount of stuff and fundamentally to me Haskell is like this still mostly hidden gem and Haskell has been the recipient of so much academic work of such high quality, but a lot of that work has not really made its way into production. I mean as you said you know back in 2015 like there were really not that many people doing commercial Haskell. And now there are a lot more but it's still I think a lot less than it ought to be, so we need to improve things like the way that we..., we use improve a lot of the incidental stuff I think that the core of the language is excellent and of course we'll keep improving it I mean there's a lot of really brilliant people working on things, but it's really making it accessible to business so that we can take those academic accomplishments and start to really reap the value out of it. One of the reasons that I'm in industry and and a practitioner myself rather than trying to personally go an academic route is that I just felt like there was a big need to get these high-tech really smart things actually being used, I think that almost nobody would would be happy to invent an amazing thing and then just have nobody else use it. You know, people people want their their ideas to be used and that's how the real value for society gets generated. So yeah.

_NV_: And do you have any suggestions on how this can happen I mean maybe using your personal experience right? because you finished low and like how did you get into haskell.


22:15 <=== HERE


_Joachim Breitner:_
_JB:_

_Nikki Vazu_:
_NV_:

_Ryan Trickle_:
_RT_:



=====



29:38.89
haskellpodcast


29:51.22
Ryan
Well so I got into Haskell Um, actually a little bit before law school I was I did computer Science undergrad and I at that time. Ah, you know I got into law school. And I wanted to make myself a more well-rounded person. So That's why I wanted to go to law school I wanted to really get the education A lot of people say that law school is like a applied philosophy degree and I think that's reasonably accurate. Certainly learned a lot about how to speak and how to think about things that were not just technical and and so I really appreciate that education I never took the bar I never practiced law but but I still am very glad that I that I went and got that Education. Um.

30:45.56
haskellpodcast
40

30:47.25
Ryan
But going back to your question I think that that's really impacted me ah to to take this sort of look of like okay well not not just how do we build this amazing technical thing. But how do we give people the trust they need to actually use it. Um. Databases for example are an area where I skew very conservative because it's like to me if somebody has a brilliant database. They just made yesterday even if it's awesome like I don't know how it's going to respond when like a disk fails in a certain weird way. Or something like that you know whereas with postgres I know it's been put through its paces for you know, 20 years or more um and and so that's I don't know that's that's that's sort of part of how I think about this stuff.

31:36.31
haskellpodcast
So the industrial setting is not trusting haskill because it's still like a bunch of academics playing with him.

31:43.89
Ryan
Well I don't I don't think the academics are doing something wrong. Yeah, you say playing with it I I think it's really substantial work. But I do think it's a different skill set to translate that into something that is easy for businesses to Adopt. You know that means we need to have things like better education which everybody knows about but but we also need things like um, clearer decision making right? like there's a lot of stuff. Haskell is a lot like ah you know, choose your own adventure book right? like there's. A lot of excellent things but just assessing.

32:20.55
Joachim
Especially if your adventure is dealing with dependencies and packet installations then you really have the best game you can hurt.

32:27.21
Ryan
Yeah, yeah, like you know when when somebody starts using Ruby on rails which was so popular like back when I was like starting to get into the tech industry I Read a book on Ruby on rails because everybody was saying like this is the way you should build a website. Um. And I tried it and I didn't like it very much. Um and I ended up switching to Haskell but um, but I see the appeal because it's sort of like this big set piece thing and you don't have to go in and research every little component and you know when. Typically building stuff at Haskell You need a lot of knowledge of how to assess which dependency to use um like there's just not a lot of ah, not a lot of stuff that's like prefabricated for you and industry probably needs more of that kind of stuff in order to make it effective. There's also a lot of. Ah, in industry sort of trepidation about having ah finding enough engineers you know and this is something that I don't think we can directly solve because it's a chicken and egg Problem. We're going to have to sort of gradually grow our way out of it. But. You know business people are afraid that you know if they're dealing with a very small community then what if their business gets big which of course everybody wants their business to get big in at least in the startup world. Um, and then what are they gonna do you know?? Um. So I think it's a valid concern and and there's there's things we can do about it. But it's not going to be any kind of Silver bullet.

34:06.33
Joachim
How how bad is it or how good is it like you you I guess you're in the position of somebody who occasionally you're often has to hire somebody who knows Haskell or wants to learn haskell so how's your experience.

34:17.88
Ryan
Well, our experience has been excellent. So for us hiring Haskell folks is is really great and it's it's nice because people who use haskell. Ah. Have typically taught themselves. Um, so they're they're preselected for having a good amount of motivation. Um there. There are a lot of benefits to hiring people in haskell I think but it's certainly true that if I wanted to go out and hire a hundred developers over the next. two months I wouldn't know how to do that and it might be possible with enough money I think io k has done that kind of thing in the past like the very well funded haskell shops have maybe dug big lifts like that. but but I can see how it would be a challenge. Um, for us on the other hand we we focus a little bit more on you know how can we make the maximally effective team and frankly, we've found that we can do a lot more with you know, 4 engineers than a lot of other teams can do with 20 and so that's really a huge benefit. Not just because obviously from a business perspective. It's more cost effective but also because you you don't have these dis economies of scale that usually crop up in large teams. Um, for example, like. You can't really have a single manager for 20 people you need to have multiple managers which means now you probably need somebody to manage all those managers and that's going to make all your communication. A whole lot slower. so so yeah having small teams of developers. Where each developer is extremely able to make changes in the system. Like for example, we we do everything full stack. We don't we don't divide our engineers into backend at front end. We always work throughout the whole stack. Of course people may have different specialties and things like that. But then usually they'll pair or they'll sort of just talk amongst themselves. Um, but we like to give people responsibility for whole features. Um, and this is way better because it it means that people can sort of do everything they need to do to get things done. They don't have to. Send a request to the backend team and wait three days to hear back that oh no, that's a terrible idea. Um you know and it's it works so much more nicely and and by the way, the fact that we can cross compile haskell to everything that we do browser backend mobile. Whatever that is really a.

37:06.80
Ryan
Key part of enabling us to work full stack because if we had to have somebody who was an expert in Swift and also an expert in in Haskell and also an expert in Kotlin or whatever. There aren't that many people who are very good at all those things.

37:22.64
Joachim
So the the model you describe with having ah a small, very effective team I think I mean definitely sounds great. I wonder does it did do you sometimes hit roadblocks or maybe not roadblocks but where which just doesn't scale anymore because you have a project that's. Too big for even for 5 x programmers to manage where you say okay this is no no, no longer a project for us and you need to go to to ah a company that has these hundreds of programmers available or did it never come up.

37:53.73
Ryan
Well typically what we do as our companies as our clients grow they will. They will start taking over more and more of the project. So you know usually. What we'll do is we'll sort of kick off the project. Get it launched you know, get it to be somewhat successful and then we'll help train internal developers as our clients hire. Um and and and then at some point we'll hand over the project fully. Um, and and that seems to be a model that works pretty well. Um, you know, clearly as well. I guess this is probably not common knowledge in the engineering community. But but in the business communities. It's pretty widely accepted that service businesses are are relatively slow growth and that's what we are as a consultancy. Whereas things like startups are obviously trying to be extremely high growth and so it's not very realistic for us to keep up if 1 of our clients really you know takes off. Of course we would try to do everything we can to to be there for them and and make it happen but generally speaking. As that kind of growth picks up people. Want to start having in-house development teams and and take more ownership of that.

39:13.52
haskellpodcast
But this.

39:13.63
Joachim
But but that's intriguing that means you have companies who've never heard about Haskell before come to you, you build them something that they like and and they're actually now they're suddenly becoming a haskell shop themselves because.

39:27.22
Ryan
Um, yeah, yeah, absolutely.

39:31.84
Joachim
That's like that's like viral.

39:34.16
haskellpodcast
Um, yeah, click. Thank you.

39:36.21
Ryan
Ah, Well yeah, right I Hope so I mean and and the thing is it's not.. It's not like we're trying to sell them on the the sort of theory and like oh man, don't you don't you love purity and and strong types like the business people. Not getting down to that level. They care that the bug counts are lower. They care that we're better at shipping on a schedule and and by the way that's very related to the bug counts right? Bugs You can't really schedule how long it's going to take to fix a bug and if most of your time is spent debugging it really wrecks your ability to plan. Anything on a schedule. Um, so you know we we can build things with less Bugs. We can build it Faster. We can typically build it with a smaller team and the business people see this and you know after a while it can really sync In. So. Yeah I mean that's definitely something. We've been looking to do like you know we've we've always wanted to take these technologies and use them to produce the things that our clients want to produce rather than trying to seek out clients specifically who just want the technologies that we are expert in.

40:48.53
haskellpodcast
Um, but then the hiring problem that I we discussed before becomes more interesting right? because you are asking from business people that don't even know what is hasal to hire Haskell experts.

41:01.56
Ryan
Yeah that's true it it does it doesn't become a challenge. Um I'm not sure that it's ah actually a worse challenge than they have in other ah in in other languages and and the reason is that hiring haskell developers. You may have a little bit less volume like you're not going to get a hundred resumes for a haskell job typically um, but with like I've you know I've had to hire Javascript developers and you do get a hundred resumes and then you have to spend a lot of time. Going through them and and looking for somebody who's actually good and that can be a real challenge. So I think that you know for our clients with our help they've they've always been able to hire who they need to hire. Um I definitely think that you know even even with explosive growth. Don't end up needing an enormous number of developers typically with a haskell shop I mean I think like some of our clients have had like 60 or 70 haskell engineers. So it's you know.

42:11.72
haskellpodcast
Yeah.

42:15.29
Ryan
I Guess IolHK has also been a client I think they probably have more than that. But um, but I wasn't involved in their hiring. Ah so so yeah I guess it's the hiring thing has always been scary but I've never seen it be a really big Problem. You know it's it's it's bark is much worse than its bite.

42:44.10
Ryan
Sorry, just a sec guys.

43:04.90
Joachim
But it's it's not just that you not just haskle that you're betting on and and betting on for your customers and then your customers seem to um, they seem to be happy, but it's still still a bet you're actually there's more interesting. Non-standard tech that you're using. So for I mean. Guess next one would be ghjs which is this gh for I guess I could still say that compiled has go to Javascript which I believe is I maybe may correct me if this is the wrong, wrong way of phrasing it but it was an and an impressive feat of work by. Very few people. Um mostlyd loiter steigman was um and I always wondered is it it very risky to have such a very rarely I mean it's okay that'shasco is rarely used, but. T two two s is even less used component is so central to your business. So but.

44:05.97
Ryan
Yeah I certainly understand where you're coming from on that and and it is it is a project with relatively few maintainers. Um, it's not just lata these days but um, but yeah, it's not ah, it's not a huge group. But we have not found this to be really a big problem. Um, really what it's meant is that a few times we obsidian have had to step in and just do the maintenance. Um, you know whether it's tracking down some obscure bug or ah or. You know helping update to a newer version of ghc and this has been a cost that we've just sort of taken on ourselves and done as part of our open source work. We do quite a lot of open source work. That's not built to any client and it's just sort of what we think is necessary to move the ecosystem forward. Um. And and gc js is is part of that. Um I would say that the benefit we've received from gacjs has been like orders of magnitude higher than the maintenance costs that we've had to pay. I I don't know exactly how much it's been probably like a couple of and maybe like 2 engineer years have been spent on that over the last seven years by us. Um, and it's just not a very large fraction of our total open source work. Even. Um, so yeah, it's I think it's another thing it's ah it's a it's a very reasonable kind of fear but in practice for us. It has not been a problem.

45:45.59
Joachim
And you never had like horrible bucks that you were unable to fix the reasonable end of time or like times where you thought oh my God we made this was a mistake to use this tech.

45:58.16
Ryan
No never I've never had a time when I felt that way there was one really crazy bug very early on right after Ghc Js was released and. It it was getting in the way of of one of the client projects and I ended up having to spend just like a ton of personal time and it ended up being this like really obscure little thing where if you have a heap object with 13 or more. Slots in it like references to other objects then one of those slots would not be traversed by the garbage collector and so if in that situation you had an object on the heap where the only reference.

46:36.31
haskellpodcast
That's hard.

46:51.43
Ryan
Was from one of these missing slots then it would get collected and yeah and and but only if it had some sort of finalizer or something were you really in trouble because this is javascript based So you'd actually still have the data.

46:55.98
haskellpodcast
It right with your team.

47:11.40
Ryan
It's just that your your finalizer would run at the wrong time that that was a very painful thing to track down it ended up being a one character change I think changing a 2 to a 1 or something and you suggest, but um, but yeah, so that that was very tough that was really.

47:20.23
haskellpodcast
7

47:29.18
Ryan
Just when obsidian was getting started. We didn't have any employees at that time allowed to have just released ghtwojs like maybe six or eight months before so we were completely prepared for it to be still buggy and and having issues. But but yeah I don't. I don't really think there's a realistic way that we could do the kind of stuff that we do without having something like Gcs I'm very excited about the webassembly progress that's being made within the ghc community I really hope that we have the ability to to have. Webassembly as a first class compilation target in your future.

48:12.11
Joachim
But in summary I think it's worth pointing out that despite the impression that one might get that. Maybe I also had at some point of G G J s being looking like a dangerous technology. It works very well and if you get your way around of actually. Installing it and using it then yeah, you can use it.

48:33.54
Ryan
Yeah, absolutely you know I think that's to a certain extent this comes down to nonhakell stuff. For example, we use knix for all of our dependency management. And we have a rule at the company that every Repo has to build in 1 step via Nix and when we hand things off to Qa for example, ah and and by the way not every software company believes in Qa these days but we certainly do um and when we hand things off to Qa. We give them a git hash. We don't give them built artifacts. Ah we we just give them a git hash and they are able to mix build from that and this gives us a high degree of confidence that we are testing the right thing and this also includes the ability to pin down things like ghc js like if we have to run. g hc js with a small patch because you know we've found an issue and we fixed it and we've contributed upstream but maybe it hasn't gotten merged or released yet nix makes it essentially trivial to work on these minor forks of things and this really gives us a huge ability. To operate in the open source world as good citizens where we will. We will build patches and and we will fix things in place rather than making workarounds this also saves our clients a ton of money by the way because when you do workarounds in the downstream codebase. Now you're on the hook for maintaining those workarounds forever. It's actually a surprisingly high maintenance cost whereas if you just go into the open source codebase and fix it. Um, you know assuming it doesn't take too long to fix it. It's so much cheaper. Um, so Nix gives us the tools we need. To be able to pin things so that once we qa it like I don't really care if if there's a bug in some version of gc js that we're not using. We're not going to accidentally upgrade to it. You know we're goingnna upgrade to it. We're Goingnna put it through q a and we're gonna be sure that it really works. Um, so. So the the sort of the flexibility to do patching and the rigidity to know exactly what we're building and not have accidental upgrades and things like that Nix enables us to really use things that are active open source projects like this without any. Real downside to us or to our clients and then the second thing is just you know being serious about q a and about process. Um, you know we don't really believe in just you know, putting things out and and.

51:20.87
Ryan
Seeing how users respond I've certainly worked with plenty of startups who kind of put the Q a on their users and I understand the sort of hesitance to to budget out a bunch of money for Q A but every case where I've seen it. It's totally worth It. Um. So You know the fact that we do a lot of that kind of testing really helps us work with technologies where we might be a little bit fearful about about the maintenance.

51:49.71
Joachim
So with user interfaces I'm always kind of interested.. How do you actually go about effectively testing and like do you do you have actually humans sitting there clicking through the thing for every version or is it scripted as it's Selenium. Do you test below the Ui. What what is your key strategy.

52:08.66
Ryan
We do both or all 3 of the things that you just mentioned. Um, so we we have a team of in-house Quality assurance people. Um and their job is to sort of be the hunter killers of the of the process. So they. They go into the app and they're not just running so test scripts right? They're not.. They're not just they do have checklists to make sure they don't miss things but but they're not just sort of like going through a a fixed thing. They're really trying to break the app. You know they're they're. Looking for ways that they can get into a weird state or whatever and they're very good at it. Um, and yeah, no, no, no they they should be.. It's it's It's actually excellent I mean we've.

52:50.76
Joachim
That sounds slightly annoyed.

53:00.29
Ryan
We've been put on the spot so many times by our clients you know Ceo of the client comes in and wants us to demo something and then and then they'll like specifically say like can you show me that thing which looks like it's rarely used you know and you know and our q a team has gone through it and and and it's solid. Um.

53:11.90
Joachim
2

53:18.74
Ryan
So it gives yeah gives me a lot of confidence in demos actually um, but but then so we also do scripted like automated user interface testing. Um, for example, http://reflexdom has a fairly large user interface test suite that is selenium-based and headless chrome based. Ah, and and for us the big, the big question there is. There's a there's a sort of cost or like ah is there's like a time cost tradeoff kind of thing like it takes quite a while to write selenium test scripts um. So. It usually makes sense to start with manual q a on things and then once something is stable at the ui level like if you have something that hasn't changed for six months or a year um it's not getting redesigned and it's also like a somewhat important part. Of the app or whatever then it makes a lot of sense to start doing a lot of automation but we don't jump straight into automation because you know with startups a lot of the time you know we we operate on a two week iteration cycle so we go from releasable thing to releasable thing every two weeks and it's not uncommon for major user interfaces to be getting redesigned every two weeks um at the beginning of a project. You know you you release something to your users and and you see that like you know there's a bunch of complaints like hey I really want to be able to do this thing or this thing is too hard to get to or I don't understand this. And so then you get a redesign and and we want to be very responsive to that. That's how the company can succeed um, but if we were taking the time to write manual or automated test scripts ah for every single ui that would just cost way more with no grow benefit.

55:34.80
Joachim
Don't worry we can cut this this break out but it's better to food Two two let's see we want to go next.

55:34.43
Ryan
Um, yeah.

55:40.91
Ryan
Sorry my noses keeps getting clogged guys Hope I'm not sounding too funny.

55:43.64
haskellpodcast
And.

55:47.98
Joachim
Hello Trans good.

56:02.50
haskellpodcast
I Have this question about the you are all around the world. But but I don't know how to connect it from the stick.

56:10.83
Ryan
Um, oh yeah.

56:17.14
Ryan
Well, that's that's you guys's expertise I'm not I'm not sure. Okay, let's see. Um.

56:25.48
haskellpodcast
But we are we staying technical or not I don't know Yohim Youhala Our other.

56:31.62
Joachim
Um, no I think we we can um out I have a way of making this transition. You just need to.

56:40.60
haskellpodcast
But that.

56:43.57
Ryan
Okay, 1 second guys.

56:47.33
haskellpodcast
About this thing.

56:51.55
Ryan
Okay I finally managed to clear my alive here. Okay.

56:56.63
Joachim
So that so you said you have um, also testing people is it are they like all sitting next door and in in the office or or is is your company more distributed than that I think you're you're based in New York City that correct.

56:58.67
haskellpodcast
You.

57:13.28
Ryan
We used to be based in New York City and yeah, our Qa team did work out of our New York city office um we've always had a principle as a company that we just want to hire the best people wherever they are. We don't do any kind of cost driven offshoring or anything like that. Um, and so we actually found it was extremely useful to be sitting with our Qa guys and be able to work through them work through things with them. Um, now when covid hit we did make the decision early on to close down the office and then. A little bit later that we would make it permanent. Um, now we already had at that time about a third of our people remote. We've always hired internationally as I said but. But yeah, we had twothirds of our people in the New York city office and it was quite a big transition to go fully distributed but it has also had a lot of benefits. The biggest one being that it makes sure that the people who are remote.

58:10.11
haskellpodcast
And.

58:26.97
Ryan
Have equal footing with people who are in the office. You know one of the problems that I think many companies have with remote work is if you've got people you know, get to know each other really well in the office then people remote can really feel excluded. So I think that we were probably.

58:40.92
Joachim
Um.

58:46.55
Ryan
Affected by that as well and so I'm really glad that now we've got a system where you know everybody is able to interact we use basecamp as our primary interaction Tool. Um, and we do a lot of video Chats. You know that kind of thing like like a lot of people are doing now. And the overall effect I think yeah has been has been really positive now. It is. It is a little bit of a challenge sometimes to work across many time zones. But we have primarily dealt with that by you know, ensuring that. Ah, we Well we always have project managers take point on things. Um and they are typically in a time zone. That's very close to the client that they're working with and so when engineers are talking to the client. It's usually a more special kind of. Situation. Um, but the the product managers are able to gather requirements report back to the client work with the engineers because we now have a fully distributed asynchronous process. Um, we don't have a lot of standing meetings at the company. Especially ones that involve Engineers We like to keep Engineers schedules as clear as we absolutely can. Um you know So the the time zone shift between Pm and engineer are not that problematic it still you know still can be a little bit of a challenge but um, but you know all in all. Being globally distributed enables us to hire the best people and that's a benefit that I think outweighs any of the challenges associated with it.

01:00:35.28
Joachim
So maybe to to wrap this up if let's come back to haske a little bit again and there are so many things going on with Heska right now. Both organizational technical. There's extensions to the type system in the making. Um, if if you could make 1 thing. Happen or for for fear you know like to get a fairy tale 1 wish 1 thing about but haskell either something that is already maybe happening or something that's completely. Ah, maybe maybe not not not on the rise and even yet but you could make it happen. Um, do you even a sense what that would. But that would be.

01:01:14.98
Ryan
I think the biggest thing if I had if I had a magic wand I would want there to be a multibillion dollar startup a unicorn as they call them that. Is primarily Haskell focused and I think that would do a huge ah favor to us as ah as a community and just demonstrate that you know it can be used to make money. That's that I think it certainly can be. This is we know that it can be used to to make money because that's what we do every day but it's not always as visible as we'd like you know we have the great work out of ah Facebook now meta with Simon Marlowe and you know we have some other high profile users. But we don't have like a champion in the business community and I would really like to see us have that um and and yeah and I think that means that we as the haspell community. Um, if we want to get that kind of thing we need to make sure that. We're delivering the value of the language to businesses so that it can be you know making it to that kind of scale. Um and and and you know again like making a ah big impact on on people's lives. You know we've we've made this great this great thing we need to see it in action.

01:02:53.13
Joachim
All right I think that that's a very very inspiring answer. Um, thanks a lot for for this for this interview. Um I enjoyed it a lot I Hope our listeners will too and I hope all the people who want to work for a cool heskell.

01:03:04.36
Ryan
Um, you have me too. Thank you so much.

01:03:06.34
haskellpodcast
Can get an answer helpful.

01:03:13.40
Joachim
Using company will not pay attention to the top page on your only of website all right hope to see you at um Siri hack or icfp or any of these and yep, thank you.

01:03:16.25
Ryan
Um.

01:03:24.44
Ryan
Um, yeah I'm looking forward to it. Thank you.

01:03:30.70
haskellpodcast
Um. Both first little.

01:03:36.16
Joachim
All right I think that was great I really liked a lot.

01:03:40.70
Ryan
Um, great.

