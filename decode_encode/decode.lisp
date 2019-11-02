; *********************************************
; *  341 Programming Languages                *
; *  Fall 2019                                *
; *  Author: Yakup Genc                       *
; *											  *
; *  BEYZA AYDOĞMUŞ			                  *
; *********************************************


;read a document as a list of paragraphs, each paragraph is list of words and each word is list of char symbols.
(defun read-as-list (filename)
	(setf document '())
	(setf word '())
	(setf paragraph '())

	(with-open-file (input filename)
  		(loop for chr = (read-char input nil)  			
  			do
	  		(when (string= chr #\Space) 
		      	(push (nreverse word) paragraph)
	  			(setf word '())
	  		)
	  		(when (or (string= chr #\Newline) (string= chr nil) )
		      	(push (nreverse word) paragraph)
	  			(setf word '())
	  			(push (nreverse paragraph) document)
	  			(setf paragraph '())
	  		)
	  		while chr
	  			do  
	  			(if (and (string/= chr  #\Space) (string/= chr #\Newline))
	  				(push (convert-ch2sym chr) word)
	  			)	
        )
    )
    (setf new (nreverse(copy-list document)))
)

;read a dictionary as a list of words and each word is list of char symbols. 
(defun readdic (filename)
	(setf lst '())
	(setf word '())
	(with-open-file (input filename)
  		(loop for chr = (read-char input nil)  			
  			do
			(when (string= chr #\Newline) 
				(push (nreverse word) lst)
				(setf word '())
	    		)
	    	(when (or (string= chr #\Space) (string= chr nil))
	  		  		(push (nreverse word) lst)
		      	(setf word '())
	  		)
	  		while chr
	  			do  
	  			(if (and (string/= chr #\Space) (string/= chr #\Newline))
	  				(push (convert-ch2sym chr) word)		
	  			)
        )
    )
	(nreverse lst)
)

;; -----------------------------------------------------
;; HELPERS
;; *** PLACE YOUR HELPER FUNCTIONS BELOW ***

;convert char to symbol.
(defun convert-ch2sym (c)
	(case c  (#\a 'a) (#\b 'b) (#\c 'c) (#\d 'd) (#\e 'e) (#\f 'f) (#\g 'g) 
		     (#\h 'h) (#\i 'i) (#\j 'j) (#\k 'k) (#\l 'l) (#\m 'm) (#\n 'n) 
		     (#\o 'o) (#\p 'p) (#\q 'q) (#\r 'r) (#\s 's) (#\t 't) (#\u 'u) 
		     (#\v 'v) (#\w 'w) (#\x 'x) (#\y 'y) (#\z 'z)
	)
)

;both spell checker 0 and 1, check if the word is in the dictionary.
(defun spell-checker-0 (word)
	(loop for dic in (get-diclist) do
		(if (equal dic word)
			(return-from spell-checker-0 T)
		)
	)
	(return-from spell-checker-0 nil)
)
(defun spell-checker-1 (word)
	(if (equal (gethash (sxhash word) (get-hash-map)) word)
		(return-from spell-checker-1 T)
		(return-from spell-checker-1 nil)
	)
)
;its the helper func for spell checker 1
(defun get-hash-map ()
	(setf hash (make-hash-table))
		(loop for dict in (get-diclist) do
			(setf (gethash (sxhash dict) hash) dict)
	)
	hash
)

;; -----------------------------------------------------
;; DECODE FUNCTIONS

(defun Gen-Decoder-A (paragraph)
	
	(set-maintxt(decode-p paragraph (make-perm (get-permt-alph) paragraph)))
)


(defun Code-Breaker (document decoder)
  	
  	(loop for paragraph in document do
  		(funcall decoder paragraph )
  	)

(nreverse maintxt)
)

;; -----------------------------------------------------
;; ENCODE FUNCTIONS


;; its half coded chiper aalphabet not 26! but 8! 
;; mixed lettters: (a b c d e f g h)
(defun get-chiper-ch (ch)
	(case ch
		('a 'c)('b 'g)('c 'e)('d 'b)('e 'h)('f 'd)('g 'f)('h 'a)
		('i 'i)('j 'j)('k 'k)('l 'l)('m 'm)('n 'n)('o 'o)('p 'p)
		('q 'q)('r 'r)('s 's)('t 't)('u 'u)('v 'v)('w 'w)('x 'x)
		('y 'y)('z 'z)
	)
)
(defun encode-word (word)
	(when (not(null word))
		(append (list (get-chiper-ch (car word))) (encode-word (cdr word)))
	)
)
(defun encode-paragraph (paragraph)
	(when (not(null paragraph))
		(append (list (encode-word (car paragraph))) (encode-paragraph (cdr paragraph)))
	)
)
(defun encode-document (document)
	(when (not(null document))
		(append (list (encode-paragraph (car document)))     ; car(document) -> first paragraph
			    (encode-document (cdr document))			 ; cdr(document) -> rest of the paragraphs
		)
	)
)
;; ---------------------------------------------------------

(defun set-chiper-ch (ch lst)
	(loop for i from 0 to 26 do
		(when(eq ch (nth i alph))
		(return (nth i (get-normalph)))
		)
	)
)
(defun decode-w (word lst)
	(when (not(null word))
		(append (list (set-chiper-ch (car word) lst)) (decode-w (cdr word) lst))
	)
)
(defun decode-p (paragraph lst)
	(when (not(null paragraph))
		(append (list (decode-w (car paragraph) lst)) (decode-p (cdr paragraph) lst))
	)
)
(defun ischiper (chiperalph paragraph)
	(loop for word in (decode-p paragraph chiperalph)  do	
		(if (eq (spell-checker-0 word) T)
			()
		    (return-from ischiper nil)
		)
	)
	(return-from ischiper T)
)
(defun set-alph(foundalph)
	(setf i 0)
		(loop for ch in foundalph do
			(setf (nth i alph) ch)
			(incf i)
		)
	
)
(defun make-perm (lst paragraph) 
    (setf all (cons '0 (copy-list lst)))      
    (setf perm (make-array (length lst)))

    (labels (                                   ; local function binding (recurse is a local function)
	        (recurse (x i &aux (y (cdr x)) )	; y is a constant local variable that have the value of (cdr x), its not actually a parameter
	            (if (null (cdr y))
	            	(progn
	                    (setf (aref perm i) (car y)) 
	                    (set-alph (coerce perm 'list))
                     	(if (eq(ischiper alph paragraph) T)
				     		(return-from make-perm alph)
					 	)  
				    )
	                (progn
	                  	(loop while y do 
	                        (setf (aref perm i) (car y))
	                        (rplacd x (cdr y)) 
	                        (recurse all (1+ i))
	                        (rplacd x y)
	                        (pop x)
	                        (pop y)
	                    )
	                )
	            )
	        )
            )                
        (recurse all 0)
    )
)

(defun set-maintxt (decodedprg)
	(push decodedprg maintxt)
)
(defun get-normalph ()
  (setf normalph '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
)
;; -----------------------------------------------------
(defun get-permt-alph ()
	(setf permt-alph '(a b c d e f g h))
)
(defun set-perm-alph(item alphab)
	(remove item alphab)
)
(defun get-diclist ()
  (setf diclist (readdic "mydictionary.txt"))	
)
;; Test code...

(defun my-test ()
  	(setf plain-doc (read-as-list "mydocument.txt"))
  	(setf encoded-doc (encode-document plain-doc))
  	(setf maintxt '())
  	(setf alph '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
  	(format t "Plain text : ~a~%" plain-doc)
  	(format t "-------------------------------ENCODE--------------------------------~%")
 	(format t "Encoded doc: ~a~%" encoded-doc)
  	(format t "-------------------------------DECODE--------------------------------~%")
  	(format t "Found Plain Text:~a~%" (Code-Breaker encoded-doc #'Gen-Decoder-A) )
)
(my-test)
