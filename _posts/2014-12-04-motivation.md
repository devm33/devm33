---
title: "Motivation Chrome Extension"
categories: chrome-extension
---

The latest project I have been working on is a fork of a chrome extension. I saw
a friend running [this chrome extension][maccman-motivation] which replaces the
newtab page in chrome with a page that displays his age to nine
decimal places.

{% image maccman-motivation.gif %}

This extension caught my attention because I liked the idea of getting rid of
the thumbnails on the default new tab page. I found myself often getting
distracted by my most visited sites whenever I opened a new tab. Having my age
ticking by instead seemed like it would be much more motivational. It turns out
there is a whole genre of motivational new tab page chrome extensions.

{% image default-new-tab.png %}

Despite how much I liked maccman's implementation I wanted to tweak the
appearance a little.  Thanks to github, I soon had a fork of the motivation
extension and after some css tweaks I was very happy. Of course, once you give a
moose a muffin the moose decides to refactor the backbone to angular, add grunt,
and start adding features. I had an idea for bookmarks on the new tab page.
When you open a new tab you should be able to quickly access your frequent
bookmarks. I implemented this vim-style so that after focusing on the page
[^focus] pressing the number [^number] of the bookmark opens it. Going further
with inspiration from vim, hitting the spacebar and then the number of a
bookmark folder opens all of the folder's contents in tabs. Of course, basic
mouse clicking works as expected and middle clicking on a bookmark folder also
opens all of the folder's contents in tabs.

{% image devm33-motivation.png %}

At this point, the bookmarks feature is complete and separable from the rest of
the extension (thanks angular!) If I ever get tired of the age counter, I would
definitely reuse the bookmarks module for my next new tab chrome extension.

I also have more development plans for the bookmarks component. Currently, I'm
interested in duplicating all the functionality of the native bookmarks
[^native].  Right now I have completed navigating and deleting. On the backlog
is renaming/editing and rearranging.

The project is on github [devm33/motivation][devm33-motivation] and the
latest release of the extension is available on the [chrome
webstore][devm33-webstore].

[^focus]: Default focus for new tab page is the url bar. A single tab brings
    focus to the page or more specifically to the first link on the page.
    I've noticed some chrome extension widgets will insert themselves in the
    focus chain after the url bar though, so shift-tab is useful in that case to
    go backwards through the focus chain, i.e. the last link on the page.

[^number]: The key for a bookmark will be a number if the bookmark is in the
    first nine bookmarks. After that the characters are used in the order the
    are defined by character code, starting with ':' at 58, '9' is 57.

[^native]: Or, at least I will implement as much as is possible with the [chrome
    extension bookmarks api][bookmarks-api] which I currently believe is
    everything.

[maccman-motivation]: https://github.com/maccman/motivation
[devm33-motivation]: https://github.com/devm33/motivation
[devm33-webstore]: https://chrome.google.com/webstore/detail/edaphnidncfdooaldnhdmijjephlbehh/
[bookmarks-api]: https://developer.chrome.com/extensions/bookmarks
