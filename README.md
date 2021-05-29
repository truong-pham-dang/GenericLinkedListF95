# GenericLinkedListF95
Singly linked list which is strictly conformant to Fortran 95 standard. In fact this repo is a refactoring of https://github.com/truongd8593/GenericLinkedList, where I mixed Fortran 2003 and Fortran 95 up.

Why is it called a generic linked list?

Because it is similar to template in C++ and some sorts of Generics in Java. For instance in Java we can define a list of String, a list of some derived types eg.

```
List<String> names;
  
List<Cells> finiteVolumeCells;
```
  
To achieve this in Fortran, one needs some work arounds. This is the reason why we have this generic linked list. The original paper discussing it is [1]. The example code that the author provided was not enough for Fortran programmers so that they can use it without adding some utilities. So yet another generic linked list by me, which is basically a clone of [1], but with more tools, and more examples of how to using them. 

The code has been tested in following IDEs:

- Compaq Visual Fortran v6.6
- Silverfrost FTN95 v8.7
- CodeBlocks 20.03 (MinGW gfortran 8.1.0)

References:

[1] Jason R Blevins: A generic linked list implementation in Fortran 95, April 2009 ACM SIGPLAN Fortran Forum 28(3).

[2] Tran Hanh Nhi, Duong Anh Duc - Introduction to data structures and algorithms (textbook in HCMUS's library, 2003).

HISTORY:

28/05/2021: A bug in subroutine list_remove_node has been fixed.
29/05/2021: Clearer interfaces has been established. We now have pointers to head and tail of the generic linked list which is similar to a usual singly linked list [2]. Management on head and tail of the linked list is pretty easy and we can implement sorting algorithms on this generic linked list.

TO-DO list:

- Add more utilities for generic linked list.
