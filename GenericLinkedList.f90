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

	use generic_list
    use data 

    implicit none

    type(list_node_t), pointer :: list => null()
	type(list_node_t), pointer :: list_tranverser => null()
    type(data_int_ptr)         :: ptr
      
    integer :: i, k


      
    do i = 1, 5
		ptr = data_int_ptr_constructor(i);

        if (.not.associated(list)) then
			call list_init(list,transfer(ptr,list_data))
        else
            call list_insert(list,transfer(ptr,list_data))
        endif
    enddo    
      

    print*,'*****************************'
    print*,'Linked list:'
    do while (associated(list))
		ptr = transfer(list_get(list), ptr)
        k = ptr%p%n
        print*, k
        list => list_next(list)
    end do
    ! Free the list
    call list_free(list)

	end program GenericLinkedList

