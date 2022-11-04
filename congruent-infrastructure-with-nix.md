---
title: Congruent Infrastructure Management with Nix
author: Jesse Moore
patat:
  eval:
    nix:
      command: nix eval -f - 
      fragment: true
...

# About Me.

  Jesse Moore: Loving husband and cat dad

  - UAH Alumni:
    - Master's of Science in Software Engineering 
    - Bachelor's of Science in Computer Science

  - ADTRAN:
    - Software Development Engineer Sr. ~8-9 years.

  - Contact: 
    - work:     jesse.moore@adtran.com
    - personal: jesse@jessemoore.dev
    - website:  jessemoore.dev
    - github:   github.com/jesseDMoore1994

---

# Initial thanks!

  I was very excited to get this event going. I appreciate everyone who had a hand in making it happen!

  - Thanks to HuntFunc for providing a platform for this presentation!
  - Thanks to ADTRAN and the Tech Team for working to faciliate the event!

---

# HuntFunc Plug

  Before getting started... Are you interested in functional programming? Do you live in the hunsville area?
  If so, consider joining HuntFunc!

  I actually don't know the official handles, but I can point you to where I look.

  - Google group: https://groups.google.com/u/1/g/huntfunc
  - twitter: https://twitter.com/huntfunc
  - website: http://huntfunc.github.io/

  I've only recently started looking at the group, the google group seems most active.

---

# Let's Get Started!

  The presentation today is: *Towards Congruent Infrastructure Management with Nix*

  I'm gonna take a guess at some of the questions:
  - What the heck is *Congruent Infrastructure*?
  - Why the heck do I even want *Congruent Infrastructure*?
  - What the heck is *Nix*?
  - How the heck does *Nix* help make *Congruent Infrastructure*?
  - What the heck does this have to do with functional programming???

  Rest easy, all will be revealed in time! We'll break it down one at a time.

  **Full Disclosure**: I think *Nix*-like systems **should** be the future of package management.
  I don't think *Nix* itself is the future of software infrastructure management, but I 
  think *Nix*-like systems are future of software infrastructure. Let me explain.


---

# Software Infrastructure Management

  Some definitions:
  - Infrastructure: The basic underlying framework or features of a system or 
      organization.
  - Management: the act or manner of managing; handling, direction, or control.

  To this end, software infrastructure management attempts to tackle how to best
  control the underlying framework of software systems.

  I strongly recommend giving *Why Order Matters: Turing Equivalence in Automated
  Systems Administration* by Traugett and Brown a read, as it serves as the source
  for the information in the following slides. 

---

# Types of Software Infrastructure Management Methods 

  Traugett and Brown lay out 3 different types of management methodologies. These methodolgies
  serve to relate the difference between the actual state of the physical disk of the machine
  and the target state of the physical disk of the machine as time increases. The three types
  are as follows:

  - *Divergence*
  - *Convergence*
  - *Congruence*

---

# Divergent Software Infrastructure Management

    Horizontal Axis: Time      x-line: target
    Vertical Axis:   Disk      o-line: actual 

    |                      x x x x x
    |       x x x x x x x x
    |x x x x      o o o
    |o o o o o o o    o o o
    |                       o o o o
    |                               o o o o o 
    |
    ------------------------------------------

  As time progresses, the intended state of the infrastructure and the actual state of the
  infrastructure grow apart. 

  This is the classic "It works on my machine" approach to software infrastructure management.
  We pretty much all agree this is a nightmare.

---

# Convergent Software Infrastructure Management

    Horizontal Axis: Time      x-line: target
    Vertical Axis:   Disk      o-line: actual 

    | x x x x
    |        x x x x x x x x x
    |                          x x x x x x
    |
    |                            o o o o o 
    |                  o o o o o 
    |o o o o o o o o o
    ------------------------------------------

  Convergent infrastructure management is characterized by the configuration of the live host
  being mangaged moving towards (hence converging) on some hypothetical ideal baseline.

  This is your ansibles, your puppets, your chefs, and so on. They serve to make assured some
  or all vital components of the infrastructure are in place. This does not mean however that
  the host cannot change in other unforseen ways that break the deployment.

---

# Congruent Software Infrastructure Management

    Horizontal Axis: Time      x-line: target
    Vertical Axis:   Disk      o-line: actual 

    |                                        x 
    |                                    x x o
    |                            x x x x o o
    |                          x o o o o
    |            x x x x x x x o
    |x x x x x x o o o o o o o
    |o o o o o o
    ------------------------------------------

  Congruent infrastructure management is the process of maintaining all target hosts in
  lockstep with some fully descriptive baseline. In other words, the intended state of the
  system is defined formally with some description that is used to build the entirety of
  the actual state.

  Tools like Nix or GNU Guix are probably the most apt to fit with this label, where you
  can write your configuration into some file and state of your infrastructure is then
  derived from that file back to first principles in some standardized environment.

---

# Congruence is almost certainly the best option.

  Here are some selling points for congruent infrastructure management:

    - deployments can be rapid and predictable.
    - Software infrastructure can be rebuilt on demand in a bit-for-bit
        identical state.
    - Changes are not tested for the first time in production.
    - Unscheduled production downtime is reduced to that caused by 
        hardware and application problems; firefighting activities drop considerably.
    - There are no ad-hoc or manual changes.

  Convergence is certainly better than divergence. While convergence technologies like
  ansible may be better than the wild west, it cannot boast the same as above.

---

# My personal conviction.

  I spend a lot of time managing infrastructure for work while overseeing software
  that can be deployed on VMs, deployed on OEM devices, deployed on in house silicon.

  That software also has to be DEVELOPED by engineers at their desks and then BUILT
  on any number of automation systems for actual release, for every component of our
  final deliverable.

  Does anyone believe I do a good job at managing them all at once?

---

# My personal conviction.

  **NO. I DON'T. I TRY. MY TEAM TRIES. WE DO NOT SUCCEED.**

  I feel comfortable expressing that here, because I don't think anyone here would
  expect every possible deployment method of every component to be tested manually
  or in automation, it would take too many resources. If there were only one state
  that I had to manage though, that problem becomes much easier, and suddenly 
  testing all possible deployment scenarios becomes easy.

  This is the real beauty of congruent infrastructure. It drives the state of the
  machine, from and well defined input in a manner that can be maintained
  in source control.

---

# Enter Nix
```
+++++++++++++++++++++++++++++++++++++++++++++
.          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖         .       So what is Nix?
.          ▜███▙       ▜███▙  ▟███▛         .
.           ▜███▙       ▜███▙▟███▛          .
.            ▜███▙       ▜██████▛           .        - Nix is heavily overloaded, scream at me if it isn't
.     ▟█████████████████▙ ▜████▛     ▟▙     .            clear which one I'm talking about :) 
.    ▟███████████████████▙ ▜███▙    ▟██▙    .
.           ▄▄▄▄▖           ▜███▙  ▟███▛    .        - It could be any one of these things
.          ▟███▛             ▜██▛ ▟███▛     .           * Nix the package manager - A system for highly reproducible builds
.         ▟███▛               ▜▛ ▟███▛      .           * Nix expression language - A pure, lazy DSL for for defining packages for Nix
.▟███████████▛                  ▟██████████▙.           * Nix the Operating System (NixOS) - An operating system developed around Nix
.▜██████████▛                  ▟███████████▛.
.      ▟███▛ ▟▙               ▟███▛         .        - Nix runs on GNU/Linux or MacOS while NixOS IS based on GNU/Linux. Clear as mud?
.     ▟███▛ ▟██▙             ▟███▛          .
.    ▟███▛  ▜███▙           ▝▀▀▀▀           .           ... its nix's all the way down ...
.    ▜██▛    ▜███▙ ▜██████████████████▛     .
.     ▜▛     ▟████▙ ▜████████████████▛      .
.           ▟██████▙       ▜███▙            .
.          ▟███▛▜███▙       ▜███▙           .
.         ▟███▛  ▜███▙       ▜███▙          .
.         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘          .
+++++++++++++++++++++++++++++++++++++++++++++
```

---

# How does Nix work?

  Nix as a package manager uses the Nix expression language to define package "derivations", these derivations serve as
  a manifest for how to install the software package within the nix infrastructure. 

  Nix expressions are defined in .nix files, and derivations are defined in .drv files. You can kind of think of nix 
  files like c files, and drv files like o files.

  These derviations when they are build are stored in the `/nix/store` under under a cryptographic hash name. These can
  then be used as inputs for other packages.

  Because of this, each derivation is unique, reproducable, and cacheable.

---

# Nix Expression language Overview

  Nix expression language is defined by 3 paradigms.

  * Lazy - Expressions are only evaluates as needed.
  * Pure - Function output is determined only by function input. (no side effects)
  * Functional - Programs are constructed by composing and applying functions to data.
  * Dynamically Typed - Types are associated with values at runtime

  Having mostly developed my own functional background in Haskell this was a great bonus for me. I can live with the
  dynamic typing as a python developer by day.

---

# Nix Expression Language Constructs - Basics

  Let's dive into the language, we'll start off simple.

  All code you see is being fed to nix eval by piping to `nix eval -f -`

  ```nix
  {
    string = "hello";
    integer = 1;
    float = 3.141;
    bool = true;
    attribute-set = {
      null = null;
      list = [ 1 "two" false ];
    }; # comments are supported
  }
  ```

  ```nix
  {
    arithmetic-result = 1 + 2;
    boolean-result = true && false;
  }
  ```

---

# Nix Expression Language Constructs - Let Bindings and Attribute sets

  We can use `let ... in` bindings to create shorthands that can be used in the expression.

  ```nix
  let
    x = 1;
    y = 3;
  in {a = y + x; b = y - x;}
  ```

  This defines x and y for the scope and uses it to populate an attribute set. We
  can access members of an attribute set with the `.` operator.

  ```nix
  let
    x = 1;
    y = 3;
  in 
    #rec allows for recursive definitions in attribute sets!
    rec {
      a = y + x;
      b = 2*a - x;
    }.b
  ```

---

# Nix Expression Language Constructs - With, Inherit, Import

  `with` pushes attribute set variables into scope for the expression.

  ```nix
  let
    z = {x = 1; y = 3;};
  in with z; {a = y + x; b = y - x;}
  ```

  `inherit` is a shorthand to pull variables from the enclosing scope in.
 
  ```nix
  let
    z = {x = 1; y = 3;};
  in { inherit z;}
  ```

  `import` will load a nix expression from a file.
 
  ```nix
    # can import absolute and relative paths.
    import ./hello.nix
  ```

---

# Nix Expression Language Constructs - Functions

  All functions in Nix are anonymous functions of one argument. They can
  be bound to names with let expressions. They take the form `<arg>: <body>`.

  ```nix
  let
    f = x : x + 1;
  in f
  ```

  Since Nix is lazy, functions are only evaluated when invoked with an argument.

  ```nix
  let
    f = x : x + 1;
  in f 1
  ```

  Multiple arguments can be accepted via currying.

  ```nix
  let
    f = x : y : x + y;
  in rec {
    a = f;
    b = a 2;
    c = b 2;
  }
  ```

  You can use parenthesis to force invocation when needed.

  ```nix
  let
    f = x : x + 1;
  in {
    a = [f 1 f 2];
    b = [(f 1) (f 2)];
  }
  ```

---

# Nix Expression Language Constructs - Functions calling conventions

  There are many different ways to call functions. Many look complicated,
  but remember, `<arg>: <body>`.

  You can have an attribute set as an argument.

  ```nix
  let
    a = 1;
    b = 2;
    c = 3;
    f = {a, b}: a + b;
  in f { inherit a b; } # note: inherting c as well would cause a failure
  ```

  You can use an ellipsis in the argument to allow additional variables to
  be passed, or use ? to define defaults.

  ```nix
  let
    a = 1;
    c = 3;
    f = {a, b ? 2, ...}: a + b;
  in f { inherit a c; }
  ```

  You can name the entire set too if need with at syntax.

  ```nix
  let
    a = 1;
    b = 2;
    c = 3;
    f = {a, b, ...}@args: a + b + args.c;
  in f { inherit a b c; }
  ```

---

# Nix Expression Language in closing.

  Thats it! There is no way I could possibly explain all the intricacies, but I hope it's enough to
  get a feel for how cool Nix is. Obviously, you can construct very complicated expressions from
  these basic building blocks, but it should give you a basis to start understanding what you are 
  looking at.

  From these rudamentary building blocks, an entire package ecosystem has been created.

---

# NixOS.

  NixOS is a Nix flavored linux distribution. Some key features include:

  - reproducible and declarative system management.
  - atomic upgrades and rollback.
  - binary package caching.

  Simply put, using all of the aspects of Nix together and blending it into a GNU/Linux
  environment, you can define the configuration of an entire GNU/Linux system in one
  domain specific language for linux infrastructure management. This experience is NixOS.

---

# Back to the topic at hand.

  So hopefully it is clearer now, how Nix can help with our goal of attaining congruent architecture.

  When our DSL is purely functional, it becomes possible to relentlessly define everything as a collection
  of inputs that correspond to an output.

  Using this approach, we can declaratively define the entire state of our system in a way that is not only
  *actionable*, but **reproducible** as well. Not only can we take the configuration and use it to create
  the state of the system (hense, congruent), but anyone else who satisfies the inputs of the configuration
  can use it as well.

---

# Demo (if possible)

  I can demonstrate a live config change on my device if I didn't sandbag too hard.

---

# Questions?

  This slide deck is available on github.

  https://github.com/jesseDMoore1994/congruent-infrastructure-with-nix

---
