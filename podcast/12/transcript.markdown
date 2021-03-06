_Wouter Swierstra:_ So welcome to the next episode of the Haskell Interlude. I'm
Dr. Wouter Swierstra.

_Andres Löh:_ And I'm Andres Löh.

_WS:_ And today our guest is Gergő Érdi. Gergő has an interesting path into
Haskell taking many twists and turns. We'll talk a little bit about that. And
discuss his recent book on implementing retro computers using Haskell.

So, welcome! And our guest today is Gergő Érdi and Gergő is famous for many
things, which we'll talk about. So both his work at Standard Chartered, his
research and the papers that he's published, and a recent book on retro
computing using Haskell. So Gergő, maybe we can start by saying something about
how you got interested in Haskell.

_Gergő Érdi:_ Right. Well so um, my connection to computers in general,
basically started back in the early Eighty's like I think everyone in my
generation. So I grew up on the Commodore 64 where I was programming in BASIC
and for some reason I never got interested in machine level computing. So like
you know, using Assembly and machine code. Everyone was basically forced to do
that on these machines because the machines were so underpowered and there were
no good high level languages for using most of the hardware. But for some reason
I really don't know why I never made that leap. So it was just BASIC and then I
tried finding some more featureful BASIC dialects.

But this was like you know, when I was a kid. But this theme of going upwards
instead of downwards seemed to be persistent and then I started using Linux. And
I started looking for some real programming languages. I used C for a bit and
C++ and then I went in the Lisp direction for a while.

And I had this, I guess, the stereotypical experience of using Lisp of suddenly
realizing that there's so much more out there than what is thought possible with
programming languages so I did Lisp for a bit.

So I used Lisp for a while but I didn't really use it. So there was no like
actual tangible end product of that unlike C++ where I got involved in some open
source project. But I really enjoyed Lisp and then I started my formal Computer
Science studies. I played around with Lisp some more but then I also started
working at Intentional Software. And there we were using C# for for all the
stuff that was not and possible in our in-house languages. So the whole idea was
that it was a language workbench where you'd make your own languages and we were
dogfooding it. So we were making our own languages for solving the problem of
giving you a tool of making your own languages but the bedrock of it was in C#.
So I programmed in C# but that was not really something that interested me.

_WS:_ But this is um, ah just to get the timeline right? So this was BASIC and
messing around in Commodore 64 in high school or whatever age up to eighteen
maybe, and then getting drawn into Linux a little bit and then you studied in
Hungary, right?

_GE:_ Yeah, so okay so the timeline was basically that says C64 was yeah when I
was a kid and then high school I but high school I I was doing I was mostly
using C++ for for open source GUI apps.

So I got involved in in Gnome and then I had this really big detour of six years
of medical school and during that I was basically contributing to open source as
a kind of keeping my sanity.

So I really didn't enjoy my time in in that school.

_WS:_ So the medical degree wasn't for you. But you kept programming
nonetheless.

_GE:_ Yeah, so I I was programming like, I always liked programming. It was
something that I regarded as like a hobby that would be cool to do on the side
but it's not necessarily something I took that I would want to do
professionally.

And so I yeah so I trained to be a doctor and then halfway through I realized
that is just not for me. But of course by then, you know, because of the sunk
cost fallacy, I decided "Oh yeah, I'm not going to waste the last 3 years. I'm
going to put in the next 3 ones and then at least get a degree out of it". So I
did that.

And then um, of course after you decide that you don't ever want anything with
it, the remaining small motivation just goes away. So it was super hard from
that point on and ah contributing to open source was a good way of doing
something fun on the side that I actually enjoy and still you know uses my brain
for something. And then basically there was like one year of overlap where I
started computer science while I was doing med school. But then I had to skip a
year at CS because basically, at least the way it's in Hungary, the sixth year
of medical school is that you're doing like six times two months of different
clinics. So you can't meaningfully go to university at the same time.

Because you you're you're almost like working. I mean you're not working but
your schedule is as if you were working in hospitals. So then I went to, I
started studying CS here in Budapest. And then I guess it was around that time
when I started picking up Lisp. And then I started working at Intentional, while
because I recognized that I still have energy left just going to University just
doing the the Masters. So I went to work at Intentional Software and there like
I said we were using C# and our in-house languages.

And there, that was a wonderful ah crowd of of coworkers there. It was like a
tiny team and everyone had formal Computer science background. And we were
working on this project that was not really well managed and there was no good
idea of what the product should be. There was no good way of "How is this ever
going to make money?". But we weren't in there for that. We were there for the
for the fun of it, for solving interesting problems.

And you know back then DSLs were not a given. It was not something that like
these days right? If you say you're working on the way of ah making DSLs or
"We're exploring the ideas behind Domain Specific Languages or Language-Oriented
Programming", these days you would say "Okay, well so what? So what is it that
you're bringing to the table?". But back then these ideas were much fresher.

_WS:_ So back then, what years are we talking about?

_GE:_ Well, I joined intentional around 2004 or five but this has been going on
for a while. So but I don't think it's particularly interesting to the
listeners. I mean I can tell you about Intentional Software for like the whole
story of that. But what's relevant for this is that there were these really
interesting people there and some of them were interested in Functional
Programming, some of them less so.

I was doing Lisp but I started really feeling the need for, well, Types,
basically. Maybe I didn't realize at that point that it was Types that I wanted
but I definitely wanted something that could make my programs more manageable.
So I have ah programs that I can't go back to because I have absolutely, like,
even though I have ideas on how to, like, there are features I would like add.

So for example, like when I started learning Haskell I wrote a, basically like
a, clean interpreter in Lisp if you want to be fancy about it. So all it does is
it implements a graph rewrite based reduction. Ah and it was written for me to
understand lazy evaluation, basically.

And I, that's something where I will, well I probably don't care enough anymore.
But like a couple of years afterwards, I would have loved to go back and do a
proper type checker for it because currently it is untyped. And I tried that and
I realized that I have absolutely no idea how it works I have absolutely no idea
if I change something here, what else is going to collapse in on itself. So this
was this was my main problem with this.

And then, so Haskell, I think, I bounced off Haskell the first time I
encountered it. It was before my university days I think, in the early 2000s. I
found something on the internet, some tutorial on Haskell and I started reading
it but I bounced off it pretty hard. I just couldn't really connect to it and so
this time was like in second half of 2000s I guess. I picked it up and because I
it was more something that I was searching for. It wasn't something that just I
just stumbled up on it was something that matched what I was looking for. And so
the reason I brought up Intentional is two reasons. One is that ah later on when
we we talk about Electronics and Hardware. It was one of the the reasons that I
got involved in in playing around it. But the other one is that basically my
interests and and and wanting this Functional Programming and didn't gel well
with the direction that Intentional was going in. Because even though some of my
coworkers were interested in in Functional Programming, the higher ups were not.

And this is so I have this story which is probably not going to be appropriate
for the podcast. But I'm going to tell you guys anyways and then then you can
just guy that so basically 1 day so happened it so but I had this coworker and
mine and we were using LINQ but abusing LINQ really to to to write things in a
Functional way right? And we probably were going overboard with it because we
had this huge processes that were really just composition of LINQ operators
instead of writing your proper C# and so um.

_WS:_ Um, yeah, so LINQ is, just for our listeners, is this is the library that
and from Microsoft for doing is it SQL queries in a functional way or...

_GE:_ Originally it was for SQL queries. But you can use it as just for like
in-memory ah stream processing. Basically you could say that it's a Monadic DSL
for the kind of data manipulation that you do in SQL but it's not necessarily
backed by SQL and so we were just using it for lazy stream manipulations. And
then so one day I go into the office and you know I put the latest version of
the code and this was we were using subversion. So it was not git so you know it
was like a global, like, the branch that we were using. So I pull and I see that
in the codes and you know, not in a commit message, not in an email, not in an
issue in the bug tracker, but in the code, in the code that this coworker of
mine that I wrote. The lead engineer added this comment on top of one of our
functions which said verbatim "If you want to program in Lisp, go start your own
fucking company!". And this one this made it to the base right?

So basically I realized, Okay? Though if I like that the things that I want to
play around with I'm not going to be able to do that there. And also, I at that
time, I was nearing graduation so like okay well as soon as I get my degree I am
basically becoming mobile. I don't need to stick around so I can start looking
in the wider world and not just whatever is interesting locally. So by the end I
did my Masters on an alternative Type checker for Haskell like languages, a
compositional type checker. I can talk about that if you guys are interested. So
that was like, the final kick to me in deciding that Functional Programming and
in particular Haskell is what I want to do.

So then shortly before graduation, I started looking around for Haskell jobs. So
I found this Ad from Standard Chartered which I didn't know anything about.

_AL:_ I can briefly interrupt and just ask, I mean like, because we were at the
point where you were at the end of your your Masters and you were just fond of
this, did you, did you not consider just staying in academia?

_GE:_ Not so. Not really. I mean, so now I'm thinking that maybe I should have,
but so my perspective at that point was a bit limited on the possibilities of
that to be honest. So I would definitely wouldn't have wanted to stick around at
my University. And I was not involved in the the the academic world so I didn't,
like, I didn't really know anyone at any other University. So I had this one
example in front of me and that was a negative example. There was example that
time, "Okay, you don't want to do this. You don't want to get stuck in something
like that". And so because of that, I was like "Okay, I'm not going to try to
stay here". If I go somewhere else and it's similar. Okay, maybe it's going to
professionally more interesting but financially is probably going to be quite
poor. I should probably just go out in industry and try to find something that's
fun to do there.

_AL:_ Yeah sure. I mean why not? And then probably also because you had your
medical degree already, you just thought that you've spent enough time at a
university already.

_GE:_ That's at that point I was like 11 years in my studies. I'm really looking
forward to just retiring and probably and going back to academia is what I would
like to do now. So my perspective has done a full hundred eighty degree turn.
And I hope that once I finish my working life, I hope I can go back and do a PhD
in my area of Computer Science. But that's in the future. It's not like I have
any plans about it but I have completely changed. Working 10 years in the
industry has completely soured me on the idea of working in industry.

_AL:_ So back to the point where I interrupted you, and try to, like, sketch
these these ten years in industry a little bit more. And we were just telling us
about how you found Standard Chartered...

_GE:_ Yeah, so I literally just just stumbled upon their ad in the industrial
users of functional programming or something like that. That's a thing right?
that there's something like that.

Yeah, and then there was this web site where they had these these job ads and I
didn't know anything about Standard Chartered that they're not present in in
Central Europe. I never heard of them and the the job ad was basically for
either London or Singapore. So I applied as a complete nobody. No one knew me. I
had no networking at that point. And basically I was told that so okay so we did
like the technical interview.

I talked to the hiring manager, who was Neville Dwyer who Lennart also mentioned
on his appearance on this show and he was doing so he was in the process of
setting up the the second Haskell team at Standard Chartered. So they already
had the core team that Lennart talked about at length and at this point they
started building the team that would do like the last mile development of
getting all this nice technology to the hands of the the traders. And so at that
point it was really up in the air whether I would end up in London or Singapore.
The idea was that I would have to be in Singapore for nine months. Because we
would like to build up the team. Everyone would be there and then so that's what
that's for about nine months. But about 6 months in we would start the
discussion on where everyone wants to be.

And so the the team was just starting out at that point. I think I was the
second or third hire and I didn't know anything about Singapore. I didn't know
anything about Standard Chartered but I knew that using Haskell in finance
sounded like an interesting thing. And so I did the interview and everything.
The timing was perfect because what happened is that by the time I, so HR was
notoriously slow at Standard Chartered at that point.

And I was through with the interviews and everything, I got the offer
everything, but I was set to start like four months later. And I was on a one
month notice at Intentional. So my plan was to basically just you know, resign
one month or one and a half months before I would start in in Singapore. That
was the plan. But what happened is that the founder of Intentional Software
decided that they finally want to start making money on this whole enterprise.
So they hired a CEO. And then he, like, you know, "what do you do when you're a
new CEO to a company that's not making any money?". You go through the various
offices you kind of get a sense of who's doing what and then you try to get rid
of most of the people right? So that's exactly what happened.

So the Budapest office got, half of us got laid off and that meant that I got
severance of, you know, I don't know, several months, like, 3 months severance
pay even though I was already, I already had the contract that Standard
Chartered signed. I was just waiting to put in my resignation. And that was
great because what happened because of that was that I had this two month or
three month window of not doing anything. So I already finished my thesis at
that point. I had to defend it, but the actual writing was done. I had the move
to Singapore lined up and and planned out but other than that it was just smooth
sailing. So I started like cooking a lunch every day and stuff like that because
I had all the time in the world. It was very idyllic. And so then I went to
Standard Chartered and true to his word, of course 6 months in Neville asks me
if I want to move to the London office for longer term.

But by that point I was completely all in on staying in Singapore. I really took
to it very quickly and I really liked it, so I decided that this is the place I
want to stay.

And basically everything worked out so well that 10 years later, I'm still, I'm
not in the same team, but I'm still at Standard Chartered and basically doing
the same or working on the same project as when I joined.

_WS:_ Um, so what do you like about Singapore that you want to stay there? I
mean not everyone moves from Hungary to Singapore.

_GE:_ So the thing about Singapore is that it's very easy to like it. I'm not
sure you can love it but liking it is very easy and it's a very convenient place
to live if you're working.

Like, I don't plan on staying there for the rest of my life. I don't plan on
retiring there. But for the foreseeable future I like living there and and
working from there. I mean these last 2 years were a bit different.

On one hand the Coronavirus responses of Singapore was, I think, very good. On
the other hand, the traveling situation, the fact that even though we're on a
working visa both me and my partner, we still can't necessarily go back. So
basically there's an ad hoc process that you have to go through to get a
pre-approval for your re-entry into the country. So that's not fun. So right now
is the first time we've traveled since 2020 March because of this. But on the
other hand, once you're in, I think their response has been really good.

Like, I mean, the numbers back them up. If you actually look at the case numbers
and number of deaths.

_WS:_ Yeah, so one interesting thing to notice though is that we've had this
talk about going back and forth between industry and academia a little bit, but
you've managed to publish quite a few papers at places like the Haskell
Symposium, despite apparently you working in industry full-time.

_GE:_ Well, I think there's only one paper that I actually managed to get
published. That's like a real paper and but yeah, so during my time in industry
I tried to keep up doing all the fun stuff that I used to do beside work. So I
was thinking that just because my work is now in the same area, that shouldn't
mean that I give up on, and also doing it for, the fun of it because of course
there is a world of difference in freedom in what you do on your own and what
you do as an employee even if it's roughly, you know, you say "Oh, it's Haskell.
It's Haskell, what's the difference?". But of course it's can. It's can be
wildly different.

And so the real paper the one that I actually got published at the Haskell
Symposium was the the Pattern Synonyms one. So that one came about first as the
actual work. So I implemented Pattern Synonyms in GHC. Because I was just
browsing the GHC bug database just looking for something fun to do.

_WS:_ To do in your spare time after programming Haskell forty hours a week,
it's you know, you come home and then you want to do some more so you look for
GHC feature requests :-)

_GE:_ Ironically yes :-)

_WS:_ As one does. Yeah okay :-)

_AL:_ Is every GHC feature request is a paper? :-)

_GE:_ Yeah, so that's exactly what happened afterwards. So once I did the the
work, GHC language features or language addons do, in fact, have a tendency to
become papers. But I didn't come up with the idea of the paper. I think it was
either Richard or Simon. I can't remember which of the two who contacted me
about this. And then I realized "Okay, that's my chance. Because if I can't get
a paper done with Simon Peyton Jones and Richard Eisenberg and Matt Pickering,
like if, if I can't write a paper with these three people standing next to me,
then what chance do I have of ever getting anything done?". So of course I
jumped at the opportunity and wrote the paper. And it even had the, it was the
whole experience. So there was even the going home from the office instead of
going for lunch on the last day before submission because there was still like
half a paragraph too long for to given size...

So it was It was a real paper submission even though the work was done years
before that. And because of that paper I went to to ICFP to present it at the
Haskell Symposium. And that was like a whole new thing for me. I've never been
to an academic conference before and this was the one in Nara. So beautiful
place I think like the best introduction I could have gotten to the world of
conferences and like half a day in and I was already realizing that "Oh, This is
great!". Like this was missing from my life, I want to do this. But I don't know
what doing it would mean, so I just started attending them and started talking
to people and and meeting a lot of people who were only names on papers before
that. Because I tried keeping up with the literature but it's so much better if
you can put faces and put stories and discussions next to the names.

_AL:_ But you haven't just, like, continued the pattern then and then look for
the next feature request and...:-)

_GE:_ Ah there's still stuff to do even on Pattern Synonyms and that did the one
thing that I think would be a substantial addition would be Value Parameters
instead of Pattern Parameters. So these would be basically allowing you to pass
arguments to View Patterns when you use a Pattern Synonym and that's something
that I think is interesting enough.

Yeah, that's interesting enough that one could be worth a try.

_WS:_ What would be an example?

_GE:_ Like you mentioned that you make a Pattern Synonym that checks if
something is... so okay, here's an example. Say you have a Pattern Synonym which
looks up a key in a dictionary and gives you the result of that. So the scrutiny
type is a dictionary and the thing that you're matching on is the result of
looking up something in the dictionary.

And if it's just a value then the pattern matches. So you can do that today by
breaking a Pattern Synonym that uses a View Pattern in its definition. But what
if the key that you want to look up is something you want to be a parameter to
the Pattern Synonym? So then you would want to pass this thing as a parameter to
Pattern Synonym, but it's not a sub-pattern right? It's a value. It's the key
that you want to look up so it's a completely different thing.

And I don't know what the syntax should be for passing it to Pattern Synonym,
because Pattern Synonyms are already quite heavy, especially on the syntax of
their types.

_AL:_ Yeah, there is this infamous, like, the double constraints for the GADT
Pattern Synonyms where you have Given and Wanted constraints or whatever they're
called and you have a double constraint and and nobody can ever, nobody I know
can ever remember and which order for it to come :-)

_GE:_ I think I have a, either some Github issue or a Stack Overflow question
where I had a problem where the solution was that actually they are the other
way around. So even I don't know which one is which.

_AL:_ I think it was even changed at some point right? I mean I think there was
a GHC version where it had it the one way around and then it was flipped around
which I think is a subtly better order. But I mean it certainly added to the
confusion.

_GE:_ But that was around the time when this thing was actually added to GHC,
right?

_AL:_ Yeah, yeah, that was in the, like in the first few commits they were
added. Yeah, but anyway I mean I do think it makes sense as you're saying. I
mean so with the with View Patterns. The expression on the pattern language are
actually intertwined right? So you have, like expressions occurring as part of
patterns and currently Pattern Synonyms can only abstract over other patterns
and I think it would be useful to have abstraction over values. I mean another
thing that I sometimes want but I don't even have the idea of how this could be
realized as sort of Pattern Synonyms that could be computed somehow, which is
also sort of in the direction of abstracting over both patterns and over
function arguments that you...

_GE:_ Ooh, but that's ah, that's a whole different direction. That sounds like
something that Connor McBride could have ideas around because I remember he had
some talk in Oxford where he had to talk about, basically saying that pattern
and matching should be an effect should be regarded as an effect just like
anything else and we should be able to to have higher order if you have higher
order effects. We should have higher order pattern matching and should do to
make something whose effect is either matching or not and then you can keep
going and try other matches and that's probably there. But I don't think Haskell
is suited for these ideas.

_AL:_ Yeah, possibly not, possibly not.

_GE:_ And the other pattern synonym feature that I remember seeing but never
getting the round to implementing would be the associated pattern synonyms. So
basically having type plus polymorphic pattern synonyms.

_AL:_ But I think that's, in my perspective, going into the same direction as
computed pattern synonyms because in a way like the Typeclass resolution
mechanism is a form of computation even though it's a relatively...

_GE:_ Yeah, but it's static right? It's all at compile times. So.

_AL:_ Yeah, that's fair. I think, I mean that would be a good first step.

_WS:_ Yeah, that would be interesting right? Because then you could have things
like abstract data types perhaps, right? where you define a Typeclass together
with some interesting or elimination principle or pattern matching without
exposing the implementation. That would be, that'd be quite amusing I think.

_AL:_ Yeah, I mean, this is always something that, I mean, I've been working for
a while on this data type generic programming stuff. Of course and then the one
thing that is occurring there is these data type generic data types. So you can
have like tries that are indexed by multiple key types or zippers that are like
depending on the structure of the type. And if you define them generically as
abstract data types then it works kind of okay but they're never fully first
class because, like you can, you can define functions that work generically over
them. But you cannot pattern match on them without revealing their like sort of
strange internal generic structure. And there you would really want something
like um, yeah, associated pattern synonyms or computed pattern synonyms. Yeah,
that would be would be cool. But I mean I've never, I've never, I've never
figured out how to do this. I mean I'm not sure whether but you have so...

_GE:_ But so the nice thing about the implementation in GHC is that ultimately
Pattern Synonyms are compiled into normal functions. So there was no Core
changes needed for Pattern synonyms and of course at that level because is just
a function. You can have any, any way that you can currently come up with a
function. You can come up with a pattern synonym the same way. So if, if you
have Typeclass methods, and you do of course in Haskell, then you should be able
to use the same mechanism to have Pattern Synonyms that are, that come from a
Typeclass because it's just another function that takes a dictionary as an
argument. It's just, it's really all in the front end where this has to be
worked out. But at least we know what it should elaborate to in Core. Unlike for
computed pattern synonyms for I don't have that great an idea of what it should
do...

_WS:_ Okay, um, so let's talk about your book. So you recently self-published a
book called "Retro computing with Clash - Haskell for FPGA hardware design" and
that's not a typical topic for a book on Functional Programming. So can you,
maybe, say something about how this came about?

_GE:_ Right. So this goes back to my days at Intentional Software. Some of my
coworkers there were interested in electronics like, the old school Hobby
Electronics stuff. The pre-microcontrollers stuff. And I had all this curiosity
and the time but no knowledge of this stuff. I got and pulled into this, and,
you know, started building breadboard circuits of LEDs and whatnot. And that was
fun! And then we started, because we had all this this free time at the office
that the company was so mismanaged that we didn't have much to do that.

So we started this fun project of designing a CPU that would use Brainfuck as
its machine language, designing it from discrete logic gate components. And this
was, so we were using the wrong tools for the wrong job because what we ended up
doing is using this Java GUI program called Logisim where you can simulate
digital circuit by drawing it out. So you know you take your mouse and you click
on a palette of components and you drag it onto this grid and you know you then
draw the wiring between them. And the reason I'm explaining it in so much
excruciating detail is because working with this tool was exactly like that.

You had this feeling that you're doing nothing else but just putting miles on
your mouse. But it was fun to you know it gave you simulation immediately. It
was fun to to play around with it. But what it was lacking was abstraction. And
we built, basically of us went off and built our own version of this CPU and it
all kind of worked. But of course there was no way to actually implementing that
on real hardware with the kind of approach that we were using. So even though it
had no abstractions but Logisim at least had buses and I remember at one point
where we were looking at this design where we were iterating on simplifying it
with the aim of at some point building it in hardware. And then, you know, one
of us pointed at a particular line like a single line on the diagram and said
that "But you guys do realize that this one line would require 32 soldering
points total if we were to do this on on the real board because it's actually a
16 wide bus?". And you know, it just, it was never going to happen. We were
never getting to get to the point of soldering this monstrosity together. And it
was just something that we kind of abandoned. And I kept it at the back of my
mind. And then much later, I was already in Singapore, I think it was 2012 or 13
when I started playing around with Lava, just to get a feel of FPGAs and get to
the point of "Okay, well, what does this even look like?".

_WS:_ Yeah, so Lava is this domain specific language for hardware design in
Haskell and it's implemented like a deeply embedded language. So there's this
data type for circuits where you say you have various gates and so forth and
then you use Haskell to kind of programmatically assemble circuits in this data
type. Is that right?

_GE:_ Yes, so basically you're using Haskell as a macro language in the Lava
approach. So you write the Haskell program that imports Lava as a library and
your main function is going to be something that when run it will write a file
containing the hardware description language representation of your circuit. So
that's the Lava model in contrast the Clash that I'm going to get into in just a
second. But so for Lava, so I started playing around with it. Kansas Lava
specifically because there is, Lava is like a whole family of languages. There
are several implementations and I think at that point Kansas Lava seemed like
the least bit rotten version on Hackage. And so I started playing around with
that. I got an FPGA dev board that had lots of user friendly IO. I didn't want
to get something where I would also need to get a soldering iron and start
messing around with that stuff. So this was the this was the board that had push
buttons and seven segment displays and VGA outfitted everything on the board so
that was great for that. And started using Lava. And so the first project of
course that I wanted to do was the Brainfuck CPU because this was at that point,
you know, like, four years just eating at my brain at the the back of it and
"Oh, but you should go back to it at some point".

So of course there was a long road even to getting to that point I had to figure
out how to blink an LED, how to show, like, a single number on the 7 segment
display and all that. But it kind of worked out I made the the Brainfuck CPU to
work pretty much based on the original design and so that went well. And then my
next idea was to build the CHIP-8 implementation.

And the reason I'm bringing these up is because if you look at the table of
contents of my book, we're doing pretty much the same projects, but in clash,
because this really was my journey originally, just in the context of Lava. And
then why doing the CHIP-8 is, there was one point where I realized that
basically Kansas Lava, like no one is really using Kansas Lava. And the reason
that I found out about this is because I found that if you use XOR in your
circuit then it simulated as XOR but it's compiled as OR. And to me that was a
sign that yeah, if no one has noticed this, it's not some exotic operation
right? It's it's one of the basic two input binary operations. And if no one has
noticed it, that must mean that no one is using Kansas Lava. Yeah, yeah, that's
what yeah, ah.

_WS:_ Yeah, so need not be in anger right?

_GE:_ Probably I should have picked on this fact from having to become the
maintainer of Kansas Lava to even compile it on a modern enough GHC back then.
So I had to fix a bunch of stuff and then Andy Gill talked to me about maybe I
should just put my versions on Hackage under the real package name. So basically
I became the maintainer of Kansas Lava and then I fixed this bug and maybe there
was a bunch of other small things. But there was no, so there were no deep bugs.
The XOR one really was just the case of some copy paste programming in some
compilation template. And that's the complete opposite of my experience with
clash that we're going to get into next.

This was Lava and then I got as far as building a Commodore PET so that was a
6502 CPU and text-based screen and enough peripheral driver chips that the
keyboard would work. So it wasn't like the complete machine I never got to like
Disk I/O or anything like that. But at least you could type in BASIC programs on
the PET. And that one had a very interesting bug that I spent one and a half
months of just afternoons and nights trying to debug. So you turned on this
Commodore PET and you typed in a BASIC program that would print an infinite
loop. You know, like the classic BASIC 10 print something 20 go to 10. And you
would run it, and after a couple of seconds it would break. I mean break in the
sense of as if you you pressed something on the keyboard to break the running
program to break out of the loop. But instead of saying that "Okay, you broke
out", it printed the nonsensical BASIC error message something or some illegal
quantity error something.

So the problem of course is that you have this machine that you can interact
with by inputting BASIC programs and you see the output as video stream going
out of VGA but the actual bug is going to be somewhere in your CPU definition.
So you're so many layers removed from where the bug could be versus how you can
interact and what you can observe. So you need to somehow cut through this. So I
needed a way to simulate the whole machine, because initially you have
absolutely no idea where to start.

The only thing you know is that if you type in this program and you keep it
running long enough then something bad happens. So for starters, you need to
simulate the whole machine end to end. And one thing that happened a lot was
that it turned out that if I type in the BASIC program automatically, so
basically if I change my computer so that the keyboard driver instead of
handling the real Keyboard, it just streams the key presses required to type in
this program, that was enough to trigger. At least there was no interactivity
needed. You could just boot up this modified PET that types in its own program
like in an 80s hacker movie where you know you can see the things appearing on
screen letter by letter. So it was still crashing. So I started running it in
various HDL simulators and I couldn't find anything that was both fast enough
and flexible enough that I could program it to try to stop at the right point.
Because exactly again because of this big distance between where the bug occurs
and...

I found a, there was like a a free software simulator. I can't remember the name
of it but there was like a GCC frontend. Basically so's say took HDL and used
the GCC compiler pipeline to compile that into simulation. And that gave good
enough performance if your observations were small enough, but it scaled really
bad with the the number of signals that you were observing. And I found no way
of specifying the signals that I'm interested in statically. I had to do it
programmatically, basically. I could, like, dynamically recognize that these are
the signals that I'm interested in.

And the reason I'm telling this whole story is because, back in University, we
had a course that used Ada, (is that high pronounced, Ada?) as the programming
language for object oriented programming I think? And I didn't expect to ever
use that knowledge. And then this GCC Frontend happened to be written in Ada.
And I had to hack it to hack my own signal filtering stuff into it. And that was
a great feeling of of using this forgotten knowledge of this language that I
have never interacted with just for this one purpose and then never touching it
again.

And so the reason that the whole thing took one and a half months was because,
well, first of all, a lot of it had to run overnight just to get, so you know,
simulating this couple of seconds of runtime. And then I had to try to find out
"Okay, so what are the relevant things? What are the relevant things, how much
of the machine itself I can just cut out?".

And it turned out that the error was that, so on these old computers, you
usually have the the video system connected directly to the CPU for timing
purposes. So you have an interrupt request that is triggered by the video
subsystem, for example, at the end of each frame. So that the program can switch
over to doing computational stuff and not have to worry about what is in, like
having updated the screen memory contents by the time the the video subsystem
would read from that. And basically, that's how you write a game on these
systems, right? You would time everything from this interrupt.

And so what happened is that the so so this interrupt came in and, it would
happen, you know, sixty times a second. And in four seconds, so that would be
roughly two hundred plus times. And one of those times it hit the CPU while it
was running this BASIC program of, you know, just printing, looping a print. It
would hit the CPU just as it was entering another interrupt handler. And that
one I think was the software triggered one because on the 6502 you can
interrupt, you can trigger an interrupt with a `break` instruction. And so what
happened is that the least common multiple of the the BASIC interpreter loop
doing its thing and the video subsystem drawing the screen, the least common
multiplier worked out to requiring two hundred plus iterations to finally hit at
the one cycle where there was a bug in my implementation of entering an
interrupt handler in the CPU. So that's why it took so long to to track this
down. But finally fixing it was a great feeling. And of course afterwards I
could test it much easier than having to wait for several seconds because I knew
what it was.

_WS:_ Yeah, so I mean, what you, but this was still implemented with Lava or was
this already and yeah, but then you decided at some point to switch to clash
which is this other domain specific language for hardware. But it's very
different of course.

_GE:_ Yes, so the way that happened is, the reason I never finished the PET
fully, the reason I never did the the disk drive and the the I/O chip that
implements, like, serial communication and stuff was because it was becoming
very unwieldy to do these chips in Lava. So for the CPU itself I managed to to
build up enough, like, a library of some utility functions that made it somewhat
bearable to use it. But the big problem for me with Lava is that because it's a
DSL where you're producing this single big term, like, under the hood, what
you're doing is, you're producing this one big term of a circuit representation.
You can't add your own types into what goes on in that term. So you can't write
a circuit that pattern matches on a data type that you define yourself in
Haskell.Even though you know what it should mean because you know that, so you
can pass values around in Lava. Lava already has a concept of representing
values as fixed size bit sequences. So you could, like, you know how to pattern
match on it.

And so what I ended up doing is, I built some utility functions where,
basically, we pass it a total function from all the possible values of your data
and it would exhaustively apply it on every possible value and build a circuit
that was like this branching structure.

But that's of course exactly what you want Lava itself to do for you. And so,
basically it get to the point where it was just not fun anymore to try to finish
the PET.

And because I was doing it for fun, I just dropped it for a while and I started
doing something else. I can't remember what the next thing was, but I always had
some harebrained project that was fun to work on.

So I dropped it and then several years later at a Singapore Functional
Programming meetup Ellie Hermaszewska was presenting about Clash. Which I think
she used even professionally at Myrtle.

But her presentation was like this introductory thing of "Okay, so this is clash
and this is how you would do something in it". And now as a complete
coincidence, the example that she used was a Brainfuck CPU, so of course that
that immediately connected with me.

But basically I was looking through through and her slides and her presentation
and I realized that Clash seemed to solve exactly the problems that I had with
Lava. So what is Clash? So Clash is a GHC backend that emits hardware
description. So the difference is that like in Lava you run your program to get
your circuit description. In Clash, you just compile it, and the result of the
compilation is, instead of getting a like an `x86` executable, you get the
hardware description.

And what this allows is that every type you define in your program is also of
course available to a GHC backend. So Clash has absolutely no problems
translating, pattern matching on your type into the appropriate circuit. On the
other hand, there are some repetitive structures that you can easily express in
Lava by just writing a normal term-level Haskell program that generates like a
macro, that structure. But if you do it in Clash and you want to write it
statically, you have to either do some type level programming to achieve that or
hope that the Clash simplifier will pick up on it and be able to flatten it into
a fixed size circuit.

And there's one situation for me where that broke out in Clash. In my book,
there is one chapter where we have to use Template Haskell to, so you know, in
Lava we could use Haskell. In Clash, we have to use Template Haskell to do this
macroing because there's one thing that I just couldn't get working statically
with Clash. And it's this longstanding open ticket now on the Clash bug tracker.
But when it works, Clash works really really well.

And you know, after my experience with Lava it was just such a, like you know,
you use a tool and you build up this repository of frustrations you have with it
and then something else comes along and it seems to address exactly those
problems.

_AL:_ Yeah, so just for my understanding. So you're saying Clash is essentially
a GHC backend. So um, it starts at the level of GHC Core. If that so, it still
uses the normal GHC optimizations or does it insert it's own optimization path?

_GE:_ So Core, of course, can still be recursive but you can't have recursive
hardware. So Clash does its own transformation after, like on Core's, it takes
the Core output from GHC, but then basically tries to supercompile it into
something that's fixed size.

_AL:_ Right. Does it first let GHC do its thing and then takes Core or does it
take Core immediately after basically type checking and desugaring?

_GE:_ No no, no no, it lets, I believe it lets GHC do its own thing.

_AL:_ Because I mean, I'm a little bit worried that this approach gives you
potentially far less control over what kind of stuff you're ultimately left
with. Is that not an issue? I mean if, like I mean, GHC's optimizer can be
unpredictable at times right? And, I mean, at least if you're, if you're having
an embedded DSL, you're computing some value of a data type. And that's the
value that you're computing, so I mean the semantics is entirely clear.

Whereas here you have what feels like this black box in between which can do
really really much good, but potentially also um, quite some bad things. And but
I mean, I don't really know, I haven't, I haven't tried to use Clash so you seem
to say it's not an issue in practice.

_GE:_ Well, okay so, well, I can't really claim that it's not an issue in
practice because the kind of projects I've been doing were not really dependent
on squeezing out the last drop of performance or the last drop of of gate count
from the FPGAs I was targeting. So this is really a question, I guess, for the
Clash developers.

At the high level, Clash's model is that the, how the pure functions correspond
to circuits is a, like I should put it, like basically if, if you have a pure
function, it is going to turn into a circuit where the input, where the
arguments become the input lines to it and the result become the output lines.

I find in that sense there is a mental correspondence. And and Clash is never
going to, like, insert registers for you. So at that level there is a
correspondence between the Clash code you write and the the HDL you get at the
end. But inside a function, the combinational circuits, how they get optimized,
I think, I think you have a very good point in that the optimization can mean
that you might not get exactly the the circuit that you want. And but like okay,
so like if, if I have a circuit, like, if I have Clash code where I say that
"Okay, so this circuit, it adds up these two eight bit unsigned numbers", like
that already you could say "Okay well, but I don't know what that corresponds to
because is it going to be like a normal you know, 8 times Propagated Carry
Circuit or it is going to be some kind of tree structure where there's less
propagation delay?".

And so I think there is a level of level of abstraction where you can say that
what you write in Clash corresponds to what you get in the HDL is probably
higher than use cases that you might imagine in your question could be happy
with. And I guess in that case, you have to look at what exactly goes on in in
the optimizer. But there is a level at which there is a direct correspondence
and that correspondence is, like I said, that your pure functions will
correspond to the combinational circuits and the registers will only be there if
you yourself in your Clash program have put in registers.

_WS:_ Yeah. So in your book I think one thing which impressed me and this has
come up tangentially a few times is, I could imagine doing this up to the point
of having the basic instruction set working, right? But, I mean what you do is
not just the basic instruction set -- it's the parallel I/O, it's handling the
graphics, the interrupts that you mentioned, it's the, it's the complete story
of how to get one of these chips running or chipsets running on an FPGA. So I'm
kind of surprised, well maybe surprise isn't the right word, that it's still
fun. If it's a hobby project, like, is that, is that still fun to do all that
nitty gritty stuff?

_GE:_ So I think the large part of the fun comes when you make these components
and because they are correct, you can then use them in place of the original
components.

And this is something that I try to stress in in the book in several places. For
example, in one of the chapters, we've written a Space Invaders arcade machine.
And it's a surprisingly short chapter because by that point in the book, we have
already written an Intel 8080 CPU and the real original Space Invaders arcade
machine uses an Intel 8080 CPU plus some very simple peripheral chips. So if we
implement those peripheral chips which is not a lot of work because the most
complicated one is the video chip. But by that point we have also implemented
similar video systems for other computers. So at that point we can just take the
CPU as, we just import it as a Haskell library, the definition of the CPU. We
write these very simple to implement peripheral chips because they are simple to
implement because, you know Clash gives you all these nice tools of abstraction
that Haskell has.

So you can reuse a lot of the code that you wrote for a different machine. So
you put it all together and because we have written a complete Intel 8080 CPU,
we can just take the original arcade machine's firmware and run it on our
machine. And we get Space Invaders! And it almost feels like you get it for free
because you didn't have to do that much Space Invader specific coding and yet
the end result is this full machine that you can interact with.

So I think, and that's the reason that the book is structured in such a way that
we build up some reusable components. But then there's a project chapter where
we do nothing groundbreaking, we just take whatever we've put so far, and we
assemble them in a way that out pops a full computer or a full circuit, because
some of the projects are not even computers, and so I think there's a ton of fun
in seeing programs that people have written 40 years ago for the original system
and seeing them run for the first time. And you know, I'm not talking about
Space Invaders, like even something that, just, like any 8080 program right,
that you can run on your cpu and have something that you can observe from the
outside and it's working.

So taking that, and knowing that the person who wrote that didn't write that
knowing the quirks of your implementation, and yet it still works, I think
that's the satisfying part.

_WS:_ Yeah, maybe. Tastes vary, I guess. So another question I have is: are you
familiar with the book "The Elements of Computing Systems" I think it's called?
It's um, it's sometimes called "NAND to Tetris". So I think it's one of my
favorite CS books, right? So what the book does is, it starts by saying "Here is
like an AND and an OR gate and here's how we can implement something else some
other simple gate using these things". And then it says "Oh we can now do adders
and then we can do memory and we can have a little CPU". And then each chapter,
it builds up this new level of abstraction, right? And then it goes up. And then
to a little instruction set and then a little language which compiles into that
instruction set and then you know the end chapter is that you write a little
Tetris game in this mini programming language. And then, but you know, kind of
in principle, how it gets, goes all the way down to, back down to zeros and
ones.

So my question is, from a, I mean, this is fun if you're interested in playing
Tetris, but I mean, we're programming language geeks. Of course, so could you
not imagine that once you've built up this little microprocessor and that the
next thing that you want to do is a little kind of Haskell compiler and then
have a little kind of Clash dialect which works on Intel 8080 microprocessors?
So you can bootstrap your own programming language ecosystem from the ground up,
right?

_GE:_ Well, at that point you also run into the limitation that, like I said at
the very beginning of this, that I never really went downwards back in my eight
bit days. So I couldn't really write an efficient and non-trivial program for
these old eight bit micros. And I guess that's one of the reasons that I wanted
to implement these full systems that match real world systems. That way I didn't
have to care about the software that runs on them. I could take the library of
existing software. But yeah, sure it would be a fun project. So, so very good,
from NAND to Tetris you would have NAND to Clash or NAND to Haskell or...

_WS:_ Yeah, and then back right? Where you could then, so Lennart always says
that compiler is only ever mature if you have the compiler kind of eating it
your own dog food and using it to compile yourself. This is kind of taking that
idea to the next level where you have an entire architecture plus the target
compiler for that architecture plus everything is self-hosting.

_GE:_ Yeah but there is a shortcut to doing that though which would be to
implement, you know, not something like an 8080 but like a RISC-V in Clash. And
I know there are existing small RISC-V variants in Clash. Because then you could
take something like real Haskell, real GHC compile that to RISC-V which is
probably a lot simpler than trying to build an a implementation and then use
Clash on that. So, so basically, like, you want to meet in the middle and I say
instead of pushing Haskell all the way down to an eight bit micro, you should
lift the the hardware to, like, RISC-V and then you have an easier time. Even,
like a simple version of the RISC-V, and have an easier time meeting in the
middle.

_WS:_ Okay, maybe that can be a next book, I guess. Then there's something to
look forward to.

_AL:_ Perhaps before we wrap up, like, how was it working with Clash? Clash is
still, in itself, if I understand correctly, a project that is an active
development and it is perhaps to some extent experimental but it has a sort of
enthusiastic core of contributors of which you're probably now a part of. Do you
want to say something about that?

_GE:_ Yes, so when I started, when I had the idea for the book, I didn't start
writing the book.I started writing the programs that would make the backbone of
the book. So idea was that I would have all the programming done upfront before
I write the first sentence of the first chapter. And in that process I found, of
course, bugs in Clash and that there were like several weekends where my only
output was just Clash bug reports. But I tried to make them as informative and
self-contained and small as possible and they really liked that, because most of
their users are like proprietary chip developers who can't share their code. So
they would have a problem, but they can't just say "Oh, and by the way, I've cut
it down into this twenty line example and put it in your public bug tracker for
everyone to see and come up with ideas", whereas that's exactly what I was
doing. So that's how I got involved in the actual Clash project because I just
kept hitting these these bugs. And then when I decided that this is too good not
to share with the world, like, I need to write this book or at least I need,
either I need to write like a long series of blog posts or something but this is
too good not to tell the world. So I'm gonna write a book about it.

So when I decided that I'm going to write this book, of course I talked to
Christiaan Baaij, the Clash main developer. And this was back in Berlin 2019
ICFP, I told him that I'm thinking of doing this book, and he was very
enthusiastic about it. You know, at that point I was just another Clash
contributor, but he really liked the idea of the book. And I've been telling
people that I've basically been getting commercial level support from them in
the sense of, you know, like I would have some bug on a Saturday and by Sunday I
would have a fix from it.

And there was at one point, but so the big bug, the one that I mentioned before
that I eventually needed to use Template Haskell to work around. So because no
one really understood what was going wrong there. It was just a Clash program
that completely blew up when you tried to compile it and you ended up with this,
you know, huge circuit that kept growing and growing and growing until it was
even, yeah, like, it was so, so the growth rate was scaling exponentially with
the input. And as it was growing, of course it hits some limit of either your
computers RAM or you just kill it because it's been running for hours. But
basically, it was never going to go anywhere and that bug no one understood why
that was going, what why this was happening or what was going on there. And for
that one at some point I ended up getting I think three or four person weeks
from a QBayLogic. I ended up getting and three or four person weeks of debugging
from QBayLogic on that. Which was great, and like, it didn't fix the issue but
at least we got a great understanding of what exactly was going on and there is
a long-term plan of, you know, just using a partial evaluator instead of the the
current simplifier in Clash that would solve that issue. It's just that the
implementation is not ready yet. So I had a wonderful time with the Clash
developers and the Clash community on this. And I hope that people who read the
book will will become as enthusiastic about Clash as I got when I started
playing around with it.

_WS:_ Okay, so on that note, I just want to thank Gergő again for joining us
today and sharing his adventures in retro computing and using Haskell and
learning Haskell. And thanks again, that was a lot of fun!

_AL:_ Yeah, thank you very much.

_GE:_ Yeah, thanks for thanks for having me! This was this was great!
