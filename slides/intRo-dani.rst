================================
A (very) brief introduction to R
================================

----

Today
=====

**Things to talk about**

* What
* Why
* How

**Things to play with**

* Get started with R

    * Read your data
    * Manipulate them
    * Explore, analyze and plot

* A hint into R for spatial data

-----

What is R?
==========

*R is a language and environment for statistical computing and graphics*

    * **language & environment**
    * **statistical computing**
    * **graphics**

* It is a Free implementation of the ``S`` language created by **R**\oss Ihaka and **R**\obert Gentleman in 1993
* **Cross-platform**: runs on many \*nix (included Linux) systems, Windows and MacOS. 
* It is licensed under GPL, which makes it **free**...
    * ... as in **beer**
    * ... as in **speech**

-----

Why should I care about R?
==========================

* Philosophy behind the project

* Convenience (once you get ahead the learning curve)

Some people who care about R:

    * Many top universities use R in teaching and research
    * `Google and Facebook <http://www.dataspora.com/2009/02/predictive-analytics-using-r/>`_
    * `New York Times <http://www.nytimes.com/2009/01/07/technology/business-computing/07program.html?pagewanted=all>`_

-----

The R Philosophy
================

    *...Then sit back, relax, and enjoy being part of something big...* 
    [`Tom Preston-Werner <http://tom.preston-werner.com/2011/11/22/open-source-everything.html>`_]

Being Free Software ("the users have the freedom to run, copy, distribute, study, change and improve the software") has enhanced:

    * **Worldwide community** of dedicated and enthusiastic users, contributors and developers that:
        * Lowers the entry barriers (mailing lists, blog posts, online
          tutorials, workshops...)
        * Continuously expands the capability and functionality
    * Becoming an instrument for **democratization** of academic software and technology transfer
    * Becoming the **lingua franca** in academia 
    * Facilitating `reproductibility and Open Science <http://arstechnica.com/science/news/2012/02/science-code-should-be-open-source-according-to-editorial.ars>`_

-----

R as free beer
==============

* The price is right
    * Education
    * Installation across multiple machines
* The *beer selection* is wide (CRAN hosts 3,669 available packages as of March 10th. 2012)
    * Makes R a good one stop-shop and a good investment of your time to learn
      it
    * No market profitability constraints put it at the cutting edge (research
      sandbox)
* Linus' Law: *"given enough eyeballs, all bugs are shallow"*
    * More reliable and stable

-----

How do I get started?
=====================

**Look for R info and packages**

    * Project website: `http://r-project.org <http://r-project.org>`_
    * The Comprehensive R Archive Network (`CRAN <http://cran.r-project.org/>`_)
    * The `R-Journal <http://journal.r-project.org/>`_ (and `JoSS <http://www.jstatsoft.org/>`_)
    * `R bloggers <http://www.r-bloggers.com/>`_
    * Twitter: the ``#rstats`` hashtag
    * Google (good luck on that)

**Install and load packages**

    * Windows and MacOS GUIs have installers
    * Command line with ``instal.packages`` function
    * Command ``library`` (e.d. ``library(maptools)`` to load the package ``maptools``)

-----

Help and documentation
======================

* R built-in search capability

============================    ===========================================
        Command                             Function
============================    ===========================================
``?read.csv``                   Check local documentation for `read.csv`
                                function
``spdep::moran.test``           Check local documentation in package 
                                `spdep` for `moran.test`
``help("read.csv")``            Check local documentation for `read.csv`
                                function
``help.search("read.csv")``     Search for "read.csv" in all help files
``RSiteSearch("plot maps")``    Search for the term "plot maps" in the
                                RSiteSearch website (requires connectivity)
============================    ===========================================

* StackOverflow: `http://stackoverflow.com/questions/tagged/r <http://stackoverflow.com/questions/tagged/r>`_


