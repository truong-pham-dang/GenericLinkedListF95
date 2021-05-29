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

	use mod_generic_list, only: singly_linked_list_t, list_data, list_delete, &
                                list_create_head_node, list_insert_head
    use mod_data

    implicit none

    type(singly_linked_list_t) :: list
    type(data_int_ptr)         :: ptr

    integer :: i, k



    do i = 1, 5
		ptr = data_int_ptr_constructor(i)

        if (i == 1) then
			call list_create_head_node(list, transfer(ptr,list_data))
        else
            call list_insert_head(list, transfer(ptr,list_data))
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

