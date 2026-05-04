*Mike Sperber (0:00:15)*: Hi, I’m Mike Sperber and Andreas Löh —

*Andres Löh (0:00:18)*: Hello.

*MS (0:00:18)*: — and I sat down with Torsten Grust, who is a professor of Database Systems at the University of Tübingen. Even though Torsten loves SQL, he’s used functional programming and Haskell to inform his work on query language design and compilation. We talked about the best way to program databases, how to bridge the gap between regular programming languages and databases, and compiling just about everything to SQL. Enjoy.

So, Torsten, how did you first get in touch with Haskell, and when was that?

*Torsten Grust (0:00:47)*: So, first off, thank you for the opportunity to be here. It’s absolutely flattering, and I’m delighted as a database person to play a part in your Haskell-based podcast, so thank you for that. Let’s see where this leads us.

So, indeed, my first contact with functional programming dates back to the ‘90s, actually, in 1990, I would say, when I studied computer science at TU Clausthal in the northern part of Germany. And back then, we did LISP on VAX, Common Lisp on a DEC VAX running VMS. And I can recall exercises and assignments that were related to the symbolic differentiation of functions. That’s, I think, the first contact I had with FP in my studies. Actually, I think it was the only contact with FP in my studies back then. Back then, we were using C and Pascal and all these languages. And LISP really was an exotic language back then. Okay.

*AL (0:01:53)*: That was what immediately convinced you, or —

*TG (0:01:56)*: No, that was really a few months of FP-programming interlude. And after that stunt, I got back into, I think, Pascal-based programming because we were building — back then, I already dabbled in database systems, and we built query execution engines for a non-first normal form database, and that was happening in Pascal. So, back then, imperative programming was the style of programming I pursued. And I only got back in touch with functional programming in Konstanz, University of Konstanz, the very southwest of Germany, next to Lake Constance, very scenic and wonderful area to study. I did my PhD there, and I had the task to augment a course on programming paradigms, and I somehow selected FP and functional programming as the paradigm I was presenting in this particular course.

So, I think in 1996, I got first in touch with Haskell again. Back then, I was using Hugs by Mark Jones. Hugs 98, I think. And then at some point, I switched over to GHC and GHCi as soon as that became available. Well, by the end of the ‘90s, like 1998, 1999, I started to read full-fledged Haskell or FP programming courses at University of Konstanz. I was employed at the database chair, database research chair, but my PhD advisor, he was very open to anything related to programming languages, and I got the freedom to read an FP or a Haskell course. And actually, Andres, one of our members here on the podcast, he actually has been, I think, first a student and attendant in that course, and then later on he was a TA in that course, right?

*AL (0:03:57)*: Yeah, I think so. Yeah, I think I was in the — I’m not sure whether that was the first course you ever did in this direction, but I was part of a course, a student in a course, where you actually did Prolog and SML.

*TG (0:04:10)*: Oh, okay.

*AL (0:04:11)*: Perhaps that was the programming paradigms thing that you were referring to.

*TG (0:04:14)*: Right.

*AL (0:04:15)*: And then I became interested, and I asked you in particular, “Can I learn more about Standard ML?” And then you said, “I have, in the meantime, actually started to look more at Haskell.” And then I think I immediately said, “I am interested in that as well.” And then you asked me to become a TA. Yeah.

*TG (0:04:33)*: Yes. I think I read four iterations of that course, and then starting — I think in the second iteration already, in 1999, you have been a TA for that particular course.

*AL (0:04:42)*: That’s what I remember as well, although I’m not 100% sure. Yeah.

*TG (0:04:47)*: Yeah, I think so.

*AL (0:04:48)*: I can only repeat — I’ve said that before as well, but I can only repeat that over and over again. I mean, you are primarily the reason that I’m still using Haskell.

*TG (0:04:58)*: Oh, oh. That’s too much of an honor, Andres, really.

*AL (0:05:02)*: Yeah.

*TG (0:05:02)*: Okay. So, that course, actually, was not based on any textbook or something. So we had no, whatever, source or pile of assignments that we could give out. We had to do these from scratch, and you helped in building a cool library of Haskell-based assignments back then that we handed out on a weekly basis. And to this day, I’m using bits of these very early assignments in Haskell courses that I’ve been reading here at University of Tübingen. So, thank you very much again. Back then, the seed was planted, and 20 years later — no. Well, 15 years later, I still can make use of that cool material. It’s really great. So yeah, that would be my first contact with FP.

*MS (0:05:47)*: But you’re still teaching a Haskell course, even though you’re a professor of database systems? How does that work?

*TG (0:05:52)*: Yeah. Well, I’ve always been a researcher in database systems. And starting in 2000 and whatever, 2004, I’ve been a professor in database systems at different universities. Actually, I went back to TU Clausthal, and all the professors that back then were examining me then were my colleagues. That was a very interesting situation. Okay. But I’m a database researcher at heart. But I always perceived queries and query languages as functional programs and query languages as functional programming in that sense. That has been a viewpoint that has served me very well in the last 25 years, and I’m going to stick with it. And that means that — well, the shelf in my office, and my notes, and actually subdirectories of my teaching directory are full of FP-related material, and I use that to also teach Haskell-based courses here at University of Tübingen. Actually, I’ve done that in the last semester, in the last summer semester, but I think this will be the last time I’m teaching this particular Haskell course.

I have wonderful colleagues here in Tübingen, Klaus Ostermann and Jonathan Brachthäuser, who are probably very well known in the Haskell community, very prolific ICFP authors, for example. And these are wonderful colleagues, and they are taking over all the FP and Haskell-related stuff now, so I can — in the final years of my career, I can really focus back on the database-related stuff. But Klaus and Jonathan are wonderful colleagues here, and if I — I don’t know whether the audience can listen to that or hear that. But if I stomp on the floor, then Klaus Ostermann will hear that because it’s the office, right? Never mind. So, greetings to Klaus, if you hear that. It’s wonderful to be in a computer science department that has such a strong PL and FP, in particular, FP background.

*AL (0:07:56)*: But this relation between functional programming and your databases research, I mean, that also goes back to your PhD, right? I mean, you did your PhD on exactly that topic.

*TG (0:08:08)*: Yeah.

*AL (0:08:09)*: I don’t know. I mean, I’m not a databases person, even though I’m using databases in my day-to-day programming, of course. But is this viewpoint that the queries are functional or query languages should be functional, is that something that has caught on?

*TG (0:08:25)*: Well, that’s a problem with the database community. The folks in the database community are actually doing programming language and FP-related stuff without knowing it and reinventing it badly from time to time. That’s a sad fact.

And back in 1999, when I focused in my PhD thesis on comprehensions as a syntactic form of expressing queries, I used all the vocabulary that relates to comprehensions, like comprehensions and all the vocabulary, like monads and map and join and zeros and whatever, and folds and so on. And that really has not served me well when I used these terms and approached the database community in papers.

So I got these papers back reviewed with rejects saying, “What’s this? Is this algebraic wonderland or something?” So I had to very carefully rephrase stuff, but I was not ready to give up on the idea that, for example, comprehensions, monad comprehensions in this particular case, are very versatile and a very fitting way to express database queries. And that’s what I pursued for quite a number of years back then in 1999, 2000, and so on.

So, if you look at the very first research and very first publications on database query languages by Ted Codd, what he’s using there are the so-called alpha expressions. That’s one of the very first query languages, which was devised for relational database systems back in ‘72. And alpha expressions are what’s today known as tuple relational calculus. And if any Haskell person would look at expressions of tuple relational calculus, they would say, “Oh, that’s set comprehensions. That’s just set comprehensions.”

And Haskell, in a way, gave me a way, a method, to play with an executable version of the tuple relational calculus. I could just use Haskell comprehension syntax to express queries, to transform queries, to unnest them, to combine them, to fuse them, and so on. And what has been done on pencil and paper in the years back then, I could just replay and use live in GHCi and Hugs, and really play live with my tuple relational calculus queries. That really convinced me that there is a very neat and very interesting and deep connection between comprehension syntax as known in Haskell and database queries.

And there’s quite a variety of query constructs that have a very uniform expression in comprehension syntax. When the database folks talk about scanning a table or filtering or grouping or evaluating a window clause or evaluating an aggregate, all of that boils down to — these are all different, syntactically different clauses in the predominant relational query language like SQL, but they are all very, very uniform if you express them in comprehension-like syntax. You can express aggregation in comprehensions and quantification and, of course, nested queries and so on. All of that boils down to one syntactic comprehension construct, and that’s very, very powerful.

Comprehensions come with a theory of simplifying and unnesting them, normalizing them. That actually turned out to generalize techniques that have been invented to unnest nested SQL queries. We could just find that theory in comprehension form in papers published by Phil Wadler and friends back then, already in the ‘90s.

And since then, there’s a — I see myself as a bridge between the DB community and the PL community today. I established that back then in 1999, and it’s — I’m known in the database community for playing this bridging role to this day. I’m a member of the SIGMOD, the ACM SIGMOD (Management of Data) community, and the SIGPLAN community, and I plan to remain so just to be in touch with both communities. I’m a database person, but I’m an interested observer at the sidelines to see and watch what the PL and FP folks do.

And yeah, it’s super interesting. It’s very tough to find PhD students that can serve both areas that are interested to work at the intersection, right at the fence between DB and PL, but once I find such students, it’s very rewarding and super interesting.

*MS (0:13:01)*: Are these comprehensions that you talk about, are they more — can you compare them in expressivity to SQL?

*TG (0:13:09)*: So, I would have a hard time to find a SQL construct that you cannot express in monad comprehensions. So, actually, I cannot think of any. Maybe there’s the recursive common table expression that I would like to talk about a bit later, maybe in this podcast, that has no obvious syntactic counterpart in monadic comprehension because there is some iteration involved, some fixpoint computation involved there. But anything else, like filtering and grouping and joins, different types of joins, semi joins, nesting joins, outer joins, window frames, all of these have almost a direct counterpart in comprehensions. And even more so since Wadler and Peyton Jones introduced these query-like comprehensions back then, where they introduced this then group by clause and so on.

And since then, the syntactic resemblance to SQL is even more in your face, I would say. So, I’m using comprehensions as a syntactic vehicle to express queries. That means you cannot express a particular SQL query. I haven’t found that case yet, actually. So I think it’s a very fitting intermediate representation for query languages. Maybe it’s not the best way to execute queries, certainly not the best way, but it would be a very sane way to represent queries, to normalize them, to do all kinds of scope checking, to detect and analyze correlation between dependent subqueries, and so on. All of this could be done in comprehension syntax in a very uniform, very elegant fashion.

*MS (0:14:58)*: I mean, you say intermediate representation. That seems to imply — I mean, SQL is this unshakable thing that many people know, right? And that somehow they find reasonably easy to use, right? Even people who usually don’t program in anything else. Is there a potential for query comprehensions to have similar ergonomics, or is that really strictly an intermediate thing that is somewhere between the front end that is user-facing and the back end that is query execution?

*TG (0:15:28)*: I think you would have a hard time to convince the database community to use a comprehension-based query execution engine. But all the early parts of the query translation pipeline, like syntactic analysis, normalization, unnesting, query plan generation, that’s something I would say would serve — monad comprehensions could serve that particular purpose quite well.

Well, if you look at your typical monad comprehension or comprehension expression, then if you have nested iteration, like you have iteration in the tail of your comprehension, and then there’s another nested comprehension in the head of your comprehension, then you have a hard time to read anything of that nested comprehension, but a nested loop strategy of evaluating this particular expression or this nested expression. And that would be unacceptable for the database community.

There’s techniques that would unnest this particular expression and turn this nested expression into a flat relational join. And that’s something that query execution engines are optimized to execute. I think at some point, you would have to leave comprehensions behind and then transition to the typical algebraic, back algebra representation with join operators, group by operators, selection projection, and so on. But until that step, I think comprehension will serve you well.

I’ve actually given a talk at Mathematics of Program Construction. Back then, Ralf Hinze was inviting me, 2000-something, ‘15, I guess, to Bonn. I very much enjoyed that. I met Jeremy Gibbons there. I will never forget that. That was really remarkable. And that talk, actually, if I recall, is full of examples where I used just pure comprehension-based reasoning, like unnesting, normalization, simplification, and so on, to simulate what the database community otherwise had expressed in a zoo of representations, like surface language, SQL-level transformations, algebraic representations, then some sort of imperative program, intermediate representation to express parallelism, and so on. This zoo of representations could be unified and reduced to just comprehensions. In fact, I very much enjoyed that particular talk.

*MS (0:17:58)*: Right. Yeah, I seem to also remember — I mean, there’s one Haskell package, right, I think called HaskellDB. I don’t know if it’s still being maintained. That essentially does that, right? So you get a monad where you express database expressions, and then out of that monad comes, I think, relational algebra, and that eventually then translates to SQL. You can use that.

*AL (0:18:19)*: I think there are a number of high-level Haskell packages that try something like this to various degrees, right? HaskellDB is just, I think, the very first of these that existed.

*TG [18:30)*: Well, actually, here in Tübingen, we built something like that. It was called Database-Supported Haskell, or DSH. Back then, George Giorgidze was part of my team. He’s probably very well-known in the Haskell community still. I don’t know whether he’s still active or around. I don’t know. I haven’t had contact with George in quite a while. But that was a Haskell-inspired language. Back then, it was called Ferry, but when we transferred and embedded that into actually Haskell, a deep embedding into Haskell, in that language, you could just use maps and filters and comprehensions and group by operations to all the selected subset of the list combinators that you would find in Haskell’s Prelude. You could express queries in a deep embedding. A query representation would be constructed out of that, and we would then compile that into executable SQL code behind the scenes. That was quite nice.

*AL (0:19:27)*: I remember that project, and I think it’s actually, I mean, going a lot further than most of these even high-level Haskell database libraries went, right? Because I think, if I remember correctly, the goal of Database-Supported Haskell was to effectively let you write actual functions or computations in your queries, which would be compiled into the query language and executed on the database side, whereas, typically, even if you have a relatively high-level embedding of a database query language into Haskell, it’s still the approach that you’re doing relatively simple stuff on the database side, but all the more complicated stuff you’re trying to do in Haskell. And I think this was the only approach that I’ve ever seen that said, “Yeah, let’s try to do as much as possible on the database side.”

*TG (0:20:22)*: Yeah.

*AL (0:20:22)*: But if I also remember correctly, it was, to a large extent, relying on this sort of flattening transformation, which was difficult, right? I think, I mean, there are other Interlude podcast episodes we’ve had with Gabby Keller and with Manuel Chakravarty, who have been working on this flattening transformation in the context of parallel programming, right? And I think this was a similar idea. But I think it was always turning out to be rather difficult in all of these different contexts to actually get right.

*MS (0:20:58)*: Is there some commonality to these flattening transformations?

*AL (0:21:02)*: I think so.

*MS (0:21:02)*: Okay. So there’s —

*AL (0:21:03)*: But I’m not the expert on either topic.

*MS (0:21:05)*: Well, which is why we have Torsten.

*AL (0:21:06)*: Yeah.

*MS (0:21:08)*: I thought one of you might know, right?

*TG (0:21:10)*: Yeah. So, back then, in 2010 or something, when the Ferry and the DSH stuff was being worked on, we made painfully sure we really gave the guarantee that your Haskell code would compile into a reasonable number of SQL queries. It’s not always guaranteed that a given Haskell program can be compiled into a single SQL query, but we had to guarantee that if the result type of your Haskell program would have N list constructors, then we would generate a bundle of N SQL queries to recompute that particular result.

So, it was a static guarantee. You look at the type of your DSH program. You can statically say, “Okay, this has three nested type constructors. There will be three SQL queries that will be evaluated at program run time.” That’s different than the infamous 1+N query problem that you probably have seen, where the number of queries that is generated is dependent on the data or the actual live data instance in your database system. DSH tried to make sure that we can give the static type-based guarantee there.

And we also dabbled with flattening approaches to query compilation back a bit later. There’s a paper there that’s called The Flatter, The Better, and that was actually based on Blelloch’s flattening nested data parallelism, the flattening transformation. And that’s related to what Manuel and Gabby did, I think. Yes.

*MS (0:22:47)*: Maybe you can explain a little bit why it’s good to have as few SQL queries as possible from your DSH query. I mean, maybe shifting down a gear a little bit. Why is that good?

*TG (0:23:00)*: Yeah. Well, what you want to avoid is that the number of SQL queries is dependent on the instance of — fully on the table cardinality of the table that you’re operating over, and the 1+N query problem really describes that. You have one query that explores some outer table, collects bindings for a particular variable or row variable that is free in another part of your program, and then for each of these N bindings, you will evaluate a second query that will then do some computation job for you. But if your first table is doubled in size or grows by a factor of 10, you will then, at query runtime, generate double this number of SQL queries, or a tenfold number of SQL queries. And doing the context switch between your programming language runtime, say, Haskell runtime, and the database system to evaluate your query is super costly. You have to submit the query to the database system.

If that’s not precooked there in terms of a prepared query, then it has to compile and optimize at that particular point, then execute it. Then the result is being prepared, serialized to be shipped back to the programming language runtime, to the Haskell runtime, for example, and all of these costs are multiplied by N. It’s absolutely forbidding to evaluate such complex queries on this 1+N system. So that’s why it’s super important. It was a selling point, actually, of our approach that you could put a static guarantee that there would be only two, three, or very few queries generated.

*MS (0:24:40)*: So the result of one of those queries has to kind of be shipped back to the Haskell code and pass through the Haskell code to go into the next query, right? And this is not — can you explain a little bit why that is not possible within SQL? Is there some limit to the expressiveness of SQL that forbids you from doing it?

*TG (0:24:57)*: Yeah. What you normally do in a database system, you have a one-shot execution. So you have one particular query, a monolithic query. You send that to the database system, and you receive one table as a result. What you would need is a sequence of queries to submit it to the database system, and that sequence of queries, which would be — the database system would not return to you until that sequence of queries is executed. So you would have a transaction to be opened on the database system that then sequences all these N queries that you are going to submit. Opening transactions, closing transactions, transaction management is another source of overhead that you would like to avoid. You want to have a very simple single-shot or a few-shot transaction that you execute on the database side. And every interaction costs you dearly.

*MS (0:25:51)*: And so I mean, despite the limitations of SQL, it seems that one theme that runs through your work is, well, we’re going to treat SQL as a full programming language anyway, right? Or as a target language for more general computations. Is that fair to say?

*TG (0:26:06)*: That’s very fair to say. It’s actually treating SQL as a programming language, not just as the dump language that queries your database, data silos, in a sense. Treating SQL as a true programming language is — I think that’s the most important message I will send during my research career.

I have courses set up here at the University of Tübingen called Advanced SQL, where I preach this particular message. Don’t follow the knee-jerk reaction of using SQL for the simplest task, like access table T, evaluate predicate P, perform aggregation. But then it’s the point to ship back to the programming language runtime where the real work will be done. All the complex interesting work will be done outside the database system. That’s how you find 95% of database system installation being used today. And that’s a real shame because you have such full-fledged, highly optimized, fine-tuned query execution engines at your disposal, and all you’re doing is select star from T where P. That’s actually absolutely underusing the resources and the potential that you have there.

So don’t give in to that knee-jerk reaction. Try to rephrase your even complex computation in a way that can be encoded in a SQL query. May it be a query that is more complex than you would like. But to encode it in that particular query, ship it to the database system, execute it there without — execute it close to the data. That’s where the data resides. Execute it there and then ship the hopefully rather tiny result back to the programming language runtime, where you can do some post-processing, maybe, or maybe even all the work is already done by the database system.

That means you have to use advanced SQL constructs. You will not get by with scanning and joining and filtering. You will use window clauses. You will use nested queries. You will probably use common table expressions of the recursive kind or the iterative kind that have been added to SQL 25 years ago. Recursive CTEs have been added 25 years ago, and they are still a somewhat niche language construct because they seem syntactically unwieldy and have a bad reputation of being evaluated inefficiently. That’s a sad state of affairs. Actually, that drives my current research.

But if you’re willing to use these advanced SQL constructs, then you can address any problem out there. You could express it as a SQL query, at least in principle. The recursive CTEs make SQL a full-fledged Turing-complete programming language, and there’s no problem that you cannot possibly encode and execute using SQL. Whether you should do that, that’s a different question, but in principle, you could do that.

And that advanced SQL course in Tübingen, we are trying to push that limit. During the course, during the semester, the tasks that we let the database system compute are getting more complex and more puzzle-like and more awkward, in a sense, until we reach a limit where you say, “Okay, that’s not actually feasible anymore to express as a SQL query.”

But until you reach that point, you can do K-means and graph algorithms and connected components and clustering and drive state machines and evaluate drive simulations. You can use parsing. You can express parsing algorithms in SQL and all that good stuff. No need to let the data leave the database system and do that outside the database system.

*AL (0:29:52)*: Okay. Now I have a hundred questions, I think, but let’s first perhaps quickly — for people who are less familiar with this, perhaps explain what CTEs and recursive CTEs actually are.

*TG (0:30:05)*: Okay.

*AL (0:30:06)*: Do you want to do that?

*TG (0:30:08)*: Yeah, I would love to do that.

*AL (0:30:10)*: Yeah? Okay.

*MS (0:30:11)*: That’s why we’re waiting for a half hour for this.

*TG (0:30:14)*: I’m so grateful. So, because I can use vocabulary speaking to your community, to your listeners, I can use vocabulary that is really fitting. So a common table expression is like a let, a non-recursive let, in your favorite programming language. So you can divide a complex problem into several sub-queries, into several sub-problems, and solve these sub-problems, express them in separate SQL queries, each on their own. You can run these on their own, you can debug these on your own.

And the complex computation task that you want to solve is solved by assembling all these query pieces that you have named in a considerable fashion using the common table expression. It’s like a let, as I said. You name these, the results of your intermediate queries, and you assemble them to the grand computational task that you want to solve only at the very beginning, at the top level of the let, in a sense.

*AL (0:31:18)*: Do you get similar guarantees about CTEs as you get for let bindings in Haskell, that they’re evaluated only once, or —

*TG (0:31:26)*: The SQL standard doesn’t give you that particular guarantee. You really have to know the implementation, the SQL implementation of your favorite database system, to learn how that behaves at runtime. If you have a very reasonable database system like PostgreSQL, for example, or DuckDB, or many other off-the-shelf relational database systems, you can annotate your CTEs using a materialized or not materialized modifier, and that will guide, that will steer the inlining or the one-shot evaluation, the materialization of the intermediate results. So they have some fine-tuning opportunities there. But the declarative goals and nature of SQL says, “Don’t put these modifiers there. Let the engine decide whether materialization is a good idea, yes or no.”

So that would be a common table expression, and these have been around for many years, like 30 years already. But in 1999, or in SQL 1999, the standard added the recursive common table expression.

*AL (0:32:36)*: And are they then simply recursive let bindings?

*MS (0:32:38)*: That was your obvious next question, right? Is what about recursive?

*TG (0:32:41)*: Actually, they should have been named iterative common table expression, I would say. That would be a more fitting name. But back then, Datalog and logic-based query languages were all the hype. And of course, Datalog is then built around the recursive evaluation of terms and queries. That’s where that came from. But I think iterative common table expression would be a more fitting name.

In iterative common table expression, you iterate the evaluation of a SQL query. Actually, there’s one initializing part that’s executed once, exactly once, and that particular query will give you an initial table. A SQL query cannot give you anything else but a table. So that initializing query will be evaluated once. You get an initial table. That particular initial table is input to a second part of a query, which will use that table and produce the next table for the next iteration. So, initializing table in, first iteration result out. That first iteration result goes back into the second part of the query to compute the result of the second iteration, and so on, and so on, and so on.

So the second part of the query is evaluated again and again and again based on the results that have been computed in the preceding iteration. And once your query produces no rows in a particular iteration, that’s a signal that the evaluation of the iterative or recursive CTE has come to an end.

The overall result of your iterative CTE then is the concatenation or the union of the results produced by the very initial query and all the iteration results that have been collected or produced while the iteration was going on. So that’s the overall result of the iterative CTE.

*AL (0:34:37)*: So it’s really good for things like transitive closure of something or —

*TG (0:34:41)*: Yes. Yeah, yeah. That’s actually the textbook use cases you find. Explore a tree-based or tree-shaped relationship of nodes, explore a graph, follow paths, and so on, build part lists of assemblies of an engine, for example. That would be the textbook use cases for recursive iterative CTEs. But you can do so much more with these. That’s mind-boggling, actually.

Because your iterative CTE already consists of two parts, the initializing part and the iterative part, and then typically, in your typical use cases, graph exploration, for example, and so on, the iterative part is not the easiest query to read. These iterative CTEs have a bad reputation of being super hard to write, super hard to read, hard to read like an APL program maybe or something, and they really have a bad reputation of being evaluated inefficiently.

*AL (0:35:42)*: Is that justified or is it —

*TG (0:35:45)*: I think it’s not justified. This inefficiency and the unwieldiness is not baked into the approach. It’s just how this construct is perceived, but probably it’s the most niche and the most complex SQL construct that you can have out there, and it really is turning off many developers out there for — I think it’s a true pity.

There’s some critique you can have at these iterative CTEs. For example, they have what we call in Tübingen “short-term memory.” So your iterated query can only see the result that has been computed in the immediately preceding iteration. What has been done two iterations ago is lost in the mist. You will see it in the very final end as the top-level result of your iterative CTEs. While you iterate, you can only see what has been computed in the immediately preceding iteration.

So that leads query authors to manually, whatever, embed arrays in their result tables, in which they try to remember the history of the relevant bits of computation. Like in this array, collect all the nodes that have already visited a particular graph so that I don’t visit this node more than N times, for example. And that means that, really, over iterations, you accumulate a lot of baggage that you pass from one iteration to the next. That’s part of the bad reputation of CTEs, iterative CTEs, that they are inefficient to execute.

*AL (0:37:22)*: Well, it sounds comparable to things that you have, like if you’re trying to express things as catamorphisms, right? And you also basically have typically only access to the immediate predecessor, and then you have some encoding tricks like paramorphisms or something like that, where you can then make that more flexible. But perhaps this is leading too far. I mean, I find it interesting, but —

*MS (0:37:47)*: So essentially, this sounds like it’s analogous to tail recursion, right? Is that a fair way to —

*TG (0:37:53)*: Yes, very much.

*MS (0:37:55)*: But tail recursion, of course, is not general recursion. Is there still some limitation in expressivity, or is there some trick that you can put a stack inside the tables that you’re generating?

*TG (0:38:08)*: That’s something that is actually played. Actually, this trick is quite often played. That’s one of these if you don’t maintain — actually, very often, these arrays, they are operated in stack-like fashion. Mike, your comment is really point on. So people try to simulate generative recursion then using these iterative constructs in SQL.

This brings me to another point, because it’s so sad that the syntactic unwieldiness and maybe also the sad inefficiency of CTEs turns developers away from that construct, that here in Tübingen, we try to write compilers that let you write your typical imperative-style code. You would program with while loops, if-then-else cases, continue breaks. You have imperative-style control flow, you have updateable variables, and so on. So you really can adopt a programming style that’s very well adapted and adopted by the database community because these guys are used to write PL/SQL, pure programming language for SQL queries, which is just imperative-style code.

And we use these imperative programs and transform them first into SSA, then into administrative normal form (ANF) based on an algorithm that we stole from Manuel Chakravarty. And in these ANF programs, or calls, or function calls that you will find are tail calls, actually. We then merge a family of such ANF functions into a single big function using a technique that we stole from the FP community that I think is called trampoline style, where you have a single core driving iteration that, in each iteration, inspects some bits of data to decide which parts of the computation actually is to be invoked in this particular iteration.

So, if we go from imperative-style code to SSA to ANF to these trampoline-style ANF functions, and these then can be immediately translated into WITH RECURSIVE CTE. So we allow developers to write imperative-style UDFs and then apply this translation chain, all the steps stolen from you guys, SSA transformation and the ANF transformation and the trampoline style stuff, and go all the way to recursive CTEs and evaluate these imperative-style programs using a recursive CTE in the background.

So best of both worlds, write imperative programs, think in imperative terms, and very updatable variables, but have that executed inside the database system close to the data in terms of an iterative CTE, not in terms of a Python program that is being evaluated outside the database system.

*AL (0:41:18)*: I think this leads me to the question that I wanted to ask for a while, because, I mean, granted, I get it immediately that 95% of programs that are using databases are underusing the expressive power of the database query language. But if we leave ergonomics aside for a moment, and we assume that working with SQL is as pleasant as working with Haskell, say, right? If we make that jump for the time being, then what is the guideline? Is it just minimizing data transfer? Or I don’t know. What is the guideline? What should I put on the database and what should I put into the main programming language? Or what should I still be doing in Haskell at all?

*TG (0:42:04)*: Yeah. There’s probably bits of your application logic that are only available or only expressed at the programming language level. A particular Haskell function for which no counterpart exists in the database system, a particular very application-specific piece of code that has no efficient counterpart on the database system.

The best thing then you can do is use the database system, collect all the input data that you need for your Haskell function in one query. Move that particular batch of bindings or parameter bindings out of the database system into the language runtime heap, and have then Haskell execute the rest of the computation.

Don’t ask the database system to produce parameters for your functions in a piecemeal fashion, but do that in a batch. That’s probably the only advice I could give. There will be plenty of stuff, like, whatever, UI interaction, something that has no place and no counterpart in the database system. Of course not, but all the data-intensive parts of the computation, I think they should be moved close to the data inside the database system.

*AL (0:43:27)*: Right. And now, sort of like taking the ergonomics into account as well. So, I mean, you mentioned database-supported Haskell at some point, but I mean, that never really made it, right? So, is there a recommendation you can give what to do in practice to make the use of SQL more pleasant? Are there systems that are not widely known on the database side that are actually providing, I don’t know, better surface languages than SQL itself, or are there libraries in the Haskell world that we should all be more aware of?

*TG (0:44:08)*: There’s actually quite a number of efforts in the database community that try to invent and come up with compositional, syntactically pleasing, compatible with the 2020 syntax of queries. For example, PRQL, P-R-Q-L, I can only recommend to look at this particular project. That’s a syntactic layer on top of SQL that underlines its compositional query formulation, syntactically lightweight, rather elegant.

There’s a different approach called SaneQL, which does the same thing. Under the hood, SaneQL and PRQL are translating expressions of programs into SQL queries, but that can really take some of the pain away from formulating pure SQL queries from scratch. Actually, I’m not the best person to ask that because I’m a big SQL lover. I look at SQL source and SQL code and properly indented, formatted properly, and laid out properly using CTEs, for example, that can be very pleasant to read.

*AL (0:45:24)*: But haven’t you also always been a lover of strong typing or static typing, let’s say?

*TG (0:45:31)*: Well, SQL queries are statically typed, so that’s —

*AL (0:45:34)*: Yeah. Okay. I guess the distinction between runtime and compile time always feels rather blurred to me, but you’re right, of course.

*MS (0:45:44)*: Composition is kind of strange in that type system, right?

*TG (0:45:47)*: Yeah.

*MS (0:45:47)*: But I was going to ask, I mean, you mentioned that you compile imperative languages into SQL, right? But it seems that what I want to do is, of course, write essentially maybe a Haskell program that has query comprehensions and recursion in it, right? Can I compile that to SQL too, or can you compile it to SQL?

*TG (0:46:05)*: Yes, we can do that because we have done work on that in — let me check my notes. 2022. That’s a paper called Functional Programming on Top of SQL Engines, and that’s actually — I’m mentioning that because we published that at the venue that you guys are actually in charge of. That’s PLDI. Is that a known venue? I think so.

*AL (0:46:29)*: Yeah.

*MS (0:46:30)*: Yeah.

*TG (0:46:30)*: Yeah? Okay. So, what we do there, we admit you to write recursive UDFs. So, where the imperative-style guys would use for loops and while loops, you use recursion to express your function logic. In that particular paper, we used the very heavily recursive version of the Floyd-Warshall algorithm. You could just write that using this particular approach.

We transform that particular function into CPS, which is, of course, higher order. That’s bad because there is no such thing as any higher-order execution engine or something. Nothing inside the database system is prepared to evaluate such a CPS program. So we defunctionalized that in Reynolds’ style and then end up with a tail-recursive first-order function and some of these typically wrapper functions that are generated by Reynolds’ differentiation, this supply function in a sense. And we then merge the body of your function with this apply function. We end up with a trampoline-style code, much like I mentioned 10 minutes ago in this podcast, and we in turn rewrite that in the WITH RECURSIVE function again, and there you go. You write recursive UDFs really in a functional style, and you end up with a WITH RECURSIVE-based implementation at runtime in your system.

*MS (0:48:04)*: So if I can ask a heretic question, does that make built-in languages or built-in UDF runtimes? I don’t know. I mean, you can write Haskell functions and deploy them to PostgreSQL, or you can write PL/SQL, which Oracle supports natively. Could we just delete all that? Should we delete it?

*TG (0:48:24)*: Yes.

*MS (0:48:27)*: I mean, PL/SQL is the bane of a lot of projects, right?

*TG (0:48:31)*: Yeah, yeah, yeah.

*MS (0:48:31)*: There’s all this logic that’s locked up in the database that’s very difficult to move outside —

*TG (0:48:41)*: That’s absolutely right.

*MS (0:48:41)*: — that locks people into the Oracle product licensing scheme and so on.

*TG (0:48:46)*: Yeah, yeah, yeah.

*MS (0:48:47)*: So it seems that might be a way out, right, is to compile all that PL/SQL away.

*TG (0:48:52)*: Yes. PL/SQL is actually, I think, among the database developers out there, probably also not a very — it’s not the most loved technology, let’s phrase it like that.

*MS (0:49:02)*: But it’s used a lot, right? Maybe not loved but used.

*TG (0:49:04)*: It’s used a lot. I think this planet runs on top of PL/SQL. If you would switch that off, we could pack our things and go home. It’s like that.

But still, the SQL execution engine of Oracle or any other database system that implements PL/SQL-style UDFs, the SQL execution and the PL/SQL interpreter are two different entities. And when I evaluate a PL/SQL UDF, I have to call out to the SQL engine to execute the queries that are embedded in my PL/SQL code. I then compute the tabular result of this embedded query, hand back control to the PL/SQL interpreter, which will then step to the next few states before it calls out to the SQL engine again. It’s a constant back and forth.

We actually quantified the overhead that you can have there while you switch back and forth between imperative style, interpreted PL/SQL evaluation, and the set-oriented, batch-oriented, collection-oriented evaluation in your SQL engine. And the friction is absolutely insane. It kills everything, and it gives PL/SQL also a very bad reputation of being super slow.

I think compiling your PL/SQL UDFs into a pure SQL recursive or iterative CTE query that really merges seamlessly with all the embedded queries that your UDF embeds or includes, that’s a strong competitor as an implementation technology for PL/SQL, and it gives you the advantage of having PL/SQL-style UDFs on top of database systems that have no PL/SQL interpreter at all from the start, in the first place.

All you need is the ability to evaluate recursive CTEs. SQLite can do that. SQLite doesn’t have PL/SQL. MySQL can do that. MySQL also doesn’t have PL/SQL. So it’s a gateway to get PL/SQL implemented on top of such database backends.

*AL (0:51:06)*: I have a question, which is of a bit different nature, so I’m not sure whether there’s more, Mike, you wanted to ask about this particular —

*MS (0:51:13)*: No, you go ahead.

*AL (0:51:14)*: Okay. So if we go back to your uses of Haskell throughout the years, I think there was the — you have been using Haskell for teaching for quite a bit, and you have been using Haskell to essentially take functional programming ideas and apply them to the database world. Is there —

*TG (0:51:36)*: Steal. I call it steal the ideas.

*AL (0:51:38)*: Yeah.

*TG (0:51:39)*: Yeah.

*AL (0:51:39)*: Is there something that functional programming could learn the other way around? Like, is there something in the database world or in the world of query languages as they’re actually being used that you wish Haskell would adopt?

*TG (0:51:55)*: In the very beginning, I mentioned that quite a number of query constructs, like quantification or aggregation, or, of course, filtering, grouping, and so on, all of these could be expressed in comprehension form in a very natural and a very homogeneous fashion. And it would be cool if Haskell would have comprehension syntax that would allow you to not only operate over collection monads in a sense, but over any readable syntax, sensible syntax, to express aggregation or quantification in terms of comprehensions. And a comprehension that generates Booleans but computes the universal quantification or the existential quantification over these Booleans, or a comprehension to compute the minimum or the sum of a range of numeric values that you are producing.

What you can normally do is produce a list of numeric values and then use whatever, a fold or a sum primitive, to then sum the generated list of numbers. It’s a two-step process in a sense. So technically, also, you would have the comprehension and apply that fold or the sum to that comprehension. I think it would be nice to annotate the comprehension and say, “Hey, this is a sum comprehension.” S-U-M, so it’s a summing comprehension. Or, “This is an exists or for all comprehension,” so that the addition or the Boolean operation would be folded into the evaluation of the comprehension. That would be quite nice and —

*AL (0:53:41)*: But the only difference I currently see beyond perhaps the syntactic difference is that you would sort of get guaranteed fusion, or is there more to it?

*TG (0:53:51)*: I think the fusion is what the database guys would be after, guaranteed fusion. So if you want to aggregate and sum a list of numbers, you better not materialize lists of numbers but do the aggregation on the fly. And of course, foldr-build style fusion or deforestation could probably give you that.

I’ve experimented with that back in the late 1990s when we wrote papers about streaming evaluation of queries based on this — I think it’s called cheap deforestation approach invented back then. And that turned out to be quite promising. Back then, the end of my PhD didn’t allow me to really implement and pursue that. But I think cheap deforestation is one way to simulate what the database guys would call streaming query evaluation. So aggregate on the fly, group on the fly, quantify on the fly, and so on. That would be cool.

Now, I think that — are there guarantees in Haskell or in GHC that say this sum aggregate is being fused with the list of values that I’m currently producing with this comprehension?

*AL (0:55:09)*: So, I think the only way to be really sure, to really have a guarantee that I’m aware of, is to effectively use staging.

*TG (0:55:20)*: Okay.

*AL (0:55:21)*: So, if you — I mean, in Haskell, unfortunately, this is a language construct which is not really perfectly supportive, but there is a subset of Template Haskell, which is called Typed Template Haskell. And that is essentially just a typed staging system which allows you to say, “Here are computations that I want to evaluate completely at compile time,” and basically combining the idea of, like, it doesn’t have to be foldr-build fusion. It can also be some form of stream fusion. But of any of the common streaming approaches with staging, you can get a system that effectively guarantees that the fusion actually happens.

But in practice, I think there’s also literature about this. I think there’s papers about — I forgot exactly whether it was Oleg Kiselyov or Jeremy Yallop. Some people have been writing about staging and fusing staging for fusion, not specifically in the Haskell context, but I think in the Meta or OCaml context.

But I think the same ideas could be transferred to Haskell as well. The only practical problem is that I think Typed Template Haskell has some rough edges, and it’s also not very beautiful on the surface because the actual staging annotations are all very heavy. But in principle, this could be done.

Apart from that, I think, yeah. I mean, the state of the art is typically to use rewrite rules, right? I mean, GHC rewrite rules. And that never gives you a 100% guarantee, I think.

*TG (0:57:05)*: Okay.

*AL (0:57:05)*: You can try very hard to make it tempting for GHC, but you can also almost always construct cases where it breaks down.

*TG (0:57:18)*: Okay. Back in 1999, actually, I was pursuing this particular approach where I said, “Let’s have comprehension that can do aggregation, or it can do quantification, and simulate that just by introducing that particular sum aggregate, or whatever, the fold of Booleans, by introducing that automatically.” And I wrote that up, and I took a sketch with me of that approach to Dagstuhl, to the computer science seminar location in Germany, to Dagstuhl, and I think you have been with me there, Andres, in 1999. We met Phil Wadler there and Doaitse Swierstra, I think.

*AL (0:57:59)*: Yeah. That was my first Dagstuhl seminar, and again —

*TG (0:58:01)*: Yes. It changed your life, I guess.

*AL (0:58:05)*: Yeah. Again, I mean, to some extent that is also responsible for me still doing Haskell, but, I mean, you are responsible for getting me there.

*TG (0:58:13)*: Okay.

*AL (0:58:14)*: So it all comes back to you yet again. Yeah.

*TG (0:58:17)*: I only wanted to say that I took these notes, these sketches of that transformation, and after the second or third beer that particular evening, Phil Wadler got hold of these notes. He looked at that and said, “Oh, I’m disappointed that you brought it up in this particular fashion, and there’s actually a bug in there.” And that’s all he said. And then he handed me back this particular piece of paper. And I can recall this particular night, it was a sleepless night. I was poring over this particular paper, and I found the bug, I guess, and it was — I showed it to him the next morning. I was completely wasted. I showed it to him the next morning. He said, “Ah, yeah, that’s how it should be done.” I will never forget that particular incident. It was very — impressed me very much. Yeah.

*MS (0:59:09)*: So, can we put the LINQ work? LINQ, right? Can we put that in that context at all in the sense that it gives you a representation where you could express those fusions that you’re talking about?

*TG (0:59:25)*: Yeah. Well, actually, back then, when LINQ was hot — so Language Integrated Query, actually, that came along with C# proposed by Microsoft. We built an alternative LINQ to SQL compiler that avoided the 1+N query problem. And that was based on the Ferry and the DSH work, actually. That could support a wider range of LINQ primitives and compile them to SQL and give that static guarantee that we generate query bundles of statically known size and avoid the 1+N problem. Actually, we showed that to the Microsoft folks back then, but we only earned raised eyebrows at a particular point, but yeah. So there was some connection there from the DSH and Ferry approaches. Yeah.

*MS (1:00:15)*: When you talked about what should happen in the database and what should happen in the application program, I mean, that takes a little bit of judgment and maybe also a little bit of experimentation, what the database can do efficiently, right? So it’d be nice if you could move the same code sort of back and forth between the database and your application code. I mean, that’s one of the problems with SQL, is that there’s usually a significant impedance mismatch between your application code, the SQL code, or if you do away with that, you end up with object-relational mappers, which bring in a whole beast form of their own problems, right?

*TG (1:00:53)*: Actually, I do not teach ORMs here in Tübingen at all. It’s an approach I do not believe in.

*MS (1:01:02)*: I mean, if there was a way to do negative teaching. We’ve heard about this. We’re going to make you forget it, then —

*TG (1:01:09)*: Make it unseen.

*MS (1:01:09)*: It would be high on my list of things to unteach, maybe.

*TG (1:01:14)*: That’s very interesting to hear. Okay.

*MS (1:01:16)*: I mean, we’ve talked sort of about the mechanics of efficient execution of programs, right? But I mean, I think about software architecture a lot. Specifically, applications that were written in the ‘90s are littered with SQL fragments that are being assembled in the application program. And I mean, that has obvious problems. And one of the obvious problems was that now your application program, all of your application program, knows sort of the structure of the SQL and therefore knows the structure of your database. And then people would have a big database with the data warehouse of all their organization’s data in there, and nothing could ever, ever change. But you would want to change things, because the SQL queries that were efficient for today’s problems or today’s SQL queries might be efficient with today’s database schema, but tomorrow’s SQL queries might not be.

*TG (1:02:16)*: Absolutely, yes.

*MS (1:02:16)*: I mean, you mentioned that the planet runs on PL/SQL, so I’ve certainly encountered a lot of PL/SQL code. For example, in insurance companies, a lot of them run on PL/SQL. And there, it’s often the case that the database schema was designed two decades ago, and today’s queries take minutes to run on fairly simple things, right? And so you want to change things. You want to be able to change or evolve your schema, but you can’t because the SQL code is littered throughout your application code, no. That’s why ORMs came along, but unfortunately, ORMs kind of couple the database schema to your data types in your program, and you kind of get the same problem in disguise.

And I mean, you mentioned that you love SQL. One thing that I really dislike, not about — I mean, I guess it’s a necessary part of SQL, but one negative effect that SQL has had is SQL doesn’t have algebraic data types, right? It doesn’t have sum types.

*AL (1:03:13)*: It’s one of my remaining questions.

*MS (1:03:15)*: Right?

*AL (1:03:15)*: But thank you for just —

*MS (1:03:19)*: And the lack — unfortunately, because database design had such a big impact on sort of enterprise software design in the past, that means that a lot of software that’s out there doesn’t have sum types, right? It only has product types. And this aspect of the design reaches into even the UIs and to the way that people interact with the software and so on. And fundamentally, I think it’s because a lot of the data design comes from the database design or is restricted by the limitations of SQL, right? Of course, we can encode algebraic data types, but we know the limitations of our language tend to be the limitations of the stuff that we do with that language, right?

So, can you — maybe here’s a question. Can you also compile it? Shouldn’t you be — I mean, you said that you’d been compiling away recursion into these common table expressions, but shouldn’t we also be compiling away or supporting algebraic data types?

*TG (1:04:21)*: Well, we should. And back when George was still part of my group, we actually thought about this, and we also wrote something up about mapping non-recursive sum-of-product types to database encodings. So, of course, products map to tuples. Sums map to tuples of lists of the choices. And that gives you the opportunity to leave one of these lists, the non-selected choice, empty, in a sense. And how to represent — what you then end up is, of course, nested lists that you want to encode into the database system. That’s something that has been known how to do. Known techniques are available since the non-first normal form databases, so surrogates, foreign key joins, and so on. That’s something that we explored in a paper in 2010 or something, how to map this sum-of-product types to database types.

But it’s not the piece of work I’m most proud of, actually. It works, but it’s probably — behind the scenes, it’s clunky, and there’s something missing there. The type system of SQL is, it’s tables of tuples. Punkt. That’s it. Period. Yeah.

*MS (1:05:46)*: But is it possible to imagine a system or an evolution of SQL or relational databases that retains the efficiency advantages and still gives you more powerful data modeling?

*TG (1:06:00)*: I guess so. Nothing speaks against that. Well, there is quite a number of advanced type constructs that you can now find in particular SQL dialects in particular systems, like nested arrays, structs of arrays, arrays of structs, structs of structs, JSON, whatever. All of this is possible. I think we could use the cleverness to also encode sums of products. Yeah. Nothing speaks against that. It’s not something that — probably for the reason that you mentioned, Mike, it’s not something that’s high on the list on the database folks because, yeah, the algebraic data types is the go-to way to model data in the circles of the listeners of your podcast. But it’s absolutely unheard of in the database circles or communities.

*MS (1:06:52)*: Yeah. Not just there, right? It’s unheard of, I think, outside of functional programming.

*TG (1:06:57)*: Okay.

*AL (1:06:57)*: Yeah, yeah. It’s self-reinforcing to some extent. I mean, you’re — like Mike, you’ve been saying that, okay, so this is because the database design spreads into the other languages. But it’s like if the other languages don’t support it, there is also no need for the databases to change.

*MS (1:07:12)*: Yeah. I mean, maybe we’ll see that change with the introduction of essentially algebraic data types into Java. But even there, its uptake is very slow, right?

*AL (1:07:22)*: Yeah, because — yeah.

*MS (1:07:24)*: Right.

*TG (1:07:24)*: Along with pattern matching, or is there pattern matching in Java now?

*MS (1:07:27)*: Yeah.

*TG (1:07:27)*: Okay. Okay.

*MS (1:07:28)*: Yeah, there’s basically full support of that in Java now. but whenever I talk to the Java folks, a lot of them don’t seem to know what to do with them, right? So we haven’t followed up with the necessary teachings efficiently to then tell people, “Now there’s this cool thing.”

*AL (1:07:49)*: Yeah, I kind of even understand that, right? Because it’s so different. And if you suddenly have a language where you have both and you have to make a choice to either do the classic thing that everybody knows or you have to do this new thing, which kind of is difficult to use selectively but basically tempts you to go all in but then you end up with something that just looks completely different and completely alien. But then there is a resistance. I find that understandable—

*MS (1:08:24)*: Yeah, I’m not sure that’s true, right? Because we’re not even at the point yet where people have seen it and have had an opportunity to reject something that they’ve seen.

*AL (1:08:32)*: No, but sometimes you simply don’t — like, as you said, sometimes you simply don’t immediately know how to productively use it, right?

*MS (1:08:39)*: Yeah.

*AL (1:08:39)*: Because there’s no easy way to do it a little bit. Yeah. I think we should probably come to an end. Is there anything, Torsten, that you would still like to discuss?

*TG (1:09:00)*: Yeah. Well, because this is a Haskell podcast, I will only want to very briefly mention that Haskell served as well as an implementation language for the prototype that we were building. For example, we were building a hood-style observational debugger for SQL, where you could mark a particular subexpression in your SQL query, even entire subqueries, and then observe how they are being evaluated at query runtime. That involved quite some query analysis and transformation and query generation behind the scenes. And Haskell has served us very well with its tools to, whatever, build ASTs of SQL queries, match these, transform these, rewrite these. That was super helpful.

We built a data provenance analyzer for SQL, where also one particular SQL query was split into two parts and then evaluated in two phases, in a sense. That particular splitting was rather involved, and we built that on top of Haskell, and it was the absolutely perfect choice to use as a tool for that particular method. So, my thanks go out to the Haskell community for providing such an absolutely wonderful toolbox.

*MS (1:10:20)*: Excellent.

*AL (1:10:21)*: Yeah, thank you.

*MS (1:10:22)*: Thank you so much, Torsten.

*TG (1:10:24)*: Okay. Thank you so much. Thank you, again, for the opportunity.

*Narrator (1:10:29)*: The Haskell Interlude Podcast is a project of the Haskell Foundation, and it is made possible by the generous support of our sponsors, especially the Gold-level sponsors: Input Output, Juspay, and Mercury.

