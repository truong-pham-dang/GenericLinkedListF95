module mod_data
  use mod_generic_list, only: list_get, list_next, list_node_t, &
                              list_remove_node, singly_linked_list_t, &
                              list_put, list_data, list_swap
  implicit none

  private
  public :: data_int_t
  public :: data_int_ptr
  public :: data_int_ptr_constructor
  public :: data_int_ptr_print
  public :: data_int_ptr_remove_node
  public :: data_int_list_selection_sort

  ! Data is stored in data_int_t
  type :: data_int_t
     integer :: n
  end type data_int_t

  ! A container for storing data_t pointers
  type :: data_int_ptr
     type(data_int_t), pointer :: p => null()
  end type data_int_ptr

  interface data_int_ptr_constructor
      module procedure data_int_ptr_initialize
  end interface data_int_ptr_constructor

  interface data_int_ptr_print
    module procedure data_int_ptr_print_list
  end interface data_int_ptr_print

  interface data_int_list_selection_sort
      module procedure list_selection_sort
  end interface data_int_list_selection_sort

  contains

  ! Implement the constructor
  function data_int_ptr_initialize(val)
      implicit none
      type(data_int_ptr)  :: data_int_ptr_initialize
      integer, intent(in) :: val

      if (.not. associated(data_int_ptr_initialize%p)) then
          allocate(data_int_ptr_initialize%p)
          data_int_ptr_initialize%p%n = val
      endif
  end function

  ! Helper method print
  subroutine data_int_ptr_print_list(list)
    implicit none
    type(singly_linked_list_t) :: list
    type(list_node_t), pointer :: p
    type(data_int_ptr)         :: ptr

    print*, '['

    p => list%head
    do while (associated(p))
		ptr = transfer(list_get(p), ptr)
        print*, ptr%p%n, ','
        p => list_next(p)
    end do

    print*, ']'
  end subroutine

  ! Remove node has value k
  subroutine data_int_ptr_remove_node(list, k)
    implicit none
    type(singly_linked_list_t) :: list
    type(list_node_t), pointer :: p, q
    type(data_int_ptr)         :: ptr
	integer, intent(in)        :: k

    p => list%head
    nullify(q)

    do while (associated(p))
		ptr = transfer(list_get(p), ptr)
		if (ptr%p%n == k) exit
        q => p
        p => list_next(p)
    end do

    if (.not. associated(p)) then
      print*, 'Cannot find node has key ', k
      return
    endif

    if (associated(q)) call list_remove_node(p, q)
  end subroutine

  SUBROUTINE list_selection_sort(list)
      ! Selection sort algorithm on linked list by manipulating data field
      IMPLICIT NONE
      TYPE (singly_linked_list_t)    :: list
      TYPE (list_node_t), POINTER    :: p, q, min
      type(data_int_ptr)             :: ptr, min_ptr

      p => list%head

      DO WHILE (ASSOCIATED(p))
          q => list_next(p)
          min => p
          min_ptr = transfer(list_get(min), min_ptr)

          DO WHILE (ASSOCIATED(q))
              ptr = transfer(list_get(q), ptr)
              IF (ptr%p%n < min_ptr%p%n) THEN
                  min => q
                  min_ptr = transfer(list_get(min), min_ptr)
              ENDIF
              q => list_next(q)
          ENDDO

          CALL list_swap(min, p)
          p => list_next(p)
      ENDDO
  END SUBROUTINE

end module mod_data
