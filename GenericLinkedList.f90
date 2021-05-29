!  GenericLinkedList.f90
!
!  FUNCTIONS:
!	GenericLinkedList      - Entry point of console application.
!
!	Example of generic linked list in Fortran 95.
!

!****************************************************************************
!
!  PROGRAM: GenericLinkedList
!
!  PURPOSE:  generic linked list in Fortran 95.
!
!****************************************************************************

	program GenericLinkedList

	use mod_generic_list
    use mod_data

    implicit none

    type(singly_linked_list_t) :: list
	type(list_node_t), pointer :: list_tranverser => null()
	type(list_node_t), pointer :: elem => null()
    type(data_int_ptr)         :: ptr

    integer :: i, k



    do i = 1, 5
		ptr = data_int_ptr_constructor(i)

        if (i == 1) elem => list%head
        if (.not.associated(elem)) then
			call list_create_head_node(list, transfer(ptr,list_data))
            elem => list%tail
        else
            call list_insert_after(list, elem, transfer(ptr,list_data))
            elem => list%tail
        endif
    enddo

	print*,'********************************************'
    print*,'Linked list:'
    call data_int_ptr_print(list)

    ! Remove node which has data = 4 in the list
    call data_int_ptr_remove_node(list, 4)

    ! Print the list again
    print*,'********************************************'
    print*,'Linked list after remove node has value = 4:'
    
	call data_int_ptr_print(list)

    ! Free the list
    call list_delete(list)

	end program GenericLinkedList

