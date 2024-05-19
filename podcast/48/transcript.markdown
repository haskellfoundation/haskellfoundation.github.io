*Andres Löh (0:00:15)*: This is the Haskell Interlude. I’m Andres Löh, and my co-host is Matthías Páll Gissurarson. 

*Matthías Páll Gissurarson (0:00:20)*: Hi.

*José Nuno Oliveira (0:00:21)*: Today’s guest is José Nuno Oliveira. He is a professor at the University of Minho in Braga, Portugal. He has been teaching Haskell for nearly 30 years. We are going to talk about how Haskell is the perfect language to introduce to all sorts of audiences, be it computer science students, music students, or children in school, and why it is beneficial to start with functional programming before moving to other paradigms. 

Hi, José Nuno. Welcome. 

*JNO (0:00:49)*: Hi. 

*AL (0:00:50)*: Our first question usually is, how did you first get into contact with Haskell?

*JNO (0:00:55)*: Well, I got in contact with Haskell around ‘97.

*AL (0:00:59)*: Okay.

*JNO (0:00:59)*: ’98. Okay.

*AL (0:01:01)*: That’s actually pretty much the same year I got in contact with Haskell.

*JNO (0:01:05)*: Yeah. And I start with the teaching first. In this department, we are functional first. It took some time to reach that stage, but for around 20 years, we have been a functional first. We have two courses on functional programming, one in the first year and one in the second year. I give you the one in the second year. And before we started teaching Haskell, we were teaching ML and Lisp.

*AL (0:01:33)*: Okay. When did the department start teaching these?

*JNO (0:01:38)*: Around ‘86.

*AL (0:01:41)*: Okay. Were you there from the very beginning?

*JNO (0:01:43)*: Yes, I was. I was here from the very beginning. Actually, in ‘84, I did my PhD in Manchester, the UK. I came in ‘84. And the functional idea came actually from my PhD project because I worked in the data flow machine project. And the very first time I knew about functional programming was this paper by John Backus FP, about FP, because my supervisor, *(0:02:13 unintelligible)*, gave me the paper to read and said, “Look at this. This is interesting. This is another way of looking at parallelism and all that.” And I became fascinated with that because I not only found something very formal and very sound, but also I enjoyed the laws—the laws of programming that he was doing. And I was sending my reports to here, to the department, and people were reading them. So when I came, we actually decided to start teaching this. But we didn’t have anything special until we found Peter Henderson. I mean, he wrote these papers on functional geometry and many others.

So he visited us in ‘85, and we knew about a library that he had written in muLISP, Microsoft LISP, which was Me Too. It’s called Me Too library. It’s basically a library of functional programming equipped with lots of functions which could animate formal specifications like VDM and that kind of thing. And that suited us very well. So we started using this library, but it was, I mean, s-expressions Lisp. On the other hand, it was Microsoft Lisp. And we wanted to change things. So we changed to XLISP, which was open source. And it was – I mean, it was written, I believe, by David Betz. I never met him, but we did a lot with this open source XLISP interpreter. And we designed our own extension of that library, and eventually designed a language which compiled to that ex-Me Too library, which we called CAMILA. And this was available in 1990. And we started teaching this using these in mainly last year’s projects because the students became interested in these animations because the course, which was basically a formal methods course, was more interesting. You can actually start animating the specifications was something they like. 

And we have this situation where we were contacted by an institute, which is where I am now, INESC TEC, and they had a project with the Italian companies, Eureka Project. And they wanted somebody to do some more formal work there, not explicitly, but they said they wanted to use the system in the banking area, and they wanted it to be very reliable. And this institute called us and said, “Ah, you have an opportunity here. You join the institute.” And this was very, very interesting because we immediately started using functional programming, not only in the classroom but also in a project. We had actually to hide the functional programming part from the consortium, but we did everything. We prototype. That was our word. We animated everything we are doing in this system. And the project was very successful. We saved around eight months of development. And in ‘95, the project ended. 

When we came back from Italy from the last meeting, we said, “Oh, this is actually useful. Okay. So let us carry on this way of teaching.” And that’s when we start actually teaching this language, CAMILA, in the second year. And it was a language that was used for students to start programming in a sense. 

But then comes Haskell. Okay. And the type system of our language was a decent one, but then I got fascinated with the Haskell type system. It was exactly what we wanted. It was interesting because my first experiments with Haskell, I started by hand transliterating my libraries from CAMILA to Haskell, and found that the types that I prescribed in the CAMILA thing were less general than the ones that Haskell was inferring. So it was a lesson that you should let the system to infer the most general type. And I started a crusade here that we should use Haskell and drop CAMILA. I mean, there was a big, not fight, but people didn’t want because we had years of investment. We were actually teaching it in a joint project we had with Bristol University. And for many years, we gave courses there. So it was a bit difficult to convince people. But then we decided to switch to Haskell. And this second-year course in ‘98, I started teaching Haskell, and also in the first year. And ever since, it became our language. And also, our students, the first language they met in the course is Haskell in first semester.

*MPG (0:07:04)*: So how did that turn out? How did the students – were they expecting something else? Or how did they react to just seeing Haskell and just running off?

*JNO (0:07:13)*: In the beginning, they weren’t expecting anything because they didn’t have any background. So they engaged in what we were teaching. And so there was no reaction. It was just fine. In later years, the students started coming with some background in programming because high school was already started teaching some language which are not functional. And then there was some, and still there is some, reaction because they have to switch background. But we believe we are right. This is the right way to start learning how to program. So in this second-year course is more than that, because I became aware of the Algebra of Programming book by Oege de Moor and Richard Bird. And I immediately said, “I have to teach this.”

*AL (0:08:02)*: Yeah. Perhaps we should say a little bit more about this book.

*JNO (0:08:06)*: It’s about some – it is a theory of functional programming. It’s actually a quite sophisticated theory because it enables one to start from specifications and, by calculation, reach the implementation, but it was rather inaccessible. It was a book that was hard to use for second-year students. So I started writing notes myself, which in a sense paved the way to the book. And eventually, those notes became a book in themselves, which I am using nowadays, but I haven’t published it. It’s just on the web, and it’s called Program Design by Calculation.

*AL (0:08:47)*: Is it available, though? I mean, like only for your students or –

*JNO (0:08:50)*: No, no, no. Everything I have is available.

*AL (0:08:52)*: Okay. We’ll try to include a link then. Yeah.

*JNO (0:08:55)*: And that’s the way I teach. So our system that was implemented here was that we should always work or teach a subject in three steps. Paradigm first, methodology second, and applications third. So the paradigm is first, because the first, I mean, your first acquaintances with a subject is always you don’t know anything about it. So it’s better in your first course you just get acquainted with, in this case, programming paradigm. And that’s the functional programming course in the first semester, first year. And then as a kind of consolidation, in the second year, you study the methodology of that paradigm. And that’s when this teaching comes in. And so what I do, I basically teach the idea of the book that you should use program combinators, very rich program combinators with free properties. But they have to do an assignment. And that assignment is to give Haskell code. So they implement the assignment in Haskell. 

*AL (0:10:05)*: Okay. So you were talking a little bit about how the students were reacting to sort of the introduction of functional programming over the years, but even further back, like initially, you made it sound as if among the staff of the university, it was an easy sell. Was that right? Going functional programming first and teaching it as the first language and –

*JNO (0:10:28)*: It was, in a sense, not that hard because we are a very young university, a very young department. And there was some tradition of teaching. We are actually teaching basic Fortran in the beginning. But it was not very strong. And so at the time, the only full professor that we had, José Valença, was a very strong, still is a very strong-minded person. And he implemented this in ‘87. I think the department accepted. So I think if it were a very old department with lots of traditions, it have been harder. So people accepted it. And still, we have this teaching like this. 

*AL (0:11:13)*: Right. Yeah. So you said the only resistance was then like switching languages. I can certainly understand this, but I mean, was the main difference between – what was it called? CAMILA?

*JNO (0:11:28)*: CAMILA. 

*AL (0:11:28)*: And Haskell was the type system? I’m actually not that familiar with CAMILA. I mean, I heard of some of the early functional languages, but that one I think I’ve never seen. 

*JNO (0:11:39)*: Well, that was a very local one. And by the time, it could lift off. We just killed it because we decided to switch to Haskell.

*AL (0:11:49)*: Oh, was it a drastic –

*JNO (0:11:51)*: It was a drastic decision. Yes. And that decision was not well accepted. 

*AL (0:11:55)*: Completely different language in a way, like syntactically and –

*JNO (0:11:59)*: Syntactically, it was – CAMILA is not pure functional programming because you could have state clause and, in a sense, you could have abstract state machine. So it’s not purely functional.

*AL (0:12:13)*: So closer to standard ML or –

*JNO (0:12:15)*: No, no, it was not that algebraic. It was basically abstract state machine. But most of the times, we didn’t use the state clause, meaning that we were actually programming functionally. The other thing which wasn’t there, it was lazy valuation.

*AL (0:12:31)*: Yeah. I mean, I was already thinking like, if you said it isn’t pure, then probably it wasn’t lazy.

*JNO (0:12:39)*: Yes. Lazy valuation, infinite data structures and that kind of thing. All that sounded very, very, very exciting. And that’s why we changed it. And talking about infinite data structures is quite interesting, infinite lists, because I currently teach Haskell to two completely different populations. The main course, which is a big one, which is 400 students, is the second-year course, which is taught to the Computer Science degree and this Engineering Informatics degree. But I also teach Haskell to music students.

*AL (0:13:19)*: Oh, okay. 

*JNO (0:13:20)*: Yeah. And why? Because some time ago, about 10 years ago, the Music department wanted to set up a course, a new course. And they called all the departments and said, “What can you offer to this new course?” And I thought of something like an abstract approach to the music language that could be processed. And you could then, in a sense, implement a course on computer-aided musicology. And that’s what my course is there. And I’m using Haskell for that. And infinite data structure is very interesting because, for instance, when you have a repeated bus, which is in a sense repeating itself all the time, you don’t need to care about describing it in full. You just write the infinite data structure, the infinite list that represents. You have the cell, and then generate the infinite list. And then we zip it with the other parts of the music. It immediately stops when the other parts stop. So it’s interesting that – and the students, these music students, don’t have any problem in understanding this. So you might think that they would have found this is infinite. No, they find it natural, quite natural, because they don’t have any background on programming with any other languages. So it’s again the same thing. If you teach this the first time, I mean, people accept it.

*AL (0:14:48)*: So you did not end up using any of the other libraries that people have been writing over the years, like Paul Hudak or so on, on music composition in Haskell?

*JNO (0:15:00)*: Yeah. In the beginning, I was going to use it. And I actually used it for a while. But then I somehow decided to have my own.

*AL (0:15:09)*: But it’s still sort of a DSL so that you don’t – I guess you’re not teaching these music students all of Haskell, but specifically this library that you have been setting up. 

*JNO (0:15:23)*: Yeah. It is a little library. And basically, what I’m doing is applying abstraction functions that start removing details. And that’s what musicology is. Doing some analysis. And that’s why I needed functions on my – I mean, I did my own functions. But I actually started with Paul Hudak’s library. And there’s something more about it and about Haskell as an introduction course, and I take the opportunity to do this. 

Quite recently, starting in 2019, I was approached by a previous student of mine who is a businessman at the moment, a very successful one, on starting teaching computer science to very young students from year 1—these 12 years are key, from year 1 to year 12. And we started doing the work. There was this pandemic that stopped the thing a little bit. But then we were setting a syllabus for doing this and contacting schools, and we got three schools in Porto that wanted to participate in this experiment. 

Nowadays, we have 5,000 students. And 5,000 per year in the several schools, mostly in Porto, some in the further east of River Douro, because we wanted to experiment with many schools with different backgrounds. Large town, small villages. And also, in Cascais in Lisbon, we are doing this at the moment. And after several experiments and attempts to start something, we landed in Haskell. So we are actually teaching Haskell to these very young students. Not at year one, but by year 5, year 6, they are using Haskell. And we are using Jupyter Notebooks.

*AL (0:17:23)*: I was going to ask what you’re using.

*JNO (0:17:25)*: We are using Jupyter Notebooks. So, this teaching has to be done very carefully because they’re very young. And the worst thing we could do would be to spoil their brain or –

*AL (0:17:39)*: Scare them away from Haskell.

*JNO (0:17:42)*: And after experiments with other alternatives, like Scratch or that kind of thing, we found that didn’t deliver something that could be regarded a proper course. So it was all very superficial. And what really, from our experience, we realize is that when the students start using these functions, these very simple functions take map. They understand them. They understand these functions. So it’s quite interesting. They don’t have any background whatsoever. So in this case, they’re pure state. And so, by use of this Jupyter Notebook with the IHaskell, the Haskell kernel, we are doing, I would say, quite well. So in the beginning, in the first years, there is no programming at all, basically. Then they start interpreting expressions, basically list expressions. 

*AL (0:18:38)*: But what does that mean? No programming at all? You just show them things or –

*JNO (0:18:43)*: So at the moment, our introduction to the students is pictures. Black and white pictures. Black and white dots. Or little squares. And then they become zero and ones. And then this converts to a matrix. All these done by hand. And eventually, we start asking them about transformations of these images. And we show them transformations. So this is what is called the unplugged method. So there’s no plugs, no machinery, no electronics involved.

*AL (0:19:20)*: So all this is done on paper?

*JNO (0:19:22)*: On paper, drawings and all that. They’re very young. Year 1, year 2. Year 1, they don’t know how to write. No reads. Year 2, they start to – and then what we show them is the master teacher is using a computer. And he is using Haskell in this Jupyter Notebook. And it starts animating what they’re doing by hand. For instance, things that they are doing by hand carefully in their – they have a physical notebook, which we call them – their first computer is the booklet that they have. It’s their first computer. And it’s quite interesting because they use the book in two ways. The booklet in the normal way, when they flip it, like my laptop is, they call it computer mode. So they are using the physical notebook, the paper, but they call it in mode computer. And the teacher starts doing transformations, which should take quite long for them to do by hand, and eventually starts showing them the rule of the game, which are lists of lists of zeros and ones. And they get used to this notation. We actually start from lists of lists of zeros and ones. And slowly, the concept of a list starts becoming part of their vocabulary. Well, for a long time, they don’t do any programming, but they see the teacher running expressions, for instance, taking the first three lines, and the images is cropped. Map reversed is going to – all these things that you can very easily do.

One of the reasons for the success of Haskell, and since we are interested in Haskell here, is kind of unexpected. When we decided to go function first in this process of teaching them all to program, I was saying that there are three steps: unplug, semi-plug, and plug. The semi-plug is when they are already seeing somebody playing the piano, who is the teacher, and they are still doing things on paper. The plug mode is when they actually start by themselves writing the expressions. And say, something they really like is, suppose you have a Haskell expression which functions after functions, and they enjoy very much when there is this, “What happens if you sort and then reverse and map something?” And the teacher asks them what is going to be the outcome. So this is already written in the cell of the Jupyter Notebook, and they start guessing, “The output will be this and this.” In this case, in the class that I attended, she was carefully marking how many votes for this output, how many votes for this, and all that. And then when she presses the return key, and then they get the output. I mean, those who win get very excited. Very excited. So they start seeing Haskell expressions being evaluated all the time. And eventually, it is their turn to play the piano and write the expressions. 

And when we considered F#, one of the interesting things was that Haskell is fully typed, as we know. And very, very sophisticated type system. But we can actually hide it. You can just write functions. 

*AL (0:22:56)*: You mean because of inference?

*JNO (0:22:57)*: Because of type inference. 

*AL (0:22:59)*: But what about error messages?

*JNO (0:23:01)*: Error messages are completely – I mean, the details of the error messages are ignored. You just say, it’s an error. It’s an error. It could be nice if, I mean, the interpreter had a version which would simply say a very simple error message rather than that very detailed. But for them, they’re just error. When those kind of colored lines appear, it’s just an error. We don’t tell them anything about the contents of the error message. And this is very important that you can actually write something. You don’t need to give type directives. If you start giving type directives, you need to write more than one line. And it is not that easy for them. Also, the simplicity of the Haskell language is very close to the language they have in the math book, in the physics book. So it’s very easy to connect what you are writing with the mathematical expressions that they have in their books.

*MPG (0:24:01)*: Right.

*AL (0:24:02)*: But do you kind of, for example, replace the Prelude or something so that they don’t get into contact with overloaded functions so that the error messages are less likely to occur? You can get sort of like ambiguity errors or monomorphous restriction errors, which are very tricky to diagnose, in particular, if you don’t see the error message. 

*JNO (0:24:26)*: Yeah. Well, basically, fixing the problem, the error is complete intuition. Yeah. At this stage, it cannot be added. So what I find interesting is that after several attempts with, I mean, systems which have been designed for this, we actually find that this is the most efficient way. It’s the most efficient way that we have found. And they’re progressing and becoming more and more elaborate because, in a sense, what we are doing is more and more elaborate functions taken from the standard Haskell libraries. And we implemented graphical library on the interface of the IHaskell language, which is always HTML. So actually, IHaskell has now many graphical libraries. But I wrote myself one very simple one, which produces SVG. It works nicely when we start doing graphics. So it’s basically lists, lists and lists of lists, lists of words and pairs. So it’s interesting that lists and pairs are the two ingredients that you need to teach these things because when you start teaching about the picture, it’s basically you have the coordinates, and it’s quite easy to do these things. So it’s just to tell you about, because you were asking about the resistance of the students to this. The resistance in this case is no resistance at all. They don’t have any background. So we may say that we are teaching Haskell to around 5,000 students. I mean, some of them are very young still, but it takes time. I’ll say we could halve this. So around 2000 students are now getting in touch with Haskell. We don’t tell them about the language. It’s just the notebook. It’s the language that they use in the cells. But they are getting used to this very easily. 

*MPG (0:26:17)*: So have you heard of the opposite experience? Like when these kids then, when they have a Haskell background and then they encounter Java or something, have they told you and come back and be like, “Yeah, it was so much more fun when we did Haskell than Java”?

*JNO (0:26:34)*: My experience is that if you teach functional programming first, your mind becomes very flexible to other paradigms. That’s why I believe in the functional first teaching paradigm. They may say, “Oh, it is very bureaucratic. You have to write a lot of text.” But you adapt very well to other paradigms. But the opposite, it is not true. If you start imperative, it’s very difficult for you to go functional. And we have experiences of this kind with students, but also with teachers. Staff members of our department, they didn’t have this background coming from other universities, and they have to teach functional programming. And one of them told me it was a big fight. He had a real trouble to change his way of thinking. So I would say they adapt very well to other paradigms. The feeling I have is that when they have something kind of practical to do, not research-oriented, they actually use this line. When they have a project, and I may see projects, something more sophisticated, they switch to us. So they do it. If the problem is sophisticated, they use Haskell.

*AL (0:27:41)*: Do you have a theory why that seems to be the case, that it’s easier to switch to other paradigms if you learn functional first, and why it’s not the other way around?

*JNO (0:27:53)*: I think functional programming forces you to be aware of the information flow. And that’s why, in a sense, it’s a quite sophisticated paradigm. Suppose you are programming in C. If you need something else, you just add another variable. In Haskell, if your function gets an input, the input is lost. If you need it later, you have to duplicate it somehow. And that’s where exactly this matches with the parallel programming. So you get aware of the information flow. If you come the other way around, you are not at all sensitive to this information flow. You don’t see it. Variables are just there. 

I have done some incursion into quantum programming. It’s quite interesting that, in a sense, a student who has a functional background is far more prepared to do quantum programming than the others. Because in quantum programming, I mean, this is an energy preservation thing, all this idea of isomorphism. An isomorphic function is very important. So I would say I have now a stronger opinion on this. If we start functional first, you actually open lots of perspectives to the students. Also, the imperative start is very atomistic. You know atomic steps. You increment the variable, you copy this variable to another variable. So it’s rather atomistic. And by the end is by adding atoms of computation that you get the final outcome. 

When you program functionally, and in particular in Haskell, which has this generic thing, this parametric polymorphism, you actually do big steps. It’s a big step programming. It’s very interesting. I have a video. I don’t know if I can later share it with you. I have to ask because it’s little kids. It’s very interesting to see very young kids talking about map. And maps of maps. This tells me that this big leap programming is possible in our mind. And when you start being trained with little steps, it’s very, very hard to do large steps. We see a typical functional program by somebody who has an imperative background is functions with many parameters. So you are doing everything simple and very little use of functional composition. It’s basically a block like the while loop that they program when they program in C. It’s basically a big block that does everything. And I mean, in the Algebra of Programming, we know that those big blocks actually can be factored in mutually recursive functions and all that. So that’s quite interesting. Big functions, a small number of functions with lots of parameters, because what they want in all those parameters, what they want to have is the variables that they have in C.

*AL (0:30:53)*: Yeah. So if I try to summarize, I think you mentioned essentially two different arguments, right? One, in functional programming, you tend to have to be more explicit about certain things, and that in a way leads to a deeper understanding than things being implicit and imperative programming and then appearing magic, and you don’t really know what’s going on. And the other being sort of trained to look at the big picture, right? Which helps with the sort of problem decomposition and structuring, perhaps.

*JNO (0:31:26)*: Yes. That’s very, very important. You said the right word. Yes. 

*AL (0:31:31)*: Okay. One thing, perhaps a final question about this school initiative: Where does it end? Like you said, okay, you start with not even programming at all and everything on paper, and then you do pictures, and then later people try things out. Is that the final step or do they go even further?

*JNO (0:31:52)*: No, I mean, this is an experimental project. We are very happy to be funded by some companies who are interested in this because they are invested in – they need, of course, programmers. And so in a sense, it’s a telecom company, NOS, and then the big other company, Sonae. So they are supporting us. So it is an experimental project. We didn’t get a grant. And because the outcome is visible and it’s productive, they keep funding us. And we are just in the beginning. So we are now in year 7. We actually didn’t start on year 1. We started at actually year 6, and then we did the year 6, year 7, year 8. And then we said, “No, we have to do the full thing.” So we then switch it to the very early years of education, where we do these basically on tails and little histories and all of that. But we have 12 years. So actually, the programming starts year 6. Year 6, 7, 8, and 9, we believe we are going to keep the functional, but then we will open to the other paradigms. And we still have three more years. 

With experiments that we are doing, we are sometimes amazed that the students, they understand things that we were not expecting them to understand. So we still have three more years after the ninth year. So we are going to open to the other paradigm. So we’re not preparing the switch to Python. This gives me something to think about because what are we going to teach in university after all these things that we thought in the pre-university education? So I believe this can have a big impact on the university education, because if the students come with this background, this is going to have an impact. 

So what we are doing in this program is, in a sense, scaling up the functional first approach, now scaling it to pre-university students. Let us see what happens, because this is experimental. One of the interesting things about this is the younger the students are, the bigger the challenge it is. And sometimes I find myself telling me, “Oh, now I understand this.” I thought I understood, but only after being challenged to decompose, because you cannot be technical. Or too much technical. You have to decompose what you want to teach in things that they are able to grasp. And that’s quite interesting. 

*AL (0:34:29)*: So, I would like to backtrack to the university teaching. When did you say was the switch from CAMILA to Haskell?

*JNO (0:34:38)*: ’97, ‘98.

*AL (0:34:40)*: Okay. So that is a very, very long time ago, right? I mean, that is essentially the – yeah, as I said, essentially the year where I also started first learning Haskell. Haskell was a very different language back then than it is now, I would say. Not just like in the language itself, but also the whole tooling, the libraries, and so on. I mean, at that time, you hardly had any libraries. People were using a handful of libraries and sending things around by email and then later. Those like Cabal and Hackage, but also, standard revisions, language extensions. Nowadays, you have loads of things. And how far has that changed the teaching or affected the teaching? Is it like, not so much at all, but it is perhaps an easier sell to the students because you can point to real-world software and say, “Oh, there are actually libraries that do all these things if you want them to,” or are you actually using more applied aspects of the Haskell ecosystem in your teaching as well?

*JNO (0:35:45)*: So we had in the past, we don’t have it anymore. We had a final year course on advanced functional programming. And in that course, we used Haskell at full speed. But because this is a second-year course, and actually first year, second year is quite conservative. It’s the students themselves. I mean, if they actually use Haskell in their, for instance, MSc, they go when they use, of course, the full language. So in a sense, we are careful there not to make it too sophisticated because then it could fire back. So in this teaching, it’s quite conservative. It’s a pity that our research in functional programming, in a sense, is now weaker than it was in the past. Less and less students want to follow these subjects. There’s this machine learning now and AI. It picks all the students. And so, in a sense, if in the teaching side, we are okay—I mean, we are in a sense—on the research side, we are not in a good shape, in this area of research. My research is basically formal methods for functional programming. I still do that, but not many people around are doing that.

*MPG (0:37:05)*: Right. But in the near future, you’ll be having kids who have been programming Haskell for 10 years starting university, right?

*JNO (0:37:13)*: Yeah.

*MPG (0:37:14)*: So, hopefully.

*JNO (0:37:15)*: I’m not sure why we are here. But I would like to know what’s going to happen. Because, well, we cannot do more because if this doesn’t work, you have to go to the babies. And it’s the babies. But I am sure this is going to have an impact. And also, there was this barrier because I’ve discussed this quite a lot with Simon Peyton Jones, for instance. Simon Peyton Jones is leading the similar initiative in the UK, CAS UK. And he was very careful about this because I believe there the resistance would be far more than here because computers in schools in the UK have been there for a long time and not here. Not here. So we didn’t have a background to fight with. And that’s why, in a sense, it’s all happening in the same time. 

When we started functional first here, there was a little background on programming. So there was not a fight. And knowing schools is exactly the same. Well, we still have the Scratch people. And actually, there are directives to schools to use Scratch. But very slowly, we are convincing those people that what we deliver is far more than what they actually are able to teach in Scratch. I don’t mean that the tool is bad. I don’t. It’s just not the right tool to start. 

We are actually now doing experiments in, for instance, introducing for loops, which are basically an iteration composition of the same function with itself a number of times, and have started showing them the same for loop written in Scratch, displayed in Scratch and in Python. And they didn’t react. They didn’t like it. I don’t mean they didn’t like it. It didn’t excite them. So it didn’t excite them that this shift was needed in a sense. So in a sense, they are happy with what we are teaching them, and we are also happy. It’s always a lot of fun to see some experiments are better than others. 

Still, doing things on paper is very successful. When they start verbalizing—so they start actually writing—we found that there’s still some resistance because they enjoy the concepts and they don’t find the need to actually go and play the piano. But very slowly, they get excited about that. And there is also something which we might imagine that technology is what kids like. And that’s not true. Our experience for graphics, computer graphics, they were not excited at all with what we were doing, or less excited than we were happy. And we did this work of designing this library. And why? Because they are used to very sophisticated computer graphics in their mobile phones. 

*AL (0:40:20)*: Yeah. But isn’t that perhaps the reason, right? I mean, I remember that when I was learning how to program, getting anything drawn on screen was spectacular. But these days, the simple things you can realistically do, they’re nowhere close to the graphics they’re already confronted with elsewhere. So it does not really get them excited.

*JNO (0:40:46)*: Yes. That’s exactly that. We were excited. I said, now our lists of pairs are going to be animated graphically and okay for them, but it was not something that they found amazing. 

*AL (0:41:02)*: No, that’s not the same as running around through a 3D world. 

*JNO (0:41:07)*: I tell you, for instance, topics that they are very keen of. QR codes, for instance. We teach them QR codes. So the lists of lists represent the QR codes. They enjoy this very much, for instance. Cryptography, very simple cryptography, encrypting the lists of – the words changing in decrypting. This is very exciting for them. The idea of sending an encrypted message that the others don’t understand. So it’s interesting that, in a sense, they get more engaged and interested in the concepts than in the technology. So a little bit surprising, but that’s what we are finding.

*MPG (0:41:49)*: Interesting. Yeah. 

*AL (0:41:50)*: Okay. So perhaps, towards the end, we can also try to look a little bit more at the bigger picture. You have a long experience with using Haskell for teaching now for various different audiences, like you talked about, like in music students, computer science students, school kids, and so on. And all this was driven by your initial enthusiasm for functional programming and, in particular, typed functional programming and lazy evaluation. After all these years, would you still say that Haskell is sort of nearly the ideal language, or have you come up with ideas where it’s lacking, or how would you evolve it and what do you think, for example, about, I don’t know, dependently typed languages and so on? Do you think that is where the future is? Or what’s your view on this?

*JNO (0:42:38)*: Well, when we look at Agda, of course, it’s a very interesting language. And it actually merges the two sides of this idea that you – I mean, programming and proving should be together. But on the other hand, I find the, for instance, syntactic simplicity of Haskell. Very, very interesting. I tend to appreciate simplicity very much. And the simplicity of the language, which is immediately patent in the syntax, is something I enjoy very much. Also, you mean, do we need more? I mean, now I believe that if we had more courses on functional programming, like that advanced functional programming course, we might need something more sophisticated. But then there is Agda. So, in a sense, I don’t think it needs to be repeated. 

One of the concepts that I teach, which is the monads, monads are still a concept that needs some preparation. But I don’t know what we can do about this because, I mean, the concept is there. It is implemented. But for instance, I switched if you – I never start by the IO monad. It’s the worst monad to start with.

*AL (0:44:06)*: Yes. I agree.

*JNO (0:44:09)*: The most interesting one is the probability monad because you throw two dice, and then you animate throwing two dice. And then they see something, which so easily you can do with so little programming. You are asking recommendations for language Haskell developers.

*AL (0:44:28)*: Yeah. No, I’m just wondering whether – I mean, what you’re saying sounds ever so slightly contradictory because you’re saying, on the one hand, Agda is a very interesting language, but then you’re saying you value Haskell for its simplicity. So that makes it sound to me like, for example, within Haskell, you would probably stay away from the more advanced type level features because they’re not exactly simple. Like you would not use GADTs or type families or whatnot. 

*JNO (0:45:01)*: No, I would use. And actually, people are using those in projects and like that. But in this teaching, I’m not using that. For instance, I had a master student last year who designed this typed linear algebra matrix, and it was quite a sophisticated use of Haskell because you can actually compose matrices with exactly the same syntax. You compose functions, for instance. So then you have to do all, you have to use all that artillery. And that’s very important and very useful. I was confining myself here to the teaching of Haskell to students in the first years of their training and, of course, in this pre-university course. 

If I look at this view that I have that comes from the Algebra of Programming book, that you should actually start from relations. So that’s where the starting point is. So if I were able, for instance, to teach discrete maths in this university, I would start from relational algebra. And then I could teach all the equivalence relations, all that. And for me, that’s the starting point. Or could you implement this in Haskell is not completely obvious to me. It basically is a mental process. You start relationally, and eventually, you land into something which is reactive because relations are declarative. So I tend to use a double-tier system where there is a layer where you think and there is a layer where we implement. 

*AL (0:46:42)*: But would you wish for a language that already supported your layer where you think at an earlier stage, which has more direct support for relations?

*JNO (0:46:52)*: Yes. We’re at the moment in the master course working with another language, Alloy. We do a lot of Alloy here. And I merge Alloy with Haskell. So if you think in terms of tooling, the first tool that we use in a project is Alloy. And then from the Alloy, you extract the functional programming.

*AL (0:47:15)*: Do you want to say a little bit more about Alloy? Like how does that work?

*JNO (0:47:19)*: Alloy is a relational language, and you can do model checking with it.

*AL (0:47:24)*: Okay.

*JNO (0:47:25)*: So you start the project by the things that are relevant. In Haskell, it’s the types. In Alloy, it’s the signatures. And you start defining relations between all the entities. And you start asking for counterexamples or instances of the system that you are designing. And you start getting nonsensical things. A recent project that I supervised, the student did blockchain. So the challenge was this: you are going to study blockchain. You didn’t know about anything about blockchain. Neither me. So you’re going to enroll in this course, and what you’re going to write is Alloy only. It was very interesting because you start defining the relations. And when you ask for instances of the system, it’s completely math. It’s not a shame. And you start adding requirements, invariants if you want. And the system gets tuned to what it should be. And now I’m going to have a student that gets Alloy specifications and draws Haskell from those. So in a sense, telling that you should have the pair of the two languages. You say that alloy is going to be used first and Haskell is going to be used when you want to have the final product. Whether you could have a relational Haskell, I don’t know. I mean, should we have a layer and then have a model checker associated to Haskell? That’s something I don’t have ideas about.

*AL (0:49:05)*: Do Alloy and Haskell as they are integrate well with each other, or is there a lot of redundancy involved?

*JNO (0:49:11)*: There are libraries in the Haskell libraries, which we call Alloy. There is an interface already between the two languages. Yes.

*AL (0:49:19)*: Yeah. But I mean, more like, if you want to do model checking using Alloy on a piece of software that is essentially functional software, do you have to effectively remodel your entire program in Alloy? Or is there some sort of either code extraction from Alloy to Haskell or a way to get a Haskell program modeled easily?

*JNO (0:49:45)*: There may be software to do that. I don’t know. The one I know is not that sophisticated. But this could be an area of research. When I started thinking about this picture, there was always this formal method inspiration. And that’s why I think functional programming fits here. So there’s a first stage which is not inherently functional, which is relational because you need to talk about things, you need to talk about properties of the software, and if you use relations, that’s very easy. And Alloy is actually a very – the other ingredient that Alloy has, and it’s comparable to Haskell, is simplicity. Again, it’s a very simple language. So the two match very well. And maybe there are projects that already used the two languages and the two paradigms that I’m not aware of. At the moment, I do that by hand. 

*MPG (0:50:45)*: Right. So you mentioned this earlier, but in the end, we always ask, what would you change about Haskell? So you already mentioned you would like better error messages, or not better, but to be able to turn them off completely. What would you change with Haskell if you were in charge?

*JNO (0:51:01)*: I think *(0:51:01 unintelligible)* had this or at Utrecht, they have a version of Haskell that would be more easier in terms of error message. 

*AL (0:51:12)*: Helium, you mean?

*JNO (0:51:13)*: Yes, Helium. That could be that we could have a switch to have less technical error messages. Not that much. Not that much. Not that much. 

*AL (0:51:28)*: Well, that’s pretty good as it is.

*JNO (0:51:31)*: What I think about Haskell, which is not as I would like, installing Haskell has become something – it should be like this, click. And installing Haskell, for instance, I have a Mac, is not that easy at the moment. And if I compare it with F#, it integrates very well with the ecosystem. The integration of F# with the ecosystem, C#, and all that is easier than in Haskell, from what I know. Maybe other, because I use Elm. Normally, I use Elm. And again, Elm is a kind of dialect for producing websites and all that. 

So I would say what Haskell needs is better integration with other things with the environment. So it should be easy, very easy to integrate Haskell with other environments, because that will make it much easier to use it in realistic, real applications. It is already used in real applications, but you have to do some work to integrate it. So that’s something which there is work to be done there. 

Also, the IHaskell, for instance, that we use has installation problems. So sometimes we have problems with that. So people who are developing the language have been very kind to us. But we feel that probably there is a need for more robust kernel. But it’s basically this integration with the outside world. 

*AL (0:53:00)*: Okay. Yeah. Let’s leave it at that. Thank you very much.

*MPG (0:53:04)*: Thank you for the chat.

*JNO (0:53:05)*: Okay. Thank you very much for having me.

*MPG (0:53:07)*: And yeah, we’re all very excited to see what the people who have been programming Haskell for 10 years, what they’re up to.

*JNO (0:53:13)*: Yeah. That’s something interesting. As I said, maybe I’m not here to – but you will tell.

*AL (0:53:22)*: They would want to hear an update from you, perhaps in a few years.

*JNO (0:53:26)*: We haven’t had the time. So we are collecting a lot of data, but we should write a paper about this sooner or later. 

*AL (0:53:31)*: Okay. Yeah. Thanks again. 

*JNO (0:53:33)*: Okay. Thank you very much for having me. 

*Narrator (0:53:36)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Monad-level sponsors: GitHub, Input Output, Juspay, and Meta.
