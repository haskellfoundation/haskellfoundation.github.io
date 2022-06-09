_Alejandro Serrano Mena_: Hello. Welcome to another episode of the Haskell
Interlude. Today with my co-host Wouter Swierstra we have David Christensen,
the new director of the Haskell Foundation.

_Wouter Swierstra_: Hello.

_David Christensen_: Hello.

_AS_: I'm very happy that you're here. We often start this conversation by
asking our guest "How did you get into Haskell?", but I would say in your case
we'd also ask "How did you get into this world of functional programming?"
because you've actually been touching many different aspects of these
different communities.

_DC_: So, when I was learning programming I first learned to program when I
was a little kid on the BASIC that you got when you booted up computers at the
time without a DOS disk inserted. But I never really was particularly serious
about it until sort of my late teenage years. And, as is typical for someone
in their late teenage years, I really wanted to sort of have things to believe
in. So I bounced around a bit between programming ideologies and I was like
"Yes, Smalltalk will be the future" and things like that for a while. And,
eventually, I developed relationships sort of with two programming language
communities over time -- that being the Lisp and the ML traditions of
functional programming. And, you know, both of them made a lot of claims about
math and things like that. But I wasn't in any real position to assess those
claims and weigh them on the evidence. But it appealed to my emotions and I
kind of kept doing them. I first encountered Haskell by reading the so-called
"A Gentle Introduction to Haskell" that was floating around back then in the
early 2000s. I say "so-called" because it was somewhat less gentle than its
title would lead you to believe. I remember spending a lot of time being very
puzzled as to what was going on and trying to convince my professors to let me
write assignments in Haskell when they really wanted me to do it in C++ and
that kind of things. Then I graduated, I actually ended up with having a
degree in philosophy rather than in computer science for various reasons. I
kind of did other work for a while: I did some database development, I filled
up printers with papers, and I always thought Haskell was fun and I tried to
participate in the ICFP Programming Contest a couple of times -- never did
all that well. Eventually I got a little bit bored with the jobs I was doing.
I lived in Copenhagen, and in Denmark the society really does care that you
have the right degree for the job you want to get. And my background in
philosophy and the fact that I only had a Bachelor's Degree -- which is not
considered a sort of standard degree to finish with in Denmark --, meant that
it was time for me to go and study again if I wanted to be qualified for other
jobs. So I went to the University of Copenhagen and managed to very badly fail
the Category Theory class in my first semester. I bit a little bit more than I
could chew. But I was sort of interested in the research side of the
university and eventually I ended up getting recruited into a PhD program. And
from there I could basically work with what I wanted to work with and, you
know, attack problems from interesting angles. And so I did some work with
Scala and also with Haskell and I eventually started working on Idris while I
was a PhD student. That was written in Haskell and was a great opportunity to
actually learn Haskell properly.

_WS_: So, what did you do your PhD on? Because you mentioned Idris a little
bit but that's, I think, what I know you from the least.

_DC_: Yeah, so funny enough, when I started my PhD project I didn't think that
I was going to be working on type theory or programming languages or sort of
that style of programming languages at least. The original plan was that I
would be helping develop a domain specific language for representing life
insurance products and pension products such that we could compute with them
on GPU and generate solvency calculations that would live up to the EU just in
time for the Solvency II regulations which came into effect after the
financial crisis. From there, I've been reading a lot about type systems and
such. I though, well, actually, you know, "money today doesn't have the same
value as money tomorrow". So shouldn't my type systems catch me if I forget to
discount it? So I thought "what if I index the currency type by the time?" and
then I started getting into a little bit of a rabbit hole. Then I went to
summer school, because that's something that PhD students in Europe do quite a
lot. And Edwin Brady had a class on Idris there, which was a fairly new
project at the time. And I remember sitting in this room in St Andrews trying
to do my homework and being very very frustrated that there was no tab
completion at the REPL. I thought "I could do this! I know functional
programming!" and that's why I implemented tab completion for the Idris REPL.
I thought that was pretty fun. And I started working more and more on it and
eventually that's what I ended up working on. So I ended up being in a
combined Master's and PhD program and my Master's thesis was essentially how
do I put `unsafePerformIO` in the Idris type system, packaged up in the sense
of how can we use this to do something like F#'s type providers. But rather
that doing compile time code generation, just running IO actions and then
computing types based on the result.

_AS_: So, maybe going one step back. We've mentioned Idris and I don't know if
everybody knows about Idris. If you can give us, you know, a couple of hints
of what it is and how is it different from Haskell...

_DC_: Sure. So, Idris looks a lot like Haskell on the surface, except it uses
`:` instead of `::` to separate types from the things that they describe. On
the other hand it's got strict evaluation and it has what we call full
dependent types. And that means that there is no fundamental difference
between types and other kind of things you can have in your program. So you
can write a function that returns a type, you can write a type that contains a
value. And, just like in Haskell you can have, you know, a list. And the list
is parameterized by the type of things contained in the list. And, the classic
example that you always get in these tutorials on dependent types is that you
can have a type of list that also tells you how long it is. And then you can
make the signature of `append` not say just `[a] -> [a] -> [a]` but it might
say "list of `a` with length `n` `->` list of `a` with length `k` `->` list of
`a` with length `n + k`. And that `(+)` is the very same `(+)` that you use to
add numbers at runtime. But here we also run it at compile time, during type
checking. This allows you to use your type checker essentially as a logic.
Your type systems becomes an expressive logic that you could use to encode
essentially arbitrary mathematical statements and then you get the nice
property that the programs that inhabit these types are then proofs of those
mathematical statements. So the fact that you can write essentially whatever
math you want means that you can use these dependent type systems to do
mathematics where the machine is making sure you don't make certain kinds of
mistakes and can also help you out in doing certain boring things. It also
means that you can encode pretty interesting stuff about your program in the
type signature and it becomes much more convenient to do so than if you have a
language that wasn't designed for this from the get-go. So you can talk about,
you know, terms that by construction are well scoped and then your scope
checker could emit a guaranteed well-scoped term from a term typed by a user,
and also a proof that it corresponds to it in the right way. You can say that
a sorting function returns a permutation of its input that happens to be
ordered with respect to the given ordering. These kind of things are pretty
fun but I actually think that the most fun part about dependent types is not
so much that you can do all this -- this is what you write on the grant
application to get people to be interested in it, people interested in things
like correctness and security, because these are important things. But, what
really grabs me is that you can also use it as part of enabling a different
kind of dialogue between the programmer and the compiler. If I am able to
express my desired very clearly to the computer then the computer is then in a
position to help me fulfill my desires. So, going back to the example of the
lists with their length in them, if I'm trying to write that function and I'm
maybe not very used to the language yet, yes, it's great that it is going to
rule out the thing that always returns the empty list. But it's also pretty
nice that while I do a case split and I can see I got to cases, one where one
of the list is empty and one where is not. In the case when it is empty we
know that its length was 0 and then we see that the length that we need to
return is actually the length of the other argument and the computer can pick
it for me and it usually picks it right. So, this is pretty fun, and we can
also get more informative error messages. If you look at what I did back when
I had time to work on Idris, I did things like make it so you could right
click on a type in an error message and expand all the type synonyms. All of
this interactive stuff, I think there's a lot of untapped potential there
still. There's a lot going on in various language communities that's very
interesting but I think we still have space to do a lot of really cool stuff
that we haven't done yet.

_WS_: Yeah, so you're saying types are more like a specification and then one
you write this down you have this type-driven development where you're
thinking about the types which then guide the program itself one you have a
precis amount of types.

_DC_: I don't think that the program write itself. I think that that's a bit
of an overstatement of the case. Because there's always a balance on how
precise you want to make your type and still have it be useful. There's a lot
of software engineering concerns that are still relevant like modularity and
things like that that you can hurt by having a type that is precise in the
wrong way. But trying to write down an informative type, failing to write the
program, is a really good way to increase your understanding about what should
go on and then, even if the program doesn't write itself, the boring parts do,
and that's pretty fun.

_WS_: I think there are a lot of example of where if you think like about a
`map` on vectors or these length indexed lists. There are many different
implementations of functions which have that type signature. But there's like
one obvious one and then having a specific type can actually help you uncover
the obvious one that is the one that you are looking for.

_DC_: For small examples I think that's true, but for larger programs it's
less true.

_WS_: Sure, I can see that.

_AS_: Speaking about dialogues you have also written one of these books in a
dialectical style, "The Little Typer", following the tradition of "The Little
Schemer" and so on. I have to say I was puzzled because I have read "The
Little Schemer" which is like a thin book and then "The Little Typer" is kind
of a bit bigger. But I mean you also get more information in return, right?
So, I was wondering how that came about. I mean, I've always felt like
dependent types was a very niche thing and this is taking dependent types from
the perspective of a Lisp programming language then getting all of this
written down. So I'm really wondering how did all of this came out?

_DC_: so the way that it came about is that Dan Friedman, who's one of the two
authors of "The Little Schemer", had been getting interested in dependent
types for a while. At the time when all this was getting going I was doing an
internship with Galois, during my PhD. One of my colleagues there, Adam
Fulzer -- he knows Dan pretty well, he grew up in Bloomington --, he knew that
Dan had these interests. He met me and knew that I had these interests and he
thought "I think these two would get along" and he put us in contact with each
other. Then we met up in one of those conferences and we had some dinner and
we thought "let's do this" and Dan was interested in dependent types in part
because of this interesting correspondence between programming and proving and
that always intrigued him -- is where he can connect math and computer science
and logic and things like that. He's a big fan of the early 20th century
period in logic and all the interesting foundation stuff that's happened
there. He does a lot of reading about those things. And you mentioned that
"The Little Typer" is much longer than "The Little Schemer". This is true, we
tried to make it shorter. So, "The Little Schemer" is not a book about Scheme,
it's a book about how to teach you to think in recursion. And "The Little
Typer" we wanted to have a book where if you read everything and understood
everything you emerged having what I think is a basic level of understanding,
you are now equipped to go and do other things with these ideas. I think that
in order to do that we really needed to do some things that just required some
space. The bar we set was that you can prove decidability of equality for
natural numbers. And "The Little Typer" is really a book about the core ideas
behind something like Agda or Coq or Idris or Lean, rather than how to use
them to do practical things. The most practical thing we do in "The Little
Typer" is determining whether a number is even or odd. And that's not so
practical. But we really tried to show what are the foundational ways of
thinking that will allow you to understand the kernel of a system like that.
We didn't think that there was another good resource out there for this,
unless you had a really heavy math background. We wanted to do this for people
who, you know, they knew how to write a program, they did some programming,
maybe they read the first two thirds of "The Little Schemer" so they'd seen
some lambdas and some recursion. But we didn't want to require you to know a
ton of stuff because there's already books that do that and we think that if
you look at it the right ideas don't require all those other apparatuses.

_WS_: And, in hindsight, do you feel like the book was a success? For me, I
appreciate the point that you're making that many of these books on dependent
types or type theory or even books like "Types & Programming Languages" which
are meant to be graduate level courses on PL, they still require pretty heavy
reading in a way, right? It's not something that I would take with me on a
desert island. So that's what I like about the project. But at the same time,
if I'm critical, I sometimes wonder, is Scheme really the best language to
bring these ideas across? Or, how do you feel looking back on the book?

_DC_: Well, there's really hardly any Scheme in the book to be hones. At
various points in time, we make references to a shared cultural understanding
amongst Scheme programmers and make jokes about notation and that sort of
things. But, the language used in the book is one that we came up with for the
book. And notationally it does have lots of parentheses and it puts the
operators first in an expression rather than at some arbitrary point in the
middle. But, aside for that, it's actually much more like the core language of
something like Coq than it is like Scheme. And, whether or not you like
parentheses I think it's mostly a matter of taste. We discussed whether we
wanted to use parentheses or not, we had really hoped to have a complete
implementation of the language as part of the book. That was sort of an early
goal that we had. Using the parenthesized notation allowed us to skip writing
a parser and so that was one practical reason why we did it. It ended up being
that the implementation couldn't fit it in -- the publisher gave us a maximum
number of pages and we looked at the chapter we'd written about the
implementation and said "well, looks like we have to transcribe all of this to
a bunch of inference rules because we can't actually fit the whole thing". And
that's something I'm a little bit sad about. But I think the question perhaps
rephrased could be "Does it make the most sense to use an existing language to
teach this or to come up with our own little language?" And there, the reason
for coming up with our own language -- because we did talk about using Agda --
is that existing languages are designed to get the work done. That means they
have lots of automation, they have a lot of things that do work for you. And
we wanted to make people work, because by making them do the work that the
computer would do in a real implementation, they'd then seen what that work is
and perhaps come to understand it a little bit more.

_WS_: Sure.

_DC_: I don't think you should use our language for anything practical.

_WS_: I'm not debating that point.

_DC_: Yeah, that's our thought process.

_WS_: I can certainly see that taking any dependently typed language, whether
is Agda, Coq or what have you, you immediately inherit all the historical
baggage and notation and all of that. Which is maybe not something you want to
get bogged in if you just want to get the ideas across about type systems and
dependent types.

_DC_: Also, most of those let you write recursive functions and we really want
people to think in eliminators. And that means getting you off of the habit of
writing explicitly recursive functions. I think, today, if we were to start
the project again, it could be interesting instead of implementing the
language by hand the way we did to implement it in Lean 4's macro system
because the kernel of Lean 4 is all based on eliminators. I think it would be
reasonably within the realms of an acceptable amount of work to create an
alternative frontend language that didn't have the features we didn't want.

_AS_: So we mentioned several other dependently typed languages like Agda,
Lean, Coq, all of those. But how do you fell as a way to approach for those
people who are learning the dependently typed part of Haskell and want to
understand this kind of things you are mentioning, like how to encode vectors
with their length and those kind of things. Do you think "The Little Typer" is
a good approach? Do you think that there is maybe a different approach which
would be more beneficial to people who already know Haskell and want to jump
into this background.

_DC_: To be honest, I don't know what the best resource is. I think "The
Little Typer" could be relevant if you want to understand the ideas and the
ways of thinking that are behind dependent type theory. That may or may not
help you if your goal is to work on a codebase that somebody has written in a
sort of dependently typed Haskell style. I have worked on such code bases and
I always found myself sort of writing Idris in my head and kind of hand
compiling it to a Haskell encoding. So I would actually learn to use one of
these existing languages in which dependent types are sort of first class part
of the language, designed in from the start, where it is more convenient, the
error messages are designed with that in mind, and where libraries are
designed with that in mind. And then, go back and think about yourself as
encoding things as Haskell becomes more and more convenient over time. There
may be a really good written resource but I didn't get there by that route, so
I don't know what it is.

_AS_: So it's interesting because it mimics a bit my experience that when you
start with simple Haskell, you don't really need to understand how the type
system works too much -- it just kind of works -- but as as people progress it
seems that you really need to understand the quirks of the type system.
Especially in Haskell, because, as you're saying, we sometimes more than
writing things down, we write them in our heads and then encode it in Haskell
as we can because the type level is not as expressive. So do you actually
think this will maybe lead to Haskell working in that direction, moving into a
way where you don't have to encode things but really write what you mean?

_DC_: I know that there are active members of the community who want to make
that a reality and I hope that these things become easier to encode. Because
people are going to be encoding them so we might as well have clear code bases
instead of confusing ones. I don't know whether something is to be said for
not being too fancy with your types when writing Haskell code. I think that
Hindley-Milner plus higher kinded type plus type classes is popular for a
reason which is that it's got a lot of nice properties and it's nice to work
in it. I think it's okay, it's like an old settings dialog box. You had to
like check the show me the advanced options dialog box. I think it's okay to
have these things a little bit off to the side because I think of them today
as sort of being kind of specialized tools for specialized contexts. I hope
that they become more pleasant and fun and that we can use in more contexts
and that more people can use them. But I don't know for sure what's going to
happen, I mean that's why they call it research.

_AS_: So now that you mentioned the check thing, this resonates with our
`#LANGUAGE` pragmas. Maybe you're thinking about Racket language levels, given
that you've also made your fair share of Racket, right?

_DC_: Yeah, so like I mentioned earlier my two great loves of programming
languages have been the sort of the broad ML tradition (including Haskell) and
the broad Lisp tradition. I played around with some of these things for a
while but I never had a lot of chance to get deep into them until I was lucky
enough to do a post doc with Sam Tobin-Hochstadt at Indiana University.  There
I really got to dive deep into the world of Racket and there's a lot of cool
stuff going on there. So the feature you're talking about is that every
program in Racket starts with a line which says what language it's written in
and then the implementation uses that to go look through the installed modules
and say "hey, you know this program says it's written in Racket, so how do I
parse Racket? Okay having parsed Racket how do I then interpret the resulting
parse tree?" This means that if you're willing to write `#lang` and then
whatever the name of your language is at the top of your file you get the
ability to write whatever you want. And this has been used to great effect.
There's Datalog with its own syntax. I saw an interesting demo where someone
made an embedding of Java so you'd write `#lang Java` on the first line and
this was right down to getting like rename refactoring working in the editor,
was really cool stuff. This is what we used for Pie in "The Little Typer".
There we were able to reuse the Racket parser because of our parenthesized
syntax. And it's got enough knobs that we can tweak, that we could change the
details of it to fit our language. It provides a really nice infrastructure
for doing all sorts of things. I think that the Haskell community could
actually learn quite a lot by paying more attention to what's going on over
with Racket. So, in addition to this language feature where you have a
collection of coherent languages all built from the same parts, there's also
the documentation system. So, in Racket they have this documentation system
called Scribble -- there's an ICFP paper about it from a few years ago. The
way it works is, first off you start your files saying `#lang scribble` -- of
course, because your documentation is also a program. Then you have this
markup language which is really an alternative concrete syntax for all of the
constructs of Racket. And then it has functions in scope for doing things like
bold text, hyperlinks,... But it also allows you to write your own functions
so you could say "I'm going to write a something for describing context free
grammars because I need that for this library that I'm documenting". Then I
define my context free language description sublanguage and it's just ordinary
code, I save it in the modules however I normally would, I can import it from
a library the way I normally would, and then I can consistently produce
context free grammars anywhere in my documentation where it makes sense. And
you could do the same thing for commutative diagrams. If we had something like
this for Haskell, it would be cool. Another thing that I think the Racket
community gets really right is that the project's history in education has led
to it being very very easy to install by people who aren't well versed in
commandline. You download a package, you install it, you get a functioning
environment immediately. You can open it up, you can type in a program, you
don't have to go create a project which is then configured with a list of
modules and a license and a description just to be able to write `Hello World`
and have it work. And you don't technically need to do that in Haskell but
really my default workflow if I want to mess around with an IDE in Racket is
that I open up a file and I type in some code and it works and then from there
on I can start, if it becomes like an idea that's got some legs, I can make a
project and I can declare like library dependencies and all that stuff. But
there's this really nice sort of on ramp from poking at a thing to having a
thing that works without a lot of bureaucracy and overhead which I really
really appreciate.

_AS_: Ah, something I've also seen when I've toyed a bit with Racket is that
the default environments have all these super powerful features for like
refactoring and seeing where things are scoped and all of that and I always
found this interesting because, you know, we often say one of the virtues of
Haskell is because of the types all these refactorings and so on will get
better but actually it feels that Racket which by default is more of an
untyped language does have better features. So I was wondering whether you
think this actually doesn't have to do with the language but with the editor
or what are your thoughts on this aspect?

_DC_: I've been talking about this essay a lot lately. So, Kent Pittman wrote
this essay back in 1994 called "Lambda, the Ultimate Political Party" and it's
mostly about Lisp standardization efforts that are not particularly relevant
except as an item of history but he has this nice thought experiment. So what
he wants to demonstrate with this thought experiment is that the most
important thing about a programming language is not its technical qualities
but rather the values of the community of people who it coexists with. So this
thought experiment is like let's take the C programming language and we'll
give it to the Lisp community and we'll leave it with the C and Unix community
and we will let them talk to each other and in 10 years let's come back and
check.  And what do you think will have happened to see in those two and the
way it evolves in those two communities? What we were supposed to conclude and
what I would conclude is that clearly like C is going to have developed
deliver and control operators and a garbage collector and all sorts of cool
stuff on the Lisp side whereas on the Unix side it'll have continued to be
doing mostly what it's doing today because that serves the values of that
community. Likewise, I think that the nice environment for Racket is in part a
result of community's values largely coming from people who are teaching new
programmers how to program and taking that very seriously as a task. And that
orients your work in a certain direction. It means that you don't do things
that cater only to experts, it means that oftentimes you make tools that are
worse for experts than for beginners, and this really shines through in the
immediate accessibility of a lot of that stuff and the fact that it's
maintained over time. Like there's been a lot of interesting work on making
refactoring tools for Haskell. They just tend to bitrot over time because you
know the grant runs out and it's not really where the core values of our
community have historically been. I think that's starting to change, right? I
mean HLS has gotten really impressive lately. It used to be, in the old days
there was `ghcmod` -- which you did some cool stuff for, Alejandro --, but it
would with every GHC release, it would take a while to get updated, because it
wasn't like a core thing that that the community was behind and HLS really is.
And that's been really great to see. I think it's a sign that we as a
community are beginning to recognize that having a great language is not
enough. We need great tools and our great language. And a great language can
in theory enable great tools. But you got to put in the sweat to make it
happen and just keep the grind going to maintain it over time and also set up
your community such so that you make it easier to keep those things going over
time.

_WS_: I can certainly see for the Haskell community: it's gotten better,
right? I mean I remember when I learned Haskell it took a PhD student a week
to build GHC and nowadays at least we have like Haskell Platform and you can
just download things and GHC is usually in the package manager on your distro
and this is not as bad as it has been.

_DC_: We even have `ghcup`. `ghcup` is wonderful.

_AS_: I agree.

_WS_: But at the same time there's always this tension between doing exciting
new things in the type system with dependent types versus having a double
clickable installer which comes with an IDE which works out of the box to lure
beginning programmers into you know, getting a turtle to draw graphics on your
screen or whatever.

_AS_: I actually think like this that's not it. So what I always wonder is,
okay, you have the beginner experience, that's one thing. But for example, if
you look at other, I'd say, more industrial communities -- you look at Java,
Scala, all of that -- there is sometimes a lot of work being put by the
community into making their tools great and having yet another Eclipse plugin
for doing this and that. And people seem to enjoy doing this. So I think it's
not only the camp of beginners and the camp of people writing grant-like
things. Why having these tools is not such an exciting thing to do for the
Haskell community?

_DC_: I actually don't know the answer to that. I mean, I really like working
on tooling and that sort of thing and, for a while, for immigration reasons, I
had to commute between Gothenburg and Copenhagen every weekend when I was a
PhD student. On that train ride I could have been doing things, I could have
written a paper about something, but instead I'm like "Let's make
right-clickable error messages". So I've always found sort of tooling UI stuff
around programming languages to be highly motivating and interesting.

_WS_: Well I mean I can certainly see, speaking as an academic, one of the
things I notice is that you have a clear incentive to publish ideas.

_DC_: That's right.

_WS_: And I spent some time in industry and one of the things I've realized
was how big the difference is between something which kind of works on my
machine I can write a paper about and the ideas are solid versus something
which is a product which someone else can use which is documented which has
all the features which people are expecting and so forth and really adds value
to an end user. The same is of course true of programming languages. It's easy
to come up with a new programming language and to draw a whole bunch of
inference rules and to have a prototype implementation and then publish about
this versus here's a package manager, here's the reasonable error messages,
here's all the other stuff which kind of comes with programming language
development as well.

_DC_: I don't think it's easy to come up with a programming language and write
down a bunch of inference rules and get a paper published. Actually I think
that's pretty hard. But I agree that it's a very different kind of difficult
and that it requires a different attitude and different skills and a different
way of looking at things. And there are people who are good at both but it it
certainly is a separate collection. But, like I said earlier, I think the
Haskell community, for whatever reason, has been less interested in these
things historically. Maybe it's because we had the idea that if the
programming language is good enough then all those other things become
irrelevant. I've heard people say that but I don't know how representative
they are. But I think that we're seeing this is changing. I mean we have HLS,
we have `ghcup`, we have people putting a lot more work into error messages
and error handling and tool support. I think we're going in the right
direction.

_WS_: So if I look at your career, though, I think you've kind of switched
back and forth between more academically oriented positions versus more
industrial positions. Kind of in the last few years you spent time in industry
working at Galois and Deon Digital and then you've decided to apply to
be director of the Haskell Foundation. So what triggered that switch?

_DC_: So the first of those switches, toward the end of the postdoc I realized
that if I wanted to have a chance in academia I'd have to be willing to move
all over the place for quite a while, I'd almost certainly need another
postdoc, work really hard on cranking out a lot of papers, and that seemed
less conducive to familial happiness than getting a job and living in one
place for a while and all those things. So I had an internship at Galois -- I
essentially wrote to them and applied and then went there after the postdoc. I
had a great time at Galois, I was treated very well, I got to work on a lot of
interesting things. But after we had our daughter, we thought we want to come
back to Denmark and for various reasons it was difficult to work remotely from
outside the US for Galois due to contracting requirements and those kind of
things. I looked around a bit and that's how I ended up working at Deon
Digital where I was mostly doing programming language tooling for an in-house
DSL which was tons and tons of fun. I'd probably kept doing it but then I was
encouraged by multiple people to get in touch with Haskell Foundation. I
thought "well, okay if a few people get in touch with me and say you should do
this, then I should take it seriously". In talking to members of the board and
the previous executive director and the previous CTO and a bunch of other
people who are sort of associated with and who volunteer with the HF, I
thought "well, here's a pretty rare opportunity to come in and help out this
programming language community that I've been a part of". I've seen ways that
Haskell has contributed a lot of value out in industrial positions and I've
also seen times that we had to retreat from a Haskell position -- for example
at Deon Digital we had to rewrite some of our Haskell code in Kotlin because
we needed to run on a JVM for various reasons. I've seen, I think, the
positives and the negatives, I have some experience there at least, I think I
have a reasonable technical background and I just really care a lot about
Haskell and I really want the language and its community of practitioners to
succeed in new ways that we haven't succeeded before. I thought "okay, well
I'm gonna give it a shot".

_AS_: So do you have any specific goal in mind? For the short, middle term?

_DC_: Yeah. So I've been at the job for a week as of today. So my first
priority is just to figure everything out. There's a lot of turbulent energy
surrounding the HF and a lot of people doing cool stuff. My first thing to do
is just get it all into my head so that I can have some sort of an idea about
it. But in the sort of shorter to medium term the first thing I want to do is
find more opportunities where different parts of the community who could be
collaborating don't know about each other and put them in touch, to find
places where we can focus our efforts on something and just get it done. So
there's this thing that we have in the United States which is called a barn
raising which is where a rural community all gets together and builds a family
a barn in a weekend. You make a big party out of it and the thing that would
have been a completely difficult task for one person to get done as a group
you can actually crank it out pretty quick. So I've been thinking of trying to
find a couple of places where we could organize like a weekend event with a
similar energy to the ICFP contest and maybe get some work done on some aspect
of GHC where you don't have to be deep into the compiler or some aspects of
some core libraries. This is something that I'm talking to people about and if
anyone's listening to this podcast and has a great idea, please get in touch.
I'm David at `haskell.foundation`. I'd also like to find/figure out where
people who are interested in working on projects of key importance to the
Haskell ecosystem don't end up doing so and remove those obstacles. I think
that those obstacles can be everything from you know, `ReadMe`s that can be
spruced up a bit to doing some issue triage -- I'm happy to sit down and do
some of that as time permits -- to identifying things or putting people in
contact with mentors. As you've heard I'm really into programming tooling and
if I can find ways to enable the people working on tooling and user
friendliness and new user accessibility of Haskell to keep doing what they're
doing well I'd really like to do that. And then, of course, a big part of any
nonprofit is fundraising and I'm going to be spending a lot of time trying to
find the best ways to strategically invest in the projects that we all rely on
to make our ecosystem stronger so that it can support more of us so that we
can get more done with it.

_AS_: It's interesting. Because when I think of Haskell foundation I always
kind of have this idea of technical stuff being done. But what you mentioned
is mostly kind of opening communication channels or putting people together to
make the work done.

_DC_: So my role at the Haskell Foundation is that of executive director and
that means that I have managed to be promoted into management and I'm not
writing code anymore -- the nightmare of everyone. But we don't have the
budget today in order to hire a lot of people to go out and do a lot of
technical things. But we do have the budget to have a role in the community to
help the people doing the technical work get unstuck, to provide resources
where it's necessary, to help things work better. And over time if we manage
to get more sponsors, if we manage to get more resources, we can then also
directly pay for more work, which I'd like to be able to do. We do have
somebody who's starting to do devops work for GHC as an employee of the
Foundation or actually as a contractor for the Foundation very soon. I'm
really happy about that. This is an initiative that really came from
grassroots around the Foundation and it went through our technical proposals
process and that's where a lot of that work is going to get done and it really
is a thing that we as a community should do. I mean the Foundation is here for
Haskellers and I hope that we are something that all of you feel like is
yours. We don't want to exist as a separate entity that's pursuing its own
goals and dreams. We certainly will have some restrictions that are imposed by
the fact that in order to keep operating we need a budget, we need to live up
to the rules that surround nonprofits -- because by living up to those rules
we gain the ability to coordinate the use of resources in new ways and we
become a place where those who live off of Haskell can invest back in the
ecosystem. But at the end of the day we're here for the community and my job
really is to find ways to serve the community and I think that I do that best
by working on ways to get people together, by unsticking communication, by
easing in the onramp rather than by sitting down and writing code.

_WS_: So I think one of the challenges for any programming language is if you
want to improve the language where does the money come from. Historically
Microsoft of course has put a lot of time into funding Simon and Simon to work
on the language. Since then GHC has spun off into more of an open source
project and you have a bunch of these smaller kind of projects like HLS or
various other tool support -- Cabal started very much as a grassroots thing by
some of the open source people interested in this, and then Stack has been
kind of pushed really hard by FPComplete. So there's all kinds of different
people kind of involved in this. Have you looked at how other kind of similar
languages have grown and flourish? Because the typical model is that you have
Oracle backing Java or Microsoft backing C# and F# to sum at least .NET. So
what's the business model for growing a programming language once it kind of
has gotten to the point where it can no longer be maintained by just one
academic?

_DC_: So I think the closest place to look is Rust. The Rust community has
done a great job of applying principled programming language design to
interesting problems. They've done a great job building a community that is
welcoming and that is authentically run by members of the community and so I'm
definitely paying close attention to what they're up to. I think that for now
we have this model of getting sponsors and people who want to support the
further development of Haskell, and also of keeping authentically connected to
the rest of the community. I don't know what the business model is. I don't
know that we can apply anything from any other programming language because
Haskell is not like most other programming languages. We have a different
culture than most programming language communities that I think is a little
bit more anarchic and individualistic and basically we're going to have to
make it up as we go along and keep our heads above water and do our best to
keep things going. Today there are people who are paying for the further
development of GHC and its surrounding infrastructure like the Haskell
Foundation is able to put money into that. We've had direct donations from
companies. There are others who pay for maintenance on GHC without being
involved in the Haskell Foundation at all because their business uses it and
they want things to work better. So it's not that we don't have any income.
It's more how can we find ways to direct resources from those who are getting
a value out of Haskell into Haskell getting even better. I don't know what all
the answers are. Again, David at `haskell.foundation`.

_WS_: Sure, of course, and I mean you've only been on the job for a week. Just
to clarify by business model I don't mean how do you make the Haskell
Foundation profitable but how do you make the language better and somehow
unite so many different projects and libraries and individuals who've all done
amazing stuff and somehow bring that together? I think that's like the real
challenge for the Foundation.

_DC_: Absolutely, absolutely. Yeah, it's a big challenge.

_WS_: You don't have to have the answers now.

_DC_: No I don't have them all now.

_WS_: We won't hold that against you of course.

_DC_: Yeah yeah, and it's also important that we don't come in and try to take
people's projects away from them, that we don't come in and tell people what
to do. Because almost everyone working on Haskell is doing it because they
want to, because it's fun. People have jobs, those jobs pay them, those people
who pay them often get to say what they should do. That's not how it is when
they sit down on the evenings and weekends. So it's great if we can make it
more fun and more rewarding to participate in larger structures and make
things that are useful for more people than oneself. I find that rewarding
personally. But at the end of the day people are going to do what they want to
do.

_WS_: Sure.

_AS_: So one thing I also wanted to ask because you've mentioned what the
Haskell Foundation can do for the development of Haskell and the users, do you
have any goals into promoting Haskell? I mean, in other languages communities
there is always this kind of publicity/promotion workforce which is all about
how you get people to use the language more and now you grow your community,
you grow your user base. This seems weird to me that it is always out of the
way, it feels like we Haskellers don't like to do marketing. But it also feels
weird that even the Haskell Foundation is kind of shy in a way, until now, to
do this kind of work.

_DC_: I think that we should be a little bit. So one thing to realize is that
the Haskell Foundation is not very big and that there aren't that many people
in official roles. And that most of those who want to volunteer don't want to
do it on writing publicity posts.

_AS_: Yeah, right. I mean it feels weird to me that out of all these people
and all these different committees -- and you have communities to make this
library better -- there is no one such thing. No grassroots, sort of desire to
to do this promotion or marketing thing.

_DC_: That's right. That is interesting. I'm not actually sure why that is I
think. I think part of it is just the Haskell community's value, sort of going
back to "Lambda, the Ultimate Political Party". I think there's a certain
contrarian non-commercialist streak to parts of the Haskell community -- I
think that if you are walking into a room full of Haskellers and you know
saying you work in advertising you're less likely to have intrigued people and
more likely to be rejected than in some other communities that I've been a
part of where they might say "oh, that's interesting". This is part of our
community values, I don't know whether it's a value that's helpful for us
always, but it is how many of us, at least historically, have worked on
things. I think a lot of us have seen things that are promoted that are not
fit for purpose and there's also a feeling of personal integrity sometimes
where you want to make sure that you're sort of being strictly honest in all
of your promotion and that you want your good results to speak for themselves.
And good results don't speak for themselves in the world as it actually is,
because our attention is a finite resource.

_WS_: Yeah. In Haskell, I think one thing I appreciate about the community is
that despite everyone's differences, everyone wants the language to succeed
and they want to change the language for the better and that's kind of
something which has unified so many people. Where it sometimes starts to rub
is that people think "I can agree that this is a good thing but it will break
all my code" -- we have this discussion about fancy types, which I know people
are super enthusiastic about. But I also know people who are like very
hesitant who's kind of been bitten by this and said "well, you know once I
start writing type families and template Haskell all my code slows down" or
"the compile will no longer compile if I change this one thing". So there's
this constant drive and the language is not like one static thing. It's this
evolving monster, I want to say, but that sounds too mean.

_AS_: Well some some error messages can be can be a monster.

_WS_: No, it's an ecosystem right? Which is where ideas flourish and die out
and then somehow managing that is a huge challenge, pushing it in any
direction, right?

_DC_: That's right. I think a unique aspect of the Haskell community is that
we include both full time programming languages researchers like you, and
full-time programmers like me a month ago, and a lot of people who do it for
fun, who work on it for fun, a lot of people who wish they could work on it
for fun. We're a very broad community for our relatively small size. And this
actually is a source of friction and a source of strength as well, I think.
Because we actually get to find out "oh hey, this this cool thing that we
thought we had solved in this research paper actually doesn't work in this
other context" by having real users who are using the language on a larger
scale than you get from a little research language.

_WS_: Sure.

_DC_: On the other hand it absolutely makes things tense sometimes when you
have to prioritize the needs of a very diverse group of people with very
different interests and that is a thing that we need to manage.

_WS_: Yeah, for sure.

_AS_: Ok, so David, thanks so much for your time. Is there anything else you'd
like to mention now?

_DC_: Sure. When I'm not working on Haskell I've been moonlighting as a
technical writer and I've been working on a functional programming book using
Lean 4 and I think that the Haskell Community, just like we should go take a
look at what's going on in Racket, we should also go and take a look at what's
going on in Lean 4. Just as a little preview, the `do` notation lets you have
mutable variables and return early and I know that'll inspire feelings. I'd
encourage you to go check it out. They do that and a lot of other things I
think are very interesting. The first release of the first part of the serial
online book should be in about a month from today's recording which is May
9th.

_WS_: Great. So look for the first kind of release in early June. I look
forward to reading that and I look forward to seeing how you grow into your
role and how the Foundation continues to flourish.

_DC_: Thank you, thanks for taking the time to talk today.

_WS_: Thank you for taking the time to join us and I think there's a lot of
exciting stuff in the pipeline to look forward, so thanks again.
