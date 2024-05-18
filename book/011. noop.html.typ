#set page(
  paper: "a5",
  margin: (x: 1.8cm, y: 1.5cm),
)
#set text(
  font: "Liberation Serif",
  size: 10pt,
  hyphenate: false
)
#set par(justify: true)
#set quote(block: true)

#v(10pt)
= Why Arc Isn't Especially Object-Oriented
#v(10pt)

There is a kind of mania for object-oriented programming at the moment, but some of the smartest programmers I know are some of the least excited about it.

My own feeling is that object-oriented programming is a useful technique in some cases, but it isn't something that has to pervade every program you write. You should be able to define new types, but you shouldn't have to express every program as the definition of new types.

I think there are five reasons people like object-oriented programming, and three and a half of them are bad:

+ Object-oriented programming is exciting if you have a statically-typed language without lexical closures or macros. To some degree, it offers a way around these limitations. (See Greenspun's Tenth Rule.) #footnote[#quote(attribution: [Philip Greenspun])["Greenspun's Tenth Rule of Programming: any sufficiently complicated C or Fortran program contains an ad hoc informally-specified bug-ridden slow implementation of half of Common Lisp."]]

+ Object-oriented programming is popular in big companies, because it suits the way they write software. At big companies, software tends to be written by large (and frequently changing) teams of mediocre programmers. Object-oriented programming imposes a discipline on these programmers that prevents any one of them from doing too much damage. The price is that the resulting code is bloated with protocols and full of duplication. This is not too high a price for big companies, because their software is probably going to be bloated and full of duplication anyway.

+ Object-oriented programming generates a lot of what looks like work. Back in the days of fanfold, there was a type of programmer who would only put five or ten lines of code on a page, preceded by twenty lines of elaborately formatted comments. Object-oriented programming is like crack for these people: it lets you incorporate all this scaffolding right into your source code. Something that a Lisp hacker might handle by pushing a symbol onto a list becomes a whole file of classes and methods. So it is a good tool if you want to convince yourself, or someone else, that you are doing a lot of work.

+ If a language is itself an object-oriented program, it can be extended by users. Well, maybe. Or maybe you can do even better by offering the sub-concepts of object-oriented programming a la carte. Overloading, for example, is not intrinsically tied to classes. We'll see.

+ Object-oriented abstractions map neatly onto the domains of certain specific kinds of programs, like simulations and CAD systems.

I personally have never needed object-oriented abstractions. Common Lisp has an enormously powerful object system and I've never used it once. I've done a lot of things (e.g. making hash tables full of closures) that would have required object-oriented techniques to do in wimpier languages, but I have never had to use CLOS.

Maybe I'm just stupid, or have worked on some limited subset of applications. There is a danger in designing a language based on one's own experience of programming.  But it seems more dangerous to put stuff in that you've never needed because it's thought to be a good idea.

== Jonathan Rees Response

_ (Jonathan Rees had a really interesting response to Why Arc isn't Especially Object-Oriented, which he has allowed me to reproduce here.)_

Here is an a la carte menu of features or properties that are related to these terms; I have heard OO defined to be many different subsets of this list.

+ *Encapsulation* - the ability to syntactically hide the implementation of a type. E.g. in C or Pascal you always know whether something is a struct or an array, but in CLU and Java you can hide the difference.

+ *Protection* - the inability of the client of a type to detect its implementation. This guarantees that a behavior-preserving change to an implementation will not break its clients, and also makes sure that things like passwords don't leak out.

+ *Ad hoc polymorphism* - functions and data structures with parameters that can take on values of many different types.

+ *Parametric polymorphism* - functions and data structures that parameterize over arbitrary values (e.g. list of anything). ML and Lisp both have this. Java doesn't quite because of its non-Object types.

+ *Everything is an object* - all values are objects. True in Smalltalk (?) but not in Java (because of int and friends).

+ *All you can do is send a message (AYCDISAM) = Actors model* - there is no direct manipulation of objects, only communication with (or invocation of) them. The presence of fields in Java violates this.

+ *Specification inheritance = subtyping* - there are distinct types known to the language with the property that a value of one type is as good as a value of another for the purposes of type correctness. (E.g. Java interface inheritance.)

+ *Implementation inheritance/reuse* - having written one pile of code, a similar pile (e.g. a superset) can be generated in a controlled manner, i.e. the code doesn't have to be copied and edited. A limited and peculiar kind of abstraction. (E.g. Java class inheritance.)

+ *Sum-of-product-of-function pattern* - objects are (in effect) restricted to be functions that take as first argument a distinguished method key argument that is drawn from a finite set of simple names. 

So OO is not a well defined concept. Some people (eg. Abelson and Sussman?) say Lisp is OO, by which they mean {3,4,5,7} (with the proviso that all types are in the programmers' heads). Java is supposed to be OO because of {1,2,3,7,8,9}. E is supposed to be more OO than Java because it has {1,2,3,4,5,7,9} and almost has 6; 8 (subclassing) is seen as antagonistic to E's goals and not necessary for OO.

The conventional Simula 67-like pattern of class and instance will get you {1,3,7,9}, and I think many people take this as a definition of OO.

Because OO is a moving target, OO zealots will choose some subset of this menu by whim and then use it to try to convince you that you are a loser.

Perhaps part of the confusion - and you say this in a different way in your little memo - is that the C/C++ folks see OO as a liberation from a world that has nothing resembling a first-class functions, while Lisp folks see OO as a prison since it limits their use of functions/objects to the style of (9.). In that case, the only way OO can be defended is in the same manner as any other game or discipline -- by arguing that by giving something up (e.g. the freedom to throw eggs at your neighbor's house) you gain something that you want (assurance that your neighbor won't put you in jail).

This is related to Lisp being oriented to the solitary hacker and discipline-imposing languages being oriented to social packs, another point you mention. In a pack you want to restrict everyone else's freedom as much as possible to reduce their ability to interfere with and take advantage of you, and the only way to do that is by either becoming chief (dangerous and unlikely) or by submitting to the same rules that they do. If you submit to rules, you then want the rules to be liberal so that you have a chance of doing most of what you want to do, but not so liberal that others nail you.

In such a pack-programming world, the language is a constitution or set of by-laws, and the interpreter/compiler/QA dept. acts in part as a rule checker/enforcer/police force. Co-programmers want to know: If I work with your code, will this help me or hurt me? Correctness is undecidable (and generally unenforceable), so managers go with whatever rule set (static type system, language restrictions, "lint" program, etc.) shows up at the door when the project starts.

#rect[Here are the pet definitions of terms used above:

- *Value* = something that can be passed to some function (abstraction). (I exclude exotic compile-time things like parameters to macros and to parameterized types and modules.)

- *Object* = a value that has function-like behavior, i.e. you can invoke a method on it or call it or send it a message or something like that. Some people define object more strictly along the lines of 9. above, while others (e.g. CLTL) are more liberal. This is what makes "everything is an object" a vacuous statement in the absence of clear definitions. In some languages the "call" is curried and the key-to-method mapping can sometimes be done at compile time. This technicality can cloud discussions of OO in C++ and related languages.

- *Function* = something that can be combined with particular parameter(s) to produce some result. Might or might not be the same as object depending on the language.

- *Type* = a description of the space of values over which a function is meaningfully parameterized. I include both types known to the language and types that exist in the programmer's mind or in documentation.]
