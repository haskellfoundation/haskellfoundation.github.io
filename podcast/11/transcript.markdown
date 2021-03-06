_Andres Löh_: Hello Simon. Thank you so much for joining us today.

_Simon Peyton Jones_: Hi Andres, hi Joachim.

_Joachim Breitner_: Hello.

_AL_: I heard that you have recently started a new job at Epic Games. Is there
anything you can tell us about that?

_SPJ_: Yes I have. It's very exciting. So I've left Microsoft Research at the
end of November after 21 years. Working for Microsoft Research has been a huge
part of my life and it's been a great privilege to work there actually because
it allowed me to do more or less whatever I liked, which is pretty amazing as
a job description. So I spent some time working on education, about around 1
day / week all told, and then the rest of my time on functional programming
research and on projects related to Microsoft. My new job with Epic actually
is with a fairly similar prospectus. Epic are very generously allowing me to
continue to spend time on functional programming research and on education.
But the balance of my time now will be spent on working with Lennart
Augustsson and the Verse team on this programming language, Verse which is
going to be a sort of extension language for the metaverse that Epic will sort
of build out starting from the base that they have with the Unreal Engine and
their sort of games, Fortnite in particular.

_AL_: Is there any particular connection between Verse and Haskell that makes
Epic hire all these famous Haskellers?

_SPJ_: Oh I think probably the main connection is Tim Sweeney himself. So Tim
Sweeney is the founder and CEO of Epic and he is a computer scientist and has
been interested in programming for a long time. So he knows about Haskell and
loves Haskell actually. So I think that's why he thought of people like me and
Lennart and was keen to have us. But Verse isn't a Haskell clone by any means.
It's a language that Tim has been designing sort of in his head actually for
-- I don't really quite know how long, I should ask him -- around a decade. So
it's informed by functional programming and imperative programming and game
programming and logic programming. There's a lot going on in Verse. Lennart's
and my job is to sort of reverse engineer Verse out of tim's head and get it
set down in a kind of formal semantics that everybody else can make make sense
of.

_AL_: And is it clear what Verse itself is going to be implemented in?

_SPJ_: Oh. Almost certainly. So I would think C++ probably. I mean Lennart and
I are busy implementing a reference interpreter of Verse in Haskell of course.
But the whole games world is very C++ oriented, right? They're very
performance conscious. So I think the version that you first start to execute
will certainly have a compiler that's written in C++. But who knows about the
glorious future? Maybe it'll be written in Verse in the end?

_AL_: So in terms of the day-to-day work, what does it look like working at
Epic Games? You're still living in Cambridge?.

_SPJ_: I will still be living in Cambridge, I'm the only Epic employee living
in Cambridge. So, one of the my losses in leaving Microsoft is not having an
office and colleagues. But I'm really happy to say that Pembroke College is
appointing me as a visiting scholar for a year. So I'm going to work out of
Pembroke College in Cambridge. So I shall have a kind of perch in a Cambridge
College which would be very nice. I'll be able to meet astrophysicists and
French linguists and medieval philosophers over lunch. So that's very
exciting.

_AL_: Yes, extremely exciting. Are they expecting anything in return like you
giving lectures?

_SPJ_: I'm going to seek ways in which I can give back to the College in
return for their generosity. We don't quite know what that will be but I'm
sure it will be fun. Because of Covid I haven't actually got there yet. So
we're still doing this conversation from home. But any moment now, I hope to
move.

_JB_: So is it refreshing to to work on an implementation of a language from
scratch after having worked on this 20-30 years old codebase in GHC and all
this big beast where you can't just redo everything from scratch?

_SPJ_: It's a very different prospectus because in this case Verse is a
pretty well-formed beast in Tim's head. If we want to do something different
we're going to have to persuade him but I'm fine with that, right? But the
dynamic is that he's a sort of technical lead on the project -- which is very
unusual for the CEO of a multibillion dollar company and actually quite
rewarding. So, in a sense, it's everything from scratch but actually there is
a team of a dozen or so people working on a compiler for at least a subset of
Verse which would be the first thing that comes out. So I'm learning at the
moment, I'm not going around redoing everything from scratch at all.

_JB_: But the the interpreter you're writing you get to write that from
scratch.

_SPJ_: Oh yes, yes.

_JB_: I always find that writing something from scratch is easier and maybe
also more more fun sometimes than modifying a 10000 lines of code compiler
with a very picky performance test suite that makes you all makes every pull
request go for weeks.

_SPJ_: Yeah, that's true. So it is rewarding. That's right, you can sort of,
in an afternoon you can add lambda which is what I did this week to the other.

_JB_: So maybe let's twist the the question around to go back to Haskell: How
could you stand working on something where you can't just add lambda in a day
for these 2 decades on GHC? Doesn't it get on your nerve sometimes that there
is just so much code that you would have to touch to make a change?

_SPJ_: Oh, well, I don't think I feel that quite. So I find myself constantly
frustrated by my own inability to manage complexity, right? I keep refactoring
bits of GHC. The last few weeks have been rewriting parts of the the kind
checker for data type declarations. It's quite complicated and I'm trying to
think there ought to be a simpler way to do this. And now I work quite closely
with Richard Eisenberg and Sam Derbyshire and Ryan Scott on some of these kind
of things. And we're constantly trying to find the simpler simpler way to
explain it and struggling with complexity. So it's sort of the complexity that
limits our ambition. So it isn't that the code is difficult to change, once
you know what you're going to do. So, one of the great things about Haskell
actually, that is spoken about and I think it's the sort of killer app for
Haskell, is that it's so refactorable, right? You can do a heart or lung
transplant on GHC and make truly major changes and the type checker just
guides you to do all the right things. The difficult stuff is envisioning and
being very clear about what you're trying to do. Actually doing it is often
not that hard. But because it has become complicated, another frustration is
that I very frequently have the feeling that I thought this was going to be
simple but it turns out to be complicated, it turned out to involve more
things than I had initially thought. And again I don't attribute that to the
code, it's a sort of complicated language that's trying to be quite ambitious
now. But every time that happens, it's a challenge. Well, could you write a
paper about this that boiled out the sort of intellectual idea -- what what
was tricky here and how could we explain it in a better way? So it's a
constant drive to research.

_JB_: So overall it's not like there's a vision in your head that after 30
years if you would do a GHC from scratch there would be fundamental
differences and you just can't get there because it's too big? Or would you do
something differently if you were to rewrite the implementation of Haskell
from scratch?

_SPJ_: I don't know. So some people have a big vision in their head that
they're trying to reach towards. I actually think Tim Sweeney is like this.
But with me and Haskell it hasn't really been like thati. I've never had a 10
year plan for Haskell. It's always been I've worked on the thing that seemed
to be the most important or most interesting right now. Like the transactional
memory came a bit out of the blue, that wasn't part of a big plan. Now,
Stephanie and Richard have a big plan to make Haskell into a dependently type
programming language. But we've been moving pretty slowly on that, as you will
have observed, because of all the things that I'm very keen to keep. So if you
like, I've almost become the rate limiting step on parts of Haskell and trying
to say "let's make sure that we don't lose touch with the the sort of the key
bits that make Haskell good". Which is that it's a statically typed language
that works fast enough to be usable in production. Let's not make it so weird
and sophisticated that we lose touch with scores of ordinary Haskell
programmers. I think many Haskell programmers are quite extraordinary and
write code that I can't make head or tail off. So this is one direction to
travel. But I don't even know whether it's the most important one. Maybe this
project around the Haskell Language Server and making a better programming
environment for building Haskell programs. Perhaps that will turn out to be
more interesting and important in terms of spreading ideas. So maybe another
way to say it is, in the end, the thing that I'm really keen on doing, I
suppose, is to bring more sort of evidence and substance to the idea that
purely functional programming is a better substrate for the enterprise of
constructing software than imperative programming. This is something I believe
in. It's a hypothesis right? It's not necessarily true but I want to gather
evidence for it. People have heardly me endlessly say **"When the limestone of
imperative programming is worn away, the granite of functional programming
will be revealed underneath"**. But then we need to make that substantial and
actual. So in a way the big message of Haskell, the big picture, the 10 year -
20 year vision, is not that it becomes super sophisticated but just becomes
more widely used than appreciated -- maybe not Haskell itself but the ideas of
functional programming -- and that people construct more beautiful, more
elegant, more robust, more refactorable software in the future than they do
today. That's a bit of a sort of amorphous goal but I think it's the big story
arc of what I've been doing in my professional life, I suppose.

_AL_: Usually we we ask our guests how they got into Haskell but in your case
perhaps, how did you get into the position where you were at the right place
at the right time so that you were around when Haskell started? I mean like
how did you even like get into computer science in the first place and how did
you become interested in Haskell?

_SPJ_: Oh yes, so, how did I get computer science in the first place? That
goes back a long way. So when I was at school I was clearly interested in
computers but computing wasn't taught at school at all. The school I went to
did have an IBM school computer. One of them! It had 100 memory locations into
which, if you were careful, you could write a square root routine or game of
nim but that was about it. I mean just 100 memory locations which are tasked
to store both program and data. So I use that quite a bit, I had some really
good friends at school who bounced off each other and learned a lot. The Intel
4004 came out around then -- that was a 4 bit microprocessor for those who
don't know. The very first sort of microprocessor that you could actually buy
and build a computer of. Then a little while later they produced the 8008
which is an 8 bit microposeor. So it was just at the beginning of the time
where you could get a microprocessor and solder it together with some memory
chips and make something that worked, which I duly did when I was at um
university. So kind of around that time it became clear that from when I was a
teenager I kind of knew that I was going to stick with computing in some shape
or form. But I didn't want to do it as a degree partly because it was
difficult to find universities that did it as a degree because it wasn't
really a respectable subject in those days. Cambridge didn't have a 3 year
degree in computer science. You could do a 1 year final year course in it. So
I chose to do Maths. But Maths turned out to be too hard so I left Maths after
2 years. Maths at Cambridge -- there's a lot of scarily intelligent people. So
I did engineering in my final year and then I did a postgraduate diploma in
computer science. So, as it were I always knew I was going to end up in
computing and somehow I didn't expect or want to be an academic. I didn't do a
PhD, I left and got a job working for a small company. Then, rather by
accident, landed out back in academia when I was starting to look for a new
job and my sister said that there were some lectureships going at UCL. So I
thought, well I just apply and see what happened, and, much to my
astonishment, I was appointed as a permanent member of faculty with no PhD and
one paper to my name. But your your question I think related then to Haskell.
So, then then lots of serendipitous things happened. I knew I was interested
in lazy functional programming. That arose from my time at Cambridge when I
learnt from Arthur Norman and I was colleagues with John Hughes and Thomas
Clarke and other people. So there was a little group of us who got the sort of
functional programming bug. After I got a job as an academic I could then work
on functional programming and there weren't that many people in the world who
were working on particularly on lazy functional programming. So I was totally
inspired by David Turner's papers on SK combinators - very short papers,
anybody can read them, they're only 3 or 4 pages long. They're completely
inspirational because they suggested a completely different way of even
thinking about executing functional programs. It was amazing, I still remember
the thrill. So, there weren't that many people in universities working on
functional programming languages particularly lazy functional programming
languages. I started to get into the habit of going to the annual conferences:
the Lisbon Functional Programming or Functional Programming Computer
Architecture Conference in America. They were always in America at that stage.
Then I did a 3 week tour in which I invited myself -- I was very cheeky -- I
wrote to all these famous people -- Arvind and Dan Friedman and Paul Hudak and
so forth -- "can I come and just hang out with you for a day or 2 on my way
out?". So I did a three week tour around America staying with all these really
cool people and that built relationships that led to forming the Haskell
Committee. Because we got together at one of these conferences and said:
"Look, we're all doing lazy functional programming kind of things but we all
have our own syntax, our own language. That's a bit silly right?". Because
then we can't share code. Initially it was very very modest goal, it was let's
just share syntax, just have a common idiom for programming. How long, how
hard can it be? Takes us about a month just to agree to the syntax. We already
knew roughly what it was going to be like. So Miranda was around at that stage
-- David Turner's language. So it was going to be something like Miranda.

_AL_: Miranda, if I remember correctly was primarily not chosen because of
licensing issues?

_SPJ_: Yes, we couldn't use Miranda directly because David Turner licensed it.
We did ask him whether we could but it would have had to be on the basis that
we could then grow and change it. And David for entirely legitimate reasons
wasn't happy to do that. So we said "Fine" and we stayed on very friendly
terms with David, but nevertheless designed a separate language. So it's
really just a group of us getting together at a conference saying "let's get a
common syntax". That's all it was, terribly low-key, terribly modest, will be
done in a month.

_AL_: So looking at it in retrospect, Haskell Committee had this really
successful and, in my view, productive phase between, I think, roughly like
the end of the 80s and the end of the 90s, where there was rapid evolution. I
mean you said you set out with modest goals, but then actually lots of things
happened and there were quite major like additions to the language that were
not like previously in Miranda or any of the other languages that you set out
to do. In particular, I'm thinking about type classes and monadic I/O. Perhaps
tying this to our current discussion about which direction the language should
be going and major additions to the language such as dependent types or linear
types and and the reception of these kinds of topics, how were the discussions
going back in that day? Was it just everybody saying "we finally have a great
idea, let's just put it in" or was there a lot of controversy around these
ideas?

_SPJ_: I think it was pretty much the former actually. I still remember
receiving Phil's message about type classes. So Phil sent a message to the to
the Haskell Committee which was just a mailing list at the time. We did meet
quite regularly in person, for a number of years. I'm not quite sure how many
years but we had several in-person meetings. Anyway, Phil sent us an email
that contained this story of type classes including this sort of
implementation plan with these dictionaries, all in one email. It was just
amazing. He and Stephen Blott, his research student back then, turned that
into the paper, the first paper about type classes. So at that stage it was
uncontroversial in the sense that it met our need. We knew that we had a sort
of a problem about how do we deal with parametric polymorphism but we still
wanted to do equality and numerics. We didn't have a good way to do that. And
we didn't really like ML's way of these variables with tick marks on them and
your arithmetic operations were sort of polymorphic, but had to be monomorphic
at the usage site. So, type classes seemed to be "oh, here's a way of doing
this kind of systematically". Since we had at that stage -- going back to your
question, Joachim -- a language that didn't really have an implementation then
we could morph, it seemed like "oh, this sort of feels right, let's just do
this". So, there was very little debate about whether we should do it. It just
seemed like "oh, yes". Another technical innovation that you didn't mention
which I think as often goes unnoticed but is deeply profound is Haskell's use
of higher kinded type variables - type variables that can range over types, a
type variable `m` that has king `Type -> Type` or `* -> *`. Now that was very
unusual, right? ML has type variables that range over types, so to have type
variables that range over type constructors was quite radical at the time. We
were all worried about whether we need to do high order unification to do it.
I think it was Mark Jones who demonstrated very convincingly and very quickly
that you could get a long way with essentially still first order unification.

_AL_: So what's the motivation for adding these? Was it to get `Monad` as a
type class?

_SPJ_: Well so that was that was the killer app, right? I don't think this was
in the original Haskell, I'm not remembering the chronology very well. But the
killer for higher kinded type variables is that we could have a type class of
`Monad`. So Phil Wadddler's paper about comprehending monads that first
introduced to us the idea taken from Eugenio Moggi's work that you could use
monads as a programming idiom was a complete revelation to me at the time. But
then to make it a programing idiom we could use over many monads you need this
ability to abstract over higher kind of type variables. I can't remember the
exact chronology but maybe it was one of those "marriages made in heaven", you
don't never quite know in which order things happened but it just fitted like
a glove. I think it had a profound influcence on Haskell. Without the ability
to abstract over higher kinded type variables Haskell would be a very
different language. So that and type classes were both pretty significant
innovations that happened with very little debate. As in they were not
controversial. I think aspects of syntax were much more controversial: should
Haskell enforce that you can reorder equations arbitrarily in a function
definition? What should the exact definition the pattern matching be? What
syntax did we use for lists and tupples and so forth? There were plenty of
times debating those and we laughed at ourselves for that because we knew that
in fact we appointed a syntax czar at any one moment to be the person who
would ultimately resolve such things.

_JB_: What is the worst syntax addition made by a czar that wasn't you?

_SPJ_: Oh, I never mind very much about syntax. So, I was fine with all
decisions actually.

_JB_: Even when the syntax might have to change vertically? So, I'm thinking
of, coming back to the present day with this push towards dependent types, my
impression is that nobody would mind dependent types and it could just come in
if it weren't for the syntactic problems of lists and tuples. I mean there's a
bit of a stretch, but the problem is that historically Haskell has a different
time spaces so we can use the same symbols for the value of a tuple and the
type of a tuple. But with dependent types when you want to have terms and
types then this becomes very confusing. If you could magically just make this
whole thing have one namespace, then the path would be clearer. The big
obstacle on that path is certainly that we are very used to having the same
syntax for built in things like tupples.

_SPJ_: Yeah, so `[]`. You know, `[Int]` means list of int but `[3]` means a
singleton list containing 3 and that's very different kind of thing. So, at
the time, that didn't even pause right? We thought it would be so obviously
helpful to use the same syntax for tuples as terms and tuples as types.
Dependent types were not even on the horizon, I was certainly not thinking
about them at all. I don't think we ever considered that to be a problem at
the time and it is an obstacle now. But it is also convenient. So we got GHC
proposals on the go at the moment for providing at least alternative syntax.
It doesn't require this punning so you write `(Int, Bool, Char)`, I think
there's a path that gets us there but if you're not using dependent types it
makes the language a little bit less convenient, maybe, but not much less.
Maybe, with the benefit of hindsight, if we'd started off with `List`
constructor instead of square brackets, maybe it would have made some things
easier if we'd always done that.

_JB_: Do you expect that the Haskell community will go along? I mean it's
superficial because it's syntax but it's also very a very deep change because
it affects almost any code. Do you expect the community will go along or will
this be a danger for having one Haskell community that has one language and
lead to a fork in the road?

_SPJ_: Well, it's all behind language extension flags. I suppose you could
imagine a future in which one group of people consistently used one set of
language flags and another consistently used another and they couldn't really
understand each other's programs. But actually, if you look at a program that
uses lenses a lot it's hard to understand if you have not got used to that
library. It just is and that's nothing to do with the language, that's to do
with libraries, right? Programs are always hard to understand if you don't
understand the idiom in which it's written. So I think it's easy to overblow
these syntactic things, I think they're probably relatively easier to adapt to
than getting used to the dozens or hundreds of functions that you might want
to use in a program that makes extensive users of lenses. I think is
relatively superficial. So I'm actually not too bothered about that.

_AL_: I'm wondering, you've been working on GHC most of the time and GHC
itself is relatively conservatively written right? But you have at the same
time you have been implementing all these really cool extensions for Haskell
that everybody is keen to use. Do you ever get to use them yourself in
anything?

_SPJ_: Oh, yeah, sure. So we have this sort of 2-release policy. We try to
make sure that GHC can can be compiled with itself with two versions ago at
least. But you wouldn't have much luck if you tried to compile GHC now with
GHC 4.2. We do pull the ladder up after ourselves.

_AL_: That's true. But I guess you're not using lots of GADTs, type families.
Do you think you will be using linear types?

_SPJ_: So we use a lot of type families. So I wrote the linear type paper and
I think it's extremely intriguing but I think it's a hypothesis that's still
out to bat as it were. We don't kind of know how it. We'll have to see where
the linear types things goes. I don't see any immediate reason or motivation
for using linear types in GHC itself, at the moment. Quantified Constraints, I
don't think we have any of those in GHC itself. We do have a lot of type
families, though. By far the majority of them arise because we're using this
"trees that grow" idiom. So there's another sort of library idiom that we know
is embedded in a paper and we're trying gradually to get GHC's core syntax
tree for Haskell into a form in which it could be completely detached into a
standalone library and not have any GHC specific decorations at all. They all
attach via these extension points which is not a built-in language feature but
a sort of program in a programming idiom, but makes extensive uses of type
families.

_AL_: So in the beginning Haskell was formed around the idea of having a joint
lazy functional programming language and then we talked about these major
additions like type classes and monadic I/O and higher kinded type variables.
I think already in this "History of Haskell" paper you're kind of making the
points that, in retrospect, these things are to some extent more the essence
of Haskell than laziness itself. Is that accurate?

_SPJ_: Yes. I've been saying this for for many years now, I still love lazy
functional programming but I don't see it as being Haskell's most significant
technical innovation. I think these other things are more important.
Particularly, purity. I've often said that I think the most important thing
about laziness is that it forces you to be pure, it makes it difficult for you
to fall into sin and just say "let's do a few side effects on the side". So
purity - super important, type classes - super important, monadic I/O - yes.
Laziness..., well Haskell has lots of strictness annotations these days and
strict functional languages generally have some support for laziness as well.
So we've sort of grown, from the ends towards the middle. It still feels a bit
different programming in Haskell than it does programming in OCaml. But you
could kind of do either in either, and I flirted frequently with the the idea
of having an intermediate language in the compiler which is truly neutral to
strict versus laziness. We're not still not there yet, but that would be a
long-term aspiration to say it is truly neutral. It would be just as good for
compiling a strict language, I don't think that's true of the of GHC's Core
language today.

_AL_: Yeah I think it's still a little bit of an unsolved problem. But I also
feel like it's always "the grass is always greener elsewhere". So I mean I'm
mostly programming in Haskell myself obviously and I'm also sometimes in a
situation where I think "oh well, this laziness is just making everything more
complicated". But it doesn't take very long looking at some code written in an
eager language where I say "why is it so complicated?" and then I figure out
"oh, it's because it's not lazy". I think I would be equally unhappy if not
more unhappy if I would suddenly be forced to switch to an eager language.

_SPJ_: Yes, I could totally agree with you. I mean, people sometimes ask "if
you'd design Haskell again would you make it strict?" and I think "maybe I
would". But then I'm sure today I'd be saying 'I'd make it lazy."

_AL_: I mean that was where I was ending up. What would you be doing for the
surface language? For the core language you would like it to be completely
neutral. But if you could start from scratch with a new functional end user
language, is there some compromise or would you still stick with lazier?

_SPJ_: I don't actually know, it's not as if I knew of a way of doing a sort
of mixed functional lazy language that was somehow inaccessible to us because
we're so bought into the existing syntax and so forth. I don't think I'd even
start again with a strict language; I think I'd pay might pay more attention
to it earlier and maybe I would just for a change. It's a somewhat
hypothetical question, because we are what we are with Haskell and building an
edifice that large is, as we were discussing about, you need to be lucky as
well as sort of cool and interesting. You know I think Haskell was very lucky
in having sort of hit some kind of wave. It's difficult to repeat that.

_AL_: I guess for Verse it would be too exotic to consider laziness?

_SPJ_: Oh Verse is kind of lenient, actually. So things are evaluated eagerly
but not strictly. So it has a lot of lazy flavor to Verse. It's not just a
vanilla strict language at all. So Lenience is a term coined by Arvind and his
colleagues at MIT about dataflow languages where everything gets executed but
you don't have to wait for it to be done before you do the next thing. So in a
dataflow machine if you called `f`, if you applied a function `f` to an
argument expression `e`, it would spin off a computation to compute `e` and at
the same time it would call `f` whereas in Haskell we build a thunk tree and
only evaluate it if the function needs it. But in a dataflow machine, `e` was
going to get evaluated sooner or later and maybe even after effort returned so
there's this slightly strange property that they could still be humming even
after they'd printed the final answer.

_JB_: Is that related to the work on speculative execution in GHC where there
were attempts to be faster and use more parallelism by evaluating thunks even
before they were used?

_SPJ_: Yes, se we can certainly create a spark and if you've got any spare
processes here's something you could do. The idea was you could be free to
start, but didn't have to. So, yes, it's sort of related.

_AL_: One of the things that I also particularly like about Haskell is that is
the language that for over a long period of time has been used in academia and
an industry and sometimes people are saying that creates a lot of tensions but
I would overall personally say that it's ultimately a really good thing. Did
that in any way happen by design or did it just happen? I mean obviously
originally it was an academic language and there is this famous "Avoid success
at all costs" that seems to indicate that at least making it particularly
attractive for industrial use was never the goal. But at what point did it
become an issue and at what point did you try to perhaps make active decisions
in order to facilitate industrial adoption?

_SPJ_: Well Haskell was always intended to be useful for real applications.
And here's the Haskell Report, the very first one, which said goal number 1
"it should be suitable for teaching research and applications including
building large systems".

_JB_: So I should explain to our listeners that Simon just reached to a shelf
within an arm length and pulled it out in a moment. So he doesn't know it by
heart but he has it right in there at his desk.

_SPJ_: But I tell you this book, the Haskell98 Report has about a year of my
life embedded in it as way too much work. I was the editor for that round of
the report. It was the the first and only one that was published actually as a
book. Well and there's a sort of PDF report.

_AL_: Was it even in the preamble of the Haskell 1.0 report?

_SPJ_: Yeah, in the preamble of the Haskell 1.0 report. It had those same
words. Now of course that was a very aspirational thing to say. Usually
programming languages are not nearly as successful as Haskell turned out to
be. So I think we're very lucky to have sort of caught some kind of way. And
of course it does engender sort of tensions around the rate at which the
language evolves and what we do about breaking changes. I suppose in the early
days it was essentially the academics which clearly were in charge. Now, the
boot's rather on the other foot. We have this enormous regression suite for
GHC, we have this big CI structure, we go through all these performance tests,
we have the GHC steering committee to try to limit and control language and
changes. And still our industrial users complain, quite legitimately actually,
that things change too fast and that we just broken their code again and it's
too much work for them to to fix. But on the whole I see that this is a sort
of creative tension right? If we work hard at resolving it then good things
will come. I mean some things are just if your shoe is rubbing that's not a
creative tension, it just hurts. But this is a sort of tension from which good
things can grow if we pay attention to each other in a respectful way I think.

_AL_: I also think it's actually slightly more complicated right? I mean it's
not just the case that the academic users want to change Haskell all the time
and the industrial users wanted to stay the same? I mean many of the biggest
changes are at least partially driven by industry and some of the academics
are sort of the most vocal in saying things should actually stay the same.

_SPJ_: That is absolutely true. I've been quite stunned by the extent to which
it's an industry that some of these more exotic corners of the type system in
particular are most widely used and I attribute that to the fact that in
industry you want this code to still work in 10 years and be refactorable, you
want to express intent and not just writing something that is going to be
gone, here today and gone in a week like a sort of quick python script. They
get the idea about expressing the intent in a type system. They really want to
do it and then they're very annoyed if they can't. So quite a lot of these
type system innovations have had a lot of driving force from industry. Like
quantified constraints, for example: meeting Patrick from GitHub at a
conference who said "Simon, I got one question: when are we going to get
quantified constraints?". I thought maybe 1 PhD student in a Scandinavian
University would use this and here's a guy from GitHub who at that stage I
didn't even know were using Haskell.

_AL_: There are these kind of extensions that actually feel like they don't
make the language more complicated but actually -- and perhaps as an
implementor -- they do. But they actually make it more regular, for example,
say the moment you introduce a higher kind of type variables that we talked
about you basically need rank N polymorphism and at that point rank N
polymorphism isn't really an extension in the sense that it is yet another
completely new feature. It is something that follows natural from what you
already have. And to some extent Quantified Constraints fall in the same
category I guess.

_SPJ_: Yeah, and kind polymorphism I definitely put into that category. If you
say you know `data T f a = MkT (f a)` well of course it should be kind
polymorphic and it's ridiculous to choose 1 monomorphic instantiation of that.

_AL_: So you often are taking, either deliberately or just because that's the
way you are, sort of the role of a moderator to some extent. So like people
are saying I want this, I want that and you often appear like you're someone
who basically is just listening to everybody and is just trying to find
consensus and is trying to implement that and that makes you like well liked
and respected by I think everyone in the community but is this something that
you actively decided you want to do or is it really just like your character
naturally?

_SPJ_: Ah, well there are maybe 2 bits of this. Sort of late I spend more and
more time reviewing code and reviewing design ideas from GHC proposals because
I'm surrounded with smart people who've got interesting ideas that they would
like to put into GHC or Haskell. So that seems like a way that I can
contribute to help refine those into a form in which they make sense. But in
some ways it's not quite as satisfying as doing it yourself. Nevertheless I do
spend a lot of time in code review. And in fact, I often feel guilty because
I'm behind, I know there are people who waiting for me to look at their patch
and that we really don't want to merge until I have had look at it. So I feel
a bit embarrassed about that I don't have enough bandwidth. But maybe also
referring to the fact that almost every paper I've written has been
collaborative, I don't think this was a deliberate choice. It was more just
the way that I've enjoyed working, is that I've met smart people and they have
good ideas and I think "maybe I can ride on this person's coattails". But then
it turns out that I have a sort of useful role to play sometimes being the
scribe rather than the moderator. Because writing papers distills out the
essence of what a person has in mind, so that's why it's really quite helpful.
So yes, scribe I think is a good role.

_AL_: Does it ever happen that somebody comes up with an idea where you say,
at least like in the back of your mind, "oh no I really don't want this, I
hope it never happens"?

_SPJ_: I don't think so. It's usually on the power to wait scale. Because
Computer Science is factile almost ever everywhere you look you could discover
something new, you can make something new. So it can be a bit "well this is
kind of interesting but will it give us enough payoff to devote all the cycles
to developing it?". So it's mostly that. I'm trying to think of any occasions
in which I've come across anything I thought was an outright bad idea that I
would not like to see and I'm having trouble doing that actually. And probably
even if I could I wouldn't tell you in public.

_AL_: I think you have been rather skeptical initially about dependent types
isn't that right? I mean at least skeptical, not not that you thought it's a
bad idea.

_SPJ_: Skeptical. It's a skepticism born of having a brain of only moderate
size? There's something very deep and subtle going on there and, moreover,
what I have discovered is that it's not one thing right. It's not as if you
say "oh let's make Haskell dependently typed now". The space of dependently
typed programs is very large. Even if you get rid of the surface syntax, you
just think of the internal language. So there was this project Stephanie
Warwick and others ran about a language called Trellis. There was a sort of an
intermediate language and they spent 3 years arguing with each other what that
should look. There's a big design space there and it always does my head in as
well and so it's essentially the sort of a limiting step. Can I actually
understand it when I think that I thoroughly understand it that I'm willing to
at least consider having a go? I'm quite reluctant to put anything to GHC that
I genuinely don't understand at all. So I have been moving slowly on that. If
you talk to Stephanie and Richard and so forth I think you'd probably hear
them saying that it's being a productive conversation that it's not just that
they've you know, finally driven me kicking and screaming to the brink there
been a lot of refining that's going on.

_AL_: I mean there are different aspects to dependent types, as you said so
yourself. So one aspect is just to see it as a yet more powerful type system
that makes you able to express yet more things more accurately. But the other
thing is of course also that it that gets you closer to the realm of proof
assistance and actually being able to reason about code formally and to
possibly express things. Is that something where you think Haskell has a
future in? Even though obviously, from a logical perspective, with everything
being potentially non-terminating it is very difficult to prove reliable
things within Haskell. But do you think that that is an interesting area that
Haskell should also explore further for itself? For example, sort of in the
direction of other approaches that are not dependent types or not exactly
dependent types like Liquid Haskell or making use of SMT solvers and this sort
of stuff?

_SPJ_: My insict at the moment, for what it's worth, is that we should move
slowly with Haskell. It's got to stay a good programming language, right? That
sort of reasoning cannot overwhelm the programming. One of the reasons that
I'm a bit cautious about dependent types is what I like doing is sort of
lifting the restrictions. So when we added `TypeInType` -- which was a big
deal at the time, it kind of lifted up restrictions that made the kind system
extremely limited before and now it's just as much as the type system. Why
should the kind system be sort of emasculated? That's turned out to be quite
useful. But a dependently type person would say "well, you should just go the
whole hog and make types and terms the same". That has quite profound
consequences that I don't feel that I am sort of fully ready to grapple with.
But where I was going with this was one approach then is to say "let's use
dependent types more and more to specify what your program does" and another
approach is to say "let's do what Liquid Haskell does which is to take
functions written in Haskell and then separately write a Liquid Haskell type
that describes that". At the moment my instinct is that that scales better
because if I want to talk about a sorting function I want to say it returns a
sorted list or list in ascending order or list of a certain length then what
typically happens with dependent types is I'm going to have to decorate the
list with extra type parameters to describe say its length. That can clutter
up all the functions that work over lists. Now, you know, `filter`, if you got
lists with length, it's got to return some kind of existential and we don't.
So every time you use `filter` things have got a bit more complicated, maybe
even significantly more complicated. Whereas the sort of Liquid Haskell story
is to say "let's do that part on the side as a separate reasoning process".

_AL_: So you mean just the idea of writing types as refinement types is perhaps sort of more compatible with what we currently have?

_SPJ_: Yeah. I don't want to infect the types like lists and list functions. I
don't want them to get awfully more complicated in order for some aspects of
reasoning like "is this list in ascending order" to be doable.

_AL_: Yeah, okay. Just because you said "write separately" and, of course,
that is what you currently have to do with Liquid Haskell - you have to write
one Haskell type signature and then you have to write another Liquid Haskell
type signature. But in principle the LiquidHaskell type signature contains all
the information that the Haskell type signature has. So I think in an ideal
world, you would want to write only the Liquid Haskell type signature.

_SPJ_: Maybe, but we quite a lot of duplicates when we write a function
definition. You repeat the function name in every equation, right? You don't
really need to do that. If you've got repeated pattern matches you sometimes
repeat parts of patent matches. We sometimes do use repetition because it
makes the net result easier to understand. The one lovely thing about Haskell
types is that a type it's not too cluttered, it makes sense in itself: `Int ->
[a] -> [a]`, I just sort of read that off. Now you could say, all that
information is in some Liquid Haskell type that takes 3 lines to write down
but the abstracted version is stilli important. Maybe in some programming
environment that would show you the abstracted version as well... now you know
we're talking again. But I really want to be able to see that obst abstracted
version too.

_JB_: Is there a a place for Liquid Haskell in GHC in the future or is that
not being discussed.

_SPJ_: Oh, mark my ambition! I would love Liquid Haskell to come in the box
with GHC. I'd just like it to be so well integrated and part of the
programming environment that if you got GHC you automatically have Liquid
Haskell. I think Liquid Haskell has quite a bit of engineering to do as in
being used for real things. It's being used for real things by people with
PhDs and that doesn't scale very well. The amazing thing about Liquid Haskell
is we all talk about reasoning about Haskell programs but Liquid Haskell is
actually doing it. And on real Haskell, right? Not on some toy subset of
Haskell, because it uses GHC's frontend. It can consume all of and really
works on Core. It can work on all of Haskell. That is amazing, right? So, for
me, that's as far as increasing our ability to give you statically guaranteed
theorems about Haskell programs. My money's on Liquid Haskell at the moment
and I hope that we the Haskell community can sort of cohere around that
because it's such a big engineering effort to turn that kind of aspiration
into reality. It's got to be more than just Ranyard and Nikki and a few others
right? We all need to pile in there. That's my brand leader for what it's
worth.

_AL_: Yeah I agree. We've been partially working on turning Liquid Haskell
into a GHC plugin which makes it a little bit easier to use but there is a lot
of overhead and there is also some redundancy that is only needed between GHC
and Liquid Haskell because there are separate tools in the first place.

_SPJ_: Yeah I'll be totally up for adapting GHC to fit. You know, it's not an
immutable thing. But when you start to do that you got to say "yes, we have
critical mass behind Liquid Haskell, that means it's not going to go away". We
just get left with a GHC that's got bent out of shape for now. No reason
right. We need to make it as much a part of the ecosystem as GHC and Cabal and
Stack and HLS.

_AL_: Perhaps sort of towards the end, we've already been talking about like
dependent types and Liquid Haskell which are kind of current or future issues
up to some extent. But we've been also looking a lot into the past. So, are
there things for the future of Haskell that you would wish or goals that you
have for the language or major features that you wish somebody would implement
or that you yourself still want to do?

_SPJ_: I think my major goals at the moment are more social than technical. I
mean of course I'm noodling away all the time myself and I'm fixing bugs and
so, but as far as the big picture is concerned I think Haskell's big and
bigger sort of both vulnerability and opportunity is can we make things like
the Haskell Foundation and the Haskell Community more broadly continue to work
well? It's hard to scale when it was very small, it's everybody knew each
other, it was no problem. Then it became larger but still full of passionate
motivated people and we sort of held together pretty well. We've had some
incidents in the Haskell community that have not gone, all that well over the
last 10 years or so. Now, the Haskell Foundation is the sort of big tangible
initiative to try to help with that. And so I think my biggest sort of hope
for the future is not some technical feature, is just that the Haskell
Foundation in particular but really I mean the Haskell Community more
generally can cohere in a way that makes all those fantastic people who I love
so much work together in a way that means that they love and respect each
other and prop each other up rather than they accidentally end up in fights.
And then, if we can do that then that creates a context, a vehicle, a
community from which all these creative and wonderful things can happen. Both
technical things like the next great thing, maybe, but also the sort of the
engineering stuff that's needed to turn something like Liquid Haskell into
reality, and, perhaps.. I still want Haskell to be a laboratory in which great
ideas grow and I don't quite know what those great ideas would be. But I think
it's unlikely we've seen the last of them. I think everybody wants that --
that's a good thing. Even our industrial users, they don't want their stuff to
be broken that often but neither do they want stasis. People who want stasis
probably have just switched to something else by now. It's that sort of
socioechnical coherence and working together. It's not easy to achieve in a
big geographically distributed community of people who very seldom meet each
other in person. But I think we can do it I and I'd like to play a part in
making that happen.

_AL_: Yeah, I think there are certainly some of these problems about changes
that that have a technical solution but many of them need a social solution as
well. And, do you have suggestions apart from just like being respectful to
each other and doing, for example, what the Haskell Foundation is already
doing? Do you have particular suggestions what we could all be be doing better
in order to like collaborate better or particular things?

_SPJ_: Ah, really I mean the thing that I've been thinking about a little bit
recently is the pain that we go through when a new version of GHC comes out.
It can be months or even years before libraries have caught up and and that's
not because it's hard to catch up. It's because library A which depends on
library B has to wait for library B to work with GHC 9.2 before library A can
even start work and then there's library X which depends on library A and X
can't start work until library A done so that and that chain of dependencies
makes things very slow and vulnerable to individual library authors, for
absolutely legitimate and good reasons, being offline or away for a few weeks
and. So I think it's a sociotechnical problem. But I think maybe we can do
something with Hackage overlays that would make it easier for people -- not
just the library authors, but for everybody -- to muck in and just help do
those routine changes that an author could then pick up and with a few mouse
clicks could commit and release so that they didn't have to do the work and
also other people didn't have to wait for them to do it. It could still make
progress. I think if we can sort of identify what are the real problems --
rather than just saying "things break too often" or "people aren't listening"
say "let's be tangible", "let's be concrete about what could help". What is a
problem and what could we do that would help? I'm sorry that's not a very
specific answer.

_AL_: I don't think it was a very easy question. It was certainly a very vague
question and I mean there are all these sort of things that can be partially
at least improved by technical stuff. I think one of the recurring problem
aspects in that space, for me, is still -- I mean we've been talking about
this quite often: there's this lock between `base` and GHC. Because that
creates implicit upgrade pressure and usually you can just say with libraries
if I if I'm unhappy with certain changes I'll just not upgrade but by GHC
being locked to `base`, if you want to have certain bug fixes at all, you need
to upgrade all sorts of things, all sorts of dependencies. You need the latest
thing, the latest security fix from one library but that suddenly comes along
with a `base` dependency that requires a new GHC and therefore you need to
upgrade GHC. And that means you need to upgrade all your other libraries as
well. So this makes the whole thing much more serious in a way, whereas
otherwise we could just say okay I disagree with this development but I'm just
going to stay roughly on this level for the next five years.

_SPJ_: Yes, so I think what would help this conversation -- it's one that's
actually taking place actively on the Haskell Discourse at the moment --, is
to be quite specific about the chain of dependencies that you described, about
use cases where where this goes wrong. Because one thing we could do, for
example, which is being discussed on this third at the moment, is to try to
split `base` into two: that is, you know a library that's really just the
library that contains, for example, the I/O library -- there's a lot of code
there, there's 250 modules in `base`. They can't all be tightly coupled to
GHC. Then there's a part that is pretty tightly coupled to GHC because it's
how do exceptions work or how does stack unwinding work or, you know, if we're
doing fold build fusion then that that is done with a sort of rule-based
system but it lives in the one of the the most basic of `base` libraries. I'm
trying to think what else is... data types and classes that GHC itself knows
about right? Then you can't just change `base` and and change one of those
types if GHC has wired in knowledge of that type then you can't change. But
there aren't that many of those right? So I think it would be significant work
for someone maybe we could split `base` up. And then, if we split it up into a
part that was really not coupled to GHC that would at least mean you could
choose to use that library or not. But what I don't know is whether that would
be a lot of work. Would that in fact, meet or help with the kind of problems
you're describing? Well we'd need to know. Quite a lot of specifics here. But
so I think people like you can actually be really helpful here because I think
from the GHC point of view we'd be totally willing to you know, cooperate with
splitting up `base`. We're not sitting there saying "no, we're definitely not
going to do this". We just need to know exactly what do you need, and will you
help us do it?

_AL_: Yeah I think one of the things that I've been observing is that already
in the past we've had these conflicting tensions. I mean some people say "I
don't want my stuff to be in `base` because then it's tied to GHC" and other
other people are saying "I absolutely want my stuff in `base` because then
everybody has it and it's available out of the box". There have been, I think,
some efforts to make `base` smaller over the years. There have also been,
understandably, conflicting efforts to actually bring more stuff into `base`
for exactly the reason that then you don't have to do any efforts to
distribute it and you can rely on it being available everywhere.

_SPJ_: Yes, so I think the message is that everyone is very open to concrete
proposed solutions here, right? It's not that I don't think anybody's
defending the status quo and saying it's perfect as it is. It's just be
specific about problems and preferably suggest ways to improve it. The only
thing that sometimes makes me irritated about Haskell community is people
who're simply criticizing -- I mean from a legitimate point of view, I'm
saying the criticism is unjustified -- but just that it it doesn't seem very
actionable because I don't know what I can do to help that person.

_AL_: Okay I think we should come to an end. Let me just use the opportunity
to thank you again for taking so much time to talk to us about all these
different things and wish you all the best for your future and exciting new
adventures at Epic Games. It's good to hear that you're going to be given time
to continue to pay attention to Haskell and the future of Haskell and as well
as telling us lots of new interesting things about Verse in the near future.

_SPJ_: I've been having a lot of fun. I think both should be fun and I shall
continue to be active in the Haskell community. I'm happy to say it's very
generous of Epic to allow me to do that!

_AL_: Absolutely. Thank you very much.

_JB_: Good. Thank you.

_SPJ_: Been nice talking to you both.
