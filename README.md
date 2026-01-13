Implementation of a 15,11 reed Solomon decoder using 4 bit Galois Field arithmetic in Verilog.

## Structure:

Syndrome Calculator -> Euclidian Algorithm (Polynomial Division)
-> Error Locator (Using Chien search and Forney Method) -> 
Error Correction by adding error vector to delayed version of input codeword.

EXAMPLE:

input codeword at 45ns 1,2,3,4,5,11,7,8,9,10,3,1,12,12
includes mistakes, correct codeword should be:
1,2,3,4,5,6,7,8,9,10,11,3,3,12,12
(highlighted orange)
<img width="1411" height="326" alt="image" src="https://github.com/user-attachments/assets/de70d035-04fe-45d2-95e5-2648b9a489cc" />


Corrected Codeword is highlighted in yellow as:
1,2,3,4,5,6,7,8,9,10,11,3,3,12,12
<img width="1587" height="462" alt="image" src="https://github.com/user-attachments/assets/71edd5cf-b90b-4a4e-aba4-1cc23a7ccca0" />





## Author
Fraser Davies
