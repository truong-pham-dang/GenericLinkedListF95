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
                                list_create_head_node, list_prepend
    use mod_data

    implicit none

    type(singly_linked_list_t) :: list
    type(data_int_ptr)         :: ptr

    integer :: i, k



    do i = 1, 5
		ptr = data_int_ptr_constructor(i)

        if (i == 1) then
			call list_create_head_node(list, transfer(ptr, list_data))
        else
            call list_prepend(list, transfer(ptr, list_data))
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

    ! Create another list
    ptr = data_int_ptr_constructor(10)
    call list_create_head_node(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(8)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(6)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(1)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(5)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(2)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(9)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(4)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(7)
    call list_prepend(list, transfer(ptr, list_data))

    ptr = data_int_ptr_constructor(3)
    call list_prepend(list, transfer(ptr, list_data))

    print*,'********************************************'
    print*,'Another linked list:'
    call data_int_ptr_print(list)

    call data_int_list_selection_sort(list)
    print*,'********************************************'
    print*,'After sorting:'
    call data_int_ptr_print(list)

end program GenericLinkedList

