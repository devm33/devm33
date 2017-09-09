---
title:  "Welcome to Jekyll!"
date:   2014-09-21 03:11:32
categories: jekyll
---

### Hello,

I know this looks like the default jekyll generated post and it might seem a 
bit unkempt to leave the title unchanged, but it was a very warm and welcoming
starter post so I'm sticking with it. Overall setting up jekyll was pretty
warm and welcoming. So far at least... the next post planned will be about
getting up on the server, so hopefully that one will be short and sweet as
well. I'm excited to have finally convinced myself to start putting some
content on this site. I look forward to making more internet.

### Setup

This wasn't bad at all. So far I have stayed very vanilla. No plugins and I
intend to keep it that way in case I decide to switch hosting over to
github pages at some point. I had relatively little content to migrate:

- A couple static pages which were quick to convert to liquid templates and
partials. In fact they refactored quite positively, dropping a lot of 
boilerplate.

- And some custom styling that plopped right into the starter sass project.
There's some work left to do in integrating that and customizing the default
rules, but with perhaps a little extra a bloat it all works quite nicely as is.

- I did end up moving the rest of my asset files over to AWS s3 without
fallbacks, just because I mostly done it already out of concern for latency
and because it seemed like a good thing to work into the templating while I
was configuring things.

Note on the configuring: I chose to place the s3 url as a site-wide variable,
by placing it in the `_config.yml` file. But I have noticed already that this
file seems like it may be prone to bloat. I'll be looking out for mitigation
strategies around that.

### Next Steps

Release the git hooks and ship it!
