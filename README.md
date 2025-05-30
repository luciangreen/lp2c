# List-Prolog-to-C-Converter

Converts List Prolog code to C code.

List Prolog (LP) Interpreter (available <a href="https://github.com/luciangreen/listprologinterpreter">here</a>) is an interpreter for a different version of Prolog that is in list format, making it easier to generate List Prolog programs. The LP interpreter is an algorithm that parses and runs List Prolog code. The converter helps convert List Prolog programs to C programs.  The interpreter and converter are written in SWI-Prolog.


# Prerequisites

* Use a search engine to find the Homebrew (or other) Terminal install command for your platform and install it, and search for the Terminal command to install swipl using Homebrew and install it or download and install SWI-Prolog for your machine at <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a>.

# Mac, Linux and Windows (with Linux commands installed): Prepare to run swipl

* In Terminal settings (Mac), make Bash the default shell:

```
/bin/bash
```

* In Terminal, edit the text file `~/.bashrc` using the text editor Nano:

```
nano ~/.bashrc
```

* Add the following to the file `~/.bashrc`:

```
export PATH="$PATH:/opt/homebrew/bin/"
```

* Link to swipl in Terminal:

```
sudo ln -s /opt/homebrew/bin/swipl /usr/local/bin/swipl
```

# 1. Install manually

Download <a href="http://github.com/luciangreen/lp2c/">this repository</a>, the <a href="https://github.com/luciangreen/listprologinterpreter">List Prolog Interpreter Repository</a> and the <a href="https://github.com/luciangreen/Text-to-Breasonings">Text to Breasonings Repository</a>.

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
mkdir GitHub
cd GitHub/
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","lp2c").
../
halt.
```

# Running

* In Shell:
`cd lp2c`
`swipl`
`['../listprologinterpreter/listprolog'].`    

* Load the List Prolog to Prolog Converter by typing:
`['lp2cconverter'].`

* The converter is called in the form:
`test(Number,_,Algorithm1,_),lp2c1(Algorithm1,Algorithm2),write(Algorithm2).`

Where:
Number - Test number of algorithm to convert (taken from <a href="https://github.com/luciangreen/listprologinterpreter/blob/master/lpiverify4.pl">"lpiverify4.pl"</a>).
Algorithm1 - is the List Prolog algorithm to convert.
Algorithm2 - is the Prolog algorithm produced.

* For example:
```
test(2,_,A,_),lp2c1(A,B),write(B).

#include <stdio.h>
#include <stdlib.h>
int function(a,b,c){+(a,b,d);+(d,1,c);}

```

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the LICENSE.md file for details
