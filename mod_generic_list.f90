! generic_list.f90 -- A Generic Linked List Implementation in Fortran 95
!
! Copyright (C) 2009, 2012 Jason R. Blevins
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
!
! The above copyright notice and this permission notice shall be included in
! all copies or substantial portions of the Software.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
! THE SOFTWARE.

! Revision History:
!
! 1. July 21, 2012: In the list_free subroutine, line 11 should read
! nullify(current%data) instead of nullify(self%data).  Thanks to
! Michael Quinlan.

module mod_generic_list
  implicit none

  private
  public :: list_node_t, singly_linked_list_t, list_data
  public :: list_create_head_node, list_delete
  public :: list_insert_head
  public :: list_insert, list_put, list_get, list_next
  public :: list_remove_node

  ! A public variable used as a MOLD for transfer()
  integer, dimension(:), allocatable :: list_data

  ! Linked list node
  type :: list_node_t
     private
     integer, dimension(:), pointer :: data => null()
     type(list_node_t), pointer :: next => null()
  end type list_node_t

  ! Singly linked list derived type
  type :: singly_linked_list_t
      type(list_node_t), pointer :: head => null()
      type(list_node_t), pointer :: tail => null()
  end type singly_linked_list_t

  interface list_delete
      module procedure list_free_singly_linked_list
  end interface list_delete

contains

    ! Initialize a singly linked list by create a head node and optionally store the provided DATA.
    subroutine list_create_head_node(list, data)
        implicit none
        type(singly_linked_list_t) :: list
        integer, dimension(:), intent(in), optional :: data

        call list_init(list%head, data)
    end subroutine list_create_head_node

    subroutine list_insert_head(list, data)
        implicit none
        type(singly_linked_list_t) :: list
        type(list_node_t), pointer :: new_ele
        integer, dimension(:), intent(in), optional :: data

        call list_init(new_ele, data)

        if (.not. associated(list%head)) then
            list%head => new_ele
            list%tail => list%head
        else
            new_ele%next => list%head
            list%head => new_ele
        end if
    end subroutine list_insert_head

  ! Initialize a head node SELF and optionally store the provided DATA.
  subroutine list_init(self, data)
    type(list_node_t), pointer :: self
    integer, dimension(:), intent(in), optional :: data

    allocate(self)
    nullify(self%next)

    if (present(data)) then
       allocate(self%data(size(data)))
       self%data = data
    else
       nullify(self%data)
    end if
  end subroutine list_init

    ! Free the entire singly linked list
    subroutine list_free_singly_linked_list(list)
        implicit none
        type(singly_linked_list_t) :: list
        type(list_node_t), pointer :: p

        p => list%head
        call list_free(p)
    end subroutine list_free_singly_linked_list

  ! Free the entire list and all data, beginning at SELF
  subroutine list_free(self)
    type(list_node_t), pointer :: self
    type(list_node_t), pointer :: current
    type(list_node_t), pointer :: next

    current => self
    do while (associated(current))
       next => current%next
       if (associated(current%data)) then
          deallocate(current%data)
          nullify(current%data)
       end if
       deallocate(current)
       nullify(current)
       current => next
    end do

  end subroutine list_free

    ! Insert to singly linked list a list node after node q containing DATA (optional)
    subroutine list_insert_after(l, q, data)
        implicit none
        type(singly_linked_list_t) :: l
        type(list_node_t), pointer :: q, new_ele
        integer, dimension(:), intent(in), optional :: data

        if (.not. associated(q)) then
            call list_insert(q, data)

            if (associated(q, l%tail)) then
                l%tail => q%next
            end if
        end if
    end subroutine list_insert_after

  ! Insert a list node after SELF containing DATA (optional)
  subroutine list_insert(self, data)
    type(list_node_t), pointer :: self
    integer, dimension(:), intent(in), optional :: data
    type(list_node_t), pointer :: next

    allocate(next)

    if (present(data)) then
       allocate(next%data(size(data)))
       next%data = data
    else
       nullify(next%data)
    end if

    next%next => self%next
    self%next => next

  end subroutine list_insert

  ! Store the encoded DATA in list node SELF
  subroutine list_put(self, data)
    type(list_node_t), pointer :: self
    integer, dimension(:), intent(in) :: data

    if (associated(self%data)) then
       deallocate(self%data)
       nullify(self%data)
    end if
    self%data = data
  end subroutine list_put

  ! Return the DATA stored in the node SELF
  function list_get(self) result(data)
    type(list_node_t), pointer :: self
    integer, dimension(:), pointer :: data
    data => self%data
  end function list_get

  ! Return the next node after SELF
  function list_next(self)
    type(list_node_t), pointer :: self
    type(list_node_t), pointer :: list_next
    list_next => self%next
  end function list_next

  ! Remove current node has key k given its previous node
  subroutine list_remove_node( current, prev )

    type(list_node_t), pointer        :: current 
    type(list_node_t), pointer        :: prev 

	if (.not. associated(current)) print*, 'Cannot find node to remove !!!'

	if (associated(prev)) then
		prev%next => current%next

		if (associated(current%data)) then
			deallocate(current%data)
          nullify(current%data)
		endif
		deallocate(current)
		nullify(current)
	endif

  end subroutine list_remove_node

 end module mod_generic_list
