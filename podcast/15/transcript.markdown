_Niki Vazou_: Welcome to the Haskell Interlude. In today's episode Facundo
Dominguez tells us the difference between STM and SMT. We also talk about
Liquid Haskell and its relation to dependent types and the `QualifiedDo`
extension -- which is one of the most highly discussed GHC proposals --, and
the general GHC proposals. And, finally, Facundo lets have Haskell peacefully
coexist with other languages thanks to his work in the build system Bazel.

So, hello, I'm Niki, and Joachim is today here with me.

_Joachim Breitner_: Hello.

_NV_: And our guest today is Facundo.

_Facundo Dominguez_: Hello there!

_NV_: So why don't you start by telling us about your Haskell history. Like,
how did you get to it, when, and where?

_FD_: All right. So, first time at Haskell was in university. It was taught in
one of the was thought in one of the courses there. Later on, I did my final
project for my Bachelor's in Haskell as well. And then I followed up that with
Master's that also had an implementation in Haskell.

_JB_: So, which university was that?

_FD_: I stayed in Montevideo, in Universidad de La República, which is a big
university owned by the state. There were some folks here who had traveled to
Sweden and studied there (also to share money) and they brought Haskell to
these latitudes. Haskell or functional programming was totally unknown before,
I would say.

_NV_: So who are you talking about?

_FD_: There were several professors who went to Sweden. I remember Juan José
García Siri, Silvia Da Rosa, Alvado Tasistro. And then, to share money, my
thesis advisor, who is called Alberto Pardo. So Alberto, I think, has stayed
connected with, or investigating research topics related to functional
programming. So you might find him in committees of conference today.

_JB_: So when you started learning Haskell at university -- my experience was
that in the first year I was just doing something I had to do because it was
University and it didn't really click; and then only later it clicked and it
made sense and became this thing that I highly value -- how was it for you?
Was it like immediately clear? "Haskell is great and going to be influencing
the rest of your life forward" or take a while?

_FD_: When I was having my first course, I surely didn't fall in love with it.
It was only after I started reading papers about Haskell that I start to see
some differences with other programming languagees. It happened to me
eventually with "Why functional programming matters?" but I had to read it
several times to get the message. What hooked me much faster was the paper of
SMT transactions that Simon Peyton-Jones wrote at about that time or perhaps a
little bit earlier. We are talking at the beginning of the century here. From
there it started to look to me like it was possible to write in Haskell code
where it was clear what it was attempting to do.

_NV_: But these SMT transactions are not about Haskell? What is it?

_FD_: SMT is software transactional memory. Is concurrency. So software
transactional memory is a tool that you can use in concurrent programs to
synchronize different threads. It has some properties related to how easy you
can compose different transactions into larger ones and still get a program
that does what what you mean it to do.

So, from there, time passed, I left university and started to work
professionally. At some point I started to look for a functional programming
job and that turned out not to be entirely trivial. It started to become like
a sort of a dream to achieve. Anyone here felt the same looking to work with
Haskell? I eventually got some freelance jobs to do with Haskell for companies
in the North Hemisphere. Because, of course, in Uruguay and Latin America in
general, Haskell is not a thing in industry.

_NV_: And that's still the case, right?

_FD_: Yes, I think so. But I think you can find companies now that are using
Scala. So functional programming is coming slowly. And I know of one company
using Erlang. So maybe we can count Erlang as functional programming too.

Well, after a while of doing freelancing I got a job for a company called
Parallel Scientific where I could work for a couple of years and then came to
Tweag.

_NV_: And here is where we are now. Because I heard that you are one of the
first Tweag employees.

_FD_: Well Tweag started in November of 2013 and we were 3 persons: Alexander
Vasilov, Mathiew Boespflug, and myself. We were working together in the former
company, Parallel Scientific. So, at some point Parallel Scientific ceases
operations and we still wanted to continue working together because we were
young, we wanted to change the world, and we wanted to to have fun.

_JB_: So which of these things have you achieved? Being young, changing the
world, and having fun?

_FD_: So, being young was easy at the time. So we still wanted to have fun and
change the world, mind you.

_NV_: The world is changed too. So, I guess the real question is, how did you
want to change the world with Tweag or Parallel Scientific or through
functional programming in general? As opposed to like many people see all this
functional programming as this borderline research that doesn't really have an
effect on the word. So I'm curious to hear the opposite argument.

_FD_: Well, from the industry side I think it's easier to change how your team
works. So you might not change the world immediately but you can convince your
peers that functional programming is worth it. You can get some start with
some small projects with functional programming. You can start having
discussions about how to solve real problems using functional programming.
Haskell is really challenging for that because it's offering you so many ways
to solve a problem and you have to pick one. If you want to make a conscious
choice, that requires a lot of discussion. There were not a lot of resources
at the time telling you how to do functional programming to solve real world
problems. So it looks interesting to try to acquire that experience.

_JB_: So what is an example of something where you have many ways of doing it
and you need expert guidance if you want to solve real world problems?

_FD_: Well, I think we could find many examples. One that comes to mind now is
how much you want the compiler to check for you. Because you might be happy
just not confusing booleans with integers or you might want to make sure that
you are searching in a map the keys that actually exist in the map and that
you are not going to get a runtime error because of a missing key. Even if you
agreed on the things you want the compiler to check you still have multiple
ways of implementing those checks. Are you going to use Liquid Haskell to try
to do that? Are you going to try to use type classes (like heterogeneous
lists)? And if you use type classes, do you use functional dependencies or do
you use associated types? So the decision tree branches and branches and
branches, and reaching to the leaves is a long way.

_NV_: So is this an obviously good thing that you have so many choices?

_FD_: Well, it must be good for researchers. But for industry, you have a
heterogeneous group of people with various degrees of experience. So it's not
so obvious. Also you have several constraints. I think that when you are
undertaking a research project you have much more freedom in deciding what
your constraints are going to be. In the real world, well, your software has
to be a specific size or it has to work with some particular technology, it
has to run in a particular operating system or many (which is worse). And all
of these constraints are not always known from the beginning. This has a
greater risk of sending you to revise your assumptions, having to rewrite some
parts of your code.

_NV_: Let me ask you what should be the structured way of software engineering
on making these decisions based on the project.

_FD_: Well, we have opinions, certainly. These opinions, of course, change
from engineer to engineer. I think there is a recently large batch who thinks
that we should try to not get too fancy with dependent types, for instance,
try to keep the scope limited in what we ask the compiler to check at compile
time, and then try to look for other practical solutions to cope with the
problems or the mistakes that the programmer can do. But that's not like there
is a consensus inside Tweag. For instance, you will find people which are
aiming for more power when programming and getting a study on guarantees.  So
I'm not sure I'm answering the question. No, I don't think we have a book that
you can read and learn all the experience that we have, that we have earned
over the years. Also, I'm reluctant to claim that this experience is universal
so you can apply it safely in all contexts. If we go and discuss the projects
I've been involved with you will see that the parts of the landscape that I've
been exploring is very narrow.

_JB_: So on the options that you think about how much you want the compiler to
do for you, I notice that you mentioned Liquid Haskell. I think you actually
worked or work on Liquid Haskell. Maybe not everybody who listens the podcast
knows what Liquid Haskell is. So maybe, could you just introduce us to
Liquid Haskell, from what it is, at least, for you and what it means for you
and what you've been doing there and why everybody should know about it or why
everybody should not know about it. I don't know that's up to you.

_FD_: Yeah, sure. So Liquid Haskell is a tool that can analyze your program
and tell you what you need to prove in order to ensure that the program does
what you intended to do. You explain to the tool what you intend the program
to do by inserting some comments in the program that say what the functions
are meant to be doing. So Liquid Haskell can read these special comments, can
read the source code and equalize these as well. Like if you want to prove
that this program is correct you need to give me this list of proofs. And, to
save the user a trouble of writing these proofs on paper it will use an SMT
solver to try to prove these things automatically.

_JB_: So, SMT is not the think we talked about earlier, right/ That was STM
and now it's SMT. So, what is SMT?

_FD_: Ah, so let's say that instead of an SMT solver there is an automatic
theorem prover. So there's yet another tool at the side of Liquid Haskell that
can prove theorems automatically for you, or some theorems for you. So
Liquid Haskell is going to pass whatever verification conditions it thinks are
necessary to this automatic theorem prover and if the automatic theorem prover
can prove them all then Liquid Haskell will say that your program actually is
correct.

_JB_: Okay.

_NV_: And maybe can you say some examples of properties you can use
Liquid Haskell on, or that you want to use Liquid Haskell on? To make things
concrete.

_FD_: Sure. So I think I would try to use Liquid Haskell on almost every code I
write. So whenever I write a function, this function has preconditions in
order to have an useful outcome. Many of these preconditions are simple and
they can be checked by an automated theorem prover. Things like the input list
must not be empty and the result is going to be sorted. If you are working
with a tree-like that structures you can say the tree is balanced both as a
precondition when I get it as input and as an output when I get it as result.

_JB_: Okay, so this sounds like something I might want to use. Is it ready for
people out there to use? You just tell somebody who just did maybe a little
bit of Haskell to know and install it?

_NV_: I was thinking exactly the same. Like you have a magic SMT based tool
that can tell you that like if your input tree is balanced, your output tree
is balanced. There should be a cut.

_FD_: Well, I've tried it for over an year now and verdict is you can use it
if you are enough motivated. But if you want to motivate other people about it
probably we should lower the value for adoption. There are 3 things, I think,
that we could improve to make Liquid Haskell followed. One of them is make
Liquid Haskell easier to understand -- that is, when you use it and it doesn't
work you have a way to inspect what Liquid Haskell is trying to do and figure
out how to modify your program so it works, so verification passes. Another
thing that could be improved is, of course, making verification faster. Today
if you want to verify a program -- it depends on what you are trying to verify
-- it could multiply several times the time you need to build a program.  And,
well of course, there are usability issues, bugs that you have to work around
because nobody had the time to fix them yet.

_JB_: Who is developing Liquid Haskell then?

_FD_: I don't know. We have to search on the web.

_NV_: Yeah, I can tell the mystery. Me and my PhD supervisor, Ranjit Jhala,
are the main developers. I mean it has been amazing that Facundo is working on
these. I think that the most amazing thing is that I made a pull request and I
immediately saw a review of the pull request by Facundo. That was very nice
and I think you have been speeding up verification times a lot.

_FD_: Well, glad to hear that your are appreciating the help. We'll see how
far we can go with performance.

_NV_: So, I have to note here that Liquid Haskell is using this SMT on the
back that is this automating prover and performance is bad. When you go
outside of these decidable fragments of verification -- like if you just want
to say "a non-empty input list returns to non-empty output list", then
everything works and it's very smooth --, the more advanced theorem you want
to prove then more processing is happening and this is where speed up is
needed.

_JB_: So could can you describe what the decidable fragment is?

_NV_: The decidable fragment is interpreted functions and linear arithmetic,
basically. So you can use linear arithmetic to talk about the size of list.
But if you want to say, for example, "`append` is associative" then you need
to know the definition of `append` and then you go to the recursive function
-- and when you start dealing with recursive functions what is happening is
that Liquid Haskell has a preprocessor that is analyzing all these. And this
is what Facundo has optimized a lot, this preprocessor for when you leave this
decidable fragment. But, of course, all these are very difficult to explain
without assuming that the user knows all the internal information.  And this
is where problems are. Like error reporting, assuming that your user doesn't
know how the SMT works, then how do you explain the error? I think error
reporting is a very difficult problem in all functional programming, I mean
even in GHC the more `#LANGUAGE` pragmas that you use, the more your errors
are getting confusing.

_JB_: If you use less language extensions, the errors are simple. They tell
you turn on this extensions. So that's easy to follow, but then the next arrow
is tricky.

_FD_: Yeah. Well, I'm not aiming to give errors that are self-explanatory,
that assume the user knows everything. But even assuming the user knows how
the algorithms work it's hard to understand why our program doesn't pass
verification. So, an easier goal to achieve is just to give enough information
for that person who knows how Liquid Haskell works. We are not there yet, if
we look at the dump of formulas that we can say that Liquid Haskell discovers
and this preprocessing that Niki was saying before. There's a part where
Liquid Haskell tries to augment your environment with extra hypotheses that it
has, that hold and some of these hypotheses can get really really large and
hard to read. So if you want to inspect what Liquid Haskell has inferred, you
have a hard time understanding because these hypotheses are too much. So when
I say improving the ability of users to understand it I'm meaning "let's give
the expert users some chance of dealing with this".  So the biggest challenge
I have with Liquid Haskell today is that the codebase is big and I still have
to make changes without breaking it. Sometimes I manage, but sometimes I still
fail to see some environment and I made a pull request and had to do another
pull request to fix what I have broken.

_NV_: But what about the good parts of Liquid Haskell? Like why are you
putting in all this effort? Where do you want to see it?

_FD_: Oh, well, I want Tweagers -- I mean, other coworkers -- to start using
it. I want our customers to start receiving code that is verified with Liquid
Haskell. So we can keep the code simple because I like dependent types. We
don't need to modify the Haskell program a lot to get verification to pass.
That's my hypothesis, to engage it with all of these.

_NV_: Then did you have something very concrete that you can explain what do
you want your code to get verified about?

_FD_: Well, in the beginning, I'm going to aim for these simple preconditions
and postconditions for functions, without choosing any particular domain. I
think this is wildly applicable. And once this is easy to use and I can get
other coworkers to use it, then we could get more ambitious and say "let's try
to prove some properties related to the domain of an application". So, say,
when we work with a database we ensure that the users of our application
really have access to the data they are supposed to and they they cannot read
the data that is private to a different user. I think Ranjit has paper related
to something like that.

_NV_: Yeah, we have a paper at OSDI that's called "STORM" and it's doing
exactly that. But it's very interesting because, I mean, it happened but,
again, it was very difficult. Like the annotations when you develop the
library that ensures these privacy properties, the annotations that the
developer had to write were very complicated. I mean the first author is a
very smart student and it took him a lot of time to develop it. But in theory
if you use this verified library to develop clients it's not that difficult.

_FD_: Right? Well, yeah that's my impression. So taking it slowly. Also you
can still prove a lot of interesting things about your functions without going
for such high level properties. I discovered this when working on an
interpreter for the lambda calculus where I tried to prove Liquid Haskell that
the expressions that you are manipulating are well-typed.

_NV_: And this is "Sticth", right?

_FD_: Yeah, this is StitchLH, because there's "Stitch" which is the paper
written by Richard Eisenberg which just uses the available Haskell hackery to
ensure with the compiler that your expressions are well typed.

_NV_: And originally it is using type families and dependent types and
all these. And you wanted to port the same verification conditions using
Liquid Haskell.

_FD_: Yeah. So that means that your code is Haskell98. All the trouble of
expressing and proving your properties is on the Liquid Haskell side, another
Haskell program.

_NV_: So you have the answer to the question of how dependent types compare to
the refinement types of Liquid Haskell? Because I hear this question a lot yet
I still don't have an answer. Like a cleanup?

_FD_: I think you can arise a lot of passion in the functional programming
community by bringing that topic. I only claim that for the examples I have
seen where I can get away without dependent types.  But I'm sure that we are
going to find persons who think that dependent types are still the future and
are more powerful and more flexible, maybe, than Liquid Haskell.

_JB_: But it's not an exclusive or, right? Presumably Liquid Haskell and
dependent types can be used together if that's needed and you can refine your
dependent types. Or is there something fundamental that makes you choose one
or the other?

_FD_: I think you can use both but right now for me, it looks like they go in
opposite directions when you approach verification. Maybe you could say "well,
I'm going to try to use dependent types for things that aren't easy to prove
with an automated theorem prover". That's plausible, but I haven't seen any
experience trying that yet.

_JB_: I think that the point I was trying to make is that dependent types per
se are not just about verifying things. They're just also functions that you
kind of want to present a dependently typed thing even though you're not
proving them to be correct, and just the ability to have types depend on terms
is not verification on its own yet. And then when you have programs that
happen to use that feature I see nothing wrong with putting some refinement
types on functions and results if you want to check some side conditions or
something else. I don't think it's they're exclusive.

_FD_: Do you have any examples of some use of dependent types that you might
not use for verification?

_JB_: I came across something -- and this is not fully thought out so this is
going to be a bit more chatty --, but I was looking at some automated
difference shapes in library earlier. It's building a differential -- a
differential is, like in the linear algebra sense, real analytics, you think
of it as this number that's the derivative; but a more abstract view of it
from a methodical point of view is to say it's a tangent at a point on a
curve. And what a tangent means kind of depends on what kind of space you're
in. So the tangent to a line is a straight line, the tangent to a sphere or to
2D object is a plane. So these are different types. Now what if I take a union
of 2 of these spaces, like just the `Either` type? Well the tangent at a point
has a different type depending on whether it's a tangent of a point of `Left`
or a tangent of the point on the `Right`. That may be one of these things --
this is very very superficial. I could just take another union type for the
tangent and then have a verification condition that kind of conveys
information that when I'm taking a tangent of a point in the `Left` space then
that really is of that type of tangents the `Left` space and the other way
around. But that may be something that I'd want to be expressed on the type
system. Then, maybe, the next step I want to verify is that all my things are
continuous, or whatever -- I ended up making things us right now up. Maybe
that would be a better for something like Liquid Haskell.

_NV_: So my understanding of what you're saying is that the benefit of
dependent types is that you can use them to affect the implementation of your
function. You can have the function depending on your type.  While the
refinement types are exactly the opposite. As Facundo said, we like Liquid
Haske because your code doesn't need to be modified. Your code just imposes
external verification conditions. So from this distinction I can see why
they're exclusive and they serve different purposes.

_JB_: They're not exclusive I would say.  Another way of putting it, if you
think about red-black trees -- is one of these typical examples of data
structures with invariants -- then you can use the Haskell98 type system to
encode the invariant. I guess people would say that this is verification
saying that a data structure is a red-black tree. I guess there's this thing
where it's unclear whether you're verifying something or you're just just
modeling the thing in a way that that only allows certain good behaviors. And
maybe that's a kind of squishy distinction.

_FD_: Yeah. I think when you use dependent types, there's always some
structure that you are imposing on your types. So there are some expressions
that would fail to typecheck if you use dependent types. So this is the thing
that you are verifying at compile time, however trivial. Now that you put it,
yes, it looks to me like you can mix dependent types with Liquid Haskell
without getting too ambitious on what you have the compiler check with
dependent types. Also, in the case of red-black trees, one question to do
there: you can do it with Haskell98, fair, but how hard is the implementation
when you try to have the compiler verify it?

_JB_: Yeah, I think that's the crux of the question. There are probably
examples where doing it in types actually makes it easier to write it because
the compiler will happily check all the things you need to do but it will
actually guide you in writing the code. And there are cases where you need to
jump through hoops to make the compiler accept it where maybe Liquid Haskell,
I would expect, would just accept it with much less trouble. And, maybe,
that's the criteria you would apply when you want to choose which kind of
approach you want to use or where you want to make the cut between what do you
put in the types and what do you put in the refinements.

_NV_: Yeah, and as we mentioned before these SMT-based refinement types like
Liquid Haskell are very good. A lot of these are decidable theories. The most
famous of which is linear arithmetic. So if you want your spec to have linear
arithmetic you have to use Liquid Haskell. Do you have to use an automated
prover behind it to discharge this? Because I mean we know how to solve this.
Why should the user develop again linear arithmetic and make explicit Proofs
about that?

_JB_: Yeah, absolutely.

_FD_: Okay, but you can encode a lot of things using linear arithmetic. So
again, it's not easy to for me to decide want to stop because that's what
Liquid Haskell does with reflection, and it gets scary.

_JB_: So you mentioned that working on the Liquid Haskell codebase, that it's
big and things. But you also worked on other big codebases like GHC itself. So
I guess the question is which is less scary of the 2 code bases, seem to be a
bit mean?

_NV_: In our defense, Liquid Haskell depends on GHC codebase, so it can only
be worse.

_JB_: So like it's practicing on reverse, so that that's a good point. So one
thing I saw you didn't yet achieve was implement the `QualifiedDo` language
extension. Is that correct?

_FD_: Yes, that's correct.

_JB_: Maybe not all our listeners are reading through all GHC proposals coming
through. So what is `QualifiedDo` and why is it there and is it useful?

_FD_: Well, `QualifiedDo` came to alleviate the syntax part of another
proposal which is linear types for GHC. So with `QualifiedDo` you basically
try to be able to use the monadic `do` syntax to write Monads that involve
linear types.  Before the `QualifiedDo` extension this wasn't possible, for
various technical reasons. So the `QualifiedDo` language extension is a
particularly small one because it affects only the renamer in GHC. The big
effort of implementing `QualifiedDo` was getting the Haskell community to
agree on how it should be.  So I like to brag that the `QualifiedDo` proposal
has the second most comments at the time it was approved.

_NV_: After Linear types?

_FD_: Yes, that was the first.

_JB_: I would expect some of the even more syntactical proposals to have even
more comments.

_FD_: Well, you check it. I'm not sure my claim is checkable, because I say
"at the time it was approved".

_JB_: Yes, yes. And by the time of recording this podcast it has already gone
down to number 6, being surpassed in number of comments by "visible `forall`
in types of terms" -- so that sounds like syntax --, "linear types" --as Niki
said --, and then before that there was a "support the design of dependent
types" -- it's all about dependent types and I guess you make a good point
that Liquid Haskell is actually simpler than dependent types, and maybe people
shouldn't be using that as much. And then before that we get the really heavy
syntactical things: the second in the list is "lambda expressions with guards
and multiple clauses" also known as "multi way if" or "multi-way lambda" and
then the most common one with 540 comments is the "Record dot syntax" language
extension proposal. Which shows that the smaller the syntax you're talking
about the more comments you get.

Okay, back to the topic.

_NV_: I meant, it's not the only factor. The record is the most commonly used
so it makes sense that people have opinions.

_JB_: Right. But we can easily get distracted by looking at what is
distracting most people. So, let's go back to `QualifiedDo`. You're right and
justified in bragging about getting it through because it means that there was
a lot of discussions and a lot of changes and refinements.

_FD_: Yeah, we had like 2 or 3 alternatives sides to decide upon.

_JB_: So how was the process from your personal point of view, the whole
proposal thing?

_FD_: I think it was very enriching because it was the first time I really had
to arbitrate the tension between people coming with different needs, different
ideas of what the proposal should be. And resolving all these tensions in an
harmonious way, I feel that was a challenge. But in the end I'm happy that we
work steadily towards a closure. And no, nobody was hurt in the process. So
that's success in my book.

_NV_: But was it productive? I have never submitted a GHC proposal but you
said this. Is it more on the people management or is the result productive
actually?

_FD_: Well, it's about talking to people certainly, so it's more about talking
to people than programming. It has a good component of research to frame the
problem and to understand what limitations you are imposing knowingly and
unknowingly. So from the implementation standpoints it just like 50 lines of
code, maybe be a hundred.

_JB_: That's surprisingly little.

_FD_: So on the other hand, you can expect a lot of code to be written that is
going to use the extension so you certainly want to get it right.

_JB_: So I wasn't following the linear Haskell development recently closely.
Are you using `QualifiedDo` now in the way you wanted to do? Is it satisfying
your needs?

_FD_: Well, for linear types, yes, I think it's working as as expected. To be
fair I have only tried `QualifiedDo` in `inline-java`, which is a library that
we wrote in Tweag to allow Haskell programs to invoke Java, to execute Java
fragments. And there we use linear types to make sure that the program doesn't
leak Java objects, so when you are finished using an object you can report to
the JVM that you are done with it and the JVM can collect it. Because if you
leak the objects then your program is going to run out of memory. So that's
where I've seen `QualifiedDo` in action and, yes, it makes your programs more
readable, if you like the monadic syntax.

_JB_: Yeah I remember that in this discussion of that extension we also had
many crazy ideas for using it to just have a more convenient syntax for lists
and things. So maybe it could be framed as abuses of the feature. But I
haven't seen them in the wild yet. But has `QualifiedDo` actually been
released? Which GHC release was it released with? Maybe it's not out there in
the wild yet. It's too much.

_FD_: Well, that's a good question. I suppose it's in GHC 9.

_JB_: Yes, 9.0

_FD_: Most customers I work with have stayed with GHC 8.10 So probably it
hasn't been in the wild and off yet.

_NV_: And can you briefly comment what is the GHC proposal procedure? I mean
everybody can go and make comments and then who decides?

_FD_: So the GHC proposal process is driven by the GHC steering committee.
Proposals can be created on the GitHub repository called `ghc-proposals` by
anybody. You're kind of invited to advertise your proposal a little bit so
that you get actual comments from people outside the committee first. So, I
don't know, talk about it on the mailing lists, and Reddit, and Twitter, and
Discourse, and these things. And hopefully a constructive and not overbearing
discussion will happen on the proposal thing where maybe committee members but
anybody else, really, like really anybody, could just comment and refine. And
when you see that discussion kind of stalls or comes to an impasse, then at
that point you would probably submit your proposal to the GHC steering
committee, at which point someone -- probably I -- will pick it up, relabel
it, assign somebody from the committee as a shepherd -- which is a single
person who is now there driving this proposal (which I think is quite useful
to actually get things done, otherwise you have a committee and things are
assigned to the committee as a whole and then that means nobody does
something). So there's always at least one person responsible for the next
steps and that shepherd will look at it more closely, maybe come back with
questions, refinement, remarks, etc. And when they have all the answers to
these question then they will make a recommendation to the committee, which
could be to accept or reject. And the committee starts talking about it. If it
turns out that, well, we can't really reject or accept either, then a
discussion is needed, and we might put it back to "needs revision".  This
means that, again, you, as in the author, have to maybe address some open
questions or maybe include some refinement and then go back and forth. And
after a few of these alterations (sometimes more than sometimes less), the
committee votes or notices that there's agreement and we don't need to do a
formal vote. This happens on the mailing list -- which is public, you're
welcome to read it, but it's still meant to be the space for the committee to
talk among themselves. And then we say yay or nay, and if it's okay, then we
merge it. At which point the committee considers its work to be done and it's
again up to you to actually motivate somebody to implement it or find somebody
to implement it. So the GHC steering committee just says "oh yeah, that's a
good idea". It doesn't say somebody has to do it.

_JB_: Which is a bit different from, for example, the core libraries
committee. They want a working merge request ready before they look at
proposals. Which is a different choice.

_NV_: But when you have the GHC request it is not reviewed?

_JB_: Yes, but the committee that reviews the proposal is about language
design. So there you would put in something like "we want a `QualifiedDo`
extension, it has this name and the syntax, and the syntax should do the
following things." And then when we are fine with that then it comes to the
implementation part. And that's when you start working against the GHC
codebase and you actually implement the thing. And now we have to get it past
the GHC developer and maintainers, who then look at, like, "did you write
sensible code?", "is it commented?", "are there tests?", "does the
implementation make sense?",... So the GHC proposals are about the design and
then the implementation is about, well, implementation. And about the who the
GHC steering committee has around 9 or 10 people. Regular people drop out
because they get bored or their term is over or something else comes up. Then
we just have an open call for nominations. Everybody is welcome to nominate
themselves. And the committee elects the next members and we're always happy
to have new motivated people on the committee. So if you want to join, pay
attention to the usual channels for next wave of nominations, which, I think,
is coming up in July or August or something.

_NV_: Yeah, it sounds like a lot of feedback and not a fast process.

_JB_: It may not be fast, but I believe it is at least functional in terms of
a process, as in not dysfunctional. I'm always asking people what they thought
of the process. Maybe there's something we need to refine.

So, maybe a different topic that I saw on your list of contributions.
Something about integrating Haskell with Bazel. I'm old enough to remember the
times when you compiled Haskell packages by downloading a tarball and running
a `./configure` and then `runhaskell setup build`. Only very recently came
cabal and kind of recently I actually learned about this thing called Nix --
which is kind of cool. And now there's yet another thing. So what is this
Bazel and why should I know about it as a Haskell developer? Or should I
just not know about it?

_FD_: So, each language ecosystem has internal tools to build its code. In
Haskell we have `cabal install` and Cabal the library. We also have Stack,
which uses Cabal the library, but does its own thing instead of relying on
`cabal install` for installing packages. These tools are very optimized for
projects that use only Haskell. If you have a codebase that includes, perhaps,
Python, or, perhaps, Java, or Go, or your favorite language then you have a
hard time convincing Stack or `cabal install` to compile and to link these
other pieces of the project. When you build your project, and you work
iteratively on it, you usually expect that you only rebuild what's necessary
when you make a change. But because `cabal install` and Stack only know about
Haskell, they only have a fair chance of detecting what to rebuild in the
Haskell part. If you change something in the code part, likely you are going
to have to rebuild everything in Haskell that might depend on it. And then the
motivation to try to look for other tools is trying to offer better solutions
to work in these settings where you have multiple language to work with. Bazel
is a system that you could think in some ways is similar to `make` where you
specify a target in the command line and then the tool will build everything
that is necessary to get the artifact for that target produced. One of the
difference of Bazel and make for instance is that Bazel allows you to define
sets of rules to build each different languages.  So when you start a new
project, instead of writing your rules from scratch to teach make how to build
Haskell, you can reuse the rules that someone else has written, and has used
for a different project. And the same thing happens with other languages. So
if you have a project that uses Haskell and Java, you can use these rule sets
and you can express dependencies using this these rules between artifacts
constructed for different languages. Bazel has a view of all the dependencies
between the files of the project no matter what language they are written in
-- which makes the build task feasible, when you want to have incremental
builds. Then, there are other goodies, like hermeticity. That means that if
you fail to declare a dependency between your artifacts, a dependency that is
necessary, it will always catch it, will say "you need to declare this
dependency".  Whereas with make when you run your `make` command if the
artifact is already present in the file system it might not detect that the
dependency declaration is missing. It might just pick the the artifact from
the file system and it will work for you and it will fail for some person
building your software as well.

_JB_: And how does Bazel achieve that on a technical level? Does it build
everything in some kind of a container?

_FD_: It has a concept of a sandbox, where you put in the sandbox everything
that is declared as a dependency and avoid putting anything else. The sandbox
can be implemented with different technologies. But that's the core concept.
You're only inputs to the commands are the files that you have said it would
needs.

_JB_: So that includes the build tools themselves? Like in nix but unlike
make, I cannot use GHC until I include it somehow as a dependency. Is that
right?

_FD_: That's correct.

_NV_: It's not Haskell specific, right?

_FD_: It's not. Basically it is written to build any language.

But the work I've been doing is Haskell specific. Because I've been working in
`rules-haskell` which is the set of rules for building Haskell code. One of
the things I've been involved in the last year is lowering or getting finer
granularity on how you express the dependencies. Right now `rules-haskell`
will allow you to express dependencies between libraries or packages.  But if
you want to get incremental builds, so you don't rebuild all of a library when
you make a change in it, you need to express dependencies between individual
module files. And expressing all the dependencies between individual modules
it's something very tedious to do in in your configuration. And then
maintaining these dependencies whenever you change the imports into your
source file. So this work is coming together with our tool to scan the Haskell
source code in dependencies and writes configuration for Bazel that expresses
the dependencies between the files.

_JB_: So it is a tool that you wrote as part of this project or is it some
other tool?

_FD_: Yeah, it's a tool that I have written. We haven't announced it yet,
because it is in the final stages of development. But the idea is that you can
have incremental builds when building up a project that has multiple packages
or multiple libraries. And you only rebuild and link what is necessary.
Sometimes it can be better than what you get with Stack or `cabal install`,
which still separates everything in libraries and packages. This is work that
has been commissioned by a customer of ours that has precisely this large
codebase, and polyglot.

_NV_: So I think it's very interesting that we start with verification and now
we went to the other side that is built system, that is very low level. So
maybe can you close with some vision about what of all this aspect is more
important for Haskell or what you see changing soon in Haskell for good?
Generally some vision about the Haskell in the future that you have.

_FD_: I suppose both are necessary. You surely want to be able to build the
programs that you have verified and you want to build them in reasonable time.
Sure if you are working with a smart program you don't care much about the
time it takes to build. But for a language to be successful, it has to be fast
to compile in large code bases. Here, performance is crucial. And, well, I
don't need to convince you about why we should try to verify our programs. But
an important part of writing software is discovering the mistakes that the
programmers do when they write it. We all do mistakes and there's no way to
avoid that because only computers can do things in a repeatably and accurate
fashion, provided that they have been programmed correctly. So there's strife
for tools that can verify programs, I think it's also worthwhile and it's one
that is going to find the future of programming.

_NV_: It's very nice.

_JB_: Well, I guess that's a good final message for this episode.

_NV_: Thank you very much.

_FD_: Thanks for having me here and see you around.

_JB_: Thanks a lot.
