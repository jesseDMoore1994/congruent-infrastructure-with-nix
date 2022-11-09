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

  Jesse Moore

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

  I was very excited to get this event going. I appreciate everyone who had a
  hand in making it happen!

  - Thanks to HuntFunc for providing a platform for this presentation!

  - Thanks to ADTRAN and the Tech Team for working to faciliate the event!

  - This presentation is my own opinion and not representative of my
      employer :)

---

# HuntFunc Plug

  Before getting started... Are you interested in functional programming?
  Do you live in the hunsville area? If so, consider joining HuntFunc!

  - Google group: https://groups.google.com/u/1/g/huntfunc

  - twitter: https://twitter.com/huntfunc

  - website: http://huntfunc.github.io/

---

# Let's Get Started!

  The presentation today is: *Congruent Infrastructure Management with Nix*

  - What is *Congruent Infrastructure*?

  - How does *Nix* help make *Congruent Infrastructure*?

  - What the heck does this have to do with functional programming???

---

# Software Infrastructure Management

  Some definitions:

  - Infrastructure: The basic underlying framework or features of a system or
      organization.

  - Management: the act or manner of managing; handling, direction, or control.

  *Why Order Matters: Turing Equivalence in Automated Systems Administration*
    by Traugett and Brow

---

# Types of Software Infrastructure Management Methods

  - Traugett and Brown lay out 3 different types of management methodologies
      - *Divergence*
      - *Convergence*
      - *Congruence*

  These relate actual state of the disk to the intended state of the disk as
  time goes on.

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

  As time progresses, the intended state of the infrastructure and the actual
  state of the infrastructure grow apart.

  "It works on my machine"

---

# Convergent Software Infrastructure Management

    Horizontal Axis: Time      x-line: target
    Vertical Axis:   Disk      o-line: actual

    | x x x x
    |        x x x x x x x x x
    |                          x x x x x x
    |
    |                            o o o o o
    |                  o o o o
    |o o o o o o o o o
    ------------------------------------------

  Convergent infrastructure management is characterized by the configuration
  of the live host being mangaged moving towards (hence converging) on some
  hypothetical ideal baseline.

  Ansible, Puppet, Chef, etc.

---

# Congruent Software Infrastructure Management

    Horizontal Axis: Time      x-line: target
    Vertical Axis:   Disk      o-line: actual

    |
    |                                    x x o
    |                            x x x x o o
    |                          x o o o o
    |            x x x x x x x o
    |x x x x x x o o o o o o o
    |o o o o o o
    ------------------------------------------

  Congruent infrastructure management is the process of maintaining all target
  hosts in lockstep with some fully descriptive baseline. In other words, the
  intended state of the system is defined formally with some description that
  is used to build the entirety of the actual state.

  Nix, GNU Guix, etc.

---

# Congruence is almost certainly the best option.

  Here are some selling points for congruent infrastructure management:

    - deployments can be rapid and predictable.

    - Software infrastructure can be rebuilt on demand in a bit-for-bit
        identical state.

    - Changes are not tested for the first time in production.

    - Unscheduled production downtime is reduced to that caused by hardware
        and application problems; firefighting activities drop considerably.

    - There are no ad-hoc or manual changes.

---

# My personal conviction.

  - A lot of my time goes into managing infrastructure
    - VMs
    - OEM devices
    - In-house hardware
    - dev environments
    - CI environments
    - etc.

  Does anyone believe they do a good job managing them all at once?

---

# My personal conviction.

  **NO. I DON'T. I TRY. MY TEAM TRIES. WE DO NOT SUCCEED.**

  - It's not expected either, its an overall unrealistic expectation to have to
    manage all that state from an ad-hoc fashion.

  - Congruent infrastructure management serves to greatly deminish these pains
    by being highly reliable and reproducible from source control.

---

# Enter Nix
```
+++++++++++++++++++++++++++++++++++++++++++++
.          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖         .       So what is Nix?
.          ▜███▙       ▜███▙  ▟███▛         .
.           ▜███▙       ▜███▙▟███▛          .
.            ▜███▙       ▜██████▛           .        - Nix is heavily overloaded, scream at me if it isn't
.     ▟█████████████████▙ ▜████▛     ▟▙     .            clear which one I'm talking about:
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

  - Nix defines packages in .nix files, when it then builds into derivations
    that describe the package. All inputs are other derivations.

  - .nix is to .div as .c is to .o

  - derviations are stored in the `/nix/store` in a uniquely identifiabl
    fashion.

  - hermetic design: each derivation is unique and reproducable.

---

# Nix Expression language Overview

  When I think of Nix Expression Language, I think of 4 primary things.

  - Lazy - Expressions are only evaluates as needed.

  - Pure - Function output is determined only by function input. (no side
    effects)

  - Functional - Programs are constructed by composing and applying functions
    to data.

  - Dynamically Typed - Types are associated with values at runtime

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

  We can use `let ... in` bindings to create shorthands that can be used in the
  expression.

  ```nix
  let
    x = 1;
    y = 3;
  in {a = y + x; b = y - x;}
  ```

  This defines x and y for the scope and uses it to populate an attribute set.
  We can access members of an attribute set with the `.` operator.

  ```nix
  let
    x = 1;
    y = 3;
  in
    # rec allows for recursive definitions in attribute sets!
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
    z = { x = 1; y = 3; };
  in with z; {a = y + x; b = y - x;}
  ```

  `inherit` is a shorthand to pull variables from the enclosing scope in.

  ```nix
  let
    z = { x = 1; y = 3; };
  in { inherit z; }
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

  Since Nix is lazy, functions are only evaluated when invoked with a
  argument.

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

  Thats it!

  From these rudamentary building blocks, an entire package ecosystem has
  been created.

---

# NixOS.

  NixOS is a Nix flavored linux distribution. Some key features include:

  - reproducible and declarative system management.

  - atomic upgrades and rollback.

  - binary package caching.

  Simply put, using all of the aspects of Nix together and blending it
  into a GNU/Linux environment, you can define the configuration of an entire
  GNU/Linux system in one domain specific language for linux infrastructure
  management. This experience is NixOS.

---

# Back to the topic at hand.

  So hopefully it is clearer now, how Nix can help with our goal of
  attaining congruent architecture.

  When our package DSL is purely functional, it enforces each package to be
  nothing more than a series of inputs that correspond to an output.

  Using this approach, we can declaratively define the entire state of our
  system in a way that is not only *actionable*, but **reproducible** as well.
  Not only can we take the configuration and use it to create the state of the
  system (hense, congruent), but anyone else who satisfies the inputs of the
  configuration can use it as well.

---

# Demo (if possible)

  I can demonstrate a live config change on my device if I didn't sandbag too hard.

  https://github.com/jesseDMoore1994/nix-config

---

# Questions?

  Let me know how you feel about this presentation, I'd love to do more presentations
  on the topic. Some questions might be a good presentation for the future!

  slides: https://github.com/jesseDMoore1994/congruent-infrastructure-with-nix

---
