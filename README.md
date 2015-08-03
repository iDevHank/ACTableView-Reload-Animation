# UITableViewReloadAnimationDemo
UITableView reload animations based on Facebook Pop.

<h2><a id="user-content-installation" class="anchor" href="#installation" aria-hidden="true"><span class="octicon octicon-link"></span></a>Installation</h2>

<p><a href="https://github.com/facebook/pop">Pop</a> is required.</p>

<div class="highlight highlight-ruby"><pre>pod <span class="pl-s"><span class="pl-pds">'</span>pop<span class="pl-pds">'</span></span>, <span class="pl-s"><span class="pl-pds">'</span>~&gt; 1.0<span class="pl-pds">'</span></span></pre></div>

<p>Drag these files into your project. <div class="highlight highlight-ruby"><pre>UITableView+PopAnimation.h UITableView+PopAnimation.m</pre></p>

<h2><a id="user-content-installation" class="anchor" href="#installation" aria-hidden="true"><span class="octicon octicon-link"></span></a>Usage</h2>

<div class="highlight highlight-ruby"><pre>#import "UITableView+PopAnimation.h"</pre>

<h3><a id="usage" class="anchor" href="#usage" aria-hidden="true"><span class="octicon octicon-link"></span></a>Start Animation</h3>

<div class="highlight highlight-objective-c"><pre>[self.tableView reloadDataWithAnimationStyle: <span class="pl-c1">UITableViewReloadAnimationStyleFlow</span>];</pre>

<h3><a id="types" class="anchor" href="#types" aria-hidden="true"><span class="octicon octicon-link"></span></a>Types</h3>

<div class="highlight highlight-objective-c"><pre>UITableViewReloadAnimationStyleNone, /**< no animation */
UITableViewReloadAnimationStyleFlow,  /**< flow */
UITableViewReloadAnimationStyleStack,  /**< stack */
UITableViewReloadAnimationStyleLeftWave,  /**< from right side */
UITableViewReloadAnimationStyleRightWave,  /**< from left side */
UITableViewReloadAnimationStyleFall,  /**< fall */
UITableViewReloadAnimationStyleFade,  /**< fade in */
UITableViewReloadAnimationStyleBounce  /**< bounce */</pre>
