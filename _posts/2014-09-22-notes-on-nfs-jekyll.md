---
title: Jekyll on NearlyFreeSpeech
categories: jekyll nearlyfreespeech.net rubygems
---

This turned out to be a bit of an adventure...

### Gem install setup

By default ruby and rubygems are available, but the default gem install
location is not writable from a user account. In order to work around this
set up gem to install into your home directory:

~~~ bash
export GEM_HOME=/home/private/gems
export GEM_PATH=/home/private/gems:/usr/local/lib/ruby/gems/1.8/
export PATH=$PATH:/home/private/gems/bin
export RB_USER_INSTALL='true'
~~~

Which I conveniently found the jekyll docs themselves:
<http://jekyllrb.com/docs/troubleshooting/>

Then on that shell install jekyll

    gem install jekyll

In order to run the jekyll just installed it needs to be found in

    /home/private/gems/bin/jekyll

This may be useful to prepend to your PATH for convenience.

In any case the next issue I came across was not having a valid javascript
runtime.

~~~
/home/private/gems/gems/execjs-2.2.1/lib/execjs/runtimes.rb:51:in `autodetect': Could not find a JavaScript runtime.
See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)
...
~~~

After some cursory perusal it appeared installing node on NFS might be hard,
but since the gem environment was all set up it made sense to use a ruby
alternative. `execjs` was the rubygem complaining about not being able to find
a runtime and on its github page serveral alteratives are listed:
<https://github.com/sstephenson/execjs#execjs> I went with `therubyracer` since
it was recommended by the jekyll docs ([see that helpful troubleshooting page
again][jekyll-execjs])

After installing therubyracer my local gem install did work, but I noticed as
well the system provided jekyll executable (installed in the main gem
directory) was also working. But there was a catch both jekyll binaries were
broken again if I opened up a new session, most likely because the
environmental variables exported above were lost.

### Gem installing take 2

Persusing the literature a little further I came across this very helpful
post [installing custom gems on your hosted jekyll blog][limitless-channels]
which outlined how to install gems in a more sustainable fashion, but within a
users permissions. The key takeaway was to run

    gem install therubyracer --user-install

which installed the gem in the user's home directory but on the gem search path
which can be checked by running

    gem env

and looking for `gem_path` another neat tidbit from the article.

The next issue I ran across seemed similar:

~~~
/usr/local/lib/ruby/site_ruby/1.9/rubygems/dependency.rb:247:in `to_specs': Could not find kramdown (~> 1.0.2) amongst
~~~

Learning that `~> 1.0.2` meant between version 1.0.2 and 1.1 from
[this issue][jekyll-issue46] I simply applied a similar process to get the
right version of kramdown

    gem install kramdown --user-install -v 1.0.2

This went fine and I could tell I had progressed since I was now getting a new
error from `jekyll --version` complaining about a different gem. This was no
longer a path I wanted to go down.

### New Approach

Putting it down and walking away for a bit allowed me to think about the
problem I was facing with all these old versions of gems and of jekyll: why
don't I just get on the bleeding edge right? Then it occurred to me that
NearlyFreeSpeech very kindly provides a smooth system for swapping out the
version of FreeBSD you're running. It's quick and easy!

I upgraded twice from green (Stable/Default) to blue (Stable/Upcoming), and
then to white (Beta/Current) in which jekyll ran by default without any of
my messing tampering and it was great!


### Conclusion

I am deploying this with git on NearlyFreeSpeech.net. All my files are
available on github <https://github.com/devm33/devm33> including the git hooks
I use in a bare repo on the server (in the util folder). You can find a good
post on setting that up here:
<http://majorursa.net/content/using-jekyll-nearlyfreespeechnet>

Cheers!

[jekyll-execjs]: http://jekyllrb.com/docs/troubleshooting/#could-not-find-a-javascript-runtime-execjsruntimeunavailable
[limitless-channels]: http://www.limitlesschannels.com/code/2013/07/10/installing-custom-gems-on-your-hosted-jekyll-site.html
[jekyll-issue46]: https://github.com/jekyll/jekyll-help/issues/46
