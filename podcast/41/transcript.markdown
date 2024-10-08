*Joachim Breitner (0:00:15)*: Today on the Haskell Interlude, Matt and I are joined by Moritz Angermann. We talk about the challenges of cross-compiling Haskell and the headaches that Template Haskell causes there, the need for a GHC stability regime, and why you should be careful if your sister calls and tells you to install a certain cabal package. 

Good evening, Moritz. Good to have you on the show. How did you get into Haskel originally? What made you be here in the long run?

*Moritz Angermann (0:00:45)*: Well, thank you for having me. How did I start with Haskell? So, Joachim might know this. There used to be—well, there still is—a mobile application in Germany called Outbank. They’re doing multi-banking, where you can basically have your bank accounts across multiple banks aggregated in one application that downloads your statements from the banks and then gives you a unified view. So, after university, a colleague of mine—well, a friend basically—started working for that company, and then they needed some help doing mobile application development. So, I joined that company as well, and eventually I was like, “I’d really like to do most of this in Haskell,” because we’re doing financial stuff and I basically want to have more assurance around what we actually do. So, I was like, “Okay, let’s learn Haskell, and let’s try to figure this out.”

*JB (0:01:34)*: Wait, you said you went there saying, “I want to do this in Haskell.” And then the next step was, “Okay, what is this Haskell in the first place?”

*MA (0:01:43)*: Yes. That was the thing. So, there was another friend from university who unlike – so, I studied mathematics, and the other friend studied computer science, and he just talked about Haskell occasionally, like more assurances and whatnot. So, I had a lot rough idea of what Haskell was, but that’s about it. And we did lots of Objective-C and then later Swift stuff. At that company, we was like, “Well, I think we can take this a notch further.” And then I tried to figure out, “Okay, how can we do Haskell?” And that’s when I started figuring out that we actually can’t. There’s absolutely no way Haskell can do any of that. We may be able to build a library for x86, and that’s basically it. 

*JB (0:02:26)*: So, this is thinking about client-side software, not server-side software.

*MA (0:02:30)*: Yes. So, the whole – so, Outbank, even today, I believe, is mostly client side. So, one thing that drew me to the company was that they focused on privacy first, which meant nothing ever left your device. Everything was on device. 

*JB (0:02:42)*: Very German.

*MA (0:02:43)*: We even had some cloud sync developed, which basically, the encrypted synchronization between your own devices, but there was no server involved, which also meant we never had any user data, which for any form of valuation is always a bit hard because people like to have user data. But we didn’t have any for good reasons. So, yeah, it was always client side. I was like, “Okay,” trying to figure that out. And I figured, “Well, that’s not going anywhere.” But that meant I was still looking at the Haskell and trying to figure out how to actually make it work at some point. So, that was when I basically started to work on Haskell, trying to make a cross-compiler without actually having any Haskell code. A cross-compile, just like, okay, if I want to use this, I need to make it usable for mobile. And that’s how this started. 

*JB (0:03:26)*: What year are we roughly talking about, just to put it in historical perspective, or of its GHC version, if that’s more easy to remember?

*MA (0:03:34)*: I don’t even remember the GHC version. So, Austin was still running GHC, basically. We still had Fabricator. Reid Barton was there. So, 10 years ago. A bit more than 10 years ago. 

*JB (0:03:50)*: Okay.

*MA (0:03:51)*: Well, I guess we could look up when my first commits were to GHC because that was about right around that time. So, I started Haskell working on GHC. It might not be the most common thing, but –

*JB (0:03:59)*: No, probably not. 

*MA (0:04:00)*: Well, that’s what I wanted to do. So then, I figured out, okay, even if I can compile parts of – well, I mean, you could build a cross compiler and then build parts, but soon you hit like any form that uses Template Haskell or anything, and you’re like, “Okay, this is not going anywhere.” I was like, “Hmm, but there’s a compiler that can do Template Haskell. How does that one do it?” So, I talked to Luite quite a lot and tried to figure out how do we actually get this done in GHCJS. And then Luite told me how that worked. I was like, “Okay, how do we graph this onto GHC?” And to be fair, I had no idea what I was really doing. I was just trying my best to get anywhere. And it didn’t really go anywhere at that time. And was like, “Okay, maybe we can at least change this LLVM backend we have into a slightly better one because at that time we still had this issue that LLVM, which each version changed its textual format. So, GHC was basically tied to one LLVM version. And that really needed to be the same, because the next one might just break the format. And LLVM has a binary-compatible format. So, the bitcode backend, which around that time also got pretty popular for Apple because they had this idea that developers maybe just publish bitcode-based applications. They could just recompile them on their servers for either optimizations or different targets. That seems not to have pan out. I hadn’t heard about bitcode for Apple a long time ago. They certainly had this idea. So, I was like, “Okay, maybe I can write a bitcode backend.” And then I worked on that. That code is still on my GitHub and even gave a lightning talk in – I think it was Nara during ICFP. 

*JB (0:05:42)*: I think I remember that.

*MA (0:05:42)*: So, I could get it to work but not perform it enough to compile fast enough. So, probably with some space leaks, and I never really followed up on it. So, time continued. I was still working on like, okay, LLVM doesn’t change so much, and we can still use the regular LLVM textual backend we have and use that. And then I just will try making stuff work occasionally. At that point, the company I worked for, Outbank, basically imploded. I lost my job, and we moved to Singapore during that time anyway. I was like, “Okay.”

*JB (0:06:17)*: We being not the company that imploded, but rather –

*MA (0:06:20)*: My wife and I. So, it was like, okay, I don’t have a job, and I really want to get this cross-compilation thing going. So, I started writing a blog post and basically published every few days things on building, cross-compiling Haskell, and whatnot. Then a new company came and said, “Hey, if you can cross-compile to mobile, maybe you can cross-compile to Windows, because Windows in CI sucks so much. We really, really don’t want to compile to Windows.” I was like, “Sure, why not? Let’s try. I’ve never tried it, but we can do.” That’s when I basically started at, back then, IOHK and started building Windows cross-compiler for Haskell so we could basically compile the flagship product of the company to Windows without actually using Windows. 

Since then, I’ve been at the same company, doing mostly cross-compilation and primarily develop experience topics for GHC. And large parts of that is also building for ARM and for static binaries, because ultimately just building a static binary is so much easier to distribute. So, you can treat Windows and other platforms just as basically deployment targets and then ignore it. That’s basically how that went.

*JB (0:07:30)*: I looked it up. Your first commit to GHG was on October 21st, 2014. So, it’s nine years old, and it has the title “Fixes the ARM build,” which is a pretty impressive first commit for somebody who just learned Haskell, and then they go into GHC and – well, they’ve fixed the ARM build and –

*MA (0:07:48)*: Well, GHC is mostly C to large parts, at least the part that I usually double, and it’s like lots of the RTS and backend. 

*JB (0:07:55)*: Yeah. But still – the third commit that I see is “Update Readme.md,” which is like the usual first commit or somebody makes where they come in and they dare to change a little bit of the documentation. But you went in all the way. That’s very impressive.

*Matthías Páll Gissurarson (0:08:10)*: So, you were targeting ARM. Before, the Macs were all ARM, so –

*MA (0:08:17)*: Yes. Way before. iPhones were ARM, right? And then all the Android devices are basically also ARM. I mean, there was MIPS, and then there’s a few AArch64 ones, but it’s mostly ARM. And Google’s now apparently also starting to move towards RISC-V and – well, we can get to RISC-V later. That’s how that basically happened. And I just remember the first few reviews in Fabricator were pretty rough. Also did a pretty good job in making sure not too much bad code got in.

*JB (0:08:47)*: Okay. Was it only rough in terms of tactical content or also in terms of welcoming a new contributor?

*MA (0:08:55)*: I don’t remember that. I think it was like, well, I think we need a test and something else, and yeah. So, I just remember, well, quite a bit of rigor around getting stuff into GHC, which probably wasn’t bad, but I got that done. And during that time, I basically learned to love Fabricator, and I still like it today because it has this view where you basically look at your change set and you just ignore the commits in between. It’s still a way I work today, even though GitHub tries to work against me.

*JB (0:09:25)*: What do you mean ignore the commits?

*MA (0:09:27)*: Well, commits is just how you structure your code, right? But the commits itself are irrelevant.

*JB (0:09:34)*: Right. But isn’t that the default view on GitHub where you have just the changes of all the changes of your pull request? 

*MA (0:09:38)*: Yes. But Fabricator very nicely gives you like, show me the diffs to the previous state. So, you viewed the base against your last changes. 

*JB (0:09:48)*: Oh, you mean like when GitHub users would force push and then it’s confusing and everybody has a bad time?

*MA (0:09:53)*: And otherwise, you also would need to view the last commit instead of like, show me the diff against the last view I reviewed. That helps a lot because then you don’t start reviewing. So, like, what the hell happened? It’s also how I treat most of my produce. Basically just squash merge all the time. 

*JB (0:10:12)*: Same here.

*MA (0:10:12)*: I think commits are ways to structure how you do your work, but ultimately, it’s just one change that hopefully is properly described. And I also don’t like changes that are way too large. And so, I’d rather have every change be in itself meaningful and not like these long-lived branches, like lots of commits, and then just try to merge them somehow into the main brand.

*JB (0:10:35)*: Yeah. Or the other extreme where you have a long-lived branch and then you spend so much time on rebasing the commits into a synthetic – this is how it could have come to be if I knew everything ahead of time, which you then very proudly emerged into master using rebase because you’re so proud of your separately divided commits and nobody ever cares about it anymore, because you hardly ever look at the history and just by squash merging it to save – just avoid the distraction.

*MA (0:11:01)*: Well, the thing is, I find rebase often not really work the way I want it to work. So, what I end up doing is basically just generating patches and then applying those

*JB (0:11:10)*: Kind of old school. That’s very old-school.

*MPG (0:11:12)*: Nice. 

*MA (0:11:13)*: But yeah, I remember having long rebase basically change sets on top of change sets in GitLab. And then when Haskell’s built, it just takes two days until your PR maybe compiles once. And everything is in between getting invalidated. And then you rebase, and you have to rebase the ones on top. It takes days again, and you’ll basically, “Okay, I spent a week just trying to get these few changes into GHC. That just can’t work,” which is also when I start basically saying, “Okay, I can’t take this. I’m just going to buy a few machines and just run CI for GHC because that’s just not sustainable.” I mean, at that point, I had a few people working at IOG that also worked on GHC and was like, “I just can’t make this work in any form with GHC. It’s so slow.” So, I was like, “Okay, it’s not that much of my personal money. I just spend it on CI-built machines and at least get us moving forward.” And then later it was like, “Okay, maybe we can have some form of way to finance that.” That never really worked out. I mean, I’m very grateful to the Cardano Foundation to support the stake pool I’m running with quite a large chunk, but there are not that many people that actually support that stake pool to make it really viable without the Cardano Foundation.

*JB (0:12:26)*: But that sounds like GHC development is quite a pain. Has this improved since you had to experience that pain, or is it still the same?

*MA (0:12:35)*: I don’t know. I guess Sylvain would be a better person to ask because I ended up doing a lot more on the haskell.nix side and on management side, and Sylvain is doing most of our GHC development these days. 

*JB (0:12:48)*: Okay.

*MA (0:12:49)*: I hope it has improved, but yeah, I can’t say if it definitely has. I think we got build times down quite substantially.

*JB (0:12:58)*: And indeed, your last commit is, from two years ago, “Do not sign extend CmmInt’s unless negative - might fix,” and then a number. 

*MA (0:13:07)*: No, there should be one from – 

*JB (0:13:08)*: Maybe that my checkout is old. Oh, that could be.

*MA (0:13:10)*: There should be one from like a week or two ago removing some old Xcode nonsense.

*JB (0:13:15)*: Okay. Yeah. I wouldn’t have that. So, coming back to bringing Haskell onto the client side/mobile side when it wasn’t there, cross-compilation is, of course, one part of it, but all naively, I would expect that you don’t want to run the command line tool on your phone. 

*MA (0:13:31)*: No.

*JB (0:13:32)*: So, how do you approach that? How do you make a GUI app that looks usable for users across different mobile phones? 

*MA (0:13:42)*: Well, it’s the same with what – so, if you look at quite a few of the iOS and other applications today, they often have some form of either C++ or some other language cores, and then a platform native Chrome on top, which is like you write your platform native UI in Swift or Kotlin or what have you. And then for significant business logic, you delegated some C++ library. C+ is very popular because, well, the whole toolchain work of C+ is fairly reliable in at least the build side of things, and it also just exposes some form of C API you can then integrate.

*JB (0:14:14)*: But did you look into ways of doing a fully Haskell client, or was it just out of the question?

*MA (0:14:21)*: I never really thought about using Haskell much for UI. I mean, we do have reactive frameworks on Reflex, comes to mind others, but to me, that’s always like a problem is solved after we have solved the fundamental one of getting Haskell well onto that platform. If you can have the Haskell core and then just the UI Chrome, which is often also the part that’s much easier to write in the platform native language. And I don’t want to spend too much time on like, “Oh, maybe we can make this work.” Then we should spend hours and days and whatnot to make it work, which is, maybe can use the platform native and use Haskell for the important part where we say, “Okay, we can use the properties of Haskell we want. We can use more formal methods like approach to defining how our business logic should work and have these assurances in our software.” At least in the business logic side of things of our core library, then yeah, that’s what we should do and focus on UI using the platform native toolkit.

*JB (0:15:18)*: Yeah. Totally makes sense. 

*MA (0:15:19)*: And even if we look at desktop apps today, you see them having basically a browser in some form of backend that they delegate you. It’s a very popular approach, which I find a bit resource-intensive, but ultimately, businesses pay for solutions not for technical marvels.

*JB (0:15:36)*: That’s unfortunate in a way.

*MA (0:15:37)*: It is. But that’s just the reality. I mean –

*JB (0:15:40)*: Yeah, no, no, it makes sense. 

*MA (0:15:41)*: Ultimately, we want to solve problems and not spend too much money on making these problems. I don’t know ideologically correct or however you’d like to frame that. 

*JB (0:15:50)*: But then even more interesting that you got to do this whole “let’s fix Haskell cross-compilation and use it in our clients’ stuff” because at least from, I guess, our point of view, certainly the technical marvel.

*MA (0:16:01)*: Right. But that only works because we needed to do Windows, and Windows in CI was just so goddamn annoying. If you just can build on Linux, it’s so much easier. 

*JB (0:16:09)*: But that doesn’t justify Haskell yet, does it? I mean, you could cross-compile C to Windows.

*MA (0:16:13)*: Right. Right.

*JB (0:16:14)*: So there’s still something. We had to convince somebody that Haskell is really more than just technical marvel that nerdy people with math friends – or no, you were the math person with computer science friends – want to do. 

*MA (0:16:25)*: Well, luckily, that was not my job. That was already set in stone before I started embarking on this. So, people had decided they wanted to use Haskell and then they were like, “Okay, but we don’t really want to use Windows and we don’t want to manage Windows in CI and whatnot, so can we do something about that?” And that’s how that basically happened. And from there, I was just like, “Okay, if we have built this infor – so, when we started, I was – okay, one step back. I was hired and was told we’re going to use Nix to do this. I was like, “Nix is what? I never heard Nix. What the hell is this? Okay, this sounds terrible.” This is just, “Oh God, what are they doing? Oh my, no. Why? I’m using Mac? What the hell is this? No, no, no, I’m not using – no.” So, okay. And that was Nix. And I was like, “Okay, let’s learn this.” 

And I don’t really like writing code because code is basically – well, if you write code, it becomes a liability. So, I don’t really like writing code and prefer to delete code. So, I looked at the Nix packages in first and was like, the way they do Haskell is fundamentally incompatible with cross-compilation ever because they basically take your cabal file and flatten it out on the machine. They run cabal to Nix, which means you lose all your conditions that are basically important to get Windows to build. Especially for Windows, there’s often conditions in your cabal files that make the dependency trees completely different. It’s not like where you just like have Linux or Mac and they’re mostly the same because everyone pretends Mac is Linux, well, which is not true, but certainly assumed. But for Windows, it’s so different that you can’t use the Unix package on Windows. You basically have the Win32 package and whatnot. So, you really need to be careful about not flattening out the cabal file. But the whole cabal to Nix infrastructure in the Nix package system flattens these out. So, it’s like, “Okay, I just can’t make this work in any form that even looks remotely sensible. But if we can make this work, if I can just have the cabal files translated in a way that it then can feed to the Nix package, that could work.” And that’s how it initially started out. 

So, we basically just flattened them out and then created a construct we could feed into the Nix packages as a component. And then later, we’re like, “Okay, the guy who worked a lot on the Web GHC project who venture came along and was like, “It would be cool if we –” I think at least it was him. “It would be cool if we could do component-level builds because the Nix package infrastructure also builds at the package, level and well, we have components, and well, cabal could technically build at a component level.” So, that also got into haskell.nix component-level builds. And that point, the project started to diverge so much from the way the Nix packages build work. They were like, “Okay, this is basically orthogonal to Nix packages.” 

We use Nix packages for system libraries and everything else, but for the Haskell side, we basically use haskell.nix. And that meant we basically try to support a bunch of Nix package revisions and then have these orthogonal to haskell.nix. Technically, all Nix packages revisions should work, but because you want to have some form of caching, we pinned a few in Haskell docs for convenience. And you don’t need to use those. However, if you want to have better caching, you probably want to use them. And the infrastructure we build for Windows, well, that basically works for Linux as well so you can cross-compile to other Linux architectures. 

Then Apple came and said, “Hey, we’re going to give you ARM MACs eventually. I was like, “Okay, if we’re going to get ARM MACs and we have our really, really bad LLVM backend, that’s not going to work. It’s going to be super slow, and people are just going to complain, and whatnot and we really need to improve this. Maybe I can write it backend for a compiler. I mean, I tried this with the bitcode LLVM backends. I had a bit of experience how to write a backend anyway. And this ARM assembly doesn’t look too bad. So, let’s try this.” And before that, I already wrote the linker and loader. So, let’s take a step back. 

GHC has an internal linker. I’m not sure if you’re familiar with that. GHC basically has a static linker where it can load object files and archives into memory, link them together, and then execute that code, which makes it independent of the system linker in case that doesn’t work. And on some platforms, there, for example, isn’t even one or it’s broken. So, GHC has this facility, it has a bunch of bugs occasionally, which makes for really fun debugging stories. 

*JB (0:20:41)*: I can imagine.

*MA (0:20:42)*: Having this at least helps you load these. And the way that GHCJS works is by running a client on your target, which for GHCJS is basically Node.js. And we can do the same for iOS or Android by basically running a tiny Haskell application on your mobile phone or on your Android device or whatnot, which then loads object files and executes them for Template Haskell. Maybe we should explain Template Haskell. I don’t know. Should we?

*JB (0:21:13)*: Maybe briefly?

*MPG (0:21:14)*: Yeah.

*MA (0:21:14)*: Okay. So, Template Haskell, a feature which we shouldn’t really be having, allows us to run arbitrary IO and process stuff during compilation. And that means Template Haskell also has this feature and is able to load arbitrary code during compilation time and execute those functions, which it even uses. So, if you evaluate your splice, basically take the Haskell function, load it into memory, evaluate and run it and take the result to splice it back in. This splice could also load some other C functions and do basically anything IO. It’s unrestricted. It can’t even call out to Git, which people do, and use this git and embed thing, which has lots of other implications, but that’s what template Haskell can do. And for that to properly evaluate one option, which was populated –

*JB (0:22:05)*: Sorry, that was me. I pressed a button I didn’t want to press. I did not want to interrupt you.

*MA (0:22:14)*: There have been two options for this. So, one is what GHCJS does, which is it basically runs Template Haskell in an evaluation context for the target, or the other, which is what evil splicer and ZeroTH basically tried, which is you’re running Template Haskell on your build machine, save all the splices, and then hope that these splices are the same ones you’d splice into your target. Well-Typed at some point improved on the ZeroTH and they have a thing that I think automatically dumps your splice and allows them to basically load back in. So, that also works for some cases. 

But to me, the problem is that the way Template Haskell works is it really assumes that it runs on the target, even though that’s hard to say because there are no semantics around it at all where it runs. But people assume that it runs on the same platform where they’re going to run it when people try to see how big are pointers and whatnot and try to poke these during compilation time to compute word sizes. And that can only work if you evaluate on the target. Otherwise, you get the wrong ones if your target and your build machine don’t line up. 

*JB (0:23:27)*: But most of the use of Template Haskell would be fine on that host, would it? At least the ones like we’ve encountered? 

*MA (0:23:33)*: Yes. Most of it. If we just had a pure Template Haskell, there would be no problem at all. If you just cut out all IO, including unsafePerformIO, then this would be all okay. If we use Java’s STG evaluator it has, that would also be fine. But as it is right now, if you want to basically evaluate Template Haskell kind of true to what it seems to be, you still have to evaluate on the target if you can. And that then brings all kinds of other issues, like how do you actually – if your Template Haskell evaluator runs on your mobile phone, how do you actually get files from your build machine? How do you actually execute processes? Should the process be executed on the machine or locally? If you’re loading libraries, most of the time if you’re loading libraries, they really want to run them on the target, and some libraries might just not exist for your build machine. So, that might be like some private library that only exists on your phone or whatnot, and you really are – it’s only available in AArch64. Then you really need to have that failure. But that’s all fringe case. 

In Template Haskell, the problem though is that you don’t know ahead of time which ones are, right? So, if you want to have a solution that’s as general as possible, you have to try to go down that route. And that’s how we basically have linkers and loaders for most of our architectures in GHC. So, GHC can basically load Mach-O files and ELF files and relocate object files properly in memory so that you can then call functions. And I did work on that for Obsidian Systems years ago, when they basically asked if we could improve the linker. 

And then later – well, that was for AArch64 and a bit for ARMv7. And then later, I was like, “Okay, let’s build a code generator for that.” So then, we start building a native code generator over probably six months or so for Mach-O and ELF so that we have Linux and macOS AArch64 targets native code. And then I got one of these Apple development kits to try it out, and that was fun to try out. Initially, it was a bit annoying to bootstrap that all, but that’s also where I learned to love Nix because, finally, you had like at least some principal development environment where not everything changed all the time. 

So, if you read some of my earlier blogs where it’s like, okay, this is how you construct a build route for your Raspberry Pi or whatnot by copying stuff from the Raspberry Pi around and rearranging your built environment, that’s all made so much easier if you use Nix. And that’s how that native code generator happened. So, I think I’ve spent most of my time working on GHC, not really with GHC.

*MPG (0:26:04)*: So I’m wondering about the impact of Template Haskell. Say I write a Haskell implementation, call it Nano Haskell, not the Micro Haskell, how far can you get without Template Haskell? Do you just crash right away? How much of the ecosystem are you foregoing or abandoning if you just say, “I don’t support Template Haskell”? 

*MA (0:26:29)*: How much are you foregoing? I don’t have hard numbers. I mean, GHC does not use Template Haskell because it itself has a staging problem. The problem with me is more that any realistic program you’re trying to build will somehow end up using Template Haskell somewhere. And that’s quite annoying. And I’m like, maybe we could tell people not to use Template Haskell, but is that going anywhere? We’re going to tell people, “No, you can’t use Template Haskell.” Then people are like, “Okay.” So, they’re going to try to build their software, and somewhere in their dependency tree, they’re going to encounter capitalizing, and then nothing works. And they’re like, “Okay, now I’m either going to try to figure out how to fix my dependencies or I’m just going to move on.” 

So, from a purely practical perspective, I don’t think you can build any of the larger Haskell project without hitting Template Haskell anywhere in your dependency tree. Even though I’d like to, but yeah, from a practicality perspective, I think it’s pretty much important that you have some form of Template Haskell support. 

*JB (0:27:21)*: Would it be more plausible to have a host Template Haskell extension that is like Template Haskell, but just runs it all in the host rather than target? Would that make things easier?

*MA (0:27:30)*: Are you going to rope me into plugins now? Because they’re absolutely not supported in cross-compilation, and that’s the next frontier.

*JB (0:27:37)*: So, you’re saying running code on the built host is no easier than running code on the target, and you’re basically in a pain in both cases?

*MA (0:27:44)*: It could be. So, I mean, we have plugins, and they are basically – I think Oleg has some synthetic language extension even based on plugins or something. So, you can do a lot of plugins. The problem is if you have a cross-compiler and you try to use plugins, then the cross-compiler will try to use iServe to run the plugins. And that’s not going to work because plugins access internal state of the compiler, and iServe does not share this internal state. So, that’s not working.  

*JB (0:28:11)*: So, at the moment, plugins are even worse for cross-compilation than Template Haskell.

*MA (0:28:15)*: Yes. We have made a lot more progress on Template Haskell than our plugin, though we’re working on plugins as well. There’s something called external static plugins, which hopefully can make plugins work, but not all of them yet, and getting them to work as non-trivial. I think there are not many people that actually use them or try to use them.

*JB (0:28:37)*: Yeah, that’s my impression as well. Plugins are nice for playing around with things, but they don’t make their way into common production libraries.

*MA (0:28:45)*: Oh, you haven’t seen Pluto, have you?

*JB (0:28:47)*: No, I haven’t. Is it full of plugins?

*MA (0:28:50)*: So, the smart contract language for Pluto – for Cardano, it’s called Pluto. And Pluto is basically a GHC plugin that transforms core to turn Haskell core into Pluto’s core.

*JB (0:29:00)*: Okay.

*MA (0:29:01)*: You can cross-compile basically everything unless you start using any of like – unless you’re trying to compile smart contracts during the cross-compilation part.

*MPG (0:29:10)*: And like you said, it feels like plugins are – it’s Template Haskel on steroids, where you are running arbitrary code that can do arbitrary IO as much as you want, but you also want to know all the internal state of GHC at the same time, right?

*MA (0:29:25)*: Right. I would say I actually like plugins more because, as the person running the code, I have more control over plugins. Template Haskell is much more opaque to me. I don’t know which of my dependencies use Template Haskell automatically, and it can just build something and then run it. The Template Haskell could just nuke my whole hard drive if it wanted to. It could ex-fill all kinds of data. It could just use my password file and send it somewhere. No one would know. Maybe we should cut this out, but if someone were to take over a popular Haskell package on Hackage and push a slightly malicious piece of code into the Haskell package, for example, let’s say ASIN, to exfiltrate sensitive data, I think you’d have quite a lot of success actually exfiltrating sensitive data. But yeah, I’m not sure we should publicly make this statement and give people idea. 

*JB (0:30:13)*: Well, maybe we should because it’s something I’ve been thinking about as well. The amazing amount of trust we open source, especially open source developers, just spread to random people whose package has been installed. And not just Template Haskell; it could be the cabal setup file. It could be some VS Code extension that automatically updates. You’re giving a vague access to your computer to so many people when you do development that it’s strange we don’t hear much more about these problems where some library becomes broke and steal stuff.

*MA (0:30:50)*: I think we only hear this in the Node community occasionally, but –

*JB (0:30:54)*: Because they’re big enough to – so the bad guys actually think that’s worth going there.

*MA (0:30:59)*: I guess. That’s why you should basically run everything you do in sandbox environments. And even those might be escape, but it’s always some form of additional security layer. 

*JB (0:31:10)*: Yeah. But the list of things you should is always longer than the list of things you do, which –

*MA (0:31:14)*: Yes, of course. Right. My mom called me the other day and asked me, “Hey, I got a WhatsApp message and someone said, ‘You changed your number and this is your new.’” I’m like, “Yeah, no, forget about this.” And then I was like, “Okay, and now we’re going to do another example.” I’m like, “What’s possible today?” And I took a sample of my sister’s voice and ran this through a voice cloner, and then basically sent them a message like, “Be very prepared. This is what happens. Someone could be coming with this voice and ask for money. Never send anyone money. Always ask for a third person to confirm what you just heard. Never trust anyone. Not even if you see a video. Those are easily fakeable as well as this point.” We are in a position where we know about this and most of our families don’t. So, it’s on us to educate them around these things. 

*JB (0:32:03)*: Yeah. But as long as you just cabal-install random packages or in node-install random packages, it’s not like we can if we have the more high ground here. 

*MA (0:32:11)*: Well, yeah. Depending how you do this, yes. 

*JB (0:32:14)*: Maybe I shouldn’t publicly say that. I know that I should have more security.

*MA (0:32:18)*: Right.

*JB (0:32:19)*: I have perfect security. No point attacking packages I use. It’s totally locked down. I’m using cubes in cubes in cubes. It’s totally safe.

*MA (0:32:27)*: That’s why you build everything in Nix, aren’t you? Isolating your build environment, try to make sure it can’t reach anywhere outside?

*JB (0:32:33)*: Yeah, no.

*MPG (0:32:35)*: I have a computer in my basement.

*MA (0:32:38)*: For Haskell development. 

*MPG (0:32:39)*: I go down there, I cabal – yeah. I cabal-install a package there and then I copy the files. Yeah.

*JB (0:32:46)*: And always wear protective gear with like a hat and antiseptic hat gloves before I touch new Haskell code.

*MPG (0:32:53)*: Exactly. 

*MA (0:32:53)*: See, I have my alcohol pads here.

*JB (0:32:57)*: Oh, that’s very good. You can disinfect everything you touch. 

*MA (0:33:02)*: No, wait. But you mentioned Setup.hs, and Setup.hs is one that, especially if you’re trying to cross-compile with cabal, is really annoying because cabal has not really any idea how to deal with it properly. It can only compile it for your build host and then run it. For GHCJS, we’re trying to see if we should basically compile it to JavaScript and then evaluate there. That makes a better solution. I don’t know. Haskell.nix basically builds them on your build host, and then it just evaluates them. Haskell.nix has a bit easier time because we don’t really use cabal-install. We use cabal-install to build a plan and then run Setup.hs to actually do any of the building. So, in that, we have a cleaner separation there than cabal. 

But Setup.hs in general is, to me, a bit less annoying than Template Haskell because Setup.hs, I can declaratively know. Template Haskell, I can’t.

*JB (0:33:54)*: That’s true. 

*MA (0:33:55)*: Template Haskell just happens. Setup.hs, I can see, okay, it’s custom or set up or make or configure or whatnot, in the cabal file at least declared if you’re using cabal. If you’re going to use for, I think, Bazel rules or whatnot, then I think that’s also all out of the window. But yes, at least that, we have a description for.

*JB (0:34:15)*: Okay. So, we can summarize that Template Haskell adds a lot of headaches for cross-compilation. 

*MA (0:34:20)*: Yes. 

*JB (0:34:21)*: But it’s a very gentle transition to another big topic. Template Haskell is also causing headaches for another big topic that you strongly care about and has been very vocal recently. And we should definitely make sure we have enough time to get into that. And that is the whole stability discussion. 

*MA (0:34:34)*: Yes. 

*JB (0:34:35)*: Maybe for a little bit of context, at least from my point of view, GHC has been a language that has always valued evolution and experimenting things. And that came at the cost, or at least appear to came at the cost, of, well, you upgrade GHC and your code no longer works. And some people surprisingly don’t like that and have plans to how we could do that better. And more, it’s one of the more very vocal advocates for stability, which is definitely a good thing. And I think you’re actually working on a concrete proposal at the moment.

*MA (0:35:05)*: I try to. I then had a bit of a medical problem that threw me off. And I think Simon basically went and took the button up, I guess, because I didn’t. And yeah, well, my fault. Simon is working on the stability guidelines around doing things. And that’s, I think, a very good step in the right direction.

*JB (0:35:24)*: Can you summarize the plan that is in the discussion here?

*MA (0:35:29)*: So, just on a high level, it’s like, let’s be a bit more mindful about what breakage means, what breakage causes. And if we can have backwards compatibility, let’s try to have backwards compatibility before we basically just break stuff randomly. So, I think it’s mostly just being a lot more mindful around this. And this comes with – I think Simon came with three general rules, how to do this. I would have to look them up right now, but the general consensus is that if you don’t really need to break it, don’t break it. If you need to break it, have at least some form of compatibility or migration path, and only break stuff if you really can’t do otherwise. And I think that goes in the right direction. I mean, it still excludes Template Haskell because, well, you don’t get really any stability guarantees if you use Template Haskell, which brings us back to the previous point where we said, “Do we actually need Template Haskell?” And sadly, I think we do. 

So, the thing with Template Haskell is Template Haskell exposes internals of the compiler. And the question of it to me is if it really should be doing that at all, or if it should basically just give you a high-level combinator library and then tries to abstract the internals from you. And maybe most use cases of Template Haskell would even be working with just high-level combinators and don’t need to have full access to the internal data structures of GHC. And that would make it a bit easier.

*JB (0:36:49)*: I guess a part of that problem is also that GHG, the library that exists is basically just, well, let’s open up all the modules that make up GHC the compiler, and you can use whatever you want, but it’s in no way designed and structured and curated API, and so it changes totally between releases.

*MA (0:37:07)*: Yes. So, we don’t have an API to the compiler. We basically just have the compiler. I mean, the library that’s called GHC is basically the compiler folder in the GHC source directory.

*JB (0:37:19)*: Yes.

*MA (0:37:20)*: So, it is the compiler. For stability, why do I care in the first place? The problem is, if I, as a company, invest in Haskell and I want to build software in Haskell, at some point, I need to upgrade to a new compiler release because the ecosystem just moves on. Or I decide to basically rewrite my whole new ecosystem at home and just don’t play with anyone else. I’m not sure if that’s a workable solution. I think that might be a workable solution for banks. Jane Street does a bit of that on the OCaml side, where they basically just reimplemented all of their standard library in their own one. But I think it’s counterproductive doing this unless you have as they did in OCaml, where they have basically got the whole community buying. But it’s counterproductive. Every company ends up building their own libraries in-house just to insulate them from other people’s dependencies. Then why do we do this in the first place? I mean, sure, if you’re in high insurance context where even using external library might be super annoying because it needs to pass legal and whatnot, internal reviews, and all these kind of things, basically insulate against the things you said you might be running into by just running cover update, then sure. But ultimately, I think we should all work towards collectively working on software, not everyone doing their own stuff. That’s why we try to basically use other people’s software and trust that they know what they’re doing. 

And now, you have a piece of software you wrote, and eventually, you need to upgrade the compiler because either you want a new dependency, and that brings in yet another dependency, which doesn’t build with the old compiler anymore, or whatever happens. And that forces a compiler upgrade. Or you think, well, I want to target a new system. For example, I want to use the native code generator for my Macs because they’re significantly faster than the LLVM backend, and you need a new compiler, which means like 92 Plus. Now you need to upgrade, and you take your existing code base, and you could see, oh, nothing really compiles out of the box anymore. Basically, every package I have somehow doesn’t compile anymore. 

At that point, what do you do? You either say, “Okay, I’m going to invest and basically upgrade all the packages, even though I don’t fully understand why I need to because the com code used to build, so what the hell is going on?” And I think if this happens often enough, you might just say like, “Why are we using Haskell in the first place? Why are we paying this continuous tax on upgrading packages and spending time on that?” Because that’s similar to what I said initially. We want to solve problems with software. We don’t really want to solve software with software because of software.

*JB (0:39:53)*: Right.

*MA (0:39:54)*: So, maybe then the option becomes, “Oh, there’s a language that does not break so often. Maybe we should be using that one.” That is basically where my point is. And I don’t want to employ someone full-term just to make sure our code base keeps compiling with the next GHC. 

*JB (0:40:09)*: So, maybe the question now is, what are the cases where compilation breaks with the next GHC? Which of these could be avoided without any pain to anybody else? Which of these would take effort that’s worthwhile to invest so that breakage doesn’t happen? And which of these are really unavoidable if you just don’t want to freeze the language in time, and what is the trade-off there?

*MA (0:40:32)*: Yeah, I think that that’s a very good question. I think I’m not sure if anyone really has a good answer to that. I know Tom is currently collecting, I think, breakages from 8.6 to 9.6, or was it from 9.6 to 9.8? I don’t remember. But yeah, at least I think Tom is currently keeping count. I’m not saying that all the issues we ran into were only compilation-related – only language-related. But what happens is you upgraded library, and now that library you upgraded needs to be integrated to other libraries because you have this forward-rolling thing where your current stack, at least if you have multiple libraries and not monorepo, depends on existing libraries. And now you obviously can start doing all of your existing libraries at their current snapshot, upgrade them, and upgrade master as well because that’s the current head version. But if you only do master, then you have a new release, then that needs to be integrated in your current versions so you can basically have this ripple down. And that just ends up being a lot of work. 

And it’s small things where language extensions somehow change or imports change, or something else changes. So, I’m just like, if we can reduce any unnecessary breakage, maybe it’s getting easier. So, I’m pushing really hard for unnecessary breakage. And if we’re doing breakage, let’s at least try to make sure that the person who encounters that breakage knows exactly what to do. Nothing is more frustrating if something breaks and you’re like, “Okay, what do I do? Do I need to rewrite it? How do I fix this?” And sometimes, I mean, we do try to write this down in the user guide to have migration notes, like this change from GHC x to GHC y, and this is you – well, sometimes it says that this is how you’re supposed to fix it. But you also have to mention there, there’s someone who might not be that familiar with the code base but is tasked with doing the upgrade for other teams because other teams are working on their features they’re supposed to implement, and there’s someone who’s just trying to also get the compatibility with the new compiler working. 

And one really big issue I have with the compiler not accepting existing language is that, how do we do proper quality control? If I can’t compile the code with two compilers, I can’t really do regression check testing properly.

*JB (0:42:40)*: That’s an interesting point. Yes. 

*MA (0:42:42)*: My code compiled with compiler X, and I have performance metrics for that. I have behavior metrics for that. Now I’m taking a new compiler, nothing compiles anymore, so I have to make changes to my code. But now these changes end up potentially influencing performance and behavior. So then, I may need to make changes that are hopefully compatible with both compilers, but that mostly is not the case. So, you have conditional ifdefs in the com code, and that means you’re basically comparing oranges to apples, kind of. It’s not the same quality control anymore. And yeah, that’s why I think at least from one to the next compiler, at least let’s try to make sure we can still combine the same code. That’s what I’m pushing for. 

*JB (0:43:22)*: What I had found as an interesting takeaway from the whole discussion is the observation that in the cases where you do want to make a break at some point eventually because the old code is – you just want to keep it going. Initially, my thought was, well, how useful is deprecation even? Because people have to make the change anyway, and many people will just ignore the warning until it really breaks. And so, for them, they don’t gain much from deprecation. And also, Simon Marlow reported from his experience at Facebook, I think, that they more or less don’t do that and they just wait for the break to happen. But then I realized it’s not about less work; it’s about giving people a window of time where they can choose when to make that work. And more importantly, they don’t have to do it in dependency order anymore.

*MA (0:44:07)*: Yes, you can do it ahead of time. 

*JB (0:44:09)*: They can paralyze it in a way. And they can build the whole thing and then they can fix one warning after time and still check whether that works, which is of course a much more pleasant experience than going through your code in dependency order and fix all the errors. As much maybe as vs Haskell developers like this experience with refactoring, where we really love the compiler telling us this breaks, and now this breaks and I can just fix it all the way. But the refactoring is something you do intentionally and fixing, break it from upgrading GHC because you had to upgrade GHC for some other reason. That’s painful. And for me, that was an interesting insight that it’s not about less work; it’s about better timing for when you do the work for the poor users who have to do it. 

*MA (0:44:52)*: Yes. 

*JB (0:44:53)*: I opened up the proposal. Maybe it’s worth to summarize it quickly because I’m sure also that our listeners will be curious what we’re discussing there. So, the stability proposal, more it’s initiated, and Simon then fleshed out a little bit, that the basic rule and promise is that a stable Haskell package—and we’ll get into what a stable Haskell package is—that works with one version of GHC should work at a subsequent version of GHC, assuming all the dependencies already work. And so, if you depend on something that’s not stable, then of course, that can break. But then if all the dependencies are stable, then there should be a guarantee that we really – well, maybe ‘guarantee’ is a strong word, but a strong promise that we try really, really hard so that in the future, if something works with one version of GHC and you stick to certain rules, then it will work in the next version. 

And the rules also may be worth rehashing. For example, obviously, you certainly depend on libraries that follow this kind of rule and not depend on the GHC internals, for example, and it should follow the PVP and things. And for example, you should not enable that every warning is an error because we will not be able to guarantee that we won’t add new warnings in a new version of GHC, which would turn into errors if you choose to do so. So, there’s some restrictions in what the developer should do in order to get the benefit of the improved stability regime in GHC. Also, you shouldn’t just be using any language extension that exists there, but there will probably be a list of language extensions that we consider stable enough that we really try too hard, try hard to give you this promise, and others where, well, if you use that extension, then you’re opting into something that’s unstable.

And then there is exceptions. We may break this promise, but only for a good reason with a very vague rule. But at least now, we have to justify that we have a good reason, and we also promise or try to look into the kind of impact the change has. Like how many packages will be broken? 

And then there’s this little third rule where if you do have a compelling reason to break, then at least we’ll try really, really hard to give you a deprecation cycle for the reason we just discussed so that you can compare different compiler versions against the other, that you can upgrade working code rather than having to operate on broken code. And this sounds all very reasonable and written like this, and it will be very exciting to see if you can actually stick to it and practice because, just, I don’t know, last week, there was some extension discussion whether there’s, oh, but this little break, it’s probably going to be very unlikely, and very few packages have ever do this kind of thing. So, we can just fix it right away. And I’m thinking, intuitively, yes, this is how I learned how Haskell development works, but then I pointed out, this breaks the rules that we just set out to follow ourselves, and we’ll see how well it goes.

*MA (0:47:50)*: Yes. You said we’re refactoring, but that’s usually contained to one package you’re looking at. It’s not that you end up having to refactor other people’s code on the spot because you’re trying to make it work. 

*JB (0:48:03)*: Yeah.

*MA (0:48:04)*: And the other is, if we have deprecation warnings, it also means we give people a heads up what’s going to come and change. And that might mean that you actually get people to discuss that a certain feature that people think is sensible and is going to change in GHC may actually draw a lot of feedback from the community telling you that there are actually cases where we don’t really want this because currently, if you want to be in on what’s going to change in GHC, you’re mostly to be part of the steering committee. If you’re not part of the steering committee, how do you actually see what’s going on?

*JB (0:48:34)*: I guess you follow me on Twitter, and I post the proposal that I accepted.

*MA (0:48:39)*: Yeah. And that’s a bit after the fact. 

*JB (0:48:42)*: Well, with the GHC proposals, acceptance is still before implementation. So, unlike, for example, the base library, where the committee decides basically on ready-to-merge pull requests. In our case, there’s still plenty of time between acceptance and implementation. And if somebody finds something wrong with an accepted proposal, please, by all means, reach out. It’s not too late.

*MA (0:49:04)*: Right. But how do you actually – as a working programmer, how do you stumble upon the proposals? You don’t. I mean, you do once they end up in your compile and you’re, “Oh.”

*JB (0:49:15)*: Yeah, then it’s too late or almost too late.

*MA (0:49:17)*: The compiler is effectively the interface to the working program. And I mean, from the discussion where I kicked – where I basically complained about stability on discourse, and eventually people said, “Hey, you should join the steering committee.” I was like, “I’m not sure. I don’t really care that much about language research. Why should I be on the steering committee?” They’re like, “Yeah, maybe you should.” So, now I’m on the steering committee, and most of the times, I’m just asking, is this going to break existing code? And if so, I’m going to be against it. 

*JB (0:49:46)*: Well, it’s a good thing to have on the committee if that is a few that was underrepresented.

*MA (0:49:51)*: Right. I’m just saying the setup we have is that I think people who care about this do not think that the steering committee would be the right place for them, because if you don’t really care about language development and whatnot, and you’re like, “I really only care about Haskell getting from a purely system-compatible engineering standpoint better,” then what am I doing on the steering committee? Most of the stuff you’re doing is never going to hit the steering committee. So, I’m going to fix the linker for some platform. That’s not going to hit the steering committee.

*JB (0:50:20)*: Luckily.

*MA (0:50:21)*: And the steering committee is, I think, mostly comprised of people who are actually interested in pushing GHC as a language reactor forward. It’s a very one-sided view on topics. I mean, you can disagree, but –

*JB (0:50:35)*: I think we have a fraction of people on the committee who are not just pushing, but also trying to steer in the sense that, let’s just not push in all directions at the same time. But I’m always sad that Yavo left because he was always a good voice that was asking questions about like, do we want that to be Haskell? And maybe we definitely need more people who take that stance?

*MA (0:50:55)*: Well, that’s still language-wise, right?

*JB (0:50:58)*: Sure, sure. It’ still language-wise, yeah. But on the other hand, it’s also good that you don’t need to go through a committee if you want to fix the build, the linker, or something.

*MA (0:51:06)*: No. That’s why I just think there’s like this anti-selection for people who are interested in the steering committees and all of these committees in general, and then these who just try to unbreak stuff. Let’s just fix the bug and make stuff work better. I mean, we see this on the CLC as well where –

*JB (0:51:25)*: The Core Library Committee?

*MA (0:51:27)*: Yeah, where people basically try to like, okay, can we maybe try not to break stuff? And I think there are quite a few who actually try to work towards this, but it’s not always easy to predict breakage ahead of time. And yes, you can compile the CLC stackage and see if any of that breaks. But for the steering committee, where there’s not even an implementation, that’s even harder, I think. 

*MPG (0:51:45)*: Because the thing with deprecation is there are two big advantages. So, first of all, it’s like a custom error message. You can say, “Hey, you’re doing this, and you should do this next.” So, you can put the user update guide directly into the compiler message, which is great. And second of all is that a deprecation warning, particularly, it’s not breaking code. So, if I break something, I can’t run the tests because it doesn’t compile anymore. But if it’s deprecated, I can fix part of it, run the tests, fix part of it, run the tests, right?

*MA (0:52:20)*: Yes.

*MPG (0:52:20)*: So, I think it’s very important to be able to – as you said before, you want to be able to compare versions and check whether it works and how it performs incrementally, and not just, “Here’s a new version, here’s a huge patch that I put on top.” And now it all works, but which part made it slower, or which part made it better?

*JB (0:52:41)*: What still bothers me about this view, or maybe ‘bothers’ is a strong word, but it requires discipline in the sense that people actually need to look out for these deprecation warnings and fix them before they – well, before they acted on, and now things break. And I know from my own experience, and maybe this is better, this is different if you’re in a corporate environment and you put up rules and you put up CI for that, but for my own projects, I see a deprecation warning scroll by in the build. And I think, okay, do we want to fix this now? Maybe I’ll just fix it when I really have to. And then some of the deprecation warnings I’ve been seeing scrolling by for more than a decade. A byte StringBuilder get lazy and or whatever it’s called. I’m looking at you. But then, of course, it’s my choice. I know that there is a certain rule I can follow, namely, take care of deprecation warnings between two releases and you will have a much better time. And if I have a worse time, because I don’t do that, at least I don’t get to complain. I could do it differently.

*MPG (0:53:34)*: But I mean, at least I didn’t get a good error message. You don’t just get, “This function doesn’t exist or could not unify true or false.” Why? Why? And then you can compile with the old version. It’s like, “Oh, okay, I need to change the constraints here.”

*MA (0:53:48)*: Yeah. So, I hope this is going to move us in the right direction. I mean, I’m not sure anyone of us really knows if it’s going to make that much of an impact. Without actually having and trying, we won’t be able to see it. And I have this other proposal for having this experimental flag because also we don’t really know what other experimental extensions are today. No one really knows. There are some that are marked in the user guide as experimental. Then there are extensions where people think they’re experimental or they consider experimental. I mean, Joachim knows this very well from that whole discussion around GHC 2024 and whatnot, which extensions are actually next, or shouldn’t be warned? And there’s a very, very big gamut of people thinking different things about stability of extensions. And I had a call with – I know at some point where he said he does not believe that this experimental flag is actually going to help; it’s just going to add more noise and whatnot. During that call, he figured that GHC today even helpfully suggests to enable linear types if you put in the syntax.

And the question of GHC should suggest you to do this today. And my thinking is we need to have GHC be able to tell you if stuff is experimental. And for that, GHC needs to have this binary flag. This is experimental or not. And then we need to add the metadata to extensions, so GHC can actually knows this, because again, GHC is the interface for the programmer. It’s not the user guide. If I ask people at the work, who reads the user guide? I guess 5% read them, especially for each version, to figure out which is now new or whatnot. And that’s why I want this experimental flag.

And we start out with like, basically nothing is experimental, but then we can start to at least first have another proposal that says, okay, let’s move the extensions that are in the user guide that say that they are experimental behind this flag because, well, we seem to agree they’re experimental. And then we can start adding more. We say this is experimental. And the thing that experimental should give you is that if it’s experimental, the author of that extension can, at any point, without warning, break that thing as he wants. It’s basically technology preview. You can try it. If it breaks, you’re out. But if it’s not experimental anymore, then it means people start relying on it and should be able to rely on it. And then you can’t just break it from now to the next thing without warning. So, there needs to be some form of deprecation. At least that’s what I hope this would be. 

And now the problem is, if we put Template Haskell into experimental, then everything ends up being experimental. And that’s a big question, how to do this properly, because I’d like to enforce no experimental in CI for us because that means that we get the guarantee that stuff should work with the next compiler. We’re still very, very far out from that, but at least that would give us the baseline to do it. And I had people implement this in GHC. So, for the proposal, there is an implementation as well, which gives us the experimental flag. And it basically uses interface files to attain dependencies. So, you basically get this tainting up all the way to where you are and can see if anything in your dependencies is experimental because that’s the core part. If anything of your dependencies is experimental, then well, the dependency can break, so everything can break.

*JB (0:56:43)*: Yeah. I guess there are two variants that we could aim for. One is where you say, okay, a stable package, which I guess is just the dual of not using experimental under the stability proposal, only gets to depend on stable packages. And the other one is, it gets to depend on whatever it wants, but the guarantee is that whoever controls the upstream package fixes that, your package would still work. And I think they both have justification. Eventually, there’s going to be some internals inside base and libraries that base depend on. And it may be okay to use very unstable features if you upgrade quickly, like evolve.

*MA (0:57:22)*: There’s this thing which is like packages that come with GHC. They’re bound to your GHC version.

*JB (0:57:28)*: So you would give them special status but not others packages. 

*MA (0:57:30)*: Yes. It’s hard. I mean, as long as we can’t reinstall base, base is basically GHC. If you upgrade GHC, you get a new base. So, as long as base depends on any form of GHC internals, but provides a stable API to the outside world, then for any consumer, it’s invisible. But if any other package in between starts claiming to be stable, but depending on experimental stuff, then well, as soon as the compiler upgrades, anything in the chain up to that package can break. And if I depend on that package, I also break.

*JB (0:57:59)*: Right. But it would just mean that from your point of view, let’s say byte string as example of a relatively low-level package that is not – well, it comes with GHC. It’s probably a bad example. 

*MA (0:58:08)*: I would say we should work hard to make the packages we can reinstall much, much larger. And there are only a few we really can’t. So, basically, the whole closure up to Template Haskell, you can’t reinstall. It doesn’t work because you need some form of stable identifiers across it. 

*JB (0:58:23)*: No, but I think what I wanted to get at is that from the point of view of a practical developer, one could say, “Well, the point when you want to start upgrading GHC is when there was a GHC release.” Or you could say, “Well, for you, the point to start upgrading is when GHC plus a few libraries have upgraded.” And then you get the stability guarantees that your code does not break, which is less, but it would allow packages like – well, to use Template Haskell internally. But you don’t look convinced that this is not achieving what you want to achieve.

*MA (0:58:55)*: I think we should coordinate with the authors of these packages around this aggressively if we want to do this. But I know from Ben and others that they even had issues with the boot libraries getting those into shape for releases. So, I’m not sure that’s happened. I mean, what I do know is that any GHC before, like a 0.4 release, I don’t really need to touch. I mean, I’m surprised I’m actually using 9.6.3 already because that hasn’t hit 4 yet. But usually, the four minor release was usually the one that started being usable. And before that, there were a bunch. But that is also related to the stability. 

So, GHC cuts a release, gives you release candidates or alphas, and whatnot. And who then starts and actually compiles the software with them? If you have anything that has a non-trivial amount of dependencies, you probably don’t because you know most of the things won’t be building anyway. So, you’re like, “Okay, someone else got to trade.” So, the GHC developers don’t really get feedback during alphas and release candidates about their versions because, for most people, it’s just not usable at that point. So, people start waiting for release, and then they say, “Oh, it still doesn’t build.” So, they wait for the next point release and whatnot. But that means that basically, the minor 1, 2, 3, whatever, are better end release candidates in reality from an ecosystem’s perspective. 

*JB (1:00:16)*: Yeah. It seems to be a consequence of this very bizarre development in Haskell, where all the ecosystem doesn’t have a clear, defined edge. It’s like spread out.

*MA (1:00:25)*: One thing for maintainers is also like, “Oh, a new GHC release comes?” I think for quite a few, it’s actually a bit fearful because it means, “Oh God, what’s going to break now? How many weekends do I need to spend to fix up all these, figure out which upper bones I need to bum? Which things still work? Are there new failures and whatnot?” Having this experimental flag needs to be accompanied by a massive CI setup that enforces that. Otherwise, it’s not going to have any value. So, I would be planning to try to set up the infrastructure as well. Having had quite a few of built machines and a bit of built experience. Now that’s what I probably would try to do. But yeah, where this will take us, I don’t know. 

And ultimately, we can’t have single people do this. If I just keep going to do this, it’s not going to be sustainable. It’s the same reason why I want to talk about the RISC-V backend a bit because Ben is doing a really good job there. Well, I’m interested in RISC-V as well. I have a bunch of the single-board computers with the RISC-V lying on my desk. And I don’t want to be the person implementing that backend. There is no point in me implementing new code gen backends one after the other. We need to spread this knowledge. There needs to be more people knowing how to do this. 

So. Ben came and said, “Hey, I want to do this.” I was like, “Please, I’m happy to mentor and help and whatnot.” I really want people to learn this, and I think it’s great to learn, and please do this. So, we need to really focus on spreading knowledge and mentoring people to make this work and especially spread it across multiple people. 

I also work on a website called mobilehaskell.org, which is currently just one of these Docusaurus standard pages, but should probably be much more flashed out in a week or two. I try to write down all of these cross-compilation things, how to build static stuff, how to build iOS stuff, how to build Android stuff. It’ll certainly use Nix because, well, Cabal is just nowhere near where we need it to be for any of this. But we need to write this down way more what we can do. I don’t think many people know that we can build iOS applications today in there. Even people who – I mean, if you know this SimpleX Chat thing, which is on iOS and Android, that thing is completely built on Haskell, even as like desktop apps and whatnot. You can do it today.

*JB (1:02:33)*: So, I’d like to add one thought to the stability discussion. High checking a bit of this podcast with my own messages, but maybe that’s okay. So, for me, one of the appeals of Haskell, of course, is that it is a language that evolves and tries out new things and inspires other languages. And when I hear somebody say that Haskell needs to be more stable and break less often than enough, I feel like this will change how Haskell is. But I think that’s actually no longer the case, or at least, I don’t know. I’ll have that vary. And I think language extensions can help a lot – or sorry, language editions can help a lot there in the sense that we can decouple the evolution of the language from GHC versions and couple them with language editions. So, you can upgrade your GHC, and you’ll stay on GHC 2021 language extension on your code if you want. And if you want to have the new fancy, totally different Haskell syntax and maybe big changes even possible, there could be huge changes theoretically. But they’re not going to be forced on you. You just opt in when you – when and if you choose to change the language edition you want to base it on. And therefore, it’s no longer breaking change. So, it seems that language evolution and breaking changes are not that much of a conflict that you might initially think. And I think we should – there’s a, first of all, message to spread so that both camps, so to say, are less worried about what the other camp wants to do.

*MA (1:03:58)*: I do agree that language extensions is a good way forward because it gives people an idea where we’re breaking changes. I think the issue we might run into is if people want to change existing extensions, because now you’re starting to have this matrix of language extensions. Do they behave differently depending on your language edition? And I don’t think we want this. I think you’d rather want to have like, I don’t know, the new types too for a different version at some point.

*JB (1:04:28)*: Plausible. Yeah. I think this is an implementation detail. But the overall idea that stability and evolution can both be provided is something that makes me actually optimistic. 

*MA (1:04:39)*: Yes. 

*JB (1:04:39)*: And I’m sure we’ll find ways.

*MA (1:04:42)*: I hope I never made it look like that was impossible. That was never my intention. My intention was that I think we can have a stable subset and keep that across languages. We just don’t need to break it with every version and then lead to maintainer burnout and whatnot. And people just like, “Oh, I want to test this.” Because really for GHC development, I want people to early test. So, if I know I can take 9.8 and run our whole code base against 9.8 and provide bug reports and regression reports to GHC, I’d be happy to do this. But I think for most companies, that’s just not a realistic position to take because if you put in a new compiler, nothing works anymore. So, yeah, a large part is this quality assurance part, which maybe I did not stress enough. And then the other is that, obviously, I don’t want to spend so much money on migrating all the time.

*JB (1:05:33)*: Cool. That was a very interesting discussion. Thanks for that. What are the final thoughts before we wrap up? Any last messages? 

*MA (1:05:42)*: Well, I hope to be able to do Haskell quite a bit more. We’ll see what the next year brings.

*MPG (1:05:47)*: All right. Thanks for coming on the show. 

*MA (1:05:49)*: My pleasure. 

*MPG (1:05:50)*: I’m excited to see how everything turns out with stability. 

*MA (1:05:53)*: I think we all are.

*Narrator (1:05:56)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
