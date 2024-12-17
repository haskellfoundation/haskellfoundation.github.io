*Samantha Frohlich (0:00:15)*: Welcome to the Haskell Interlude Podcast. I’m Sam Frohlich.

*Wouter Swierstra (0:00:19)*: And I’m Wouter Swierstra.

*SF (0:00:21)*: Today we’re joined by Harry Goldstein. Harry is a researcher in property-based testing and human-computer interaction. Together we reflect on random generators, the find-a-friend model, interdisciplinary research, and how to have impact beyond your own research community.

Okay. Well, today we are joined by Harry. Welcome. So, how did you get into Haskell?

*Harry Goldstein (0:00:46)*: So, I actually started with Haskell in my undergraduate. I had learned a little bit of functional programming before that, but I actually was thrown into Haskell in a compilers course. The compilers course didn’t exactly say you had to use a particular programming language. The professor, Andrew Myers, at Cornell said, “We prefer you use Java.” And I think he was pretty firm but fair. He said, “You’re allowed to use other languages, but we won’t bend over backward to help you if you get stuck in another language.” And my friend said, “We should use Haskell.” And I didn’t know Haskell. So I tried using Haskell, and it was somewhat of a disaster. We had to have the course staff give us more RAM in the autograder VM multiple times. I think it was our fault. I don’t think it was Haskell’s fault, but that was a whole thing. And then we didn’t really know what we were doing in this new language that had all sorts of different approaches, but it was just so interesting to try to program in this different way. And I fell in love with the tools for abstraction and with how seamlessly you can walk over data structures and implement these pure functions. 

So, while that experience, I think, was more stressful than anything else, I think it encouraged me to learn more about this language. And then I helped TA a Haskell course in grad school. And that’s where I actually got it. 

*WS (0:02:28)*: So, your undergraduate degree was in Cornell, and then you did a PhD in the University of Pennsylvania. Is that right?

*HG (0:02:35)*: Yes, that’s right.

*WS (0:02:37)*: And what was your PhD on?

*HG (0:02:38)*: So, my PhD was on property-based testing, which is an approach to testing that was popularized in Haskell by the QuickCheck library. And property-based testing, great. I mean, I can do a little introduction to property-based testing for the listeners who don’t know about it.

*SF (0:02:57)*: Yeah, that’d be great.

*HG (0:02:58)*: Okay. So, property-based testing, it’s an approach to unit testing of software. You’re trying to test your software during development to see that each individual part does what you think it does. But instead of doing example-based unit testing where you write input/output examples and you check that your function respects those, you write a property. So, you write some logical condition that your function needs to satisfy. For example, for all lists that I put into my sorting function, the result is sorted. That’s a property, and you can check that for any list. For any list, you can make sure that your sorting function actually sorts that list. So, once you have one of these properties, you test it with a bunch of random data. So, you write a random data generator and you use that generator to produce inputs, and you run all of them through the property, or lots and lots of them through the property. And that gives you confidence that the property is true without having to prove that property or do anything, like more involved model checking or formal verification.

*SF (0:04:05)*: What drew you to property-based testing?

*HG (0:04:08)*: So, it’s an interesting story. I think I went into my PhD not knowing 100% what I wanted to do. I knew I liked PL, but I didn’t really know beyond that, like, what I was interested in. And my advisor, Benjamin Pierce, was doing property-based testing at the time, collaborating a lot with John Hughes, and his previous student, Leo Lampropoulos, who I’m now doing a postdoc with, was working on property-based testing. 

And I didn’t like it at first, or at least I didn’t really see what was interesting about it. I didn’t see the parts that were interesting to me. And so, I wandered around in the first couple of years of my PhD doing other stuff too. Eventually, I came back to property-based testing when I found a couple of things that I found interesting about it.

So, the first is that I think the theory of the random data generators is really interesting. There’s a lot of fun stuff to do with domain-specific languages in that space, and I think that it’s actually a surprisingly hard problem to write good random data generators. And the other part that I found interesting was that this was a part of PL that is really applicable to actual software engineering. I think all of PL has applications at some point, but the applications of property-based testing are excitingly near term, where I feel like I can design some things and they can get into developers’ hands in later this year or next year, which is just a fun place to be where I can do PL research and have this really tangible immediate impact.

*WS (0:05:45)*: So, what makes writing these generators so hard?

*HG (0:05:48)*: Well, the temptation when you’re doing property-based testing, which I think is the right thing to follow, is that you want these properties to be really expressive. But the problem with an expressive property is that there are often very expressive preconditions to those properties.

So, for example, maybe you have an insert function that’s going to insert a value into a binary search tree. In order to test that, what you actually need, the property you want, is, for all binary search trees, if I insert a value into it, it’s still a binary search tree. That’s one property you might test. The problem is that for all binary search trees is a big lift because now you actually need to randomly generate valid binary search trees. And you need to do so hopefully without wasting a bunch of time generating things that aren’t valid binary search trees. And so, this problem in general of generating things that satisfy a precondition is very NP-hard, right? It’s like iterated 3SAT if you think about it like that. So, you can’t automatically do it. The programmer needs to do something there to figure out how to generate this random data. And that’s the space I work in.

*SF (0:07:01)*: I’m aware you’ve done a lot of reflection on different DSL languages. What work have you done on generators for property-based testing?

*HG (0:07:11)*: It’s funny you say reflection, Sam. So, for the listeners who don’t know, Sam and I collaborated on a paper called Reflecting on Random Generation, which presents a domain-specific language for property-based testing generators that can run bi-directionally. They can run in reverse. I mean, we can get into the technical details of exactly how and why one would do that. I don’t know how deep we want to get on that, but the upshot is that by being able to run generators bi-directionally, you basically enable some new algorithms for generation and also for test case reduction, or shrinking they call it, where once you’ve found a counterexample, the reflective generator helps you to make that counterexample much smaller so that you can debug more effectively.

*SF (0:08:01)*: I think the way we did it might be interesting, like how it built from your work on free generators because that links to a common pattern in Haskell, if you wanted to chat about that. 

*HG (0:08:14)*: Oh yes, yes. So, reflective generators are built on a concept called free generators. And free generators, Benjamin and I came up with in a paper called Parsing Randomness, which was a couple of years before the stuff on reflective generators. And the idea with free generators is to basically take the normal monadic language that we use in Haskell for writing data generators. This is the standard way to do it. There’s a generator monad, and you write those generators in that monad. And we basically extracted out a free monad that captures the structure of generators.

And what we noticed in that paper was that the free monad allows you to basically pattern match on the monad as a data structure. And once you can do that, you can do some cool things, like take its derivative. For folks who know about Brzozowski derivatives, Brzozowski derivatives are one of my favorite little bits of computer science. Every time they come up, I’m delighted. And so, that was what we could do with free generators. 

And the idea with reflective generators was that if you take free generators and add on this piece of these partial monadic profunctors, which Sam had been working on in relation to bidirectional programming, you can make a free partial monadic profunctor generator, which gets a little bit complicated. But the idea is that now you can not only pattern match on the generator to take its derivative and do that kind of thing. You can pattern match on the generator to give it lots of different semantics. Some of which are actually backwards. Some of which go from output to input in a way. 

I think there’s a lot of cool stuff going on there with the free structures and being able to reinterpret them. And we also had fun with some type class magic along the way. It was a great Haskell project because we got to, I think, use many of the tools that Haskell gives you for abstraction in cool and interesting ways.

*WS (0:10:29)*: So, why would you want to do this? I can understand these free generators where you make a deeper embedding of the Gen monad in QuickCheck, right, where you can then observe how certain calls to generation are made. And then you mentioned that, well, if you then do apply these bi-directional programming techniques, you can run the generators backwards. But what would be the reason for doing that?

*HG (0:10:55)*: It’s a good question. So, when I say run them backward, what I mean concretely is that you can go from a value that the generator could output to the set of choices that the generator would need to make in order to produce that value. Because in parsing randomness, one of the big insights was like a generator is essentially a parser. It’s turning some sequence of choices into a value. And so, reflective generators go the other way. They turn values into sequences of choices. And once you have choices, there’s a lot you can do with them. You can manipulate them. You can make them smaller. You can do a bunch of stuff to mutate or modify the choices. Prior work has shown that this is useful for various interesting generation algorithms. 

But if you have a value that you didn’t just generate—so, for example, a value handed to you by the user in a crash report or a value that you stored somewhere and haven’t thought about for a while—if you want the choices to do all that mutation, modification, those sorts of things, you’re out of luck with normal generators because there’s no way to get those choices back. There’s no way to know how that generator would produce that value. But the reflective generator gives you that ability to walk backwards and see what choices would produce that value. 

*WS (0:12:20)*: Right. So very concretely, suppose someone files a bug report and says, “If I enter this data, your program crashes,” then you scratch your head and think, “Well, why didn’t QuickCheck catch that?” Right? And then what you could now do is look back to see the sequence of choices that would’ve been necessary to produce this value. And then maybe it’s somehow missed or very unlikely to be generated by your test suite. Is that right?

*HG (0:12:46)*: That’s right. Actually, there’s a few things that you can do. So, one is, if the reflective generator says, “Yeah, I can’t generate that value,” then great. Now you know you have a gap in your test suite. But maybe the reflective generator says, “Actually, I can produce that value,” but it’s just unlikely or something like that, or the space is very big. What you can then do is you can tell the reflective generator, “Okay, now give me a smaller value that’s like the one the user gave me in the crash report, but that still triggers the same bug.” And this lets you debug whatever issue that the user brought to you much more effectively because you don’t have some gigantic file with a whole bunch of stuff going on. You have a minimal counterexample. And you can manually write down shrinking functions, which make values smaller. But that’s tedious, and it also is difficult to do when you have these complex preconditions that the inputs need to satisfy. But the reflective generator just lets you do that automatically because it can retrieve the choices, and then you can shrink the choices in a type-independent way.

*SF (0:13:57)*: And this is not the only work you’ve done on making sure that property-based testing is comprehensive and effective. Could you tell us a bit more about the other work you’ve done to make sure that it’s doing its job?

*HG (0:14:10)*: Yeah. So the free and reflective generator stuff are the biggest pure programming languages, pieces of my dissertation. And I think those have definitely helped developers to do their testing better. But I’ve also done some work on the software engineering and human-computer interaction side to help developers improve their testing. So, we did a study called Property-Based Testing in Practice, where we interviewed a bunch of property-based testing developers who use property-based testing to understand both how they use it and what challenges they face with it.

And I can talk about that a little more, but to more directly answer your question, that study then spawned a project called Tyche, and Tyche is a user interface that helps developers to understand what happened during property-based testing. So, generally speaking, when you do your property-based testing, the testing framework will say, “Okay, 100 tests passed,” or something like that. But it doesn’t tell you much about how successful you were at covering the space of possible inputs. And this can be a problem if, for example, the space is quite big and complex, and you don’t realize that you’re missing important parts of it. And so, what Tyche does is it shows you statistics, charts, graphs, things like that about the inputs that were used to test your property so that you as the developer can look at that and say, “Oh, actually, these are way too small,” or “These are way too big,” or “We’re missing this important case of the variant type,” or something like that.

*WS (0:15:55)*: But that’s just an analysis on the values that get generated. It’s not doing any program coverage or anything like that?

*HG (0:16:03)*: So, Tyche actually does have support for if the language emits coverage information. It can show you stuff about that too. But I think the core insight from my perspective was that knowing about the input space coverage is a really good first step, even if you don’t have the instrumentation to get code coverage information.

*WS (0:16:25)*: Right. So, QuickCheck lets you get some information out, like you can observe the length of the inputs or things like this. What things are you missing from the distribution visualization, or what’s the right word here? Observing the structure of the inputs that get generated that QuickCheck doesn’t offer, or which is somehow you’d like to visualize better?

*HG (0:16:51)*: So, this is a really interesting question. One answer is actually, we’re not missing that much from QuickCheck. Actually, Tyche hooks into QuickCheck’s built-in functions for labeling test cases. And if you structure your labels in just such a way and you call it with a wrapper function, then Tyche will display those labels for you as charts.

There are a couple of places where we wanted to give those labels a little bit more structure, because right now those labels are just strings in Haskell, in QuickCheck, and if you want those labels to be able to be plotted on a graph, you need them to be numbers and parsed as such. So, that’s like a superficial thing that we added.

But I think the more important thing is, the labels in QuickCheck are displayed on the command line as percentages for you to look at in your terminal. And the research in the human-computer interaction and visualization literature is quite clear that humans are not as good at understanding that kind of information quickly than they are at understanding visual information at a glance.

I don’t think Tyche is so groundbreaking in terms of like, it gives you information that you couldn’t get before, but I think it gives you information in a way that is more useful than the way that you had it available before.

*WS (0:18:21)*: Does it do anything fancy in terms of generic programming or something like that to give you some predefined measures of saying, like, what variants of a data type get produced, or the percentages across these things, or do you still have to write the data that you’re collecting by hand for the generators?

*HG (0:18:40)*: I think there’s a lot of room to look deeper into that question. I didn’t implement anything like that for a couple of reasons. First is because, actually, I was implementing Tyche primarily for the hypothesis library in Python, because, actually, that’s the biggest user base these days of property-based testing, not QuickCheck. But I think there’s a huge opportunity for making this thing more ergonomic and more automatic in individual programming languages. And so, yes, I think generic programming to automate some of this stuff in Haskell can and should be done. I just haven’t gotten around to it.

*WS (0:19:20)*: So, you mentioned this user study about talking to actual people using property-based testing. Can you say something about the results that came out of that?

*HG (0:19:28)*: Yeah, that study was super fun. We interviewed a bunch of developers at Jane Street. That was our population because they use property-based testing pretty extensively, but not exclusively. And so, we got a good sense of how they traded off with other forms of testing and what they’re doing with it. And we found a bunch of cool stuff. One was that in a previous study we had done, we found that people had a hard time specifying their programs, that writing the properties was one of the hard parts of property-based testing. And this we found to some extent at Jane Street. 

But one thing that we found which was interesting was that we didn’t hear it very much. What we heard instead was that people were applying property-based testing opportunistically. They were finding these, what I call, high leverage scenarios, where property-based testing is particularly effective and particularly easy to apply for a situation. And that’s when they were choosing to use PBT. There were other times when they would just use unit testing, or they’d do some other kind of testing entirely. And they saved property-based testing for the times when it was either particularly important or particularly easy to apply. 

*WS (0:20:45)*: And what are the characteristics of the kind of code that they’re using property-based testing for? Do you have any conclusion that you could draw from this study?

*HG (0:20:54)*: Yeah. So, often it was your code. This is one core idea of property-based testing, is that I think part of the reason it was able to be popularized in Haskell was that Haskell has pure functions, and purity makes testing very easy because you can run a function a thousand times and not be worried that you’re spawning a thousand connections to a database or doing something else awful a thousand times. So, that’s one thing, is that they had pure cores of an application that they would more often be testing this way. 

Another insight is that they were often testing things differentially. So, if they had two functions that were supposed to behave the same way, maybe one was a more optimized version of the other, or one was a simplified model that they had written to say, “Here’s what this function is supposed to do in theory,”—they could use property-based testing to test that those two things actually agreed. And I think this is a really powerful approach to testing because it’s very flexible. You can use this in many different ways, and actually, it’s so powerful and flexible and important that I worked with a master’s student, Ernest Ng, on a tool called Mica to automate this process for OCaml modules. So, if you have two OCaml modules that implement the same signature, you can use this Mica tool to automatically generate a test harness that can compare them and make sure that they agree.

*WS (0:22:28)*: Oh, that’s nice. I think that’s one thing which is harder to do in Haskell, right? Because you don’t have the module system to define some API, right? In OCaml, you can say, “Here’s the module, the behavior that I want. And now test these two modules, implement that API in the same way.”

*HG (0:22:45)*: Yes. 

*WS (0:22:46)*: So, I think a nice thing about this testing versus reference implementation is that you don’t really have to think about the spec because you have the spec, which is the reference implementation, and then you did something smart to make it faster, or for whatever reason, you have a different implementation that you actually want to work with.  So, there’s been some work on tools like QuickSpec, which try to figure out automatically what a specification could be. How do you feel about that line of work?

*HG (0:23:16)*: Yeah, it’s a great question. First of all, I do want to say, I think that sometimes building a model implementation of your code and testing it against it, I think, is the best spec you can write. There are times when it feels like a function just does what it does. And by modeling it and understanding it at a higher level and checking that, I think that that actually is a lot of the process of specification in and of itself. However, your point about more mathematical logical specifications is a good one. And I think QuickSpec and tools like it—there’s a tool called Ghostwriter and Hypothesis—I think these are important milestones on the way to something that is necessary. 

So, for listeners who don’t know QuickSpec, it generates equational properties and tests them, and then tells you which ones of those equational properties actually hold so that you can add those to your test suite as properties that should continue holding. And it’s really good for certain kinds of functions, but I think maybe a little bit limited when it comes to more realistic code. And this is basically the same for Ghostwriter and Hypothesis, which is really good for a couple of situations, and then can’t find particularly interesting properties beyond that.

But I think one thing that will need to happen over the next, say, five to ten years of property-based testing research is doing something to help developers come up with properties, because sometimes the model-based approach is either too heavy or doesn’t give enough insight into what’s actually supposed to be happening in the function. And so, I think the process of specifying code is one that developers should be going through in some cases. And they need help doing that. So, I don’t know if this is a PL problem or an HCI problem. I don’t know if this is a problem on the better languages for properties or a problem that is just better user interfaces and hints and things like that, but I think that this is a line of work that will be really important over the next five to ten years.

*WS (0:25:37)*: Yeah, writing specifications is just hard, right? I mean, QuickSpecs, like you said, is very good at trying to find equations, but the examples you mentioned about things like binary search trees, I mean, if you just gave the code to someone and said, “Write a spec for this,” it’s like, unless you know what a binary search tree, it’s very unlikely that you guess what it’s actually doing, right? And that’s just even a simple example where it’s the problem that every CSM undergrad encounters. I can imagine it’s much, much harder if you have real-world code out in the wild doing something, right? And then you want to come up with some invariant that is maintained, or who knows what, right? 

*HG (0:26:19)*: Yeah. I mean, I think it’s maybe not as dire as that sounds, simply in the sense that programmers do know what they meant for their code to do in some sense, right? It’s not like they were given this code by someone else. They’ve never seen it, they’ve never heard about it, and they’re asked to write a specification. They had some intent as they’re writing the code. The problem is more in translating that intent to a concrete program that checks the property. And there’s a lot of hard stuff going on there. This is very difficult, but it’s not quite as bad as sight unseen, they have to figure out what a binary search tree is.

*WS (0:27:03)*: Sure.

*SF (0:27:05)*: You mentioned you weren’t sure if this was an HCI problem or a PL problem, but surely it’s both. There’s a lot of work coming up recently combining HCI and PL. What made you end up in this combination, and do you think it’s important that we have both? What are your thoughts?

*HG (0:27:23)*: Yes, it is both a PL and an HCI problem for sure. I ended up in this intersection by accident. I had been doing just the work on generators and stuff like that, pure PL work, and I was a little bit worried that it wasn’t having the impact that I wanted. I was unclear if this was helping. And so, I had Andrew Head, who is a new assistant professor at Penn, who does HCI, had just arrived, and I went to Benjamin, and I said, “Hey, maybe I should take Andrew’s seminar and ask him if the HCI folks have a way to gauge impact in the way that I was looking for.” And it turns out they do. 

Qualitative user research is an amazing thing. It’s a really rigorous and structured way of just talking to people and figuring out how they feel about stuff. But the structure and the techniques of HCI give you a way to actually analyze that data in a way that I feel is a little bit more concrete than just like, “Oh, we talked to some people and we got a vague sense of what was going on.”

And so, that seminar of Andrews that I was taking became a paper called Some Problems with Properties, which was at HATRA, the HATRA workshop. And then that became the study with Jane Street that ended up being a paper at ICSE. And so, this trajectory from not just wondering if my PL work was having impact to pretty medium to large-scale qualitative user study was not something that I expected to happen in my PhD, but I think it was really beneficial.

And I also want to call out, I want to shout out, Sarah Chasins, Joshua Sunshine, and Elena Glassman, who wrote a CACM article called PL + HCI: Better Together. If you want a broader picture of the kinds of things that can happen between PL and HCI, I think that’s a really great place to start.

*WS (0:29:33)*: So, what would your advice be? I mean, I think plenty of our listeners know Haskell and programming languages. And then suppose you want to do something, get into HCI, and figure out what you should be doing better. I don’t know anything about user studies or any qualitative methods. How do you get into that?

*HG (0:29:51)*: As with all interdisciplinary research, there are two paths. There’s learn it yourself or find a friend. I always think the collaborative approach is better. I’m sure Sam agrees. Sam and I gave a talk at a PLMW about collaboration. So, I think finding a person in HCI who is interested in these kinds of ideas, or in PL + HCI, already at that intersection and collaborating, I think, is a great place to start.

My experience with HCI folks—HCI is very broad—especially the HCI folks doing programming tools and things like that, is that they’re super curious and often very interested in hearing about the user-centered problems or what the PL researchers are curious about in that space. And so, I think that’s a great way to go, is to just find someone who’s interested in and collaborate. 

There are also plenty of resources. I’m not going to be able to cite any off the top of my head, but there are plenty of resources for learning this stuff, and you can just dip your toe in and read a few studies that have been happening. There’s quite a few PL + HCI studies coming out recently. There’s stuff at the PLATEAU workshop, the Hatcher workshop, and then OOPSLA lately has been publishing quite a bit of PL + HCI work as well. And reading those papers, seeing the methods they used, reaching out to the authors to ask questions, is another way to do that kind of work if you’re interested. 

*WS (0:31:32)*: So, what’s next? You’ve wrapped up your PhD, or have submitted, I believe? 

*HG (0:31:37)*: Wrapped up. 

*WS (0:31:38)*: Wrapped up. Completely done and dusted. 

*SF (0:31:41)*: The defense was amazing.

*HG (0:31:44)*: Thank you, Sam.

*WS (0:31:46)*: So, what’s next?

*HG (0:31:48)*: So, right now, I’m a postdoc at the University of Maryland, College Park, but I am actively looking for tenure-track assistant professor jobs in the US. So, submitting my first job application later today, I believe, is actually what’s going on here. And I am excited to keep working on testing stuff. I see my work as really spanning programming languages, HCI, and software engineering, because I think that we haven’t talked much about SE, but the testing stuff is very in that vein. And so, I’m looking for a pretty broad set of positions and excited to keep working on stuff with generators. I’ve got some ongoing work on generator stuff. I’m excited to keep asking questions about how people specify code. This is an ongoing thing that I’m thinking about and just generally helping developers with usable tools to make their code better.

*WS (0:32:55)*: So, I know this is a Haskell podcast and people talk about AI way too much, but what’s the role for this property-based testing in this era where half of our code is generated by Copilot and tab auto-completed, right?

*HG (0:33:12)*: Yeah, I think there’s a big question about, like, is programming going away, and all of that kind of stuff. And I think that if programming is unambiguously communicating to the machine what you want to happen, then programming cannot be going away, because ultimately, when people are using LLMs, what they have to eventually do is communicate unambiguously what they want to happen. And so, in a way, I think properties and specifications become even more important when programmers don’t have to write the low-level code as much because they still need to communicate what that low-level code is supposed to do, or else it won’t happen. So, I think that property-based testing, and more broadly formal methods, has a big role to play here in terms of helping developers make sure that the code that is being generated by LLMs is actually the code they intended.

*WS (0:34:13)*: So, do you see a renaissance for program calculation of the 50, 60 years ago where people like Dijkstra said, “Well, you should write your specification and then from that specification derive a program”? Is it now going to be, we’re going to teach our students to write good specs, and then the LLM will just figure out how to actually turn that into an implementation?

*HG (0:34:37)*: Maybe. I think that the more important part is that we teach our students to write specifications. Whether or not they’re prompting the LLM with that specification or with text or whatever, the output code should get tested against that specification. 

*WS (0:34:55)*: Exactly.

*HG (0:34:35)*: Right? Or be verified against that specification. I don’t know. I think maybe the direct line from specification to code is going to continue to be fuzzy because LLMs might not understand the specification as well as human language, but you can then validate that code with the specification, and you should.

*WS (0:35:18)*: Exactly. Yeah. Now that’s the line I was thinking where you would actually start thinking about your spec and then maybe ask, prompt the LLM to give you some kind of program, and then you can test whether that’s actually the thing that you wanted because you had this spec that you thought about very hard to make sure that it wasn’t wrong, and then you have some degree of confidence in it that the code you just copy-pasted is actually doing the thing it should.

*HG (0:35:44)*: Yes.

*SF (0:35:44)*: One thing we haven’t touched on is your contributions to the community. So, you’ve done a lot of PLMW talks. I know because I did one of them with you. But do you want to chat about those?

*HG (0:35:58)*: Yeah. I mean, I think that PLMW is just an amazing thing that we as a community do. I think that the PL community works really hard to provide things like PLMW, and I think it’s a huge benefit. So, Sam and I gave a talk called Consider Collaboration at POPL’24, which was so fun. That was so much fun to write and to give. And then at ICFP’24, I gave a talk about my PhD compass and about navigating a PhD. And I think that I’m so excited to be able to give back to the community in that way, and I hope to be able to continue doing that by helping to organize PLMW in the future and also to just continue being involved in initiatives like it, especially, I think, PL is intimidating. I think Haskell’s intimidating, and I think these are really amazing techniques and amazing communities. And we should want as many people as possible to be able to access them and thrive in these communities. And so, I think that things like PLMW are hugely important.

*WS (0:37:14)*: So, another way to give back to the community is through teaching. So, is that something you enjoy?

*HG (0:37:20)*: Oh, I love teaching. Yes. I haven’t gotten to do as much of it in the last few years as I’d like, because finishing up the PhD is quite a struggle, but at the beginning of my PhD, I spent a few years helping Stephanie Weirich teach her Advanced Programming course. I love the title of that course because it’s Trojan Horse’s Haskell into the students’ lives. It’s truly just a course on Haskell, but it’s called Advanced Programming because Haskell gives you lots of tools for advanced programming. But I love that course. I think many Haskell courses have been based on it at various other universities.

Teaching Haskell is so fun because not everyone ends up coming away thinking it’s the best thing ever. But some students really get it, and they have this moment where they’re like, “Wait, I don’t have to worry about all these things going wrong that go wrong in other programming languages, but I can just think about this like it’s math, and it just works?” And that’s really special, I think, when you can show a student a new way of doing things that they hadn’t considered before and open up their mind in that way because a lot of students up to that point had seen no functional programming or very little functional programming, and certainly no pure functional programming. And it’s very exciting to be able to do that. So, yeah, I love teaching, and I especially love teaching functional programming languages like Haskell.

*SF (0:38:55)*: We had a really nice quote from a student at Bristol, because we teach C and Haskell at the same time. At the beginning they went, “C is useful, Haskell is weird.” And then eight weeks in, they said, “Haskell is beautiful, C is ridiculous.” My co-teacher told me that. I was like, “That is brilliant.”

*HG (0:39:17)*: Oh, I love that. 

*WS (0:39:18)*: So, a lot of property-based testing finds its roots in the QuickCheck work from 20-something years ago. So Haskell’s changed a lot in the meantime. How up to speed is the property-based testing on modern Haskell, and what features would the language need to make it even better for property-based testing? We touched on purity, which I think is an important one, right?  Because if you want to throw a hundred random inputs at a function, it helps if you know that it’s not going to write to a file every time you call it. But maybe there are other things there, either in the IDE or the development environment or anything like that, which would make it easier or encourage people to use these new techniques more.

*HG (0:40:08)*: Yeah. I think certainly, things like Tyche to give feedback in the IDE is one thing, and making sure that Haskell is good at integrating with IDEs in that way is really important. I also think that there’s a lot when it comes to generators that need a fair amount of things like metaprogramming and computation at compile time and things like that because what you’d really like is for a person to be able to write down a T to bool function and have them just derive a generator from that.

But I think that there’s almost no hope within the language of being able to do everything you want with that. And so, like, metaprogramming and things like that, I think, are really important. I think Typed Template Haskell and having that continue to improve can unlock a lot of things there. And then also, just like as much as possible, giving people feedback on their specifications, feedback on their generators, better error messages are important. I mean, I think anything to help a developer understand what’s going on in their application better is better for correctness, right? I think we think of correctness as being about proving things correct and things like that, and I think it is. But also, you can get a long way towards correctness by just making sure users understand what’s going on. And so, yeah, everything to aid in understandability is really key.

*WS (0:41:54)*: Right. So, that brings us back to HCI and PL, I guess.

*HG (0:41:57)*: Yeah. If I had to sum up my vision in a sentence, it’s that I think that by making programming tools more usable and understandable, we can help developers make their programs more correct, right? That correctness is fundamentally also about usability and understandability, and that you can’t separate those things.

*WS (0:42:22)*: Great, that’s very nice.

*SF (0:42:24)*: Thank you very much for joining us. Best of luck with your job hunt. Thank you. 

*HG (0:42:27)*: Thank you.

*Narrator (00:42:29)*: The Haskell Interlude Podcast is a project of the Haskell Foundation. It’s made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
