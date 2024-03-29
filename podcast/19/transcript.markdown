_Andres Löh_: Welcome to the Haskell Interlude. I am Andres Löh and my host
today is Joachim Breitner. Our guest for this episode is Marc Scholten,
creator of the Integrated Haskell Platform web framework and founder of
Digitally Induced. In this episode we'll learn why the IHP is the easiest way
to get started with Haskell, why implicit parameters are massively underrated
and why nix is the future is.

_Joachim Breitner_: Marc, welcome.

_Marc Scholten_: Hi, happy to be here.

_AL_: Marc, why don't you tell us how you first came into the Haskell world?

_MS_: I think it's a good story. I started getting into Haskell in 2015,
maybe. I first got introduced by a friend who told me "okay, this is a
programming language, it's very hard to learn". I found it as a cool and
challenging kind of thing to look into. If it's considered hard it's a good
probability to be something interesting...

_AL_: What kind of programming languages did you know at the time?

_MS_: I was mostly working with PHP and other web stuff. NodeJS I think was
just getting popular in 2015. Also, Ruby on Rails. So I basically started with
PHP and the moved from there to Ruby on Rails and then NodeJS all the time. So
I was already exposed to a lot of technologies. It was cool to see that there
were still things that are considered hard that I don't know.

_JB_: So these were all web technologies as far as I can tell. This is
what you were doing at the time, web development? Or, what were you doing at
that at that time?

_MS_: I was working for a startup basically and I was doing web programming.
So I basically started programming with web programming. I started with HTML
and then kind of learned PHP to make it dynamic, in 2011 or something. So I
always focused on web programming.

_JB_: And how did you go about learning Haskell? I mean there are so many ways
of doing that, and I guess you picked a successful one.

_MS_: I pretty much learned programming by myself. I think a lot of people
learn Haskell in university. But when I learned Haskell I was not in school. I
was not at a university where people sometimes get to learn Haskell. I just
Googled around and I found "Learn You A Haskell" -- that's why I still
recommend it a lot. I learned by doing. I figured out it really changes the
way you think about computer programs. At that point my thinking was very
imperative, object oriented kind of thinking about how to design a program.
And when you're exposed to functional programming you kind of rewire your
brain to think differently about problems. That made it actually very
challenging at firs. It's easy to write your first couple of functions, like
doing very simple expressions and stuff. But when actually try to compose
programs out of these it gets very complicated because you don't know how to
approach it. With imperative programming you know how to do it. But if you are
in a functional project it's hard to rethink that. That took me quite a while
to get to know Haskell, understand how to build something in functional design
and, basically, build small programs.

_AL_: But I guess you must have liked it or otherwise you would not have
stayed with this?

_MS_: Yeah, I was actually exploring at the time some things related to F#.
There was some website I saw that some examples of how you can use types to
design your program and use that to drive everything. I found this really cool
and thought this can be done with Haskell. So I found this kind of
interesting. But I also quickly figured out that if you build a Haskell
program, it actually mostly works when it compiles. I think this is a
controversial thing to say on the podcast but, compared to NodeJS, it's
something like a fact that if you have a Haskell program and then it compiles
it will most likely run successfully, even with no test, and in NodeJS.. good
luck. It will mostly likely crash with some error message. I always complain
about the Haskell error messages, but it's also not that good in NodeJS.

_JB_: No, I don't think it's controversial to say that on a Haskell podcast.
It's probably something that all of use have experienced while learning
Haskell. That's why we ended up staying involved. And there's certainly truth
to that.

_JB_: OK, so you got excited about Haskell as a thing to learn out of
curiosity and, I guess, there was a challenge too. So, how did you go from
there to starting a company around it?

_MS_: I basically started Digitally Induced in 2006, right after finishing
school. We basically started doing with startups, software systems for
startups. It was just me at the time. I think our first projects were NodeJS
and everything, because that was the job thing at the time. And that was kind
of hard or painful to see how the quality was. You want to move fast and you
want to do everything quickly and everything but then you have a lot of random
errors. This is very painful to see when your system crashes in production. I
was always thinking that Haskell can do this better and in reality we were
using something like NodeJS and it's always causing problems. Also, we were
working with Ruby on Rails at the time and there I saw that you could work
fast but you have to make a tradeoff with quality. With Haskell I could see
that I can work fast and not have this tradeoff. So, as I was working with
these technologies, I was side hacking with Haskell and playing around. I also
wanted to do something with the web because that's my background. I started
looking into how to use the Warp web server to get something done. I looked at
the existing frameworks but I found them very complicated and did not use them
very much. I was probably too inexperienced to work with them. So I just
followed Stack Overflow and got Warp running. Then started building small
things just playing with Warp and running from there. One thing I hated about
Haskell was that Cabal was so slow. When you have PHP, or in Rails or NodeJS,
you have very fast development cycles. In Haskell I didn't have that. So the
first thing I did was for my Warp web server I just did a thing that just
refreshes the thing in GHCi whenever something changes. I think in the first
version we just told GHC to basically restart the program, which was still
faster than Cabal. And this was the first thing that got turned into IHP, this
reload cycle. At that time I'm not sure if there was something like this in
Haskell, but I was not looking for that. I was just thinking that I need
something for faster development cycle so I have a similar experience like in
other languages.

_JB_: Did you say you were already using GHCi, the interpreter, to read out
quickly, or were you just recompiling and restarting when you saved the file?

_MS_: I think the first version was actually just recompiling but not with
Cabal. So it was faster than Cabal, Cabal at that point was still very painful
to use and I still remember at some point I actually got to a point where I
had Cabal reinstall everything.

_JB_: The Cabal hell.

_MS_: Yes. I think it does not exist anymore. I think it has been fixed in the
meantime, but in the past I had this multiple times. So I just tried to just
have something that is fast, where I can make changes and see it on the web. I
think I built from there, I just built whatever was missing to do what I
wanted to do. This was quickly connecting to some database, the first version
was just PostgreSQL. After a while I added the first code generator for
database operations. In the past I was working with PHP ORM and in that ORM
there was a lot of PHP code generation going on. So I basically just copied
what I knew from there to Haskell, and that was part of what later became IHP.

_AL_: OK, but if I understand you correctly the desire was to eventually get
to use this on real web development projects for your clients at Digitally
Induced. How soon did you achieve that goal? Was that easy once you had
something up and running? Could you actually put it into production or was it
a very long and difficult road?

_MS_: At first it was actually not really the goal to have this. I was really
just playing around with it, because I thought it was cool to play with the
technology. After a while I wanted to use that because I saw the pain of using
other technologies and thought this is so much better, why don't we use it
instead? At that point we had the first couple of people working at the
company and we had some smaller projects where we could use it, probably in 2017.
There were smaller things where we could use it and we just tried it out
because sometimes you have clients that don't really care about technologies
because it doesn't matter that much. It's a small project and we could try it
out, take a risk to see whether this works well and where it doesn't work. So
we got the first project into production at that point, but there was still a
very raw very, it was still a tiny wrapper around WAI, Warp and other Haskell
libraries that were already there. So, step by step it kind of grew. We always
added something when something was missing, or sometimes we just took the
application code and extract to the framework step by step. I think also
around the time we figured that this is something cool, seems like we have a
pragmatic way to build Haskell stuff compared to what I consider complex web
frameworks out there.

_AL_: So, if we fast forward to today, how much of your company is now doing
web applications for your clients? How much is developing IHP itself? Are you
still doing projects in other languages or is it all Haskell now?

_MS_: Basically IHP itself, the core, is open source. So we are not in the
business of building IHP. We do a lot of projects with IHP at the moment. I
think it's half-half, we have still a lot of stuff from the past that is not
with IHP, but we also have new projects that are using IHP. So, most of our
work is focused on doing software with IHP and not really developing open
source. It's also not good for the framework: the framework needs to be
designed from the real world, not from thinking about the real world. It's
better to build something specifically and then extract out the generic code,
because then you know it actually covers the real world well, if you have done
it in a couple of projects. These APIs are generally well designed. Some of
the APIs in IHP are not designed that way and there are typically worse in
quality and sometimes need to be rewritten a bit more. The stuff we extract
from existing projects, these are things that really work.

_JB_: Can you give us a concrete example of something where you design an API
thinking it is good and then it turns out that just doesn't work in practice?
A good anecdote you can tell us?

_MS_: Oh, yeah. I think IHP serverside components are such a thing. It's like
the IHP version of live view which projects such as Laravel have as well. We
designed it because it was a cool experiment but it's not been used in
production by us in any project. For that it feels like it has certain
limitations, and it would have been better if we would have used it directly
in a project and then extract it out. Then it would not be missing critical
stuff. With serverside components there's so much to do because it's not
designed. We just released it because it was a cool experiment and is still in
that experimental phase. It's actually cool, I think some people don't know it
exists, but I think it's a cool way to work with IHP, though not that ready
for production as other parts of IHP.

_AL_: So perhaps we can talk a little bit more not from the historical
perspective but from today's perspective. What IHP has to actually offer? I
must admit from my own perspective mostly when I had something to do with web
I've been working on the backend, my favorite framework is personally Servant.
But why would I want to perhaps look at IHP? What are the cool extra things
that I would be getting?

_MS_: Generally, one of the IHP design values is that we want it to be very
simple, in the sense that it's easy to get started with it. Which makes IHP
very friendly for everybody who's coming from other ecosystems, like Rails.
For example, I think we have a lot of people coming from Rails, trying out
IHP, because they like the kind of productiveness of Rails but want to have
some more type safety. Or, we have people that work with Elm and think Haskell
is very complicated compared to Elm and want to still build a backend for
their web applications. One of the things we do really well in IHP is that we
have this kind of thought out process from start to end on how the API is
supposed to be used. So, if someone is just trying out Haskell, it's probably
the easiest way with IHP because we tell you all the steps and there's a lot
of materials on when something goes wrong how you deal with that, and I think
that's something which works really well. Taking that aside, we have a lot of
good stuff, like HSX, which for someone that has been working with React is
cool because it's very similar and copies a lot of similar ideas to Haskell.
We also have this integrated development tooling which saves a lot of time.
It's really helpful because you can just quickly build something even without
writing any code, which makes it a bit faster. It's a quick way to generate a
lot of stuff and boilerplate. We have a lot of code generators and everything
is kind of built in and you don't have to install like 10 packages to get
started, this is one of the advantages. Compared to other frameworks, IHP is
also full stack, so we are really designed for building applications where you
build a backend and frontend in a single project. But in recent versions we
also added APIs like IHP DataSync which allows to build React applications
with DataSync. I think not enough people know about this, so it's probably
worth talking about it.

_MS_: We've basically been looking at ways to work better with React. Because
a lot of people use React with IHP, and even we do it in our projects. One
thing that's always kind of painful when interfacing with React is you have to
do the mapping of data structures from Haskell to your React application. And
you always introduce some errors there and in the data mapping you always lose
type safety and everything. We've been looking into ways to make this simple.
We basically ported core IHP functions for the data layer, like
`createRecord`, `updateRecord` and `deleteRecord` to JavaScript, so you could
call these functions from the browser. So the syntax is very similar to the
Haskell syntax and this allows you to build dynamic web components with an IHP
system on the backend side. Direct interfacing works together which is really
cool because you have the best of both words. You can do the hard stuff in the
backend in Haskell and, when you have something very dynamic you can IHP
DataSync to build a direct view and still access the same data without writing
an API layer first. It works really great and makes everything real time.
We've been just using this in a project to save so much time.

_AL_: So I understand all of this. I found it interesting. Initially you said
you want to make Haskell simpler, and I can understand from what you explain
that basically the integrated aspect of IHP is a good vehicle to make it
simple because it just answers a lot of questions for the programmer
initially, like "how do I do this?", "how do I do that?". There's a standard
way to do things and that's documented and so on and so forth. But many people
are perceiving the Haskell language itself to be complicated, right? Are you
trying specifically in the Haskell code that you are generators to not use
advanced features or all you embracing all that?

_MS_: Thing is, Haskell language is probably simpler that many other
languages, in the Core basically. If you look at the grammar of some popular
languages, I think they are much more complicated. Haskell in that sense is
much better designed. It's just that Haskell has too many options sometimes on
how to approach things and that makes it complicated. Especially when you look
at people who have been exposed to other programming languages and have this
problem where you need to rewire the brain to understand it. When you then
have so many options, I think that's where it feels complicated. But in IHP we
try to not use what I would consider very complex features, just because of
design trade-offs. So, if you saw "we want to make IHP easy for people
beginning Haskell" we need to make sure that if you do basic operations in IHP
that is not exposing you to stuff that is very fancy Haskell. Like if you need
to write your own type instances for examples to get some basic operations and
IHP running, I would consider this to be a problem because type families is
problaby something you don't learn from the beginning when you are digging
through how to write your first expressions and functions in Haskell.

_JB_: I played around a little bit with IHP and I guess one example of where
this design leads to is that most of the code is just plain IO monad and then
you pass around environmental information using implicit parameters which I
personally like in some context. But they are frowned upon by the majority of
the community as far as I can tell. So would say that an experienced Haskell
programmer in an independent approach surely shouldn't be using this pattern
and should be using their favorite monad stack or `Free` monad or algebraic
effects or whatever? But in the context of IHP you wanted to make it more
approachable and therefore chose to use implicit parameters and a simple IO
monad. Or are you saying this is actually a good pattern that people should be
using more? Implicit parameters, just to pick an example, has a bad reputation
for no good reason?

_MS_: I would say it's proven that this pattern actually work well. For me, I
was actually not thinking about that because, for me, it's just the way it is.
But it's actually a good point, most other people probably use monads more
than us. We actually added a monad stack -- we only have one -- in the config
side of IHP, this is now powered by a monad stack. I think this is a good
point where the monad stack adds a lot of complexity because it's like you
need to understand how monads work and then you need to write a lot of
boilerplate for connecting your stuff with the stack. The IO monad just works
very well and implicit parameters are underrated in a sense, because they
provide a similar thing as the Reader monad. But as the types are simpler you
still have only plain functions. Because it's passed implicitly, this is a
good thing. Maybe I should start with why did we even add implicit parameters.

_MS_: So, in the very first version of IHP I did not know about implicit
parameters. We were just passing database connection to the functions that run
a database query. But the problem is this adds a lot of noise to your program
in the sense that in a web application you don't really care about the
database connection. You really care about what is the function's query, so
you want to have some focus on the data itself and not on the thing about
querying the database. It doesn't matter that much how it's queried, you just
want to get the data out of it. If you always explicitly pass everything
around it then everything is important, nothing is important. And you can't
design your code in a way where you can focus on what's important and what's
not important. For web applications certain things are what we consider
important, and things that are not. Implicit parameters allow us to do exactly
that. In a web application you always need to have certain things in the
context, and this context contains the database connection, the logger, the
base URL of your application and stuff like this that needs to be available.
But you don't really want to explicitly pass this around to all functions
because then all functions have like 10 arguments and it gets hard to read
what matters. If you think about other web frameworks, like Rails -- actually
all other web frameworks in object oriented languages -- they always do this.
Implicit parameters is kind of what object oriented programmers do with this
basically. We just copied this kind of thing and applied it to IHP with
implicit parameters. Generally, it seems like there's no real downside of
that. So we've not seen a limitation and we've probably written like tons of
IHP applications from small to very large and it's never been a limiting
factor. It's advantage -- there actually are advantages -- is that the error
messages are really good, compared to what you get if you a monad transformer
stack, because there you have a myriad of instances, it gets very complicated
quickly. With implicit parameters the error messages don't explode like in
monad transformers.

_AL_: I'm trying to think back in time when I first encountered implicit
parameters and I also have the feeling that Joachim has that somehow they've
always had a little bit of a bad reputation. But I'm actually wondering where
this is coming from?

_MS_: There's one problem with implicit parameters, there are cases where you
don't have the program behave as you think it should behave. But in IHP you
don't manually deal with implicit parameters. Basically the framework passes
the implicit parameters but you don't really manually handle them and that
kind of avoids this problem. Otherwise you would probably run into edge cases
but we kind of don't run into these edge cases.

_AL_: Yes, but I can abuse many features, but it is a valid point that you
have to have a little it of discipline and that's what IHP is doing. It's
particularly well suited for this.

_JB_: I think some of the criticism is about the way you provide them, which
is something you wouldn't do in IHP framework as a user, where you have to let
bind them and then it's kind of implicit where it exits the scope. I think
there are also examples where it appears to break referential transparency.
You have an expression and you move it around and you don't know that the
expression has an implicit parameter -- this dependency is not made very
explicit. And once you go to higher rank types and you put the implicit
parameter in there, things become a bit more complicated. But these are things
you wouldn't do as a user of IHP framework.

_MS_: Yeah. This again, it's like a tradeoff in the design space between
wanting to make it simple to use but also keep like the great properties of
Haskell. So, in practice, while it has these edge cases where it makes your
program a bit more unstable or decreases quality, in our case it does not
actually apply that much. So it is a tradeoff between making the programs
simpler, easier to use and everything. And especially with dot notation, I
think it provides an even more simpler approach. I hope this will get more
popular outside of IHP in the future.

_AL_: So one thing I was wondering was that on the one hand having everything
integrated is really nice -- certainly for people who want to start, and we
can talk about perhaps a little bit more --, but it's also making it sort of a
harder sell for people who might want to switch, because it feels like you
cannot try, for example, one particular component of IHP. At least at first it
feels like it's all of nothing. Is there a way to take it apart, even though
perhaps that's not the intended way of using it? Is there a way of using some
of the IHP functionality without doing everything?

_MS_: At the moment not really. It's the full package deal at the moment. So,
first step we've done in this direction is we've put HSX into its own package.
So it's its own package and can be used outside of IHP, basically. But in that
case it made sense, because some people actually wanted to use it for other
features. Some of the code is so intertwined to IHP and IHP way of thinking.
IHP is not meant to be a library, it's more like a real framework. There is
this separation between a framework and a library where you can say you call
the library but the framework calls you. So, IHP is more in the style where
IHP provides a structure where you place the logic but IHP sees the whole
control flow of the application.

_AL_: Fair enough. So, if you now look at the users of IHP, would you think
that they are, to a large extent, actually people who have not been using
Haskell before or are you having many very experienced Haskell programmers
among your users? What's the kind of feedback you're receiving?

_MS_: I think we have a lot of people that are trying out Haskell. I think a
lot of Haskell experts already have their framework of choice and don't want
to switch. We have nearly 400 people on our Slack. So it's already kind of a
big community. We have a couple of thousand of users on the IHP mailing
list. So it's kind of its own subcommittee. A lot of people that are well
known in the Haskell community sometimes are not that much into IHP because
they have their own way of doing things already and maybe IHP is not a good
fit for them. But we have a lot of people coming from Rails background, from
Django background, etc. using IHP now. Another benefit we have in IHP now is
that we have this great community that people having a problem about a
specific IHP thing can just go on slack and ask a question and get an answer
relatively quick because everyone is also working with the same IHP, same
packages and everything. Because it's always managed by Nix. It's always easy
to get a problem solved because everybody is using everything pretty much the
same way. This is also a certain advantage of the IHP community. But in
general, I think a lot of people are just trying out Haskell and seeing IHP
somewhere.

_AL_: That's great. What's the outcome of this? Is it "IHP is great but I wish
it didn't use Haskell underneath"? Or "IHP is great because it gets me into
Haskell and I want to do more Haskell"? "I want to use this Haskell library
that isn't in IHP, so please integrate it as well and make IHP even bigger"?
What's the kind of pressures that you see on the wish list?

_MS_: I think a lot of people are really loving IHP. A lot of people are
really excited about IHP in general. If you actually go through IHP Slack
there's lot of messages, for example just a random one, I think it was when we
launched the 1.0: "Love what you've done. Never used Haskell before. Will give
it a go". This is kind of the idea we want to use IHP to give people a reason
to use Haskell. It's like the entry drug to figuring out functional
programming. I think a lot of people really get excited about this quickly.
When they learn that they can have type safety and the productivity of
something like Rails or Django, now they can learn more about Haskell because
they get to write a bit more logic. First you just use a IHP schema designer
to add your tables, you generate a couple of controllers. You modify a bit of
HSX templates and everything works, now you already have an application
running. Now you need to actually write your first logic and now you need to
learn about Haskell. While it's still probably a bit hard, you already have
this feedback loop where you can see things on the screen and you can see
output and see progress. So this makes it much better in general experience. I
think a lot people then just go on with this journey and are very happy to use
IHP and Haskell to build stuff. We've also seen people that think Haskell is
their favorite kind of language but have not considered using it in their work
projects. With IHP, sometimes, people have more confidence in using it for the
work projects because it has a lot of the infrastructure that is needed for
you to give confidence to it, basically. So people that want to use Haskell
but cannot use it sometimes pick IHP because it provides a lot of things other
framework maybe don't provide in the same sense.

_AL_: Are there any things about Haskell or GHC or the tooling or the
ecosystem that you think are painful to work with from your perspective, or
that you think that IHP cannot easily fix and shield users from?

_MS_: I think error messages are a core problem. The errors of GHC are
sometimes too complicated are not really helpful. It's a big problem, because
this is where people get stuck. I've seen this a couple of times where people
that were live streaming IHP development -- I followed that -- and you someone
gets stuck on an error message. You sit there and watch the stream and think
"I know what the problem is", but the person streaming does not know and does
not really understand. GHC sometimes tells you there's an error but maybe the
error actually happens somewhere else or it just tells you the error in a very
complicated language. Someone who's just trying it out the first time doesn't
understand it. I think understanding GHC error messages is kind of a skill to
learn and get used with with time. This makes it kind of a problem because
people that have too much Haskell experience don't really fear this pain
anymore. They just know when GHC says this you need to change this, it's like
pattern matching, you've seen 10 times before and you know what you need to
do. But if you've seen this the first time, it's complicated.

_JB_: Maybe at this point we should advertise the project by the Haskell
Foundation to create a Haskell Error Index, which is a website that will
collect information for all the Haskell errors that Haskell produces. Then all
the errors will get a number that you can Google for and you'll find a long
explanation of things and that, hopefully, will help. Especially your audience
here, so contributions are welcome. So, if anybody who listens here and wants
to help with that, then Google for Haskell Error Index and start contributing
and explain that.

_MS_: I've been also talking with David from the Haskell Foundation, and
before, Andrew, and told them that I hope we kind of help in that sense by
complaining enough.

_AL_: I think it's pretty uncontroversial to say that GHC's error messages
could be better. I think most people would agree. It's just not always easy to
figure out how, in some cases it might be not an easy problem to solve. But
this error message index is certainly a step in the right direction. If you
can't make them better or easier to understand on their own you can at least
make it easier to find extra documentation about them. Also, one aspect is
just that often they tend to be very verbose, they have lots of information in
them but in practice you only need a very small part and it's very difficult
at the moment to remove the extra information. But if the information is in a
separate index for documentation, then perhaps this can actually be fixed. But
I think (getting) good error message is a difficult problem. In the past, at
Utrecht University where the Helium compiler was designed for a while -- this
was a Haskell compiler that was specifically designed to have good error
messages for beginners. There was a lot of effort being put into giving
meaningful type error messages, but it only ever supported Haskell98, or a
very small part compared to what people today consider to be proper Haskell.
Even type classes were difficult to add. If you see all the extra features
that GHC has over standard Haskell, there are quite a few error situations
where it's basically an unsolved problem. Unfortunately, I think in the
research world, it's not rewarded to work on good error messages, or not
sufficiently rewarded. So researchers get their research credits for adding
new features to languages or proposing new features. But saying "I can produce
a better error message for this well-known issue" is unlikely to make
academics really excited and that's perhaps a bit sad.

_MS_: One example I can think of is the new (record) dot notation, which is
actually one of the most underrated features in Haskell -- it took a while to
get finally merged. I was following that RFC for a while. I think it's a great
feature, but the problem is that now if you mistype a field, for example, it
does not say that this data structure does not have the field, it gives you a
missing instance error. Basically, it makes sense because it's just a wrap
around the `HasField` class, right? In this case, it's technically correct.
But as a user if you just learn Haskell you think "cool, this dot notation I
know from JavaScript or some other programming language and I'll use it". You
would expect to just tell you "okay, this field does not exist" but basically
it gives you typeclass errors which is not helpful.

_AL_: Basically it's an implementation detail leaking, right? You have a very
general mechanism -- which is justified, I guess -- but then most people think
about this dot operator just as field projection and it would be nice for the
common case to get sort of an error message in those terms, without exposing
all the underlying generality. I think that's a very common problem for
Haskell where we build our own EDSLs and layers upon layers of abstraction and
this encourages people to just learn the DSL -- "how can I use this little
sublanguage within Haskell?". But the moment you get an error you're back to
square one, because the error message is exposing all the nitty-gritty
underlying details of the implementation. And then you have to understand how
it is implemented. I don't want to talk too much about Helium, but there's
another nice feature that it had back then that, for DSLs, you could get DSL
specific messages. For example for parser combinators if you would a type
error with parser combinators you would get an error message that is specific
to the user of parser combinators. Perhaps, it would be a good idea to try to
add something like this to GHC as well. Sometimes we can just hide some of the
underlying complexity for those cases where you're actually thinking on a
different level about your program.

_JB_: So you're not only using Haskell as some kind of cool project that you
want to expose people to, but the whole thing actually uses Nix to get IHP on
the user machines. I guess this is another of those obviously correct but
still bold technology choices, from my point of view. In this case it's a bit
strange because you're building a framework where you control everything, so
it wouldn't be too hard to just bundle it up in all bundle with a few static
binaries in there you place on your path and you're done. So I'm wondering how
did that go for you? Is it causing trouble? Are people happy about it? Is it
something that your beginning users, or entry level users don't even notice
that there's something interesting underneath?

_MS_: I think Nix is also underrated. It's probably even more underrated than
Haskell. It's now getting to the point where it's really good and brings more
advantages than painful experiences. I think in the first release of IHP in
2020, we had a lot of people -- there was even a GitHub issue -- that asked us
to remove Nix and just offer something else because some people got burned by
this and then they don't want to touch it again. It was more painful in the
past. Installing Nix on MacOS was really broken and then there was also a
problem on M1 Macs for a while. So it has caused some problems but I think
there are actually some advantages -- and we see this in practice: we have
projects from 2017-2018 here, these very old projects, where we had the first
version of IHP, and we still can run them. We just go to the project and we
run it -- except under M1 Mac, there's a problem, we need to update to later
packages. But on a normal Mac you just can still run it. Try that with npm
projects. We have npm projects where after half a year we are not sure if we
can get back to the project without spending a lot of time to get it working
again, because it moves so fast. With Nix you just know it will work again. So
this also simplifies a lot of the deployment. Like building a docker image is
super simple. At Digitally Induced we just do a lot of different projects and
when you switch between these projects it's a bit of pain to get the
dependencies and everything running as it was in the past. There was Vagrant
that was very popular in 2005, before Docker became popular. It worked really
well and provided a really great experience where you could just type `vagrant
up` and you were in the project and everything was working. I think `docker
compose` now has a similar experience, but it's not really there with Docker.
We really wanted to have the same experience but with Nix instead. I don't
think it's such a big problem in practice anymore. I think Nix is really where
the future is going to be, so IHP is really positioned for that. Other people
on HackerNews commented that combining Haskell with Nix is like a competition
of the worst ideas. But I think they're a great fit. Hopefully more people
when they use IHP will then figure out that Nix is actually a really cool
technology and continue to use it. It happened that a lot of people have kind
of been exposed to Nix and figured out a bit more of everything. For example,
one of the people in the IHP community is building this Shipnix service, if
someone want to try it out. He got into Nix just by being exposed to IHP and
now he's building kind of a service where you can even deploy stuff with Nix.
I think this is really cool. Nix, generally, in 10 years will probably be very
very popular. It took a couple of years to get Nix to a point where it's
productive to use. It's an exciting technology in general.

_AL_: I certainly can share some of your experiences. I'm using Nix for a long
time as well and as a Haskell consultant, we also work with clients having
various different configurations -- that's just one aspect that's always been
very pleasant. I mean obviously you build completely different environments
and docker images and so forth, but just setting up various different
toolchains and dependencies and environments using Nix is very quick. I guess
the question in the context of IHP is: you're integrating already quite a few
design choices and then you're integrating yet another rather substantial
design choice as to what kind of OS tooling you're using. If the goal is to
have something integrated with everything then perhaps that's not a big
blocker in any way?

_MS_: Nix also allows us to bundle the PostgreSQL server. Folks have a good
simple case, where in dev mode they use sqlite and this is not great because
in sqlite you don't many of the features that make PostgreSQL great - like
constraints I think are not available in sqlite. So you can easily do
something that works in dev mode but then doesn't work in production, because
your build mode is different. I've seen this a lot of times. The problem is
when you set up PostgreSQL and you have a lot of projects -- which we have as
a company -- you sometimes have different PostgreSQL versions and everything.
And then it's a pain to work with a project. The experience with sqlite in
general is great, everything is bundled in the project. But you don't have to
do the manual setup of PostgreSQL to get the technical advantage of
PostgreSQL, you don't want to have the setup cost associated with that. With
Nix, you can basically get both. We can have bundled PostgreSQL, without any
manual setup. It's all done by the integrated server of IHP, it just calls
PostgreSQL and starts the server locally.

_AL_: As we're close to the end, we should look a little bit to the future.
You've recently released IHP 1.0. So what are your plans? Continue evolving
it, making it even more successful than it already is? Or are there big new
things on the horizon or also big developments in the Haskell community you're
looking forward to?

_MS_: I think in general the core thing is not making it much more popular. I
think it's already very popular in terms of number of projects. I think from a
technical side there are still a lot of things we want to actually ship which
we sadly didn't get in version 1. One of this is internationalization. We had
some projects where we have implemented internationalization already, just not
fully extracted into IHP. So some parts are work for internationalization. For
example the URL generation and routing system actually can do
internationalization now but it's not documented and a lot of other parts are
not extracted to IHP yet. So this is something that we will add on the future.
Nix flakes I think will be very cool. I think this will help us make the
current setup a bit more streamlined. Nix flakes is still experimental feature
and should not yet be used without a flag. I think these are some of the
features we'd like from a technical side. Outside that, we really just want to
grow the ecosystem. I think there's a lot of companies that could get a lot of
value by using IHP. And we see even more companies adopting that. We have a
lot of interesting companies that you would not think they use Haskell. A lot
of these companies evaluate what are the framework like, the most active
working framework and stuff and then some of these pick up IHP and we get to
work with them and do interesting stuff. I think this can grow more if we grow
the IHP ecosystem. The overall mission of IHP is really to make Haskell more
popular, in the sense of how Ruby was made more popular from Rails. We
basically want to do the same thing for Haskell. Then you have a killer
application in the Haskell ecosystem for people to start using Haskell and
experience the great technology that is available within the Haskell
ecosystem. IHP really wants to be that.

_JB_: So that's the future of IHP and what good it would do for Haskell. What
do you expect from Haskell to become or to do in the future to benefit IHP?
What is your wish list?

_MS_: First, don't remove implicit parameters. This would be bad. I think in
general error messages. Dot notation was my favorite feature that has been
added in a long time. It's now been added so that's good. I think also making
compile times faster could be a thing. Generally anything that makes the
experience better. I don't think, for example, there's a lot of development
into making Haskell even more type safe, but I don't think this is valuable
because you get most of the value just by switching from something else to
Haskell. By making Haskell more type safe you might catch a couple more errors
but it's diminishing returns and it's probably better to spend resources to
focus on general experience, like making everything faster and better error
messages.

_AL_: I think that's a nice message to conclude on. Thank you so much Marc for
taking the time to talk to us. And good luck with making Haskell and the IHP
yet more popular.

_MS_: Thanks for having me and for everybody listening who has not yet tried
out IHP, maybe just try it out and if you have any feedback feel free to share
in the IHP community. I'm happy to hear what everybody from the community is
thinking about IHP. Feel free to join the IHP community if you're interested
to see what's going on there.

_JB_: Thank you.

_AL_: Thanks.

_Sponsors_: The Haskell Interlude Podcast is a project of the Haskell
Foundation, and it is made possible by the support of our sponsors, especially
the Monad-level sponsors: Digital Asset, GitHub, Input Output, Juspay, and
Meta.
