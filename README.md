# encoding-and-decoding
Encode a text from a file. and decode an encoded text with brute force algorithm

## Programming in Common Lisp: In this project, I implemented functions for
encoding and decoding a sequence of words using a cipher alphabet.

### A cipher alphabet is a one to one mapping to a plain text alphabet. An example of such mapping is
given below:

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
