# GenericLinkedListF95
Singly linked list which is strictly conformant to Fortran 95 standard. In fact this repo is a refactoring of https://github.com/truongd8593/GenericLinkedList, where I mixed Fortran 2003 and Fortran 95 up.

The code has been tested in following IDEs:

- Compaq Visual Fortran v6.6
- Silverfrost FTN95 v8.7
- CodeBlocks 20.03 (MinGW gfortran 8.1.0)

Reference:

[1] Jason R Blevins: A generic linked list implementation in Fortran 95, April 2009 ACM SIGPLAN Fortran Forum 28(3)

TO-DO list:

- a bug in subroutine list_remove_node. To overcome this, I prepared a simplify version of this repo, which is a trivial linked list as usual in many textbooks https://github.com/truongd8593/SimpleLinkedListF95 . Still an open question in this repo, although removing a node in linked list is relatively easy in the simplify version.
