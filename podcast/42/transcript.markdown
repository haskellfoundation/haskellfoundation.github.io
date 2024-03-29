*Wouter Swierstra (0:00:15)*: Welcome to the next episode of the Haskell Interlude. I’m Wouter Swierstra. 

*Joachim Breitner (0:00:20)*: And I’m Joachim Breitner. 

*WS (0:00:21)*: And joining us today is Jezen Thomas. Jezen didn’t just flirt with Haskell, but he actually got his hands dirty and founded his own Haskell company—Supercede. We’ll talk a little bit about growing a diverse and remote Haskell team, Supercede’s technology stack, and how prototypes always end up in production. 

Okay. So, welcome, Jezen. So, perhaps you could start by saying a little bit about how you got into Haskell.

*Jezen Thomas (0:00:48)*: Yeah. Okay. It’s perhaps not the same way that most other Haskellers got into it, because I didn’t go to university and I didn’t have a clever professor teaching me it. What I did do was, at the time, I was writing a lot of PHP and Ruby and JavaScript. So, I was quite a typical web developer, and I felt that a lot of things were breaking all the time, despite me trying to be conscientious and methodical. And I got into TDD and SOLID, and I learned all the Robert C. Martin and Gary Bernhardt stuff. And even with practicing that, it wasn’t enough. So, I ended up picking up a book called Seven Languages in Seven Weeks. And it takes you through Ruby and then IO, a prototype or language like JavaScript and Scala and Clojure and Erlang.

And the final language, the last boss, is Haskell. And there was a lot of mystery around this language. And it still has a reputation of being for galaxy brains and not for normal people. But when I used it, I didn’t think that was merited, really. It’s actually a really nice language to use at the term level. For normal web development stuff, it’s fabulous. So, I found that a lot of the problems I was stumbling with in Ruby and JavaScript world fell away just with some pretty basic usage of Haskell’s type system. So, that’s how I got into it. And I’ve stuck that way for a while now.

*WS (0:02:31)*: So, it was the static typing really that helped you the most?

*JT (0:02:34)*: I think so, but it’s not just static typing per se. I think it’s Haskell’s way of doing it. It seems to be much more principled than a lot of other options.

*WS (0:02:48)*: And how did you go from Seven Languages in Seven Weeks, which probably gives you a very cursory introduction to data types and pattern matching and maybe some maps and filters –

*JT (0:02:59)*: It does, yeah.

*WS (0:03:00)*: – into writing a web server in Haskell? It seems like quite a jump.

*JT (0:03:06)*: Through pure persistence.

*JB (0:03:08)*: Is that a Haskell Library? Pure persistence? It sounds like Haskell Library.

*JT (0:03:13)*: Well, that was involved, but basically, I realized at some point that I’m never going to get any good at Haskell by just flirting with the language. And I think that’s what a lot of people try and do. They think, “Oh, this is an interesting thing that isn’t in the C family of languages. I’ll do an advent of code exercise in it, I’ll do a small Fibonacci function or something and then self-indulge, but never do anything more than that,” which is a shame. I decided that I’m going to learn it, come hell or high water. And it didn’t come easily to me. I’m not an academic, as I said, but –

*JB (0:03:56)*: Hell and high water, that also sounds like Haskell Library. I mean, they begin with age.

*JT (0:03:59)*: It ought to be, I think. So, that’s how I got into it. And that’s also what I would encourage other people now, is just get your hands dirty and actually build things and actually have a goal rather than flirting with the language. 

*WS (0:04:18)*: Yeah. I think we had John MacFarlane on a while ago, and he’s the author of Pandoc, and he’s also very much not a university-trained Haskell programmer or anything like that, but he said, “Oh, that seemed like an interesting language. And I needed to write something to convert document formats, and I made Pandoc.” And then it grew into this tool, which is now probably one of the most widely used Haskell binaries out there, right?

*JT (0:04:43)*: That’s everyone’s favorite example of success with Haskell. 

*WS (0:04:47)*: Yeah, exactly. And were you self-employed or were you working for a company at the time when you started using Haskell?

*JT (0:04:54)*: A bit of both, but I was working for a company doing – oh, was it doing all sorts of like React and JavaScripty things and then always doing Haskell on the side. Or if I had an opportunity to sneak Haskell in somewhere, then I would do that. I ended up working for a FinTech in Scandinavia who did a lot of functional programming. I did some more Haskell there, which was a little more sanctioned. But at some point, I realized that if I’m going to be doing this full-time, I don’t think anyone’s going to give me a job doing this because there are lots of other, you know, really smart kids, and there aren’t that many seats still. So, I realized that if I am going to be doing this, I have to create my own job. And that’s what I did. And ironically enough, all of my colleagues now write a lot more Haskell than I do.

*WS (0:05:45)*: And this was the founding of Supercede? 

*JT (0:05:47)*: Yes, it was. Well, originally, I made my own software as a service product just by myself, which was a UK government database filtering tool. And I built the thing by myself. I don’t really want to look at the code again. It’s probably quite embarrassing. I built the thing and designed it and did the marketing and sales and stuff. And I realized that I really am not fit for sales. I’m not happy to jump on the phone in the morning and talk to people, apart from you guys, obviously.

*WS (0:06:19)*: Yeah, yeah.

*JT (0:06:20)*: But to try and get people to give me money in the morning, it’s not something I’m motivated to do. So, I realized that if I’m going to be able to continue realistically doing this, I need to partner with some people in suits who can do the sales side and I can do the product side. So, I actively went in search of people to work with, and I met my two business partners, Ben and Jerad. And we started doing this thing called Riskbook at the time. It eventually stopped being called Riskbook because there’s a company in the world that doesn’t like you using the word ‘book’ in your name.

*JB (0:06:58)*: Gosh, that sounds like a – oh, I probably can’t say that sounds Meta, does it? 

*WS (0:07:05)*: Yeah. A Meta comment, I guess. And then how do you find business partners? I mean, I think most of our listeners are, on the one hand, interested in the technical aspect, but how do you – 

*JB (0:07:18)*: Yeah, I was just about to ask, how do you do that? Because building things, yeah, we know how to do that. How do you actually find people that sell it for you? 

*JT (0:07:26)*: That’s a thing that I think programmers struggle with so much because building things is always the path of least resistance. And there are so many inflection points in that small solo product that I mentioned where I’d sit down on my kitchen table and identify a problem and then think, okay, what could I build to solve that? And it’s like, “No, no, no more building. Building’s not going to help everything.” Sometimes you have to just pick up the phone. Sometimes you have to do some graphical design or whatever. It’s not always building. And I think finding a business partner is the same thing. You’d rather be building. 

For me, I tried a few different approaches, but the one that worked ultimately was a website called CoFoundersLab. It’s a premium subscription, but I didn’t ever pay for it. I just set up a free profile, and people can still find you and then read about you, and then contact you on LinkedIn, say. I think that’s what I did. And I spoke to quite a few different people on CoFoundersLab, but it’s not exactly a treasure trove because, okay, if you are interviewing for a – if you’re hiring for a Haskell job, chances are that just about everybody who applies for your Haskell job is really rather qualified and really very smart. You can’t just invent yourself a Haskell programmer identity. It’s a bit too obscure for that. But to call yourself an entrepreneur takes nothing. Really nothing. There’s no barrier to entry other than some significant ego.

If you go this route, then you’ll end up speaking to lots of people with lots of style and very little clue. So, you’ll have to learn to separate those people. But I did meet – I spoke to a few people who are rather switched on and go and actually do things. And yeah, Ben and Jerad were exactly those people, and they wanted to build a boring business. They sold it to me as being really exciting. But it was in the reinsurance industry, which sounds hella boring, and it is, which is good. It means it’s ripe for change.

*JB (0:09:43)*: Oh, so you actually went on this site not with your business idea and product looking for people to co-found and sell it with you, but rather with the idea of, “Hey, I can do Haskell. Do you have good ideas”?

*JT (0:09:54)*: It was, I’m looking for someone to help me market and sell this thing that I made, but I’m also looking for anything else. And the anything else had better ideas anyway. So, better use of my time.

*WS (0:10:09)*: So, what does Supercede do? Because I had a look at the website and I don’t know anything about financial products and insurance and things like this. But it seems you found a niche for yourself at least.

*JT (0:10:22)*: Yeah. So, we have a few different kinds of clients, and we have a couple of main products currently. One addresses the part of a reinsurance workflow where insurance companies, they have to buy their own insurance on the policies that they’ve sold. And that’s called a reinsurance. In order to do that, they need to gather together all of their policies into something called a bordereau, and they buy reinsurance on that. But they need to do a whole bunch of cleansing and analysis on this bordereau. And usually, the data’s quite bad. And we can gather together all that data and make it a bit less bad. So, a product has a lot of streaming XML passing because everything’s done with Excel spreadsheets, which is essentially a zipped collection of XML files. 

There’s also this problem the companies have where an Excel spreadsheet can only contain a million rows, but they probably have more than a million policies that they’ve sold. One big insurer has like 13 million motor policies that they sold. And how do you manage that? How do you concatenate these spreadsheets and run analysis on them? It’s not very easy. So, the idea is that you chuck the whole thing in Supercede. We build an actual database out of it. And you can do some real analysis there, which you can’t do with Excel. 

So, we model that part where the insurance companies are trying to buy reinsurance. And from the insurance company, it would normally go to a reinsurance broker. And the reinsurance broker would interact with a reinsurance underwriter. Those are the two sides of the reinsurance market. So, we model that, a bit of the workflow also, which is a bit more of a crud-style system of gathering information together and presenting it nicely, and then modeling how the two parties transact on this deal or this risk model. And that’s it really. We have more things in the pipeline, but that’s what’s working so far. 

*WS (0:12:31)*: Sounds good. And can you say something about your tech stack that you’re using?

*JT (0:12:33)*: Yes. So, I’d like to say it’s all Haskell all the time. It isn’t, but it almost is and it’s getting that way. One decision that I think I’ve come to regret is, and this is perhaps interesting for listeners, trying to build out some of the UI with Elm. And usually, when you say that, people jump to the dramatic angle of, “Oh, what was wrong with Elm? Is it because it hasn’t got type classes? Oh.” It’s like, no. Actually, Elm is a fabulous language. It’s bloody brilliant, really. Imagine how much wasted computation and human tears would just fall away if people used Elm instead of React and JavaScript. 

But the problem really is parts of our application were written in a single-page application style, when there was never any real justification for that to be. If we had designed the product or parts of the product a little bit better, then we wouldn’t have added this false constraint where we need a single-page app type of thing, which necessitates Elm. I mean, it’s great. But if you have a system in Haskell and a system in Elm, you need another system to manage the boundary layer between the two and to keep all the encoders and decoders and all the types in sync. And we did that and we have a very clever system for doing that. But that’s yet more stuff to compile. It’s yet more stuff to go wrong. It’s more stuff to maintain. It’s more stuff to train people on. And I don’t think the cost-benefit ratio was right. And when it comes to technology, a lot of our thinking is driven by economics really because we’re not writing software in a vacuum. We’re thinking about, what’s this going to cost us? So, we’re gradually pulling all the Elm out and not replacing it with any other clever frontendy thing. We’re trying to just go all Haskell. 

So, for the Haskell stuff, it’s mostly Yesod. We have some bits written in Servant, like the API parts. But I’m skeptical of the future of that in Supercede also. I think we’re generally quite happy with Yesod. Everyone on the team knows it. It’s a very lovely framework. And we use most of the things that would typically come with Yesod’s scaffolded project. So, Persistent and Esqueleto and Shakespeare—those are all very lovely things and maintained by very lovely people. And we leverage those a lot, I think, to our success. I think we just continue down that road.

*WS (0:15:13)*: So, coming back to the frontend language, your main regret about Elm is that – so you’re saying Elm is a lovely language, but it just meant that we had one more thing to teach our employees, one more language boundary to cross. And that’s what made the cost too high for you, or is there something else? Did I misunderstand that?

*JT (0:15:35)*: No, I mean, the training part is interesting because Elm—I’ve said before that Elm is a bit like Haskell with training wheels. It’s awesome to train people who have no experience with any ML family language to get them on Elm because it really guides them towards the right thing. And that’s what so many programmers need. They need this so-called ‘pit of success’ where they push towards designing things in a really sensible way and not given lots and lots of rope to hang themselves with, which is what a lot of languages do under the auspice of, well, it’s expressive. You can express anything. It’s like, yeah, but you don’t want to express anything. You want to express the right thing—the thing that you actually want. And Elm is so good at that. So, we have had people who are writing Haskell now start with Elm to pick up at least the syntax and gain some familiarity and some of the ways for thinking, which does translate directly across to Haskell. But that’s not enough of a justification to keep it as part of your tech stack and maintain it.

*JB (0:16:43)*: Just to clarify, when you said you’re going all Haskell, it’s now Haskell generating HTML on the server. There’s no more client-side fancy logic anymore?

*JT (0:16:52)*: That’s exactly it. So, I would – yeah, I think that’s a better angle, actually. There’s no more client-side fancy in any flavor. And that’s the direction that we want to go in. I think it’s more brittle, it’s less accessible, and it’s harder to test. So, that side of it is more expensive. And then you think, okay, how do we test this stuff sensibly? Run a virtual DOM and catch very little, or run Selenium and make testing very, very expensive? It’s not a very good situation.

*WS (0:17:21)*: Even in the Elm setting, where I would hope that you could generate events and try to trigger certain behavior and test certain execution paths and make sure that the HTML looks the way that you’re expecting? 

*JT (0:17:36)*: You can do that. And the tools for doing that are all very good, but that doesn’t get you around that system boundary. Yes, that means all of your Elm stuff will look great, and it probably will. But when it needs to interact over the internet with the server, that’s when things tend to fall apart. And your options for managing that are manually with diligence, which doesn’t scale, and it will fall apart because humans are fallible. Or you add more machinery to manage that, like we did. We use, I think, Haskell to Elm library, which is really very good, and it works, but it’s more expensive than just not having this whole fancy frontend bit. 

*JB (0:18:18)*: So, on the other side, towards the backend, you said you’re using persistence as the persistence layer? 

*JT (0:18:25)*: Yes. Yeah. We use Persistent. It works very nicely. 

*JB (0:18:28)*: It’s like a PostgreSQL database behind it, or SQLite, or –

*JT (0:18:31)*: With Postgres. We would like to have a situation where we can use both, or either Postgres or SQLite really because testing with Postgres is slow, so expansive. And CI times are not where we’d like them to be, which I think is a common problem for a lot of people. Actually, that’s a common problem for any tech stack, really. If you’ve coupled your database code to Postgres, then you really have to test with Postgres. And that means if you need to do truncations at the end of every test, then it runs slowly. And that’s not a Haskell problem; it’s a Postgres thing. So, it would be nice to run tests more with SQLite because it’s very, very fast, but not quite feasible just yet for us.

*WS (0:19:22)*: And how have you found growing the company? Because it sounded from your story a little bit like you started with you as the CTO doing the development together with your co-founders and getting a product launched. But then as time goes by, you’ve obviously had to hire people and onboard them. And like you mentioned now, you have more people developing Haskell and less time to work on the actual development yourself.

*JT (0:19:48)*: Yeah, exactly. It’s been an interesting story with growing the company from a few different angles. So, one of the angles is that we’ve had people like peers and investors tell us over the years that it’s all about growth, and all the hardest thing to do in your startup is to grow the team. And you need to think about retention. You need to think about hiring the best people, and how are you going to be competitive. You need to grow, grow, grow. You need to be 300 people within the next 18 months, which is, it’s bullshit. You don’t have a business just because you have lots of people. You can order a hundred people to stand in a field, but you’re not generating money that way. You’re not feeding anyone’s families that way. It’s just, I’ve never understood that way of thinking. So, our team doesn’t have a very high head count. We’re about 20 people now. At most, you’ve been, I think, 25. And we will have more people, but we’re not aching for it. We’ll add people when we have a need to add people. Anything beyond that I think is really premature and silly. 

So, the other aspect that I think is interesting is that people offer and make this argument, why would you use Haskell when there are so few Haskell developers? There are so many Scala developers or –

*WS (0:21:14)*: C# or Java or whatever.

*JT (0:21:15)*: Yeah, exactly. And I think Ruby had the same problem. And I remember hearing David Heinemeier Hansson being asked this question at a conference like 15 years ago of, well, why would you use Ruby when there are no Ruby developers and there’s like thousands of PHP developers? I think his answer was, “Okay, but do you need thousands of PHP developers?? Do you need thousands of developers? Probably not. You probably need like three to get going,” which is true. It’s absolutely true. And we don’t need thousands of Haskell programmers. In fact, if we did, then we’re probably, at our stage anyway, not really leveraging the technology the way that we ought to be. So, we don’t need that many people. 

And funnily enough, when I do post an advert for a job at Supercede, I’m inundated with applications from really high-quality applications. It’s not, “Oh, I just came out of a bootcamp. Can I have a job, please?” It’s like, “Yeah, well, I was a professor at this university for this many years,” or “I worked on this rocket system, I worked on this, I worked on that.” I get really high-quality applications, and it pains me that I can’t hire them all. But that’s the reality. I’m really not wanting for more fabulous Haskell applications or applicants.

*WS (0:22:39)*: And you mentioned in passing as well that you have started using Servant, but are a little bit unsure about the future. So, Servant is interesting, as it really tries to leverage the Haskell type system to generate all the things. But how did that work for you, or what’s the trade-off there?

*JT (0:23:01)*: I think as you said, using the type system to all the things is the more general theme here because the Servant itself is lovely. It’s very nice. I’m happy that people are finding success with it. The issue for us is that, and we’ve used other bits of interesting tight-level programming in the product, but these parts of the system tend to – I’m not sure I could characterize it as collapse under their own weight. But they would ossify. They’d be resistant to change, which is the point. I think the point is that you build in more and more constraints to make sure there are no gaps in your logic, which is for some applications, very good. But we’re building a bigger website in an industry that changes, in a product that’s still developing, that we’re still learning about. So, it’s changing all the time. So, we need to strike that balance between things not falling apart like they would if it was all written in JavaScript and being able to change it fairly rapidly. 

So, we can’t encode everything at the type level because it becomes a bit too hard to change, a bit too expensive. It’s also quite hard to train earlier people on this stuff because it’s non-trivial. It’s pretty tough. There’s a lot to learn. It’s not necessarily hard to learn. I’ve heard that – I’ve read that the Haskell learning curve is not necessarily steeper; it’s just longer, which I think is true. There’s more stuff to learn, and we don’t need to go that far with the type level stuff. So, mostly sticking to the term level is just perfect for us. We still need to think about how to model all of our ideas in the system. So, we still need to use the type system. We still need to create lots of new types. Be diligent in how we use them. We leverage smart constructors quite a lot and a lot of testing and property-based testing and stuff like that. But it’s about striking a balance for us. 

*JB (0:25:10)*: Yeah, that makes sense. You said that one of the big problems with Elm was that you had this language boundary, but there are ways of doing Haskell on the client side. Did you consider going like Reflex-DOM/FRP, some kind of Haskell on the client, which would help with the language boundary? Or were you already put off by client-side logic at that point and didn’t even try?

*JT (0:25:33)*: Yeah, I haven’t tried. I’m sure it’s good. I’m not sure that GHCJS is good, or at least it wasn’t at the time when I looked. It was a few years ago now. But supposedly, it’s just too much stuff to send to the client, and not really a great story there. I’ve been interested in that kind of thing for a long time. I met the guy in Gothenburg who made Haste, which is, essentially, you write Haskell in one place and it generates the code for the server and the client, which is very, very clever. But it’s not purely a technical decision. It’s also a product decision. I think for the kind of application that we do, whether it’s Haskell or not, it really ought to be a webpage with some forms that are accessible, that are designed nicely with good contrast and good text sizing and labels for all the inputs and that kind of thing. And just building a website mostly according to web standards is probably the more important factor here. And I think giving yourself that design constraint leads to a better product, but then also obviates the need for something fancy on the client.

*WS (0:27:00)*: So, how long has Supercede been around? Just to get a rough idea of the timeline here?

*JT (0:27:06)*: I’d say about five years. I’ve been full-time on it for five years. I think the first commit was maybe six years ago from me.

*WS (0:27:15)*: And how’s the maintenance been in that time? Because I imagine that GHC releases are fairly regular and sometimes we hear people complain, especially if they have quite a few dependencies that get out of sync with their own internal tooling that this can create headaches.

*JT (0:27:33)*: Yeah. So, one headache that we have now—not a major one, but it’s a headache nonetheless—is we went down this road of some type level programming in some places, and we’re using the singletons library and then the singlethongs library. But it didn’t work with the later version of GHC, so we have our own fork of it. But that’s not compatible with newer GHC, so we’re stuck on an older version. If we had been a bit more conservative in choosing dependencies, we wouldn’t have this problem. If we had made the dependency graph smaller, then we wouldn’t have this problem. So, we’re working to not have this problem.

Now, I mean, all things considered, it’s not a major problem. We can figure it out. And a large part of the justification for choosing Haskell in the first place is because it’s such a good technology to be able to make changes with. You can very confidently rip things apart and rebuild them and have to compile and still behave as they should, which you can’t really do in most other languages. So, we can actually correct previous mistakes and move forward. But yeah, it’s not terrible. The alternative is you go with something like Python 2 and then realize that you can’t change to Python 3 because everything’s different. So, you do a full rewrite in that case, which we don’t have to do and we’ve never had to do. 

*WS (0:29:02)*: So, do you use – you mentioned singletons and some type level stuff, but at the same time, trying to make conservative choices and staying away from all too much fanciness, like Servant. How do you balance the – when is it worth it to do the extra type level stuff to enforce some property or some variant that you’re very keen on not breaking?

*JT (0:29:29)*: That’s a good question. I think it’s all heuristics and experience and taste and thinking. I think you can’t really get around the fact that you need to make a judgment call at some point and not based on a hard-and-fast rule. It would be silly for me to impose any hard-and-fast rules. Like, “Sorry, but this thing is outlawed,” or “Always do things this way.” That doesn’t really work in software development. You just need to have some taste and some good judgment.

*WS (0:29:58)*: And do you see that you start with a simply typed version and then you see the same bug popping up and up and then someone says, “Oh, I know how to fix that. I’ll do this fancy type level thing,” and then the bill times go up and then someone says, “Oh, let’s get rid of the fancy type level thing and do the simple thing again, and then we will add more tests”? Is there an evolution of ideas and techniques that you see?

*JT (0:30:22)*: Yes, there is, and it depends on the author. And that’s something that Haskell, the technology, doesn’t save you from. And no technology would really, but in Haskell, we still have the same problems that any other stack would have insofar as developers can become distracted by their own self-indulgence and say, “Well, I could express this idea this way.” It’s like, “Yeah, you could, but should you?”

*WS (0:30:53)*: Right. And have you developed any coding standards or general methodology within Supercede that you’ve found has been successful?

*JT (0:31:03)*: I think that the slogan that we’re running with, if I can boil it down to that, is make it smaller, which means use fewer dependencies, use fewer ideas, pair things down if you can, have like half a product rather than a half-assed product, to put it in 37 signals terms. I think that idea of just making things smaller can be applied to quite a lot of what we do in product development.

*WS (0:31:35)*: No, that makes sense. So, looking ahead, where do you see the company developing, and what changes do you see in the way you will use Haskell in the next few years?

*JT (0:31:49)*: Big changes, massive changes. Everything’s going to be different. No, not really. It’s really funny in the reinsurance industry. In the reinsurance technology space, what tends to happen is companies will find some investors, get a load of money, hire some people, have them guided by someone who thinks they know what they’re doing, but doesn’t, sit in a room for two years, and say, “Oh, we’re going to have this amazing product. We’re going to rule the industry. Just check back in two years and we’ll have the best product ever and we’re going to monopolize this thing.” And they go bankrupt.

*WS (0:32:32)*: The money runs out.

*JT (0:32:33)*: Yeah. The money runs out. Their ideas weren’t ever that good anyway, and there’s quite a lot of vaporware in the industry. And we might just end up monopolizing the industry, not by having the best product, but by being the last man standing.

*JB (0:32:51)*: That’s a good strategy as well.

*JT (0:32:53)*: So, what I’m getting at is I think we’re just going to continue to iterate, or the technology strategy I think is good. And obviously, I’m biased, I set it, but it evolved over time. And I’m happy with the direction that we’re going in now that it’s just small iterative changes to continue to listen to our customers and make sure we’re building the right thing. It doesn’t matter if you have this fabulous type level thing that works beautifully if it’s like a feature that no one cares about and you’ve just wasted time and money.

*JB (0:33:32)*: Are you telling me that reinsurance industry customers are not excited by you telling them about the use of singleton library?

*JT (0:33:38)*: It’s worse than that. I think you couldn’t imagine how much worse it is than that. There’s been at least a few occasions where enterprise clients have asked me rather excitedly. “Oh, so what’s your tech stack? Is it TypeScript and Azure, like we expect you to say? Is it Angular, like we expect you to say?” “No, it’s this other thing.” Like, “Uh-oh. Other thing? We’re not familiar with the other thing.” And then I’ll say, “Well, we write everything in Haskell.” And they go, “Wow. Really? But Pascal is so old.” “No, not Pascal. Haskell.” It’s such a common confusion, and I’m not really sure how to solve that. And the real trouble is that people who are confused by this are often people who pull the strings and make buying decisions. That’s a tough problem that technology can’t solve. I’m not really sure how to solve that. As you can see, I’m quite mad about it still.

*WS (0:34:41)*: So, is it – I imagine, especially in a lot of FinTech, it’s hard to get your first customers, right? 

*JT (0:34:49)*: Yes. 

*WS (0:34:49)*: Because especially if you’re using unfamiliar technology. But once you have a handful and they buy into the product that you’re making, the strategy for growth that you’re proposing here is to make the product better and better and then attract more customers iteratively.

*JT (0:35:06)*: Yeah. But it was hard getting our first client. I don’t think it’s for technology reasons, though. I think it’s because with enterprise clients, perhaps just in general, but definitely in our industry, nobody wants to be the first mover really because that’s a really scary idea. Just on a human level, it’s a scary idea. Being the odd one out, being the black sheep, it’s like, “Well, maybe I’m the crazy one. Maybe everyone else is sane. Probably everyone else is sane.” So, getting the first one was tough. It took a long time. But then once you get a few more clients on board, then it’s like, “Oh, they’re using Supercede? Well, I guess we better use Supercede also. We don’t want to be left behind.” So, that helps sales along.

*WS (0:35:51)*: So, how do you know that you’re building the right thing? Because I can imagine that once you have a handful of customers who might have feature requests, which are very valuable to them, how do you know that those are the right features that will attract more customers rather than keep your existing customer base happy?

*JT (0:36:10)*: Yeah, that’s a tough one because we don’t always build the right thing. We have had situations where we’ve spent time building something that ultimately no one cares about. The times when we’ve done that, it’s because someone in a position of relative authority has beat their chest and said, “I know what’s best for this company. We are going to build this thing, and everyone’s going to love it,” despite never talking to any actual customers. It doesn’t really work in practice. What is working is having people on staff who have worked in the industry and know what challenges their former peers are up against. They know what it looks like to work in reinsurance, and they have some ideas for how it could be better. That’s not enough, by the way. It’s not enough to throw an industry practitioner into a product design role because they don’t know what you can do with a website.

*WS (0:37:12)*: Yeah. They can’t imagine what the solution might be in a way or what’s possible. 

*JT (0:37:17)*: Exactly. 

*JB (0:37:18)*: Do they imagine too much as possible or too little as possible?

*JT (0:37:22)*: Usually too little, at least in the reinsurance world, because the systems that they’re used to are in a pretty dire state. A few years ago, I went to visit a software vendor who a lot of reinsurance companies work with and pay for. And the software was astonishingly terrible, and they were quite proud of it. And they would pull up one screen, and it looks like Windows 95. Pull up one screen, and then they’d click a button, and then we’d talk for half a minute. And then it would finally load this new page of data and then say, “See, wasn’t that quick? It only took 30 seconds to load that page.” I was like, “Oh, okay. Yeah. Cool. Maybe we live on a different planet. Yeah. Great.” 

So, I think people’s imaginations are a bit constrained by what they know. So, we have people who have worked in the industry, but they work very closely together with all of our programmers. It’s a really collaborative process. And we do a fair bit of prototyping because we certainly don’t come up with the best idea the first time most of the time. We do a lot of prototyping, even on paper. So, we’ll just write some words out and then sketch some ideas with – I quite like Excalidraw because I’m not very good with a pen. And that’s how we build ideas together. And then we prototype stuff. 

And what’s also part of our technology strategy and always has been is that I strongly believe that your prototype will always end up in production. And so, we do our prototypes in Haskell, and then quite a lot of that actually ends up as just the finished product. I don’t believe in the idea that you’ll do a scrappy version and then, okay, we’re going to scrap that, and this time we’re going to get it right. No, it never happens.

*WS (0:39:40)*: I think that’s something which people at Standard Chartered, which is another FinTech Haskell, it’s not just a Haskell company, of course, but the Strats team there also work very closely with the traders, and they typically write small applications where the traders have certain questions and then the developers go off and implement that. But they need to sit very close together in order because the traders have certain domain expertise and the developers know how to build the product. But bridging that gap, even culturally, is quite challenging.

*JT (0:40:18)*: It can be. That’s another challenge that we have in the business, is not technology-related at all. But from the beginning, I insisted that we’d be a remote distributed team and be able to hire people from anywhere in the world, and we do. But it can be hard to get people to work together that are culturally different and different in terms of the professional work they do. And programmers are often different kinds of people, from salespeople or people who work with spreadsheets and stuff. We try and gather people together every year for a week and just get them to hang out. We did that recently, actually. We were in the south of Turkey for a week, the whole team, and it was very lovely. And people come away with much stronger bonds, and we can all be at ease when we talk and collaborate, which is really cool.

*JB (0:41:15)*: What do you do during the year to keep a remote team coherent, cohesive? I mean, just like once a year seeing it, oh, that’s great, but it probably doesn’t go all the way, does it?

*JT (0:41:26)*: No, it doesn’t go all the way. And I don’t think that’s the main thing that we do either to – it really helps. But I think the main thing is giving people a sense of purpose by having them work on things that actually matter. Before becoming a programmer, I was a musician. And there’s no money in music, obviously, so that’s why I’m a programmer. But there were a number of times when I did it professionally. So, I played in front of thousands of people at times. But there were also times when I would be playing with a band in a local pub to a room with three people in the audience. Five people on stage, but three people in the audience. And two of those people worked there. One of those people was the guitarist’s doting girlfriend or something. Playing to an empty room is really demoralizing. They really – I think in whichever field you’re in, it makes you question like, why am I doing this? And it’s the same with programming. You build something that no one cares about, and it’s like, why am I doing this? 

So, having people work on actual problems for customers and showing them the feedback from the customers—very direct specific feedback on those bits—makes people feel that they’re working on the right thing and that their work actually matters. And that’s definitely more powerful than just one big year in somewhere sunny.

*WS (0:43:03)*: So, how do you see – what’s the future for Supercede? Is it iterative growth for now and then take over the world of reinsurance? Or how do you see the company growing and developing its use of Haskell?

*JT (0:43:18)*: I don’t see us changing away from Haskell anytime soon. If I were to do it all over again, I would pick Haskell a thousand times over. Absolutely fabulous technology. How I see us growing, it would be a lot like the company 37signals. I think a lot of the ways that we think about business now is influenced by the way that Jason Fried and David Heinemeier Hansson think about their business. And we were not trying to pump up the company in order to flip it and then go and live the good life. You can wake up and have breakfast, then sit in your Ferrari for a few days, and then by day four you’re wondering like, “Okay, well, what else do I do now?”

*JB (0:44:05)*: Speaking out of experience or is this like a –

*JT (0:44:08)*: I haven’t owned a Ferrari yet.

*JB (0:44:10)*: Okay. But you’ve had breakfast. It’s half true.

*JT (0:44:16)*: Once or twice. We’re building the kind of company that we wish we could work at. So, we’re building jobs for ourselves, and we’re building the team that we want to be around. We have a very, very lovely team—a sort of accidentally very diverse team, I think—which is a consequence of hiring remotely. One thing I find interesting is that the annual Haskell survey. It’s the state of Haskell thing that goes out every year. Very, very good idea, I think. Very nicely executed. And what it highlights every year is that there are just about no women doing Haskell, which is really a shame. The reasons for which I don’t know. I don’t think I should pretend to know. But we have had a few women at our company doing Haskell. We have two currently, and we’re a relatively small team. So, two is already something, especially given that in the survey, it’s less than 5% identify as women who are doing Haskell. But the way that we’ve gone about it is – it’s hard to find women who are already doing Haskell, but it’s not hard to find brilliant women who are eager to learn, which is what we’ve done. We’ve brought on some brilliant women, and then we’ve trained them up, and they’re very excited about learning Haskell and they’re very productive. 

So, I envision us just continuing on that path of not compromising on our ideals. We’re going to continue to build the best product we can. We’re going to continue to only retain the best people. And ‘best’ in this context doesn’t exclusively mean in terms of technical proficiency. When people say the best person for the job, they’re forgetting that best can also mean in terms of diplomacy, in terms of other kinds of thinking. 

*WS (0:46:17)*: It’s not a linear skill, right?

*JT (0:46:19)*: Exactly. 

*WS (0:46:20)*: Especially if you have a team, the best fit might not be the most experienced Haskell programmer, but it might be someone who brings us skillset to the table that the team really needs, I suppose.

*JT (0:46:32)*: Yeah. I mean, this applies to every technology, but there are plenty of Haskellers who are fabulously technically proficient but aren’t really motivated to do the ordinary work that goes into building a product like Supercede. We have normal crud stuff to build some of the time. Some of it is interesting. Our event source system is interesting. But a lot of it is just building a website, which for some people is beneath them. And they can be fabulously technically proficient, but it doesn’t matter if they don’t do anything. So, I’m really wary of working with pundits—people who have lots of opinions about stuff but don’t actually get their hands dirty. And that’s not exclusive to Haskell; that’s in anything.

*WS (0:47:27)*: In general. 

*JT (0:47:27)*: Yeah.

*JB (0:47:30)*: What is on your visual list for Haskell for the future as a technology, as a community, as a – I guess these two things, besides changing the name to be less similar to Pascal. I think that’s unlikely.

*JT (0:47:46)*: I mean, you can’t fix all the stupidity in the world, sadly. So, I’m going to get a few more lines on my forehead from people like those enterprise buyers. But what I really wish for Haskell is, and not to pat myself on the back, but more people to do what I did, which is just, okay, you can’t find a Haskell job, fine. Go and make one. You’re smart enough to know all this type level stuff. You should be smart enough to go and find people to work with and to get money and to hire some people. That’s probably the best thing that the Haskell world can do, is just have more of it. And what we shouldn’t do is worry about drama stories on Twitter or on the Discord or the Discourse, Discord, I don’t know.

*JB (0:48:35)*: Discourse, yeah. Discourse is the forum. Discord is the chat. Yeah.

*JT (0:48:38)*: All right. Okay. So, Discourse or Reddit. I saw one recently where it’s like, “Ooh, Azure is moving to rust.” It’s like, yeah, but okay, who gives a shit? It’s not going to make Supercede go away. It’s not going to make Mercury stop being a Haskell company. They’ve got like 9,000 modules in their project. It doesn’t matter. We shouldn’t have such tribalism. We shouldn’t have people throwing their toys out of the pram of like, “Oh, well, if such and such company uses Haskell, then I will never use Haskell.” Get rid of it, come on. It’s so immature. I think just build more companies doing Haskell and stop making such a big deal about it. 

Aside from that, I’d love to see some better build times. I recognize that the compiler’s doing more than most other technologies, but it would absolutely benefit us to have a faster feedback loop and better CI times.

*WS (0:49:44)*: Absolutely. 

*JT (0:49:45)*: Part of that’s on us. We took on too many dependencies and perhaps haven’t broken down the project quite enough, which we are beginning to do. It’s nice that in Yesod you can break apart bits of the system into subsites, which is I think interesting because it’s exactly the ideal that many people in the software craftsmanship community have. They talk about this like ports and adapters model, like hexagonal architecture. They have lots of ideas for essentially the same thing, the onion architecture. They’re essentially talking about programming to an interface. Like what you get out of the box if you write some subsites. You can’t be any other way. It’s a very nice design pattern, which we’re leveraging to some degree, but perhaps not enough.

*WS (0:50:39)*: Okay. On that note, thanks very much for your time, Jezen. 

*JB (0:50:41)*: Yeah, thanks. That was fun. 

*WS (0:50:42)*: Thanks for being on the show.

*JT (0:50:43)*: Thank you for having me. Have a good day.

*Narrator (0:50:47)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
