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

    type(list_node_t), pointer :: list => null()
	type(list_node_t), pointer :: list_tranverser => null()
	type(list_node_t), pointer :: elem => null()
    type(data_int_ptr)         :: ptr

    integer :: i, k



    do i = 1, 5
		ptr = data_int_ptr_constructor(i)

        if (.not.associated(list)) then
			call list_init(list,transfer(ptr,list_data))
        else
            call list_insert(list,transfer(ptr,list_data))
        endif
    enddo


    list_tranverser => list
	print*,'********************************************'
    print*,'Linked list:'
    call data_int_ptr_print(list_tranverser)

    ! Remove node which has data = 4 in the list
    list_tranverser => list
    call data_int_ptr_remove_node(list_tranverser, 4)

    ! Print the list again
    print*,'********************************************'
    print*,'Linked list after remove node has value = 4:'
    
	call data_int_ptr_print(list_tranverser)

    ! Free the list
    call list_free(list)

	end program GenericLinkedList

