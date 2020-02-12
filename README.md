# encoding-and-decoding
Encode a text from a file. and decode an encoded text with brute force algorithm

## Programming in Common Lisp: In this project, I implemented functions for encoding and decoding a sequence of words using a cipher alphabet.

### A cipher alphabet is a one to one mapping to a plain text alphabet. 
An example of such mapping is given below:

**Plain Alphabet** : a b c d e f g h i j k l m n o p q r s t u v w x y z

**Cipher Alphabet**: d e f p q a b k l c r s t g y z h i j m n o u v w x

Encoding and decoding is simply done by replacing the letter in the source alphabet with the
corresponding one in the target alphabet using the provided mapping.
For example:
-Original: testing this
-Encoded : mqjmlgb nklj


## Project Description
For this project, words are represented as lists of lower case symbols, e.g., the word “class" is
represented as '(c l a s s ). Paragraphs are lists of words, e.g.,'((c l a s s) (i s) (r e a d y) (f o r) (w o r k)).
A document is a list of paragraphs.
A document encoded with a cipher alphabet is not easy to break without the help of a computer.
we are asked to implement a brute force version that uses a spell checker to break the cipher.


## Brute Force with Spell Checker Gen_Decoder_A
The algorithm for the brute force code breaker is simple. The input words are encoded for each possible mapping. 
There are 29! (! means factorial) such mappings. *to simplify, I made it 8! (just 8 letters are mixed)*
For each mapping, a spell checker determines whether the resulting words are words in the English language. The mapping that generates the most correctly spelled words is assumed to be correct one.

For this method, I needed to implement a spell checker. the spell checker implemented by using the dictionary of words in file *dictionary.cl.* You will need to implemented the spell checker *spell_checker* that takes as input a word, and returns the truth value T or NIL. 
- spell_checker_0: A brute force version of the spell checker that just checks whether the word occurs in the dictionary or not.
- spell_checker_1: Implements a faster search strategy using hash mapping. 
