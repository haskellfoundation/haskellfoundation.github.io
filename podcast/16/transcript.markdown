_Wouter Swierstra_: Welcome to the next episode of the Haskell Interlude where
we'll talk to Oskar Wickström, so Oskar will tell us a little bit about
property-based testing (PBT) Haskell code but also applying these ideas to the
testing of complete systems, he'll tell us a bit about interfacing Haskell to
other languages and even your web browser and what it's like to learn Rust as a
Haskell programmer. So welcome to the next episode of the Haskell Interlude,
I'm about Swierstra (Wouter Swierstra) and with we today is Alejandro
(Alejandro Serrano), hi Alejandro, and our guest is Oskar Wickström, and Oskar
is an independent contractor working on the Quickstrom project. Hi Oskar.

_Oskar Wickström_: Hello.

_WS_: Tell me a little bit about yourself, how did you get into Haskell?

_OW_: Yes, well this was maybe ten years ago or something it was quite early in
my programming journey or career, when I was probably first introduced to Scala
by someone who was like my mentor very early on and but rather quickly that
turned into looking into Haskell on my own and since then I've been sort of
intertwined with Haskell in one or more ways, I guess but yeah in the beginning
it was mostly just playful stuff and my personal interest in it. Yeah.

_WS_: So how did you drift from Scala to Haskell, what kind of project were you
working on?

_OW_: So yeah in the beginning there was just my personal explorations and it
was mostly just like the curiosity around FP (Functional Programming) and let's
see what first actual kind of project was probably something with some web
server related thing I remember I was very interested in like the REST
(Representational state transfer) pattern and see if I could do something like
that in Haskell, I had this trying to do very practical things with Haskell, so
to speak I saw also that there was sort of the area of web technology was sort
of well somewhat explored in Haskell but not all of what I was interested in,
yeah.

_Alejandro Serrano_: I think by that time was where there was like this
explosion of Web Frameworks like you suddenly had nothing and next day you had
like Miso then the Scotty and I think Servant was not there yet, but people
were exploring this area, so... It's weird because now it feels like Haskell is
a very backend language. So I think people approach it that way but it wasn't
until recently that we had all these nice web frameworks.

_OW_: Right, yeah, there was this other framework that I got really interested
in which I think it sort of died off, but it was based on the web machine
architecture from the Erlang project I think that is called Webmachine. But
more like this structure, more centered around resources so to speak than just
handlers on paths in web server. So I can't remember the name, it was something
with air-something. Yeah, it was a few years ago now. Anyway, so that was an
interest and I started there and picked up more and more for practical things
and started using it in some work projects I was that annoying guy that picked
up Haskell so that everyone else had to also learn a bit of Haskell I guess,
but that came this need for a compiler like tool that we use in a project so
that was a fun start and it obviously fits quite well to use Haskell for that.
So that was probably the first like actual work project we went Haskell, yeah.

_WS_: Yeah, then one thing you did is you got into property-based testing I
think right? Which is like many people were familiar with libraries like
QuickCheck or SmallCheck. Where you specify some kind of property that you
expect for your functions to hold and then you either generate inputs for that
function and try to falsify this, and then you wrote a small book about
property-based testing a real application. So usually when you see a QuickCheck
tutorial there's always these very clean examples of you know, checking whether
insert on a binary tree works or search tree works and you wrote something
about property-based testing a screen cast editor which is I think an unusual
kind of domain to think of property-based testing. So what drove you to that
project?

_OW_: Yeah, that was like the largest rabbit hole I've ever been down in I
think and so this started with... let's rewind a bit I started doing Haskell
videos first, like screencasts, producing screencasts and they were called
Haskell at Work that was also very like focused on the practical side of using
Haskell for whatever work projects and stuff like that and so I started
exploring like how do you edit a screencasts, like how do you record it, how do
you plan or like plan it, record it and then edit and I don't know it's
painful.  It's a lot of work and the sort of mainstream or traditional think
it's called non-linear video editors from the legacy of video editing back when
they had more like tapes rather than files on a disk but the whole idea around
that is very different from how I would like to think about sections or scenes
or this structure of the screencast that I'm producing and also I found that
like I was rather picky with like audio quality and recording and stuff like
that. So I didn't want to have like keyboard noise and I didn't want to... I
wanted to be like really really snappy and so I mean I recorded all the video
separately from the audio and I planned everything like down to the word
basically so I had a detailed script and I recorded all the voice stuff
separately and then I joined it together and that process of joining it
together was really painful in the traditional editor, like oh I got to move
this five hundred milliseconds or like one hundred milliseconds to sound a bit
more natural with the typing and you know. So I started on this was ah probably
a mistake but I started building a video editor for these screencasts for the
production of these screening screencasts and it basically sliced up all the
inputs automatically based on movement in video and based on the the patterns
in the audio, like silence and then I had this kind of vim-like editor workflow
where I could just grab pieces of audio and video and put them together and add
gaps they were called and you can sort of quickly process the inputs to
assemble the video and this was rather fiddly to build the editor and had lots
of complicated logic around the editing and also not only the editing the
vim-like thing but also the processing of audio and video.

_AS_: So this was built with Haskell, all this editor?

_OW_: Yeah, this is written in Haskell. It definitely doesn't compile anymore
I've tried but I like it's a mess we can maybe talk about that later. Yeah, I
think I've started writing this around 2018, 2017, 19, something like that and it
started with just trying to figure out this is actually a recurring theme in my
use of Haskell, it's just writing down some data structures and messing
around with something to figure out like what are the sort of edges of this
problem or how can things fit together and maybe write a few tests or
something.

_WS_: Data modeling, right? Where you want to figure out just the right data
structures to that are well behaveved that support the operations that you're
looking for and so forth.

_OW_: Yeah, see if you like find this nice ultra-break structure that works for
a problem or not so it started like that and is sort of just unfolded to a full
video editor with a lot of time, but the complicated thing might have been GTK
UI bits 2, well we can maybe go that direction later but, anyway so this editor
I started exploring property-based testing, that's where we started. Sort of a
roundabout way of getting there. But this was a new technique to me and I had
looked at a property-based testing before and I've been to some talks and seen
all those examples that you mentioned, list reversing and I couldn't figure
anything out and maybe there is this threshold of understanding it that is
takes some time and it takes some effort and I don't know what is the best way
to teach property-based, I really don't know.

_WS_: One of the things which I like about QuickCheck is that it was actually
originated as something to help Mark students' homework assignments where they
would think about what are the tests that we can write and if you know you can
think about 6 properties of reversing lists and then if it passes all these
then it's pretty hard to write a function which passes all these things but
doesn't reverse a list right? So that and I don't know right? It's hard because
a lot of the time people think of writing tests as writing unit tests right?
Where they say okay I just want to check that you know this certain control
flow or this series of steps I set up something and I make these calls and I
check that I get a result back and if I throw in some bogus data I check that I
get an error back and they come up with three edge cases and so forth, I think
one way that I think about this property-based testing is that what you're
doing is your kind of automating unit testing in a way, right? You don't have
to write the unit test yourself but you abstract over this and you write a
program which writes unit tests for you so that you have that program it
generates inputs and then it checks that each of the unit tests passes the way
you would expect.

_AS_: That's already quite nice, but it gives you a bit more understanding of
the program just being able to like I don't know I usually approach as you
write one unique test and then you try to run it to say ok, what are the things
which I don't really care or what things could be generated arbitrarily and,
you know, it at the end of the day it gives you a bit of the idea of what your
program is doing you I mean you can always fall on the trap of just
reimplementing your function.

_WS_: So I think what's hard though is that for a lot of property-based testing
the examples like you say they tend to be quite small functions whereas if you
have I know I spent some time in the industry and then we would write unit
tests to you know test the integration of a whole bunch of subsystems and then
you really just wanted to check that the whole thing didn't fall down so and if
you kind of explain that and then if that's what you're used to when it comes
to testing just to, you know, check that it could pass in some inputs and then
get the answer that I want whether it's like setting up some you know suppose
you're testing a web server just make a few calls to check that you get the
behavior that you're expecting, you don't typically think in terms of so what's
the specification of this web server and what's the behavior that I expect that
it satisfies and that taking that and making that generalization step right
from use a unit test that checks that the system doesn't fall down to here's
the specification of what the system should really be doing and let's check
that instead, right?

_OW_: I mean, it seems like this is a common thing for all knowledge and
learning that you learn by example, a lot and maybe some people can learn
abstractions quickly or quicker than others or something like that. But you
gather examples and you gather concrete things and then you can maybe extract
abstract from there once you've gotten comfortable with all those examples.

_AS_: Actually I was to say talking about examples I mean, I'm curious what are
the kind of properties that you were testing for the screencast editor.

_OW_: Oh yeah, I don't recall all of them like that. So let's see we had the
the vim-like editor things that were pretty simple to understand properties I
think like if you did a bunch of actions and then you undid all of the actions
you would end up where you started stuff like that or if you there were
variations on that but like redoing all the actions after undoing all the
actions then you were back at where you ended up for you started with.

_AS_: It's nice because I've also read it sometimes you know this idea of using
QuickCheck to generate not examples but actual traces of execution and then
checking the stuff I've heard a couple of times and it seems like such a great
technique to me like, you know, you don't go one step high you're actually
creating traces of what the user could do and then checking properties over
those which I think goes, you know, when I learned QuickCheck I was always
thinking of this simple function and reverse and but the idea that you can have
a traceover node I've seen it several times and I think it's such a great
technique that people should know because it works very much and you know
people in Haskell already used to having Free Monads and all these kind of
things so it fits naturally that actually also test those things if you want
to.

_OW_: Yeah, so in QuickCheck and in many other property-based testing libraries
now you have some sort of state machine testing support that's usually
something for it where you can. It's not exactly what I used but it's
reminiscent of the same thing. So with those statement machine testing
approaches you basically you have a model and you have your actual
implementation and your model is just a simplified version of that
implementation ideally and then you sort of step them like step them forward in
lockstep and see if they match in what you can observe. So but in my case it
was easier than that because I didn't need to have a model I didn't have to
implement the screencast editor twice, in a simple way I could just say as long
as I can see the end state of a sequence of actions I can, or like apply
actions and observe some sement state I just want to see this property that you
know, undoing the same number of actions as I initially did would end up in the
initial state. And I don't need to have a model so but it's the same sort of
idea of using properties on traces or on stateful systems or on sort of step
behaviors like that. Yeah so I found this very very useful when I did those
editor actions because these simple properties like undo/redo they helped fix
bugs in all the other actions that were possible so I had actions like, it was
this the video was like a hierarchical structure so you can have sequences of
sequences of sequences and in there you had like audio and video but fit
together somehow and you can sort of join and split those or do these
operations on them sort of like if you're familiar with Par Edit for Emacs or
Lisp if you have a list, exactly you can transform the structure of the
parentheses like join 2 different expressions into 1 or like remove the
intermediate parentheses or like lift and lower stuff. So it's the same idea
really that you can apply these transformations to this structure without
breaking it and I could find bugs in like basically all of these operations by
just doing the redo thing so it was really effective and the other property I
can mention was the the video processing, the audio processing was quite simple
because I found a library that could split audio based on silence but the video
thing I built from scratch basically and let's see I did some some fun stuff
there. How to hit work. Well, I think I actually generated output that I know
how. So let's go back, there was a component called a classifier I think which
took video and said like this is the scene and then this is the scene and then
this is scene. So just basically you get intervals of time, like a list of
intervals or something like that. So to test that I had this property that
generated output from which I knew where it would classify the scenes like
which were I could like generate just a list of intervals, right? And then I
could sort of transform those to video that matched, like trigger scene changes
and then I run the classifier and check that it gave me back the same list of
intervals. Basically so this this sort of reverse thinking of generating the
expected output and then running the program and seeing that you get the right
output that was. For me that was a revelation that something I would never have
thought if I were doing unit testing, that's like such a mindset shift. So the
book is about these examples more in detail. So it is pretty short and yeah it
was a really fun project and I still do a lot of PBT like in my work I used to
bring in work projects and my spare time stuff too.

_AS_: Is it easy to bring it into your projects, so I'm curious how people
react to you know, changing those, changing the, you know, people think of unit
test, integration tests and that's it and this new thing might be frightening
somehow?

_OW_: Yeah, somewhat. It's a bit of a struggle to get it integrated in a team
and like most people are curious and they can really see the value but like as
you say it's like this new, new big different thing and when they 
fail if they find something then it's maybe not everyone wants to get
going and fix them and this is a fun thing with property tests too because
if they might not expose a bug on nvery run, right? So we had stuff like a
lot of the stuff I've been doing the last few years in work projects have been
or in the work project I've been at has been dealing with stuff around time
zones and time a lot. And some bugs have like shown up three months later in CI
where it's like if you're in this particular time zone with these particular
fiddly details then you have this daylight savings time switch happening at the
right moment to like it's a mess.

_WS_: Yeah, time zones are a mess.

_OW_: Yeah. But they have found like actual bugs that no one would ever find if
in burn for like running these all over every commit so you can argue like is
that time zone bug really that important like. Maybe not, but...

_WS_: Well, I mean I know people at standard chartered right? And they have to
using Haskell and they have a lot of headaches with you know you have to
calculate interest Payouts right? But then if there's a bank holiday in England
or if I know it's the Queen's jubilee on a full moon or who knows what then
this extra clause kicks in and this is just a nightmare to model this
accurately.

_AS_: This might be the reason why my bank has set my interest rate to 0,
that's an easy calculation.

_OW_: That's the property. It has to end up at 0. But that sort of reminds me
of a thing that I've found with property-based testing I don't what your
experience or experiences are here. But if you model something like the thing
you mentioned with the bank and all these business rules and stuff you can end
up in this situation where the property is so there's so much essential
complexity around this problem. So your tests or your models your oracles,
whatever they are. Basically as complicated as the thing you're testing and
it's so hard in that situation to sort of back out of that complexity and find
a simple property or find something that where we can test it without sort of
duplicating the whole system.

_WS_: Yeah, especially if you have many of these edge cases that you have to
account for in the spec right? Then all of a sudden. It's getting the
specification right? Is as hard as getting the code right? Almost right?

_OW_: Yeah, and you have to fiddle with generators and stuff to trigger these
edge cases but not too often because it's unproductive.

_JB_: Yeah, yeah, exactly. So then on the topic of property-based testing I
guess one of the things you're involved in heavily at the moment is this
Quickstrom project. And so can you tell us a little bit about that?

_OW_: Yeah, it is a sort of sprung out of the property-based testing interest
of mine and I think this was around the time we, our son was born and my mind
was like everywhere and lots of sleep preparation and stuff and somehow this
turned it into a productive thing too. I don't know like I had these small
hacking sessions and thinking sessions in the middle of the nights, oh I have
an hour where I can be alone for a little moment so I started thinking a lot
about be well I read the TLA+ book the first bit of it the the one by Leslie
Lampport was called Specifying Systems and was looking at a TLA+ from different
angles also hillel way ands online resources and I was really interested in and
inspired by this temporal logic approach of specification basically. But also
in the sort of practical application of property-based testing on actual
programs like the sort of black box testing style or just the regular artifacts
that you would run in the end. So I haven't really used TLA+ for anything real
or I messed around with it and I messed around with Alloy a bit still I haven't
really like used it at work or used it for some interesting problem which isn't
just you know, copy pasting something from the internet. So, but I had this
interest in temporal logic and I saw some connection to the state machine
testing that we discussed before like maybe.

_AS_: Just to have all like the same ground. So when you say temporal logic how
is it that different from like regular logic?

_OW_: Oh yeah, ok. So, temporal logic or specifically the kind of logic that
I'm using is linear temporal logic and so in a regular like it's called
propositional logic you have the operators that most people are probably
familiar with like or and and an implication and you have these atoms or
atomics usually and then there is like what's the next one where you have...

_WS_: Predicate logic.

_OW_: Predicate logic, yeah. I forget these names all the time.

_AS_: Don't worry some somebody might be teaching a logic course right now,
so...

_OW_: Somewhere on earth. Yeah, I'm not formally trained in these things I
they're not like really, haven't stuck that well, but anyway. So in linear
temporal logic you have, back in propositional logic you have all these
operators and so on but you're sort of expressing something stateless. It's
just with this global state that you can say something about whether something
is true or false, with temporal logic and linear temporal logic you can talk
about time, how something changes over time or how the truth of something
changes over time so you can basically say something like well X is 1 and in
the next state X is 2 or you can so in that case, the next part is an operator.
So if I would try to formulate that a bit more structurally it would be like `X
= 1` and `(next X = 2)' or something like that.

_AS_: Like so, adds a layer to the logic to talk about like steps or passing of
time or something like this. Okay then I mean now the name makes sense.

_OW_: Yeah, I'm not sure if the temporal operators are like a modality, this is
sort of outside my expertise I guess, it feels like that to me, like you take
an like a formula or yeah and you sort of say that if you have the next
operator and some expression or some formula that changes how that formula is
interpreted, then that formula is interpreted in the next state, is that. So
basically you have these operators to talk about how things change over time,
you have next but you also have always which says that, you know, always `X =
1`, that means that X is always equals to 1 if that is true, or you can say
that X is eventually true, so eventually `X = 1`.  There are a bunch of others
but, now that you have these temporal operators you can sort of specify how a
system evolves over time or you can start specifying State Machines, basically.
So this ties back to what we talked before with property-based testing and
state machine testing so instead of having a model that sort of replicates the
actual system under test. In a simplified manner, ideally, you could instead
have this temporal logic formula that specifies the system without perhaps
being a full implementation or full model of that system, that was sort of what
I realized how temporal logic could fit together with property based-testing
for stateful systems.

_WS_: And that led's to Quickstrom, right? So Quickstrom is a if I understand
correct it's basically, it's a way to do property-based testing but for say
frontend web applications or Javascript code, right? Where you typically want
to trigger a bunch of events mimicking what a user might do in a web browser
and then observe whether the specification given now instead of usually we
think of specifications in QuickCheck or SmallCheck or any of these
property-based testing languages which is somehow being a predicate, right?
Saying that you run the function and then check this the output satisfies this
predicate, but here you don't have a single predicate but you have one of these
more advanced formulas that want to check that as you kind of throw new events
at the system some invariant holes or eventually something good happens
something like that, is that thing?

_OW_: Yeah, exactly so that is sort of the third leg of Quickkstrom is the web
or at least the the first version of Quickstrom how it started so it is this
kind of property-based testing approach together with specifying in temporal
logic but also in your specifications you also specify or you sort of declare
actions and so you can say stuff like you know click buttons that match the
selector in the browser. So you have CSS selectors to specify what can be done
or what is sort of allowed to be done and if we look a bit more at how it works
in detail when it runs a check it constantly communicates with the browser
introspects the browser to see what is the state and your the actions that are
declared are sort of matched with that state to see like okay maybe only 2 of
these actions are actually possible at this particular state and then it
randomly affects one of those and progresses and then you have a new state and
you can evaluate from there and when it's doing this exploration of the web app
and collects all the states and then it could can use the temporal logic
formula to as you said as a predicate on that sequence of states.

_AS_: I was just gonna say that this reminds me a bit of what model
checking people are doing sort of also exploring the state of of a model.  So
any relation between, like model check people are doing in this approach, you
have to property-base testing with temporal logic?

_OW_: Yeah I think there is again I'm sort of a novice with it when it comes to
model checking but it seems like model checking is about to some, if not fully
exhaustively then at least to up to some point exploring as much of the state
space that you can really, so this doesn't come near a model mold checker when
it comes to like how much of the safe space it can check or explore because
browser testing is pretty slow so it really is more like property-based testing
in that sense that you have a very or not necessarily a very limited but a more
limited exploration of the state space I guess.

_WS_: Can you do anything to speed up it because I can imagine that you don't
want to I don't know parse the DOM after every state change or that you might
want to recognize when you're in a state that you've seen previously or I don't
know I can imagine that there are a lot of opportunities to be clever, but
maybe none of these are optimizations I don't know.

_OW_: Yeah.

_WS_: Is there anything you can say about that?

_OW_: Yeah, definitely like the first thing I realized pretty quickly was that
you can't collect all of the state of the browser into the checker and then
it's like yeah I'm only going to look at these 2, you know, these 2 elements
through these properties, there is a static analysis pass of the spec which
sort of collects these or all the possibly interesting things. So you don't
have to query for everything because it wouldn't be feasible to, that is one
thing. On the speed aspect, yeah looking at stuff like cycles and so on there
is a lot more work to be done and I also have like so I started doing this as a
sort of prototype or first version and it was based on it is based on
PureScript and since then I've partnered up with Liam O'Connor and we're doing
this as a more we're doing a new version and he is an academic and has more
experience looking at temporal logic from a more like formal way. So we
basically redesigned the formal logic that we, the temporal logic that we use
and we have a new version. It's not released yet and something we're working on
still but it has a bunch of tricks going on that makes stop a bit faster.
Especially one thing I realized in my first version I couldn't, if the spec
would you know reject some sequence of actions early on like if there's like 4
actions in and then it would impossible for it to be true. It couldn't really
stop there because it didn't evaluate the spec like at each step so it would
collect a full trace and then was like ah no, you fail at step 4.

_WS_: Yeah.

_OW_: So that was that sort of silly but it's pretty hard when you start
looking at this how to do that and other stuff we have talked about doing and
we have some ideas around are basically around exploring the state space
more efficiently or more intelligently than just being doing random stuff. So
if you have let's say you have a website and you have a bunch of just
information pages or whatever and then you have some functionality somewhere
that is interesting to test. But you might wanna every now and
then go through the information pages to just to check that they're fully
broken. It would be a waste of time to just bounce around information pages
forever in all your testing so you might want to like directed somehow or have
a more guided testing there as it would speak. So we have some ideas on how
to do that and improve.

_WS_: Is that a bit like an imperfect analogy maybe is to think of writing good
generators for QuickCheck tests where you typically want to make sure that you
get good coverage of kind of, which represents real data right? The same might
be here where you want of course if you're I know suppose you're building some
online web shop right? Then you the crucial bits are you know, checking credit
card information and collecting that and not shipping stuff until it's been
paid. But at the same time you do want to kind of have simulate what a real
user might do is you know click around to find a bunch of products before
selecting the ones that they want to buy so you want to somehow way
probilistically. Get the right coverage and not spend all of your time clicking
around filling your shopping basket while still making sure that you're not
always buying the 1 product all the same product all the time.

_OW_: Right. Yeah, the analogy to generators is bottom, I mean in Quickstrom
you don't write generators as such like you don't have access to it.  You could
say. But that would be like because it sort of generates based on the state of
the web app at each step but that is the selection of actions based on like if
you know that these are the selectable actions. Which one is selected that is
sort of the analogy to the generators.

_WS_: Yeah, so you mentioned that this new implementation is not going to be in
Haskell but you've actually moved to Rust I think so can you say something
about what triggered the transition there?

_OW_: Right. So first we realized that Quickstrom implementation the new one
is actually two programs and I'll just say a short bit about that. But we
realized like the web specifics in Quickstrom aren't really tied to anything
else and we sort of split the implementation into one checking engine like the
thing that parses the specifications and that drives the checking and then it
communicates with another component which just does the sort of web specifics
of talking to a browser and executing actions and so on and you could swap that
out for something else. You could write an implementation that you know talks
to another kind of GUI or we have had wild ideas but basically any stateful
system that you can trigger actions in and that you can observe state from that
or those are sort of the 2 big operations and the checker we started building
that in Haskell and we had a prototype which worked nicely was very quick to
get up and running. But we also found that, yeah, we have some problems with
space leaks and at some point we were like yeah this is we're gonna try doing
this in Rust and we've had good experiences so far but space leaks is something
that I've struggled a bit with the video editor for instance and yeah.

_WS_: So these space leaks they presumably come from that you must have long
traces and then you're collecting data and then you will evaluate this and then
somehow if you're not strict enough these thugs to just grow bigger and bigger
and bigger until they collect, until they're fully evaluated at some point and
then finally they collapse?

_OW_: Yeah, in the specification language that is sort of a functional
programming kind of logic language and it is, it has laziness so there are
thanks in that language too. And yeah, it's hard to like invalidate those and
yeah.

_WS_: Yeah, okay. Then that becomes pretty hard to debug at some point I can
imagine. Yeah, if you have, you might describe as the ambient laziness that
Haskell supports and then the kind of laziness of the system that you're
building or the DSL or the specification language and then getting these two to
interact well and then not running into space, that I could see that can be
pretty tricky.

_OW_: That was one thing I mean we would have the problem of space leaks in our
language, in the interpretation of that language if we wrote an you know an
interpreter in Rust too like the sum of it is sort of an essential complexity
of that language that then you have Haskell's own sort of space leak problem.
So yeah, we decided to do it differently and we also were a bit burned on like
dependencies and churn with versions and so on in Haskell. So as I mentioned
before like I have no chance of compiling my project from 2018.  It's a bit
annoying but I can see the pros and cons of having it that way like if you're
used to if you pick up a Java project from like 2006 it would probably be
compiled today like without much work but they have like this really strict, I
don't know, culture or mindset around dependencies and incompatibility and
Haskell doesn't and that has well it makes it easier to progress and go beyond
these old annoying problems that we've had for some time and but it also have
some costs.

_AS_: I'm wondering because when I read about Rust like 99% of the stuff is
clearly gear to work C, C++ programmers to show how Rust is much better but of
course when I approach it from the Haskell point of view. For me, it's mostly
annoyance that I have to fight the borrow checker so I shouldn't be doing this
because I'm the the first who says that you are not fighting the type system
but somehow I feel I'm finding the borrow checker so I was I was wondering you
know how's your experience from moving from Haskell to Rust and how much time
did it take to be productive because as maybe I'm just spending too little and
you know in one month I would actually get it.

_OW_: Yeah, I haven't done that much Rust yet so I'm very new to this. But I
guess I've been sort of taking the shortcuts as much as possible. And not fight
the borrow checker if I can avoid it but in some instances like I tried to the
thing that I would have done in Haskell it would be super painful and like I
would have to pass lifetimes all over the place and like 500 lifetime
parameters on every structure and like yeah, no, maybe not worth it and then
youd like put a box around something and it sort of works.

_AS_: That's already good to know that if you go the easy route you're gonna
still get something which doesn't have a space leaks. So.

_OW_: Yeah, hopeful not, yeah, and also like it's been, I must say like a
very nice experience with tooling and so on, yeah, so far. So..

_AS_: So since you mentioned space leaks and I think that's already something
which it's hard. We don't have a lot of tools and I think also for people who
areciting with Haskell they you know. Suddenly everything is cool and nice and
then you have a space leaks and then they are hard to debug and hard to find so
I don't know whether you have you know an opinion or ideas of how we could
approach this problem. You know, how do you think we could avoid this or have
more introspection of what's going on in our programs.

_OW_: Yeah I don't think I have any very good answers to this problem I can
just like vaguely say that it would be nice to have better introspection
tooling of some sort but I'm not sure how it would look.

_WS_: Having said all of this there's a lot to be said for leakness right? I
think there's one thing I like about Haskell when you prototype something is
that I don't have to worry about evaluation order right? I can just write it
out and I know that all be taken care of and I don't have to worry about any of
that stuff. It's only when I want to get a certain level of performance or
predictable memory usage that I then have to start to become very careful about
how where to put certain bangs and what gets evaluated when and to make sure
that I be just strict enough in the right places and that's when I teach
students highschool or when like it's a particular mindset or a particular
skillset which is very hard to teach or to pick up right? It's require a
certain insight about how GCC works and there is a lot of stuff out there which
can really help right? Sometimes generating these profiles and all of this but
yeah that tells you part of the story but before you really see um like where
is this basic coming from or what's not being forced or why is something being
shared or not being shared and you need to have a pretty deep understanding I
think of what lazy evaluation is doing.

_OW_: Yeah I found myself annoyingly like middle ground in this question
somehow like I tried being on the extreme ends of this. Let's say debate if
lazyness is good or bad or whatever. But so like Haskell is often shown with
these cute nice example of like if you use lazyness you can do this. It's so
amazing. Yeah that looks cool and maybe it's useful in some particular case but
I never like use those things. I never really like leveraged that power in such
a clear way. But then if I would adopt the other way of like maybe everything
should be strict I don't know let's try having everything strict and then I get
stuck on all kinds of problems instead with a restrict evaluation and like if
I'm in, maybe if I'm in PureScript or something and I still have this sort of
Haskell mindset going then I might get bitten on strictness somehow. So I find
myself sort of in the middle all the time.

_AS_: I'm going to say I've been lazyness writing some Kotlin for work and I'm
so used to doing things in Haskell like imap and then find and then I know that
once I find the first thing which has been mapped nothing else happens and
suddenly I write this in a strict language and why are you mapping over my
whole list I only need to find 1 element so it. And I have definite feeling
that that's some idioms it's more like I don't use lazyness. It's more I use
some idioms which use laziness somehow. Like you know when you use AND an OR
and it's lazy and or search grouping. Whatever you do it and you don't really
think about it. It's just you just write and whatever the language. So for me,
that's been the hardest to move or so because other than that most of the times
you really want all your arguments to be evaluated because well that's why they
are there at the end of the day.

_OW_: Right? I did stumble upon like 1 of these things where lazyness is really
not just a nice trick but sort of an essential thing and it was in the first
Quickstrom interpreter based. Which uses PureScript as sort of the surface
language when you have like recursive bindings and you have to like build up
this recursive environment basically and then but that was like using Monadfix
but you need the lazyness in that case. So yeah. It's such a mind bener I have
no like and no goal of really understanding like to the core understanding and
embodying the full understanding of Monadfix and that kind of recursion in my
life ever. But I'm accepting that it's something I use. Yeah.

_AS_: Maybe changing a bit of different topic. But I'm always impressed
about how in it seems in every project you do just somehow manage to interface
with the rest of the world. Ah, you know you do the thing and then you know
quick, for me, it's really interesting that Quickstrom talks to the browser or
that you know you build this editor and you actually like build like as special
version of GTK this declarative version of GTK right? So because I think that's
a corner we don't look at very often interfacing Haskell with other languages
so I was wondering how is your experience there. You know not writing just
Haskell, pure Haskell but really talking to other things.

_OW_: Yeah I mean the library situation in Haskell might not always be like
perfect like stuff like GTK and so on it's maybe not super well used and pretty
in some cases very barebone stuff so like in Quickstrom when talking to the
browser you need some kind of web driver implementation and did they are maybe
not exactly as you know up to the full feature set of current web driver
specification or whatever. So it is you might have to build some stuff on your
own and I don't know it's in the early phases of a project where Haskell really
shines on like prototyping something or getting something consistent or like
well-behaved together I find that it's often acceptable to have these more
immature libraries. So to speak. But and yeah and the same with the GDK like it
would probably be easy to write regular GDK code with the Python implementation
or whatever, I don't know. I've so far been enough interested in Haskell and
doing sort of the core logic in Haskell to take that cost I guess. But there
definitely a cost because libraries are very often not the same quality as in
mainstream languages.

_WS_: And setting up the whole FFI (Foreign function interface) and marshaling
data and all of this is still not easy. I mean there's some tool support but
it's still like a significant cost right? I mean. That's at least my experience
whenever we tried to I mean be people tried to do things like write IOS apps
using Haskell or something right? And then you need to talk to a zillion used
to be Object-C, nowadays it's Swift. Libraries and then figure out how to call
something and then make sure everything is garbage collected at the right point
and convert data back and forth and then at some point the overhead to doing
that kind of programming is so much bigger than the potential gain that using
Haskell has to offer.

_OW_: Right. Maybe that's where Haskell sort of starts to find its niche or a
few niches I guess where like if for example, if you're doing backend services
or like web servers or APIs or something like that. It's easier to interface
with stuff because there's always already this ah and culture around having a
few ways of communicating between services with like Protobuf or JSON or
whatever and it's sort of easier to interface. But if you're going into a
desktop give you programming then that's pain.

_WS_: Yeah, that's true. I think that well maybe the success of the Haskell web
servers that we talked about right? It's much easier if you know there's yeah
it doesn't matter kind of you just get some JSON requests thrown and then you
respond appropriately and doesn't you don't have to go around all of this
interfacing and setting stuff up.

_OW_: Yeah.

_WS_: Okay, any parting thoughts Oskar?

_OW_: Not more than it's been really nice to talk to you.

_AJ_: Good.

_WS_: Thanks I really enjoyed that I learned a lot and it's always nice to see
property-based testing and see Haskell using practice in a bunch of domains.
And also kind of broaden horizon thinking about applying these ideas in
settings I would not expect to encounter right? That's a bit a lot of fun.

_OW_: Cool. Thank you.

_WS_: Thank you.
