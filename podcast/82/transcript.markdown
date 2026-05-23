*Matthías Páll Gissurarson (0:00:15)*: Hello, and welcome to The Haskell Interlude. Mike and I –

*Mike Sperber (0:00:19)*: Hi.

*MPG (0:00:19)*: – talked to Fraser Tweedale. Fraser works at Red Hat and is on the Haskell Security Response Team. We talked about security in the context of Haskell, both technical and organizational issues, and also the political issues involved. Fraser’s work is both really important and not well-known in the Haskell ecosystem, so it was high time for him to come on the show. 

Welcome, Fraser. So, how did you get into Haskell?

*Fraser Tweedale (0:00:46)*: Great to be here. So, I first learned about Haskell when I was working at a local software company here in Brisbane, a medium-sized company. And I’d been in the industry at that point for maybe three years or so. And during the lunch breaks or the breaks, I would read Hacker News and other sources of technology and software industry news and discussion, and up popped all of this chatter about Haskell. And it was because of the Learn You a Haskell book, which had recently been published, or I think it might have been just the online version at that point. It hadn’t gone to print yet. But there was a lot of buzz around this book and this explosion of interest in Haskell at that time. 

So, I was reading about that, and I discussed it with some of my colleagues. “Oh, this looks interesting. Have you used Haskell?” And quite a few blank stares, and one or two people went, “Do you mean Pascal?” “No, Haskell.” And my team lead at the time, he whizzed around on his chair and was like, “Ah, yeah, you definitely need to learn Haskell. Go read the book. Go get into it. It’s an awesome language.” 

We didn’t do any functional programming stuff at that company, but I liked my dev lead and respected him and his technical opinions. So I thought, “For sure, okay, I’ll go, and I’ll work my way through this book.” And yeah, I think I was hooked from chapter one. A completely new way of looking at what programming is, what is a program even, or what is computation. It’s an approach that really made sense to me and clicked for me. Not everything straight away, of course. That takes time. 

But yeah, I think from that point on, that was the start of my journey. And I very quickly looked around and tried to find meetup groups to do with Haskell or functional programming and got hooked in with the Brisbane Functional Programming Group, which, at that time, was really big. I mean, at least for Brisbane, it was big. I think typical attendance at that time was maybe 60 or 70 people. So, it was a really vibrant scene. A lot of people, both from academia and primarily industry, getting together, bumping heads, sharing knowledge, and I was hooked.

*MPG (0:03:15)*: Was it a Haskell-focused group or –

*FT (0:03:18)*: No, not at all. There was some Haskell content. But if I remember correctly, the very first session I went to, they had two talks. The first talk was on – I think it was on a database that was written in Erlang. I can’t remember the name of it, but there was someone who was part of the group who worked on that database, and he gave a presentation about Erlang and on that system that he worked on.

And the other talk was kind of a theoretical talk about co-recursion and co-data. I took physical damage from this talk. I mean, it hurt my head. And that’s not everyone’s cup of tea. I can understand at the end of a day’s work and in people’s busy lives, the idea of going to a meetup and getting punched in the face with math that’s really conceptually dense is not their cup of tea. And that’s fine, I get that. But it was definitely my thing. Yeah, I went away from that night, that first night that I had attended, and I knew for sure I was going to be a lifer.

*MS (0:04:36)*: Can you expand a little bit on the background that you were coming from? So you said you were using Haskell at the time, at the company that you were working at. But what is the difference between the computational model you’ve been trained on and the new one that you found with Haskell that you found compelling?

*FT (0:04:54)*: I had done a little bit of programming in school, just in the senior years. And at the time, the language that was taught in Queensland schools was Pascal. So this was my introduction to programming. I then went and studied computer systems engineering, so a Bachelor of Engineering with the major of computer systems engineering at University of Queensland. And this was a really interesting major, because it was digital hardware design and low-level programming. So, a lot of embedded systems stuff, that was kind of the bulk of the coursework once we got past the introductory years. So, circuit design, embedded systems programming, so a lot of C, a lot of assembly, various different microcomputer architectures, and also ASIC design.

So, I remember in my final year we even had a course out at a lab at the technology park in the south of Brisbane, and they had systems there for doing ASIC design, integrated circuit design, and we would go there and use this software and actually lay out transistors on chips and design chips. And that was super cool. They never got fabbed, but we got to learn the design process.

And in addition to that, there was, of course, programming courses. And these were C, and in terms of higher-level programming languages, Java was the thing at that time. So that was the extent of my training in programming. Very much imperative, very much a model of computation where what a programmer does is gives the computer a series of instructions to execute sequentially on a CPU or a microcontroller.

Following university, there actually is not a lot of work in Australia in that specific focus area of my degree, that being embedded systems and digital hardware design. So I ended up in a software job, and I worked in a few different jobs. The first one was doing internet filtering, so a high-performance packet engine basically with deep packet inspection, and in addition to that, a mail store-and-forward system. Then the next place I worked on, I say the gaming industry, but it was the gambling industry, and we worked on lottery systems. And also at that company, I worked on payroll and tax. So, one company, two very different limbs of the business. That was where I first encountered Haskell. Not through that company, but that’s where I was. 

*MS (0:07:44)*: I mean, do you remember at all what it was that struck – I mean, were you fed up with the technologies that you used before and the imperative paradigm, or was it just that this new vision of Haskell was so compelling that it made everything pale in comparison?

*FT (0:08:03)*: That’s a great question. I would say that I just found the notion of telling the computer, telling the compiler what things are, building a model of your problem in the computer, and simply letting the compiler figure out the details of how to do the computation on that model or within that model, subject to the constraints that you give it, which are the types. 

Yeah, I can’t really explain it other than that this made a lot of sense to me and I could immediately see the benefits of programming in this way, in terms of composability, in terms of narrowing the amount of scope you need to have in your head, the amount of context you need to have in your head in order to reason about a program. And yeah, definitely, I could see the benefits.

It was not that I was fed up with any of the tools I was using. And indeed, today I still am mostly not using functional programming in my day-to-day work. But using Java is a big part of my current job, and also Python and a little bit of C as well. Nowadays, I’m starting to get into Rust in the work that I’m doing.

But yeah, I think for me the paradigm of functional programming, expressing computation as functions, and also the capabilities of languages like Haskell and those ML-style languages that give you ADTs and really cheap and rich ways to express data structures, to me, the benefits were abundantly clear from very early on. 

*MS (0:09:50)*: So, you seem to be implying that while you were – you liked the computational model of Haskell, but you haven’t really been able to use it at work, right? You must have wanted to, though, right? 

*FT (0:10:02)*: Definitely. And yeah, I have managed to eke out a few small wins for Haskell, or at least for using Haskell in my day-to-day work. I’ve been now for nearly 12 years, actually, at Red Hat. So, a long time in one company. Over that time, I’ve used Haskell to write a few small internal tools for a couple of odd jobs. Most of them are not in use anymore. 

I’m a big fan of Hakyll. So whenever I need to build web resources, that’s my go-to tool. And in fact, just in the last week, I’ve been preparing for a PKI workshop that I’m running at a conference and building web resources to present the curriculum for that using Hakyll. Okay, this is not very advanced stuff, but it’s still nice.

There was one significant project that I proposed a while back, and the unwritten side of this was – and I would like to use Haskell to do this, but that was not really why I was proposing the project. And it was a significant investment that I was proposing in the PKI (Public Key Infrastructure) sphere, which is one of the main things that I work on at Red Hat. And it turned out that that was not the kind of investment that the company wanted to make for very sound business reasons that I didn’t fully appreciate at the time. So that didn’t get off the ground, but it was not because I wanted to use Haskell that it failed.

But yeah, I’m definitely beating the drum. I’m always taking opportunities to encourage colleagues and people I meet in industry to learn Haskell or consider functional programming in general. I enjoy running workshops internally and externally, educating people about functional programming. So I’m hopeful that one day I’ll be getting paid to use Haskell, but at the moment that hasn’t happened for me. But that by no means has dissuaded me from continuing to use Haskell outside of work and to invest in my own growth in functional programming and in Haskell and in my investment into the community and the ecosystem. 

*MPG (0:12:34)*: You worked a lot on – so you worked on security stuff with PKI and stuff. So could you tell us a bit about – like your JOSE package and all this cryptography work that you’ve been doing in Haskell and how that compares?

*FT (0:12:48)*: The JOSE package is my most widely used artifact of my Haskell production. And yeah, I think it’s quite widely used. I get enough bug reports and feature requests to prove to me that there are plenty of people out there using it in anger. So, this is not necessarily my objective, but it’s nice to know that something that I’ve done has generated some value for people.

How that package came about was at the time, there was a – would "project" be the word? Or a campaign of the Mozilla Foundation to popularize an identity provider protocol called Persona. This was to present an alternative to the prevailing and now dominant web SSO protocols like SAML or OpenID Connect and provide a much more end-user privacy-preserving identity provider system by having the browser mediate between the identity provider and the relying party, so the websites you’re trying to log into. 

So I wanted to use this system. I wanted to support this initiative. Having newly come into Haskell—I mean, this was quite early in my Haskell journey, I think probably even in my first year since learning about the language—I decided, okay, I’m going to write a Persona identity provider, and naturally I’ll use this new exciting language that I’ve picked up to do that.

The JOSE library emerged as a dependency of that work, that was even before the JOSE – JOSE for someone who doesn’t know is JSON Object Signing and Encryption. It’s basically a completely unneeded reimplementation of a whole lot of stuff that already existed and had been battle-tested for decades, namely ASN.1. But because it wasn’t JavaScript-y enough, they do the thing that technologists always do and throw out all the good old battle-hardened stuff that works and still works and build something completely new and make a lot of the same mistakes all over again and some new ones to boot. That’s exactly what happened with JOSE. 

But my library development followed the development of the specifications until they were finalized. And yeah, since then I think the library has become fairly widely used. But only the signing and verification aspects of the JOSE specs are implemented. So, the encryption part, I have a branch with a start on that work from probably 10 years ago now that I never finished, and no one has been loudly complaining about the lack of the encryption support in my library. So for now, that’s something that isn’t there yet. Maybe one day. 

*MS (0:15:57)*: So, can you talk a little bit about if I’m a software developer, I’m developing a system, where would this library fit in? What does it do? When would I look at it? 

*FT (0:16:08)*: It implements public key cryptography, not the low-level stuff. So we’re depending on Crypton at the moment for the actual cryptographic operations, but it implements a higher-level wire format for transporting keys, transporting signed data objects. So the object that bundles a parcel of data you want to sign, the signature itself, and optional metadata about that signature or about the object. So, things like the key ID, the validity start time and end time of the data, audience information, so who is this data intended to be used by, or who are the expected relying parties.

And that’s the base spec. Then there are many other specifications that use the JOSE spec as a building block. So some specs that many people I expect would be aware of would be OpenID Connect, which is a web identity provider protocol, and ACME, which is the Automated Certificate Management Environment protocol that’s used by the Let’s Encrypt CA and nowadays some other CAs as well. And this is a protocol for automating domain validation and the issuance and the life cycle management of X.509 certificates or SSL/TLS certificates.

Although I said, and I stand on what I said, that JOSE was a completely unnecessary development and it would have been better if people had just implemented libraries for ASN.1 and DER, the encoding of the ASN.1 data, but humans gonna human. It’s that whole xkcd thing. There’s too many competing specs, so I’m going to make a new one that’s better than all the others. And now they’re just adding one more broken thing into the pile of broken things.

*MPG (0:18:17)*: I mean, I use this a bit myself, and I use the JWTs, right? The tokens to represent users. It’s quite useful for user representation. I mean, that’s why – I mean, servant-auth depends on JOSE as well, right?

*FT (0:18:37)*: That’s correct.

*MPG (0:18:38)*: It’s one of these base packages that you – because of the magic of Haskell, you just set things up so they just work. But I think JOSE is one of those packages that is load-bearing in making things just work online without having to manually implement claim sets and whatever. 

So, you’ve done some work with the security in JOSE, but then you’re also part of this Haskell security group, right? So, could you tell us a bit about that group and what they do, or what you do?

*FT (0:19:14)*: Yes, I sure can. So the Haskell Security Response Team is a small volunteer group who look after some aspects of security of or within the Haskell ecosystem. Okay. That’s a very hand-wavy thing that I just said. 

In practical terms, what do we do? We manage an advisory database where we catalog discovered security issues within the Haskell package ecosystem and also within the compiler and build toolchain ecosystem. 

In addition to that, within the scope of the Security Response Team’s work is not so much development of downstream tooling to consume the data in the advisory database but encouraging people to use our data, collaborating with them or liaising with them to understand what do they want, what do they need from us to make that data useful for them and easy to consume so that they can then go and build the features that the Haskell ecosystem—the Haskell community, all the way from the big commercial users down to individual hobbyists—can use Haskell securely and can know when there are security issues within the parts of the ecosystem that they depend on so that they can respond to security problems. 

We also publish—well, we have one so far, but there’s plans for more—guides, so best practices guides around security for Haskell developers. So this can cover things like, okay, for a Haskell developer, what do they need to know about Git security or code repository security? What do they need to know about things like how to bundle C code securely within a Haskell package and things like that?

*MPG (0:21:16)*: All right. So, you often don’t think of security in Haskell at the same time, right? Because you think, “Oh, we have managed memory. We don’t need to worry about that.” So, what things is it that crops up in the Haskell system that’s not the same things as crops up in C, for example?

*FT (0:21:38)*: It’s true that if you’re using Haskell without breaking out into any C or providing C bits using the C FFI in your project – and by the way, there are many good reasons why people do want or need to do that. And when that’s the case, then there’s a significant potential for memory issues to cause problems, security problems, or other kinds of problems in Haskell programs. 

Within the whole umbrella of, like, what are legitimate, logical, sensible ways to use Haskell, there’s still a significant scope for memory issues that can crash a program, and even using the unsafe bits of libraries like bytestring or anything else that is exposing lower-level memory primitives. So even if you’re not using C, but you’re breaking out of this nice and generally very robust memory management model, which is the default way to use Haskell. But, yeah, there are many reasons why someone would venture outside those bounds and forfeit some of the safety that Haskell offers by default.

But that being said, the question has frequently arisen, and I’ve been part of many discussions around, is Haskell more secure than other programming languages? My opinion is yes, but not much. The scope of what using Haskell in a sensible way secures you from is quite limited. And now that we have an advisory database and we track information in there about what are the underlying weaknesses or coding or architectural mistakes that give rise to these vulnerabilities, well, then we actually have data in the database to track all this stuff. And it’s qualitative – quantitative data, rather, so the Common Weakness Enumeration or CWE taxonomy, which gives you a whole hierarchy of all of this information. And we can extract that information and analyze it and learn about what are – there’s the OWASP Top 10 for the web, right? And that’s the list of the top 10 security issues that arise on the web or in web development. And we can do the same sort of thing for Haskell. What’s the HSEC top 10? 

*MS (0:24:08)*: What would be number one on that list?

*FT (0:24:10)*: Number one on that list would probably be cross-site scripting, which is still, or if not still, then was recently, until recently, number one on the OWASP Top 10. Cross-site scripting on web-related projects written in Haskell is still a significant issue.

*MS (0:24:29)*: Yeah. So, is there anything that would be on the Haskell list that is not on the OWASP 10 that is unique to Haskell, or maybe not so typical of other technologies or languages?

*FT (0:24:38)*: Not really. So far from what we have seen, the kinds of errors that programmers are making in Haskell are basically not really different from any other widely used programming language, except that, because of the good memory management that we have by default in Haskell. If you’re not using any of the escape hatches, then you don’t have to worry about something like a segmentation fault or double free or anything like that. Unless you’re doing stuff involving those memory escape hatches that I discussed earlier, then you don’t need to worry about those sorts of vulnerabilities.

But most sorts of vulnerabilities that arise in real-world programming in industry are as likely to affect Haskell project as any other language. So we have cross-site scripting, is a fairly significant one. Other kinds of injection vulnerabilities, like code injection, a shellcode injection. If you’ve got a program that’s thunking out to a shell or running external processes, that’s a significant risk that you have to be aware of and mitigate.

Simple logic programming errors, Boolean blindness, yes, these are things we see in Haskell, even though it is very easy, very cheap, and very sensible in a language like Haskell to make dedicated data types for representing flags. Is this flag on or off? Well, I think we have been trained as programmers typically to reach for a Boolean because fundamentally we’re expressing a binary state. So okay, we want a Boolean for that.

But when that gives rise to problems like you have in your type signature, okay, it’s a Boolean true or false. Well, does the true mean on or does it mean off? When the use case of the data type becomes divorced from the definition of the data type, it’s very easy to make logic errors. And we see this in Haskell.

So, if I can give one piece of advice, and I’m speaking as much to myself as anyone else in this, because I know that there are lots of places in my code where I’ve done this, but yeah, just make a data type. If it’s a Boolean, it doesn’t matter. A CGT event is eligible for a CGT discount, or a CGT event is not eligible for a CGT discount. Like, just type a few more keystrokes. It’s much less expensive to make a few extra keystrokes than to make an expensive mistake in your code.

*MS (0:27:25)*: I often look at other people’s Haskell code, and I think that’s a general piece of advice, right? Do a few more keystrokes to name things better.

*FT (0:27:33)*: Yeah.

*MPG (0:27:34)*: Yeah.

*MS (0:27:34)*: Right? Don’t call everything A and X.

*FT (0:27:37)*: Well, that’s a good comment to make because actually when it comes to highly polymorphic functions and parametric polymorphism, I am a big believer in, like, if you don’t have any information about the thing, call it an A, call it an X.

*MS (0:27:53)*: Oh, absolutely.

*FT (0:27:54)*: But where you do have that information, by all means, give it a 50-character identifier or a 50-character constructor name. 

*MS (0:28:03)*: Well, if you do that, then the fact that something is named A actually gives you some information, namely that you don’t know anything, right?

*FT (0:28:09)*: Yeah, for sure.

*MS (0:28:10)*: But if you don’t do that, then everything is muddled, and it gets difficult to figure out, as somebody else reading the code, what’s going on if concrete things are named A or X.

*FT (0:28:23)*: Yeah. And it’s not just other people, other programmers, that you’re being nice to. It’s also that other programmer that is yourself in six months or in three months or in two weeks when you look at the code and you think, “Ah, what fool wrote this?” And you check the git blame, and you’re like, “Oh, that was me two weeks ago.” Yeah. Okay.

*MPG (0:28:39)*: Right.

*FT (0:28:40)*: Humans are sometimes slow learners, and I’m certainly not that fast a learner. And I have had to make these mistakes many times before the practice of doing what seems like a little bit of extra work up front to avoid the mistake arising and the pain or the extra work that comes later because of the mistake.

*MPG (0:29:01)*: Right. Well, you mentioned toolchain attacks. Because we have Cabal and we have Hackage and we have this whole shebang, right? Are we more susceptible than, say, the npm package system? Or is it like because we have fewer users, we are kind of, “Oh, I know this author, so we can use this package more generally”? So, how are we doing toolchain-wise? 

*FT (0:29:33)*: Yeah. So what you’re talking about is generally known as supply chain security in the cybersecurity sphere. So that’s the big buzzword anyway, supply chain security. It’s incredibly important. There are so many different facets to supply chain security, and it comes down to the tools developers are using through to the project infrastructure that they’re using, which in Haskell’s case is public project infrastructure and hackage.haskell.org, which is the main package database. It’s kind of the central point of that. 

So, npm is a huge juicy target because of the amount that JavaScript is used. It’s the biggest programming language in the world. It’s no surprise that people are – attackers, malevolent forces are trying to go after npm. Does that mean that we should be complacent? No, we mustn’t be complacent. And in fact, increasingly, regulation and legislation is requiring open-source projects to develop credible security response apparatus in order for their languages and their ecosystems to be acceptable for companies to use. And if you can bear with me one minute, let me just pull up some quotes which I had delivered in a talk last year. 

Several jurisdictions are now legislating or regulating for companies, for example, that want to sell anything to governments, that they need to audit their whole supply chain and make sure that all the elements in the supply chain have appropriate security response apparatus. The European Union, in particular, is ahead of the game, but they’re not the only ones. We’re seeing similar requirements emerging in the United States and other developed nations.

So, from a talk that I gave last year – and I’m just reading off the slides because I can’t hold all of this stuff in my head, but of course, there’s ISO 27001 de-risking. NIST in the US have their requirements around what they call the SSDF, which is Secure Software Development Framework, and also executive orders around procurement where that involves open source software.

But one of the most significant developments is the European Union Cyber Resilience Act. And quoting from that act and Article 24, with some slight parts of this elided, but this was the quote that I had on the slide, it says, “Open source software stewards shall put in place a cybersecurity policy to foster effective handling of vulnerabilities and also foster the voluntary reporting of vulnerabilities and promote the sharing of information concerning discovered vulnerabilities.” So this is a regulatory requirement that the European Union is imposing for open source software stewards. What does that mean? It means entities that have stewardship or governance of some open source project or community. In Haskell’s case, that’s the Haskell Foundation. 

So, where the Security Response Team actually comes from is that David Christiansen, who was executive director at the time, was becoming aware of this evolving regulatory landscape and recognized that for Haskell to continue to be a valid choice, a valid option within industry, that we would need, at the very least, a vulnerability database to do this stuff that I’ve just repeated off the act. So, that led to a Haskell Foundation tech proposal to create this vulnerability database and have some sort of a team to manage that database.

I became aware of this proposal, and I waltzed into the discussion thread with some opinions about it. And those are stemming from my experience at Red Hat, where although I’m not on the product security team, I work on security products, and we have exposure to how a large open source organization does security response and vulnerability handling. And so I weighed in with a few suggestions about how the proposal needs to be changed or enhanced in some ways, and David circled back and said, “Well, it looks like you know what you’re talking about. Would you like to take ownership of this and do the building the team, building the security team and leading them so that we can do this stuff?” And I said, “Yeah. Okay, let’s go.”

So that would have been in mid or late 2022. And then in the first part of 2023 is when we put out the initial call for volunteers, and I guess I spent some time thinking about and discussing also with David what the charter of the team should be, what the scope of our work should be. And then the team was formed in mid-2023. So we’re coming up now about two and a half years through since we started the work of the Security Response Team.

*MPG (0:35:19)*: And we had this cross-site scripting thing for Hackage, right?

*FT (0:35:25)*: Yeah. So tell me what you know about it, because it was under embargo for a while. And actually, just today I have put up the pull request that has all of the information about this issue. This was a significant, critical, catastrophic issue in Hackage.

And so this comes back to the whole npm discussion, and people are always trying to go after npm packages and compromise web security or JavaScript ecosystem security through package takeovers on npm or whatever angle they can try and do it, they’re trying that angle. Well, we should be very thankful that, at the moment, the Haskell ecosystem is apparently a small target. Does that mean that there aren’t people looking at ways to exploit us? I mean, there are companies doing very interesting things using Haskell. So, although we’re not attracting the kind of broad interest to attack us that a larger ecosystem would have, it doesn’t mean that people would not be interested to try and find a way to compromise Haskell ecosystem security.

But to cut a long story short, this was a critical cross-site scripting vulnerability that the Haskell security ID for it was HSEC-2024-0004. I was first alerted to it in June 2024, and immediately, it was clear that this was a major, major issue. However, it took a long time to completely mitigate the issue or the collection of issues that were related because of this issue.

It arose because HTML files and JavaScript files in Haskell source packages that you upload, as when you upload the package to Hackage, it goes as a source tarball. And you can ship extra content there, and you can also upload documentation packages or documentation bundles as well to provide or replace the documentation that would come by default from the Hackage doc builder. And we were serving up the JavaScript or the HTML from those bundles on the main Hackage domain as JavaScript that could be executed or as HTML that would be rendered as a web page by a browser without any sanitization or any other controls that would prevent scripts on those pages from using whatever latent credentials were lying around.

So you could imagine Ed Kmett with an authenticated session on Hackage, and he ends up browsing to some package that’s malicious. And so then, suddenly, all of Ed Kmett’s packages get compromised. You could put in whichever interesting, widely used package you could imagine. So this was a catastrophic vulnerability that, if someone had wanted to exploit it, they would have owned the whole Haskell ecosystem, or they would have owned specific packages that they wanted to target.

*MPG (0:38:36)*: No, I mean, it’s good to know that the Security Response Team is working, right?

*FT (0:38:42)*: Well, I mean, the problem is basically it took 18 months to completely resolve these issues. Now, okay, there were some initial mitigations in place much earlier than that. So, I do want to assure people that we weren’t sitting around for 18 months and then finally pulled our finger out and fixed it. But for an issue like that, it’s far too long.

However, it’s a situation where we don’t currently have anyone getting paid to do Haskell security work, and so this is no criticism of anyone involved whatsoever. We all have busy lives. We all have to do the things that put food on our tables and roofs over our heads. So if there’s some critical vulnerability that hasn’t been addressed and the worst were to happen, some attacker was to discover that. And by the way, it would not have been hard for them to discover this vulnerability if someone minded to do so turned their attention to it. Who’s to blame in that situation?

I was not happy about how long this took, but I can’t blame anyone for it. It’s a result of the fact that, as a smaller ecosystem that hasn’t in the past historically prioritized security and cybersecurity as a critical concern for our ecosystem, the infrastructure is not there to solve these issues quickly.

What we do need, I feel, is funding for security work in the Haskell ecosystem. And this is something that the Security Response Team, and in particular one of our members, Montez, is currently working on a prospectus, if you like, to bring to the Haskell Foundation and the Haskell community more broadly to put forward a whole smorgasbord of ideas about how to fund security work or a security role for the Haskell ecosystem so that when these issues arise, there’s somebody whose job description it is who can drop tools and work on solving those problems and has authority as well to do so.

*MPG (0:40:58)*: Yeah. I feel like we’re often stumped by community-based issues and not theoretical or technical issues. It’s more like, oh.

*FT (0:41:08)*: Well, we’ll see. I really do hope that we can find a way to fund security work. And I don’t want to preempt too much what Montez will produce in this prospectus, but there are a range of different options. So I think for now it’s enough to say that – and by the way, these are not mutually exclusive options, but things that we can look at are grants. So there are various government grant programs in this place or that place. 

The US has one with the National Science Foundation, although there were some controversy around that recently. And this is not to get political, but it’s a fact about what happened. 

The Python Software Foundation, they’d made an application. They received or they were approved for the grant, but they ended up having to turn it down because they determined that certain requirements around diversity, equity, and inclusion, or rather that orgs who would receive the money were not permitted to do any of that stuff. And the Python Software Foundation found that was fundamentally incompatible with their constitution, so they had to turn the grant money down. 

But there’s an organization putting money on the table. The Germany or EU – I can’t remember. I think it might be specifically Germany. But the Sovereign Tech Fund is another big one putting money on the table for open source projects and organizations to do security work or to do other kinds of critical infrastructural work to ensure the sustainability of critical open source projects and infrastructure. 

And there are some other options beside, and some of them are quite broadly scoped, and some of them are quite narrowly scoped. So there are some other options that say, “Well, we just provide funding or provide free security audits or whatever for particular open-source projects, and apply here.” So we can look at that. That’s one side of things.

Another side of things is, how do we fund the work from the Haskell ecosystem? So, commercial users of Haskell or larger organizations that use Haskell, like universities who might have some capacity to fund the work in part. Do we want to find a way to fund the work through the Haskell Foundation as one possible conduit? Do we want to establish something more direct to fund the security work and perhaps offer additional benefits to companies and organizations who would fund that work? For example, providing access to consulting hours with the Security Response Team for us to assist organizations in a more direct way. And in return, they’re going to help fund the work. 

So Montez and I have met about this. We’ve had some good discussions, throwing ideas around, and he’s currently working on putting this prospectus together.

*MS (0:44:14)*: If I may, I’d like to get back to a point that you made in the beginning. You said that you do websites with Hakyll.

*FT (0:44:21)*: Mm-hmm.

*MS (0:44:21)*: Well, that’s cool. So, can you explain a little bit what makes Hakyll nice to do this in an ocean of static site generators? 

*FT (0:44:30)*: I think it’s nice because it is Haskell, and I know Haskell, and I can understand the implementation. And therefore, I can find a way to do almost anything I can conceive when it comes to building a static site. But I haven’t used all the others. I grab Hakyll because it’s the Haskell one. Yeah, I’m sure there are great static site generators out there that aren’t Hakyll.

*MS (0:44:57)*: I’m not so sure, but –

*FT (0:44:59)*: Well, as you say, there are myriad. They can’t all be terrible. And Hakyll has its rough edges too, there’s no doubt. It’s the one I use because I like Haskell. And I don’t think that’s probably a very satisfying answer. This is certainly not a profound answer, but that’s why I use it. I like it. I have on my personal blog a whole tag category of just Haskell deep cuts, like how to do some really esoteric or very useful but very specific things in Hakyll. So if people want to use Hakyll or they’re struggling with some stuff, maybe they’ll find some answers there. 

*MPG (0:45:43)*: Yeah. So, before you leave, I want to ask – well, we talked about how we should change the community aspect, right, to get funding for security and stuff like that. But with Haskell itself, what would you change about Haskell?

*FT (0:46:02)*: Yeah. This is not anything related to security or anything we discussed so far, but I would like – well, I don’t know if this is something that we could change about Haskell, but what I dream of is a language just like Haskell, but instead of the record selector syntax, you just get optics by default. Lenses and prisms for everything.

I love lens. I know that this is something that there’s a very broad spectrum of opinions in the Haskell community around, whether lens is good at all, particularly in the context of larger organizations, large projects that many people work on where you might have a breadth of experience or comfort levels with more complex type wizardry and more abstraction, more significant amounts of abstraction in the types. But when you have understood the power of lens, I feel like for me, I can’t turn my back on that power.

However, I have my own rules for how I use lens. I never ever, ever use the infix operators. I can’t make sense of them. I don’t know how anyone could ever learn in their head, memorize all of those operators. So I just use the text. I find that, for me personally, that’s a good practice. It improves the readability. But yeah, a language where you define your record types and you get the optics for free, that would make my day.

*MPG (0:47:33)*: Yeah. I would also enjoy that for sure.

*FT (0:47:36)*: But I think for everyone who enjoys it, there’ll probably be another who thinks that it’s definitely a terrible idea. So yeah, I don’t know.

*MPG (0:47:44)*: We’ll have the great schism.

*FT (0:47:46)*: Someone needs to make the language or make a GHC plugin, and we can A/B test it and find out what happens. 

*MPG (0:47:53)*: All right. Well, thanks for coming on. I think we learned a lot more about security than – well, we thought about security a lot more than many Haskell people do. And again, thanks for coming on, and thanks for the excellent work with the Security Response Team. I think it’s very important.

*FT (0:48:11)*: Thank you very much. It’s been a pleasure.

*Narrator (0:48:15)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.
