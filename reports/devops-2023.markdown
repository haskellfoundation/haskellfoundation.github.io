---
title: Haskell Foundation DevOps Yearly Log - July 2023
author: Bryan Richter
date: 2023-07-14
summary: Achievements and reflections from a year of improvements to GHC's CI
---


<p>Hello, and welcome to the first Haskell Foundation DevOps <strong>yearly</strong> log, where I document my work to shape the Haskell of the future.</p>

<p>I have not worked alone, of course. My part in the play is rather microscopic compared to the many groups and individuals contributing to the Haskell community. Think of us as the trees, rocks, and streams of the Haskell forest, subtly shifting, rejuvenating, and co-evolving. Getting started with Haskell is easier than ever thanks to the ongoing development of tools like GHCup and Stack. The GHC Steering Committee, Core Libraries Committee, and Haskell Foundation Stability Working Group continue to chip away at hard coordination problems that would otherwise only get more difficult. Countless groups work on the libraries that power Haskell programs. And we are part of a wider evolving sphere: New technologies and paradigms in software development are always coming onto the scene.</p>

<p>Then there is GHC itself, standing tall at the center of our Haskell forest. It has become more performant, reliable, and useful than ever. I, meanwhile, have been tending the mushrooms that grow among its roots, working to improve GHC CI. In this log, I will explain what that means, and I will break it down to give a sense of where my time has gone. For now, suffice it to say I have been successful in reducing frustration in the GHC contributor workflow. Although challenges remain, I think good things are coming and I look forward to continuing the task.</p>

<h2>My role outside of GHC CI</h2>

<p>The DevOps role has many responsibilities, so I did not devote all of my time to GHC CI. The other tasks contributed to the Haskell ecosystem by reducing the burden on GHC maintainers (not just contributors) and by encouraging additional contributions to GHC. So before diving into the details of CI, I will briefly survey all the other work that I did outside of it.</p>

<p>First, in recognition of the public aspect of my role, I spent time on community engagement. (Did you know mushrooms may communicate with electrical signals?) I did this by writing on Discourse, Matrix, IRC, and the GHC wiki. I wrote weekly reports on Discourse that gave a sense of progress and activity. That habit subsequently inspired other such reports, like the GHC Web Assembly Weekly Update. I also encouraged GHC contributions by answering questions or providing guidance. I mentored volunteer contributors to the CI infrastructure itself, including Chris Linton-Ford, who rewrote one of my services from Python to Haskell. Feel free to reach out if you would also like to get involved with DevOps!</p>

<p>Two other notable projects outside of GHC CI were Cabal release pipelines and Mac notarization for GHC releases. Thanks to my work with CI on GitLab, the Cabal team was able to release official binaries for Cabal 3.10 on thirteen different platforms in March, compared to 3.9's four. For the Mac notarization project, I familiarized myself with notarization (part of the standard Mac developer workflow) and identified the steps to produce notarized GHC binaries. Unfortunately I didn’t implement an automated solution for this. However, I identified the key commands that should be run during the manual GHC release process. Coming in GHC 9.8, notarized releases will keep GHC more in line with MacOS's ever-evolving security mechanisms.</p>

<h2>CI - Description</h2>

<p>In this log, I try not to assume much familiarity with DevOps or CI, so I will provide some background on the what and why. CI stands for "continuous integration". It is a process that integrates new software into a full system. CI can be arbitrarily complex, but typical hosted CI systems are structured as a pipeline of individual jobs. (Terminology may differ—for example, GitHub uses the term "workflow" instead of "pipeline".) A job corresponds to a single task, like "build the code" or "run the tests". A pipeline, meanwhile, is a sequence of jobs that may depend on each other. Here’s a cropped visualization of a GHC pipeline showing dependencies:</p>

<img alt="Screenshot of a pipeline visualization from GitLab's UI" src="pipeline-visualization.png">

<p>In advanced forms, CI can be quite complex. It can be implemented as multiple pipelines, each of which is defined as a directed acyclic graph of jobs. Furthermore, many different products can be used to implement CI. Because of this complexity and the breadth of implementations, CI has become a generic term encompassing any automated processing of source code. Personally, I think of CI as a service for developers that makes them more effective and helps them produce higher-quality products.</p>

<p>DevOps is even more vague. Microsoft calls it a "union of people, process, and technology to continually provide value to customers." DevOps was an industry-wide response to the disconnect forming between software development, where potentially valuable stuff is created, and operations, where service is actually delivered to users. In some cases, this disconnect formed because busy beavers created organizational dams preventing value flowing downstream to users. No one is to blame, though—these are hard, decentralized problems that require a lot of coordination to overcome. The DevOps solution is not just to prevent dams from forming, but to move value delivery closer to product development. In other words, the way software is delivered should influence how it is created. Dams aren’t a problem if everybody is swimming in the same pond.</p>

<p>How an organization "does DevOps" is where things get vague. It is often referred to as a "culture", which kinda gives me happy fungus vibes. But I believe that—in the context of open source, Haskell, and GHC—DevOps should be focused on empowering contributors and reducing the workload for maintainers. For now, this means developing CI.</p>

<h2>CI - Challenges</h2>

<p>As a software-defined service, CI can degrade for many reasons, including downtime, bugs in the testsuite, hardware failure, power outages, cosmic rays, hurricanes, very angry mice(?), spammers, malevolent 4th dimensional beings, …. Seriously, GHC CI in particular depends on many components, whose reliability is impacted in many ways:</p>

<ul>
<li>GitLab, the product GHC uses to implement CI, experiences periods of network unreachability and disk outages, and has its own share of bugs.</li>
<li>Marge-bot, a service that mediates the contributor workflow, is known to crash and sometimes has undesirable behavior.</li>
<li>GitLab Runners, where CI workloads are executed, are their own complex systems: Their underlying servers can experience disk, memory, or network outages, and the workloads still occasionally receive mysterious signals that could be coming from several different layers of the hardware/software stack.</li>
<li>Finally, GHC itself has bugs (gasp!) that pop up in unexpected ways—and so do other programs that lurk in the GHC source code, like ghc-pkg or the internal tool ghc-config.</li>
</ul>

<p>CI is thus complex in implementation as well as purpose. And CI was not healthy when I started a year ago. In fact, the HF DevOps role was created to get GHC CI "in good shape."</p>

<h2>HF DevOps Role</h2>

<p>Although the failure symptoms were diverse and hard to predict, the root problem could be formulated in a simple way: CI is complex, and GHC simply needed more human resources to handle the workload. The Haskell Foundation addressed the latter problem by creating the DevOps role. But the complexity is inherent to the system, and to address it, my job was threefold: (1) Simply pitch in to spread the workload across more people. (2) Reduce the workload with automation. (3) Increase individual efficiency by increasing observability and building tools.</p>

<h3>Sidebar - Observability</h3>
<p>Observability is one of my favorite concepts from DevOps culture. A system is observable if it has many different ways it can be inspected. Google says "observability is based on exploring properties and patterns not defined in advance". One of the best methods for improving the health of a software-defined service is to improve observability.  Complex systems have emergent properties, and good observability gives operators emergent tools to actively debug them. Humans are very good at noticing patterns—we should capitalize on that!</p>

<h3>Back to the DevOps role</h3>
<p>As I mentioned before the sidebar, my job was to get GHC CI in good shape. The most impactful project I worked on was reducing spurious failures. I will focus on that project later, but first, I want to paint a full picture of my year by discussing other CI projects I worked on.</p>


<h3>A collection of CI projects</h3>
<ol>
<li>I replaced the server <code>gitlab-storage</code>, which satisfies all the storage needs of our GitLab service and hosts <a href="https://downloads.haskell.org/">downloads.haskell.org</a>. It plays a critical role in the CI infrastructure. The old hardware was being decommissioned, so I painstakingly developed and executed a migration plan to minimize downtime and avoid data loss.</li>
<li>I monitored systems, investigated their problems, fixed issues, and created tickets when appropriate. In the last year I opened 76 tickets, of which 43 have already been fixed.</li>
<li>I participated in GHC team discussions and issue triage.</li>
<li>Using the tools I built to reduce spurious failures, I identified hard-to-reproduce bugs like <a href="https://gitlab.haskell.org/ghc/ghc/-/issues/22872">ticket #22872</a>.</li>
<li>I built a dashboard that tracks GHC memory usage during nightly tests, making it easier to identify regressions.</li>
<li>I cleaned up hundreds of instances of link spam that found its way on to GitLab. (This only counts as a "CI project" because we run our pipelines on our own GitLab instance.)</li>
</ol>

<h2>Improving CI - Introducing spurious failures</h2>

<p>Those other projects helped keep the forest floor tidy, but the real impact came from addressing incorrect failure results. These usually came from jobs that spuriously failed due to confounding factors. This was seen as the biggest source of frustration with CI. It turned what should have been an automatic process into a manual one.</p>

<p>Tackling these spurious failures was difficult. There were no good tools for inspecting the problem. And as an outsider, I didn't know where to find example failures, and I didn't know how to measure the scope of the problem. I had one thing to go on: users’ subjective reports of how frustrating CI was due to these spurious failures.</p>

<p>Without insider knowledge, it would have been tortuous to differentiate spurious failures from legitimate ones. My biggest contribution was to implement a service to perform that differentiation automatically. With such a tool, spurious failures can be automatically retried without any user intervention.</p>

<h2>Improving CI - Addressing spurious failures</h2>

<p>The spurious failure retry service I created runs on the GitLab server. It inspects jobs as they finish and records new occurrences of spurious failures. Jobs that have failed spuriously are retried. By retrying jobs, contributors are spared the task of restarting jobs that fail for no good reason. This saves real clock time and, more importantly, saves contributors from wasting personal time on dead ends.</p>

<p>This automation was only possible because I created a method for quickly investigating errors across thousands of CI jobs. The method relies on a full-text search index that I populate manually. (Future work will be to update this data automatically and make it available to other users.) Searching across this index is an effective way to analyze occurrences of specific phrases that identify types of failures. It has been the driver for collecting the data necessary to make the retry service effective.</p>

<p>Furthermore, with the data collected by this service, I created a dashboard to monitor CI health:</p>

<img alt="Screenshot of spurious failure timeline chart" src="failure-chart.png">

<p>This dashboard, <a href="https://grafana.gitlab.haskell.org/d/167r9v6nk/ci-spurious-failures?orgId=2&refresh=15m&from=now-30d&to=now">which can be viewed live</a>, adds a bit of observability to CI. At a glance I can tell if something "odd" is happening—an intuition that can only develop with repeated observations.</p>

<h2>Improving CI - Measuring progress</h2>

<p>After addressing spurious failures, reports of frustration went down, so I knew I had made progress. But I was interested in finding more concrete measures. After all, how much frustration is too much? It's hard to identify the point of diminishing returns.</p>

<p>After recent work, I have discovered that the success rate of jobs in a specific pipeline may be a good proxy for overall health, and we can use it to measure past progress as well as set future goals. In the remainder of this log, I would like to explain what this measure represents and how I came to find it. To do so, however, I must first explain how GHC CI is designed.</p>

<ol>
<li>First, there is the <strong>Validate pipeline</strong>. This one runs tests against new patches submitted by contributors. It is designed to strike a balance between thoroughness and promptness of feedback. On average, it takes 1.2 hours to complete.</li>
<li>Next, there is the <strong>Nightly pipeline</strong>. This one runs tests against the master branch, i.e. the main codebase including all previously-accepted patches. It is designed to be maximally thorough. Promptness is less of a concern. It takes 5.4 hours on average.</li>
<li>Finally, there is the <strong>Release pipeline</strong>. This is a special-purpose pipeline used during the release process. Release pipelines are invoked manually.</li>
</ol>

<h3>Finding a good signal for CI health</h3>

<p>One of the simplest ideas for measuring CI health is to measure how often pipelines succeed. More success is better, right?</p>

<p>Unfortunately, there are many problems with this idea.</p>

<ul>
  <li>Validate pipelines are expected to fail precisely as often as people write faulty patches. (If that never happened, we’d hardly need CI in the first place!)</li>
  <li>Nightly pipelines include some experimental jobs that are known to fail. Unlike Validate pipelines, this one isn't designed for public consumption. Looking at the pipeline as a whole doesn't give a good signal.</li>
  <li>Release pipelines are even more special-purpose than Nightly pipelines, and don't get run often. They also don't give a good signal.</li>
</ul>

<p>Therefore, it looked like pipeline success rates couldn’t be used as a measure of CI health.</p>

<p>But wait! There’s a special case! There is a Validate pipeline that is run on the master branch immediately after the latest patches have been validated and merged. I call it the <strong>Post-Merge Validate pipeline</strong>. Technically, this pipeline is redundant, because it's testing exactly the same code that was validated <em>before</em> the merge. But since it's redundant, it is useful. It is a duplicate of another Validate pipeline that just succeeded. All other things being equal, it should also succeed 100% of the time.</p>

<h3>False starts</h3>

<p>But all other things are not equal! When I created a chart of pipeline results in April, there was no clear trend.</p>

<img alt="Diagram of pipeline success ratio" src="post-merge-validate-pipeline.png">

<p>Instead, there was a lot of noise, and the success ratio bounced between 40% and 80% both before and after I started working on the problem. It did not correlate with users' subjective reports of reduced frustration. This was a little surprising to me, and I would like to figure out what's happening. (Naively, I would expect the pipeline success rate to be the product of the success rates of the constituent jobs—which would visibly correlate.) But meanwhile, there were other things to try—which brings me to job success rate.</p>

<h3>Post-Merge Validate Jobs as a measure of CI health</h3>

<p>There are some reasons to believe that job success rate might correlate better with reduced frustration than entire pipelines. First, the work I did this year focused on recovering from failures in individual jobs. For the most part, I haven't looked at pipelines as a whole. Looking at job success directly might mean avoiding confounding factors. Second, jobs are simply a finer-grained measure. While this shouldn't necessarily improve the correlation with user-reported frustration, maybe it would avoid any potential confounders.</p>

<p>At any rate, I would be remiss not to look at the job success rate. So let’s look.</p>

<img alt="Diagram of success ratio per month, discussed below" src="post-merge-validate-jobs.png">

<p>In this diagram, I have charted the success ratio per month for jobs in the Post-Merge Validate pipeline. I have included a chart showing the overall number of jobs for some extra context.</p>

<p>In short, it looks good! There are clearly two regimes: before and after I started working on the problem. The rate was steady beforehand, and has been improving afterward. The success rate has gone up even with the total number of jobs going up in the same period. I welcome anyone with statistical expertise to give me better ways of slicing this, but at least visually it corresponds to reduced frustration and healthier CI. I will keep my eye on this chart.</p>

<p>As a bonus, the Post-Merge Validate pipeline is a new, automated source of spurious failure reports. That means I don't have to only rely on user reports of spurious failures. This, by itself, is a way to reduce the CI burden on contributors.</p>

<h2>Closing thoughts</h2>

<p>If we consider the whole Haskell forest, my work on GHC CI is a small thing: little mushrooms under a great tree. But I’ve done what I can. I have reduced the workload with automation, pitched in to spread the work that remained, and made myself and others more efficient with more tools and data. The highlight of my work is the system I built for automatically repairing spurious failures. I can only hope that it wasn't a complete coincidence that GHC maintainers think 9.6 was the smoothest release in recent history. Besides, mushrooms aren't just funny-looking protuberances in the dirt—they are vast subterranean mesh networks that symbiotically connect other forest life! Small changes have big effects. That's why I'm happy to keep my hands dirty and keep chipping away at the problems, particularly with the new perspective and data I’ve gained through reflecting on this year of work.</p>

<h2>Addendum: Live Charts</h2>

<p>Many of the charts in this log are now implemented as dashboards so I (or anybody else) can keep tabs on CI health. Click on them to see them live!</p>

<a href="https://grafana.gitlab.haskell.org/d/kv1oojs4z/ci-health?orgId=2&refresh=5s&kiosk"><h3>CI Health Overview</h3>

<img alt="Screenshot of CI Health Overview dashboard" src="ci-health-overview.png">
</a>

<a href="https://grafana.gitlab.haskell.org/d/phJc-UyVz/ci-success-stats?orgId=2"><h3>CI Success Stats</h3>

<img alt="Screenshot of CI Success Stats dashboard" src="ci-success-stats.png">
</a>

<a href="https://grafana.gitlab.haskell.org/d/167r9v6nk/ci-spurious-failures?orgId=2&refresh=15m"><h3>CI Spurious Failures</h3>

<img alt="Screenshot of CI Spurious Failures dashboard" src="spurious-failures-dashboard.png">
</a>

