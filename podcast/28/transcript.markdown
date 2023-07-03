*Niki Vazou [0:00:11]*: This is the Haskell Interlude. I’m Niki Vazou.

*Mattias Pall [0:00:14]*: And I’m Mattias Pall.

*NV [0:00:16]*: And our guest today is Richard Eisenberg. Richard is currently a language designer at Jane Street. He is the chair of Haskell Foundation and known for his work on the GHC compiler. Today we talk about dependent types in Haskell, how to get involved with GHC and the Haskell Foundation, and how Haskell and OCaml can benefit from each other. 

Hello, Richard. Thank you very much for joining us. So do you want to tell us how did you get into Haskell?

*Richard Eisenberg [0:00:45]*: Sure. Was it by accident? I guess it was a little bit in that I started my PhD program at Penn and I had heard of Haskell at that point, but I didn’t really know it at all. And then I enrolled in Stephanie Weirich’s-- I think it was called Advanced Functional Programming class. And on the first day of class, she said, “Oh, it’s really-- class participation is really important.” And so I was like, “Okay, so I’ll try to participate a little bit.” And then she started going through examples. And I had done a little functional programming before that. So there was one example that came up around-- she was redefining plus, trying to explain that plus is just an ordinary function in Haskell. And so she had on the board the word plus X Y = X + Y. And so I raised my hand and said, “Oh, well, what if we just did plus, or if we did the word plus equals sort of unapplied plus, won’t that work?” And then that of course led us right to the metamorphism restriction. And so we had a little conversation about that in class. 

Anyway, that I guess went well from her point of view. She emailed me after class and said, “Hey, instead of taking this class, it seems like you know a bunch of functional programming already.” Because I had done it as an undergrad. So then she pulled me aside and said, “Maybe we should do an independent study in all of this,” and just sort of pointed me at the idea of singletons and this just made sense somehow. And so sort of ended up going down that road. And then once I started working with singletons and trying to build them, I was using Template Haskell to sort of generate these singleton definitions. And Template Haskell didn’t have the features that I wanted, so I started complaining on the bug tracker saying, “Oh, we need this, we need this, we need this.” And then at some point, Simon said, “Why don’t you just write it?” Of course, he said it much, much more nicely than that, but that was the content of it. And I was like, “Oh, but I’ve never done anything like that before.” And he said, “Oh, it’s not that hard. There’s just these three files in the compiler. I bet you can figure it out.” It was hard, but I sort of got in. And then once I started contributing to GHC, that was really, really fun.

*NV [0:02:51]*: So this was in parallel with the Hasochism paper.

*RE [0:02:56]*: So the Hasochism paper came out a year later. So it’s sort of a similar timeframe. We were in discussions with Conor at that point and trying to come up with all these ideas together. But I think the Hasochism paper was one year after

*MP [0:03:10]*: So what is that paper for us that don’t know?

*RE [0:03:13]*: Oh.

*NV [0:03:14]*: Paper with a nice title. 

*RE [0:03:16]*: Yes. So that paper, that was a work between Sam Lindley and Conor McBride. Some papers are really out there because you have this big idea that you want to communicate to the world. Others are really, you’re just trying to convince a few people of an idea. This is definitely in that second category in that Sam and Conor were trying to convince Simon and Stephanie that Haskell should have real dependent types and not these crazy singletons. And up until then, at least Stephanie was pretty unconvinced about the need for real dependent types. I think Simon was too. I wasn’t in as much conversation with him at the time. And Hasochism just sort of demonstrated all the ways in which singleton-based programming can be really painful. And that’s where the title comes from. But it is quite painful to look at all of that. And after that paper, Stephanie really was convinced that we needed to have full dependent types.

*NV [0:04:06]*: And this is how you started working on full dependent types for Haskell?

*RE [0:04:10]*: I think so, yeah. I mean, after building out those singletons, they’re really not very cool. And so the idea of being able to have right in your program a proof that it’s correct and have the type checker check that, that just seems so powerful and just a great way of really delivering on the promise of a strongly typed functional program being language like Haskell in that we say, “Oh, if a type checks, it works.” And that’s kind of true sometimes. But with dependent types, or as I’m sure we’ll want to discuss refinement types, you can really deliver on that promise.

*NV [0:04:48]*: But do you really need to have Haskell prove all these fancy proofs to enforce the claim that if it type checks, it works?

*RE [0:04:58]*: I think so at some level in that when you say-- the way that you say it is, do you need Haskell to do it? I guess there’s different ways of doing it, is we could have some process where we extract from Haskell into some other proof language and then prove our programs correct in some other platform. That would work, but that’s really kind of indirect and quite a lot of work.

*NV [0:05:19]*: No, I was mostly saying that Haskell gives you the promise that if it type checks, it works. As long as it works doesn’t mean that plus is associative.

*RE [0:05:29]*: Well, but maybe it should.

*NV [0:05:30]*: Yeah. So can you do that in Haskell now?

*RE [0:05:34]*: I would say yes, you can. I mean, there’s two different good approaches to do this. So Haskell has sort of a limited painful form of dependent types. In some sense, we’ve gotten maybe a little bit better since the Hasochism paper in the past 10 years, and there’s certainly more support internally. But it’s not all that usable, so we’re still in that world of having to do things somewhat painfully with dependent types. So you can do that. You can prove associativity of an operation. It’s painful. The alternative is something like Liquid Haskell where you can write refinement types and-- can you prove associativity using refinement types? I bet you can.

*NV [0:06:10]*: Yes. I mean, you don’t have to, right? If you are restricting to plus, then SMT knows that, so you don’t have to do any proofs. But in a painful way, you can prove associativity of append and other elements.

*RE [0:06:24]*: Right. Sure, of course. Because the refinement types sort of start at a higher platform. I mean, the dependent type support is very, very basic in that it doesn’t know anything other than the nature of inductive types. Whereas Liquid Haskell powered by an SMT solver knows about arithmetic, for example. And so you don’t need to prove associativity, sure.

*NV [0:06:44]*: And so what is the plan? Is the dependent types plan to make it less painful?

*RE [0:06:53]*: So, the dependent types, the overarching dependent types plan is, well, to have full dependent types and write in the language. So in some ways, that makes it less painful because it means--

*NV [0:07:06]*: I always had this question, so I’m going to stop you. What does it mean to have full dependent types in the language? 

*RE [0:07:12]*: It means that you can write the same expressions. I mean, there’s a bunch of different aspects to it, but I think the key thing that I mean when I say that is that I would want you to be able to write the same expressions in the compile time language that you can in the runtime language. So what a lot of people say is the same things in types as they are in terms, and I have found that terminology sometimes challenging because then you have to ask the question, well, what is a type? Then it means that there’s a difference between types and terms. And I don’t want there to be a difference. So instead, I think it’s a more helpful language to talk about compile time programs versus runtime programs. But if I say that, if you want to hear types versus terms, you can and that’s fine.

*NV [0:07:56]*: Yeah. This will put many restrictions.

*RE [0:08:00]*: Why do you say that?

*NV [0:08:02]*: Termination.

*RE [0:08:04]*: Oh, we don’t need termination. We don’t need termination.

*NV [0:08:06]*: You want to put like all the expressions in the pipes and not have termination. 

*RE [0:08:11]*: Yeah.

*NV [0:08:12]*: Is this possible? It sounds that it’s violating some like Godel basic theorem. 

*RE [0:08:18]*: No, it’s fine. I mean, what I mean by that is, if you put non-terminating expressions in your types, then it means that when you try to compile, maybe the compiler won’t terminate, which is annoying, but it’s not worse than annoying in that the goal that we’re trying to achieve is that when you run your program, it’s type safe. But if you can never run your program because your compiler has never produced it, then that’s fine. So that’s one way that things can go wrong. And then the other is that if you have a proof of something that doesn’t terminate, well, you have to make sure then to run your proof to see like by running it, that will cause everything to-- all the non-termination, well, you’re sort of essentially checking to see whether it terminates by running it. And that’s a real downside to the current design of Haskell, is that if we have-- going back to plus, if we have a proof associativity, actually, if you need that to prove some other quality of your program, you’re going to have to run that proof, which is kind of ridiculous. You should be able to check the proof at compile time. But because of this non-termination thing, it means we can’t really do that and it means we have to run the proof and that’s going to slow your program down. So there’s workarounds, but the workarounds sort of essentially amount to assuming that some proof terminates, which is often a good assumption. And that’s fine. But there’s nothing sort of fundamentally broken about it.

*NV [0:09:45]*: But there are two dangerous things with termination. One is what you said that your compiler might not terminate with-- let’s assume it is. I don’t know if Haskell programmers or the programmers did not use the dependent feature on that, but let’s assume it is okay. And then termination might cause consistencies, no? You have solved this problem.

*RE [0:10:10]*: Yeah. The design of the internal language and our proof of type safety accommodate this. It’s not a problem. But again, it means that we have this extra step at runtime essentially checking the termination of our proofs. Because they do need to terminate, but we can check them.

*NV [0:10:27]*: These happen once, and then you just take the proofs and you assume it, right?

*RE [0:10:32]*: Once per time you run the program and depending on how it’s structured, maybe once per argument into the proof. We want to prove that 1+2+3 is associative, but then later we might want to prove that 1+2+4 is associative. And actually, I think in that case, we don’t have to rerun it because it’s the last number. But if it’s either of the first two numbers, we’d have to rerun the proof. That’s really pretty annoying.

*NV [0:10:58]*: And so how are all these features affecting the programmers that are not using the dependent features?

*RE [0:11:05]*: So that’s a great question and that’s been one that I think a lot of people have had over the years. So the goal is—and I think we’ve achieved that goal—not to affect those other programmers, or I should say we’re not affecting the programs that those other programmers might write. So all the programs that have been written in Haskell, we’re going to continue to accept and you’ll be able to import symbols from files that don’t use dependent types and import things back and forth. Everything should be fine. The challenge is sometimes keeping the error messages good. So this is something that I think we made a few early mistakes about. I think we’ve actually gotten quite a bit better about this in the last couple of years. And every now and then, there are still complaints out there, but I think that things have gotten quite a bit better in terms of not necessarily fixing the older messages, but not introducing new bad ones. We’ve become very careful about that. So that’s a way that they could affect other programmers. 

The other thing that I’ve really wanted to think more about in this space is declared language levels in that, like right now, if you accidentally use-- if you wanted to say Maybe Int, you have-- X has type Maybe Int, and X is nothing. Maybe you accidentally say X is Just Int because you’re somewhat new or you’ve made a mistake. Right now, GHC will say, “Oh, I can understand that. Do you want to turn on DataKinds or something like that?” Especially a novice programmer is not going to know that that’s not what they want. And the new tooling inside of VS Code and with the Haskell language server and all of that, they can now just click a button and it’ll add DataKinds. And then now they get some obscure kind error saying that Just Int has kind Maybe type and it should be a type or something, and now they’re just very confused. This is bad. But it’s really hard to know how to fix because some users want to turn on DataKinds and some don’t. And so it would be kind of cool if you could say, at the top of your file, “Oh, this is my first week of Haskell programming, treat me like a novice. Help me along.” Or you could say, “This is my fifth year of Haskell programming.” And then maybe the error messages should be different in those cases. There’s some problems there. So I don’t know if that’s really the right approach, but it’s something I’ve been wanting to experiment with.

*NV [0:13:30]*: But I mean, in all this is a very ambitious project goal because it has many restrictions. You need to keep the compatibility, you need to keep-- you have all these ergonomic things that you want to keep. And also, my understanding is that you are inventing a new lazy type theory at the same time.

*RE [0:13:49]*: Yeah. There’s a lot going on. And I should just say at this point that the dependent types project goes much further than me. And in fact, at this point, I’m only barely in the project at this point. So I’ve been using a lot of my time over the past many years, sort of push this along. There are others who have taken the fire from me at this point. And that’s fantastic. I’m available. I participate in conversations as they come up and sort of have an idea of the overall design. I’m happy to talk about all this, but I just want to give credit where credit’s due. Right now, Vladislav Zavialov of Serokell, he’s really the one sort of pushing this forward. So I just want to sort of highlight his efforts here. 

In terms of these design challenges, I think they sort of keep us honest. There’s other dependently typed languages out there, they tend to require a lot more type annotations than Haskell does. And so the desire to keep old programs working means that we have to sort of think hard about type inference in a way that other dependently typed languages haven’t had to think. And so that is, I think, quite an interesting constraint that we have and one that pushes the science of programming language design forward.

*NV [0:15:04]*: And now what is the project that takes your time?

*RE [0:15:08]*: So, at this point, I mean, starting last summer, so summer of 2022, I took a new job at Jane Street. And so that job reduces the amount of time I have for Haskell. So Jane Street was nice enough to agree that I should have some time for Haskell. So they give me a day, maybe a little bit more if I need it toward Haskell per week. And that Haskell time is spent sort of solving problems that come up in the type checker more than designing new features. So sometimes this solving problems in the type checker means designing a new feature. And actually, there’s one that’s happening right now that might be of interest. So I’m on a weekly call with Simon. When there’s something that requires discussion, Simon and I will talk about it. And I’m very involved with the Haskell Foundation and working with its Executive Director, David Christensen, and trying to steer that in a good direction for the whole Haskell community. And for the most part, that takes up the time sort of looking at new language proposals. I’m on the GHC steering committee and active there, sort of helping out with these problems in the type checker and the Haskell Foundation. That easily adds up to the one day a week. So there’s not so much time for design or implementation of these new dependently typed features.

*NV [0:16:31]*: So you said too many interesting things. I want to ask about Haskell Foundation and I want to ask about your Haskell with OCaml. So where do you want to start?

*RE [0:16:45]*: So I’ll talk about Haskell Foundation for a little bit. I think our listeners here will know, but that’s been this growing movement to really try to have some group that sits between all of the others in a sense. That Haskell for the last 20 years, there’s been these different committees, there’s GHC running over here, and there’s Cabal running over there, and there’s stack running over there. And then more recently, there’s HLS, there’s been Haddock for a long time. All of these tools really need to talk together. And I think maybe the core part of the Haskell Foundation is trying to facilitate that collaboration. There’s been a bunch of other things on the side, but I think all of that is really happening. Haskell Foundation started in earnest in early 2021. So we’ve been around-- I guess about two years now. And I think already I’m getting the sense that we’re performing really essential functions in the community. We’re going to sponsor some of the students in Haskell Summer of Code this coming summer. We are running a clinic as part of ZuriHac to help people learn about GHC. I say running, I should say organizing, that there are other speakers that are going to come in, reaching out to new communities. David appeared at FOSDEM, a major open source conference, to try to talk about the glories of Haskell there. So there’s a lot of these things on the side that are really coming together and I think where momentum is building behind it all.

*NV [0:18:13]*: And so if somebody wants to participate or to help?

*RE [0:18:17]*: So that’s a great question. The place to start is our website. It’s haskell.foundation. David Christensen is the Executive Director. He’s the one to handle volunteers that come up. We’re very happy to have people come through with that.

*NV [0:18:33]*: Nice. Okay. Then let’s go back to your OCaml experience as a Haskell programmer.

*RE [0:18:39]*: Sure. So Jane Street does all of their programming—I shouldn’t say all, there’s a couple of other languages in the mix, but the vast majority of their programming—in OCaml. OCaml is a language that’s very similar to Haskell. It’s a strongly typed functional programming language. It has data type definitions that are just like Haskell’s. It’s missing a few features that Haskell has. So it doesn’t have type classes. And what this means is that if I want to turn something into a String for printing, for example, there’s a function String of Int and then a different function String of Double, and then a different function String-- I guess it’s not String of Double, String of Float, excuse me. What Haskell calls double OCaml calls Float. That always throws me for a loop. So it doesn’t have type classes. It has GADTs, but it doesn’t have DataKinds. Although you can get pretty far without the DataKinds. But OCaml also has a very glorious module system that allows you to define abstract types in a way that-- I mean, Haskell, you can have a type that doesn’t export its constructors and Haskell calls that abstract. OCaml takes that to a whole new level of what it really means to be abstract. And I think that’s quite an interesting feature over there.

*NV [0:19:53]*: I don’t know. I just remembered that OCaml has a module system through functors.

*RE [0:20:00]*: Yes, that’s right. 

*NV [0:20:02]*: If it’s correct, then is that something you can explain to Haskell listeners?

*RE [0:20:07]*: Sure. So a functor, it’s annoying. OCaml has the word functor. Haskell has the word functor. They’re unrelated.

*NV [0:20:17]*: Okay. Things make more sense now.

*RE [0:20:21]*: Yeah. They’re just two different uses of that word. Even more annoying is, OCaml has something called applicative functors, and Haskell has something called applicative functors. And those are also completely unrelated.

*NV [0:20:35]*: But they both came from the same category as a theory term, no?

*RE [0:20:38]*: Presumably. I don’t know the history of it. They’ve got to, or maybe one language was trolling the other, I don’t know. But they both have this thing called an applicative functor that has nothing to do with the other. So in OCaml, a functor is essentially a module with some missing pieces. And so to use the module, you have to apply the functor to another module. It’s basically a function at the module level. And so listeners who know a little bit about Backpack, Backpack is a little bit inspired by this idea that you can have sort of a package that’s missing some things. And it’s kind of like an OCaml functor, they don’t line up exactly. And actually, one of the features that we’re cooking up within Jane Street for OCaml is something more like Backpack than what OCaml currently has.

*NV [0:21:30]*: Okay. We learned that. And before I interrupt you, you were saying that like two string is difficult, but other than that?

*RE [0:21:41]*: Well, I mean, the flow of the languages is really different. So OCaml is a strict language and has very much a top-to-bottom evaluation order. So when I’m writing an OCaml function, I know that the lines that I write are going to be executed in the order that I write them, except oddly for function arguments which evaluate right to left, which is very strange, but it’s just the way it is. But the evaluation order is predictable. The optimizer takes a lot of care not to change that. And in fact, the optimizer in OCaml is significantly less ambitious, I’ll say, than Haskell’s because OCaml programmers, there’s a more important connection between the code that they write and what they expect to actually execute than what we have in Haskell. And so it’s a bit of a different mindset when programming. 

And one of the features I really miss from Haskell when I’m programming in OCaml is where. It sounds really simple, but I miss it all the time programming in OCaml in that in a Haskell function, I can say F(x, y, z) = and then I can say the most important idea of my function right then and there, and then describe all of the other pieces afterward. And so the interesting thing comes first, readers can come along and understand the interesting thing and then fill in the details. In OCaml, without that feature, everything is top to bottom. So you always have to define everything before you use it. There’s no-- well, there is a mutual recursion, but it’s sort of a special language construct. And so it means that every big function starts out with 50 lines of, and here’s this little definition, and here’s this little definition. And as you’re reading it, there’s no structure to understand these. And so you’re like, “Why do they need this? Why is there this?” I’m always thinking about the compilers. So there’s lots of manipulations of source locations. I don’t care about the source location; I care about what this function really does. But you have to wade through all that other stuff before you get to it. It’s really annoying.

*NV [0:23:37]*: Yeah. We are spoiled with Haskell that ordering is not important.

*RE [0:23:42]*: Yes, very much so. And moving to another language where ordering is suddenly important, it always gets in my way, I find. And I have to be careful about thinking about my definitions because they’re always going to execute. And so in Haskell, I can just have a let and I just define, “Oh, here’s 10 things I might need. Whether I need them or not, doesn’t matter. I’ll just define them anyway.”

*NV [0:24:02]*: The compiler will figure it out.

*RE [0:24:03]*: And the compiler will figure it out. And OCaml does have dead code elimination, but if it’s used in one branch but not another, it’s not quite dead code and it’s not going to reorder things because everything in OCaml is effectful, which is also very annoying. We need to get rid of these effects.

*NV [0:24:19]*: So you are working on the compiler?

*RE [0:24:21]*: Yeah. So my job within Jane Street is to design and implement new language features in OCaml and, in particular, to help Jane Street get them back up into the main trunk OCaml compiler. So one of the fun things right now is that I’m on the GHC steering committee. So I’m on the committee that helps to decide what such features end up in GHC. Over in the OCaml side, I’m helping to develop the features and trying to convince the OCaml equivalent of what should go in. And so it’s fun because I now have a lot of sympathy for both sides of that equation.

*MP [0:24:54]*: So what about the other direction? What can we take from OCaml? What is it there that you’re like, “Wow, I wish we had this in Haskell”?

*RE [0:25:02]*: So now I’m going to contradict myself. And so maybe this is why the language design is hard. It’s really nice in OCaml that there are ordered definitions in that one challenge that we’ve had in Haskell is around cleaning up imports, and wouldn’t it be nice to just have that you import something and you can automatically get it qualified, as opposed to at the top of every file, you have to repeat the same little pattern of import qualified Data.Set ss or something like that? And there’s been a number of proposals to do it, but they all end up falling a ground on the fact that everything at Haskell is always in scope all the time and we can’t really control that. Whereas in OCaml, everything is ordered. 

So in OCaml, if you have import A followed-- well it’s open A, but if you have-- I’ll just use the Haskell syntax for our listeners. But if you have import A followed by import B, and both modules A and B introduce the same thing, well, B just shadows A. It’s very simple. There’s no ambiguity to worry about. It just takes the last thing. And that’s nice actually. And it means you can also have data types in OCaml where all the data types have the same constructors. And if you don’t have any types around, then the last one wins. And if you do have types around it, it does type-based disambiguation, which is really nice. Because OCaml has these nested modules, you can actually put these different type definitions in separate little modules and then now you can refer to them by a fully qualified name. And it just means that we don’t need to sort of worry about choosing unique names. In Haskell, every time you make a data type, you put the-- the name of the type is a little prefix on all of your constructors just so that they’re easier to use. You just don’t have to worry about any of that OCaml, so it’s nice.

*NV [0:26:45]*: And what about the two compiler communities? They use the same infrastructure and all this?

*RE [0:26:53]*: The communities are a little bit different. I mean, everything in OCaml is on GitHub instead of Haskell does its stuff on GitLab. That actually makes a bit of a difference. GitLab I think does a much better job of review than GitHub does. Doing in-depth code reviews on GitHub is kind of painful.

*NV [0:27:12]*: I am a big GitHub fan. 

*RE [0:27:14]*: Are you? 

*NV [0:27:15]*: I like the reactions. Yeah, I think the design is very good. Whenever I want to use something else, I don’t like it.

*RE [0:27:21]*: Interesting. So the reactions I think are very nice in GitHub. I like that. But if you ever do a review that has more than 10 comments or so, I find GitHub just really doesn’t scale and GitLab does a better job of that. So there’s that one small difference in the communities. OCaml doesn’t have a rigorous proposals process the way that GHC does. So when there’s a new idea for OCaml, there is this proposals repo, but there’s no sort of actual process there. You just sort of post it and people discuss it. And then I think every six months, there’s a meeting of the core developers and they decide on the proposals. But actually, even the list of who that is I don’t think is readily available. So there’s a little less process there. But then maybe Haskell’s overdone that. I’ve been an important part of that. My stance has been to sort of introduce a lot of what’s hopefully a transparent process for doing things, but to be really transparent needs quite a lot of process. And sometimes I think we’ve overdone it and--

*NV [0:28:22]*: It’s a lot of time too, right?

*RE [0:28:23]*: Yeah, and a lot of time. So those are some differences in the communities. In the end, there’s, I say, more similarity than difference. The core members of the OCaml community are a bunch of academic researchers. The core members in Haskell have been as well. And I think that helps to sort of guide the direction of both languages. I think both languages are struggling in expressiveness versus simplicity and elegance. I think--

*NV [0:28:53]*: And the direction that OCaml is going down with is parallelism, is that correct?

*RE [0:29:00]*: Yeah. So OCaml 5 came out somewhat recently, and the big thing there is that it allows for multi-threaded programs for the first time. Obviously, Haskell has had that for a long time, and that’s an exciting new feature. I say I don’t know very much about that because Jane Street has not adopted that. I know that it’s out there, but other than its existence, that’s about as much as I know.

*NV [0:29:22]*: And what is the direction that Haskell’s proposal and everything is going?

*RE [0:29:27]*: I mean, all Haskell process goes where the community wants to lead it in that there’s new proposals being added. I think right now, there’s some work being done on getting better control over error messages and warnings. There’s always the steady drumbeat toward more ways of expressing things at the type level and getting us closer to dependent types. Those are some big topics on the proposals repo.

*NV [0:29:54]*: And is there any interesting, like existing open think in the proposals?

*RE [0:30:01]*: That’s a great question. There’s nothing that immediately jumps to mind that’s going to be earth-shattering that’s going in the proposals. We’re trying to clean things up. We’re trying to have a better story around scoped type variables. That’s been a big thing that we’ve been working on. There’s a new feature coming with--

*NV [0:30:18]*: What is it? Cope type variable?

*RE [0:30:21]*: Yeah, scoped type variables. Just to have a slightly more principled story around them and where you can introduce them in patterns. Something that most programmers won’t notice, as you breathe a sigh of relief. That’s in some sense when a goal of ours is that there’s the programmers who are pushing for things will notice because they get what they want, but others won’t. And that’s exactly what we’re trying to achieve.

*NV [0:30:45]*: This is not the type application, this exists already. Correct? The explicit type application?

*RE [0:30:49]*: Yeah.

*NV [0:30:50]*: Okay. It’s irrelevant to the scoped type variables.

*RE [0:30:54]*: Not entirely irrelevant because sometimes we can bring variables into scope in new places and the type application allows you to use them, but a different proposal, a different feature.

*MP [0:31:08]*: Right. Are you going to fix that part where there was some bug? Or not a bug, but it would tell you to turn on scoped type variables, but there was no type variables being introduced to scope. It was something you do notation or something like that. Like you would do something and then it would think, “Ah, you need scoped type variables here, but--”

*RE [0:31:27]*: Ah, yes. Yeah, that’s right. Sometimes you want to put a type signature on a pattern. And that’s part of the scoped type variables extension. And there was actually a proposal some years ago to try to separate that out, but everyone decided, “Ah, this just isn’t worth introducing a new extension.” And so right now, you just need to turn on scoped type variables for that. It’s a bit silly.

*NV [0:31:50]*: And so do you have any advice for a newcomer that wants to contribute to GHC but has very little knowledge?

*RE [0:32:01]*: I think that there’s a great place for people who want to contribute to GHC and have very little knowledge of GHC, but they would need to have some knowledge of language implementations where that’s an understanding of abstract syntax trees and how compilers operate. undergrad course in compilers, I think, would be plenty for that. But I think in the past, it’s very tempting to say, “Everyone who wants to can contribute,” and that’s not quite true. 

*NV [0:32:31]*: It’s not an easy code base, right?

*RE [0:32:34]*: That’s right. It’s not a particularly easy code base. At the same time, it’s doing hard things. And so we really take pride within GHC about documenting the code base well. That’s another big difference between GHC and OCaml, is that GHC has a much better tradition, at least internally, of writing lots of documentation. The OCaml source code is missing some documentation. And that has been a challenge for me as I’ve tried to get to know it. So a great thing to do right now is there’s this little clinic I mentioned that’s happening right before ZuriHac, that Simon is presenting there, a number of other GHC contributors are presenting there. I would love to go but can’t quite swing at a sort of a poor time for me. And where people will really get exposure and everything there is going to be recorded and made available. So even if you can’t make it to that or you’re listening to this, after that’s happened in the summer of 2023, that material should be available. And the goal is to make that a real way of getting involved.

*MP [0:33:36]*: I just want to add to that I think I contributed first like six years ago and I just wrote some code, and then a lot of people came in and helped me improve it. So you don’t need to be afraid to put something out there. No one’s going to be mad at you, right?

*RE [0:33:52]*: Yeah, that’s absolutely true. I mean, it’s fantastic when a newcomer joins the GHC GitLab and just contributes code that does a new thing. That’s great. It’s always when something comes out of the blue, there always has to be sort of a conversation like, “Oh, is this a feature that we’re excited for? How does this fit in with the rest of it?” So it’s often good to start a conversation either on discourse or there’s a GHC devs mailing list where people can connect about that or you can make a little proposal. There’s various ways of introducing an idea, but having new people do that brings new energy into the compiler. It’s fantastic.

*NV [0:34:29]*: And I assume the number of people that are contributing over the year grows, right?

*RE [0:34:35]*: Yeah, absolutely. As the compiler gets bigger, we’re going to have more and more contributors.

*MP [0:34:40]*: So Richard, you worked a lot on the type checker and the gnarly parts of Haskell. So do you have any good stories to tell about what happened? How did you solve it?

*RE [0:34:50]*: Yeah, sure. So I can share one that’s happening right now, and it’s fairly typical of a lot of others. But everything in the GHC type checker is around constraints. So the idea is that, as GHC is understanding your Haskell program, it looks and sees, okay, so this variable is used here and this variable is used there. The variable has to have just one type. So then we know that in this context, that type has to be the same as the type in that context. And that will create an equality constraint between those two types. And as we understand the source program, we’re going to generate a ton of these equality constraints and also class constraints. Maybe something is used as the argument to abs, for example. And so then we know that that thing must have a num constraint. And so we build up a whole lot of constraints. 

And then there’s another little algorithm—not so little—in GHC that solves the constraints. And so one effort that really Simon is pushing right now—I’m sort of watching along and offering advice on the side every now and then—is doing a big refactor of that constraint solver. So there was a paper that Simon and collaborators wrote, I guess it sort of came out in either 2010 or 2011, called OutsideIn. Anyone who follows along with GHC will have heard of that paper. That sort of laid down the way that the type checker worked. And actually, for the last 10 years or so, it’s been pretty true. With this refactor, it’s really going to look a lot less like that paper than previously. And so Simon and I always muse about how fun it would be to write an update to that and really say where we’ve come. It would be really fun. It’s sort of hard to find the time to do that. It’s a lot of work. 

So, where the big change is that previously, we thought about a pipeline where every constraint would sort of get canonicalized into a certain form, and then we would look to see if there’s other constraints that sort of look like it that we can use to inform it. And these were called interactions. And I think that the idea behind that is a fine idea, but it meant that sometimes during this canonicalization phase as we were simplifying something as like, oh, well, actually it turns out we could just solve this right now, we know how to solve it, but because of this pipeline and the way that it was structured, we couldn’t. And so we then had to record what the solution would be if we could do it in the data structure and then wait for later to actually solve it. This was kind of silly. And so the restructuring is now each constraint goes through and is solved by whatever means necessary. So the means necessary usually are simplifying and then somehow solving, but it’s just sort of, I guess in some sense taking the transpose of the previous design. So that’s going on right now and should simplify things, make it easier to express some of our thoughts.

As we’re doing that, we’re discovering other strange aspects of the type checker. So one recurrent problem that we’ve seen come up is that sometimes we have an equality between two types that for whatever reason can’t actually be made equal. So an easy case of this is if I have a type variable A and I discover that A equals Maybe of F(a) where F is some type family. So if I have an equality A equals Maybe A, I know I can’t solve that. The only solution to that is something that would be infinitely sized. But if I have A equals Maybe of F(a), then depending on exactly what the type family F does, maybe there is a solution to that one. 

*NV [0:38:17]*: The inversion of a Maybe?

*RE [0:38:19]*: Well, the inversion of Maybe is a good one. Yes. 

*NV [0:38:21]*: Does it even exist? 

*RE [0:38:23]*: Sure it does. Yeah. You can write that as a type family. And it turns out that that equality is sometimes useful. And so in the type checker, we really want to be careful. If A here is actually a unification variable, it’d be very bad if I filled in a unification variable with something involving itself. That will then immediately make the type checker not terminate. So we don’t want to do that. So that’s one case where here we have this equality, we’d like to be able to do something with it, but we can’t do the normal thing with it. 

It turns out that we had a similar case somewhere else. There’s this sort of-- no one really knows about this, but there’s a-- not a feature, a concept. There’s a concept within GHC called a concrete type variable. And a concrete type variable is one that after we solve it just has to be a bunch of type constructors with no type variables left. You can’t abstract over these concrete type variables and they’re needed when you mention something in a runtime representation. So GHC has this feature called representation polymorphism, which allows you to have a function that can work over both normal lifted types, but also unboxed ints and unboxed floats, and all of things like that. And there’s a lot of restrictions around it. And so concrete is one of these restrictions. But because of this restriction, if I have A equals Maybe of list of B, well, I can’t now-- if A has to be concrete, I can’t say that A equals that other thing because B, well, B isn’t concrete; B is some variable. I don’t know what it is, but I want to be able to do something with that equality. 

It turned out that these two things are really quite similar. And there’s a third one involving type checker levels, which I won’t even explain. But we identified that there were three different stories. We had this equality and we had this thing that we wanted to do with it to make progress, but that we couldn’t use in our normal techniques. And the infinite types case, it was like this big pile of code and an even bigger comment. The comment itself I think went on for about five pages, five screenfuls of how to deal with it. And it turns out that we could unify all of these into a common structure and this was a nice little bit of refactoring that is more expressive than any of the individual pieces. Because we solved different problems in each of the cases, but now that we’ve unified them all, all of the problems have all the solutions, and so we can do more. And it’s just a nice simplification. And I think that there’s even a perf benefit to it because we understand the problem better. It’s very typical of our work, is that we get something. It’s driven by a couple of examples and then eventually, we realize the more general structure that solves all of the examples.

*NV [0:41:04]*: And what is the solution?

*RE [0:41:06]*: Oh, I mean, it’s with one algorithm that sort of analyzes a type and sort of knows what kinds of trouble it’s looking for, and then when it spots the trouble, it sort of creates a new type variable that has just the right qualities and uses that to replace part of the type and then it can do some unification. The algorithm itself isn’t all that interesting as much as identifying. The conditions in which it’s used, I think, is the more interesting part.

*NV [0:41:32]*: And now like type inference is faster, no?

*RE [0:41:36]*: Has that been merged? Maybe it’s been merged this week, last week, next week. It’s all happening right now. I don’t know exactly where it sits.

*MP [0:41:42]*: So you won’t have the Tc non-canonical anymore, or is that still around?

*RE [0:41:48]*: No, that is still around. I’d love to kill that off. That shouldn’t be there, but it is still around. And yeah, there’s no active plans right now to get rid of that, although we shouldn’t have it.

*NV [0:41:58]*: What is the Tc?

*RE [0:41:59]*: So, it’s non-canonical, it means a constraint that we haven’t simplified yet. And the reason I say it shouldn’t really exist is that there are constraints that are sort of fresh that have just been created. Those are going to be non-canonical. And then there’s the constraints that we’ve already processed. What’s weird in GHC is that right now they’re the same type and they’re just different constructors of the same type. But actually, in almost all cases, we know whether something has been canonicalized or not. And so non-canonical should really just be out in its own type. And then in the constraint generator, we know everything is non-canonical. And then after we’ve simplified things and canonicalized, then we know everything is canonical. Maybe in a few places we would need an either between these things, but probably not even that.

*NV [0:42:47]*: But isn’t it strange that all these seem fundamental features of Haskell’s type inference? How do they come up now?

*RE [0:42:57]*: Well, they come up now because we continue to-- as we continue to add new features, they are sort of fundamental, but they’re related to new features. So this idea of concrete, we only came up with that maybe two or three years ago. And it takes time before someone writes the obscure program that our current algorithm doesn’t handle. This one about these equalities that can lead to infinite types. Well, that’s been around for a while, but there was an older technique called flattening, and I forget exactly why. A few years ago, I found flattening was getting in my way. Oh, that’s right. There was this big comment explaining it and I couldn’t understand the comment. And so I talked to Simon, we talked about it a bunch. Neither of us could really understand the comment by the end. And so that meant that the whole feature had to go. And so we factored this part of the type checker to get rid of flattening. This made things faster and simpler and better. But it turned out that flattening was really important on these like A equals Maybe of F(a) equalities. And so once we removed flattening, then something had to come back in to handle those equalities. And so that’s why it’s kind of newish.

*NV [0:44:07]*: Okay. I’m thinking I have heard many times, especially from Haskell programmers, that if something has many comments, most probably it doesn’t work.

*RE [0:44:15]*: Yeah, that’s exactly right. And so I was talking about there’s this algorithm that had five screenfuls of comments. Are those all gone in the new design? I guess they’re not, but actually, now that I come to think of it, we probably need to go-- I don’t remember doing serious edits on those five screenfuls, but this new approach probably needs to completely rewrite that and hopefully as much simpler now.

*NV [0:44:38]*: So the lesson is this: if you want to contribute to GHC, do not comment your code, right?

*RE [0:44:44]*: No, no, no, no. That is not the lesson. If anything, during review, most of the responses are going to be “Write more comments.” So in a sense, actually, what you said is true. The best contributions to GHC would have no comments because the code would be so self-evidently correct and beautiful that they wouldn’t need comments. That would be the best contribution. Getting to that point seems hard. Programming is a hard thing. And it seems very hard or impossible to immediately come up with the beautiful, elegant algorithm that needs no comment. There always needs to be the awkward, heavily commented algorithm first. And then over years of people reading the comments, someone’s going to say, “Oh, you could just rewrite this in five lines much more simply.” And that happens, but it never happens first. Or I guess maybe it does, but then we never talk about it because that was easy. So there’s no need to comment on it.

*NV [0:45:38]*: Can you remember a story or an example of that happening?

*RE [0:45:42]*: Well, this current one, this refactor is, although the new code is not simple, the new code is quite complicated also. So we haven’t quite gotten to that story. I don’t have a great answer to that. I know there’s been a number of times where Simon and I have debated problems for hours in calls and that the solution is one or two lines of code that we just changed this one thing right here to change this one key relation in the type checker. And then we know that that’s going to make everything work. But it took hours to discover that that was the right change. And then five screenfuls of comments about the one line of code, which is for maybe the inverse of what we should be doing, but sometimes it’s just where it is.

*NV [0:46:22]*: Cool. How is it working with Simon?

*RE [0:46:25]*: Oh, it’s a joy. I mean, he’s really fun to work with because he just has such an encyclopedic knowledge of how all of these things work. It’s not just knowledge; it’s knowledge and deductionability in that if we’re talking and I was like, “Oh, well, what if we did this,” instantly, he’ll respond with, “Oh, well then that will cause these five things to happen. Do we want all of those five things?” And it’s just his ability to do that just really sort of speeds up development and it’s just a ton of fun.

*NV [0:46:56]*: I think we are approaching the end and usually we ask the guests to tell us what they want to see in Haskell in the future or what they don’t like in Haskell. And I mean, I think you are special on that because somehow you can affect more what it’s going to be there. So it’s not just the desire, but also your future plants on Haskell. So what do you want to see or remove?

*RE [0:47:24]*: So my answer to that is going to be probably something that people don’t expect. But a few years ago, I wrote up this local modules proposal that describes a way to-- an OCaml programmer would think this is not modules. This is really local namespaces, but it goes a lot in this direction. This was before I had anything to do with OCaml. I think especially now spending a lot of time programming in a language with a richer namespace system, I think it would make a really big difference to Haskell to have an ability to control namespaces better. I still think the design in that proposal is good. The current state of it is that it’s kind of an abandoned proposal because I put so much time into it and it still wasn’t quite ready. So right at the end, there was an objection saying, “Oh, in this one corner case, this formalism that you’ve described doesn’t quite handle this corner case,” which was absolutely true. It does not handle that corner case. The formalism is insufficient. Fixing it would require a rewrite and I’d already invested too much time into that, and I wasn’t sure anyone was really going to sort of take the torch from me on that. So I ended up walking away from it. But I think that coming back to that, it would just make the language so much more pleasant to program in. And it would be really interesting to see someone take that on.

*NV [0:48:32]*: The module.

*RE [0:48:33]*: Yeah. But to be clear, the proposal is called Local Modules. It is not proposing OCaml-style modules. It is just proposing a sort of finer namespace control. The OCaml module system with its functors I think is more than Haskell needs. Haskell has type classes, which it’s a really different solution to the same kind of programming problem. But we have it, it’s good. We don’t need to switch over to the full system. We just need better namespaces.

*NV [0:49:00]*: Cool. Thank you very much.

*RE [0:49:04]*: Yeah, thanks very much. This was great.

*MP [0:49:06]*: Thanks for the chat.

*Narrator [0:49:10]*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the support of our sponsors, especially the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and Meta.
